//
//  PodcastsViewController.swift
//  Pod Player
//
//  Created by Virgil DINU on 01/11/2020.
//

import Cocoa

class PodcastsViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var podcastURLTextField: NSTextField!
    
    @IBOutlet weak var tableViewLeft: NSTableView!
    
    var podcasts: [Podcast] = []
    
    var episodesVC: EpisodesViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        podcastURLTextField.stringValue =  "https://www.omnycontent.com/d/playlist/aaea4e69-af51-495e-afc9-a9760146922b/14a43378-edb2-49be-8511-ab0d000a7030/d1b9612f-bb1b-4b85-9c0c-ab0d004ab37a/podcast.rss"
        getPodcast()
    }
    
    func getPodcast() {
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            
            let fetchy = Podcast.fetchRequest() as NSFetchRequest<Podcast>
            fetchy.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            
            do {
                podcasts = try context.fetch(fetchy)
                print(podcasts)
            }
            catch{}
            DispatchQueue.main.async {
                self.tableViewLeft.reloadData()
            }
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
                            if !self.podcastExists(rssURL: self.podcastURLTextField.stringValue) {
                                
                                if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                                    let podcast = Podcast(context: context)
                                    podcast.rssURL = self.podcastURLTextField.stringValue
                                    podcast.imageURL = info.imageURL
                                    podcast.title = info.title
                                    
                                    (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
                                    
                                    self.getPodcast()
                                }
                            }
                        }
                        print("Pasul2!!!")
                    }
                }
            }.resume()
            
            podcastURLTextField.stringValue = "https://teacherluke.libsyn.com/rss"
        }
    }
    
    func podcastExists(rssURL: String) -> Bool {
        
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let fetchy = Podcast.fetchRequest() as NSFetchRequest<Podcast>
            fetchy.predicate = NSPredicate(format: "rssURL == %@", rssURL)
            
            do {
                let matchingPodcasts = try context.fetch(fetchy)
                
                if matchingPodcasts.count >= 1 {
                    return true
                } else {
                    return false
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
            cell?.textField?.stringValue = " UNKNOWN TITLE!"
        }
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let podcast = podcasts[tableViewLeft.selectedRow]
        
        episodesVC?.podcast = podcast
        episodesVC?.updateView()
    }
}

