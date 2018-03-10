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
    internal var checkImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flagImageLabel.pin.left(20).vCenter().width(18).height(13)
        countryNameLabel.pin.after(of: flagImageLabel).marginLeft(13).vCenter().marginRight(10)
//            checkImageView.pin.after(of: [flagImageView, countryNameLabel]).marginLeft(10).right(20).vCenter().aspectRatio(1)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupFlagImageView()
        setupCountryNameLabel()
    }
    
   
//        if cellType == CellType.settings{
//            setupCheckImageView(borderColor: UIColor(red: 206.0/255, green: 208.0/255, blue: 218.0/255, alpha: 1),
//                                shadowColor: UIColor(red: 207.0/255, green: 218.0/255, blue: 226.0/255, alpha: 1))
//        }
//        else{
//            setupPhoneNumberLabel()
//        }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initWith(country: Country) {
        countryNameLabel.text = country.getName()
        flagImageLabel.text = country.getEmojiFlag()
    }
    
//    func setCheckImageView(with image: UIImage?) {
//        if image == nil {
//            setupCheckImageView(borderColor: UIColor(red: 206.0/255, green: 208.0/255, blue: 218.0/255, alpha: 1),
//                                shadowColor: UIColor(red: 207.0/255, green: 218.0/255, blue: 226.0/255, alpha: 1))
//        }
//        else{
//            setupCheckImageView(borderColor: .clear,
//                                shadowColor: .clear)
//        }
//        checkImageView.image = image
//    }
    
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
        countryNameLabel = UILabel(frame: CGRect(x: 51, y: 96, width: 270, height: 18))
        countryNameLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(countryNameLabel)
    }
    
//    private func setupCheckImageView(borderColor: UIColor, shadowColor: UIColor) {
//        checkImageView = UIImageView(frame: CGRect(x: 335, y: 159, width: 20, height: 20))
//        checkImageView.layer.borderWidth = 1
//        checkImageView.layer.borderColor = borderColor.cgColor
//        checkImageView.layer.cornerRadius = checkImageView.bounds.width / 2
//        checkImageView.layer.shadowColor = shadowColor.cgColor
//        checkImageView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        checkImageView.layer.shadowOpacity = 6
//        self.addSubview(checkImageView)
//    }
    
}
