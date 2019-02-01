//
//  UIImageView+Helper.swift
//  FoxCast
//
//  Created by Vaibhav Parmar on 01/02/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


public class ImageView: UIImageView {
    
    //let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorView.Style.whiteLarge)
    let activity = UIActivityIndicatorView(style: .whiteLarge)
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(self.activity)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.activity.frame = self.bounds;
    }
    
    public func setImageFromUrl(urlString: String,
                                placeHolder: UIImage? = nil,
                                removeExsiting: Bool = false) {
        guard let url = URL(string: urlString) else {
            self.image = placeHolder
            return
        }
        if removeExsiting {
            let options: KingfisherOptionsInfo = [.forceRefresh]
            self.setImageFromUrl(url: url, placeHolder: placeHolder, options: options)
        } else {
            self.setImageFromUrl(url: url, placeHolder: placeHolder)
        }
    }
    
    public func setImageFromUrl(url: URL,
                                placeHolder: UIImage? = nil,
                                options: KingfisherOptionsInfo? = nil) {
        self.image = placeHolder
        
        var kfOptions: KingfisherOptionsInfo = [.transition(ImageTransition.fade(1))]
        if let options = options {
            kfOptions.append(contentsOf: options)
        }
        
        self.kf.setImage(with: url,
                         placeholder: placeHolder,
                         options: kfOptions,
                         progressBlock: { _, _ in },
                         completionHandler: { image, error, cacheType, imageURL in
        })
    }

    private func startLoader() {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    private func stopLoader() {
        activity.isHidden = true
        activity.stopAnimating()
    }
}

extension ImageView {
    func loadGif(_ named: String) {
        guard let url = Bundle.main.url(forResource: named, withExtension: ".gif") else { return }
        self.setImageFromUrl(urlString: url.absoluteString)
    }
}
