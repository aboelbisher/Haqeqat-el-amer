//
//  News.swift
//  HaqeqatElAmer
//
//  Created by Muhammad on 10/16/15.
//  Copyright © 2015 Muhammad. All rights reserved.
//

import UIKit

let JSON_CELL_COLOR = "color"
let JSON_FONT_COLOR = "font_color"
let JSON_BG_COLOR = "background_color"
let JSON_CONTENT = "content"
let JSON_DATES = "dates"
let JSON_DATE_DAY = "day"
let JSON_DATE_DATE = "date"
let JSON_DATE_HOUR = "hour"
let JSON_NOTES = "notes"
let JSON_IMAGES = "images"
let JSON_IMAGES_IMAGE = "image"
let JSON_IMAGES_INFO = "info"
let JSON_LINK = "link"
let JSON_VIDEO = "video"


struct Date
{
    var day : String
    var date : String
    var hour : String
}

struct NewsImage
{
    var url : String
    var info : String // description
    //var image : UIImage?
}



enum NewsKind
{
    case NO_MEDIA , YES_MEDIA
}


class News
{
    var cellBgColor : String
    var fontColor : String
    var content : String
    var date : Date
    var fullDate  = ""
    //var notes : [String]
    var images : [NewsImage]
    var link : String
    var videoLink : String
    var kind : NewsKind
    
    
    convenience init(newsDic : NSDictionary)
    {
        self.init()
        if let cellColor = newsDic[JSON_CELL_COLOR] as? String
        {
            self.cellBgColor = cellColor
        }
        
        
        if let fontColor = newsDic[JSON_FONT_COLOR] as? String
        {
            self.fontColor = fontColor
        }
        
        //bgColor = newsDic[JSON_BG_COLOR] as! String
        
        
        if let content = newsDic[JSON_CONTENT] as? String
        {
            self.content = content
        }
        
        
        if let link = newsDic[JSON_LINK] as? String
        {
            self.link = link
        }
        
        
        if let videoLink = newsDic[JSON_VIDEO] as? String
        {
            if videoLink.stringByReplacingOccurrencesOfString(" ", withString: "") != ""
            {
                var newVideoId = ""
                if videoLink.containsString("&")
                {
                    let endRange = videoLink.rangeOfString("&", options: NSStringCompareOptions.LiteralSearch, range: nil, locale: nil)
                    let rangeOfId = Range(start: videoLink.startIndex, end: endRange!.startIndex)
                    newVideoId = videoLink.substringWithRange(rangeOfId)
                    
                }
                else
                {
                    newVideoId = videoLink
                }
                
                
                self.videoLink = newVideoId
            }
           
        }
        
        
        
        //date
        if let datesDic = newsDic[JSON_DATES] as? NSDictionary
        {
            if let day = datesDic[JSON_DATE_DAY] as? String
            {
                if let date = datesDic[JSON_DATE_DATE] as? String
                {
                    if let hour = datesDic[JSON_DATE_HOUR] as? String
                    {
                        self.date = Date(day: day, date: date, hour: hour)
                        
                        self.fullDate = date + " " + day + " " + hour
                    }

                }
            }
        }
        
        //images
        var imagesArr = [NewsImage]()
        if let imagesJsonArray = newsDic[JSON_IMAGES] as? JSONArray
        {
            
            for image in imagesJsonArray
            {
                if let myImage = image as? NSDictionary
                {
                    let url = myImage[JSON_IMAGES_IMAGE] as! String
                    let info = myImage[JSON_IMAGES_INFO] as! String
                    
                    let newsImage = NewsImage(url: url, info: info )
                    
                    imagesArr.append(newsImage)
                }
            
            }
            
            self.images = imagesArr
            
        }
        
        if self.images.count == 0 && (self.videoLink.stringByReplacingOccurrencesOfString(" ", withString: "") == "")
        {
            self.kind = .NO_MEDIA
        }
        

        
        
    }
    
    
    init()
    {
        self.cellBgColor = ""
        self.fontColor = ""
        self.content = ""
        self.date = Date(day: "", date: "", hour: "")
        self.images = [NewsImage]()
        self.link = ""
        self.videoLink = ""
        self.kind = .YES_MEDIA
    }

}
































