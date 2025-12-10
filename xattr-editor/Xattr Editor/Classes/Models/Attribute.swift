//
//  Attribute.swift
//  Xattr Editor
//
//  Created by Richard Csiko on 2017. 01. 21..
//

class Attribute {
    var originalName: String
    var originalValue: String?

    var name: String
    var value: String?
    var isModified: Bool {
        return name != originalName || value != originalValue
    }

    init(name: String, value: String? = nil) {
        originalName = name
        self.name = name

        originalValue = value
        self.value = value
    }

    func updateOriginalValues() {
        originalName = name
        originalValue = value
    }
}
