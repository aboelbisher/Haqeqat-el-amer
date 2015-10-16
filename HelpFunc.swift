//
//  HelpFunc.swift
//  AllMuz
//
//  Created by muhammad abed el razek on 6/14/15.
//  Copyright (c) 2015 muhammad abed el razek. All rights reserved.
//

import UIKit

typealias JSON = AnyObject
typealias JSONDictionary = Dictionary<String, JSON>
typealias JSONArray = Array<JSON>

typealias SizeKind = CGFloat // for changing in future

struct ViewConfig
{
    var width : SizeKind
    var height : SizeKind
    var margin : Margins
    
    init(width : SizeKind , height : SizeKind , upMargin : SizeKind , downMargin : SizeKind ,
        leftMargin : SizeKind , rightMargin : SizeKind)
    {
        self.width = width
        self.height = height
        
        let margin = Margins(up: upMargin, left: leftMargin, right: rightMargin, down: downMargin)
        self.margin = margin
    }
}

struct Margins
{
    var up : SizeKind
    var left : SizeKind
    var right : SizeKind
    var down : SizeKind
}




func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor
{
    let actualColorCode = colorCode.stringByReplacingOccurrencesOfString("#", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
    
    let scanner = NSScanner(string:actualColorCode)
    var color:UInt32 = 0;
    scanner.scanHexInt(&color)
    
    let mask = 0x000000FF
    let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
    let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
    let b = CGFloat(Float(Int(color) & mask)/255.0)
    
    return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
}

func widthForView(text:String, font:UIFont, height:CGFloat) -> CGFloat
{
    let label:UILabel = UILabel(frame: CGRectMake(0, 0, CGFloat.max, height))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.ByWordWrapping
    label.font = font
    label.text = text
    
    label.sizeToFit()
    return label.frame.width
}


func heightForView(text : String , font : UIFont , width : CGFloat) -> CGFloat
{
    let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.ByWordWrapping
    label.font = font
    label.text = text
    
    label.sizeToFit()
    return label.frame.height
    
}



extension String
{
    func checkForEmptyOrNillSring()->Bool
    {
        let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
        if self.stringByTrimmingCharactersInSet(whitespaceSet) == ""
        {
            return true
        }
        return false
    }
}

extension Int
{
    func toString()->String
    {
        var str = ""
        
        if(self>=0 && self<=999)
        {
            str = self.description
        }
        else if (self >= 1000 && self<=999999)
        {
            let tmp = self/1000
            str = tmp.description + "K"
        }
        else // milions!!!
        {
            let tmp = self/1000000
            str = tmp.description + "m"
        }
        
        return str
    }
}


func downloadImgFromUrl( url : NSURL , completionHandler : (UIImage->Void))
{
    let request: NSURLRequest = NSURLRequest(URL: url)
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
        if error == nil
        {
            if let image = UIImage(data: data!)
            {
                completionHandler(image)
            }
        }
        else
        {
            print("Error: \(error!.localizedDescription)")
        }
    })
    
}




//(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
//    //UIGraphicsBeginImageContext(newSize);
//    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
//    // Pass 1.0 to force exact pixel size.
//    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
//    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
//}

extension UIImage
{
    func resizeTo(newSize : CGSize) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImg
    }
}




extension CLong
{
    func turnIntoPlayerTime()->String
    {
        var retString = ""
        
        let seconds = (self%60)
        
        var minutes = self/60
        
        let hours = minutes/60
        
        minutes = minutes%60
        
        let secondsStr = seconds < 10 ? "0" + seconds.description : seconds.description
        let minutesStr = minutes < 10 ?  "0" + minutes.description : minutes.description
        
        if(hours > 0)
        {
            retString = hours.description + ":" + minutesStr + ":"
            
        }
        else if (minutes > 0)
        {
            retString = minutesStr + ":"
        }
        
        retString += secondsStr
        
        return retString
        
    }
}

func setViewSizeConf(view : UIView , size : ViewConfig)
{
    view.translatesAutoresizingMaskIntoConstraints = false
    
    let views = ["view" : view]
    
    let metrics = ["width" : size.width ,
        "height" : size.height]
    
    let view_width = NSLayoutConstraint.constraintsWithVisualFormat("H:[view(width)]",
        options: [],
        metrics: metrics,
        views: views)
    
    let view_height = NSLayoutConstraint.constraintsWithVisualFormat("V:[view(height)]",
        options: [],
        metrics: metrics,
        views: views)
    
    view.addConstraints(view_width)
    view.addConstraints(view_height)
}


