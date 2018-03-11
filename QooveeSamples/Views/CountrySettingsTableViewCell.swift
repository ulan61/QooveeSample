//
//  CountrySettingsTableViewCell.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/10/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import UIKit

class CountrySettingsTableViewCell: CountryBaseTableViewCell {
    private var checkImageView: UIImageView!

    override func layoutSubviews() {
        super.layoutSubviews()
        checkImageView.pin.right(20).vCenter().width(20).aspectRatio(1)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCheckImageView(borderColor: UIColor(red: 206.0/255, green: 208.0/255, blue: 218.0/255, alpha: 1), shadowColor: UIColor(red: 207.0/255, green: 218.0/255, blue: 226.0/255, alpha: 1))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setCheck(image: UIImage?) {
        if image == nil {
            setCheckImageView(borderColor: UIColor(red: 206.0/255, green: 208.0/255, blue: 218.0/255, alpha: 1),
                                shadowColor: UIColor(red: 207.0/255, green: 218.0/255, blue: 226.0/255, alpha: 1))
        }
        else{
            setCheckImageView(borderColor: .clear,
                                shadowColor: .clear)
        }
        checkImageView.image = image
    }
    
    private func setCheckImageView(borderColor: UIColor, shadowColor: UIColor){
        checkImageView.layer.borderWidth = 1
        checkImageView.layer.borderColor = borderColor.cgColor
        checkImageView.layer.cornerRadius = checkImageView.bounds.width / 2
        checkImageView.layer.shadowColor = shadowColor.cgColor
        checkImageView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        checkImageView.layer.shadowOpacity = 6
    }
    
    private func setupCheckImageView(borderColor: UIColor, shadowColor: UIColor) {
        checkImageView = UIImageView(frame: CGRect(x: 335, y: 159, width: 20, height: 20))
        setCheckImageView(borderColor: borderColor, shadowColor: shadowColor)
        self.addSubview(checkImageView)
    }
}
