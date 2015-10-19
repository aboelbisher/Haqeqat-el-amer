//
//  NewsDetailsViewController.swift
//  HaqeqatElAmer
//
//  Created by Muhammad on 10/16/15.
//  Copyright © 2015 Muhammad. All rights reserved.
//

import UIKit


class NewsLbl : UILabel
{
    let padding = CGFloat(3)
    
    override func drawTextInRect(rect: CGRect)
    {
        
        let insects = UIEdgeInsets(top: padding , left: CGFloat(7), bottom: padding, right: CGFloat(8))
        
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insects))
    }
}

class NewsDetailsViewController: UIViewController
{
    var news : News
    
    
    var scrollView = UIScrollView()
    var scrollViewSize : ViewConfig?
    
    var dateLbl = UILabel()
    var datelblSize : ViewConfig?
    
    var contentLbl = NewsLbl()
    var contentLblSize : ViewConfig?
    let contentLblFont = UIFont.systemFontOfSize(20)
    
    var videoPlayer = YouTubePlayerView()
    var videoPlayerSize : ViewConfig?
    
    
    //var images
    
    

    init(news : News)
    {
        self.news = news
        super.init(nibName: nil, bundle: nil)
        
        
        
    }

    required init?(coder aDecoder: NSCoder)
    {
        self.news = News()
        super.init(coder: aDecoder)
        
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColorFromRGB("#F4F4F4", alpha: 1)
        
        
        print(self.news.content)
        
        self.preCalculations()
        self.initSubViews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: init
    func preCalculations()
    {
        self.scrollViewSize = ViewConfig(width: self.view.bounds.width * 0.9 ,
            height: self.view.bounds.height  ,
            upMargin: 0, downMargin: 0, leftMargin: 0, rightMargin: 0)
        
        self.datelblSize = ViewConfig(width: self.view.bounds.width * 0.9 ,
            height: CGFloat(70) ,
            upMargin: CGFloat(5) + self.navigationController!.navigationBar.frame.height,
            downMargin: 0, leftMargin: 0, rightMargin: 0)
        
        
        var tmpStr = self.news.content.stringByReplacingOccurrencesOfString("\n", withString: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
        tmpStr = tmpStr.stringByReplacingOccurrencesOfString("\\", withString: "a")
        tmpStr = tmpStr.stringByReplacingOccurrencesOfString("-", withString: "a")
        tmpStr = tmpStr.stringByReplacingOccurrencesOfString("\"", withString: "a")
        tmpStr += "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"


        
        let contentLblHeight = heightForView(tmpStr,
            font: self.contentLblFont, width: self.view.bounds.width * 0.9)
        
//        let height = NSString(string: self.news.content).boundingRectWithSize(CGSizeMake(self.view.bounds.width * 0.9 ,
//            CGFloat.max),
//            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
//            attributes: [NSFontAttributeName : self.contentLblFont],
//            context: nil)
        
        
        
        self.contentLblSize = ViewConfig(width: self.view.bounds.width * 0.9 ,
            height: contentLblHeight,
            upMargin: CGFloat(3),
            downMargin: 0, leftMargin: 0, rightMargin: 0)
        
        self.videoPlayerSize = ViewConfig(width: self.view.bounds.width * 0.9,
            height: self.view.bounds.width * 0.9 ,
            upMargin: CGFloat(10) ,
            downMargin: 0, leftMargin: 0, rightMargin: 0)
    }
    
    func initSubViews()
    {
        self.initScrollView()
        self.initDateLbl()
        
        self.initContentLbl()
        
        if self.news.videoLink.stringByReplacingOccurrencesOfString(" ", withString: "") != ""
        {
            self.initVideoPlayer()
        }
        
    }

    
    //MARK: scroll view
    func initScrollView()
    {
        self.view.addSubview(self.scrollView)
        setViewSizeConf(self.scrollView, size: self.scrollViewSize!)
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.scrollView,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1, constant: 0))
        
        
        let height = self.datelblSize!.height + self.datelblSize!.margin.up + self.contentLblSize!.height + self.contentLblSize!.margin.up + self.videoPlayerSize!.height + self.videoPlayerSize!.margin.up
        
        self.scrollView.contentSize = CGSizeMake(self.scrollViewSize!.width, height)
        
        
    }
    
    
    //MARK: datelbl
    func initDateLbl()
    {
        self.scrollView.addSubview(self.dateLbl)
        
        setViewSizeConf(self.dateLbl, size: self.datelblSize!)
        
        
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.scrollView,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.dateLbl,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1, constant: -self.datelblSize!.margin.up))
        
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.scrollView,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.dateLbl,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1, constant: 0))
        
        
        
        
        self.dateLbl.text = self.news.date.date + " " + self.news.date.day + " " + self.news.date.hour
        self.dateLbl.textAlignment = .Right
        self.dateLbl.textColor = UIColor.redColor()
        self.dateLbl.font = UIFont.systemFontOfSize(12)
        
        //self.dateLbl.backgroundColor = UIColor.redColor()
        
        
    }
    
    
    
    //MARK: content label
    func initContentLbl()
    {
        self.scrollView.addSubview(self.contentLbl)
        setViewSizeConf(self.contentLbl, size: self.contentLblSize!)
        
        let views = ["upView" : self.dateLbl ,
            "lbl" : self.contentLbl]
        
        
        let metrics = ["upMargin" : self.contentLblSize!.margin.up]
        
        let lbl_up_margin = NSLayoutConstraint.constraintsWithVisualFormat("V:[upView]-upMargin-[lbl]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: metrics ,
            views: views)
        
        self.scrollView.addConstraints(lbl_up_margin)
        
        
        self.contentLbl.text = self.news.content//.stringByReplacingOccurrencesOfString("\n", withString: "")
        self.contentLbl.textColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        self.contentLbl.textAlignment = .Right
        self.contentLbl.font = self.contentLblFont
        self.contentLbl.numberOfLines  = 0
        
        
        //self.contentLbl.sizeToFit()
        
        
        
        
        self.contentLbl.layer.borderColor = UIColor.grayColor().CGColor
        self.contentLbl.layer.borderWidth = CGFloat(0.5)
        self.contentLbl.layer.cornerRadius = 10
        
        
        //self.contentLbl.addSadow()
        
        
        
        
        
        
        
    }
    
    
    
    //MARK: video player
    func initVideoPlayer()
    {
        self.scrollView.addSubview(self.videoPlayer)
        setViewSizeConf(self.videoPlayer, size: self.videoPlayerSize!)
        
        let views = ["upView" : self.contentLbl ,
            "player" : self.videoPlayer]
        
        let metrics = ["upMargin" : self.videoPlayerSize!.margin.up]
        
        let video_up_margin = NSLayoutConstraint.constraintsWithVisualFormat("V:[upView]-upMargin-[player]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: metrics,
            views: views)
        
        self.scrollView.addConstraints(video_up_margin)
        
        self.videoPlayer.webView.scrollView.scrollEnabled = false

        
        
        self.videoPlayer.loadVideoID(self.news.videoLink)
    }
    
    
    func initImages()
    {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
