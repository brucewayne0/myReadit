//
//  baseTableViewController.swift
//  myReadit
//
//  Created by 江南 on 2017/11/28.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import UIKit

protocol baseViewDelegate {
    func backToLocation(_ Location:NSRange)
    func showKeyword(_ node:KeyNode)
    func getbook()->Book
    
}
class baseViewController: UIViewController,baseViewDelegate {
    
    

    @IBOutlet weak var headBar: UIView!
    var delegate :tabBarDelegate!
    var readDelegate :readViewDelegate!
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        headBar.layer.shadowOffset=CGSize(width: 0, height: 1)
        headBar.layer.shadowRadius=7
        headBar.layer.shadowColor=UIColor.gray.cgColor
        headBar.layer.shadowOpacity = 0.5
       // delegate=
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backtoReading(_ sender: Any) {
        self.dismiss(animated: true,completion: nil)
      //  delegate?.backToReading();
    }
    func backToLocation(_ Location:NSRange)
    {
        
        readDelegate.setLocation(Location)
      //  print("back to Location ")
        self.dismiss(animated: true,completion: nil)
    }
    func showKeyword(_ node: KeyNode) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "kwDetailController") as? kwDetailViewController
        
        vc?.key=node.Key
        vc?.node=node
        vc?.isAdd=false
        self.present(vc!, animated: true)
    }
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    func getbook()->Book
    {
        return readDelegate.getBook()
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
