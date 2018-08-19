//
//  WikiSearchObject.swift
//  WikiSearch
//
//  Created by Darshan K S on 19/08/18.
//  Copyright © 2018 Darshan K S. All rights reserved.
//

import Foundation

class WikiSearchObject : Codable {
    
    var query : QueryObject?

}

class QueryObject: Codable {
    
    var pages: [WikiPage]?
    
}


class WikiPage: Codable {
    
    var pageId: Int!
    var title: String!
    var thumbnail: WikiThumbnail?
    var index: Int!
    var terms: WikiTerms?
    
}

class WikiThumbnail: Codable {
    
    var source: String?
    
}

class WikiTerms: Codable {
    
    var description : [String]?
    
}
