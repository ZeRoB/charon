import Foundation

let home = FileManager.default.homeDirectoryForCurrentUser

let playgroundPath = "Documents/Work/Freeletics/fl-application-ios"
let playgroundUrl = home.appendingPathComponent(playgroundPath)
enum swiftType: String {
    case classType = "class", structType = "struct", enumType = "enum"
}

func test(url: URL) {
    do {
        let file = try String(contentsOf: url, encoding: .utf8)
        let strings = file.components(separatedBy: .whitespacesAndNewlines)
        var array = [(String, String)]()
        for (index, string) in strings.enumerated() {
            if let swiftType = swiftType(rawValue: String(string)) {
                array.append((swiftType.rawValue, String(strings[index + 1 ])))
            }
        }
        print("------")
        print(array)
    } catch {
        print(error)
    }
}

let fileManager = FileManager.default

do {
    let resourceKeys : [URLResourceKey] = [.creationDateKey, .isDirectoryKey]
//    let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let enumerator = FileManager.default.enumerator(at: playgroundUrl,
                            includingPropertiesForKeys: resourceKeys,
                                               options: [.skipsHiddenFiles], errorHandler: { (url, error) -> Bool in
                                                        print("directoryEnumerator error at \(url): ", error)
                                                        return true
    })!

    for case let fileURL as URL in enumerator {
        guard ["swift", "h", "m"].contains(fileURL.pathExtension) else {
            continue
        }
        let resourceValues = try fileURL.resourceValues(forKeys: Set(resourceKeys))
        print(fileURL.path, resourceValues.creationDate!, resourceValues.isDirectory!)
        test(url: fileURL)
    }
} catch {
    print(error)

}

//let exampleFile = "/Users/rob/Documents/Work/Freeletics/fl-application-ios/Freeletics/Spaces/TrainingSpots/TrainingSpotDetailViewController.swift"
//
//test(url: URL(fileURLWithPath: exampleFile))
