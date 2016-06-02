//
//  ArrayData.swift
//  ForecastIO
//
//  Created by Subodh Sah on 12/8/15.
//  Copyright © 2015 Subodh Sah. All rights reserved.
//

import UIKit

class ArrayData: NSObject {

    static var temp: [Float]!
    static var timestr: [String]!
    static var summary: [String]!
    static var weektimestr: [String]!
    static var monthday: [String]!
    static var weekmintemp: [Float]!
    static var weekmaxtemp: [Float]!
    static var weekicon: [String]!
    
    
    init(var temp: [Float],var timestr: [String],var summary: [String],var weektimestr : [String],
        var monthday : [String],var weekmintemp : [Float],var weekmaxtemp : [Float],var weekicon : [String]) {
        
        temp = []
        timestr = []
        summary = []
        weektimestr = []
        monthday = []
        weekmintemp = []
        weekmaxtemp = []
        weekicon = []
        
    }
    
}
  //var ArrayObject = ArrayData(temp:[]);