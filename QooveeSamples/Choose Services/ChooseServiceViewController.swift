//
//  ChooseServiceViewController.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/9/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import UIKit

class ChooseServiceViewController: UIViewController {
    static func storyboardInstance() -> UIViewController?{
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        return viewController
    }
    
    @IBOutlet private weak var headerView: UIView!{
        didSet{
            let colors = [UIColor(red: 0, green: 57.0/255, blue: 164.0/255, alpha: 1).cgColor,
                          UIColor(red: 0, green: 111.0/255, blue: 210.0/255, alpha: 1).cgColor,
                          UIColor(red: 0, green: 155.0/255, blue: 248.0/255, alpha: 1).cgColor]
            setup(view: headerView, with: colors)
        }
    }
    
    @IBOutlet private weak var marketView: UIView!{
        didSet{
            let colors = [UIColor(red: 0, green: 202.0/255, blue: 196.0/255, alpha: 1).cgColor,
                          UIColor(red: 114.0/255, green: 229.0/255, blue: 182.0/255, alpha: 1).cgColor,
                          UIColor(red: 180.0/255, green: 245.0/255, blue: 174.0/255, alpha: 1).cgColor]
            setup(view: marketView, with: colors)
            addShadow(to: marketView)
        }
    }
    
    @IBOutlet private weak var tenderView: UIView! {
        didSet{
            let colors = [UIColor(red: 1, green: 89.0/255, blue: 80.0/255, alpha: 1).cgColor,
                          UIColor(red: 254.0/255, green: 193.0/255, blue: 59.0/255, alpha: 1).cgColor]
            setup(view: tenderView, with: colors)
            addShadow(to: tenderView)
        }
    }
    
    @IBOutlet private weak var serviceView: UIView!{
        didSet{
            let colors = [UIColor(red: 57.0/255, green: 25.0/255, blue: 144.0/255, alpha: 1).cgColor,
                          UIColor(red: 229.0/255, green: 107.0/255, blue: 175.0/255, alpha: 1).cgColor]
            setup(view: serviceView, with: colors)
            addShadow(to: serviceView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor(red: 247.0/255, green: 249.0/255, blue: 252.0/255, alpha: 1)
    }
    
    func setup(view: UIView, with colors: [CGColor]) {
        addGradient(to: view, colors: colors)
    }
    
    func addGradient(to view: UIView, colors: [CGColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.zPosition = -1
        gradient.colors = colors
        gradient.cornerRadius = 15
        view.layer.addSublayer(gradient)
    }
    
    func addShadow(to view: UIView) {
        let shadowSize : CGFloat = 16.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: view.frame.size.width + shadowSize,
                                                   height: view.frame.size.height + shadowSize))
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor(red: 214.0/255, green: 224.0/255, blue: 231/255, alpha: 1).cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowPath = shadowPath.cgPath
    }
}
