//
//  PortfolioDetailViewController.swift
//  StockApp
//
//  Created by Kevin Singh on 7/18/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import UIKit

class PortfolioDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
            navigationController?.navigationBar.barStyle = .black
        }
        self.navigationController?.navigationBar.tintColor = UIColor.white
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PortfolioDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.chooseStackTableViewCell) as! ChooseStockTableViewCell
        if indexPath.section == 0 {
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Amazon"
        case 1:
            cell.textLabel?.text = "Apple"
        case 2:
            cell.textLabel?.text = "Google"
        default:
            print("OUT OF INDEXPATH")
        }
            cell.accessoryType = .disclosureIndicator
        } else {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Actual price"
            case 1:
                cell.textLabel?.text = "Portfolio"
            default:
                print("OUT OF INDEXPATH")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Choose Stock"
        } else {
            return "Values"
        }
    }
}
