//
//  ImageDetailsView.swift
//  HaqeqatElAmer
//
//  Created by Muhammad on 10/19/15.
//  Copyright © 2015 Muhammad. All rights reserved.
//

import UIKit

class ImageDetailsViewController: UIViewController
{
    var image : NewsImage?
    
    var imgView = UIImageView()
    var imgViewSize : ViewConfig?
    
    init(image : NewsImage)
    {
        super.init(nibName: nil, bundle: nil)
        self.image = image
    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.blackColor()
        
        self.preCalculations()
        self.initSubViews()
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    
    //MARK: init
    func preCalculations()
    {
        self.imgViewSize = ViewConfig(width: self.view.bounds.width ,
            height: self.view.bounds.width ,
            upMargin: 0, downMargin: 0, leftMargin: 0, rightMargin: 0)
    }
    
    func initSubViews()
    {
        self.initImgView()
    }


    
    //MARK: init image view
    func initImgView()
    {
        self.view.addSubview(self.imgView)
        setViewSizeConf(self.imgView, size: self.imgViewSize!)
        
        self.imgView.image = UIImage(named: "default")!
        
        if let img = images_chache[self.image!.url]
        {
            self.imgView.image = img
        }
        else
        {
            if let url = NSURL(string: self.image!.url)
            {
                downloadImgFromUrl(url, completionHandler: { (img) -> Void in
                    images_chache[self.image!.url] = img
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.imgView.image = img
                    })
                })
            }
        }
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.imgView,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.imgView,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 1, constant: 0))
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}
