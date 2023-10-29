//
//  KeychainStorage.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 28.10.2023.
//

import FFKeychain

@propertyWrapper
struct Keychained<Item> where Item: Codable {

    var wrappedValue: Item? {
        get {
            FFKeychain.shared.loadItem(key: key)
        }
        set {
            guard let item: Item = newValue else {
                FFKeychain.shared.deleteItem(key: key)
                return
            }
            FFKeychain.shared.save(item, key: key)
        }
    }

    private let key: FFKeychain.Key

    init(_ key: FFKeychain.Key) {
        self.key = key
    }
}
