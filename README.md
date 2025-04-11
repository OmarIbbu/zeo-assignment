# Zeo App

This is a Swift-based iOS application that fetches public images from the Flickr api and displays them in a collection view with in-memory image caching for optimized performance.

---

##  Features

-  Fetches images asynchronously from Flickr’s public image feed api.
-  Displays them in a UICollectionView.
-  Utilizes NSCache for efficient in-memory image caching (Note: does not use URLCache).
-  Uses async/await for modern, clean concurrency.
-  Follows key SOLID principles (especially Dependency Inversion).
-  Implements testable components using dependency injection.
-  Designed with separation of concerns in mind.
-  Covers Codable Protocol.
-  Designed for both iPhone and iPad, with support for portrait and landscape orientations.

---

##  Architecture & Design Patterns

This app follows a lightweight *MVVM architecture*:


###  View (ImageViewController)
- Handles UI-related logic.
- Delegates data fetching and caching to the ViewModel.
- Uses UICollectionView to show images.

###  ViewModel (ImageViewModel)
- Contains business logic and acts as a bridge between the View and Model layers.
- Uses dependency injection to allow testability and loose coupling.
- Responsible for:
  - Fetching image data from the HttpClient.
  - Managing in-memory cache with ImageCache.

###  Model
- Images and Image structs conforming to Decodable.
- Parses and structures JSON from Flickr API.

###  API Layer
- ImageService: Makes the actual API call.
- HttpClient: Generic networking utility using URLSession and async/await.

###  Image Caching (ImageCache)
- Implements the ImageCaching protocol to allow flexibility and dependency inversion.
- Uses NSCache internally.
- Uses DispatchQueue for thread-safe concurrent access:
  - sync for safe concurrent reads.
  - async(flags: .barrier)` for thread-safe writes.
---

##  Setup Instructions

1. Clone the repo:
   git clone https://github.com/OmarIbbu/zeo-assignment

3. Open the project in Xcode:
   open Zeo.xcodeproj
 
4. Build & run the app on a simulator or real device.
