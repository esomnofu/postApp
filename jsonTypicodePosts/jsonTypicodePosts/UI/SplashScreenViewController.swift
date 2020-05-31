//
//  ViewController.swift
//  jsonTypicodePosts
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    //MARK: Properties
    let logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "app_logo")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        decideAppFlow()
    }
    
    //MARK: Handlers
    private func setupUI(){
        view.backgroundColor = UIColor.appBgColor()
        self.navigationController?.isNavigationBarHidden = true
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 100, width: 100)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func decideAppFlow() {
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            print("Moving to Vc based on user Auth status...")
        }
    }

}

