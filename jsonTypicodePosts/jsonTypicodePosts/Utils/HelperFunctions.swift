//
//  HelperFunctions.swift
//  jsonTypicodePosts
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit


//MARK: UIButton
func produceButton(label:String, bgColor:UIColor, textColor:UIColor, size:CGFloat=BUTTON_FONT_SIZE, isEnabled:Bool=true) -> UIButton {
    let button = UIButton(type: .system)
    button.setAttributedTitle(NSAttributedString.singleOpenSansBold(string: label, size: size, color: textColor), for: .normal)
    button.backgroundColor = bgColor
    button.layer.cornerRadius = 8
    button.isEnabled = isEnabled
    return button
}

func produceButtonWithNoBg(label:String, textColor:UIColor, size:CGFloat=14) -> UIButton {
    let button = UIButton(type: .system)
    button.setAttributedTitle(NSAttributedString.singleOpenSansRegular(string: label, size: size, color: textColor), for: .normal)
    button.backgroundColor = nil
    button.layer.cornerRadius = 8
    return button
}


func produceButtonWithDoubleLabels(label1:String, textColor1:UIColor, label2:String, textColor2:UIColor) -> UIButton {
    let button = UIButton(type: .system)
    button.setAttributedTitle(NSAttributedString.doubleOpenSansRegular(string1: label1, string2: " \(label2)", size1: 14, size2: 14, color1: textColor1, color2: textColor2), for: .normal)
    button.backgroundColor = nil
    button.layer.cornerRadius = 8
    return button
}

//MARK: UITextfield
func produceTextField(placeholder:String, tf: UITextField, fontSize:CGFloat=14, isSecureEntry:Bool) -> UITextField {
    tf.layer.cornerRadius = 8
    tf.layer.borderWidth = 0.5
    tf.layer.borderColor = UIColor.lightGray.cgColor
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.textColor = UIColor.black
    tf.isSecureTextEntry = isSecureEntry
    tf.font = UIFont.systemFont(ofSize: fontSize)
    tf.setLeftPaddingPoints(15)
    tf.attributedPlaceholder = NSAttributedString.singleOpenSansRegular(string: placeholder, size: fontSize, color: UIColor.lightGray)
    return tf
}

//MARK: UIlabel
func produceSingleUiLabel(labelString:String, size:CGFloat, color:UIColor) -> UILabel {
    let label = UILabel()
    label.attributedText = NSAttributedString.singleOpenSansRegular(string:labelString, size:size, color:color)
    label.numberOfLines = 0
    return label
}

func produceSingleBoldUiLabel(labelString:String, size:CGFloat, color:UIColor) -> UILabel {
    let label = UILabel()
    label.attributedText = NSAttributedString.singleOpenSansBold(string:labelString, size:size, color:color)
    label.numberOfLines = 0
    return label
}


//MARK: UIImageView
func produceImageView(image:UIImage) -> UIImageView {
    let img = UIImageView()
    img.contentMode = .scaleAspectFill
    img.image = image
    img.clipsToBounds = true
    return img
}
