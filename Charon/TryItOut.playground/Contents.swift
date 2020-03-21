import Foundation

let home = FileManager.default.homeDirectoryForCurrentUser

let playgroundPath = "Documents/Work/Freeletics/fl-application-ios"
let playgroundUrl = home.appendingPathComponent(playgroundPath)

playgroundUrl.path
playgroundUrl.absoluteString
playgroundUrl.absoluteURL
playgroundUrl.baseURL
playgroundUrl.pathComponents
playgroundUrl.lastPathComponent
playgroundUrl.pathExtension
playgroundUrl.isFileURL
playgroundUrl.hasDirectoryPath


let fileManager = FileManager.default

do {
    let contents = try fileManager.contentsOfDirectory(atPath: playgroundUrl.path)
    
    let urls = contents.map { return playgroundUrl.appendingPathComponent($0) }
//    print("\(urls)")
} catch let error{
    print("\(error)")
}

//do {
//    let resourceKeys : [URLResourceKey] = [.creationDateKey, .isDirectoryKey]
////    let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//    let enumerator = FileManager.default.enumerator(at: playgroundUrl,
//                            includingPropertiesForKeys: resourceKeys,
//                                               options: [.skipsHiddenFiles], errorHandler: { (url, error) -> Bool in
//                                                        print("directoryEnumerator error at \(url): ", error)
//                                                        return true
//    })!
//
//    for case let fileURL as URL in enumerator {
//        let resourceValues = try fileURL.resourceValues(forKeys: Set(resourceKeys))
//        print(fileURL.path, resourceValues.creationDate!, resourceValues.isDirectory!)
//    }
//} catch {
//    print(error)
//
//}

let exampleFile = "/Users/rob/Documents/Work/Freeletics/fl-application-ios/Freeletics/Spaces/TrainingSpots/TrainingSpotDetailViewController.swift"

do {
    var file = try String(contentsOf: URL(fileURLWithPath: exampleFile), encoding: .utf8)
    file = file.replacingOccurrences(of: "\n", with: " \n")
    let strings = (file.split(separator: " "))
    var array = [(String, String)]()
    for (index, string) in strings.enumerated() {
        if let first = string.first, first.isUppercase {
            array.append((String(string), String(string)))
        }
    }
    print(array)
} catch {
    print(error)
}
