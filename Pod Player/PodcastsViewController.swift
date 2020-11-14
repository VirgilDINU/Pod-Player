//
//  PodcastsViewController.swift
//  Pod Player
//
//  Created by Virgil DINU on 01/11/2020.
//

import Cocoa


class PodcastsViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var podcastURLTextField: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    
    var podcasts: [Podcast] = []
    var episodesVC: EpisodesViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        podcastURLTextField.stringValue = "https://feeds.simplecast.com/pvzhyDQn"
        getPodcast()
    }
    
    func getPodcast() {
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            let fetchy = Podcast.fetchRequest() as NSFetchRequest<Podcast>
            fetchy.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            do {
                podcasts = try context.fetch(fetchy)
                print(podcasts)
                print("S-a executat getPodcast().")
            }
            catch{}
            self.tableView.reloadData()
            
            
        }
    }
    
    @IBAction func addPodcastButton(_ sender: Any) {
        if let url = URL(string: podcastURLTextField.stringValue) {
            URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    print(error!)
                }
                else{
                    if data != nil {
                        let parser = Parser()
                        let info = parser.getPosdcastMetaData(data: data!)
                        DispatchQueue.main.async {
                            if self.podcastExists(rssURL: self.podcastURLTextField.stringValue) {
                                if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                                    let podcast = Podcast(context: context)
                                    podcast.rssURL = self.podcastURLTextField.stringValue
                                    podcast.imageURL = info.imageURL
                                    podcast.title = info.title
                                    (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
                                    self.getPodcast()
                                    DispatchQueue.main.async {
                                        self.podcastURLTextField.stringValue = ""
                                    }
                                    print("S-a executat addPodcastButton(_ sender: Any).")
                                }
                            }
                        }
                    }
                }
                
            }.resume()
        }
        
        
    }
    
    func podcastExists(rssURL: String) -> Bool {
        
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let fetchy = Podcast.fetchRequest() as NSFetchRequest<Podcast>
            fetchy.predicate = NSPredicate(format: "rssURL == %@", rssURL)
            
            do {
                let matchingPodcasts = try context.fetch(fetchy)
                if matchingPodcasts.count >= 1 {
                    return false
                } else {
                    return true
                }
            } catch {}
        }
        return false
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "podcastcell"), owner: self) as? NSTableCellView
        
        let podcast = podcasts[row]
        
        if podcast.title != nil {
            cell?.textField?.stringValue = podcast.title!
        } else {
            cell?.textField?.stringValue = "UNKNOWN TITLE!"
        }
        
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        if tableView.selectedRow >= 0 {
            let podcast = podcasts[tableView.selectedRow]
            
            episodesVC?.podcast = podcast
            episodesVC?.updateView()
        }
        
    }
    
    
    
    
}

/*
 https://teacherluke.libsyn.com/rss
 https://feeds.megaphone.fm/the-daily-show
 http://feedproxy.google.com/~r/TheJimmyDoreShow/~3/L8DVYZuuetI/TJDS_20201028_Podcast.mp3?utm_source=listennotes.com&utm_campaign=Listen+Notes&utm_medium=website
 https://feeds.simplecast.com/pvzhyDQn
 https://podcasts.files.bbci.co.uk/p07h19zz.rss
 https://feeds.megaphone.fm/ESP7239282233
 */
