//
//  Constants.swift
//  StockApp
//
//  Created by Robert Wais on 7/16/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import Foundation

struct Constants {
    struct Segue {
        //FILL IN
    }
    
    struct UserDefaults {
        //FILL IN
    }
    
    struct CellIdentifiers {
        //FILL IN
    }
    
    struct APICall {
        static let APIKey = "Y0FL3ZP4752EYZ9O"
        static let stockTimeLine = "here"
        static let weeklySlot = "TIME_SERIES_WEEKLY"
        static let monthlySlot = "TIME_SERIES_MONTHLY"
        
        
        //Function is called to get the correct URL for Alamofire
        
    }
    static func getData(timeSlot: String,symbol: String)->(String){
        let returnString = "https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=\(symbol)&outputsize=100&apikey=\(APICall.APIKey)"
        
        print("Return string \(returnString)")
        return returnString
    }
    

}


