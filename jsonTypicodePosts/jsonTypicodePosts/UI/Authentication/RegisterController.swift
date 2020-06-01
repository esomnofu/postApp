//
//  RegisterController.swift
//  jsonTypicodePosts
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RegisterController: LoginController {
    
    //MARK: Properties
    let fullNameTextField = UITextField()
    lazy var fullNameTextFieldView = produceTextField(placeholder: "Full Name", tf: fullNameTextField, isSecureEntry: false)
        
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
     }
    
    //MARK: Handlers
    func updateLabels(){
        pageNameLabel.attributedText = NSAttributedString.singleOpenSansBold(string: "Register", size: 18, color: UIColor.white)
        
        fullNameTextField.addTarget(self, action: #selector(validateAllInputFields), for: .editingChanged)
        
        logInButton.setAttributedTitle(NSAttributedString.singleOpenSansBold(string: "Register", size: BUTTON_FONT_SIZE, color: UIColor.white), for: .normal)
        
        dontHaveAccountButton.setAttributedTitle(NSAttributedString.doubleOpenSansRegular(string1: "Already have an account? ", string2: "Login", size1: 14, size2: 14, color1: UIColor.lightGray, color2: UIColor.appBgColor()), for: .normal)
    }
    
    override func setupFormFields(){
        
          let stackView = UIStackView(arrangedSubviews: [fullNameTextFieldView, emailTextFieldView, passwordTextFieldView, logInButton])
          stackView.axis = .vertical
          stackView.distribution = .fillEqually
          stackView.spacing = 20
              
          view.addSubview(stackView)
          stackView.anchor(top: topBlueView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 50, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, height: 200 + 60, width: 0)
    }
    
    @objc override func validateAllInputFields() {
        
        let emailAddress = emailTextField.getStringValue()
        let password = passwordTextField.getStringValue()
        let fullName = fullNameTextField.getStringValue()
        
        let formIsValid = emailAddress.isEmail && password.count > 5 && fullName.count > 1
        
        if formIsValid {
             logInButton.isEnabled = true
             logInButton.backgroundColor = UIColor.appBgColor()
         }else{
             logInButton.isEnabled = false
             logInButton.backgroundColor = UIColor.appInactiveBgColor()
         }
    }
    
    override func handleToggleOtherAuthScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc override func handleAuthenticateUser() {
    
        guard let email = emailTextField.text, email.isEmail else {
            presentAlert(title: "Please provide a valid email")
            return
        }
        
        guard let password = passwordTextField.text, password.count > 5 else {
            presentAlert(title: "Password should be a minimum of 6 characters")
            return
        }
        
        guard let fullname = fullNameTextField.text, fullname.count > 1 else {
            presentAlert(title: "Enter your full name correctly")
            return
        }
        
        START_PAGE_LOADING()
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                    if let err = error {
                        self.displayNetworkRequestError(msg: err.localizedDescription)
                        return
                    }
                    let uid = Auth.auth().currentUser?.uid
                    let dictionaryValues = ["fullName" : fullname]
                    let values = [uid: dictionaryValues]
                    Database.database().reference().child(FIREBASE_USER_NODE).updateChildValues(values, withCompletionBlock: { (error, ref) in
                        if let err = error {
                            self.displayNetworkRequestError(msg: err.localizedDescription)
                            return
                        }
                        self.END_PAGE_LOADING()
                        self.goHome()
                })

        }
        
    }


    
}
