//
//  LoginController.swift
//  UberUikit
//
//  Created by Ali Eldeeb on 9/25/22.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginController: UIViewController {
    
    //MARK: - Properties
    
    private let titleLabel: UILabel = { //in this closure we create the label, give its attributes, then return it.
        let label = UILabel().uiLabel(withText: "UBER", font: UIFont(name: "Avenir-Light", size: 36), textColor: UIColor(white: 1, alpha: 0.8))
        return label
    }()
    
    
    
    //Container view that will contain the UiImage and divider, usernameTextField (which will be added seperately)
    private lazy var emailContainerView: UIView = { //lazy var gets configured on an as needed basis, so its configured when its called upon
        let view = UIView().inputContainerView(imageName: "ic_mail_outline_white_2x", textfield: emailTextField)
        //added a height constraint for our stack
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
        
    }()
    //this email text field will be added to our email ContainerView, we made our emailTextField outside the container view bc eventually we are going to need to grab the text from it later.
    private lazy var emailTextField: UITextField = {
        var tf = UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
        tf.tag = 1
        tf.delegate = self
        return tf
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(imageName: "ic_lock_outline_white_2x", textfield: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf =  UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
        tf.tag = 2
        tf.delegate = self
        return tf
    }()
    
    private lazy var loginButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleUserLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var dontHaveAccoutButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ",attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupConstraints()
        navigationController?.navigationBar.barStyle = .black //gives a white tint to time and battery on top
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent //light status bar on top for dark backgrounds
    }
    
    private func setupConstraints(){
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        //.axis property determines the orientation of the arranged views.
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 24
        
        view.addSubview(titleLabel)
        view.addSubview(stack)
        view.addSubview(dontHaveAccoutButton)
        
        //MARK: - Constraints
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        dontHaveAccoutButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
        dontHaveAccoutButton.centerX(inView: view)
    }

    @objc func handleUserLogin(sender: UIButton){
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let _ = self else { return }
                guard error == nil else{return}
                
            }
        }
        guard let controller = UIApplication.shared.keyWindow?.rootViewController as? HomeController else{return }
        controller.configureUI()
        dismiss(animated: true)
    }
    
    @objc func handleShowSignUp(sender: UIButton){
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension LoginController: UITextFieldDelegate{
    //anytime the user types something, can be used when the user changes something in the textfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText =  textField.text{
            if let swiftRange = Range(range, in: currentText){
                let textFieldText = currentText.replacingCharacters(in: swiftRange, with: string)
                var otherTextFieldText: String
                if textField.tag == 1{
                    otherTextFieldText = passwordTextField.text ?? ""
                }else{
                    otherTextFieldText = emailTextField.text ?? ""
                }
                if !textFieldText.isEmpty && !otherTextFieldText.isEmpty{
                    loginButton.isEnabled = true
                    loginButton.setTitleColor(UIColor(white: 1, alpha: 1), for: .normal)
                }else{
                    loginButton.isEnabled = false
                    loginButton.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
                }
            }
        }
        return true
    }
}
