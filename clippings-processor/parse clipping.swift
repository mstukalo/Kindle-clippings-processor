//
//  parse clipping.swift
//  clippings-processor
//
//  Created by Mykola Stukalo on 21.01.16.
//  Copyright © 2016 Mykola Stukalo. All rights reserved.
//

import Foundation

//this function parces one clipping and returns tuple for author, title and clipping
func parseClipping(clipping: NSString) -> (author: String, title: String, clipping: String)? {
    
    let clipping = clipping.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    let separatedArray = clipping.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
    
    if separatedArray.count == 0 {
        return nil
    }
    
    let authorString: NSString = separatedArray.first!
    
    let regex: NSRegularExpression
    do {
        regex = try NSRegularExpression(pattern: authorRegexPattern, options: NSRegularExpressionOptions.CaseInsensitive)
    }
    catch {
        print("Failed to create regex with pattern \(authorRegexPattern)")
        exit(0)
    }
    
    let matchRange = regex.rangeOfFirstMatchInString(String(authorString), options: .ReportProgress, range: NSMakeRange(0, authorString.length))
    
    if matchRange.location == NSNotFound {
        
        //sometimes author - title may be in other format than "title (author)
        let titleAuthorArray = authorString.componentsSeparatedByString(" - ")
        if titleAuthorArray.count == 2 {
            let author = titleAuthorArray.first!
            let title = titleAuthorArray.last!
            
            return (author, title, String(separatedArray.last!))
        }
        else {
            print("Failed to find author in clipping \(clipping)")
            return nil
        }
    }
    
    var author = authorString.substringWithRange(matchRange)
    
    let title = authorString.stringByReplacingOccurrencesOfString(author as String, withString: "").stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    
    author = author.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "()"))
    
    return (author, title, String(separatedArray.last!))
}
