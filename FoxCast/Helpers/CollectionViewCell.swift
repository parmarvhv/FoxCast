//
//  CollectionViewCell.swift
//  FoxCast
//
//  Created by Vaibhav Parmar on 31/01/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var item: Any? {
        didSet {
            self.configure(self.item)
        }
    }
    
    weak var delegate: NSObjectProtocol? = nil
    
    func configure(_ item: Any?) { }
}

