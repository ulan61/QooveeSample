//
//  CountryTableViewCell.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/7/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!{
        didSet{
            countryNameLabel.textColor = Colors.labelTextColor
        }
    }
    @IBOutlet private weak var checkImageView: UIImageView!{
        didSet{
            setupCheckImageView(borderColor: UIColor(red: 206.0/255, green: 208.0/255, blue: 218.0/255, alpha: 1),
                                shadowColor: UIColor(red: 207.0/255, green: 218.0/255, blue: 226.0/255, alpha: 1))
        }
    }
    
    var checkImage: UIImage!{
        didSet{
            if checkImage == nil {
                setupCheckImageView(borderColor: UIColor(red: 206.0/255, green: 208.0/255, blue: 218.0/255, alpha: 1),
                                    shadowColor: UIColor(red: 207.0/255, green: 218.0/255, blue: 226.0/255, alpha: 1))
            }
            else{
                setupCheckImageView(borderColor: .clear,
                                    shadowColor: .clear)
            }
            checkImageView.image = checkImage
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = .zero
        self.layoutMargins = .zero
        self.selectionStyle = .none
    }
    
    func setupCheckImageView(borderColor: UIColor, shadowColor: UIColor) {
        checkImageView.layer.borderWidth = 1
        checkImageView.layer.borderColor = borderColor.cgColor
        checkImageView.layer.cornerRadius = checkImageView.bounds.width / 2
        checkImageView.layer.shadowColor = shadowColor.cgColor
        checkImageView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        checkImageView.layer.shadowOpacity = 6
    }
    
}
