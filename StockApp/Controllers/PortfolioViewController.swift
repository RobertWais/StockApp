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
    
    var portfolios = [Portfolio]()
    var stockPrices = [String: Double]()
    var lookedUp = Set<String>()
    var labels = [UILabel]()
   // var totalValueArr = [Double]()
    //var compNamesArr = [String]()
    var tempArrNames = [String]()
    //var sum: Double = 0
    var pieChartDataEntry = [PieChartDataEntry]()
    let fakeValues: [Double] = [25.6]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
            navigationController?.navigationBar.barStyle = .black
//            navigationItem.rightBarButtonItem = addNavigationItem
//            navigationItem.rightBarButtonItem?.image = UIImage(named: "addIcon")
//            navigationItem.rightBarButtonItem?.tintColor = .white
        }
        
        portfolios = CoreDataHelper.retrievePortfolio()
        updateValues()
        
//        labels.append(stockPriceLabel)
//        labels.append(numOfStockLabel)
//        labels.append(totalWorthLabel)
        
        print(labels)

        
//        StockData.getDailyStocks(symbol: "AAPL") { (data) in
//            print("Current value: \(data[data.count-1].high)")
//        }
        
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue){
        portfolios = CoreDataHelper.retrievePortfolio()
        updateValues()
    }
    
    func updateValues (){
        //totalValueArr.removeAll()
        //compNamesArr.removeAll()
        var count = 0
        for index in 0..<portfolios.count {
            if lookedUp.contains(portfolios[index].ticker!) {
            }else{
                lookedUp.insert(portfolios[index].ticker!)
                delay(Double(index*2))  //Here you put time you want to delay
                {
                    StockData.getDailyStocks(symbol: self.portfolios[index].ticker!) { (data) in
                        if data.count != 0 {
                            self.stockPrices[self.portfolios[index].ticker!] = (Double(data[data.count-1].close)!)
                            self.tableView.reloadData()
                            
                            //self.totalValueArr.append(self.stockPrices[self.portfolios[index].ticker!]!*Double(self.portfolios[index].amount))

                            self.tempArrNames.append(self.portfolios[index].name!)
                            //self.compNamesArr.append(self.tempArr.last!)
                            print(self.tempArrNames)
                            //print(self.compNamesArr)
                            //print(self.totalValueArr)
                            
                            for vals in 0 ..< self.fakeValues.count {
                                self.pieChartDataEntry.append(PieChartDataEntry(value: self.fakeValues[vals], label: self.tempArrNames[vals]))
                                print(self.pieChartDataEntry)
                            }
                            
                            let set1 = PieChartDataSet(values: self.pieChartDataEntry, label: "Hello")
                            //print(set1)
                            //set1.colors = ChartColorTemplates.vordiplom()
                            
                            //GENERATE CHART ON SCREEN
                            self.pieChartView.data = PieChartData(dataSet: set1)
                            //self.pieChartView.data?.setValueTextColor(UIColor.black)
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            //self.sum = self.totalValueArr.reduce(0, +)
                            
//                            print(self.sum)
                            
                            
                        }
//                        self.sum = self.totalValueArr.reduce(0, +)
//                        print(self.sum)
                       // print(self.totalValueArr)
                    }
                }
                count += 1
                //print(self.totalValueArr)
            }
        }
    }
    @objc func addTapped() {
        print("add button tapped")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PortfolioViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Owned Stocks\n  (Current Price) (# of Stocks)  (Total worth)"
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
        //totalValueArr.removeAll()
        //compNamesArr.removeAll()
        let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioStockTableViewCell") as! PortfolioStockTableViewCell
        cell.stockTitle.text = portfolios[indexPath.row].name
        //FOR PIE CHART
        //compNamesArr.append(cell.stockTitle.text!)
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
            
            //FOR PIE CHART
            //totalValueArr.append(stockPrices[portfolios[indexPath.row].ticker!]!*Double(portfolios[indexPath.row].amount))
            
        }else{
            cell.stockPrice.text = "Loading.."
            cell.stockValue.text = "Calculating"
        }
        //compNamesArr.append(cell.stockTitle.text!)
        //totalValueArr.append(stockPrices[portfolios[indexPath.row].ticker!]!*Double(portfolios[indexPath.row].amount))
        cell.stockAmount.text = String(describing: portfolios[indexPath.row].amount)
        var priceBoughtAt = portfolios[indexPath.row].value
        return cell
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioStockTableViewCell") as! PortfolioStockTableViewCell
//
//            cell.stockTitle.text = "AMZN"
//            cell.stockPrice.text = "price"
//            cell.stockAmount.text = "amount"
//            cell.stockValue.text = "value"
//            return cell
//        } else if indexPath.row == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioStockTableViewCell") as! PortfolioStockTableViewCell
//            cell.stockTitle.text = "AAPL"
//            cell.stockPrice.text = "price"
//            cell.stockAmount.text = "amount"
//            cell.stockValue.text = "value"
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioGraphTableViewCell") as! PortfolioGraphTableViewCell
//            cell.graphImageView.image = UIImage(named: "portfolio_test_graph")
//            return cell
//        }
    }
}
