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
    
    
    var imageSize : ViewConfig?
    
    var imageView1 = UIImageView()
    var imageView2 = UIImageView()
    
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
        
        self.view.multipleTouchEnabled = true
        
        
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
        
        
        //bulllll shittt!!!!!!
        var tmpStr = self.news.content.stringByReplacingOccurrencesOfString("\n", withString: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
        tmpStr = tmpStr.stringByReplacingOccurrencesOfString("\\", withString: "a")
        tmpStr = tmpStr.stringByReplacingOccurrencesOfString("-", withString: "a")
        tmpStr = tmpStr.stringByReplacingOccurrencesOfString("\"", withString: "a")
        tmpStr += "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        //bulllll shittt!!!!!!


        
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
        
        self.imageSize = ViewConfig(width: self.view.bounds.width * 0.4 ,
            height: self.view.bounds.width * 0.4,
            upMargin: CGFloat(30) ,
            downMargin: 0, leftMargin: self.view.bounds.width * 0.1, rightMargin: self.view.bounds.width * 0.1)
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
        
        self.initImages()
        
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
        
        
        var height = self.datelblSize!.height + self.datelblSize!.margin.up + self.contentLblSize!.height + self.contentLblSize!.margin.up
        
        if self.news.videoLink.stringByReplacingOccurrencesOfString(" ", withString: "") != ""
        {
            height += self.videoPlayerSize!.height + self.videoPlayerSize!.margin.up
        }
        
        
        if self.news.images.count > 0
        {
            height += self.imageSize!.height + self.imageSize!.margin.up
        }
        
        height += CGFloat(30)
        
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
        self.dateLbl.font = UIFont.systemFontOfSize(15)
        
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
        //let imageView1 = UIImageView()
        setViewSizeConf(imageView1, size: imageSize!)
        //        self.scrollView.addSubview(imageView2)
        imageView1.layer.cornerRadius = 10
        imageView1.tag = 3

        
        //let imageView2 = UIImageView()
        setViewSizeConf(imageView2, size: imageSize!)
//        self.scrollView.addSubview(imageView2)
        imageView2.layer.cornerRadius = 10
        imageView2.tag = 1
        
        imageView1.image = UIImage(named: "default")!
        imageView2.image = UIImage(named: "default")!
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "imgViewTapped:")
        
        imageView1.userInteractionEnabled = true
        imageView1.addGestureRecognizer(tapGesture)
        
        imageView2.userInteractionEnabled = true
        imageView2.addGestureRecognizer(tapGesture)

        
        if self.news.images.count == 1
        {
//            let imageView = UIImageView()
//            setViewSizeConf(imageView, size: imageSize!)
//            
//            imageView.layer.cornerRadius = 10
//            
            self.scrollView.addSubview(imageView1)
//
//            imageView.image = UIImage(named: "default")!
            
            let upView = self.news.videoLink.stringByReplacingOccurrencesOfString(" ", withString: "") != "" ? self.videoPlayer : self.contentLbl

            
            let views = ["upView" : upView ,
                "img" : imageView1]
            
            let metrics = ["upMargin" : self.imageSize!.margin.up]
            
            let img_up_margin = NSLayoutConstraint.constraintsWithVisualFormat("V:[upView]-upMargin-[img]",
                options: NSLayoutFormatOptions.AlignAllCenterX,
                metrics: metrics,
                views: views)
            
            self.scrollView.addConstraints(img_up_margin)
            
            
            
            
        }
        else if self.news.images.count == 2
        {
//            let imageView1 = UIImageView()
//            setViewSizeConf(imageView1, size: imageSize!)
            self.scrollView.addSubview(imageView1)
//            imageView1.layer.cornerRadius = 10
//            
//            let imageView2 = UIImageView()
//            setViewSizeConf(imageView2, size: imageSize!)
            self.scrollView.addSubview(imageView2)
//            imageView2.layer.cornerRadius = 10
//            
//            imageView1.image = UIImage(named: "default")!
//            imageView2.image = UIImage(named: "default")!
            
            let upView = self.news.videoLink.stringByReplacingOccurrencesOfString(" ", withString: "") != "" ? self.videoPlayer : self.contentLbl
            
            
            let views = ["upView" : upView ,
                "img1" : imageView1 ,
                "img2" : imageView2]
            
            let metrics = ["upMargin" : self.imageSize!.margin.up]
            
            let img1_up_margin = NSLayoutConstraint.constraintsWithVisualFormat("V:[upView]-upMargin-[img1]",
                options: NSLayoutFormatOptions.AlignAllLeft,
                metrics: metrics,
                views: views)
            
            let img2_up_margin =  NSLayoutConstraint.constraintsWithVisualFormat("V:[upView]-upMargin-[img2]",
                options: NSLayoutFormatOptions.AlignAllRight,
                metrics: metrics,
                views: views)
            
            self.scrollView.addConstraints(img1_up_margin)
            self.scrollView.addConstraints(img2_up_margin)
            
        }
        
    }
    
    
    
    func imgViewTapped(recognizer : UIGestureRecognizer)
    {
        
        print("image view with tag \(recognizer.view!.tag) clicked")
        let image = self.news.images[recognizer.view!.tag]
        
        let vc = ImageDetailsViewController(image: image)
        
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        super.touchesBegan(touches, withEvent: event)
        
        for touch in touches
        {
            let point = touch.locationInView(self.imageView1)
            print(point)
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
