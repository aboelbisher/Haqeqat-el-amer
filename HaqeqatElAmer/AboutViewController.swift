//
//  AboutViewController.swift
//  HaqeqatElAmer
//
//  Created by Muhammad on 10/24/15.
//  Copyright © 2015 Muhammad. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController
{
    var cancelBtn = UIButton()
    var cancelBtnSize : ViewConfig?
    let cancelBtnImg = UIImage(named: "cancel")!
    
    var contentLbl = NewsLbl()
    var contentLblSize : ViewConfig?
    let contentLblFont = UIFont.systemFontOfSize(20)
    
    
    var iconImgView = UIImageView()
    var iconImgViewSize : ViewConfig?
    
    
    var faceBookBtn = UIButton()
    var faceBookBtnSize : ViewConfig?
    let groupId = "1449455718694420"
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.preCalculations()
        self.initSubViews()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //MARK: init
    func preCalculations()
    {
        self.cancelBtnSize = ViewConfig(width: CGFloat(30), height: CGFloat(30), upMargin: CGFloat(20), downMargin: 0, leftMargin: 0, rightMargin: CGFloat(8))
        
        self.iconImgViewSize = ViewConfig(width: self.view.bounds.width / 2 ,
            height: self.view.bounds.width / 2,
            upMargin: CGFloat(70) ,
            downMargin: 0, leftMargin: 0, rightMargin: 0)
        
        self.contentLblSize = ViewConfig(width: self.view.bounds.width * 0.9 ,
            height: self.view.bounds.height * 0.4 ,
            upMargin: CGFloat(5),
            downMargin: 0, leftMargin: 0, rightMargin: 0)
        
        self.faceBookBtnSize = ViewConfig(width: self.view.bounds.width * 0.2 ,
            height: self.view.bounds.width * 0.2,
            upMargin: CGFloat(8),
            downMargin: 0, leftMargin: 0, rightMargin: 0)
    }
    
    func initSubViews()
    {
        self.initCancelBtn()
        self.initIconImgView()
        self.initContentLbl()
        self.initFaceBookBtn()
    }
    
    
    
    //MARK: init cancel btn
    func initCancelBtn()
    {
        self.view.addSubview(self.cancelBtn)
        setViewSizeConf(self.cancelBtn, size: self.cancelBtnSize!)
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.cancelBtn,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1, constant: -self.cancelBtnSize!.margin.up))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view,
            attribute: NSLayoutAttribute.Right,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.cancelBtn,
            attribute: NSLayoutAttribute.Right,
            multiplier: 1, constant: self.cancelBtnSize!.margin.right))
        
        self.cancelBtn.setImage(self.cancelBtnImg, forState: UIControlState.Normal)
        self.cancelBtn.addTarget(self, action: "cancel:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    
    func cancel(sender : UIButton)
    {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    
    //MARK: icon 
    func initIconImgView()
    {
        self.view.addSubview(self.iconImgView)
        setViewSizeConf(self.iconImgView, size: self.iconImgViewSize!)
        
        self.iconImgView.image = UIImage(named: "default")!
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.iconImgView,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.iconImgView,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1, constant: -self.iconImgViewSize!.margin.up))
    
        
        //self.iconImgView.layer.cornerRadius = 10
        
        
        
    }
    
    
    //MARK: content label 
    func initContentLbl()
    {
        self.view.addSubview(self.contentLbl)
        setViewSizeConf(self.contentLbl, size: self.contentLblSize!)
        
//        self.contentLbl.layer.borderWidth = CGFloat(0.5)
//        self.contentLbl.layer.borderColor = UIColor.blackColor().colorWithAlphaComponent(0.7).CGColor
//        self.contentLbl.layer.cornerRadius = 10
        self.contentLbl.numberOfLines = 0
        self.contentLbl.textAlignment = .Center
        
        self.contentLbl.font = self.contentLblFont
        
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.contentLbl,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.iconImgView,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.contentLbl,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1, constant: -self.contentLblSize!.margin.up))
        
        var content = "هذا التطبيق حقيقة الأمر ، هو أداة إعلامية صحفيّة موضوعية، مُحايدة ودقيقة جدًا ، تتبع اسلوبًا صحفيًا مميزًا، يبعث ملخصات "
        content += "الاخبار الفلسطينية، وما يهمها .."
        content += "\n\n"
        content += "بالمُختَصَر المُفيد .. حقيقة الأمر .. أولاً بأوّل !"
        
        
        self.contentLbl.text = content


        
        
    }
    
    
    
    //MARK: facebook button
    func initFaceBookBtn()
    {
        self.view.addSubview(self.faceBookBtn)
        setViewSizeConf(self.faceBookBtn, size: self.faceBookBtnSize!)
        
        
        self.faceBookBtn.setImage(UIImage(named: "facebook")!, forState: UIControlState.Normal)
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.faceBookBtn, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.contentLbl,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.faceBookBtn,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1, constant: -self.faceBookBtnSize!.margin.up))
        
        self.faceBookBtn.addTarget(self, action: "faceBookBtnClicked:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func faceBookBtnClicked(sender : UIButton)
    {
        if let url = NSURL(string: "fb://profile/" + self.groupId)
        {
            UIApplication.sharedApplication().openURL(url)

        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}
