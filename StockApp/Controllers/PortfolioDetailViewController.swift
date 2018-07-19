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
    
    @IBOutlet var numberButton: [UIButton]!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cbutton: UIButton!
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        
        updateTextField(number: "\(sender.tag)")
    }
    @IBOutlet weak var addValueTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var actualPriceValue: UILabel!
    @IBAction func addToPortfolioButtonTapped(_ sender: UIButton) {
        print("Button pressed")
        self.view.endEditing(true)
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
            navigationController?.navigationBar.barStyle = .black
        }
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "Add New Portfolio"
        tableView.dataSource = self
        addValueTextField.isUserInteractionEnabled = false
        setButtons()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PortfolioDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 2
        }
    }
    
    func updateTextField(number: String) {
        
        if addValueTextField.text == "0" {
            addValueTextField.text = nil
            addValueTextField.text = (addValueTextField.text ?? "") + number
        } else {
            addValueTextField.text = (addValueTextField.text ?? "") + number
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
        return "Choose Stock"
    }
}


extension PortfolioDetailViewController {
    
    func setButtons() {
        let borderColor = UIColor.lightGray.cgColor
        let borderWidth = 0.5
        for button in numberButton {
            button.layer.borderColor = borderColor
            button.layer.borderWidth = CGFloat(borderWidth)
        }
    }
}
