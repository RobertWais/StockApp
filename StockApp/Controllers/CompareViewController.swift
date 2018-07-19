//
//  CompareViewController.swift
//  StockApp
//
//  Created by Kevin Singh on 7/16/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import UIKit
import Charts

class CompareViewController: UIViewController, ChartViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var company: Company?
    @IBOutlet var chartView: LineChartView!
    @IBOutlet  var tableViewDetails: UITableView!

   
   
    
    
    var chartDataEntry = [ChartDataEntry]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
            navigationController?.navigationBar.barStyle = .black
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        guard let indyCompany = company else {
            return
        }
    
        
        StockData.getStockTime(timeSlot: Constants.APICall.monthlySlot, symbol: (indyCompany.ticker)) { (data) in
            print("\(data.count)")
            
            var count = data.count
            for index in (data.count - 30) ..< data.count {
                self.chartDataEntry.append(ChartDataEntry(x: Double(index), y: Double(data[index].high)!))
            }
            let set1 = LineChartDataSet(values: self.chartDataEntry, label: "\(indyCompany.title) USD Stock Price")
            self.chartView.data = LineChartData(dataSet: set1)
            var highAndLow = self.getHighLow(entries: data)
            self.chartView.leftAxis.axisMaximum = Double(highAndLow.0 + 50)
            self.chartView.leftAxis.axisMinimum = Double(highAndLow.1 - 50)
            set1.circleRadius = 2
            set1.valueColors = [UIColor.white]
            set1.lineWidth = 2
            self.chartView.xAxis.axisLineWidth = 0
            self.chartView.animate(xAxisDuration: 3)
        }
        
        // IMPLEMENT STOCK NAME & TICKER
        self.title = "\(indyCompany.title)"
        
        
        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        // x-axis limit line
        let llXAxis = ChartLimitLine(limit: 10, label: "Index 10")
        // llXAxis.lineWidth = 4
        llXAxis.lineDashLengths = [10, 10, 0]
        llXAxis.labelPosition = .rightBottom
        llXAxis.valueFont = .systemFont(ofSize: 10)
        
        //DESTROY GRID
        chartView.xAxis.drawGridLinesEnabled = false
        
        //GRID LINES
        
        //chartView.xAxis.gridLineDashLengths = [10, 10]
        //chartView.xAxis.gridLineDashPhase = 0
        chartView.xAxis.drawLabelsEnabled = false
        
        //UPPER AND LOWER BOUND LINES
        
        /*let ll1 = ChartLimitLine(limit: 150, label: "Upper Limit")
        ll1.lineWidth = 4
        ll1.lineDashLengths = [5, 5]
        ll1.labelPosition = .rightTop
        ll1.valueFont = .systemFont(ofSize: 10)
        
        let ll2 = ChartLimitLine(limit: -30, label: "Lower Limit")
        ll2.lineWidth = 4
        ll2.lineDashLengths = [5,5]
        ll2.labelPosition = .rightBottom
        ll2.valueFont = .systemFont(ofSize: 10)
        */
        
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        //leftAxis.addLimitLine(ll1)
        //leftAxis.addLimitLine(ll2)
        
        
        
        //leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        chartView.rightAxis.enabled = false
        
        chartView.legend.form = .line
        
        //chartView.animate(xAxisDuration: 3)
        
        // DESTROY GRID LINES
        leftAxis.drawGridLinesEnabled = false
        
        
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        NSLog("chartValueSelected");
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        NSLog("chartValueNothingSelected");
    }
    
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        
    }
    
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
extension CompareViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //    TODO: SWITCH STATEMENT
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SegmentedControlTableViewCell") as! SegmentedControlTableViewCell
              return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GraphTableViewCell") as! GraphTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComparePriceTableViewCell") as! ComparePriceTableViewCell
            cell.firstCompatitor.text = "$242.93"
            cell.secondCompatitor.text = "$141.58"
            return cell
        }
    }
}

extension CompareViewController: UITableViewDelegate {
    
}

extension CompareViewController {
    //Get (high, low)
    func getHighLow(entries: [Entry])->(Int,Int){
        var high:Double = 0
        var low:Double = 0
         for index in (entries.count - 30) ..< entries.count {
            if let number = Double(entries[index].high){
                if  number > high {
                    high = number
                }
                if low == 0 {
                    low = number
                }else if number < low {
                    low = number
                }
            }
        }
        return (Int(high),Int(low))
    }
}
