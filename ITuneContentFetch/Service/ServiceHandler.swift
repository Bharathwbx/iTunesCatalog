//
//  ServiceHandler.swift
//  ITuneContentFetch
//
//  Created by Bharatraj Rai on 4/3/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import Foundation



/**
 Service singleton class has been implemenetd to make any service request

*/

class Service {
    
    let baseUrlString = "https://itunes.apple.com/search?term="
    
    static let shared = Service()
    
    private init() {}
    
    /// getDataFromApi is generic api which accept the url and data type to decode the response which return back model to calling method. If there is any error while parsing or fetching from the service then result  will be sent as nil and error parameter is with error data.
    
    func getDataFromApi<T: Codable>(url: URL, resultType: T.Type, completionHandler: @escaping(_ result: T?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
            } else {
                    do {
                        let result = try JSONDecoder().decode(T.self, from: data!)
                        completionHandler(result, nil)

                    } catch let error {
                        print("Error occured while decoding", error)
                        completionHandler(nil, error)
                    }
                }
        }.resume()
    }
}
