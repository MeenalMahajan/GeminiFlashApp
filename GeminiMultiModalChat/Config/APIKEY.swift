//
//  APIKEY.swift
//  GeminiChat
//
//  Created by Meenal Mahajan on 01/08/25.
//

import Foundation

// fetches api key from p-list
enum APIKEY {
    
    // fetches api key from GenerativeAi-Info list
    static var `default` : String{
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist")
        else {
            fatalError("Couldn't find GenerativeAi-Info.plist")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find API_KEY in GenerativeAi-Info.plist")
        }
        if value.starts(with: "_"){
            fatalError(
                "Follow instructions to get api key."
            )
        }
        return value
    }
}
