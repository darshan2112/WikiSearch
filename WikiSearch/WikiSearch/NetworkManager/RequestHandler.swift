//
//  RequestHandler.swift
//  WikiSearch
//
//  Created by Darshan K S on 18/08/18.
//  Copyright © 2018 Darshan K S. All rights reserved.
//

import Foundation
import Alamofire

typealias ResponseHandler = (Int, Data?, Error?) -> Void

class RequestHandler {
    
    private static let successCodes = [200]
    
    class func sendRequest(request: DataRequest, completionHandler handler: @escaping ResponseHandler) {
        
        request.responseData { (response) in
            
            switch response.result{
                
            case .success(let data):
                
                if let statusCode = response.response?.statusCode {
                    
                    print("Status Code : \(statusCode)")
                    
                    if successCodes.contains(statusCode){
                        
                        let jsonData = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        print("Response: \(jsonData)")
                        
                       handler(statusCode, data, nil)
                        
                    } else {
                        
                        let error = NSError(domain: "WIKI API DOMAIN", code: 500, userInfo: ["message": "No Data found"])
                        
                        handler(statusCode, nil, error)
                        
                    }
                }
                
            case .failure(let error):
                
                print(error.localizedDescription)
                
                handler(response.response!.statusCode, nil, error)
                
            }
        }

    }
    
}
