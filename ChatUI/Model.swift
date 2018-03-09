//
//  Model.swift
//  ssssssss
//
//  Created by Igor Smirnov on 14/02/2018.
//  Copyright © 2018 IS. All rights reserved.
//

import Foundation

struct Message {
    var text: String
    var date: Date
    var isOwn: Bool
    var isNew: Bool

    init(text: String, date: Date, isOwn: Bool = false, isNew: Bool = true) {
        self.text = text
        self.date = date
        self.isOwn = isOwn
        self.isNew = isNew
    }
    
}
