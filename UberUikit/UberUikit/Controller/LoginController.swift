//
//  LoginController.swift
//  UberUikit
//
//  Created by Ali Eldeeb on 9/25/22.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Properties
    
    private let titleLabel: UILabel = { //in this closure we create the label, give its attributes, then return it.
        let label = UILabel()
        label.text = "UBER"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
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
    private let emailTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(imageName: "ic_lock_outline_white_2x", textfield: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        //this is to make the button Title Color change depending on whether the textfields are filled
        button.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        button.backgroundColor = .mainBlueTint
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    private let dontHaveAccoutButton: UIButton = {
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
        constraints()
        navigationController?.navigationBar.barStyle = .black //gives a white tint to time and battery on top
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent //light status bar on top for dark backgrounds
    }
    
    private func constraints(){
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

    @objc func handleShowSignUp(sender: UIButton){
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
