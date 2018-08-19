//
//  WebViewController.swift
//  WikiSearch
//
//  Created by Darshan K S on 19/08/18.
//  Copyright © 2018 Darshan K S. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    static let identifier = "WebViewController"
    
    var url : String?
    
    @IBOutlet weak var webview: WKWebView!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlString = url, let webURL = URL(string: urlString){
            
            webview.load(URLRequest(url:webURL, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 5.0))
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
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
