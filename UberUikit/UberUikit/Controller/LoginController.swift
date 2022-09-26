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
    private lazy var emailContainerView: UIView = { //lazy var gets configured on an as needed basis
        let view = UIView()
        view.backgroundColor = .red
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_mail_outline_white_2x")
        imageView.alpha = 0.87
        view.addSubview(imageView)
        imageView.centerY(inView: view) //horizontally centering it in the view
        imageView.anchor(left: view.leftAnchor, paddingLeft: 8, width: 24, height: 24)
        view.addSubview(emailTextField)
        emailTextField.anchor(left: imageView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        return view
    }()
    //this email text field will be added to our email ContainerView, we made our emailTextField outside the container view bc eventually we are going to need to grab the text from it later.
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        tf.keyboardAppearance = .dark //dark keybord to stick with the dark theme
        //attributed placeholder with a custom color
        tf.attributedPlaceholder = NSAttributedString(string: "Email",attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        return tf
    }()
    
    private let divider: UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .white
        return divider
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRect.zero)
        textField.placeholder = "Password..."
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = true
        return textField
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
        view.addSubview(titleLabel)
        view.addSubview(emailContainerView)
        emailContainerView.addSubview(emailTextField)
        emailContainerView.addSubview(divider)
        
        //MARK: - Constraints
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        emailContainerView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16, height: 50)
    }


}
