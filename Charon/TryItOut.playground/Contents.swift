import Foundation

let home = FileManager.default.homeDirectoryForCurrentUser

let playgroundPath = "Documents/Work/Freeletics/fl-application-ios"
let playgroundUrl = home.appendingPathComponent(playgroundPath)

enum swiftType: String {
    case classType = "class", structType = "struct", enumType = "enum"
}

func testSwift(url: URL) {
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
    print()
}

let fileManager = FileManager.default

let resourceKeys : [URLResourceKey] = [.creationDateKey, .isDirectoryKey]
//    let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
let enumerator = FileManager.default.enumerator(at: playgroundUrl,
                                                includingPropertiesForKeys: resourceKeys,
                                                options: [.skipsHiddenFiles], errorHandler: { (url, error) -> Bool in
                                                    print("directoryEnumerator error at \(url): ", error)
                                                    return true
})!

for case let fileURL as URL in enumerator {
    // add Test for "h", "m"
    if ["swift"].contains(fileURL.pathExtension) {
        print(fileURL.path)
        testSwift(url: fileURL)
    }
}
