//
//  Episode.swift
//  Pod Player
//
//  Created by Virgil DINU on 08/11/2020.
//

import Cocoa

class Episode {
    
    var title = ""
    var pubDate = Date()
    var htmlDescription = ""
    var audioURL = ""
    
    static let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzzz "
            return formatter
        }()

    
}

