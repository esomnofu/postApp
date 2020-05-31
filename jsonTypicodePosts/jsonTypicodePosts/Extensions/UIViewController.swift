//
//  UIViewController.swift
//  jsonTypicodePosts
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit


//MARK: UINavigation
extension UIViewController {
    func presentViewController(caller:UIViewController){
        self.modalPresentationStyle = .fullScreen
        caller.present(self, animated: true, completion: nil)
    }
    
    func pushNavController(caller:UINavigationController){
        caller.modalPresentationStyle = .fullScreen
        caller.pushViewController(self, animated: true)
    }
}


//MARK: Used to dismiss keyboard when any part of the screen is touched
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: present Alert
extension UIViewController {
    func presentAlert(title : String) {
        let alert = UIAlertController.alert(title: "", message: title)
        self.present(alert, animated: true)
    }
}

//MARK Loaders
extension UIViewController {
    func START_PAGE_LOADING(){
        let resultingView = UIActivityIndicatorView.startLoading()
        resultingView.center = self.view.center;
        self.view.addSubview(resultingView)
    }
    
    func END_PAGE_LOADING() {
        UIActivityIndicatorView.stopLoading()
    }
    
    func displayNetworkRequestError(msg:String=SOMETHING_WENT_WRONG){
        self.END_PAGE_LOADING()
        self.presentAlert(title: msg)
    }
}
