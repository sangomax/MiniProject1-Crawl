//
//  main.swift
//  MiniProject1
//
//  Created by Adriano Gaiotto de Oliveira on 2021-03-11.
//

import Foundation


let fileManager = FileManager.default

let url = URL(string: "/Users/adrianogaiotto/Downloads")!//fileManager.currentDirectoryPath)!

var l = "├─ "

try? dive(url, l, 1)

func dive(_ url: URL, _ indent: String, _ level: Int) throws {
    
    var loc : String = indent
    
    let urls = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: .none, options: .skipsHiddenFiles)
    
    var count = 0
    
    for item in urls {
        let pathBroke = item.path.split(separator: "/")
        if(count == urls.count - 1) {
            print(loc[0, loc.count - 3] + "└─ " + pathBroke[pathBroke.count-1])
            if (loc.count > (level * 3) - 1 ) {
                let before = loc[0,(level - 1) * 3 ]
                loc = before + "   " + loc[loc.count - 3,loc.count]
            } else {
                loc = "   " + loc
            }
        } else {
            print(loc + pathBroke[pathBroke.count-1])
            if (loc.count > (level * 3) - 1 ) {
                let before = loc[0,(level - 1) * 3]
                loc = before + "│  " + loc[loc.count - 3,loc.count]
            } else {
                loc = "│  " + loc
            }
        }
        
        if (try? dive(item, loc, level + 1)) == nil {}
        
        count += 1
        loc = indent
    }
}

extension String {
    subscript(index: Int) -> String {
        get {
            return String(self[self.index(startIndex, offsetBy: index)])
        }
        set {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            self = self.replacingCharacters(in: startIndex..<self.index(after: startIndex), with: newValue)
        }
    }
    
    subscript(start: Int, end: Int) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: start)
            let endIndex = self.index(self.startIndex, offsetBy: end)
            return String(self[startIndex..<endIndex])
        }
        set {
            let startIndex = self.index(self.startIndex, offsetBy: start)
            let endIndex = self.index(self.startIndex, offsetBy: end)
            self = self.replacingCharacters(in: startIndex..<endIndex, with: newValue)
        }
    }
}
