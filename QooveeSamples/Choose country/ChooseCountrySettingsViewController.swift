//
//  ChooseCountrySettingsViewController.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/10/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import UIKit

class ChooseCountrySettingsViewController: ChooseCountryBaseViewController {
    private var selectedIndexPath: IndexPath!
    private var footerView: UIView!
    private var footerViewButton: UIButton!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        footerView.pin.left(0).right(0).bottom(0).width(self.view.bounds.width).aspectRatio(self.view.bounds.width/95.0)
        footerViewButton.pin.left(20).right(20).width(self.view.bounds.width - 40).aspectRatio().top(20)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView(cellClass: CountrySettingsTableViewCell.self, reuseIdentifier: "countrySettingsCell")
        setupFooterView()
    }
    
    override func setupTableView(cellClass: AnyClass?, reuseIdentifier: String) {
        super.setupTableView(cellClass: cellClass, reuseIdentifier: reuseIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    private func setupFooterView(){
        footerView = UIView(frame: CGRect(x: 0, y: 572, width: self.view.bounds.width, height: 95))
        footerView.backgroundColor = .white
        footerView.addShadow()
        footerViewButton = UIButton(frame: CGRect(x: 20, y: 20, width: self.view.bounds.width - 40, height: 50))
        footerViewButton.backgroundColor = UIColor(red: 0  , green: 147.0/255, blue: 243.0/255, alpha: 1)
        footerViewButton.layer.cornerRadius = 10
        footerViewButton.setTitle("ПРОДОЛЖИТЬ", for: .normal)
        footerViewButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.heavy)
        footerView.addSubview(footerViewButton)
        self.view.addSubview(footerView)
    }
}

extension ChooseCountrySettingsViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! CountrySettingsTableViewCell
        guard let selectedIndexPath = self.selectedIndexPath else {
            cell.setCheck(image: nil)
            return cell
        }
        if selectedIndexPath == indexPath{
            cell.setCheck(image: #imageLiteral(resourceName: "checkboxPressed"))
        }
        else{
            cell.setCheck(image: nil)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        tableView.reloadData()
    }

}
