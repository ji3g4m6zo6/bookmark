//
//  GTViewController.swift
//  BookMark
//
//  Created by CuGi on 2017/1/8.
//  Copyright © 2017年 Cu. All rights reserved.
//

import UIKit
import SwiftyJSON

class GTViewController: UIViewController {
    
    var imageData: String = ""
    var receivedItemImageData: NSData = NSData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // User discover new item -> Analyze image with cloud image
        let imageStringToBeAnalyze = receivedItemImageData.base64EncodedString(options: .endLineWithCarriageReturn)
        self.createRequest(imageData: imageStringToBeAnalyze)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    func createRequest(imageData: String) {
        
        let API_KEY: String = "AIzaSyAMs55t2wiarsD8wiAf0A0lVJTQbPQxyDw"
        //        if let path = NSBundle.mainBundle().pathForResource("Info", ofType: "plist"), dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
        //            // use swift dictionary as normal
        //            if let getKey = dict["CloudVisionKey"] {
        //                API_KEY = getKey as! String
        //            }
        //        }
        
        // Create our request URL
        let request = NSMutableURLRequest(
            url: NSURL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(API_KEY)")! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(
            Bundle.main.bundleIdentifier ?? "",
            forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        // Build our API request
        let jsonRequest: [String: Any] = [
            "requests": [
                "image": [
                    "content": imageData
                ],
                "features": [
                    [
                        "type": "TEXT_DETECTION",
                        "maxResults": 1
                    ]
                ]
            ]
        ]
        
        // Serialize the JSON
        request.httpBody = try! JSONSerialization.data(withJSONObject: jsonRequest, options: [])
        
        let session = URLSession.shared
        
        // run the request
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            //            self.analyzeResults(data!)
            
            
            
            
//            let a = JSONSerialization.jsonObject(with: data!, options: .MutableContainers)
//            print(data)
//            nsdataToJSON(data: data)
//            self.nsdataToJSON(data: data!)
            do {
                let a =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]
                
                
                let json = JSON(data: data!)
                let responses: JSON = json["responses"][0]
                
                 let logoAnnotations: JSON = responses["textAnnotations"]
                let str: String = logoAnnotations[0]["description"].stringValue
                print(str)
                // Get LOGO
//                let logoAnnotations: String = responses["textAnnotations"]["description"] as! String
//                print(logoAnnotations)
                
//                let responses = a?["responses"] as! [String: Any]
                
                
                // Get LOGO
//                let logoAnnotations: JSON = responses["logoAnnotations"]
                
            } catch let myJSONError {
                print(myJSONError)
            }
            
            
        })
        task.resume()
        
        // Run the request on a background thread
        //        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0).asynchronously(execute: {
        ////            self.runRequestOnBackgroundThread(request)
        //        });
        
    }
    
    
    // Convert from NSData to json object


//    func analyzeResults(dataToParse: NSData) {
//        
//        
//        
//        // Use SwiftyJSON to parse results
//        let json = JSON(data: dataToParse)
//        let errorObj: JSON = json["error"]
//        
//        // Check for errors
//        if (errorObj.dictionaryValue != [:]) {
//            self.detectedLogo = "Error code \(errorObj["code"]): \(errorObj["message"])"
//        } else {
//            // Parse the response
//            //print(json)
//            let responses: JSON = json["responses"][0]
//            
//            
//            // Get LOGO
//            let logoAnnotations: JSON = responses["logoAnnotations"]
//            let numLogos: Int = logoAnnotations.count
//            var logos: Array<String> = []
//            if numLogos > 0 {
//                var logoResultsText:String = ""
//                for index in 0..<numLogos {
//                    let logo = logoAnnotations[index]["description"].stringValue
//                    logos.append(logo)
//                    self.detectedLogo = logo
//                }
//                for logo in logos {
//                    // if it's not the last item add a comma
//                    if logos[logos.count - 1] != logo {
//                        logoResultsText += "\(logo), "
//                    } else {
//                        logoResultsText += "\(logo)"
//                    }
//                }
//                self.detectedLogo = logoResultsText
//            } else {
//                self.detectedLogo = "Please edit Logo"
//            }
//            
//        }
//        
//        // New one -> Load item with detected logo
//        self.spinnerUI.stopAnimating()
//        self.matchingStatus = .unMatch
//        self.infoLabel.text = "You found a new one!"
//        
//        self.moveToItemPage()
//        
//        
//    }
    
}
