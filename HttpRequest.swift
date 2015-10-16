//
//  Httprequests.swift
//  AllMuz
//
//  Created by muhammad abed el razek on 6/14/15.
//  Copyright (c) 2015 muhammad abed el razek. All rights reserved.
//

import UIKit

func makeRequest(method : String , api : String , params : Dictionary<String , AnyObject>? , values : Dictionary<String , String> , completionHandler : (NSDictionary->Void)?)
{
    
    var request = NSMutableURLRequest(URL: NSURL(string:api)!)
    var session = NSURLSession.sharedSession()
    request.HTTPMethod = method
    
    
    //    NSJSONSerialization.JSONObjectWithData(<#data: NSData#>, options: <#NSJSONReadingOptions#>, error: <#NSErrorPointer#>)
    
    
    // var err: NSError?
    
    for keyValue in values
    {
        request.addValue(keyValue.1, forHTTPHeaderField: keyValue.0)
    }
    
    //var params = ["emailToFollow":self.user!.email, "follow" : follow.description] as Dictionary<String, String>
    
    
    if let myParams = params
    {
        //        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(myParams, options: nil, error: &err)
        do
        {
            try request.HTTPBody = NSJSONSerialization.dataWithJSONObject(myParams, options: [])
            
        }
        catch
        {
            print("error \n")
        }
    }
    
    
    //var httpRes = HttpPostREsult.FAIL
    
    
    
    let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        //var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
        //        var err: NSError?
        
        do
        {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            
            print("request sent \n")
            if let parseJSON = json
            {
                if let myComplitionHandler = completionHandler
                {
                    myComplitionHandler(parseJSON)
                }
            }
            else
            {
                // the json object was nil, something went worng. Maybe the server isn't running?
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: \(jsonStr) \n")
            }
            
        }
        catch let error as NSError
        {
            print("error \(error.localizedDescription)")
            let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            print("error \(jsonStr)")
        }
        
    })
    task.resume()
    
}


func makeRequestWithJsonArray(method : String , api : String , params : Dictionary<String , AnyObject>? , values : Dictionary<String , String>? , completionHandler : ((JSONArray , [NSObject : AnyObject])->Void)?)
{
    
    let request = NSMutableURLRequest(URL: NSURL(string:api)!)
    let session = NSURLSession.sharedSession()
    request.HTTPMethod = method
    
    
    //var err: NSError?
    
    if let myValues = values
    {
        for keyValue in myValues
        {
            request.addValue(keyValue.1, forHTTPHeaderField: keyValue.0)
        }
    }
    
    
    //var params = ["emailToFollow":self.user!.email, "follow" : follow.description] as Dictionary<String, String>
    
    
    if let myParams = params
    {
        //        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(myParams, options: nil, error: &err)
        do
        {
            try request.HTTPBody = NSJSONSerialization.dataWithJSONObject(myParams, options: [])
            
        }
        catch
        {
            print("error \n")
        }
    }
    
    //var httpRes = HttpPostREsult.FAIL
    
    let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
        //var err: NSError?
        do
        {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? JSONArray
            let headerDic = (response as! NSHTTPURLResponse).allHeaderFields
            
            print("request sent \n")
            if let parseJSON = json
            {
                
                
                if let myComplitionHandler = completionHandler
                {
                    myComplitionHandler(parseJSON , headerDic)
                }
            }
            else
            {
                // the json object was nil, something went worng. Maybe the server isn't running?
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: \(jsonStr) \n")
            }
            
        }
        catch let error as NSError
        {
            print(error.localizedDescription + "\n")
            let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Error could not parse JSON: \(jsonStr) \n")
            
        }
        
        
        
    })
    task.resume()
}

func makeRequesWithString(method : String , api : String , params : Dictionary<String , AnyObject>? , values : Dictionary<String , String> , completionHandler : (NSString->Void)?)
{
    let request = NSMutableURLRequest(URL: NSURL(string:api)!)
    let session = NSURLSession.sharedSession()
    request.HTTPMethod = method
    
    
    //var err: NSError?
    
    for keyValue in values
    {
        request.addValue(keyValue.1, forHTTPHeaderField: keyValue.0)
    }
    
    //var params = ["emailToFollow":self.user!.email, "follow" : follow.description] as Dictionary<String, String>
    
    
    if let myParams = params
    {
        //        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(myParams, options: nil, error: &err)
        do
        {
            try request.HTTPBody = NSJSONSerialization.dataWithJSONObject(myParams, options: [])
            
        }
        catch
        {
            print("error \n")
        }
    }
    
    //var httpRes = HttpPostREsult.FAIL
    
    let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
        
        if let myComplitionHandler = completionHandler
        {
            myComplitionHandler(strData!)
        }
        
        
    })
    task.resume()
    
}

