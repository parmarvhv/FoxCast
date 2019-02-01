//
//  ProfileViewModel.swift
//  FoxCast
//
//  Created by Vaibhav Parmar on 01/02/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import Foundation

struct Feed {
    var name: String
    var title: String
    var feedImage: String
    var profileImage: String
}

class ProfileViewModel {
    
    var sectionModel = SectionModel()
    
    init() {
        self.prepareModel()
    }
    
    private func prepareModel() {
        
        let cellModels = self.feeds.map {
            CollectionCellModel.init(name: $0.name, title: $0.title,
                                     image: $0.feedImage, profileImage: $0.profileImage)
        }
        self.sectionModel = SectionModel(cellModels: cellModels)
    }
    
    var rowCount: Int {
        return self.sectionModel.cellModels.count
    }
    
    func cellModel(at indexPath: IndexPath) -> Any {
        return self.sectionModel.cellModels[indexPath.row]
    }
    
    var feeds = [
        Feed(name: "Jon Snow", title: "Stark now targaryen",
             feedImage: "jon_feed", profileImage: "jon_snow"),
        Feed(name: "Arya Stark", title: "The no one", feedImage: "", profileImage: "arya_stark"),
        Feed(name: "Bran Stark", title: "Three eyed Raven", feedImage: "", profileImage: "bran_stark")
    ]
    
}
