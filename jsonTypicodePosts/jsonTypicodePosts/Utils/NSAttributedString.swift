//
//  NSAttributedString.swift
//  jsonTypicodePosts
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit

protocol NSAttributedStringExtension {
    static func singleOpenSansRegular(string:String, size:CGFloat, color:UIColor) -> NSAttributedString
}

extension NSAttributedString : NSAttributedStringExtension {

    class func singleOpenSansRegular(string:String, size:CGFloat, color:UIColor) -> NSAttributedString {
        let attrs = [NSAttributedString.Key.font : UIFont(name: OpenSansRegular, size: size)!, NSAttributedString.Key.foregroundColor : color]
        return NSAttributedString(string: string, attributes: attrs)
    }
    
    class func singleOpenSansBold(string:String, size:CGFloat, color:UIColor) -> NSAttributedString {
        let attrs = [NSAttributedString.Key.font : UIFont(name: OpenSansBold, size: size)!, NSAttributedString.Key.foregroundColor : color]
        return NSAttributedString(string: string, attributes: attrs)
    }
}

protocol NSAttributedStringExtensionTwo {
    static func doubleOpenSansRegular(string1:String, string2:String, size1:CGFloat, size2:CGFloat, color1:UIColor, color2:UIColor) -> NSAttributedString
    
    static func doubleOpenSansRegularAndBold(string1:String, string2:String, size1:CGFloat, size2:CGFloat, color1:UIColor, color2:UIColor) -> NSAttributedString
    
    static func tripleOpenSansRegular(string1: String, string2: String,  string3: String, size1: CGFloat, size2: CGFloat, size3:CGFloat, color1: UIColor, color2: UIColor, color3: UIColor)  -> NSAttributedString
}
extension NSAttributedString : NSAttributedStringExtensionTwo {
    
    class func doubleOpenSansRegular(string1: String, string2: String, size1: CGFloat, size2: CGFloat, color1: UIColor, color2: UIColor) -> NSAttributedString {
        
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: OpenSansRegular, size: size1)!, NSAttributedString.Key.foregroundColor : color1]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: OpenSansRegular, size: size2)!, NSAttributedString.Key.foregroundColor : color2]
        
        let attributedString1 = NSAttributedString(string:string1, attributes:attrs1)
        let attributedString2 = NSAttributedString(string:string2, attributes:attrs2)
        
        let tmpStr : NSMutableAttributedString = attributedString1.mutableCopy() as! NSMutableAttributedString
        tmpStr.append(attributedString2)
        let finalStr : NSAttributedString = tmpStr.copy() as! NSAttributedString
        
        return finalStr
    }
    
    class func doubleOpenSansRegularAndBold(string1: String, string2: String, size1: CGFloat, size2: CGFloat, color1: UIColor, color2: UIColor) -> NSAttributedString {
        
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: OpenSansRegular, size: size1)!, NSAttributedString.Key.foregroundColor : color1]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: OpenSansBold, size: size2)!, NSAttributedString.Key.foregroundColor : color2]
        
        let attributedString1 = NSAttributedString(string:string1, attributes:attrs1)
        let attributedString2 = NSAttributedString(string:string2, attributes:attrs2)
        
        let tmpStr : NSMutableAttributedString = attributedString1.mutableCopy() as! NSMutableAttributedString
        tmpStr.append(attributedString2)
        let finalStr : NSAttributedString = tmpStr.copy() as! NSAttributedString
        
        return finalStr
    }
    
    class func tripleOpenSansRegular(string1: String, string2: String,  string3: String, size1: CGFloat, size2: CGFloat, size3:CGFloat, color1: UIColor, color2: UIColor, color3: UIColor) -> NSAttributedString {

        let attrs1 = [NSAttributedString.Key.font : UIFont(name: OpenSansRegular, size: size1)!, NSAttributedString.Key.foregroundColor : color1]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: OpenSansRegular, size: size2)!, NSAttributedString.Key.foregroundColor : color2]
        let attrs3 = [NSAttributedString.Key.font : UIFont(name: OpenSansRegular, size: size3)!, NSAttributedString.Key.foregroundColor : color3]

        let attributedString1 = NSAttributedString(string:string1, attributes:attrs1)
        let attributedString2 = NSAttributedString(string:string2, attributes:attrs2)
        let attributedString3 = NSAttributedString(string:string3, attributes:attrs3)

        let tmpStr : NSMutableAttributedString = attributedString1.mutableCopy() as! NSMutableAttributedString
        tmpStr.append(attributedString2)
        tmpStr.append(attributedString3)
        let finalStr : NSAttributedString = tmpStr.copy() as! NSAttributedString

        return finalStr
    }

}
