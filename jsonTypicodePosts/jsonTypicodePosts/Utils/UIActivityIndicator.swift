//
//  UIActivityIndicator.swift
//  jsonTypicodePosts
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit


let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView();

let indicatorCoverView : UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.appBgColor()
    view.layer.cornerRadius = 5
    view.clipsToBounds = true
    view.isOpaque = false
    return view
}()

extension UIActivityIndicatorView {
    
    static func startLoading() -> UIView {
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.color = UIColor.white
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.startAnimating();
        indicatorCoverView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        indicatorCoverView.addSubview(activityIndicator)
        activityIndicator.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 50, width: 50)
        activityIndicator.centerXAnchor.constraint(equalTo: indicatorCoverView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: indicatorCoverView.centerYAnchor).isActive = true
        //UIApplication.shared.beginIgnoringInteractionEvents();
        return indicatorCoverView
    }
    
   static func stopLoading(){
        activityIndicator.stopAnimating();
        indicatorCoverView.removeFromSuperview()
        //UIApplication.shared.endIgnoringInteractionEvents();
    }
}


