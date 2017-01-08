//
//  ViewController.swift
//  BookMark
//
//  Created by CuGi on 2017/1/8.
//  Copyright © 2017年 Cu. All rights reserved.
//  Test commit

import UIKit
import DKCamera

class ViewController: UIViewController {
    var imageFormCamera: UIImage?
    
    var isFirst: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isFirst {
            return
        }
        
        isFirst = false
        
        let camera = DKCamera()
        
        camera.didCancel = { () in
            print("didCancel")
            
            self.dismiss(animated: true, completion: nil)
        }
        
        camera.didFinishCapturingImage = {(image: UIImage) in
            print("didFinishCapturingImage")
            print(image)
            
            //            showImageSegue
            
            self.imageFormCamera = image
            
            self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "showImageSegue", sender: nil)
        }
        self.present(camera, animated: true, completion: nil)
        
        //        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
        //            var imagePicker = UIImagePickerController()
        //            //            imagePicker.delegate = self
        //            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
        //            imagePicker.allowsEditing = false
        //            self.present(imagePicker, animated: true, completion: nil)
        //        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //get destination controller
        
        
        guard let destViewController = segue.destination as? MaskViewController else{
            //先讓App Crash
            fatalError()
        }
        
        destViewController.imageFile = imageFormCamera
        
        //            let station = Station()
        //            station.convertJsonToObject(dataArray[tableviewCellIndoxPath.row])
        
        //            destViewController.station = station
        //
        //            //隱藏Tabbar 的View
        //            destViewController.hidesBottomBarWhenPushed = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

