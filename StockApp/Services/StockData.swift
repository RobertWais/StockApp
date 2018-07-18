//
//  StockData.swift
//  StockApp
//
//  Created by Robert Wais on 7/16/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import Foundation
import Alamofire

struct StockData {
    
    static func getStockTime(timeSlot: String, symbol: String, completion: @escaping ([Entry])->()){
        Alamofire.request(Constants.getData(timeSlot: timeSlot, symbol: symbol )).validate().responseJSON () { (data) in
            var tempArr = [Entry]()
            print("Ethan Canada Dry")
            //Cast result to a Dictionary
            let result = data.result.value as! [String: Any]
            
            guard let dict = result["Weekly Time Series"] as? [String: Any] else {
                print("Could not retrieve timestamp")
                return
            }
            for dic in dict {
                guard let date = stringToDate(string: dic.key),
                    let tempValue = dic.value as? [String: Any] else{
                    print("Could not retrieve Date")
                    return
                }
                tempArr.append(Entry(dict: tempValue, timeStamp: date))
            }
            completion(Entry.getSorted(array: tempArr))
            //Testing Purposes
//            for temp in tempArr {
//                print(temp.printStuff())
//            }
        }
    }
    
    static func stockNews() {
        Alamofire.request(Constants.getNewsString(symbol: "AAPL")).validate().responseJSON { (data) in
            let result = data.result.value as! [String: Any]
            
            guard let items = result["items"] as? Array<Dictionary<String,Any>> else {
                print("NOOOOs")
                return
            }
            
            for item in items{
                print("Item: \(item)")
            }
            //print("result: \(result)")
        }
    }
    
    
}

extension StockData {
    static func stringToDate(string: String )->(Date?){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let date = dateFormatter.date(from: string)
        return date
    }
}
