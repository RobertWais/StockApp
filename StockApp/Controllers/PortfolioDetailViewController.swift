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
    
    @IBOutlet weak var numberOneButton: UIButton!
    @IBOutlet weak var numberTwoButton: UIButton!
    @IBOutlet weak var numberThreeButton: UIButton!
    @IBOutlet weak var numberFourButton: UIButton!
    @IBOutlet weak var numberFiveButton: UIButton!
    @IBOutlet weak var numberSixButton: UIButton!
    @IBOutlet weak var numberSevenButton: UIButton!
    @IBOutlet weak var numberEightButton: UIButton!
    @IBOutlet weak var numberNineButton: UIButton!
    @IBOutlet weak var numberZeroButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cbutton: UIButton!
    
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
        numberOneButton.layer.borderWidth = CGFloat(borderWidth)
        numberOneButton.layer.borderColor = borderColor
        numberTwoButton.layer.borderWidth = CGFloat(borderWidth)
        numberTwoButton.layer.borderColor = borderColor
        numberThreeButton.layer.borderWidth = CGFloat(borderWidth)
        numberThreeButton.layer.borderColor = borderColor
        numberFourButton.layer.borderWidth = CGFloat(borderWidth)
        numberFourButton.layer.borderColor = borderColor
        numberFiveButton.layer.borderWidth = CGFloat(borderWidth)
        numberFiveButton.layer.borderColor = borderColor
        numberSixButton.layer.borderWidth = CGFloat(borderWidth)
        numberSixButton.layer.borderColor = borderColor
        numberSevenButton.layer.borderWidth = CGFloat(borderWidth)
        numberSevenButton.layer.borderColor = borderColor
        numberEightButton.layer.borderWidth = CGFloat(borderWidth)
        numberEightButton.layer.borderColor = borderColor
        numberNineButton.layer.borderWidth = CGFloat(borderWidth)
        numberNineButton.layer.borderColor = borderColor
        numberZeroButton.layer.borderWidth = CGFloat(borderWidth)
        numberZeroButton.layer.borderColor = borderColor
        deleteButton.layer.borderWidth = CGFloat(borderWidth)
        deleteButton.layer.borderColor = borderColor
        cbutton.layer.borderWidth = CGFloat(borderWidth)
        cbutton.layer.borderColor = borderColor
    }
}
