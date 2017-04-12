//
//  ViewController.swift
//  uvAppDetector
//
//  Created by user125090 on 4/1/17.
//  Copyright © 2017 user125090. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet var zipInput: UITextField!
    @IBOutlet var jsondataLabel: UILabel!
    @IBOutlet var msgLabel: UILabel!
    @IBOutlet var skinDamageLabel: UILabel!
    
    
    @IBOutlet var precautionText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        zipInput.keyboardType = UIKeyboardType.numberPad
        precautionText.isEditable = false
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func zipBtn(_ sender: UIButton) {
        print("Checked ")
        getJSON(zipInput: Int(zipInput.text!)!);
        zipInput.resignFirstResponder()
            
    }
    
    
    
   
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  let  DestViewController : SecondViewController = segue.destination as! SecondViewController
       // DestViewController.LabelText  = "entered Text " + zipInput.text!
    //}
    
    
    
    func getJSON(zipInput : Int){
        
            let url = NSURL(string :"https://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVDAILY/ZIP/\(zipInput)/JSON")
            let request = URLRequest(url: url! as URL )
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: request){(data, response, error ) -> Void in
                if error == nil{
                    DispatchQueue.main.async(execute: {
                        let jsondata = JSON(data : data!)
                        print(jsondata)
                        print("-----")
                        
                        let result =  jsondata[0]["UV_INDEX"].stringValue
                        self.jsondataLabel.text = result
                        
                        
                        if Int(result)! >= 0 && Int(result)! <= 2{
                            self.msgLabel.text = "Low"
                            self.skinDamageLabel.text = "60 Mins"
                            self.precautionText.text = "\u{2022} Wear Sunglasses  \n  \u{2022} Wear 30+ SPF sunscreen "
                            
                            
                        }
                        
                        else if Int(result)! >= 3 && Int(result)! <= 5 {
                            self.msgLabel.text = "Moderate"
                            self.skinDamageLabel.text = "45 Mins"
                            self.precautionText.text = "\u{2022} Stay in shade  \n \u{2022} Wear a hat, UV blocking sungalsses, sun protective clothing  \n \u{2022} Wear 30+ sunscreen every 2 hours even on cloudy days"
                        }
                        else if Int(result)! >= 6 && Int(result)! <= 7{
                            self.msgLabel.text = "High"
                            self.skinDamageLabel.text = "30 Mins"
                            self.precautionText.text = "\u{2022}  Stay out of sun between 10AM - 4PM \n \u{2022} Stay in shade \n \u{2022} Wear a hat, UV blocking sungalsses, sun protective clothing  \n \u{2022} Wear 30+ sunscreen every 2 hours even on cloudy days"
                        }
                        
                        else if Int(result)! >= 8 && Int(result)! <= 10  {
                            self.msgLabel.text = "Very High"
                            self.skinDamageLabel.text = "15 Mins"
                            self.precautionText.text = "\u{2022}  Stay out of sun between 10AM - 4PM \n \u{2022} Stay in shade \n \u{2022} Wear a hat, UV blocking sungalsses, sun protective clothing  \n \u{2022} Wear 30+ sunscreen every 2 hours even on cloudy days"
                            
                        }
                        else if Int(result)! > 11 {
                            self.msgLabel.text = "Extreme"
                            self.skinDamageLabel.text = "< 10 Mins"
                            self.precautionText.text = "\u{2022}  Stay out of sun between 10AM - 4PM \n \u{2022} Stay in shade \n \u{2022} Wear a hat, UV blocking sungalsses, sun protective clothing  \n \u{2022} Wear 30+ sunscreen every 2 hours even on cloudy days"
                            
                        }
                        else {
                            self.msgLabel.text = "The UV Index value is not available"
                        }
                    })
                    
                    
                }else{
                    print("There was an error")
                }
                
                
                            }
            task.resume()
        
        
    }
   
}

