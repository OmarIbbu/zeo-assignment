//
//  ImageCollectionViewModel.swift
//  Zeo
//
//  Created by Umar Farooq on 11/04/25.
//

import UIKit

class ImageCollectionViewModel {
    var itemsPerRow: CGFloat {
        return UIDevice.current.userInterfaceIdiom == .pad ? 2 : 1
    }
    let spacing: CGFloat = 10
}
