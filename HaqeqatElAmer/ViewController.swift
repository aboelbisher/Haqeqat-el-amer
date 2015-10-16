//
//  ViewController.swift
//  HaqeqatElAmer
//
//  Created by Muhammad on 10/16/15.
//  Copyright © 2015 Muhammad. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate
{
    var tableView = UITableView()
    var tableViewSize : ViewConfig?
    let CELL_NO_MEDIA_ID = "NoMediaID"
    let CELL_YES_MEDIA_ID = "YesMediaID"
    let CELL_NO_MEDIA_HEIGHT = CGFloat(100)
    let CELL_YES_MEDIA_HEIGHT = CGFloat(200)
    
    let SEPARATOR_HEIGHT = CGFloat(10)
    
    var newsArr = [News]()
    
    var lastIndex = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationBarCustomizations()
        self.bringNews(0)
        self.view.backgroundColor = UIColorFromRGB("#F4F4F4", alpha: 1)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func navigationBarCustomizations()
    {
        self.navigationItem.title = "حقيقة الأمر"
    }
    
    //MARK: init
    func preCalculations()
    {
        self.tableViewSize = ViewConfig(width: self.view.bounds.width * 0.9,
            height: self.view.bounds.height - self.navigationController!.navigationBar.frame.height - UIApplication.sharedApplication().statusBarFrame.height - CGFloat(5),
            upMargin: self.navigationController!.navigationBar.frame.height + UIApplication.sharedApplication().statusBarFrame.height + CGFloat(5),
            downMargin: 0, leftMargin: 0, rightMargin: 0)
    }
    
    func initSubViews()
    {
        self.initTableView()
    }

    
    //MARK: bring news
    func bringNews(index : Int)
    {
                
        makeRequestWithJsonArray("GET", api: NEWS_API + "/" + index.description,
            params: nil, values: nil) { (arr, dic) -> Void in
                for newsDic in arr
                {
                    let oneNews = News(newsDic: newsDic as! NSDictionary)
                    self.newsArr.append(oneNews)
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.preCalculations()
                    self.initSubViews()
                })
        }
    }
    
    
    //MARK: table view
    func initTableView()
    {
//        let frame = CGRect(x: 0, y: 0, width: self.tableViewSize!.width, height: self.tableViewSize!.height)
//        
//        self.tableView = UITableView(frame: frame)

        
        
        self.view.addSubview(self.tableView)
        setViewSizeConf(self.tableView, size: self.tableViewSize!)
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.tableView,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1, constant: -self.tableViewSize!.margin.up))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.tableView,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1, constant: 0))
        
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = UIColor.clearColor()
        
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let news = self.newsArr[indexPath.section]
        
        switch news.kind
        {
        case .NO_MEDIA:
            var cell = tableView.dequeueReusableCellWithIdentifier(self.CELL_NO_MEDIA_ID) as? NewsNoMediaTableViewCell
            if cell == nil
            {
                cell = NewsNoMediaTableViewCell(reuseId: self.CELL_NO_MEDIA_ID, width: self.tableViewSize!.width, height: self.CELL_NO_MEDIA_HEIGHT)
            }
            
            cell!.contentLbl.text = news.content
            
            addSeperatorsToView(cell!, width: self.tableViewSize!.width,
                height: self.CELL_NO_MEDIA_HEIGHT, up: true, down: true, left: true, right: true)

            return cell!

            
        case .YES_MEDIA:
//            var cell = tableView.dequeueReusableCellWithIdentifier(self.CELL_YES_MEDIA_ID) as? NewsYesMediaTableViewCell
//            
//            if cell == nil
//            {
            let cell = NewsYesMediaTableViewCell(news : news , width: self.tableViewSize!.width, height: self.CELL_YES_MEDIA_HEIGHT)
//            }
            cell.contentLbl.text = news.content
            
            addSeperatorsToView(cell,
                width: self.tableViewSize!.width,
                height: self.CELL_YES_MEDIA_HEIGHT,
                up: true, down: true, left: true, right: true)

            return cell
        }
        

    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let news = self.newsArr[indexPath.section]
        
        switch news.kind
        {
        case .NO_MEDIA:
            return self.CELL_NO_MEDIA_HEIGHT
            
        case .YES_MEDIA:
            return self.CELL_YES_MEDIA_HEIGHT
        }
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return self.SEPARATOR_HEIGHT
    }
    
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let frame = CGRect(x: 0, y: 0, width: self.tableViewSize!.width, height: self.SEPARATOR_HEIGHT)
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.clearColor()
        
        return view
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return self.newsArr.count
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

