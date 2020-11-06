//
//  Parser.swift
//  Pod Player
//
//  Created by Virgil DINU on 01/11/2020.
//

import Foundation

class Parser {
    
    func getPosdcastMetaData( data: Data) -> (title: String?, imageURL: String?) {
         
        let xml = SWXMLHash.parse(data)
        print("Am preluat cu succes 'Data' si printam url-ul")
        print(xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text)
        print("Returnam doua String: 'title' si 'imageURL'")
        return (xml["rss"]["channel"]["title"].element?.text, xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text)
    
    }
}
