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
        static let companyCollectionView = "CompanyCollectionViewCell"
    }
    
    struct APICall {
        static let APIKey = "Y0FL3ZP4752EYZ9O"
        static let stockTimeLine = "here"
        static let weeklySlot = "TIME_SERIES_WEEKLY"
        static let monthlySlot = "TIME_SERIES_MONTHLY"
        static let converter =  "https://api.rss2json.com/v1/api.json?rss_url="
        static let newsFinance = "https://feeds.finance.yahoo.com/rss/2.0/headline?s="
        static let region = "&region=US&lang=en-US"
        
        
        //converter newsFinance \(ticker) region
//        https://feeds.finance.yahoo.com/rss/2.0/headline?s=ticker(s)&region=US&lang=en-US
        //Function is called to get the correct URL for Alamofire
        
    }
    static func getData(timeSlot: String,symbol: String)->(String){
        let returnString = "https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=\(symbol)&outputsize=100&apikey=\(APICall.APIKey)"
        return returnString
    }
    
    static func getNewsString(symbol: String)->(String){
        let returnString = "\(APICall.converter)\(APICall.newsFinance)\(symbol)\(APICall.region)"
        print("Return String: \(returnString)")
        return returnString
    }
    

}


