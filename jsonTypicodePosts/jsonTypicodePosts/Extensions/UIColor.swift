//
//  UIColor.swift
//  jsonTypicodePosts
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit

extension UIColor {
    //rgb divider formatter
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    //app bg color
    static func appBgColor() -> UIColor {
        return rgb(red: 17, green: 154, blue: 237)
    }
    
    static func appInactiveBgColor() -> UIColor {
        return rgb(red: 149, green: 204, blue: 244)
    }
    
    static func faintWhiteBgColor() -> UIColor {
          return rgb(red: 245, green: 245, blue: 245)
    }
}
