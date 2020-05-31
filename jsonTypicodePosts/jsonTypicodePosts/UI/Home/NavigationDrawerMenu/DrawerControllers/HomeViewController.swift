//
//  HomeViewController.swift
//  Kadick
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit

private let homeCellIdentifier = "homeCellIdentifier"

class HomeViewController : UIViewController {
    
    //MARK: Properties
    let welcomeLabel = produceSingleBoldUiLabel(labelString: "Welcome to Post App", size: 18, color: UIColor.appBgColor())
    
    //MARK: Side Menu
    var homeDelegate : HomeControllerDelegate?
    var containerController : ContainerViewController?
    
    
    //Toggle
    let toggleButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "toggleBar").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleMenuToggle), for: .touchUpInside)
        return btn
    }()
    
    //MARK: Init
    override func viewDidLoad(){
        super.viewDidLoad()
        configureHomeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        if containerController != nil {
            containerController?.currentCase = .Home
        }
    }
    
    //MARK: Handlers
    @objc func handleMenuToggle(){
        homeDelegate?.handleMenuBarToggle(forMenuOption: nil)
    }
    
    func configureHomeView(){
        view.backgroundColor = UIColor.white
        
        view.addSubview(toggleButton)
        toggleButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, height: 50, width: 50)
        
        view.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
    }

    
}
