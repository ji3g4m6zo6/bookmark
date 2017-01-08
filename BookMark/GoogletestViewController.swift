//
//  googletestViewController.swift
//  BookMark
//
//  Created by CuGi on 2017/1/8.
//  Copyright © 2017年 Cu. All rights reserved.
//

import UIKit

class GoogletestViewController: UIViewController {
    
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
                        "type": "LABEL_DETECTION",
                        "maxResults": 1
                    ],
                    [
                        "type": "LOGO_DETECTION",
                        "maxResults": 1
                    ],
                    [
                        "type": "TEXT_DETECTION",
                        "maxResults": 1
                    ]
                ]
            ]
        ]
        
        // Serialize the JSON
        request.httpBody = try! JSONSerialization.data(withJSONObject: jsonRequest, options: [])
        
        // Run the request on a background thread
//        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0).asynchronously(execute: {
////            self.runRequestOnBackgroundThread(request)
//        });
        
    }


}
