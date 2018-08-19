//
//  Extensions.swift
//  WikiSearch
//
//  Created by Darshan K S on 19/08/18.
//  Copyright © 2018 Darshan K S. All rights reserved.
//

import UIKit

extension NSURL{
    
    typealias ImageCacheCompletion = (UIImage) -> Void
    
    // Retrieves a pre-cached image, or nil if it isn't cached.
    var cachedImage: UIImage? {
        return ImageCache.sharedCache.object(
            forKey: absoluteString as AnyObject) as? UIImage
    }
    
    // Fetches the image from the network.
    func fetchImage(completion: @escaping ImageCacheCompletion) {
        let task = URLSession.shared.dataTask(with: self as URL) {
            data, response, error in
            if error == nil {
                if let  data = data,
                    let image = UIImage(data: data) {
                    ImageCache.sharedCache.setObject(
                        image,
                        forKey: self.absoluteString as AnyObject,
                        cost: data.count)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
        task.resume()
    }
}


extension UIView {
    
    /// Method to make rounded cross on either sides of a view. If the view is square, rounded corners will lead to circular view
    func configureRoundedCorner(withRadius radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    
}
