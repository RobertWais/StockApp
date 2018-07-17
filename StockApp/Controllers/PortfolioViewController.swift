//
//  PortfolioViewController.swift
//  StockApp
//
//  Created by Kevin Singh on 7/16/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController {
    
    let addNavigationItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
            navigationController?.navigationBar.barStyle = .black
            navigationItem.rightBarButtonItem = addNavigationItem
            navigationItem.rightBarButtonItem?.image = UIImage(named: "addIcon")
            navigationItem.rightBarButtonItem?.tintColor = .white
        }

    }
    
    @objc func addTapped() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
