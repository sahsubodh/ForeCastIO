//
//  ViewController.swift
//  ForecastIO
//
//  Created by Subodh Sah on 11/21/15.
//  Copyright © 2015 Subodh Sah. All rights reserved.
//

import UIKit



class ViewController: UIViewController ,UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var forecastLabel: UILabel!
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var degreePicker: UIPickerView!
    @IBOutlet weak var forecastLinkLabel: UILabel!
    @IBOutlet weak var streetText: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var validationText: UILabel!
    
    let gotoResult = "gotoResult"
    
    var stateVal = "Select"
    var degreeVal = "Farhenheit"
    
    var statepickerDataSource = ["Select","AL", "AK", "AZ", "AR","CA","CO","CT","DE","DC","FL","GA","HI",
    "ID", "IL", "IN", "IA","KS","KY","LA","ME","MD","MA","MI","MS","MO","MT","NE","NV",
    "NH", "NJ", "NM", "NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT",
    "VT", "VA", "WA", "WV","WI","WY" ];
    
    var degreepickerDataSource = ["Farhenheit", "Celsius"];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        forecastLabel.font = UIFont.boldSystemFontOfSize(20.0)
        
         statePicker.tag = 0
         degreePicker.tag = 1

        forecastLinkLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        
        
        self.statePicker.dataSource = self;
        self.statePicker.delegate = self;
        
        self.degreePicker.dataSource = self;
        self.degreePicker.delegate = self;
        
        
    }    
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    //State picker properties
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if (pickerView.tag == 0){
            return statepickerDataSource.count;
        }else{
            return degreepickerDataSource.count;
        }
        
        

    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        if (pickerView.tag == 0){
             ResultData.state = statepickerDataSource[row]
            return statepickerDataSource[row];
        }else{
            ResultData.degree = degreepickerDataSource[row];
            return degreepickerDataSource[row];
        }

    }
    
    //to check the state value on valdiation
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        if (pickerView.tag == 0){
        stateVal = statepickerDataSource[row]
        }else{
        degreeVal = degreepickerDataSource[row]
        }

    }

    
    @IBAction func clearButton(sender: AnyObject) {
        
        streetText.text = "";
        
        cityText.text = "";
        
        validationText.text = "";
        
        self.degreePicker.selectRow(0, inComponent: 0, animated: true)
        
        self.statePicker.selectRow(0, inComponent: 0, animated: true)
        
    }

    
    @IBAction func forecastClick(sender: AnyObject){
        UIApplication.sharedApplication().openURL(NSURL(string: "http://forecast.io")!)
        
    }
    
 
    @IBAction func validationResult(sender: AnyObject) {
        
        //input validation
        validationText.text = "";
        
        if streetText.text!.isEmpty || cityText.text!.isEmpty  ||  stateVal == "Select"     {
            
            var alertText = "Please enter" ;
            
            if (streetText.text!.isEmpty)
            {
                alertText += " a Street Address ";
            }
            if (cityText.text!.isEmpty)
            {
                alertText += " City";
            }
            if (stateVal == "Select")
            {
                alertText += " State";
            }

            validationText.text = alertText;

        }
        else{
            
            
            ResultData.city = cityText.text
            ResultData.street = streetText.text


            //resultVar = ResultData(city: cityText.text!,state: streetText.text!,degree:degreeVal,street:stateVal);
            
            
            
            let myUrl = NSURL(string: "http://cs-server.usc.edu:37926/phpServerApp.php/");
            let request = NSMutableURLRequest(URL:myUrl!);
            request.HTTPMethod = "POST";
            // Compose a query string
            
            let postString = "streetaddr=\(ResultData.street)&city=\(ResultData.city)&state=\(ResultData.state)&degree=\(ResultData.degree)";
            
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                if error != nil
                {
                    print("error= \(error)")
                    return
                }
                // You can print out response object
                print("response = \(response)")
                
                // Print out response body
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("responseString = \(responseString)")
                
                
                do {
                    ResultData.myJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                    
                } catch let error2 as NSError? {
                    print("error 2 \(error2)")
                }
                
            }
            
            
            
            task.resume()
            
            
            self.performSegueWithIdentifier(self.gotoResult, sender: nil)
            
        }


        
    }
    
    
}

