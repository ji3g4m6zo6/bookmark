//
//  MaskViewController.swift
//  BookMark
//
//  Created by CuGi on 2017/1/8.
//  Copyright © 2017年 Cu. All rights reserved.
//

import UIKit
//import

class MaskViewController: UIViewController, ImageMaskFilledDelegate{
    @IBOutlet weak var FengjieMask: ImageMaskView!
    @IBOutlet weak var uploadBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        FengjieMask.radius = 20;
        //        [FengjieMask beginInteraction];
        //        FengjieMask.imageMaskFilledDelegate = self;
        
        FengjieMask.radius = 20
        FengjieMask.beginInteraction()
        FengjieMask.imageMaskFilledDelegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func imageMaskView(_ maskView: ImageMaskView!, clearPercentDidChanged clearPercent: Float) {
        if clearPercent > 50 {
            UIView.animate(withDuration: 2, animations: {
                self.FengjieMask.isUserInteractionEnabled = false
                self.FengjieMask.alpha = 0
                self.FengjieMask.imageMaskFilledDelegate = nil
            })
        }
    }
    
    
    
    @IBAction func uploadAction(_ sender: UIButton) {
        
        //        print("ok")
        
        FengjieMask.alpha = 1
        uploadBtn.alpha = 0
        
        //        let screenShot = UIApplication.shared.screenShot!
        
        
        
        self.performSegue(withIdentifier: "toGoogleTest", sender: nil)
        //        self.performSegue(withIdentifier: "toGoogleTest", sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //get destination controller
        
        
        guard let destViewController = segue.destination as? GTViewController else{
            //先讓App Crash
            fatalError()
        }
        
        
        //        destViewController.receivedItemImageData =  UIImagePNGRepresentation(img) as NSData?
        
        var data:NSData = NSData()
        
        let img: UIImage = UIImage.init(view: self.view)
        data = (UIImagePNGRepresentation(img) as NSData?)!
        //        if let img = UIImage(named: "before") {
        //            data = (UIImagePNGRepresentation(img) as NSData?)!
        //        }
        
        destViewController.receivedItemImageData = data
        
        //            let station = Station()
        //            station.convertJsonToObject(dataArray[tableviewCellIndoxPath.row])
        
        //            destViewController.station = station
        //
        //            //隱藏Tabbar 的View
        //            destViewController.hidesBottomBarWhenPushed = true
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}

extension UIApplication {
    
    var screenShot: UIImage?  {
        
        let layer = keyWindow!.layer
        let scale = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return screenshot
    }
}
