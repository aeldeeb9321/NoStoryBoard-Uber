//
//  SignUpController.swift
//  UberUikit
//
//  Created by Ali Eldeeb on 9/27/22.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpController: UIViewController{
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
    
    //Container view that will contain the UiImage and divider, usernameTextField (which will be added seperately)
    private lazy var fullNameContainerView: UIView = { //lazy var gets configured on an as needed basis, so its configured when its called upon
        let view = UIView().inputContainerView(imageName: "ic_person_outline_white_2x", textfield: fullNameTextField)
        //added a height constraint for our stack
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
        
    }()
    //this email text field will be added to our email ContainerView, we made our emailTextField outside the container view bc eventually we are going to need to grab the text from it later.
    private let fullNameTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Full Name", isSecureTextEntry: false)
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(imageName: "ic_lock_outline_white_2x", textfield: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
    }()
    
    private lazy var accountTypeContainerView: UIView = {
        let view = UIView().inputContainerView(imageName: "ic_account_box_white_2x", segmentedControl: accTypeSC)
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return view
    }()
      
    private let accTypeSC: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Rider", "Driver"])
        sc.backgroundColor = .backgroundColor
        sc.tintColor = UIColor(white: 1, alpha: 0.87) //when you have a dark mode an alpha of 0.87 is reccommended
        sc.selectedSegmentIndex = 0 //makes the first segment selected right away
        return sc
    }()
    
    private lazy var signUpButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleUserSignUp), for: .touchUpInside)
        return button
    }()
    
    private lazy var alreadyHaveAccoutButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ",attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        updateUI()
    }
    
    //MARK: - Helper Functions
    private func updateUI(){
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, fullNameContainerView, passwordContainerView, accountTypeContainerView, signUpButton])
        //.axis property determines the orientation of the arranged views.
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 24

        view.addSubview(stack)
        view.addSubview(titleLabel)
        view.addSubview(alreadyHaveAccoutButton)
        //MARK: - Constraints
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        alreadyHaveAccoutButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
        alreadyHaveAccoutButton.centerX(inView: view)
        
    }
    
    //MARK: - Selectors
    
    @objc func handleUserSignUp(sender: UIButton){
        guard let email = emailTextField.text, let password = passwordTextField.text, let fullname = fullNameTextField.text else{return}
        let accountTypeIndex = accTypeSC.selectedSegmentIndex
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard error == nil else{ return}
            
            //grabbing user id which will help us identify the user
            guard let uid = authResult?.user.uid else{return}
            //creating a dictionary of data that we will upload to firebase real time database
            let values = ["email": email, "fullname": fullname, "accountType": accountTypeIndex]
            
            //Creating the users node, then add the dictionary of data about our user to the database
//            Database.database().reference().child("users").child(uid).updateChildValues(values) { error, ref in
//                print("Successfully registered user and saved data...")
//            }
        }
    }
    
    @objc func handleShowLogin(sender: UIButton){
        
        navigationController?.popViewController(animated: true)
    }
}
