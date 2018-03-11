//
//  CountryLoginTableViewCell.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/10/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import UIKit

class CountryLoginTableViewCell: CountryBaseTableViewCell {
    private var phoneNumberCodeLabel: UILabel!
    private var phoneNumberCode: String!

    override func layoutSubviews() {
        super.layoutSubviews()
        phoneNumberCodeLabel.pin.right(20).vCenter()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPhoneNumberLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupPhoneNumberLabel(){
        phoneNumberCodeLabel = UILabel(frame: CGRect(x: 317, y: 96, width: 50, height: 25))
        phoneNumberCodeLabel.textColor = UIColor(red: 0, green: 147.0/255, blue: 243.0/255, alpha: 1)
        phoneNumberCodeLabel.textAlignment = .right
        self.addSubview(phoneNumberCodeLabel)
    }
    
    override func initWith(country: Country) {
        super.initWith(country: country)
        phoneNumberCode = country.getPhoneNumberCode()
    }
    
    func setPhoneNumberCode()  {
        phoneNumberCodeLabel.text = phoneNumberCode
    }
    
}
