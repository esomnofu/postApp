//
//  Post.swift
//  jsonTypicodePosts
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import Foundation

struct Post : Codable {
    let title : String
    let body : String
    var dictionary : [String:String] {
        return [
            "title" : title,
            "body" : body
        ]
    }
}
