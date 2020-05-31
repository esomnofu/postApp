//
//  MenuOptionCell.swift
//  Kadick
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit

class MenuOptionCell: UITableViewCell {

    //MARK: Properties
    let iconImageView : UIImageView = {
       let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFit
        imageV.clipsToBounds = true
       return imageV
    }()
    
    let controllerLabel = UILabel()
    
    let rightIconImageView : UIImageView = {
       let imageV = UIImageView()
        imageV.image = UIImage(named: "icon_next")
        imageV.contentMode = .scaleAspectFit
        imageV.clipsToBounds = true
       return imageV
    }()
    
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.appBgColor()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Handlers
    func setupUI(){
        addSubview(iconImageView)
        iconImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, height: 25, width: 25)
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
      
        addSubview(controllerLabel)
        controllerLabel.anchor(top: nil, left: iconImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
        controllerLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        
        addSubview(rightIconImageView)
        rightIconImageView.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, height: 10, width: 15)
        rightIconImageView.centerYAnchor.constraint(equalTo: controllerLabel.centerYAnchor).isActive = true
    }
    
    var cellProperties : CellRow?{
        didSet{
            guard let thisCellProperty = cellProperties else {return}
            iconImageView.image = thisCellProperty.iconImage
            controllerLabel.attributedText = NSAttributedString.singleOpenSansBold(string: thisCellProperty.name, size: 14, color: UIColor.white)
            if thisCellProperty.hasRightIcon {
                rightIconImageView.isHidden = false
            }else{
                rightIconImageView.isHidden = true
            }
        }
    }

}
