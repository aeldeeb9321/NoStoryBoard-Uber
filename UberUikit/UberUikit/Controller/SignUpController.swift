//
//  SignUpController.swift
//  UberUikit
//
//  Created by Ali Eldeeb on 9/27/22.
//

import UIKit

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
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        //this is to make the button Title Color change depending on whether the textfields are filled
        button.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        button.backgroundColor = .mainBlueTint
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
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
        stack.distribution = .fillEqually
        stack.spacing = 24

        view.addSubview(stack)
        view.addSubview(titleLabel)
        
        //MARK: - Constraints
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
    
    }
    
    //MARK: - Selectors
}
