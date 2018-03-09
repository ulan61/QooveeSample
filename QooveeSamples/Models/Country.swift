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
    var phoneNumberCode: String!
    var firstLetter: String{
        return String(self.name[self.name.startIndex]).uppercased()
    }
    init(name: String, emojiFlag:String) {
        self.name = name
        self.emojiFlag = emojiFlag
    }
    convenience init(name: String, emojiFlag: String, phoneNumberCode: String) {
        self.init(name: name, emojiFlag: emojiFlag)
        self.phoneNumberCode = phoneNumberCode
    }
}
