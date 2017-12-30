//
//  keywordViewController.swift
//  myReadit
//
//  Created by 江南 on 2017/11/28.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import UIKit

class keywordViewController: baseViewController ,tableDelegate{

   
    @IBOutlet weak var keywordTable: UITableView!
    var kwList=[KeyNode]()
    var isEdit=true
    override func viewDidLoad() {
        super.viewDidLoad()
        kwList=delegate.getBook().keywordList
        keywordTable.dataSource = self
       // keywordTable.contro
        // Do any additional setup after loading the view.
    }
    @IBAction func Edit(_ sender: Any) {
        for i in (keywordTable.visibleCells as? [kwTableViewCell])!
        {
            i.DeleteButtom.isHidden = !isEdit
        }
        isEdit = !isEdit
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
    
    func remove(at : Int)
    {
        
        keywordTable.deleteRows(at:[IndexPath(row: at, section: 0)], with: .fade)
        
    }

}

extension keywordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        kwList=delegate.getBook().keywordList
        return kwList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "kwCell", for: indexPath) as! kwTableViewCell
        cell.Keyword.text=kwList[indexPath.row].Key
        cell.node=kwList[indexPath.row]
        cell.index=indexPath.row
        cell.tableDelegate=self
        cell.DeleteButtom.isHidden=true
        cell.baseDelegate=self
        
        return cell
    }
}

