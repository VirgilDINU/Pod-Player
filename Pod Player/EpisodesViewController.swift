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
    var podcastsVC: PodcastsViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func updateView() {
        
        if podcast?.title != nil{
            titleLabel.stringValue = (podcast?.title)!
        }
        
        if podcast?.imageURL != nil{
            
            let image = NSImage(byReferencing: URL(string: (podcast?.imageURL)!)!)
            imageView.image = image
        }
        
        pausePlayButton.isEnabled = false
        
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        
        if podcast != nil{
            if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(podcast!)
                (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
                podcastsVC?.getPodcast()
            }
        }
    }
    
    @IBAction func pausePlayClicked(_ sender: Any) {
    }
    
}
