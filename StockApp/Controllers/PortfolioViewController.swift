//
//  PortfolioViewController.swift
//  StockApp
//
//  Created by Kevin Singh on 7/16/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
            navigationController?.navigationBar.barStyle = .black
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
