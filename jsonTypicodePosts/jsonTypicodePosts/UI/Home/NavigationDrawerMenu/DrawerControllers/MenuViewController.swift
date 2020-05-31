//
//  MenuViewController.swift
//  Kadick
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit
import Firebase
private let menuOptionCellIdentifier = "menuOptionCellIdentifier"

class MenuViewController : UIViewController {
    
    //MARK: Properties
    let menuTextsArray = ["Home", "Posts","Logout"]
    let menuIconsArray : [UIImage] = [#imageLiteral(resourceName: "home"),#imageLiteral(resourceName: "posts"),#imageLiteral(resourceName: "logout")]
    let menuRightArrowBooleanArray = [true,true,true,true,true,true,false,false,false]

    var menuControllerDelegate : HomeControllerDelegate?
    
    lazy var tableView : UITableView = {
       let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = UIColor.appBgColor()
        tv.separatorStyle = .none
        tv.rowHeight = 60
        tv.register(MenuOptionCell.self, forCellReuseIdentifier: menuOptionCellIdentifier)
        return tv
    }()
    
    let profileImageView = produceImageView(image: #imageLiteral(resourceName: "esomnofu"))
    let usernameLabel = UILabel()
    let viewProfileButton = produceButton(label: "\(Auth.auth().currentUser?.email ?? "")", bgColor: UIColor.white, textColor: UIColor.appBgColor(), size: 14)
    
    let menuWidthDisplayView : UIView = {
       let uv = UIView()
        uv.backgroundColor = UIColor.appBgColor()
        return uv
    }()
    
    
    //MARK: Init
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = UIColor.appBgColor()
        setupUI()
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child(FIREBASE_USER_NODE).child(uid)
         
         ref.observeSingleEvent(of: .value, with: { (snapshot) in
             guard let userInfo = snapshot.value as? [String:String] else { return }
            guard let fullName = userInfo["fullName"] else {return}
            self.usernameLabel.attributedText = NSAttributedString.singleOpenSansBold(string: fullName, size: 16, color: UIColor.white)
         })
        
        
    }
    
    
    //MARK: Handlers
    func setupUI(){
        //add parent cover view for easy anchoring
        view.addSubview(menuWidthDisplayView)
        menuWidthDisplayView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0, width: (view.frame.width/2)+50)
        
        menuWidthDisplayView.addSubview(profileImageView)
        profileImageView.anchor(top: menuWidthDisplayView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 80, width: 80)
        profileImageView.centerXAnchor.constraint(equalTo: menuWidthDisplayView.centerXAnchor).isActive = true
        profileImageView.layer.cornerRadius = 80/2

        menuWidthDisplayView.addSubview(usernameLabel)
        usernameLabel.anchor(top: profileImageView.bottomAnchor, left: menuWidthDisplayView.leftAnchor, bottom: nil, right: menuWidthDisplayView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, height: 0, width: 0)
        usernameLabel.numberOfLines = 0
        usernameLabel.textAlignment = .center

        menuWidthDisplayView.addSubview(viewProfileButton)
        viewProfileButton.anchor(top: usernameLabel.bottomAnchor, left: menuWidthDisplayView.leftAnchor, bottom: nil, right: menuWidthDisplayView.rightAnchor, paddingTop: 10, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, height: 30, width: 0)

        menuWidthDisplayView.addSubview(tableView)
        tableView.anchor(top: viewProfileButton.bottomAnchor, left: menuWidthDisplayView.leftAnchor, bottom: menuWidthDisplayView.bottomAnchor, right: menuWidthDisplayView.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
    }
    
}


extension MenuViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuTextsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuOptionCellIdentifier, for: indexPath) as! MenuOptionCell
        let currentIndex = indexPath.row
        let cellProperties = CellRow(name: menuTextsArray[currentIndex], iconImage: menuIconsArray[currentIndex], hasRightIcon: menuRightArrowBooleanArray[currentIndex])
        cell.cellProperties = cellProperties
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMenuOption = MenuOption(rawValue: indexPath.row)
        menuControllerDelegate?.handleMenuBarToggle(forMenuOption: selectedMenuOption)
    }
    
    
}
