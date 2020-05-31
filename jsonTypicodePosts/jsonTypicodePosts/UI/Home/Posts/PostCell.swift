//
//  PostCell.swift
//  jsonTypicodePosts
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit

protocol PostCellDelegate {
    func sharePost(sender: PostCell)
}

class PostCell: UICollectionViewCell {
    
    //MARK: Properties
    var delegate : PostCellDelegate?
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    lazy var shareButton = produceButtonWithNoBg(label: "Share", textColor: UIColor.systemRed)
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Handlers
    func setupUI(){
        shareButton.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        backgroundColor = UIColor.faintWhiteBgColor()
        titleLabel.numberOfLines = 0
        messageLabel.numberOfLines = 0
        
        addSubview(shareButton)
        shareButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, height: 0, width: 0)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 30, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, height: 0, width: 0)
        
        addSubview(messageLabel)
        messageLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: titleLabel.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
    }
    
    @objc func handleShare(){
        delegate?.sharePost(sender: self)
    }
    
    var post : Post?{
        didSet{
            guard let post = post else {return}
            titleLabel.attributedText = NSAttributedString.singleOpenSansBold(string: post.title, size: 14, color: UIColor.appBgColor())
            messageLabel.attributedText = NSAttributedString.singleOpenSansRegular(string: post.body, size: 12, color: UIColor.black)
            messageLabel.setLineHeight(lineHeight: 1.2)
        }
    }
    
}
