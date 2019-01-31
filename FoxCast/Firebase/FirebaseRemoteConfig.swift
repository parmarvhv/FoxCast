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
    case showCallNowButton
    case showRatingCircleView
    
    
    case loginOption
}

enum LoginOption: String {
    case facebook
    case google
}

class FirebaseRemoteConfig {
    
    public static let shared = FirebaseRemoteConfig()
    
    //TODO: Yet to implement in Splash Screen
    var isFetchComplete: Bool = false
    var loadingDoneHandler: (() -> ())?
    
    func configure() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        self.loadDefaultValues()
        self.fetchRemoteValues()
    }
    
    private init() {}
    
    func loadDefaultValues() {
        let appDefaults: [String: NSObject] = [
            FirebaseRemoteKey.loginOption.rawValue: LoginOption.facebook.rawValue as NSObject
        ]
        RemoteConfig.remoteConfig().setDefaults(appDefaults)
    }
    
    func fetchRemoteValues() {
        let fetchDuration: TimeInterval = 0
        self.activateDebugMode()
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: fetchDuration) { (status, error) in
            guard error == nil else {
                print("Oops! Got an error fetching remote values \(error!)")
                return
            }
            
            RemoteConfig.remoteConfig().activateFetched()
            self.isFetchComplete = true
            self.loadingDoneHandler?()
        }
    }
    
    //TODO: Will remove debug mode after A/B Test Experiment
    func activateDebugMode() {
        let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
        RemoteConfig.remoteConfig().configSettings = debugSettings
    }
    
    func boolValue(forKey key: FirebaseRemoteKey) -> Bool {
        return RemoteConfig.remoteConfig()[key.rawValue].boolValue
    }
    
    func stringValue(forKey key: FirebaseRemoteKey) -> String {
        return RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? LoginOption.facebook.rawValue
    }
    
}
