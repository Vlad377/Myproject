//
//  League+CoreDataProperties.swift
//  Bet Helper
//
//  Created by Vladyslav Zhulavskyi on 2/12/19.
//  Copyright © 2019 Vladyslav Zhulavskyi. All rights reserved.
//
//

import Foundation
import CoreData


extension League {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<League> {
        return NSFetchRequest<League>(entityName: "League")
    }

    @NSManaged public var country: String?
    @NSManaged public var leagueId: String?
    @NSManaged public var name: String?
    @NSManaged public var season: String?
    @NSManaged public var seasonEnd: String?
    @NSManaged public var seasonStart: String?
    @NSManaged public var result: Int64

}
