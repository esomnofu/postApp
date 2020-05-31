//
//  LoginController.swift
//  jsonTypicodePosts
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    
    //MARK: Properties
    var pageNameLabel = produceSingleBoldUiLabel(labelString: "Login", size: 18, color: UIColor.white)
    
    lazy var topBlueView : UIView = {
        
        let topView = UIView()
        topView.backgroundColor = UIColor.appBgColor()
        
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "app_logo"))
        logoImageView.contentMode = .scaleAspectFit
        
        topView.addSubview(logoImageView)
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 100, width: 100)
        
        logoImageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        
        topView.addSubview(pageNameLabel)
        pageNameLabel.anchor(top: nil, left: nil, bottom: topView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, height: 0, width: 0)
        pageNameLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        
        return topView
    }()
    
    let dontHaveAccountButton = produceButtonWithDoubleLabels(label1: "Don't have an account? ", textColor1: UIColor.lightGray, label2: "Register.", textColor2: UIColor.appBgColor())
    
    let emailTextField = UITextField()
    lazy var emailTextFieldView = produceTextField(placeholder: "Email Address", tf: emailTextField, isSecureEntry: false)
    
    let passwordTextField = UITextField()
    lazy var passwordTextFieldView = produceTextField(placeholder: "Password", tf: passwordTextField, isSecureEntry: true)
    
    let logInButton = produceButton(label: "Log in", bgColor: UIColor.appInactiveBgColor(), textColor: UIColor.white, isEnabled:false)
    
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavLook()
        setupHandlers()
        setupUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //MARK: Handlers
    fileprivate func setupNavLook(){
        navigationController?.isNavigationBarHidden = true
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = .white
    }
    
    fileprivate func setupHandlers(){
        emailTextField.autocapitalizationType = .none
        
        dontHaveAccountButton.addTarget(self, action: #selector(handleToggleOtherAuthScreen), for: .touchUpInside)
        
        emailTextField.addTarget(self, action: #selector(validateAllInputFields), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(validateAllInputFields), for: .editingChanged)
        
        logInButton.addTarget(self, action: #selector(handleAuthenticateUser), for: .touchUpInside)
    }
    
    fileprivate func setupUI(){
        
        view.addSubview(topBlueView)
        topBlueView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 200, width: 0)
            
        setupFormFields()
        
        //add register button
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 100, width: 0)
        
    }
    
    func setupFormFields(){
        //add form fields
          let stackView = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView, logInButton])
          stackView.axis = .vertical
          stackView.distribution = .fillEqually
          stackView.spacing = 20
              
          view.addSubview(stackView)
          stackView.anchor(top: topBlueView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 50, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, height: 150 + 40, width: 0)
    }
    
    @objc func validateAllInputFields() {
        
        let emailAddress = emailTextField.getStringValue()
        let password = passwordTextField.getStringValue()
        
        let formIsValid = emailAddress.isEmail && password.count > 5
        
        if formIsValid {
            logInButton.isEnabled = true
            logInButton.backgroundColor = UIColor.appBgColor()
        }else{
            logInButton.isEnabled = false
            logInButton.backgroundColor = UIColor.appInactiveBgColor()
        }
        
    }
    
    @objc func handleToggleOtherAuthScreen(){
        let registerController = RegisterController()
        navigationController?.pushViewController(registerController, animated: true)
    }
    
    @objc func handleAuthenticateUser(){
            //Login
            guard let email = emailTextField.text, email.isEmail else {
                presentAlert(title: "Please provide a valid email")
                return
            }
            
            guard let password = passwordTextField.text, password.count > 5 else {
                presentAlert(title: "Password should be a minimum of 6 characters")
                return
            }
            
            START_PAGE_LOADING()
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let err = error{
                    self.displayNetworkRequestError(msg: err.localizedDescription)
                    return
                }
                self.END_PAGE_LOADING()
                //go home
                self.goHome()
            }
        
    }
    
    func goHome(){
        let dashBoardController = ContainerViewController()
        dashBoardController.presentViewController(caller: self)
    }
    
    
    
}

