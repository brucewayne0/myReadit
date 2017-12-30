//
//  chapterViewController.swift
//  myReadit
//
//  Created by 江南 on 2017/11/28.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import UIKit

class chapterViewController: baseViewController {

    
   
    @IBOutlet weak var chapterTableView: UITableView!
    var chapterList=[ChapterNode]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chapterList=delegate.getBook().chapterList
        chapterTableView.dataSource = self
      /*  headBar.layer.shadowOffset=CGSize(width: 0, height: 1)
        headBar.layer.shadowRadius=7
        headBar.layer.shadowColor=UIColor.gray.cgColor
        headBar.layer.shadowOpacity = 0.5*/
        
        
        // Do any additional setup after loading the view.
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
    
    


}

extension chapterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chapterList.count
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let chapter = chapterList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "chapterCell", for: indexPath) as! chapterTableViewCell
        cell.chapterName.text=chapter.Name
        cell.chapterProgress.text=String(format: "%.1f", chapter.Progress*100)+"%"
        cell.Location=chapter.Destination
        cell.baseDelegate=self
     
        
        return cell
    }
    
}

