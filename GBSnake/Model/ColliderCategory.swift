//
//  ColliderCategory.swift
//  GBSnake
//
//  Created by Даниил Мурыгин on 01.11.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

struct ColliderCategories {
    static let snake: UInt32 = 0x1 << 0
    static let snakeHead: UInt32 = 0x1 << 1
    static let apple: UInt32 = 0x1 << 2
    static let edgeBody: UInt32 = 0x1 << 3
}
