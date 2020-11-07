//
//  TheSplitViewController.swift
//  Pod Player
//
//  Created by Virgil DINU on 06/11/2020.
//

import Cocoa

class TheSplitViewController: NSSplitViewController {
    
    
    @IBOutlet weak var podcastsItem: NSSplitViewItem!
    
    @IBOutlet weak var episodesItem: NSSplitViewItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        if let podcatsVC = podcastsItem.viewController as? PodcastsViewController {
            if let episodesVC = episodesItem.viewController as? EpisodesViewController {
                podcatsVC.episodesVC = episodesVC
                episodesVC.podcastsVC = podcatsVC
            }
        }
    }
    
}
