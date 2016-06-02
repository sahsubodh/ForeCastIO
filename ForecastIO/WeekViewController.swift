//
//  WeekViewController.swift
//  ForecastIO
//
//  Created by Subodh Sah on 12/9/15.
//  Copyright © 2015 Subodh Sah. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class WeekViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var weekscrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.rowHeight = 100
        weekscrollview.contentSize.height = 630;
        tableView.contentSize.height = 630;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  7;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("WeekDetailsCell") as! WeekTableViewCell
        
        
        if(indexPath.row == 0){
            cell.backgroundColor = UIColor.yellowColor()
        } else if(indexPath.row == 1){
            cell.backgroundColor = UIColor.blueColor()
        } else if(indexPath.row == 2){
            cell.backgroundColor = UIColor.cyanColor()
        } else if(indexPath.row == 3){
            cell.backgroundColor = UIColor.greenColor()
        } else if(indexPath.row == 4){
            cell.backgroundColor = UIColor.magentaColor()
        } else if(indexPath.row == 5){
            cell.backgroundColor = UIColor.redColor()
        }else if(indexPath.row == 6){
            cell.backgroundColor = UIColor.purpleColor()
        }
        
        
        
        cell.dayLbl!.text = "\(ArrayData.weektimestr[indexPath.row]) , \(ArrayData.monthday[indexPath.row])"
        
        cell.tempLbl!.text = "Min: \(String(ArrayData.weekmintemp[indexPath.row])) | Max: \(String(ArrayData.weekmaxtemp[indexPath.row]))"
        
        
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
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
