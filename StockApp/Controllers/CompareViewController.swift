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

    @IBOutlet var chartView: LineChartView!
    @IBOutlet weak var tableView: UITableView!

   
   
    
    
    
    var company = Company(image: UIImage(named: "char_shadow")!, title: "Apple", ticker: "AAPL")
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
        
        StockData.getStockTime(timeSlot: Constants.APICall.monthlySlot, symbol: company.ticker) { (data) in
            print("\(data.count)")
            var count = data.count
            for index in (data.count - 30) ..< data.count {
                self.chartDataEntry.append(ChartDataEntry(x: Double(index), y: Double(data[index].high)!))
                
                print(data[index].timeFrame)
            }
            let set1 = LineChartDataSet(values: self.chartDataEntry, label: "DataSet 1")
            self.chartView.data = LineChartData(dataSet: set1)
        }
        
        // IMPLEMENT STOCK NAME & TICKER
        self.title = "\(company.title)"
        
        
        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        // x-axis limit line
        let llXAxis = ChartLimitLine(limit: 10, label: "Index 10")
        llXAxis.lineWidth = 4
        llXAxis.lineDashLengths = [10, 10, 0]
        llXAxis.labelPosition = .rightBottom
        llXAxis.valueFont = .systemFont(ofSize: 10)
        
        //DESTROY GRID
        chartView.xAxis.drawGridLinesEnabled = false
        
        //GRID LINES
        
        //chartView.xAxis.gridLineDashLengths = [10, 10]
        //chartView.xAxis.gridLineDashPhase = 0
        
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
        leftAxis.axisMaximum = 1000
        leftAxis.axisMinimum = -50
        
        //leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        chartView.rightAxis.enabled = false
        
        chartView.legend.form = .line
        
        chartView.animate(xAxisDuration: 2.5)
        
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
            cell.firstCompatitor.text = "$ 1,2 mil"
            cell.secondCompatitor.text = "$ 1,1 mil"
            return cell
        }
    }
}

extension CompareViewController: UITableViewDelegate {
    
}
