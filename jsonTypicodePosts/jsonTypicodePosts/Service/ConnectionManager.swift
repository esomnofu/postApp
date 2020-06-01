//
//  ConnectionManager.swift
//  jsonTypicodePosts
//
//  Created by Malik on 31/05/2020.
//  Copyright © 2020 MrOfu. All rights reserved.
//

import UIKit
import Reachability
import Toast_Swift

class ConnectionManager {

static let sharedInstance = ConnectionManager()
private var reachability : Reachability!

func observeReachability(){
    do{
        self.reachability = try Reachability()
    }catch{
        print("could not instantiate reachability")
    }
    NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
    do {
        try self.reachability.startNotifier()
    }
    catch(let error) {
        print("Error occured while starting reachability notifications : \(error.localizedDescription)")
    }
}

@objc func reachabilityChanged(note: Notification) {
    let reachability = note.object as! Reachability
    switch reachability.connection {
    case .cellular:
        removeNetworkToast()
        print("Network available via Cellular Data.")
        break
    case .wifi:
        removeNetworkToast()
        print("Network available via WiFi.")
        break
    case .none:
        print("Network is not available.")
        presentNoNetworkToast()
        break
    case .unavailable:
        print("Network is unavailable.")
        presentNoNetworkToast()
        break
    }
  }
    
    func presentNoNetworkToast(){
        let toastDuration : TimeInterval = 3600.0 //1hr
        if let window = UIApplication.shared.windows.first {
            window.hideToast() //dismiss any toast if available
            window.makeToast("There is a break in your internet connection", duration: toastDuration, point: CGPoint(x: window.frame.width/2, y: window.frame.height/2), title: "No Connection", image:#imageLiteral(resourceName: "no_internet")) { didTap in
                if didTap {
                    print("handle user trying to reconnect")
                } else {
                    print("user didn't try to reconnect, duration elasped")
                }
            }
        }
    }
    
    func removeNetworkToast(){
        if let window = UIApplication.shared.windows.first {
            window.hideToast() //dismiss any toast if available
        }
    }
    
}
