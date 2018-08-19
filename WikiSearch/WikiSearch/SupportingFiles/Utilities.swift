//
//  Utilities.swift
//  WikiSearch
//
//  Created by Darshan K S on 19/08/18.
//  Copyright © 2018 Darshan K S. All rights reserved.
//

import Foundation

/// Cache class to handle max cache size and count.
class ImageCache {
    static let sharedCache: NSCache = { () -> NSCache<AnyObject, AnyObject> in
        let cache = NSCache<AnyObject, AnyObject>()
        cache.name = "ImageCache"
        cache.countLimit = 50
        cache.totalCostLimit = 30*1024*1024
        return cache
    }()
}
