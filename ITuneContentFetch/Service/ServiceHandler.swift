//
//  ServiceHandler.swift
//  ITuneContentFetch
//
//  Created by Bharatraj Rai on 4/3/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import Foundation


class Service {
    
    let baseUrlString = "https://itunes.apple.com/search?term="
    
    static let shared = Service()
    
    private init() {}
    
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
