//
//  LoadingViewController.swift
//  FoxCast
//
//  Created by Vaibhav Parmar on 31/01/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if FirebaseRemoteConfig.shared.isFetchComplete {
            self.startOnboarding()
        }
        FirebaseRemoteConfig.shared.loadingDoneHandler = self.startOnboarding
    }
    
    private func startOnboarding() {
        self.performSegue(withIdentifier: "onboardingVCSegueId", sender: nil)
    }
}
