//
//  ImagesCollectionViewCell.swift
//  HaqeqatElAmer
//
//  Created by Muhammad on 10/19/15.
//  Copyright © 2015 Muhammad. All rights reserved.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell
{
    var imageView = UIImageView()
    var imageViewSize : ViewConfig?
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
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
        self.imageViewSize = ViewConfig(width: self.frame.width, height: self.frame.height, upMargin: 0, downMargin: 0, leftMargin: 0, rightMargin: 0)

    }
    
    func initSubViews()
    {
        self.initImageView()
    }

    
    
    //MARK: image view
    func initImageView()
    {
        let frame = CGRect(x: 0, y: 0, width: self.imageViewSize!.width , height: self.imageViewSize!.height)
        
        self.imageView = UIImageView(frame: frame)
        
        self.imageView.layer.cornerRadius = 10
        
        self.contentView.addSubview(self.imageView)

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