func animateView(views : [UIView] , verticalShift : CGFloat , horizontalShift : CGFloat , completionHandler : ()-> ())
{
    let duration = 0.3
    let delay = 0.0
    let options = UIViewKeyframeAnimationOptions.CalculationModePaced
    
    UIView.animateKeyframesWithDuration(duration, delay: delay, options: options, animations:
        {
            // each keyframe needs to be added here
            // within each keyframe the relativeStartTime and relativeDuration need to be values between 0.0 and 1.0
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1/3, animations:
                {
                    
                    for view in views
                    {
                        view.frame.origin.y += verticalShift / 3
                        view.frame.origin.x += horizontalShift / 3
                    }
                    
                    
                    
            })
            UIView.addKeyframeWithRelativeStartTime(1/3, relativeDuration: 1/3, animations:
                {
                    for view in views
                    {
                        view.frame.origin.y += verticalShift / 3
                        view.frame.origin.x += horizontalShift / 3
                    }
            })
            UIView.addKeyframeWithRelativeStartTime(2/3, relativeDuration: 1/3, animations:
                {
                    for view in views
                    {
                        view.frame.origin.y += verticalShift / 3
                        view.frame.origin.x += horizontalShift / 3
                    }
            })
            
            
        }, completion: {finished in
            completionHandler()
            
    })
    
}

extension UIButton
{
    func animateWithScale(toSkale : CGFloat , withFinalImg : UIImage?)
    {
        
        //let fullRotation = CGFloat(M_PI * 2)
        let duration = 1.0
        let delay = 0.0
        let options = UIViewKeyframeAnimationOptions.CalculationModePaced
        
        UIView.animateKeyframesWithDuration(duration, delay: delay, options: options, animations:
            {
                // each keyframe needs to be added here
                // within each keyframe the relativeStartTime and relativeDuration need to be values between 0.0 and 1.0
                
                UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1/3, animations:
                    {
                        // start at 0.00s (5s × 0)
                        // duration 1.67s (5s × 1/3)
                        // end at   1.67s (0.00s + 1.67s)
                        //self.container.transform = CGAffineTransformMakeRotation(1/3 * fullRotation)
                        
                        self.transform = CGAffineTransformMakeScale(1, 1)
                        
                })
                UIView.addKeyframeWithRelativeStartTime(1/3, relativeDuration: 1/3, animations:
                    {
                        self.transform = CGAffineTransformMakeScale(toSkale, toSkale)
                        
                        
                })
                UIView.addKeyframeWithRelativeStartTime(2/3, relativeDuration: 1/3, animations:
                    {
                        if let myImg = withFinalImg
                        {
                            self.setImage(myImg, forState: UIControlState.Normal)
                        }
                        self.transform = CGAffineTransformMakeScale(1, 1)
                })
                
                
                
            }, completion: {finished in
                // any code entered here will be applied
                // once the animation has completed
                
        })
        
    }
}


func addSeperatorsToView(view : UIView , width myWidth : CGFloat , height myHeight : CGFloat , up myUp : Bool , down myDown : Bool , left myLeft : Bool , right myRight : Bool)
{
    if myUp
    {
        let sepUp = UIView()
        
        let sepUpSize = ViewConfig(width: myWidth,
            height: CGFloat(0.5),
            upMargin: 0, downMargin: 0, leftMargin: 0, rightMargin: 0)
        
        sepUp.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.3)
        
        setViewSizeConf(sepUp, size: sepUpSize)
        
        view.addSubview(sepUp)
        
        
        view.addConstraint(NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: sepUp,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1, constant: 0))
    }
    
    
    if myDown
    {
        let sepDown = UIView()
        let sepDownSize = ViewConfig(width: myWidth,
            height: CGFloat(0.5),
            upMargin: 0, downMargin: 0, leftMargin: 0, rightMargin: 0)
        sepDown.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.3)
        
        setViewSizeConf(sepDown, size: sepDownSize)
        
        view.addSubview(sepDown)
        
        view.addConstraint(NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: sepDown,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: sepDown,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1, constant: 0))
    }
    
    if myLeft
    {
        let leftSep = UIView()
        let leftSepSize = ViewConfig(width: CGFloat(0.5),
            height: myHeight,
            upMargin: 0, downMargin: 0, leftMargin: 0, rightMargin: 0)
        
        leftSep.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.3)
        
        
        setViewSizeConf(leftSep, size: leftSepSize)
        
        view.addSubview(leftSep)
        
        
        view.addConstraint(NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Left,
            relatedBy: NSLayoutRelation.Equal,
            toItem: leftSep,
            attribute: NSLayoutAttribute.Left,
            multiplier: 1, constant: 0))
        
    }
    
    
    if myRight
    {
        let rightSep = UIView()
        let rightSepSize = ViewConfig(width: CGFloat(0.5),
            height: myHeight,
            upMargin: 0, downMargin: 0, leftMargin: 0, rightMargin: 0)
        
        rightSep.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.3)
        
        
        setViewSizeConf(rightSep, size: rightSepSize)
        
        view.addSubview(rightSep)
        
        
        view.addConstraint(NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Right,
            relatedBy: NSLayoutRelation.Equal,
            toItem: rightSep,
            attribute: NSLayoutAttribute.Right,
            multiplier: 1, constant: 0))
    }
    
    
    
}


extension UIView
{
    func addSadow()
    {
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 3, height: 0.7)
        self.layer.shadowRadius = 7
        self.layer.zPosition = 1
        
    }
}




