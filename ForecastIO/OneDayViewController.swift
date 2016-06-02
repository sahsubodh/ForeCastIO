//
//  OneDayViewController.swift
//  ForecastIO
//
//  Created by Subodh Sah on 11/25/15.
//  Copyright © 2015 Subodh Sah. All rights reserved.
//

import UIKit

class OneDayViewController: UIViewController {

    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dayscrollview: UIScrollView!
    
    
    var items: [String] = ["We", "Heart", "Swift"]
    var numofrows=24
    
    //var temp: [Float] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.contentSize.height = 100;
        dayscrollview.contentSize.height = 100;
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.cityLbl!.text = "More Details for \(ResultData.city),\(ResultData.state)"
        
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  numofrows;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DayDetailsCell") as! DayDetailsTableViewCell
        
        
        if(indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor.whiteColor()
        } else{
            cell.backgroundColor = UIColor.lightGrayColor()
        }
        
        
         cell.timeLbl!.text = String(ArrayData.timestr[indexPath.row])
        
        cell.tempLbl!.text = String(ArrayData.temp[indexPath.row])
        
        
        if ArrayData.summary[indexPath.row] == "clear-day"
        {
            cell.summaryImg.image = UIImage(named: "clear.png")
            
        }
        else if ArrayData.summary[indexPath.row] == "clear-night"
        {
            cell.summaryImg.image = UIImage(named: "clear_night.png")
            
        }
        else if ArrayData.summary[indexPath.row] == "rain"
        {
            cell.summaryImg.image = UIImage(named: "rain.png")
            
        }
        else if ArrayData.summary[indexPath.row] == "snow"
        {
            cell.summaryImg.image = UIImage(named: "snow.png")
            
        }
        else if ArrayData.summary[indexPath.row] == "sleet"
        {
            cell.summaryImg.image = UIImage(named: "sleet.png")
            
        }
        else if ArrayData.summary[indexPath.row] == "wind"
        {
            cell.summaryImg.image = UIImage(named: "wind.png")
            
        }
        else if ArrayData.summary[indexPath.row] == "fog"
        {
            cell.summaryImg.image = UIImage(named: "fog.png")
            
        }
        else if ArrayData.summary[indexPath.row] == "cloudy"
        {
            cell.summaryImg.image = UIImage(named: "cloudy.png")
            
        }
        else if ArrayData.summary[indexPath.row] == "partly-cloudy-day"
        {
            cell.summaryImg.image = UIImage(named: "cloud_day.png")
            
        }
        else if ArrayData.summary[indexPath.row] == "partly-cloudy-night"
        {
            cell.summaryImg.image = UIImage(named: "cloud_night.png")
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CustomHeaderCell
        headerCell.backgroundColor = UIColor.cyanColor();
        
        if (ResultData.degree == "Farhenheit")
        {
            
            headerCell.headerLabel.text = "Time                 Summary                 Temp\u{00B0} F";
        }
        else
        {
            headerCell.headerLabel.text = "Time                 Summary                 Temp\u{00B0} C";
        }
        
        
        return headerCell
    }

    
    @IBAction func PlusAction(sender: AnyObject) {
                //tableView.contentSize.height = 2000;
    //            dayscrollview.contentSize.height = 2000;
        
        numofrows = 48
        tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
