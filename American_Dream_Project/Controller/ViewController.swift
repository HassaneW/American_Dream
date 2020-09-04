//
//  ViewController.swift
//  test_Projet_9
//
//  Created by Wandianga on 6/27/20.
//  Copyright © 2020 Wandianga. All rights reserved.
//

import UIKit
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        WeatherService.shared.getWeathers { [weak self] (resultWeather) in
//                  switch resultWeather {
//                  
//                  case .success(let weathers):
//                      print(weathers)
//                  
//                  case .failure(let error):
//                      print(error.localizedDescription)
//                  }
//              }
//        
//        MoneyService.shared.getMoneys { [weak self] (resultMoney) in
//            switch resultMoney {
//                
//            case .success(let money):
//                print(money)
//                
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//        
//        TranslateService.shared.getTranslate(text: "") { [weak self] (resultTranslate) in
//            switch resultTranslate {
//                
//            case .success(let translate):
//                print(translate)
//                
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//
//}


/*
 1. Taux de change
 Dans la page taux de change, on peut insérer un montant dans votre monnaie locale et voir le résultat en dollar ($). Rien de bien sorcier a priori !
 Pour obtenir le taux de change, vous utiliserez l'API fixer.io, actualisé chaque jour. Il vous faudra donc obtenir le taux de change au minimum une fois par jour pour être sûr d'afficher le bon montant en dollar à vos utilisateurs.
 2. Traduction
 Dans la page traduction, l'utilisateur peut écrire la phrase de son choix en français et obtenir sa traduction en anglais of course !
 Pour cela, vous utiliserez l'API de Google Translate. Contrairement à la précédente, cette API nécessite une clé que vous obtiendrez en suivant les étapes expliquées dans la documentation.
 3. La météo
 Dans la page météo, vous afficherez les informations météo de New York et de la ville de votre choix (là ou vous habitez).
 Pour chaque ville, vous afficherez les conditions actuelles en utilisant l'API OpenWeathermap en précisant notamment :
 La température
 La description des conditions (nuageux, ensoleillé), etc.


 Bonus
 Et encore un petit bonus de votre choix pour finir ce projet ! Voici quelques idées pour vous inspirer :
 Auto-détection de la langue d'origine dans la page de traduction avec Google Translate
 Un bouton pour échanger la langue d'origine et la langue de destination pour la traduction
 Gérer le mode paysage
 Une page de réglages pour changer les paramètres (langues, destinations, devises)
 Votre idée ?!
 Le bonus est obligatoire. Mais vous êtes libre d'implémenter la fonctionnalité de votre choix. :)
 Contraintes
 Le code est sur Github avec un historique de commits cohérent.
 Le code est clair et lisible.
 Le code est écrit en anglais : commentaires, variables, fonctions…
 Le projet ne contient aucun warning ni erreur.
 Vous avez respecté le modèle MVC scrupuleusement.
 Votre application doit contenir des tests unitaires qui couvriront la majorité de la logique de votre code.
 L'application doit s'afficher correctement sur toutes les tailles d'iPhone en mode portait.
 L'application doit supporter iOS 11 et les versions supérieures.
 */

/*
 Requis 2 moins complet
 
 1. Taux de change
 Dans la page taux de change, on peut insérer un montant dans votre monnaie locale et voir le résultat en dollar ($). Rien de bien sorcier a priori !
 Pour obtenir le taux de change, vous utiliserez l'API fixer.io, actualisé chaque jour. Il vous faudra donc obtenir le taux de change au minimum une fois par jour pour être sûr d'afficher le bon montant en dollar à vos utilisateurs.
 2. Traduction
 Dans la page traduction, l'utilisateur peut écrire la phrase de son choix en français et obtenir sa traduction en anglais of course !
 Pour cela, vous utiliserez l'API de Google Translate. Contrairement à la précédente, cette API nécessite une clé que vous obtiendrez en suivant les étapes expliquées dans la documentation.
 3. La météo
 Dans la page météo, vous afficherez les informations météo de New York et de la ville de votre choix (là ou vous habitez).
 Pour chaque ville, vous afficherez les conditions actuelles en utilisant l'API OpenWeathermap en précisant notamment :
 La température
 La description des conditions (nuageux, ensoleillé), etc.
 */


/*
 requis 3
 
 1. Taux de change
 Dans la page taux de change, on peut insérer un montant dans votre monnaie locale et voir le résultat en dollar ($). Rien de bien sorcier a priori !
 Pour obtenir le taux de change, vous utiliserez l'API fixer.io, actualisé chaque jour. Il vous faudra donc obtenir le taux de change au minimum une fois par jour pour être sûr d'afficher le bon montant en dollar à vos utilisateurs.
 2. Traduction
 Dans la page traduction, l'utilisateur peut écrire la phrase de son choix en français et obtenir sa traduction en anglais of course !
 Pour cela, vous utiliserez l'API de Google Translate. Contrairement à la précédente, cette API nécessite une clé que vous obtiendrez en suivant les étapes expliquées dans la documentation.
 3. La météo
 Dans la page météo, vous afficherez les informations météo de New York et de la ville de votre choix (là ou vous habitez).
 Pour chaque ville, vous afficherez les conditions actuelles en utilisant l'API OpenWeathermap en précisant notamment :
 La température
 La description des conditions (nuageux, ensoleillé), etc.


 Bonus
 Et encore un petit bonus de votre choix pour finir ce projet ! Voici quelques idées pour vous inspirer :
 Auto-détection de la langue d'origine dans la page de traduction avec Google Translate
 Un bouton pour échanger la langue d'origine et la langue de destination pour la traduction
 Gérer le mode paysage
 Une page de réglages pour changer les paramètres (langues, destinations, devises)
 Votre idée ?!
 Le bonus est obligatoire. Mais vous êtes libre d'implémenter la fonctionnalité de votre choix. :)
 Contraintes
 Le code est sur Github avec un historique de commits cohérent.
 Le code est clair et lisible.
 Le code est écrit en anglais : commentaires, variables, fonctions…
 Le projet ne contient aucun warning ni erreur.
 Vous avez respecté le modèle MVC scrupuleusement.
 Votre application doit contenir des tests unitaires qui couvriront la majorité de la logique de votre code.
 L'application doit s'afficher correctement sur toutes les tailles d'iPhone en mode portait.
 L'application doit supporter iOS 11 et les versions supérieures.
 */
