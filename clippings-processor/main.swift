import Foundation

let workingDirectory = "~/Documents/library/_clippings/"
let clippingsFile = "My Clippings.txt"
let clippingsFilePath: NSString = workingDirectory + clippingsFile
let authorRegexPattern = "\\(.+\\)$"

var fileContents: NSString? = nil

do {
    fileContents = try NSString(contentsOfFile: clippingsFilePath.stringByExpandingTildeInPath, encoding: NSUTF8StringEncoding)
}
catch {
    print("Failed to open file at path \(clippingsFilePath) with error \(error)")
    exit(1)
}

if let fileContents = fileContents {
    let separatedArray = fileContents.componentsSeparatedByString("==========")
    let clippingsDictionary = processClippingsArray(separatedArray)
    
    let processedFolderPath = NSString(string: NSString(string:workingDirectory).stringByExpandingTildeInPath).stringByAppendingPathComponent("processed")
    
    writeClippings(clippingsDictionary, toPath: processedFolderPath)
}
else {
    print("Nil file contents")}



