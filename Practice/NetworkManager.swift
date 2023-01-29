//
//  NetworkManager.swift
//  Practice
//
//  Created by Dinmukhamed on 29.01.2023.
//

import Foundation

enum ObtainPostsResult{
    case success(posts: [Post])
    case failure(error: Error)
}

class NetworkManager{
    let sessionConf = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    func obtainPost(completion: @escaping(ObtainPostsResult) -> Void){
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        let urlRequest = URLRequest(url: url)
        
        session.dataTask(with: url) { [weak self] data, response, error in
            
            var result: ObtainPostsResult
            
            guard let strongSelf = self else { return }
            if let data = data, error == nil{
                guard let posts = try? strongSelf.decoder.decode( [Post].self, from: data) else{
                    return
                }
                result = .success(posts: posts)
            }else{
                result = .failure(error: error!)
            }
            completion(result)
        }.resume()
    }
}
 
