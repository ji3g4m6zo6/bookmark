//
//  BooklistViewController.swift
//  BookMark
//
//  Created by SHAO-HANG HUANG on 2017/1/8.
//  Copyright © 2017年 Cu. All rights reserved.
//

import UIKit
import BarcodeScanner

    // MARK: - FakeData

let bookDict1: [String:Any] = [ "name" : "booktitle1" , "ISBNcode" : "12345678", "pic" : "", "notesCount": 3 ]
let bookDict2: [String:Any] = [ "name" : "booktitle2" , "ISBNcode" : "23456789", "pic" : "", "notesCount": 12 ]
var allBookArray: [Any] = [bookDict1, bookDict2]

class BooklistViewController: UITableViewController, BarcodeScannerCodeDelegate {

    @IBAction func addBookButton(_ sender: UIButton) {
    
        //Camera
        //Barcode
        
        
        
        let controller = BarcodeScannerController()
        controller.codeDelegate = self
        
        navigationController?.pushViewController(controller, animated: true)
        
        alertForCreateAccount()
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allBookArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BooklistCell", for: indexPath) as! BooklistCustomCell

        if let currentBook = allBookArray[indexPath.row] as? NSDictionary {
            
            cell.bookNameLabel.text = currentBook.value(forKey: "name") as? String
            cell.ISBNCode.text = currentBook.value(forKey: "ISBNcode") as? String
            cell.numberOfNotes.text = currentBook.value(forKey: "notesCount") as? String
            
            
        } else {
            fatalError("book not found")
        }
        

        return cell
    }
    

       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func barcodeScanner(_ controller: BarcodeScannerController, didCaptureCode code: String, type: String) {
        print(code)
        controller.reset()
    }
    
    func alertForCreateAccount() {
        
        var booknameCreated: String = ""
        let bookISBNCreated: String = ""
        let bookImageCreated: String = ""
        
        
        let alert = UIAlertController(title: "Add new book", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: { action in
            
            let bookNameTextField = alert.textFields![0] as UITextField
            
            if let name = bookNameTextField.text {booknameCreated = name}
            
            if booknameCreated.isEmpty != true {
                
                let newBookDict: [String:Any] = [
                
                    "name" : booknameCreated,
                    "ISBNCode" : bookISBNCreated,
                    "pic" : bookImageCreated,
                    "notesCount" : 0
                ]
                
                allBookArray.append(newBookDict)
                
            } else {
                
                self.signupErrorAlert(title: "Oops!", message: "Title cannot be blank!")
                
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { action in
        }))
        
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter book name"
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }

    func signupErrorAlert(title: String, message: String) {
        
        // Called upon signup error to let the user know signup didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}
