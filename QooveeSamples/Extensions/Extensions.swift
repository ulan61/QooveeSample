//
//  Extensions.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/8/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func addCharacterSpacing() {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: 1, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}

extension UIView{
    func addGradient(colors: [CGColor], cornerRadius: CGFloat) {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.zPosition = -1
        gradient.colors = colors
        gradient.cornerRadius = cornerRadius
        self.layer.addSublayer(gradient)
    }
    func addShadow() {
        let shadowSize : CGFloat = 16.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.frame.size.width + shadowSize,
                                                   height: self.frame.size.height + shadowSize))
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 214.0/255, green: 224.0/255, blue: 231/255, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = shadowPath.cgPath
    }
}
