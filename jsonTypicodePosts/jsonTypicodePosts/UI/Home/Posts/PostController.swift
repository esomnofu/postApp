//
//  PostController.swift
//  jsonTypicodePosts
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit

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
            self.displayNetworkRequestError()
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
