//
//  FirebaseRemoteConfig.swift
//  FoxCast
//
//  Created by Vaibhav Parmar on 31/01/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import Foundation
import Firebase
import FirebaseRemoteConfig

enum FirebaseRemoteKey: String {
    case loginOption
    case gridView
}

enum LoginOption: String {
    case google
    case linkedin
}

class FirebaseRemoteConfig {
    
    public static let shared = FirebaseRemoteConfig()
    
    var isFetchComplete: Bool = false
    var loadingDoneHandler: (() -> Void)?
    
    func configure() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        self.loadDefaultValues()
        self.fetchRemoteValues()
        
//        let idToken = InstanceID.instanceID().token()
//        print ("Your instance ID token is \(idToken ?? "n/a")")
    }
    
    private init() {}
    
    func loadDefaultValues() {
        let appDefaults: [String: NSObject] = [
            FirebaseRemoteKey.loginOption.rawValue: LoginOption.linkedin.rawValue as NSObject
        ]
        RemoteConfig.remoteConfig().setDefaults(appDefaults)
    }
    
    func fetchRemoteValues() {
        //Remote Config caches values for around 12hrs. To fetch remote values instantly
        let fetchDuration: TimeInterval = 0
        self.activateDebugMode()
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: fetchDuration) { (status, error) in
            guard error == nil else {
                print("Oops! Got an error fetching remote values \(error!)")
                self.isFetchComplete = true
                self.loadingDoneHandler?()
                return
            }
            
            RemoteConfig.remoteConfig().activateFetched()
            self.isFetchComplete = true
            self.loadingDoneHandler?()
        }
    }
    
    //TODO: remove after experimenting A/B
    //Remote Config has client side throttle. By enabling developer mode, byepass throttle.
    func activateDebugMode() {
        let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
        RemoteConfig.remoteConfig().configSettings = debugSettings
    }
    
    func boolValue(forKey key: FirebaseRemoteKey) -> Bool {
        return RemoteConfig.remoteConfig()[key.rawValue].boolValue
    }
    
    func stringValue(forKey key: FirebaseRemoteKey) -> String {
        return RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? LoginOption.linkedin.rawValue
    }
    
}
