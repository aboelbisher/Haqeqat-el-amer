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
    
    var dateLbl = UILabel()
    var datelblSize : ViewConfig?
    
    var contentLbl = NewsLbl()
    var contentLblSize : ViewConfig?
    let contentLblFont = UIFont.systemFontOfSize(20)
    
    var videoPlayer = YouTubePlayerView()
    var videoPlayerSize : ViewConfig?
    
    

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
        self.datelblSize = ViewConfig(width: self.view.bounds.width * 0.9 ,
            height: CGFloat(70) ,
            upMargin: CGFloat(5) + self.navigationController!.navigationBar.frame.height,
            downMargin: 0, leftMargin: 0, rightMargin: 0)
        
        let contentLblHeight = heightForView(self.news.content,
            font: self.contentLblFont, width: self.view.bounds.width * 0.9)
        
        
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
        self.initDateLbl()
        
        self.initContentLbl()
        
        if self.news.videoLink.stringByReplacingOccurrencesOfString(" ", withString: "") != ""
        {
            self.initVideoPlayer()
        }
        
    }

    
    //MARK: datelbl
    func initDateLbl()
    {
        self.view.addSubview(self.dateLbl)
        
        setViewSizeConf(self.dateLbl, size: self.datelblSize!)
        
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.dateLbl,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1, constant: -self.datelblSize!.margin.up))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view,
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
        self.view.addSubview(self.contentLbl)
        setViewSizeConf(self.contentLbl, size: self.contentLblSize!)
        
        let views = ["upView" : self.dateLbl ,
            "lbl" : self.contentLbl]
        
        let metrics = ["upMargin" : self.contentLblSize!.margin.up]
        
        let lbl_up_margin = NSLayoutConstraint.constraintsWithVisualFormat("V:[upView]-upMargin-[lbl]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: metrics ,
            views: views)
        
        self.view.addConstraints(lbl_up_margin)
        
        
        self.contentLbl.text = self.news.content
        self.contentLbl.textColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        self.contentLbl.textAlignment = .Right
        self.contentLbl.font = self.contentLblFont
        self.contentLbl.numberOfLines  = 0
        
        self.contentLbl.layer.borderColor = UIColor.grayColor().CGColor
        self.contentLbl.layer.borderWidth = CGFloat(0.5)
        self.contentLbl.layer.cornerRadius = 10
        
        
        //self.contentLbl.addSadow()
        
        
        
        
        
        
        
    }
    
    
    
    //MARK: video player
    func initVideoPlayer()
    {
        self.view.addSubview(self.videoPlayer)
        setViewSizeConf(self.videoPlayer, size: self.videoPlayerSize!)
        
        let views = ["upView" : self.contentLbl ,
            "player" : self.videoPlayer]
        
        let metrics = ["upMargin" : self.videoPlayerSize!.margin.up]
        
        let video_up_margin = NSLayoutConstraint.constraintsWithVisualFormat("V:[upView]-upMargin-[player]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: metrics,
            views: views)
        
        self.view.addConstraints(video_up_margin)
        
        self.videoPlayer.webView.scrollView.scrollEnabled = false

        
        
        self.videoPlayer.loadVideoID(self.news.videoLink)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
