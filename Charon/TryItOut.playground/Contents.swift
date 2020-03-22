import Foundation

let home = FileManager.default.homeDirectoryForCurrentUser

let playgroundPath = "Documents/Work/Freeletics/fl-application-ios"
let playgroundUrl = home.appendingPathComponent(playgroundPath)

enum SwiftType: String {
    case classType = "class", structType = "struct", enumType = "enum", protocolType = "protocol"
}

func mainTypes(inFile url: URL) -> [(SwiftType, String)]? {
    do {
        let file = try String(contentsOf: url, encoding: .utf8)
        let strings = file.components(separatedBy: .whitespacesAndNewlines)
        var mainTypes = [(SwiftType, String)]()
        for (index, string) in strings.enumerated() {
            if let swiftType = SwiftType(rawValue: String(string)),
                let firstCharacter = strings[index + 1].first,
                firstCharacter.isUppercase {
                mainTypes.append((swiftType, String(strings[index + 1 ])))
            }
        }
        //        print("------")
        //        print(array)
        return mainTypes
    } catch {
        print(error)
        return nil
    }
    //    print()
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

var types = [String]()

for case let fileURL as URL in enumerator {
    // add Test for "h", "m"
    if ["swift"].contains(fileURL.pathExtension) {
        if let mainTypes = mainTypes(inFile: fileURL), !mainTypes.isEmpty {
            types.append(contentsOf: mainTypes.map({ $0.1 }))
            print(fileURL.path)
            print(mainTypes)
            print()
        }
    }
}

print(types)
print(types.count)
