import Foundation

enum SwiftType: String {
    case classType = "class", structType = "struct", enumType = "enum", protocolType = "protocol", extensionType = "extension"
}

func mainTypes(inFile url: URL) -> (mainType: [String], links: [(String, String)])? {
    do {
        var stack = [String]()
        var currentType: String?
        let file = try String(contentsOf: url, encoding: .utf8)
        let strings = file.components(separatedBy: .whitespacesAndNewlines)
        var mainTypes = [String]()
        var links = [(String, String)]()
        for (index, string) in strings.enumerated() {
            if let _ = SwiftType(rawValue: String(string)),
                let firstCharacter = strings[index + 1].first,
                firstCharacter.isUppercase {
                let foundType = String(strings[index + 1 ])
                mainTypes.append(foundType)
                currentType = foundType
//                print(string)
                continue
            }
            if string == "{" {
//                guard let currentType = currentType else {
//                    assertionFailure("currentType cannot be nil if an { occurs. In \(url.absoluteString)")
//                    continue
//                }
                stack.append(currentType ?? "")
            }
            if string == "}" {
                currentType = stack.popLast()
            }
            if let currentType = currentType,
                let firstCharacter = string.first,
                firstCharacter.isUppercase {
                links.append((currentType, string))
            }
        }
        
//        print(links)
        //        print("------")
        //        print(array)
        return (mainTypes, links)
    } catch {
        print(error)
        return nil
    }
    //    print()
}

let fileManager = FileManager.default

let resourceKeys : [URLResourceKey] = [.creationDateKey, .isDirectoryKey]
let home = FileManager.default.homeDirectoryForCurrentUser

let playgroundPath = "Documents/Work/Freeletics/fl-application-ios"
let playgroundUrl = home.appendingPathComponent(playgroundPath)
//    let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
let enumerator = FileManager.default.enumerator(
    at: playgroundUrl,
    includingPropertiesForKeys: resourceKeys,
    options: [.skipsHiddenFiles],
    errorHandler: { (url, error) -> Bool in
        print("directoryEnumerator error at \(url): ", error)
        return true
})!

var maintypes = [String]()
var links = [(String, String)]()

for case let fileURL as URL in enumerator {
    // add Test for "h", "m"
    if ["swift"].contains(fileURL.pathExtension) {
        if let mainTypesAndLinks = mainTypes(inFile: fileURL),
            !mainTypesAndLinks.mainType.isEmpty {
            maintypes.append(contentsOf: mainTypesAndLinks.mainType)
            links.append(contentsOf: mainTypesAndLinks.links)
//            print(fileURL.path)
//            print(mainTypes)
//            print()
        }
    }
}

print(links)
print("MainTypes: \(maintypes.count) Links: \(links.count)")

//let exampleFile = "/Users/rob/Documents/Work/Freeletics/fl-application-ios/Freeletics/Spaces/TrainingSpots/TrainingSpotDetailViewController.swift"
//
//let url = URL(fileURLWithPath: exampleFile)
//let mainTypesAndLinks = mainTypes(inFile: url)
//mainTypesAndLinks?.mainType
//mainTypesAndLinks?.links

