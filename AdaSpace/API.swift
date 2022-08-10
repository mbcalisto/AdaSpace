//
//  api.swift
//  AdaSpace
//
//  Created by Mateus Calisto on 10/08/22.
//

import Foundation

struct Posts: Codable{
    let id: UUID
    let content: String
    let user_id: String
    let created_at: String
    let updated_at: String
}
