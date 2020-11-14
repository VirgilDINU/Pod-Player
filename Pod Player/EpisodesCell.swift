//
//  EpisodesCell.swift
//  Pod Player
//
//  Created by Virgil DINU on 14.11.2020.
//

import Cocoa
import WebKit

class EpisodesCell: NSTableCellView {

    @IBOutlet weak var descriptionWebView: WKWebView!
    @IBOutlet weak var pubDateLabel: NSTextField!
    @IBOutlet weak var titleLabel: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
