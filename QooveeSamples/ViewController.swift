//
//  ViewController.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/6/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func chooseCountryLogin(_ sender: UIButton){
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(ChooseCountryLoginViewController(), animated: true)
    }
    
    @IBAction func chooseCountrySettings(_ sender: UIButton){
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(ChooseCountrySettingsViewController(), animated: true)
    }

    
    @IBAction func chooseService(_ sender: UIButton){
        self.navigationController?.pushViewController(ChooseServiceViewController(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
}

