//
//  FIrebaseConfig.swift
//  FoxCast
//
//  Created by Vaibhav Parmar on 31/01/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import Foundation
import Firebase

class FirebaseConfig {
    
    static let shared = FirebaseConfig()
    
    private init() {
    }
    
    func configure() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
}
