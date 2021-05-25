//
//  Created by Alexander Svalov on 08.03.2021.
//

import UIKit

class SwitchingViewController: UIViewController {  // корневой контроллер

    private var blueViewController: BlueViewController!
    private var yellowViewController: YellowViewController!
    
    override func viewDidLoad() {  // вызывается после загрузки раскадровки в память
        super.viewDidLoad()
        
        // загружает экземпляр класса BlueViewController из раскадровки
        blueViewController =
            (storyboard?.instantiateViewController(withIdentifier: "Blue") as! BlueViewController)
        
        // устанавливаем размеры представления
        blueViewController.view.frame = view.frame
        
        // переключение на blueViewController
        switchViewController(from: nil, to: blueViewController)
    }
    
    @IBAction func switchViews(sender: UIBarButtonItem) {
        // Create the new view controller, if required
        if yellowViewController?.view.superview == nil {
            if yellowViewController == nil {
                yellowViewController =
                    (storyboard?.instantiateViewController(withIdentifier: "Yellow")
                        as! YellowViewController)
            }
        } else if blueViewController?.view.superview == nil {
            if blueViewController == nil {
                blueViewController =
                    (storyboard?.instantiateViewController(withIdentifier: "Blue")
                        as! BlueViewController)
            }
        }
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)  // в секундах
        UIView.setAnimationCurve(.easeInOut)
        
        // Switch view controllers
        if blueViewController != nil && blueViewController!.view.superview != nil {
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            yellowViewController.view.frame = view.frame
            switchViewController(from: blueViewController, to: yellowViewController)
        } else {
            UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)
            blueViewController.view.frame = view.frame
            switchViewController(from: yellowViewController, to: blueViewController)
        }
        UIView.commitAnimations()
    }
    
    // Безопасное освобождение памяти от ненужных контроллеров
    // при сильных ограничениях на объем памяти
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Освобождаем возобновляемые ресурсы
        if blueViewController != nil && blueViewController!.view.superview == nil {
            blueViewController = nil
        }
        if yellowViewController != nil && yellowViewController!.view.superview == nil {
            yellowViewController = nil
        }
    }
    
    private func switchViewController(from fromVC: UIViewController?, to toVC: UIViewController?) {
        // Удаляем текущий контроллер представления
        if fromVC != nil {
            fromVC!.willMove(toParent: nil)
            fromVC!.view.removeFromSuperview()
            fromVC!.removeFromParent()
        }
        // Добавляем новый контроллер представления
        if toVC != nil {
            self.addChild(toVC!)
            self.view.insertSubview(toVC!.view, at: 0)
            toVC!.didMove(toParent: self)
        }
    }
}
