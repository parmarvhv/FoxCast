//
//  SectionModel.swift
//  FoxCast
//
//  Created by Vaibhav Parmar on 01/02/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import Foundation

class SectionModel {
    
    var headerModel: Any?
    var cellModels: [Any] = []
    var footerModel: Any?
    
    init(headerModel: Any? = nil,
         cellModels: [Any] = [],
         footerModel: Any? = nil) {
        self.headerModel = headerModel
        self.cellModels = cellModels
        self.footerModel = footerModel
    }
}
