//
//  Created by Alexander Svalov on 08.03.2021.
//

import UIKit

class YellowViewController: UIViewController {

    @IBAction func yellowButtonPressed(sender: UIButton) {
        let alert = UIAlertController(
            title: "Yellow View Button Pressed",
            message: "You pressed the button on the yellow view",
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "Yes, I did", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }    
}
