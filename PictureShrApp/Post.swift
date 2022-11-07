//
//  Post.swift
//  PictureShrApp
//
//  Created by Erbil Can on 31.10.2022.
//

import Foundation
class Post {
    
    var email : String
    var yorum : String
    var gorselUrl : String
    
    init(email: String, yorum: String, gorselUrl: String) {
        self.email = email
        self.yorum = yorum
        self.gorselUrl = gorselUrl
    }
    
}
