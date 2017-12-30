//
//  bookshelfViewController.swift
//  myReadit
//
//  Created by 江南 on 2017/12/4.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import UIKit
import os.log
protocol bookshelfViewDelegate {
    func saveBooks()
    func saveList()
}

@IBDesignable
class bookshelfViewController: UIViewController,bookshelfViewDelegate{

    
    @IBOutlet weak var bookList: UICollectionView!
    @IBOutlet weak var topLabel: UILabel!
    var booklist:[Book]?
    var list:[StatisticNode]?// 统计信息
    var stasticsVC:StatisticsViewController?
    
    @IBOutlet weak var recordsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.isHidden=true
        let label1=UILabel(frame: CGRect(x: -270, y: 300, width: 700, height: 130))
        label1.text="BOOKSHELF"
        self.view .addSubview(label1)
        label1.transform=CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        label1.font=topLabel.font
        label1.textColor=topLabel.textColor
        self.view.bringSubview(toFront: recordsBtn)
        
        list=loadList()
        booklist = loadBooks()//读取已存取数据
        loadBookLists()//  直接刷新
        if (booklist == nil)
        {
            booklist=[Book]()
        }
        
   
        if (list == nil)
        {
            list=[StatisticNode]()
            saveList()
        }
        bookList.dataSource=self
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeGesture))
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.left //不设置是右
        self.view.addGestureRecognizer(swipeLeftGesture)
       
      
        // Do any additional setup after loading the view.
        
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "EnterBook":
            guard let readViewController = segue.destination as? ReadViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            readViewController.delegate=self
            guard let selectedBookCell = sender as? bookshelfCollectionViewCell else {
                fatalError("Unexpected sender: \(segue.destination)")
            
            }
            
            guard let indexPath = bookList.indexPath(for: selectedBookCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedBook = booklist![indexPath.row]
            readViewController.book = selectedBook
            readViewController.list=self.list!
        case "StasticsView":do {
            guard let statisticVC = segue.destination as? StatisticsViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
          
           
            list=loadList()//确保每次点开都为最新纪录
            if(list==nil){
                print("empty")
                list=[StatisticNode]()
                saveList()
                
            }
            statisticVC.delegate=self
            statisticVC.list=self.list
            }
        default:
            fatalError("Unexpected Segue Identifier: \(segue.destination)")
           
        }
        
    }
    
    
    @objc func handleSwipeGesture()
    {
        loadBookLists()
        bookList.reloadData()
        
    }
    private func loadBookLists() {
        if (booklist == nil)
        {
            booklist=[Book]()
        }
        //遍历文件夹
        let bundlePath = Bundle.main.bundlePath
        let audiosPath = bundlePath+"/books/"
        let fileManager = FileManager.default
        let enumerator:FileManager.DirectoryEnumerator! = fileManager.enumerator(atPath: audiosPath)
        var bookname=[String]()
        while let element = enumerator?.nextObject() as? String {
            if element.hasSuffix("txt") {
                //文本文件
                let cover1=UIImage(named: "bottom")
                var name=element
                let range: Range<String.Index> = name.range(of: ".txt")!
                name.removeSubrange(range)
                bookname.append(name)
                var new=true//判断是否已存在
                
                for i in booklist!
                {
                    
                    if (i.name==name)
                    {
                        new=false
                        break;
                    }
                    
                }
                if (new)
                {
                let book1=Book(name,cover1,currentLine:10,PreviousProgress:0.1,Note:"",length:Float(1.1),chapterList:[ChapterNode](),markList:[MarkNode](),keywordList:[KeyNode]())
                //模拟List生成
                booklist?.append (book1!)
                }
            }
        }
        //删除不存在的书
 
        var deletelist=[Int]()
        for i in  0 ..< booklist!.count{
       // for i in   booklist!{
            var toRemove=true
            for name in bookname
            {
                if (name==booklist![i].name){
                    toRemove=false
                }
            }
            if(toRemove){
                
                deletelist.append(i)
          
            }
        }
        var count=0;
        for i in  deletelist{
            
            booklist?.remove(at: i-count)
            count=count+1
        }
        
        
        
    }
    func saveBooks() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(booklist ?? [Book](), toFile: Book.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Books successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save books...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadBooks() -> [Book]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Book.ArchiveURL.path) as? [Book]
    }
    
    func saveList() {
       
           let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(list ?? [StatisticNode](), toFile: StatisticNode.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("List successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save list...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadList() -> [StatisticNode]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: StatisticNode.ArchiveURL.path) as? [StatisticNode]
    }
    
    @IBAction func reload(_ sender: Any) {
      
        performSegue(withIdentifier: "StasticsView", sender: " ")
       
        
    }
}

extension bookshelfViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
      
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(booklist==nil){
            booklist=[Book]()}
        return booklist!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath)as! bookshelfCollectionViewCell
        
        let book=booklist![indexPath.row]
      
        cell.cover.isHidden=true
        cell.cover.image=book.cover
        cell.name.text=book.name
       
        cell.layer.cornerRadius=9
        cell.layer.masksToBounds=true
        cell.layer.shadowOffset=CGSize(width: 2, height: 2)
        cell.layer.shadowRadius=7
        cell.layer.shadowColor=UIColor.gray.cgColor
        cell.layer.shadowOpacity = 0.5
        
        return cell
    }
    
}
