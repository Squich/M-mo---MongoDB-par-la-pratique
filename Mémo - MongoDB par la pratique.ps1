====

https://docs.mongodb.com

====

Contexte mongodb :

mongo


Liste les commandes :A

help


==== 1 ====

Version database :

db.version()


====

Liste de databases :

show dbs


====

SQL Database == NoSQL Database
SQL Table == NoSQL Collection
SQL Row == NoSQL Document
SQL Column == NoSQL Field


==== 2 ====

Insertion de données de fichier JSON :

# Commande à exécuter hors contexte mongodb et donc dans une console

mongoimport --db cinemabis --collection movies --jsonArray --file movies.json


==== 3 ====

Savoir sur quelle base on se situe :

db


====


Sélectionner une autre base de donnée :

use cinemabis


====

Visualiser la liste des collections de la base :

show collections


==== 4 ====


Afficher une partie du contenu de la collection "movies" :

db.movies.find()



Afficher les documents suivants :

it



Affichage formatté des collections :

db.movies.find().pretty()



==== 5 ====


Limiter les nombres de documents lus :

db.movies.find().limit(3).pretty()



Filtrer l affichage en fonction des noms des champs :

db.movies.find({}, {Title: 1, Year: 1}).pretty()



Supprimer le champs de nom id :

db.movies.find({}, {Title: 1, Year: 1, _id: 0}).pretty()



==== 6 ====


Commande à exécuter hors contexte mongodb et donc dans une console :

mongoimport --db cinemabis --collection terminators --jsonArray --file terminator.json



Trouver tous les titres de films 'Terminator 2' :

db.terminators.find({ Title: 'Terminator 2' }).pretty()




Trouver tous les titres de films qui contiennent 'Terminator' :

db.terminators.find({ Title: /Terminator/ }).pretty()



Trouver tous les titres de films qui contiennent 'Terminator' sans prendre en compte la casse :

db.terminators.find({ Title: /terminator/i }).pretty() # i pour insensitive



Indique le nombre d enregistrements :
db.terminators.find({ Title: /terminator/i }).count()



==== 7 ====


Premier document correspondant à la recherche :

db.terminators.findOne({ Title: /terminator/i })



Affiche une propriété en particulier :

db.terminators.findOne({ Title: /terminator/i }).Title



==== 8 ====


Afficher le nom des technos auxquelles a participé "Evan You" => recherche dans tableau de noms :

db.technos.find({ team: 'Evan You' }).pretty()
db.technos.find({ team: /Evan/i }).pretty()



==== 9 ====


Créer manuellement d une base de données et des documents :

use databis # la database est sélectionnée et sera visible quand il y aura insertion d'un document


Création de documents dans la base de données :

db.collect.insertOne({ 'name': 'Bob'})
db.collect.insertOne({ 'name': 'Bill'})


db.collect.insertMany([{ name: 'Bobby'}, { name: 'Billy'}])


==== 10 ====

Supprimer une collection :

db.collect.drop() # affiche true quand la suppression a bien eu lieu


Supprimer la base de données sélectionnée :

db.dropDatabase()


==== 11 ====


Utiliser js pour insérer des documents :

use bigbasebis

for (let i = 0; i < 200000; i++) {
db.bigcoll.insert({ _id: i, name: `Je suis le document ${i}`, timestamp: new Date() });
}


==== 12 ====


Lire le tableau contenu le nom des collections :

db.getCollectionNames()


Utiliser js pour lire l index de chaque collection :

db.getCollectionNames().forEach(function(coll) {
print(`collection ${coll}`);
printjson(db[coll].getIndexes());
})


==== 13 ====


Création documents dans base 'people' et collection 'students' :

use people
db.students.insertMany([{ name: 'Bob', age: 18 }, { name: 'Jeff', age: 24 }, { name: 'Greg', age: 19 }, { name: 'Max', age: 22 }])


$gt 	# greater than
$gte 	# greater than or equals
$lt	# less than

Requêtes avec opérateurs de comparaison :

