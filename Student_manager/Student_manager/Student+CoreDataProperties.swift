//
//  Student+CoreDataProperties.swift
//  Student_manager
//
//  Created by Ngoc on 6/21/19.
//  Copyright © 2019 Ngoc. All rights reserved.
//
//

import UIKit
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: Int32
    @NSManaged public var classes: String?
    @NSManaged public var image: UIImage?

}
