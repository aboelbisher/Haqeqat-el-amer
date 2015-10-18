//
//  NewsGenericCellTableViewCell.swift
//  HaqeqatElAmer
//
//  Created by Muhammad on 10/18/15.
//  Copyright © 2015 Muhammad. All rights reserved.
//

import UIKit

class NewsGenericCellTableViewCell: UITableViewCell
{

    var dateLbl = UILabel()
    var dateLblSize : ViewConfig?
    
    var width = CGFloat(0)
    var height = CGFloat(0)
    
    
    init( width : CGFloat , height : CGFloat)
    {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "")
        
        self.width = width
        self.height = height
        
        self.preCalculations()
        self.initSubViews()
        
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    //MARK: init
    func preCalculations()
    {
        self.dateLblSize = ViewConfig(width: self.width * 0.9 ,
            height: CGFloat(40) ,
            upMargin: CGFloat(3),
            downMargin: 0, leftMargin: 0, rightMargin: 0)
    }
    
    func initSubViews()
    {
        self.initDateLbl()
    }
    
    
    //MARK: date label 
    func initDateLbl()
    {
        self.contentView.addSubview(self.dateLbl)
        setViewSizeConf(self.dateLbl, size: self.dateLblSize!)
        
        self.contentView.addConstraint(NSLayoutConstraint(item: self.contentView,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.dateLbl,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1, constant: -self.dateLblSize!.margin.up))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: self.contentView,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.dateLbl,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1, constant: 0))
        
        
        self.dateLbl.textAlignment = .Right
        self.dateLbl.font = UIFont.systemFontOfSize(12)
        self.dateLbl.textColor = UIColor.redColor()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}
