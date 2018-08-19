//
//  SearchViewController.swift
//  WikiSearch
//
//  Created by Darshan K S on 18/08/18.
//  Copyright © 2018 Darshan K S. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBarTextChangeTimer : Timer?
    
    var wikiPages = [WikiPage]() {
        
        didSet {
            searchResultsTableView.reloadData()
        }   
    }
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchBar()
        self.configureTableViewProperties()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureTableViewProperties() {
        
        self.searchResultsTableView.register( UINib.init(nibName: SearchListTableViewCell.identifier, bundle: nil) , forCellReuseIdentifier: SearchListTableViewCell.identifier)
        self.searchResultsTableView.estimatedRowHeight = 80.0
        self.searchResultsTableView.rowHeight = UITableViewAutomaticDimension
        
    }

    func configureSearchBar() {
        
        //Setup Search Controller
        self.searchController.obscuresBackgroundDuringPresentation = false
        
        self.searchController.searchBar.placeholder = "Type here to search"
        
        let cancelButtonAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
        
        self.definesPresentationContext = true
        
        let searchBar = searchController.searchBar
        
        searchBar.tintColor = UIColor.white
        searchBar.barTintColor = UIColor.white
        searchBar.delegate = self
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.blue
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        
        if let navigationbar = self.navigationController?.navigationBar {
            navigationbar.barTintColor = #colorLiteral(red: 0.09799999744, green: 0.6859999895, blue: 1, alpha: 1)
        }
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func showErrorPopUp(withMessage message: String) {
        
        let alertController = UIAlertController(title: "Could not complete action", message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action) in
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func getSearchResults(forQueryString query: String) {
        
        APIConnector.shared.searchWikiForQueryString(queryString: query) { (statusCode, data, error) in
            
            if let error = error {
                
                self.showErrorPopUp(withMessage: error.localizedDescription)
            }
            
            if let responseData = data {
                
                let wikiResponse = try? JSONDecoder().decode(WikiSearchObject.self, from: responseData)
                
                if let wikiSearchObject = wikiResponse, let pages = wikiSearchObject.query?.pages?.sorted(by: {$0.index < $1.index}){
                    self.wikiPages.removeAll()
                    self.wikiPages = pages
                }
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let searchText = searchBar.text, searchText.count > 2 {
            
            if let searchTimer = self.searchBarTextChangeTimer {
                searchTimer.invalidate()
                self.searchBarTextChangeTimer = nil
            }
            
            self.searchBarTextChangeTimer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false, block: { (timer) in
                self.getSearchResults(forQueryString: searchText)
            })
            
        } else {
            self.wikiPages.removeAll()
        }
    }
    
}



extension SearchViewController : UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wikiPages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchListTableViewCell.identifier) as! SearchListTableViewCell
        
        let page = self.wikiPages[indexPath.row]
        
        cell.titleLabel.text = page.title
        
        if let description = page.terms?.description {
            
            cell.descriptionLabel.text = description.count > 0 ? description[0] : ""
            
        }
        
        //Loading image from cache if present
        if let url = page.thumbnail?.source, let image = NSURL(string: url)?.cachedImage{
            DispatchQueue.main.async {
                cell.thumbnailImageView.image = image
                cell.thumbnailImageView.alpha = 1
            }
            
        } else{
            
            cell.thumbnailImageView.alpha = 0
            
            if let url = page.thumbnail?.source {
                // Download image if not present in cache and if it is valid URL
                NSURL(string: url)?.fetchImage(completion: { (image) in
                    
                    DispatchQueue.main.async {
                        cell.thumbnailImageView.image = image
                    }
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        cell.thumbnailImageView.alpha = 1
                        
                    })
                })
            }
        }
        
        return cell
    }
}


extension SearchViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let page = self.wikiPages[indexPath.row]
        
        let webVC = self.storyboard?.instantiateViewController(withIdentifier: WebViewController.identifier) as! WebViewController
        let url = APIurls.WEB_PAGE_BASE_URL + page.title.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlPathAllowed)!
        webVC.url = url
        self.present(webVC, animated: true, completion: nil)
        
    }
    
    
}
