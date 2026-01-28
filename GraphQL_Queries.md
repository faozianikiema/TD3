**URL GraphQL** : `http://localhost:8055/graphql`

# D'abord on génére un access token à ajouter dans l'authorization

{
"email": "admin@admin.com",
"password": "admin123"
}

# 1. Liste des praticiens (id, nom, prénom, téléphone, ville)

query {
praticien {
id
nom
prenom
telephone
ville
}
}

# 2. Liste des praticiens avec libellé de spécialité en plus

query {
praticien {
id
nom
prenom
telephone
ville
specialite_id {
libelle
}
}
}

# 3. Praticiens avec spécialité filtrés par ville = Paris

query {
praticien(filter: { ville: { \_eq: "Paris" } }) {
id
nom
prenom
telephone
ville

    specialite_id {
      libelle
    }

}
}

# 4. Praticiens avec spécialité et structure

query {
praticien(filter: { ville: { \_eq: "Paris" } }) {
id
nom
prenom
telephone
ville
specialite_id {
libelle
}
structure_id {
nom
ville
}
}
}

# 5. Praticiens avec emails contenant ".fr"

query {
praticien(filter: { ville: { \_eq: "Paris" }, email: { \_contains: ".fr" } }) {
id
nom
prenom
telephone
ville
email
specialite_id {
libelle
}
structure_id {
nom
ville
}
}
}

# 6. Praticiens rattachés à une structure située à Paris

query {
praticien(filter: { structure_id: { ville: { \_eq: "Paris" } } }) {
id
nom
prenom
telephone
ville
email
specialite_id {
libelle
}
structure_id {
nom
ville
}
}
}

# 7. Praticiens de Paris rt Bourdon-les-Bains

query {
praticiensParis: praticien(filter: { ville: { \_eq: "Paris" } }) {
id
nom
prenom
telephone
ville
email
}

praticiensBourdon: praticien(
filter: { ville: { \_eq: "Bourdon-les-Bains" } }
) {
id
nom
prenom
telephone
ville
email
}
}

# 8. Même requête mais avec fragment

query {
praticiensParis: praticien(filter: { ville: { \_eq: "Paris" } }) {
...PraticienInfo
}

praticiensBourdon: praticien(
filter: { ville: { \_eq: "Bourdon-les-Bains" } }
) {
...PraticienInfo
}
}

fragment PraticienInfo on praticien {
id
nom
prenom
telephone
ville
email
}

# 9. Requête avec variable pour filtrer par ville

**Variables**

{
"ville": "Paris"
}

**Requête** :

query GetPraticiensByVille($ville: String!) {
praticien(filter: { ville: { \_eq: $ville } }) {
id
nom
prenom
telephone
ville
specialite_id {
libelle
}
}
}

## 10. Structures avec leurs praticiens et spécialités

query {
structure {
nom
ville
praticiens {
nom
prenom
email
specialite_id {
libelle
}
}
}
}
