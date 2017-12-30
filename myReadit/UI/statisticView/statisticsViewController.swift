//
//  StatisticsViewController.swift
//  myReadit
//
//  Created by 江南 on 2017/12/4.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

   
    @IBOutlet weak var headBar: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var back: UIButton!
    var list:[StatisticNode]?
    var delegate:bookshelfViewDelegate!
    @IBAction func bacoToRead(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        headBar.layer.shadowOffset=CGSize(width: 0, height: 1)
        headBar.layer.shadowRadius=7
        headBar.layer.shadowColor=UIColor.gray.cgColor
        headBar.layer.shadowOpacity = 0.5
        tableView.dataSource=self
        
        self.tableView.rowHeight=CGFloat(130)
       
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     //   delegate.saveList()
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
   
    
}

extension StatisticsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if list==nil
        {
            list=[StatisticNode]()
        }
        return list!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let node = list![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticCell", for: indexPath) as! StatisticTableViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full
        cell.date.text=dateFormatter.string(from: node.date as Date)
        let time=node.time
     //   print(time)
        let t=time/3600
        let hour=String(format: "%02d", time/3600)+"："
        let minute=String(format: "%02d",time/60-t*60)+"："
        let ms=minute+String(format: "%02d",time%60)
        
        cell.time.text=hour+ms
        
        
        return cell
    }
    
}


