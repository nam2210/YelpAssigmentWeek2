//
//  YelpFilter.swift
//  Yelp
//
//  Created by Nam Pham on 2/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation


class YelpFilter {
    var term: String?
    var sortBy: YelpSortMode?
    var isOfferDeal: Bool?
    var distance: Int?
    var categories: [String]?
    var offset: Int?
    
    static let sharedInstance = YelpFilter()
}
