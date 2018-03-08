//
//  Country.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/8/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import Foundation

class Country  {
    var name: String!
    var emojiFlag: String!
    var firstLetter: String{
        return String(self.name[self.name.startIndex]).uppercased()
    }
    init(name: String, emojiFlag:String) {
        self.name = name
        self.emojiFlag = emojiFlag
    }
}
