//
//  CountryTableViewCell.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/7/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import UIKit

class CountryBaseTableViewCell: UITableViewCell {
    
    internal var flagImageLabel: UILabel!
    internal var countryNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flagImageLabel.pin.left(20).vCenter().width(18).height(13)
        countryNameLabel.pin.after(of: flagImageLabel).marginLeft(13).vCenter().marginRight(10).width(self.bounds.width / 1.7).aspectRatio(2)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupFlagImageView()
        setupCountryNameLabel()
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initWith(country: Country) {
        countryNameLabel.text = country.getName()
        flagImageLabel.text = country.getEmojiFlag()
    }
    
    private func setupCell()  {
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = .zero
        self.layoutMargins = .zero
        self.selectionStyle = .none
    }
    
    private func setupFlagImageView()  {
        flagImageLabel = UILabel(frame: CGRect(x: 20, y: 19, width: 18, height: 13))
        flagImageLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(flagImageLabel)
    }
    
    private func setupCountryNameLabel() {
        countryNameLabel = UILabel(frame: CGRect(x: 51, y: 96, width: 250, height: 18))
        countryNameLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(countryNameLabel)
    }
    

    
}
