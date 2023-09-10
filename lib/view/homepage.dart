import 'package:flutter/material.dart';
import 'package:quizzflutter/view/listQuizzView/myQuizzList.dart';
import 'package:quizzflutter/view/quizzAddView/quizzCreator.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 2.0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          'OtaKizz',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/photo9.jpg'),
          ),
        ],
      ),
      drawer: Drawer(
        // Ajouter un menu hamburger personnalisé
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Accueil'),
              onTap: () {
                // Naviguer vers la page d'accueil
              },
              leading: const Icon(Icons.home),
              iconColor: Colors.cyan,
            ),
            ListTile(
              title: Text('Profil'),
              onTap: () {
                // Naviguer vers la page de profil utilisateur

              },
              leading: const Icon(Icons.person),
              iconColor: Colors.cyan,
            ),
            ListTile(
              title: Text('Paramètres'),
              onTap: () {
                // Naviguer vers la page de paramètres
              },
              leading: const Icon(Icons.settings),iconColor: Colors.cyan,
            ),
            ListTile(
              title: Text('Déconnexion'),
              onTap: () {
                // Déconnecter l'utilisateur
              },
              leading: const Icon(Icons.logout),
              iconColor: Colors.cyan,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildQuizTheme(
                context, '4 images 1 anime', 'assets/4im1anim.jpeg',Colors.orange),
            _buildQuizTheme(
                context, '4 images 1 perso', 'assets/4im1perso.png',Colors.purple),
            _buildQuizTheme(
                context, 'Image floue', 'assets/eyequizz.png',Colors.pink),
            _buildQuizTheme(context, 'Eye quizz', 'assets/hairquizz.png',Colors.blueAccent),
            _buildQuizTheme(context, 'Hair quizz', 'assets/imfloue.png',Colors.green),
            _buildQuizTheme(
                context, 'Place quizz', 'assets/placequizz.png',Colors.redAccent),
            _buildQuizTheme(
                context, 'Question/Réponse', 'assets/quesrep.png',Colors.brown),
            _buildQuizTheme(context, 'Quizz mixte', 'assets/cover.jpg',Colors.blueGrey),
          ],
        ),
      ),
    floatingActionButton: FloatingActionButton(
    backgroundColor: Colors.cyan,
    onPressed: () {
    // Naviguer vers l'écran de création de quiz
    Navigator.of(context).push(
    MaterialPageRoute(
    builder: (_) => const QuizzCreator(),
    ),
    );
    },
    child: const Icon(Icons.add),
    ),
    );

  }

  Widget _buildQuizTheme(BuildContext context, String title, String imagePath, Color color) {
    return GestureDetector(
      onTap: () {
        // Naviguer vers l'écran du quiz correspondant
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => myQuizzList(title:title,color:color),
          ),
        );

      },
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,


              ),
            ),
          ],
        ),
      ),
    );
  }
}
