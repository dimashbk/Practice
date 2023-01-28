//
//  Post.swift
//  Practice
//
//  Created by Dinmukhamed on 28.01.2023.
//

import Foundation

struct Post: Codable{
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    enum CodingKeys:String ,CodingKey {
        case userId
        case id
        case title
        case body
    }
}
