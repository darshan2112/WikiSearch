//
//  SearchViewController.swift
//  WikiSearch
//
//  Created by Darshan K S on 18/08/18.
//  Copyright © 2018 Darshan K S. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchControllerDelegate {

    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func configureSearchBar() {
        
        let searchBar = searchController.searchBar
        
        searchBar.tintColor = UIColor.white
        searchBar.barTintColor = UIColor.white
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.blue
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        
        if let navigationbar = self.navigationController?.navigationBar {
            navigationbar.barTintColor = #colorLiteral(red: 0.737254902, green: 0.8784313725, blue: 0.9921568627, alpha: 1)
        }
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
