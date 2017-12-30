//
//  kwDetailViewController.swift
//  myReadit
//
//  Created by 江南 on 2017/11/30.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import UIKit

class kwDetailViewController: UIViewController {

    @IBOutlet weak var keyword: UILabel!
    @IBOutlet weak var Description: UITextView!
    var key:String?
    var book:Book?
    var isAdd=false
    var node:KeyNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if (!isAdd)//补充内容
        {
            keyword.text=node?.Key
            Description.text=node?.Description
        }
        else
        {
            keyword.text=key!
        }
        
        // Do any additional setup after loading the view.
    }

    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true,completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        let newnode=KeyNode(key!,Description.text)
    //    newnode.complete(key:key,des:Description.text)
        if(isAdd){
            book?.keywordList.append(newnode!)
            isAdd=false
            
        }
        else{
            node?.Description=Description.text
        }
       // self.dismiss(animated: true,completion: nil)
        //Description.text="Saved"
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
