//
//  GradientButton.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/9/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import UIKit
import PinLayout

class GradientButtonView: UIView {
    private var imageView: UIImageView!
    private var label: UILabel!
    private var colors = [CGColor]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.pin.top(20).left(60).bottom(20).aspectRatio()
        label.pin.after(of: imageView).marginLeft(17.3).vCenter().right(87).aspectRatio(124.0/34.0)
        addGradient(colors: colors, cornerRadius: 15)
    }
    
    convenience init(frame: CGRect, colors: [CGColor], buttonImage: UIImage, buttonTitle: String) {
        self.init(frame: frame)
        self.colors = colors
        setupImageView(with: buttonImage)
        setupLabel(with: buttonTitle)
        addShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupImageView(with image: UIImage)  {
        imageView = UIImageView(frame: CGRect(x: 60, y: 20, width: 46.7, height: 60))
        imageView.image = image
        self.addSubview(imageView)
    }
    
    private func setupLabel(with text: String)  {
        label = UILabel(frame: CGRect(x: 124, y: 33, width: 124, height: 34))
        label.text = text
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.heavy)
        label.adjustsFontSizeToFitWidth = true
        self.addSubview(label)
    }
    
    
}
