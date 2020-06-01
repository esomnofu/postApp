//
//  PostController.swift
//  jsonTypicodePosts
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit
import CoreData
import Toast_Swift

private let postCellIdentifier = "any_value"

class PostController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: Properties
    var allPosts = [Post]()
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
        setupUI()
    }
    
    //MARK: Handlers
    func getPosts(){
        START_PAGE_LOADING()
        ApiService.sharedInstance.fetchAllPosts(completion: { (allPosts) in
            self.END_PAGE_LOADING()
            self.allPosts = allPosts
            self.collectionView.reloadData()
        }) { (err) in
            self.END_PAGE_LOADING()
            self.view.makeToast("Poor Network Connection, Will Fetch Posts from local storage if available.", duration: 3.0, position: .bottom)
            DispatchQueue.main.asyncAfter(deadline: .now()+4) {
                self.getLocalPosts()
            }
        }
    }
    
    func getLocalPosts(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: postDataEntity_key)
        do{
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                guard let title = data.value(forKey: "title") as? String else {return}
                guard let body = data.value(forKey: "body") as? String else {return}
                let post = Post(title: title, body: body)
                allPosts.insert(post, at: 0) // new elements top
            }
            self.collectionView.reloadData()
            if allPosts.count == 0 {
                self.view.hideToast()
                self.view.makeToast("Oops!, no local posts stored on this device.", duration: 6.0, position: .center)
            }
        }
        catch{
            print("Cant get local data...")
        }
    }
    
    func setupUI(){
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: postCellIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        collectionView.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func getEstimatedHeight(text:String, width:CGFloat, fontSize: CGFloat) -> CGRect {
        let size = CGSize(width: width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [kCTFontAttributeName as NSAttributedString.Key : UIFont(name: OpenSansRegular, size: fontSize)! ], context: nil)
    }
    
    //MARK: Collectionview Calls
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return allPosts.count
    }
       
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCellIdentifier, for: indexPath) as! PostCell
           cell.delegate = self
           cell.layer.cornerRadius = 20
           cell.post = allPosts[indexPath.item]
           return cell
       }
       
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           print("selected Row: ", indexPath.item)
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            var height : CGFloat = 100
            let width = collectionView.frame.width - 20
            let message = allPosts[indexPath.item].body
            height = self.getEstimatedHeight(text: message, width: width, fontSize: 13).height + 100
            return CGSize(width: width, height: height)
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 10
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0
       }
       
    
}


extension PostController : PostCellDelegate {
    func sharePost(sender: PostCell) {
            guard let indexPath = self.collectionView.indexPath(for: sender) else {return}
            let post = allPosts[indexPath.item]
            let message = "\(post.title) \n\(post.body)"
            let sharedMsg = "\(message) \n\n -- PostApp Messages -- Powered by PostApp"
            let appUrl = "https://www.google.com" //url to app on store
            guard let url = URL(string: appUrl) else {return}
            let activityViewController = UIActivityViewController(activityItems: [sharedMsg, url], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
    }
}