db.students.find({ age: {$gt: 19}})
db.students.find({ age: {$gt: 19, $lt: 23}})
db.students.find({ age: {$gt: 19, $lt: 29}, name: 'Max'})


==== 14 ====


Suppression de la collection pour création nouvelle collection :

db.students.drop()

db.students.insertMany([{ name: 'Bob', age: 18, fields: ['musique', 'philosophie'] }, { name: 'Jeff', age: 24, fields: ['programmation', 'réseaux'] }, { name: 'Greg', age: 19, fields: ['lettres', 'programmation'] }, { name: 'Max', age: 22, fields: ['réseaux', 'programmation'] }])

db.students.find().pretty()


Requêtes avec opérateurs logiques :

db.students.find({ $or: [{fields: 'musique'}, {name: 'Max'}] }).pretty()

db.students.insertOne({ name: 'Sam', age: 24, fields: ['math', 'philosophie'] })
db.students.find({ $and: [{fields: 'philosophie'}, {name: 'Bob'}] }).pretty()




==== 15 ====


Requêtes complémentaires :

db.students.find({ name: { $in: ['Bob', 'Greg']} })
db.students.find({ name: { $nin: ['Bob', 'Greg']} })



==== 16 ====


Requête complémentaire :

db.students.find({ fields: {$all: ['programmation', 'réseaux']} }).pretty()



Vérification de l existence d un field dans un document :

use foodbis

db.restaurants.insertMany([{name: 'Le Mékong', dailyspecial: 'nouilles curry rouge'},  {name: 'La Saïgonnaise', todayspecial: 'Bo Bun'}])


db.restaurants.find({todayspecial: {$exists: 1}}).pretty()


==== 17 ====



Mettre à jour un champ de document :

db.students.update({ name: "Bob" }, { $set: {age: 19} })



==== 18 ==== 


Remplacer un document par un nouveau document :

db.students.insert({ name: 'Cobaye', age: 2, fields: ['sieste'] })

db.students.update({name: 'Cobaye'}, {name: 'Pieuvre', age: 3}) # le ID reste inchangé


==== 19 ====


Ajouter une valeur à un tableau d un document :

db.students.update({name: 'Jeff'}, {$push: {fields: 'sécurité informatique'}})


Ajouter une valeur à un tableau et sans créer de doublon :

db.students.update({name: 'Jeff'}, {$addToSet: {fields: 'sécurité informatique'}})


Ajouter plusieurs valeurs à un tableau et sans doublon :

db.students.update({name: 'Jeff'}, {$addToSet: {fields: {$each: ['Linux', 'Unix']}}})



==== 20 ====



Mise à jour d un document qui n existe pas :

db.students.update({name: 'Eric'}, {test: 'hello world!'}) # la modification n'est pas réalisée

db.students.update({name: 'Eric'}, {test: 'hello world!'}, true) # la modification a été réalisée par une insertion du document -> upserted



==== 21 ====



Supprimer un document :

db.students.remove(ObjectId("123456"))

db.students.remove({name: 'Max'})



==== 22 ====

RAPPELS :

Supprimer un collection :

db.students.drop()


Supprimer la base courante :

db # vérifier quelle est la base de données courante
db.dropDatabase()


Lister les bases de données :

show dbs


==== 23 ====


Création base et collection :

use people

db.students.insertMany([{ name: 'Bob', age: 18, fields: ['musique', 'philosophie'] }, { name: 'Jeff', age: 24, fields: ['programmation', 'réseaux'] }, { name: 'Greg', age: 19, fields: ['lettres', 'programmation'] }, { name: 'Max', age: 22, fields: ['réseaux', 'programmation'] }])


Tri des documents :

db.students.find().sort({name: 1}) 	# ordre croissant
db.students.find().sort({name: -1}) 	# ordre décroissant


Tri sur plusieurs champs :

db.students.insertOne({name: 'Bob', age: 20, fields: ['musique', 'sociologie']})
db.students.find().sort({name: 1, age: 1}) 



