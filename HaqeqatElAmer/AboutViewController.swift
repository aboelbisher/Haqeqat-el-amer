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
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        
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
    }
    
    func initSubViews()
    {
        self.initCancelBtn()
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}
