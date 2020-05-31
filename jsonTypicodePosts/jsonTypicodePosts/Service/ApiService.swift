//
//  ApiService.swift
//  jsonTypicodePosts
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit
import Alamofire

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    func fetchAllPosts(completion: @escaping ([Post]) -> (), errorCompletion: @escaping (Any) -> () ){
        AF.request("https://jsonplaceholder.typicode.com/posts", method: .get).responseJSON  { response in
            if let data = response.data {
                let decoder = JSONDecoder()
                do {
                    let postsArray = try decoder.decode([Post].self, from: data)
                    completion(postsArray)
                } catch let jsonError {
                    errorCompletion(jsonError)
                }
            }else{
                errorCompletion(response)
            }
        }
    }
}
