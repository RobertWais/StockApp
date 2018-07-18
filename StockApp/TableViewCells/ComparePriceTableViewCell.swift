//
//  NewsTableViewCell.swift
//  StockApp
//
//  Created by Kevin Singh on 7/16/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import UIKit

//TODO: COMPLETE THIS CONTROLLER BY DESIGN (HINT: COMPAREVIEWCONTROLLER), FIX CONSTRAINTS FOR STACKVIEW - CHECK THE VIEW ON iPHONE SE, 8 PLUS,...
class ComparePriceTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var firstCompatitor: UILabel!
    @IBOutlet weak var secondCompatitor: UILabel!
    override func awakeFromNib() {
        priceLabel.text = "Price"
        //        TODO: Color update
        firstCompatitor.textColor = .blue
        secondCompatitor.textColor = .blue
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
