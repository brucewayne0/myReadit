//
//  BookmarkViewController.swift
//  myReadit
//
//  Created by 江南 on 2017/11/29.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import UIKit
protocol tableDelegate {
    func remove(at : Int)
    
}
class bookmarkViewController: baseViewController ,tableDelegate{

    
    @IBOutlet weak var bookmarkTable: UITableView!
    var isEdit=true
    var bkList=[MarkNode]()
    override func viewDidLoad() {
        super.viewDidLoad()
        bkList=delegate.getBook().markList
        bookmarkTable.dataSource = self
        self.bookmarkTable.rowHeight=CGFloat(80)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Edit(_ sender: Any) {
        for i in (bookmarkTable.visibleCells as? [bkTableViewCell])!
        {
            i.DeleteButtom.isHidden = !isEdit
        }
        isEdit = !isEdit
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
extension bookmarkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bkList=delegate.getBook().markList
    //    print(bkList.count)
        return bkList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let bk = bkList[indexPath.row]
        let bkcell = tableView.dequeueReusableCell(withIdentifier: "bkCell", for: indexPath) as! bkTableViewCell
        bkcell.Content.text=bk.Content
        bkcell.Progress.text=String(format: "%.1f", Float(bk.Range.lowerBound)/delegate.getBook().length*100)+"%" 
        bkcell.Location=bk.Range
        bkcell.baseDelegate=self
        bkcell.DeleteButtom.isHidden=true
        bkcell.tableDelegate=self
        bkcell.index=indexPath.row
        
        return bkcell
}
    func remove(at : Int)
    {
     
        bookmarkTable.deleteRows(at:[IndexPath(row: at, section: 0)], with: .fade)
      
    }
}
