//
//  noteViewController.swift
//  myReadit
//
//  Created by 江南 on 2017/11/29.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import UIKit

class noteViewController: UIViewController {

   
    
    var book:Book!
    
    @IBOutlet weak var note: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        note.text=book.Note
        note.isEditable=true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true,completion: nil)
        
    }
    
    @IBAction func save(_ sender: Any) {
        book.Note=note.text
   //     delegate.savebooks()
       // note.text="Savedsjafkajgkrgkagklajgkajdgkagkdngkangkejatjaogjldml;a"
        
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
