//
//  CityViewController.swift
//  ForecastIO
//
//  Created by Subodh Sah on 11/25/15.
//  Copyright © 2015 Subodh Sah. All rights reserved.
//

import UIKit
import Social

  // var temp: [Float]!

class CityViewController: UIViewController , FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherconditionLbl: UILabel!
    @IBOutlet weak var tempretureLbl: UILabel!
    @IBOutlet weak var PrecipitationLbl: UILabel!
    @IBOutlet weak var corLbl: UILabel!
    @IBOutlet weak var wsLbl: UILabel!
    @IBOutlet weak var dpLbl: UILabel!
    @IBOutlet weak var humLbl: UILabel!
    @IBOutlet weak var visLbl: UILabel!
    @IBOutlet weak var srLbl: UILabel!
    @IBOutlet weak var ssLbl: UILabel!
    @IBOutlet weak var hlLbl: UILabel!
    @IBOutlet weak var cityscrollview: UIScrollView!
    
    
    @IBOutlet weak var fbButton: FBSDKLoginButton!

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        var temp1:[Float] = []
        var timestr1:[String] = []
        var summary1:[String] = []
        var weektimestr1:[String] = []
        var monthday1:[String] = []
        var weekmintemp1:[Float] = []
        var weekmaxtemp1:[Float] = []
        var weekicon1:[String] = []
        
        
        ArrayData.temp = []
        ArrayData.timestr = []
        ArrayData.summary = []
        ArrayData.weektimestr = []
        ArrayData.monthday = []
        ArrayData.weekmintemp = []
        ArrayData.weekmaxtemp = []
        ArrayData.weekicon = []
        
        //ArrayObject.temp:[Float] = []
        
        print("in here CityViewController1")
        
        if let parseJSON = ResultData.myJSON {
            // Now we can access value of elements by its key
            let weather_condition = parseJSON["weather_condition"] as! String
            let icon = parseJSON["icon"] as! String
            let temperature = parseJSON["temperature"] as! Float
            let precipIntensitystr = parseJSON["precipIntensitystr"] as! String
            let precipProbabilityper = parseJSON["precipProbabilityper"] as! Float
            let windSpeed = parseJSON["windSpeed"] as! Float
            let dewPoint = parseJSON["dewPoint"] as! Float
            let humidityper = parseJSON["humidityper"] as! Float
            let visibility = parseJSON["visibility"] as! Float
            let sunriseTimestr = parseJSON["sunriseTimestr"] as! String
            let sunsetTimestr = parseJSON["sunsetTimestr"] as! String
            let temperatureMax = parseJSON["temperatureMax"] as! Float
            let temperatureMin = parseJSON["temperatureMin"] as! Float
            
           for i in 0...47
            {
                temp1.append((parseJSON["temp"]!![i] as! Float))
                timestr1.append(parseJSON["timestr"]!![i] as! String)
                summary1.append(parseJSON["summary"]!![i] as! String)
            }
            
            for j in 0...6
            {
                weektimestr1.append((parseJSON["weektimestr"]!![j] as! String))
                monthday1.append(parseJSON["monthday"]!![j] as! String)
                weekmintemp1.append(parseJSON["weekmintemp"]!![j] as! Float)
                weekmaxtemp1.append(parseJSON["weekmaxtemp"]!![j] as! Float)
                weekicon1.append(parseJSON["weekicon"]!![j] as! String)
            }

            ArrayData.temp = temp1;
            ArrayData.timestr = timestr1;
            ArrayData.summary = summary1;
            ArrayData.weektimestr = weektimestr1;
            ArrayData.monthday = monthday1;
            ArrayData.weekmintemp = weekmintemp1;
            ArrayData.weekmaxtemp = weekmaxtemp1;
            ArrayData.weekicon = weekicon1;

            ResultData.image = icon;
            
            if icon == "clear-day"
            {
                weatherImage.image = UIImage(named: "clear.png")
            }
            else if icon == "clear-night"
            {
                weatherImage.image = UIImage(named: "clear_night.png")
            }
            else if icon == "rain"
            {
                weatherImage.image = UIImage(named: "rain.png")
            }
            else if icon == "snow"
            {
                weatherImage.image = UIImage(named: "snow.png")
            }
            else if icon == "sleet"
            {
                weatherImage.image = UIImage(named: "sleet.png")
            }
            else if icon == "wind"
            {
                weatherImage.image = UIImage(named: "wind.png")
            }
            else if icon == "fog"
            {
                weatherImage.image = UIImage(named: "fog.png")
            }
            else if icon == "cloudy"
            {
                weatherImage.image = UIImage(named: "cloudy.png")
            }
            else if icon == "partly-cloudy-day"
            {
                weatherImage.image = UIImage(named: "cloud_day.png")
            }
            else if icon == "partly-cloudy-night"
            {
                weatherImage.image = UIImage(named: "cloud_night.png")
            }
            
            self.weatherconditionLbl.text = weather_condition + " in " + ResultData.city+","+ResultData.state
            self.PrecipitationLbl.text = precipIntensitystr
            self.corLbl.text = String(precipProbabilityper) + " %"

            self.humLbl.text = String(humidityper) + " %"

            
            
            if (ResultData.degree == "Farhenheit")
            {
                self.tempretureLbl.text = String(temperature) +  "\u{00B0} F"
                self.wsLbl.text = String(windSpeed) + " mph"
                self.dpLbl.text = String(dewPoint) +  "\u{00B0} F"
                self.visLbl.text = String(visibility) + " mi"
                self.hlLbl.text = "L: \(temperatureMin) \u{00B0} F  | H: \(temperatureMax) \u{00B0} F"
            }
            else
            {
                self.tempretureLbl.text = String(temperature) +  "\u{00B0} C"                
                self.wsLbl.text = String(windSpeed) + "m/sec"
                self.dpLbl.text = String(dewPoint) + "\u{00B0} C"
                self.visLbl.text = String(visibility) + " km"
                self.hlLbl.text = "L: \(temperatureMin) \u{00B0} C  | H: \(temperatureMax) \u{00B0} C"
            
            }

            self.srLbl.text = sunriseTimestr
            self.ssLbl.text = sunsetTimestr
           
        }

        
    }


    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("in here CityViewController")
        cityscrollview.contentSize.height = 600;
        
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            print("User is logged in")
        }
        else
        {
                print("User is not logged in")
        }
        
        fbButton.delegate=self
        fbButton.readPermissions = ["public_profile", "email", "user_friends"]
        
    }
    
    
    // Facebook Delegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            
            
            let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            vc.setInitialText("Current Weather in \(ResultData.city) , \(ResultData.state) : \(weatherconditionLbl.text!),\(tempretureLbl.text!) ")
            
            if ResultData.image == "clear-day"
            {
                vc.addImage(UIImage(named: "clear.png")!)
            }
            else if ResultData.image == "clear-night"
            {
                vc.addImage(UIImage(named: "clear_night.png")!)
            }
            else if ResultData.image == "rain"
            {
                vc.addImage(UIImage(named: "rain.png")!)
            }
            else if ResultData.image == "snow"
            {
                vc.addImage(UIImage(named: "snow.png")!)
            }
            else if ResultData.image == "sleet"
            {
                vc.addImage(UIImage(named: "sleet.png")!)
                
            }
            else if ResultData.image == "wind"
            {
                vc.addImage(UIImage(named: "wind.png")!)
            }
            else if ResultData.image == "fog"
            {
                vc.addImage(UIImage(named: "fog.png")!)
            }
            else if ResultData.image == "cloudy"
            {
                vc.addImage(UIImage(named: "cloudy.png")!)
            }
            else if ResultData.image == "partly-cloudy-day"
            {
               vc.addImage(UIImage(named: "cloud_day.png")!)
            }
            else if ResultData.image == "partly-cloudy-night"
            {
               vc.addImage(UIImage(named: "cloud_night.png")!)
            }
            
  
            vc.addURL(NSURL(string: "http://forecast.io"))

            presentViewController(vc, animated: true, completion: nil)
    
            
            var status = ""
            
            vc.completionHandler = {result -> Void in var
                r = result as SLComposeViewControllerResult
                switch(r.rawValue) {
                case SLComposeViewControllerResult.Cancelled.rawValue:
                    print("Cancelled") ;
                   // self.displayAlert("NOTE", body: "Cancelled");
                    status = "Cancelled";
                case SLComposeViewControllerResult.Done.rawValue:
                    print("Done");
                    //self.displayAlert("NOTE", body: "Posted");
                    status = "Done";
                default: print("Something went wrong") }
                self.dismissViewControllerAnimated(true, completion: nil) }
            
    
            if (status == "Done")
            {
                self.displayAlert("NOTE", body: "Posted");
            }else
            {
                self.displayAlert("NOTE", body: "Cancelled");
            }
            
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlert(head:String, body:String) {
        let alertController = UIAlertController(title: head, message: body, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) { }
    }


}
