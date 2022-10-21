//
//  Post.swift
//  IsbakApp
//
//  Created by Can Öncü on 22.09.2022.
//

import Foundation
class Post{
    
    var email : String
    var comment : String
    var imageUrl : String
    
    init(email: String, comment: String, imageUrl : String){
        self.email = email
        self.imageUrl = imageUrl
        self.comment = comment
    }
}
