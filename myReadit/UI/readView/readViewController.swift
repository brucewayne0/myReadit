//
//  ReadViewController.swift
//  myReadit
//
//  Created by 江南 on 2017/11/25.
//  Copyright © 2017年 cn.edu.nju. All rights reserved.
//

import UIKit
import os.log

protocol readViewDelegate {
    func setLocation(_ Location:NSRange)
    func addKeyword(_ Key:String)
    func addMark(_ range: NSRange)
    func getBook()->Book
   
    
}
@IBDesignable
class ReadViewController: UIViewController,readViewDelegate {

  
    @IBOutlet weak var BookName: UILabel!
    var book:Book?//书籍
    var list=[StatisticNode]()
    @IBOutlet weak var content: ContentView!
    
    //菜单
    //content.contentOffset
    @IBOutlet weak var topMenu: topView!
    @IBOutlet weak var bottomMenu: bottomView!
    @IBOutlet weak var topName: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var backButton: UIButton!
    
    var delegate:bookshelfViewDelegate!
    var menuIsHidden=true
    var fontSize=20
    var currentLine=0
    var isNight=false
    @IBOutlet var backGround: UIView!
    
    var menuController:UIMenuController!
    
    var dayTextColor: UIColor!
    var dayBackColor: UIColor!
    
    var beginDate :NSDate!
    
    /// 底部状态栏
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContent(book)//初始化书籍内容
        
        loadSubviews()//状态栏初始化,其他子窗口初始化
        loadReadSettings(book)//初始化阅读进度，书签，笔记，关键词等
        slider.setValue(Float((book?.PreviousProgress)!), animated: false)
        content.scrollRangeToVisible(NSMakeRange(Int((book?.PreviousProgress)!), 1) )
        content.scrollRangeToVisible(NSMakeRange(Int((book?.PreviousProgress)!), 1) )
        beginDate=NSDate()
     
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
    
    
    
    
    @IBAction func setMenu(_ sender: Any) {
        menuIsHidden = !menuIsHidden
        hideMenu(menuIsHidden);
    }
    
    @IBAction func setLightType(_ sender: Any) {
        isNight = !isNight
        setLightType(isNight)
    }
    
    func hideMenu(_ hide:Bool)
    {
        topMenu.isHidden=hide
        bottomMenu.isHidden=hide
     
    }
    
    func loadSubviews()
    {
        slider.minimumValue=0
        slider.maximumValue=Float(content.attributedText.length)
        dayBackColor=backGround.backgroundColor
        dayTextColor=content.textColor
        content.isEditable=false//关闭键盘
        slider.isContinuous = false
        BookName.text=book!.name
        topName.text=book!.name
        menuIsHidden=true
        hideMenu(true)
        content.readDelegate=self
        topMenu.layer.shadowOffset=CGSize(width: 0, height: 1)
        topMenu.layer.shadowRadius=7
        topMenu.layer.shadowColor=UIColor.gray.cgColor
        topMenu.layer.shadowOpacity = 0.5
       
    
        bottomMenu.layer.shadowOffset=CGSize(width: 1, height: -1)
        bottomMenu.layer.shadowRadius=7
        bottomMenu.layer.shadowColor=UIColor.gray.cgColor
        bottomMenu.layer.shadowOpacity = 0.5
        
    }
    override var canBecomeFirstResponder: Bool{
        get{
            return true
        }
    }
    func loadReadSettings(_ book:Book!)
    {
        
        currentLine=book.currentLine
        slider.value=Float(currentLine)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    func loadContent(_ book: Book!)
    {
        
        let bookurl = Bundle.main.url (forResource: book!.name, withExtension: "txt",subdirectory: "books")
   
        let contents = EncodeURL(bookurl!)
        let paraph = NSMutableParagraphStyle()
        //将行间距设置为28
        paraph.lineSpacing = 17
        //样式属性集合
        let attributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(fontSize)),
                          NSAttributedStringKey.paragraphStyle: paraph]
    content.attributedText=NSAttributedString(string: contents, attributes: attributes)
     
        ChapterParse(contents,book)
        book.length=Float(contents.length)
      
     
   //     content.attributedText = NSAttributedString(string: str, attributes: attributes)
        //恢复高亮
         let attributedString = content.attributedText.mutableCopy() as!  NSMutableAttributedString
        
        for  mark in book.markList
        {
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.brown , range: mark.Range)
          
        }
        content.attributedText=attributedString
        
    }
    
    func setLightType(_ isNight: Bool)
    {
        if (isNight)
        {
            content.textColor=UIColor.gray
            backGround.backgroundColor=UIColor.black
        }
        else
        {
            content.textColor=dayTextColor
            backGround.backgroundColor=dayBackColor
        }
    }
    
    @IBAction func backToList(_ sender: Any) {
       
        book?.PreviousProgress=slider.value
        delegate.saveBooks()
      
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        let endDate = NSDate()
        dateFormatter.dateStyle = DateFormatter.Style.full
        let beginStr = dateFormatter.string(from: beginDate as Date)
        //let endStr=dateFormatter.string(from: endDate as Date)
        let second = endDate.timeIntervalSince(beginDate as Date)
     
        var isadd=false
      
        for i in list{
            let str=dateFormatter.string(from: i.date as Date)
            if (str==beginStr)
            {
                isadd=true
                i.time = i.time+Int(second)
            }
            
        }
        if (!isadd)
        {
           // print("here")
            let node=StatisticNode(Int(second),beginDate)
            list.append(node!)
        }
     //    print(beginDate)
   
        saveList()
       
        
        
        self.dismiss(animated: true,completion: nil)
       
    }
    
    @IBAction func fontPlus(_ sender: Any) {
        if fontSize<30
        {
            fontSize=fontSize+1;
            content.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "OpenTab":
            guard let tabBarController = segue.destination as? menuTabBarController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            tabBarController.book=book
            tabBarController.readDelegate=self
        case "ShowNote":
            guard let noteController = segue.destination as? noteViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
          
            noteController.book=book
        default:
            fatalError("Unexpected Segue Identifier")
        }
        
    }
    @IBAction func fontMinus(_ sender: Any) {
        if fontSize>15
        {
            fontSize=fontSize-1;
            content.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        }
    }
    
    @IBAction func sliderJump(_ sender: Any) {
      
        content.scrollRangeToVisible(NSMakeRange(Int(slider.value), 1) )
      
        
    }
    
    
    func setLocation(_ Location:NSRange)
    {
        let location=Location.location
     
        hideMenu(true)
        content.scrollRangeToVisible(NSMakeRange(location, 70))
        content.scrollRangeToVisible(NSMakeRange(location, 70))
        slider.setValue(Float(location), animated: false)
        
      
    }
    func addKeyword(_ Key:String){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "kwDetailController") as? kwDetailViewController
        
        vc?.key=Key
        vc?.book=book
        vc?.isAdd=true
        self.present(vc!, animated: true)
    }
    func addMark(_ range: NSRange) {
       
        let mark=MarkNode(self.content.attributedText.string.substring(range),range)
        book?.markList.append(mark!)
    }
    func getBook() -> Book {
        return book!
    }
  
    func saveList() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(list, toFile: StatisticNode.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("List successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save list...", log: OSLog.default, type: .error)
        }
    }
 
}

