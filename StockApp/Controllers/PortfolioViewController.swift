//
//  PortfolioViewController.swift
//  StockApp
//
//  Created by Kevin Singh on 7/16/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import UIKit
import Charts

class PortfolioViewController: UIViewController, ChartViewDelegate{
    
    let addNavigationItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pieChartView: PieChartView!
    var pieChartDataEntry = [PieChartDataEntry]()
    var portfolios = [Portfolio]()
    var stockPrices = [String: Double]()
    var lookedUp = Set<String>()
    let compNames:[String] = ["Apple","Tesla","Microsoft","Amazon"]
    let values: [Double] = [25.6,25.0,25.0,24.4]
    //var emptyDoubles: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
            navigationController?.navigationBar.barStyle = .black
//            navigationItem.rightBarButtonItem = addNavigationItem
//            navigationItem.rightBarButtonItem?.image = UIImage(named: "addIcon")
//            navigationItem.rightBarButtonItem?.tintColor = .white
            
            //GET DATA FOR CHART
            for index in 0 ..< values.count {
                self.pieChartDataEntry.append(PieChartDataEntry(value: values[index], label: compNames[index]))
            }
            

            let set1 = PieChartDataSet(values: self.pieChartDataEntry, label: "")
            set1.colors = ChartColorTemplates.vordiplom()
            
            //GENERATE CHART ON SCREEN
            self.pieChartView.data = PieChartData(dataSet: set1)
            self.pieChartView.data?.setValueTextColor(UIColor.black)
           
            //FORMAT NUMBERS INTO PERCENTAGES
            let pFormatter = NumberFormatter()
            pFormatter.numberStyle = .percent
            pFormatter.maximumFractionDigits = 1
            pFormatter.multiplier = 1
            pFormatter.percentSymbol = " %"
            self.pieChartView.data?.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
            
            //LEGEND ATTRIBUTES
            let l = self.pieChartView.legend
            l.horizontalAlignment = .right
            l.verticalAlignment = .top
            l.orientation = .vertical
            l.xEntrySpace = 7
            l.yEntrySpace = 3
            l.yOffset = 16
            
            //ANIMATION
            pieChartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
            //let centerText: NSMutableAttributedString = NSMutableAttributedString(string: "Charts\nby Daniel Cohen Gindi")
            //self.pieChartView.centerAttributedText = centerText
            
            //GET RID OF DESCRIPTION
            self.pieChartView.chartDescription?.text = ""
            //self.pieChartView.
            
        }
        
        
        portfolios = CoreDataHelper.retrievePortfolio()
        updateValues()

        
        
//        StockData.getDailyStocks(symbol: "AAPL") { (data) in
//            print("Current value: \(data[data.count-1].high)")
//        }
        
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func updateValues (){
        var count = 0
        for index in 0..<portfolios.count {
            if lookedUp.contains(portfolios[index].ticker!) {
            }else{
                lookedUp.insert(portfolios[index].ticker!)
                delay(Double(count*2))  //Here you put time you want to delay
                {
                    StockData.getDailyStocks(symbol: self.portfolios[index].ticker!) { (data) in
                        if data.count != 0 {
                            self.stockPrices[self.portfolios[index].ticker!] = (Double(data[data.count-1].close)!)
                            self.tableView.reloadData()
                            
                        }
                    }
                }
                count += 1
            }
            
            
        }
    }
    
//    func setDataCount(_ count: Int, range: UInt32) {
//        let entries = (0..<count).map { (i) -> PieChartDataEntry in
//            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
//            return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5),
//                                     label: "Hello",
//                                     icon: #imageLiteral(resourceName: "icon"))
//        }
    @objc func addTapped() {
        print("add button tapped")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PortfolioViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Owned Stocks"
    }
}

extension PortfolioViewController: UITableViewDataSource {
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolios.count
    }
    
    //    TODO: DATA FROM API, Switch statement
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let name = portfolios[indexPath.row].ticker else {
            fatalError()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioStockTableViewCell") as! PortfolioStockTableViewCell
        cell.stockTitle.text = portfolios[indexPath.row].name
        if let stock = stockPrices[portfolios[indexPath.row].ticker!] {
            if let dub = stockPrices[name]{
                cell.stockPrice.text = "$\(dub)"
                
                if dub < Double(portfolios[indexPath.row].value) {
                    cell.stockPrice.textColor = UIColor.red
                }else{
                    cell.stockPrice.textColor = UIColor.green

                }
            }
            cell.stockValue.text =  "$\(stockPrices[portfolios[indexPath.row].ticker!]!*Double(portfolios[indexPath.row].amount))"
        }else{
            cell.stockPrice.text = "Loading.."
            cell.stockValue.text = "Calculating"
        }
        
        cell.stockAmount.text = String(describing: portfolios[indexPath.row].amount)
        var priceBoughtAt = portfolios[indexPath.row].value
        return cell
    }
}

