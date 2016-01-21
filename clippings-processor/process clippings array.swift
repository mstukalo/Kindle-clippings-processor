//
//  process clippings array.swift
//  clippings-processor
//
//  Created by Mykola Stukalo on 21.01.16.
//  Copyright © 2016 Mykola Stukalo. All rights reserved.
//

import Foundation

//this functions puts titles and clippings to the dictionary. Author strings are keys
func processClippingsArray(clippingsArray: [String]) -> [String: (title:String, clippings: String)] {
    var clippingsDictionary: [String: (title:String, clippings: String)] = Dictionary()
    
    for clipping in clippingsArray {
        //delete bookmarks data
        if clipping.containsString("Your Bookmark on Location") {
            continue
        }
        
        //ignore empty strings
        if NSString(string: clipping).length == 0 {
            continue
        }
        
        let tuple = parseClipping(clipping)
        
        //place clippings into the dictionary
        if let tuple = tuple {
            let titleClippingTuple = clippingsDictionary[tuple.author]
            if let titleClippingTuple = titleClippingTuple {
                let clippings = titleClippingTuple.clippings + "\n" + "\t" + tuple.clipping
                clippingsDictionary[tuple.author] = (tuple.title, clippings)
            }
            else
            {
                clippingsDictionary[tuple.author] = (tuple.title, "\t" + tuple.clipping)
            }
        }
        else {
            print("Failed to find author in clipping \(clipping)")
        }
    }

    return clippingsDictionary
}