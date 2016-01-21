//
//  write clippings.swift
//  clippings-processor
//
//  Created by Mykola Stukalo on 21.01.16.
//  Copyright © 2016 Mykola Stukalo. All rights reserved.
//

import Foundation

//tries to write clippings to text files
func writeClippings(clippings:[String: (title:String, clippings: String)], toPath: String) {
    let fileManager = NSFileManager.defaultManager()
    
    if fileManager.fileExistsAtPath(toPath) {
        do {
            try fileManager.removeItemAtPath(toPath)
        }
        catch {
            print("Failed to delete folder at path \(toPath) with error \(error)")
        }
    }
    
    do {
        try fileManager.createDirectoryAtPath(String(toPath), withIntermediateDirectories: true, attributes: nil)
    }
    catch {
        print("Failed to create directory at path \(toPath) with error \(error)")
    }
    
    for (author, titleClippingTuple) in clippings {
        let fileName = author + " - " + titleClippingTuple.title + ".txt"
        let path = NSString(string: toPath).stringByAppendingPathComponent(fileName)
        do {
            try titleClippingTuple.clippings.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
        }
        catch {
            print("Failed to write clipping to path \(path) with error \(error)")
        }
    }

}