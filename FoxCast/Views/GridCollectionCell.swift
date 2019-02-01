//
//  GridCollectionCell.swift
//  FoxCast
//
//  Created by Vaibhav Parmar on 31/01/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import UIKit

class GridCollectionCell: CollectionViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var feedImageView: UIImageView!
    @IBOutlet var thumbnailView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func configure(_ item: Any?) {
        guard let model = item as? CollectionCellModel else { return }
        self.nameLabel.text = model.name
        self.titleLabel.text = model.title
        self.feedImageView.image = UIImage(named: model.image)
        self.thumbnailView.image = UIImage(named: model.profileImage)
    }
}
