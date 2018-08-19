//
//  APIConnector.swift
//  WikiSearch
//
//  Created by Darshan K S on 18/08/18.
//  Copyright © 2018 Darshan K S. All rights reserved.
//

import Foundation
import Alamofire

class APIConnector {
    
    static let shared = APIConnector()
    
    private init() {
        
    }
    
    func searchWikiForQueryString(queryString: String, completionHandler handler: @escaping ResponseHandler) {
        
        let params = ["action" : "query", "format": "json", "prop": "pageimages|pageterms", "generator": "prefixsearch", "redirects": 1, "formatversion": 2, "piprop": "thumbnail", "pithumbsize": 50, "pilimit": 20, "wbptterms": "description", "gpssearch": queryString, "gpslimit": 20] as [String : Any]
    
        
        let request = Alamofire.request(APIurls.BASE_URL, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
        
        RequestHandler.sendRequest(request: request, completionHandler: handler)
        
    }
    
    
}
