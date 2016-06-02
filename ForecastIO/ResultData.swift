//
//  ResultData.swift
//  ForecastIO
//
//  Created by Subodh Sah on 11/25/15.
//  Copyright © 2015 Subodh Sah. All rights reserved.
//

import Foundation
import UIKit

class ResultData: NSObject {

  static  var myJSON: AnyObject?
  static  var city:String!
   static var state:String!
   static var degree:String!
  static  var street:String!
  static  var image:String!
  //static  var temp:[Float] = []
 // static  var temp: [Float]!
    
    init(city:String,state:String,degree:String,street:String,image:String) {
////        self.city=city
////        self.state=state
////        self.degree=degree
////        self.street=street
    }
}

var resultVar = ResultData(city: "",state: "",degree:"",street:"",image:"");

