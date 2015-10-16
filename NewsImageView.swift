//
//  NewsImageView.swift
//  100
//
//  Created by muhammad abed el razek on 4/30/15.
//  Copyright (c) 2015 muhammad abed el razek. All rights reserved.
//

import UIKit

class NewsImageView: UIView
{
    //var image : UIImage
    
    var image : NewsImage?
    
    var imageView = UIImageView()
    let imageViewWidth = UIScreen.mainScreen().bounds.width
    let imageViewHeight = CGFloat(300)
    
    var infoLabel = UILabel()
    let infoLabelWidth = UIScreen.mainScreen().bounds.width
    let infoLabelHeight = CGFloat(70)
    let infoLabelDownMargin = CGFloat(10)
    
    required init(frame: CGRect , image : UIImage , info : String)
    {
        self.image = NewsImage(url: "" , info: info  , image : image)


        
        super.init(frame: frame)
        self.backgroundColor = UIColor.blackColor()
        self.initSubViews()
        
    }

    required init?(coder aDecoder: NSCoder)
    {
       // self.image = UIImage(named: "tst")!
        super.init(coder: aDecoder)
    }
    
    
    func initSubViews()
    {
        self.initImageView()
        self.initInfoLabel()
    }
    
    //MARK: image view
    
    func initImageView()
    {
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.imageView.image = self.image!.image
        
        self.addSubview(self.imageView)
        
        let views = ["img" : self.imageView]
        
        let metrics = ["width" : self.imageViewWidth ,
            "height" : self.imageViewHeight]
        
        let img_width = NSLayoutConstraint.constraintsWithVisualFormat("H:[img(width)]",
            options: [],
            metrics: metrics,
            views: views)
        
        let img_height = NSLayoutConstraint.constraintsWithVisualFormat("V:[img(height)]",
            options: [],
            metrics: metrics,
            views: views)
        
        self.imageView.addConstraints(img_width)
        self.imageView.addConstraints(img_height)
        
        self.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1,
            constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 1, constant: 0))
    }
    
    func initInfoLabel()
    {
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.infoLabel)
        self.infoLabel.text = self.image!.info
        self.infoLabel.textColor = UIColor.whiteColor()
        self.infoLabel.textAlignment = .Center
        
        let views = ["lbl" : self.infoLabel ]
        
        let metrics = ["width"  :self.infoLabelWidth,
            "height" : self.infoLabelHeight ,
            "margin" : self.infoLabelDownMargin]
        
        let lbl_width = NSLayoutConstraint.constraintsWithVisualFormat("H:[lbl(width)]",
            options: [],
            metrics: metrics,
            views: views)
        
        let lbl_height = NSLayoutConstraint.constraintsWithVisualFormat("V:[lbl(height)]",
            options: [],
            metrics: metrics,
            views: views)
        
        self.infoLabel.addConstraints(lbl_width)
        self.infoLabel.addConstraints(lbl_height)
        
        let lbl_down_lbl = NSLayoutConstraint.constraintsWithVisualFormat("V:[lbl]-margin-|",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: metrics,
            views: views)
        
        self.addConstraints(lbl_down_lbl)
        
    }

}
