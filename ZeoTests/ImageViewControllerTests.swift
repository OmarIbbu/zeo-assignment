//
//  ImageViewControllerTests.swift
//  Zeo
//
//  Created by Umar Farooq on 11/04/25.
//

import XCTest
@testable import Zeo

final class ImageViewControllerTests: XCTestCase {

    var viewController: ImageViewController!
    var collectionView: UICollectionView!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController else {
            XCTFail("Failed to instantiate ImageViewController from storyboard")
            return
        }
        viewController = vc
        viewController.loadViewIfNeeded()
        collectionView = viewController.imageCollectionView
    }
    override func tearDownWithError() throws {
        viewController = nil
        collectionView = nil
    }

    func testCollectionViewFlowLayoutConfiguration() {
        // Ensure the collection view layout is a UICollectionViewFlowLayout
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            XCTFail("Collection view layout is not a UICollectionViewFlowLayout")
            return
        }

        // Trigger layout configuration
        viewController.view.layoutIfNeeded()

        // Assert layout properties
        XCTAssertEqual(layout.minimumInteritemSpacing, viewController.imageCollectionLayoutViewModel.spacing, "Minimum inter-item spacing is incorrect")
        XCTAssertEqual(layout.minimumLineSpacing, viewController.imageCollectionLayoutViewModel.spacing, "Minimum line spacing is incorrect")
        
        let expectedItemSize = calculateExpectedItemSize(
            collectionViewWidth: collectionView.bounds.width,
            itemsPerRow: Int(viewController.imageCollectionLayoutViewModel.itemsPerRow),
            spacing: viewController.imageCollectionLayoutViewModel.spacing
        )
        XCTAssertEqual(layout.itemSize, expectedItemSize, "Item size is incorrect")
    }

    // Helper function to calculate expected item size
    private func calculateExpectedItemSize(collectionViewWidth: CGFloat, itemsPerRow: Int, spacing: CGFloat) -> CGSize {
        let totalSpacing = spacing * CGFloat(itemsPerRow - 1)
        let availableWidth = collectionViewWidth - totalSpacing
        let itemWidth = availableWidth / CGFloat(itemsPerRow)
        return CGSize(width: itemWidth, height: itemWidth) // Assuming square items
    }
}
