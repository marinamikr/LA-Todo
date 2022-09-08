//
//  Todo.swift
//  Todo
//
//  Created by 原田摩利奈 on 9/5/22.
//

import Foundation
import RealmSwift

class Todo: Object {
    @objc dynamic var todo: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var date: String = ""
}
