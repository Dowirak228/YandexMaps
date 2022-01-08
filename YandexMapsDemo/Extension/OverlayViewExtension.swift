//
//  OverlayViewExtension.swift
//  YandexMapsDemo
//
//  Created by NODIR KARIMOV on 07/01/22.
//

import UIKit
import YandexMapsMobile

extension OverlayView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearhCell
        
        cell.titleLabel.text = searchResults[indexPath.row].formattedAddress
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heigth: CGFloat = 80
        return .init(width: self.view.frame.width, height: heigth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}



extension OverlayView {
    
    func onSearchResponse(_ response: YMKSearchResponse) {

        for searchResult in response.collection.children {
            guard let obj = searchResult.obj else {
                continue
            }

            guard let objMetadata = obj.metadataContainer.getItemOf(YMKSearchToponymObjectMetadata.self) as? YMKSearchToponymObjectMetadata else {
                continue
            }

            let address = objMetadata.address

            let formattedAddress = address.formattedAddress
            let postalCode = address.postalCode ?? "none"
            let additionalInfo = address.additionalInfo ?? "none"

            print("formattedAddress", formattedAddress)
            print("postalCode", postalCode)
            print("additionalInfo", additionalInfo)

            print("components:")

            searchResults.append(address)
            collectionView.reloadData()
            print(searchResults)

            address.components.forEach {
                let value = $0.name
                

                $0.kinds.forEach {
                    let kind = YMKSearchComponentKind(rawValue: UInt(truncating: $0))
                    switch kind {

                    case .country:
                        print("country: \(value)")

                    case .region:
                        print("region: \(value)")

                    case .locality:
                        print("locality: \(value)")

                    case .street:
                        print("street: \(value)")
                                                
                    case .house:
                        print("house number: \(value)")
                        

                    default:
                        break
                    }
                }
            }

            print("==========")
        }
    }
    
    func onSearchError(_ error: Error) {
        let searchError = (error as NSError).userInfo[YRTUnderlyingErrorKey] as! YRTError
        var errorMessage = "Unknown error"
        if searchError.isKind(of: YRTNetworkError.self) {
            errorMessage = "Network error"
        } else if searchError.isKind(of: YRTRemoteError.self) {
            errorMessage = "Remote server error"
        }

        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}


extension OverlayView: UISearchBarDelegate, UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchResults.removeAll()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        return true
    }


    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let responseHandler = {(searchResponse: YMKSearchResponse?, error: Error?) -> Void in
            if let response = searchResponse {
                self.onSearchResponse(response)
            } else {
                self.onSearchError(error!)
            }
        }
        
        if searchText == "" {
            searchResults.removeAll()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } else {
            searchSession = searchManager.submit(
                withText: searchText,
                geometry: geometry,
                searchOptions: SEARCH_OPTIONS,
                responseHandler: responseHandler)
        }
        
    }
}

