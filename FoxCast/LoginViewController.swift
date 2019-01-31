//
//  LoginViewController.swift
//  FoxCast
//
//  Created by Vaibhav Parmar on 31/01/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var loginButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.updateLoginButtonText()
    }

    private func updateLoginButtonText() {
        let text = FirebaseRemoteConfig.shared.stringValue(forKey: .loginOption)
        let loginText = "Login with \(text.capitalized)"
        self.loginButton.setTitle(loginText, for: .normal)
    }

}

