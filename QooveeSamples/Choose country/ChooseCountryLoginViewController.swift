//
//  ChooseCountryLoginViewController.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/10/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import UIKit

class ChooseCountryLoginViewController: ChooseCountryBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView(cellClass: CountryLoginTableViewCell.self, reuseIdentifier: "countryLoginCell")
    }
}

extension ChooseCountryLoginViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! CountryLoginTableViewCell
        cell.setPhoneNumberCode()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
