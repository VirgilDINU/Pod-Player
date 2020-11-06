//
//  EpisodesViewController.swift
//  Pod Player
//
//  Created by Virgil DINU on 06/11/2020.
//

import Cocoa

class EpisodesViewController: NSViewController {
    
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var pausePlayButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    var podcast: Podcast? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func updateView() {
        
        if podcast?.title != nil{
            titleLabel.stringValue = (podcast?.title)!
        }
        
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
    }
    
    @IBAction func pausePlayClicked(_ sender: Any) {
    }
    
}
