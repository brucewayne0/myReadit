//
//  menuTabBarController.swift
//  myReadit
//
//  Created by 江南 on 2017/11/28.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import UIKit

protocol tabBarDelegate {
    func backToReading()
    func getBook()->Book
}
class menuTabBarController: UITabBarController,tabBarDelegate {
   
    var book:Book!
    var readDelegate:readViewDelegate!
    func backToReading() {
        
        self.dismiss(animated: true,completion: nil)
    }
    func getBook()->Book
    {
        return book
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
      for i in 0..<self.childViewControllers.count
        {
            (childViewControllers[i] as? baseViewController)!.delegate=self//指定委托为自己
            (childViewControllers[i] as? baseViewController)!.readDelegate=readDelegate
        }
        
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "backToLocation1":
            guard let readViewController = segue.destination as? ReadViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedCell = sender as? chapterTableViewCell else {
                fatalError("Unexpected sender")
            }
            readViewController.setLocation(selectedCell.Location)
            self.dismiss(animated: true,completion: nil)
           
            
           
     
        default:
            do{
                
            }
            
        }
     
    }
    

}
