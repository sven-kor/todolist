//
//  List.swift
//  ToDoList(UIKit)
//
//  Created by 김형준 on 5/24/24.
//

import Foundation

struct TaskList: Codable {
    var task: String
    var check: Bool = false
}

var tasklist = [TaskList(task: "밥먹기", check: false), TaskList(task: "똥싸기", check: false)]
