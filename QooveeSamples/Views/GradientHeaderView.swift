//
//  GradientHeaderView.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/9/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import UIKit

class GradientHeaderView: UIView {
    private var backButton: UIButton!
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var detailLabel: UILabel!
    private var infoButton: UIButton!
    
    private var colors = [CGColor]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backButton.pin.left(15).top(35)
        imageView.pin.left(50).top(44).right(50).aspectRatio()
        titleLabel.pin.bottom(47).left(78).right(78)
        detailLabel.pin.hCenter().bottom(15)
        infoButton.pin.right(15).bottom(15)
        addGradient(colors: colors, cornerRadius: 0)
    }
    
    convenience init(frame: CGRect, colors: [CGColor], title: String, detail: String) {
        self.init(frame: frame)
        self.colors = colors
        setupBackButton()
        setupImageView()
        setupTitleLabel(text: title)
        setupDetailLabel(text: detail)
        setupInfoButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupBackButton() {
        backButton = UIButton(frame: CGRect(x: 15, y: 35, width: 36, height: 36))
        backButton.setImage(#imageLiteral(resourceName: "buttonGradientMediumBack"), for: .normal)
        self.addSubview(backButton)
    }
    
    private func setupImageView()  {
        imageView = UIImageView(frame: CGRect(x: 15, y: 44, width: 345, height: 145))
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "group")
        self.addSubview(imageView)
    }
    
    private func setupTitleLabel(text: String) {
        titleLabel = UILabel(frame: CGRect(x: 79, y: 191, width: 218, height: 29))
        titleLabel.text = text
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.heavy)
        titleLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(titleLabel)
    }
    private func setupDetailLabel(text: String) {
        detailLabel = UILabel(frame: CGRect(x: 230, y: 115, width: 145, height: 22))
        detailLabel.text = text
        detailLabel.textColor = .white
        detailLabel.textAlignment = .left
        detailLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        detailLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(detailLabel)
    }
    
    private func setupInfoButton() {
        infoButton = UIButton(frame: CGRect(x: 338, y: 230, width: 22, height: 22))
        infoButton.setImage(#imageLiteral(resourceName: "buttonInfo"), for: .normal)
        self.addSubview(infoButton)
    }
    
    
}
