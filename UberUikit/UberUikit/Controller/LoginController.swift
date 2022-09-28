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
    
    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        constraints()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent //light status bar on top for dark backgrounds
    }
    
    private func constraints(){
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        //.axis property determines the orientation of the arranged views.
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        
        view.addSubview(stack)
        view.addSubview(titleLabel)
        
        //MARK: - Constraints
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
    }


}
