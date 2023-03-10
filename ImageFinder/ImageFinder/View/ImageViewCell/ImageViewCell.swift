import Foundation
import UIKit

class ImageViewCell: UICollectionViewCell {
     
    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        clipsToBounds = true
        layer.cornerRadius = 6
        }

    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        loadImage(from: url)
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ImageViewCell", bundle: nil)
    }
}
