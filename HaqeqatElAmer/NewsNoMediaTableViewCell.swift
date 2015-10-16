//
//  NewTableViewCell.swift
//  HaqeqatElAmer
//
//  Created by Muhammad on 10/16/15.
//  Copyright © 2015 Muhammad. All rights reserved.
//

import UIKit

class NewTableViewCell: UITableViewCell
{
    //var news : News?
    
    var width = CGFloat(0)
    var height = CGFloat(0)

    init(reuseId : String , width : CGFloat , height : CGFloat)
    {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseId)
        //self.news = news
        self.width = width
        self.height = height
        
        
        self.contentView.backgroundColor = UIColor.greenColor()
        
        self.preCalculations()
        self.initSubViews()
        
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }

    
    
    
    
    
    
    func preCalculations()
    {
        
    }
    
    func initSubViews()
    {
        
    }
}
