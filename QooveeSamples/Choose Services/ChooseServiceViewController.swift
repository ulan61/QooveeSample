//
//  ChooseServiceViewController.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/9/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import UIKit
import PinLayout

class ChooseServiceViewController: UIViewController {
    private var headerView: GradientHeaderView!
    private var marketView: GradientButtonView!
    private var tenderView: GradientButtonView!
    private var serviceView: GradientButtonView!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.pin.left(0).top(0).right(0).width(self.view.bounds.width).aspectRatio(1.4)
        marketView.pin.below(of: headerView).marginTop(30).left(20).right(20).aspectRatio(3.35)
        tenderView.pin.below(of: [headerView, marketView]).marginTop(20).left(20).right(20).aspectRatio(3.35)
        serviceView.pin.below(of: [headerView, marketView, tenderView]).marginTop(20).left(20).right(20).aspectRatio(3.35)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        setupMarketView()
        setupTenderView()
        setupServiceView()

        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor(red: 247.0/255, green: 249.0/255, blue: 252.0/255, alpha: 1)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    private func setupHeaderView() {
        let colors = [UIColor(red: 0, green: 57.0/255, blue: 164.0/255, alpha: 1).cgColor,
                      UIColor(red: 0, green: 111.0/255, blue: 210.0/255, alpha: 1).cgColor,
                      UIColor(red: 0, green: 155.0/255, blue: 248.0/255, alpha: 1).cgColor]
        headerView = GradientHeaderView(frame: CGRect(x: 0, y: 0, width: 375, height: 267),
                                            colors: colors,
                                            title: "Добро пожаловать",
                                            detail: "Выберите сервис")
        headerView.setBackButton(action: #selector(getBack), target: self)
        headerView.setInfoButton(action: #selector(getInfo), target: self)
        self.view.addSubview(headerView)
    }
    
    @objc private func getBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func getInfo(){
        print("Yeap")
    }
    
    private func setupMarketView() {
        let colors = [UIColor(red: 0, green: 202.0/255, blue: 196.0/255, alpha: 1).cgColor,
                      UIColor(red: 114.0/255, green: 229.0/255, blue: 182.0/255, alpha: 1).cgColor,
                      UIColor(red: 180.0/255, green: 245.0/255, blue: 174.0/255, alpha: 1).cgColor]
        marketView = GradientButtonView(frame: CGRect(x: 0, y: 0, width: 335, height: 100), colors: colors, buttonImage: #imageLiteral(resourceName: "marketIcon"), buttonTitle: "Маркет")
        self.view.addSubview(marketView)
    }
    
    private func setupTenderView() {
        let colors = [UIColor(red: 1, green: 89.0/255, blue: 80.0/255, alpha: 1).cgColor,
                      UIColor(red: 254.0/255, green: 193.0/255, blue: 59.0/255, alpha: 1).cgColor]
        tenderView = GradientButtonView(frame: CGRect(x: 0, y: 0, width: 335, height: 100), colors: colors, buttonImage: #imageLiteral(resourceName: "tendersIcon"), buttonTitle: "Тендеры")
        self.view.addSubview(tenderView)
    }
    
    private func setupServiceView() {
        let colors = [UIColor(red: 57.0/255, green: 25.0/255, blue: 144.0/255, alpha: 1).cgColor,
                      UIColor(red: 229.0/255, green: 107.0/255, blue: 175.0/255, alpha: 1).cgColor]
        serviceView = GradientButtonView(frame: CGRect(x: 0, y: 0, width: 335, height: 100), colors: colors, buttonImage: #imageLiteral(resourceName: "servicesIcon"), buttonTitle: "Сервисы")
        self.view.addSubview(serviceView)
    }
    
}
