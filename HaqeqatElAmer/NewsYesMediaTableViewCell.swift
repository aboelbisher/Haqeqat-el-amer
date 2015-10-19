//
//  NewsYesMediaTableViewCell.swift
//  HaqeqatElAmer
//
//  Created by Muhammad on 10/16/15.
//  Copyright © 2015 Muhammad. All rights reserved.
//

import UIKit

class NewsYesMediaTableViewCell: NewsGenericCellTableViewCell
{
//    var width = CGFloat(0)
//    var height = CGFloat(0)
    
    var news : News!
    
    var contentLbl = UILabel()
    var contentLblSize : ViewConfig?
    
    var scrollView = UIScrollView()
    var scrollViewSize : ViewConfig?
    
    
    var images = [UIImageView]()
    var imageViewSize : ViewConfig?
    
    var videoPlayer = YouTubePlayerView()
    var videoPlayerSize : ViewConfig?
    

    init( news : News ,width : CGFloat , height : CGFloat)
    {
        //super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "")
        
        super.init(width: width, height: height)
        
        self.width = width
        self.height = height
        self.news = news
        
        //self.contentView.backgroundColor = UIColor.redColor()
        
//        let newsimg = NewsImage(url: "asdasdsad", info: "asd", image: nil)
//
//        
//        self.news!.images.append(newsimg)
//        self.news!.images.append(newsimg)
//        self.news!.images.append(newsimg)
//        self.news!.images.append(newsimg)
//        self.news!.images.append(newsimg)
        
        self.myPreCalculations()
        self.myInitSubView()
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    
    //MARK: init
    func myPreCalculations()
    {
        let lblheight = min(heightForView(self.news!.content, font: NEWS_FONT, width: self.width * 0.9 - self.dateLblSize!.height - CGFloat(3) ) , CGFloat(90))
        self.contentLblSize = ViewConfig(width: self.width * 0.9  ,
            height: lblheight,
            upMargin: CGFloat(3) , downMargin: 0, leftMargin: 0, rightMargin: 0)
        
        //let scrollViewHeight = self.height * 0.95 - lblheight - CGFloat(5)
        
        self.scrollViewSize = ViewConfig(width: self.width * 0.95 ,
            height: CGFloat(100),
            upMargin: 0,
            downMargin: CGFloat(5),
            leftMargin: 0, rightMargin: 0)
        
        self.imageViewSize = ViewConfig(width: self.scrollViewSize!.height * 0.95 ,
            height: self.scrollViewSize!.height * 0.95,
            upMargin: 0, downMargin: 0, leftMargin: 0, rightMargin: 0)
        
        self.videoPlayerSize = self.imageViewSize!
    }
    
    func myInitSubView()
    {
        self.initContentlbl()
        self.initImages()
        self.initVideoPlayer()
        self.initScrollView()
    }

    
    
    //MARK: content lbl
    func initContentlbl()
    {
        self.contentView.addSubview(self.contentLbl)
        
        setViewSizeConf(self.contentLbl, size: self.contentLblSize!)
        
        self.contentLbl.font = NEWS_FONT
        self.contentLbl.textAlignment = .Right
        self.contentLbl.textColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        self.contentLbl.userInteractionEnabled = false
        self.contentLbl.numberOfLines = 3
        
        
        let views = ["upView" : self.dateLbl ,
            "lbl" : self.contentLbl]
        
        let metrics = ["upMargin" : self.contentLblSize!.margin.up]
        
        let lbl_up_margin = NSLayoutConstraint.constraintsWithVisualFormat("V:[upView]-upMargin-[lbl]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: metrics,
            views: views)
        
        self.contentView.addConstraints(lbl_up_margin)
        
        
//        self.contentView.addConstraint(NSLayoutConstraint(item: self.contentView,
//            attribute: NSLayoutAttribute.CenterX,
//            relatedBy: NSLayoutRelation.Equal,
//            toItem: self.contentLbl,
//            attribute: NSLayoutAttribute.CenterX,
//            multiplier: 1, constant: 0))
//        
//        self.contentView.addConstraint(NSLayoutConstraint(item: self.contentView,
//            attribute: NSLayoutAttribute.Top,
//            relatedBy: NSLayoutRelation.Equal,
//            toItem: self.contentLbl,
//            attribute: NSLayoutAttribute.Top,
//            multiplier: 1, constant: -self.contentLblSize!.margin.up))

    }
    
    
    //MARK: initScrollView
    func initScrollView()
    {
        self.contentView.addSubview(self.scrollView)
        setViewSizeConf(self.scrollView, size: self.scrollViewSize!)
        
        self.contentView.addConstraint(NSLayoutConstraint(item: self.contentView,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.scrollView,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1, constant: self.scrollViewSize!.margin.down))
        
//        let views = ["upView" : self.contentLbl ,
//            "scroll" : self.scrollView]
//        
//        let metrics = ["upMargin" : self.scrollViewSize!.margin.up]
//        
//        
//        let scroll_up_margin = NSLayoutConstraint.constraintsWithVisualFormat("V:[upView]-upMargin-[scroll]",
//            options: NSLayoutFormatOptions.AlignAllCenterX,
//            metrics: metrics,
//            views: views)
//        
//        self.contentView.addConstraints(scroll_up_margin)
        
        
        var contentWidth = self.imageViewSize!.width * CGFloat(self.images.count)
        if self.news!.videoLink.stringByReplacingOccurrencesOfString(" ", withString: "") != ""
        {
            contentWidth += self.videoPlayerSize!.width
            self.scrollView.addSubview(self.videoPlayer)
        }
        
        self.scrollView.contentSize = CGSizeMake(contentWidth , self.scrollViewSize!.height)

        for image in self.images
        {
            self.scrollView.addSubview(image)
        }
        
        if self.news!.videoLink.stringByReplacingOccurrencesOfString(" ", withString: "") != ""
        {
            self.scrollView.addSubview(self.videoPlayer)
        }

        
        
        let rect = CGRect(x: self.imageViewSize!.width * CGFloat(self.images.count) - self.imageViewSize!.width ,
            y: 0, width: self.imageViewSize!.width, height: self.imageViewSize!.height)
        
        self.scrollView.scrollRectToVisible(rect, animated: false)
    }
    
    
    //MARK: images
    func initImages()
    {
        for (var i = 0 ; i < self.news!.images.count ; i++)
        {
            let XValue = CGFloat( self.imageViewSize!.width * CGFloat(i) + CGFloat(20) )
            
            let frame = CGRect(x: XValue , y: 0, width: self.imageViewSize!.width, height: self.imageViewSize!.height)
            
            let myImageView = UIImageView(frame: frame)
           
            
            myImageView.image = UIImage(named: "default")!.resizeTo(CGSizeMake(self.imageViewSize!.width * 0.7, self.imageViewSize!.width * 0.7))
            
            myImageView.layer.cornerRadius = 10
            
            
            self.images.append(myImageView)
        }
    }
    
    
    func initVideoPlayer()
    {
        let frame = CGRect(x: self.imageViewSize!.width * CGFloat(self.news!.images.count) + CGFloat(20), y: 0, width: self.videoPlayerSize!.width,
            height: self.videoPlayerSize!.height)
        
        self.videoPlayer = YouTubePlayerView(frame: frame)
        
        self.videoPlayer.webView.scrollView.scrollEnabled = false
//        self.videoPlayer.translatesAutoresizingMaskIntoConstraints = false

        // println("the video id is ====> \(newVideoId)")

        self.videoPlayer.loadVideoID(self.news!.videoLink)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
