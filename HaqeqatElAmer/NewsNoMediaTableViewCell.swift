//
//  NewTableViewCell.swift
//  HaqeqatElAmer
//
//  Created by Muhammad on 10/16/15.
//  Copyright © 2015 Muhammad. All rights reserved.
//

import UIKit

class NewsNoMediaTableViewCell: UITableViewCell
{
    //var news : News?
    
    var width = CGFloat(0)
    var height = CGFloat(0)
    
    var contentLbl = UILabel()
    var contentLblSize : ViewConfig?
    

    init(reuseId : String , width : CGFloat , height : CGFloat)
    {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseId)
        //self.news = news
        self.width = width
        self.height = height
        
        
        self.contentView.backgroundColor = UIColor.whiteColor()
        
        self.preCalculations()
        self.initSubViews()
        
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }

    
    
    
    
    
    
    func preCalculations()
    {
        self.contentLblSize = ViewConfig(width: self.width * 0.9 ,
            height: self.height * 0.9 ,
            upMargin: 0, downMargin: 0, leftMargin: 0, rightMargin: 0)
    }
    
    func initSubViews()
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
        
        
        self.contentView.addConstraint(NSLayoutConstraint(item: self.contentView,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.contentLbl,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1, constant: 0))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: self.contentView,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.contentLbl,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 1, constant: 0))
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
