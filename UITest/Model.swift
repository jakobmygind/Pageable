//
//  Model.swift
//  Pageable
//
//  Created by Jakob Mygind on 14/09/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation

//
//  Listing.swift
//  DoGood
//
//  Created by Jakob Mygind on 20/06/16.
//  Copyright © 2016 DooGood. All rights reserved.
//

import Foundation
import Serializable
import UIKit

enum StatusType : String {
    case Deleted = "deleted"
    case Canceled = "canceled"
    case Sold = "sold"
    case Pending = "pending"
    case Expired = "expired"
    case Trending = "trending"
    case Active = "active"
}

struct Listing : Equatable {
    var id = 0
    var listingDescription:String?//<-description
    var tags = [String]()
    var lat = ""
    var lng = ""
    var status : StatusType = .Active
    var saleId:Int?
    var distance:Double = 0.0
    var categoryId = 0
    var category:Category?
    
    var ownerUserId = 0
    var suggestedPrice:Double?
    var currentPrice:Double?
    var myBid:Double?
    var imageUrl:NSURL?
    var shareUrl:NSURL?
    var organization:Organization?
    var images:[Image]?
    
    var followed = false
    var created:NSDate?//<-created_at
    var updatedAt: NSDate?
    var isEmptyDummyListing = false
    
    //For createListing, not to be parsed
    
    var uploadImages:[UIImage]?
}

extension Listing: Serializable {
    init(dictionary: NSDictionary?) {
        id                  <== (self, dictionary, "id")
        listingDescription  <== (self, dictionary, "description")
        tags                <== (self, dictionary, "tags")
        lat                 <== (self, dictionary, "lat")
        lng                 <== (self, dictionary, "lng")
        status              <== (self, dictionary, "status")
        saleId              <== (self, dictionary, "sale_id")
        distance            <== (self, dictionary, "distance")
        categoryId          <== (self, dictionary, "category_id")
        category            <== (self, dictionary, "category")
        
        ownerUserId         <== (self, dictionary, "owner_user_id")
        suggestedPrice      <== (self, dictionary, "suggested_price")
        currentPrice        <== (self, dictionary, "current_price")
        myBid               <== (self, dictionary, "my_bid")
        imageUrl            <== (self, dictionary, "image_url")
        shareUrl            <== (self, dictionary, "share_url")
        organization        <== (self, dictionary, "organization")
        images              <== (self, dictionary, "images")
        
        followed            <== (self, dictionary, "followed")
        created             <== (self, dictionary, "created_at")
        updatedAt           <== (self, dictionary, "updated_at")
        isEmptyDummyListing <== (self, dictionary, "is_empty_dummy_listing")
        uploadImages        <== (self, dictionary, "upload_images")
    }
    
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "id")                     <== id
        (dict, "description")            <== listingDescription
        (dict, "tags")                   <== tags
        (dict, "lat")                    <== lat
        (dict, "lng")                    <== lng
        (dict, "status")                 <== status
        (dict, "sale_id")                <== saleId
        (dict, "distance")               <== distance
        (dict, "category_id")            <== categoryId
        (dict, "category")               <== category
       
        (dict, "owner_user_id")          <== ownerUserId
        (dict, "suggested_price")        <== suggestedPrice
        (dict, "current_price")          <== currentPrice
        (dict, "my_bid")                 <== myBid
        (dict, "image_url")              <== imageUrl
        (dict, "share_url")              <== shareUrl
        (dict, "organization")           <== organization
        (dict, "images")                 <== images
       
        (dict, "followed")               <== followed
        (dict, "created_at")             <== created
        (dict, "updated_at")             <== updatedAt
        (dict, "is_empty_dummy_listing") <== isEmptyDummyListing
        (dict, "upload_images")          <== uploadImages
        return dict
    }
}



func ==(left:Listing, right:Listing) -> Bool {
    return left.id == right.id
}

struct Organization {
    var id = 0
    var name = ""
    var organizationDescription = ""//<-description
    var logoUrl:NSURL?
    var imageUrl:NSURL?
}

extension Organization: Serializable {
    init(dictionary: NSDictionary?) {
        id                      <== (self, dictionary, "id")
        name                    <== (self, dictionary, "name")
        organizationDescription <== (self, dictionary, "description")
        logoUrl                 <== (self, dictionary, "logo_url")
        imageUrl                <== (self, dictionary, "image_url")
    }
    
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "id")          <== id
        (dict, "name")        <== name
        (dict, "description") <== organizationDescription
        (dict, "logo_url")    <== logoUrl
        (dict, "image_url")   <== imageUrl
        return dict
    }
}

struct Image : Equatable {
    var id = 0
    var imagePath:NSURL?
    var listingId = 0
    var order = 0
    
}

extension Image: Serializable {
    init(dictionary: NSDictionary?) {
        id        <== (self, dictionary, "id")
        imagePath <== (self, dictionary, "image_path")
        listingId <== (self, dictionary, "listing_id")
        order     <== (self, dictionary, "order")
    }
    
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "id")         <== id
        (dict, "image_path") <== imagePath
        (dict, "listing_id") <== listingId
        (dict, "order")      <== order
        return dict
    }
}

func ==(left:Image, right:Image) -> Bool {
    return left.id == right.id || left.imagePath == right.imagePath
}


