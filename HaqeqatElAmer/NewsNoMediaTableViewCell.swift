//
//  NewTableViewCell.swift
//  HaqeqatElAmer
//
//  Created by Muhammad on 10/16/15.
//  Copyright © 2015 Muhammad. All rights reserved.
//

import UIKit

class NewsNoMediaTableViewCell: NewsGenericCellTableViewCell
{
    //var news : News?
    
//    var width = CGFloat(0)
//    var height = CGFloat(0)
    
    var contentLbl = UILabel()
    var contentLblSize : ViewConfig?
    

    init(reuseId : String , width : CGFloat , height : CGFloat)
    {
        //super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseId)
        super.init(width: width, height: height)
        
        //self.news = news
//        self.width = width
//        self.height = height
        
        
        //self.contentView.backgroundColor = UIColor.whiteColor()
        
        self.myPreCalculations()
        self.myInitSubViews()
        
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }

    
    
    
    
    
    
    func myPreCalculations()
    {
        self.contentLblSize = ViewConfig(width: self.width * 0.9 ,
            height: self.height * 0.9 - self.dateLblSize!.height - CGFloat(2) ,
            upMargin: CGFloat(2), downMargin: 0, leftMargin: 0, rightMargin: 0)
    }
    
    func myInitSubViews()
    {
        self.initContentLbl()
    }
    
    
    
    //MARK: contentLbl
    func initContentLbl()
    {
        self.contentView.addSubview(self.contentLbl)
        
        setViewSizeConf(self.contentLbl, size: self.contentLblSize!)
        
        self.contentLbl.font = NEWS_FONT
        self.contentLbl.textAlignment = .Right
        self.contentLbl.textColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        self.contentLbl.userInteractionEnabled = false
        self.contentLbl.numberOfLines = 3
        
        
//        self.contentView.addConstraint(NSLayoutConstraint(item: self.contentView,
//            attribute: NSLayoutAttribute.CenterX,
//            relatedBy: NSLayoutRelation.Equal,
//            toItem: self.contentLbl,
//            attribute: NSLayoutAttribute.CenterX,
//            multiplier: 1, constant: 0))
        
//        self.contentView.addConstraint(NSLayoutConstraint(item: self.contentView,
//            attribute: NSLayoutAttribute.CenterY,
//            relatedBy: NSLayoutRelation.Equal,
//            toItem: self.contentLbl,
//            attribute: NSLayoutAttribute.CenterY,
//            multiplier: 1, constant: 0))
        
        let views = ["upView" : self.dateLbl ,
            "lbl" : self.contentLbl]
        
        let metrics = ["upMargin" : self.dateLblSize!.margin.up]
        
        let lbl_up_margin = NSLayoutConstraint.constraintsWithVisualFormat("V:[upView]-upMargin-[lbl]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: metrics,
            views: views)
        
        self.contentView.addConstraints(lbl_up_margin)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
