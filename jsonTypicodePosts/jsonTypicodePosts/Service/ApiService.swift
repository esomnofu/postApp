//
//  ApiService.swift
//  jsonTypicodePosts
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    func fetchAllPosts(completion: @escaping ([Post]) -> (), errorCompletion: @escaping (Any) -> () ){
        AF.request("https://jsonplaceholder.typicode.com/posts", method: .get).responseJSON  { response in
            if let data = response.data {
                let decoder = JSONDecoder()
                do {
                    let postsArray = try decoder.decode([Post].self, from: data)
                    self.storePostsToCoreData(postsArray)
                    completion(postsArray)
                } catch let jsonError {
                    errorCompletion(jsonError)
                }
            }else{
                errorCompletion(response)
            }
        }
    }
    
    func storePostsToCoreData(_ posts: [Post]){
        if getLocalEntityCount(entityName: postDataEntity_key) == 0 {
            for post in posts {
                self.storeItem(entityName: postDataEntity_key, entityData: post.dictionary)
            }
        }
    }
    
    func storeItem(entityName:String, entityData:[String:String]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        
        for (key, value) in entityData {
            object.setValue(value, forKey: key)
        }
        
        do
        {
            try managedContext.save()
        }
        catch
        {
            print("Error Saving Core Data")
        }
    }
    
    func getLocalEntityCount(entityName:String) -> Int {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return 0}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do{
            let allLocalPosts = try managedContext.fetch(fetchRequest)
            return allLocalPosts.count
        }
        catch{
            print("Cant get local data...")
            return 0
        }
    }
    
}
