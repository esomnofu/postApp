//
//  ContainerViewController.swift
//  Kadick
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit
import Firebase

class ContainerViewController : UIViewController {
    
    //MARK: Properties
    var menuController : MenuViewController!
    var centerController : UINavigationController!
    var isExpanded = false
    var currentCase : MenuOption = .Home
    
    
    //MARK: Init
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .appBgColor()
        configureHomeViewController()
    }

    //MARK: Handlers
    func configureHomeViewController() {
        let homeController = HomeViewController()
        homeController.homeDelegate = self
        homeController.containerController = self
        centerController = UINavigationController(rootViewController: homeController)
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func configureMenuViewController(){
        if menuController == nil {
            //add menu controller here
            menuController = MenuViewController()
            menuController.menuControllerDelegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    
    func showMenuController(shouldExpand:Bool, menuoption: MenuOption?) {
        if shouldExpand {
              UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    let width = self.centerController.view.frame.width
                    self.centerController.view.frame.origin.x = (width/2)+50
                  }, completion: nil)
          }else{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }) { (_) in
                guard let selectedMenuOption = menuoption else {return}
                self.moveToSelectedNavigation(selectedOption: selectedMenuOption)
            }
          }
    }
        
    func moveToSelectedNavigation(selectedOption:MenuOption) {
        switch selectedOption {
            case .Home:
                if currentCase != .Home {
                    let dashBoardController = ContainerViewController()
                    dashBoardController.presentViewController(caller: self)
                    currentCase = .Home
                }
            case .Post:
                   let postController = PostController(collectionViewLayout: UICollectionViewFlowLayout())
                   postController.pushNavController(caller: centerController)
                   currentCase = .Post
          case .Logout:
                do{
                    //Logout user from Firebase
                    try Auth.auth().signOut()
                    let loginController = LoginController()
                    loginController.pushNavController(caller: centerController)
                    currentCase = .Logout
                } catch _ {
                    presentAlert(title: "Log out failed, please retry")
                }
        }
    }
    
}


extension ContainerViewController : HomeControllerDelegate {
    func handleMenuBarToggle(forMenuOption menuOption: MenuOption?) {
        //if side menu bar is hidden
        if isExpanded == false {
            //this call adds menu only once
            configureMenuViewController()
        }
        
        //set bool to true so we can show side menu bar
        isExpanded = !isExpanded
        //call to show side menu bar
        showMenuController(shouldExpand: isExpanded, menuoption: menuOption)
    }
}