==== 24 ====



use cinemabis
db.movies.find({}, {Title: 1, Year:1, _id: 0}).pretty()

Saut de 5 enregistrements et affichage des 10 suivants :

db.movies.find({}, {Title: 1, Year: 1, _id: 0}).sort({Title: 1}).skip(5).limit(10)


Affiche le film le plus ancien :

db.movies.find({}, {Title: 1, Year: 1, _id: 0}).sort({Year: 1}).limit(1)



==== 25 ====



ObjectId : https://docs.mongodb.com/manual/reference/method/ObjectId/

4 bits : timestamp value
4 bits : random value
4 bits : incrementing counter, initialized to a random value



Obtenir date création du document à partir de son ID :

db.movies.find()[0]._id 		# affiche le ID du premier document de la collection
db.movies.find()[0]._id.getTimestamp()	# affiche la date contenue dans le ID du document



Informations du ID : https://steveridout.github.io/mongo-object-time

To find all comments created after 2013-11-01:

db.comments.find({_id: {$gt: ObjectId("5272e0f00000000000000000")}})

Javascript function examples :

var objectIdFromDate = function (date) {
    return Math.floor(date.getTime() / 1000).toString(16) + "0000000000000000";
};

var dateFromObjectId = function (objectId) {
    return new Date(parseInt(objectId.substring(0, 8), 16) * 1000);
};
        

==== 26 ====



use bigbasebis
db.bigcoll.find().count() # 3,5 millions de documents


Recherche du document 120000 :

db.bigcoll.find({name: 'Je suis le document 120000'})
db.bigcoll.find()[120000] # même résultat que ligne précédente mais requête plus longue



Affiche le chemin suivi par mongo pour trouver le résultat :

db.bigcoll.find({name: 'Je suis le document 120000'}).explain()



Indique le nombre de documents parcourus :

db.bigcoll.find({name: 'Je suis le document 120000'}).explain('executionStats') # 3,5 millions de documents parcourus en 1020 millisecondes


==== 27 ====



Optimisation de la requête par les index -> par défaut Mongo a déjà créé un index déposé sur le champs _id :

db.bigcoll.getIndexes()


Créer un index pour la collection sur le champ name pour accélérer la recherche :

db.bigcoll.createIndex({name: 1})	# 1 index est créé pour le champ 'name'
db.bigcoll.getIndexes()

db.bigcoll.find({name: 'Je suis le document 120000'}).explain('executionStats') # 1 document trouvé en 0 milliseconde



==== 28 ====



Supprimer un index :

db.bigcoll.getIndexes()		# liste des index avec leur nom dans mongodb
db.bigcoll.dropIndex('name_1')	# suppression par nom de l'index



==== 29 ====



Créer un index qui garanti l unicité du champ indexé :

db.bigcoll.createIndex({name: 1}, {unique: true})
db.bigcoll.getIndexes()


db.bigcoll.insert({_id: 4000000, name:'Je suis unique', timestamp: new Date()})	# création d'un document
db.bigcoll.insert({_id: 4000001, name:'Je suis unique', timestamp: new Date()})	# erreur de la création du document avec le même champ 'name' que le précédent



==== 30 ====


Importer data -> commande dans un terminal :

mongoimport --db restaurants --collection recipes --jsonArray --file recipes.json


Créer un index composé sur les champs 'category' et 'preptime' :

db.recipes.createIndex({category: 1, preptime: 1})
db.recipes.getIndexes()

Requête :

db.recipes.find({category: 'dessert', preptime: {$lte: 10}}).explain('executionStats')



==== 31 ====



Créer un index de type text sur le tableau 'ingredients' et le string 'description' :

db.recipes.createIndex({ingredients: 'text', description: 'text'})
db.recipes.getIndexes()


Requête de recherche :

db.recipes.find({$text: {$search: 'oeufs'}}, {recipe: 1, _id: 0})



==== 32 ====


Afficher le score pour le mot recherché :

