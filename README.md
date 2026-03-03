# Front End – Module de Facturation Mobile (Flutter)

Application Flutter permettant de créer une **facture dynamique** avec :
- saisie des informations client
- ajout / suppression d’articles
- calcul automatique des totaux (HT / TVA / TTC)
- **aperçu de la facture en temps réel** (onglet “Aperçu”)
- UI inspirée d’une facture réelle (alignements, tableau, totaux à droite)

## Fonctionnalités (conformité au challenge)

### 1) Écran de création de facture 
- Nom du client (TextField)
- Email du client (TextField)
- Date de facture (DatePicker + champ readonly)
- Liste d’articles dynamique
- Bouton “Ajouter un article”
- Zone de calcul dynamique :
  - Total HT
  - TVA (20 %)
  - Total TTC  
 Les totaux sont recalculés automatiquement à chaque modification (ajout / suppression / édition d’un article).

### 2) Gestion des articles 
Chaque article contient :
- Description
- Quantité (validation numérique)
- Prix unitaire HT (validation numérique)
- Total HT calculé automatiquement (quantité × prix unitaire)

Actions :
- Ajouter un article (carte vide)
- Supprimer un article (icône poubelle)

### 3) Aperçu facture en temps réel 
Affichage dans un onglet “Aperçu” :
- Détails client
- Date de facture
- Tableau des articles (description, quantité, PU, total)
- Totaux HT / TVA / TTC
- Message conditionnel si aucun article (“Aucun article ajouté”)

Design inspiré d’un modèle de facture (header coloré, séparateurs, tableau aligné, totaux à droite).

## Structure du projet

Le code est organisé pour rester lisible et modulaire :

- `lib/main.dart`  
  Point d’entrée de l’application + thème global (couleurs, inputs, divider, boutons).

- `lib/screens/invoice_screen.dart`  
  Écran principal : formulaire + gestion des articles + totaux + navigation par onglets (Formulaire / Aperçu).  
  State management via `setState()` et `TextEditingController`.

- `lib/models/invoice_item.dart`  
  Modèle de données d’un article (description, quantité, prix unitaire) + calcul du total HT.

- `lib/widgets/item_card.dart`  
  Widget UI d’un article (carte) : champs description/quantité/prix + total + bouton suppression.

- `lib/widgets/invoice_preview.dart`  
  Aperçu structuré de la facture (style “facture réelle”) avec tableau et totaux.

## Choix techniques

- **State management :** `setState()` (simple et adapté au scope du challenge)
- **Gestion dynamique des articles :** `List<InvoiceItem>` + `ListView.builder`
- **Champs contrôlés :** `TextEditingController` (client name / email)
- **Validation :**
  - email (format basique `nom@domaine.com`)
  - quantités / prix (input numérique)
- **UI/UX :**
  - séparation claire des sections
  - tableau aligné pour les articles
  - totaux à droite et TTC mis en valeur
  - thème global cohérent (bleu + accent)
##  Installation & lancement

### 1 Cloner le repo

```bash
git clone https://github.com/SalmaSpace/Front-End-Module-de-Facturation-Mobile.git
cd Front-End-Module-de-Facturation-Mobile
```

### 2️ Installer les dépendances

```bash
flutter pub get
```

### 3️ Lancer l’application

```bash
flutter run
```

---

##  Captures d’écran

###  Inspiration

<img width="200" height="300" alt="Inspiration" src="https://github.com/user-attachments/assets/efb3f74a-d363-4cae-8492-206e77246796" />

---

###  Résultat

**Formulaire (avec 1-2 articles ajoutés)**  
<img width="260" height="600" alt="image" src="https://github.com/user-attachments/assets/44c99b82-0249-462f-be12-e0a0ac0a2603" />

**Aperçu facture (tableau + totaux HT / TVA / TTC)**  
<img width="260" height="600" alt="image" src="https://github.com/user-attachments/assets/f02218fa-2df0-46b6-987a-266c2555e343" />

**Email invalide(validation)**  
<img width="260" height="600" alt="image" src="https://github.com/user-attachments/assets/f02218fa-2df0-46b6-987a-266c2555e343" />


##  Choix techniques

- State management : `setState()`
- Gestion dynamique des articles : `List<InvoiceItem>` + `ListView.builder`
- Champs contrôlés : `TextEditingController`
- Validation email basique
- Calcul automatique des totaux
- UI claire et responsive

---

##  Notes

Le projet est volontairement simple et lisible pour répondre aux critères du challenge.

Le design s’inspire d’un modèle de facture réel tout en restant adapté à une interface mobile.
