//
//  News.swift
//  StockApp
//
//  Created by Robert Wais on 7/17/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import Foundation


struct News {
    
//    "title":"When Will This Stock Market Bubble Burst in Our Faces? Not Anytime Soon.",
//    "pubDate":"2018-07-17 15:06:07",
//    "link":"https://finance.yahoo.com/news/stock-market-bubble-burst-faces-150607862.html?.tsrc=rss",
//    "guid":"82913fa4-7b53-30e3-8dba-1beaa29e8667",
//    "author":"",
//    "thumbnail":"",
//    "description":"Never let it be said former Republican Congressman Ron Paul doesn\u2019t have a knack for theatrics.  Just for the record, however, this is a warning bell Ron Paul has been ringing since 2014 \u2014 and really, before that \u2014 and so far it has not happened.  With Q2 earnings projected to rise a hefty 26.7% year-over-year and with expectations of Q2 GDP growth rate in excess of 4%, it seems unlikely the market, and the economy itself, are more vulnerable now than they were then.",
//    "content":"Never let it be said former Republican Congressman Ron Paul doesn\u2019t have a knack for theatrics.  Just for the record, however, this is a warning bell Ron Paul has been ringing since 2014 \u2014 and really, before that \u2014 and so far it has not happened.  With Q2 earnings projected to rise a hefty 26.7% year-over-year and with expectations of Q2 GDP gro
//
    init(dict: [String: Any]) {
        self._title = dict["title"] as? String
        self._pubDate = dict["pubDate"] as? String
        self._description = dict["description"] as? String
        self._content = dict["content"] as? String
    }
    
    var _title: String?
    var _pubDate: String?
    var _description: String?
    var _content: String?
    
    var title: String {
        guard let title = _title else {
            print("ERROR")
            return ""
        }
        return title
    }
    var pubDate: String {
        guard let pubDate = _pubDate else {
            print("ERROR")
            return ""
        }
        return pubDate
    }
    
    var description: String {
        guard let desc = _description else {
            print("ERROR")
            return ""
        }
        return desc
    }
    
    var content: String {
        guard let content = _content else {
            print("ERROR")
            return ""
        }
        return content
    }
}