db.recipes.find({$text: {$search: 'oeufs'}}, {recipe: 1, _id: 0, score: {$meta: 'textScore'}})


Trier le score :

db.recipes.find({$text: {$search: 'oeufs'}}, {recipe: 1, _id: 0, score: {$meta: 'textScore'}}).sort({score: {$meta:'textScore'}})



==== 33 ====



Répartir les données sur plusieurs serveurs -> cf. doc : sharding

Répliquer les données qui seront disponibles quand le serveur primaire est en panne -> cf. doc : replication



==== 34 ====


mongoimport --db hardwarebis --collection computers --jsonArray --file computers.json


Liste les valeurs distinctes pour un champ :

db.computers.distinct('usage')
db.computers.distinct('OS')


==== 35 ====


Compte le nombre d ordinateurs suivant leur usage :

db.computers.aggregate([{$group: {_id:'$usage', nombre_ordinateurs: {$sum: 1}}}]) # groupby sur le champ 'usage'


Indique le prix moyen de chaque catégorie d ordinateur :

db.computers.aggregate([{$group: {_id:'$usage', moyenne_prix_ordinateur: {$avg: '$price'}}}])


==== 36 ====


Enregistre le résultat d agrégation dans une nouvelle collection :


db.computers.aggregate([{$group: {_id:'$usage', moyenne_prix_ordinateur: {$avg: '$price'}}}, {$out: 'prix_moyen'}])
db.prix_moyen.find()


==== 37 ====


use musicshop

db.instruments.insertMany([{name: 'Fender Stratocaster'}, {name: 'Gibson Les Paul'}, {name: 'Fender Jazz Bass'}])


Créer une jointure :

const guitar1 = db.instruments.findOne({name: 'Fender Stratocaster'})
const guitar2 = db.instruments.findOne({name: 'Gibson Les Paul'})

db.musicians.insertMany([{name: 'Jimi Hendrix', instrumentId: guitar1._id}, {name: 'Jimmy Page', instrumentId: guitar2._id}])

db.musicians.find()
db.instruments.find()


Recherche de l instrument utilisé par le musicien -> utilisation de la jointure :

const musician = db.musicians.findOne({name: 'Jimi Hendrix'})
db.instruments.findOne({_id: musician.instrumentId})


==== 38 ====


db.bands.insertMany([ {name: 'Beatles', musicians: ['John Lennon', 'Paul McCartney', 'Ringo Starr', 'George Harrison']}, {name: 'Wings', musicians: ['Paul McCartney', 'Joe English', 'Denny Laine', 'Linda McCartney', 'Jimmy McCulloc']}, {name: 'Cream', musicians: ['Eric Clapton', 'Ginger Baker', 'Jack Bruce']}, {name: 'Yardbirds', musicians: ['Jimmy Page', 'Chris Dreja', 'Keith Relf', 'Jim McCarty']}, {name: 'Foo Fighters', musicians: ['David Grohl', 'Chris Shiflett', 'Ramy Jaffee', 'Taylor Hawking', 'Pat Smear', 'Nate Mendel']}, {name: 'Led Zeppelin', musicians: ['Jimmy Page', 'John Bonham', 'Robert Plant', 'John Paul Jones']}, {name: 'Sex pistols', musicians: ['Paul Cook', 'Glen Matlock', 'John Lydon', 'Steve Jones', 'John Simon Ritchie']}, {name: 'Pil', musicians: ['John Lydon', 'Keith Leven', 'Jim Walker']}, {name: 'Nirvana', musicians: ['Kurt Cobain', 'Krist Novoselic', 'Dave Grohl']} ])


Affichage de données de plusieurs collections :

const jpBands = db.bands.find({musicians: /Jimmy Page/i})

while (jpBands.hasnext())
{
const currentBand = jpBands.next();
const musician = db.musicians.findOne({name: /page$/i});
const instrument = db.instruments.findOne({_id: musician.instrumentId});
print(`${musician.name} a joué avec une ${instrument.name} dans ${currentBand.name}`);
}