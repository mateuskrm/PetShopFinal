import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' ;

class DatabaseJaAberto implements Exception{}
class ImpossivelLocalizarDiretorio implements Exception{}
class DatabaseNaoEstaAberto implements Exception{}
class ImpossivelDeletarUsuario implements Exception{}
class UsuarioJaExiste implements Exception{}
class UsuarioNaoExiste implements Exception{}
class ImpossivelLocalizarUsuario implements Exception{}
class ImpossivelDeletarPet implements Exception{}
class PetNaoExiste implements Exception{}
class ImpossivelLocalizarPet implements Exception{}
class ImpossivelDeletarAgenda implements Exception{}
class AgendaNaoExiste implements Exception{}

 Database? _db;

class Services
{
 
  Future<String> getPetNamebyId(int idPet) async
  {
    
    final pet = await Services().getPet(id: idPet);
    return pet.nome;
  }

  Future<DatabasePet> createPet({required String nome, required String especie, required String porte, required DatabaseUser dono}) async
  {
    final db = _getDatabase();

    final dbUser = await getUser(email: dono.email, password: dono.password);
    if(dbUser != dono)
    {
      throw ImpossivelLocalizarUsuario();
    }
    final petId =await db.insert(tabelaPet, {nomeColumn: nome.toLowerCase(), especieColumn: especie.toLowerCase(), porteColumn: porte.toLowerCase(), idDonoColumn: dbUser.id});
    return DatabasePet(id: petId, nome: nome, especie: especie, porte: porte, idDono: dbUser.id);
  }

  Future<void> deletePet({required int id}) async {
    final db = _getDatabase();
    final contador = await db.delete(tabelaPet, where: 'id = ?', whereArgs: [id]);
    if(contador == 0){
      throw ImpossivelDeletarPet();
    }
  }

  Future<DatabasePet> getPet({required int id}) async{
    final db = _getDatabase();
    final resultado = await db.query(tabelaPet,limit: 1, where: 'id = ?', whereArgs: [id]);
    if(resultado.isEmpty)
    {
      throw PetNaoExiste();
    }
    return DatabasePet.fromRow(resultado.first);
  }

  Future<List<DatabasePet>> getAllPets({required DatabaseUser dono})async{
    final db = _getDatabase();
    final pets = await db.query(tabelaPet, where: 'id_dono = ?', whereArgs: [dono.id]);
    List<DatabasePet> resultado = [];
    resultado.addAll(pets.map((petRow) => DatabasePet.fromRow(petRow)));
    return resultado;
  }

    Future<DatabaseAgenda> createAgenda({required DatabasePet pet, required String servico, required String data, required String entregaDomicilio}) async
  {
    final db = _getDatabase();

    final dbPet = await getPet(id: pet.id);
    if(dbPet != pet)
    {
      throw ImpossivelLocalizarPet();
    }
    final agendaId =await db.insert(tabelaAgenda, {idPetColumn: dbPet.id, idDonoColumn: dbPet.idDono, servicoColumn: servico, dataColumn: data, entregaDomicilioColumn: entregaDomicilio});
    return DatabaseAgenda(id: agendaId, idPet: pet.id, idDono: pet.idDono, servico: servico, data: data, entregaDomicilio: entregaDomicilio);
  }

  Future<void> deleteAgenda({required int id}) async {
    final db = _getDatabase();
    final contador = await db.delete(tabelaAgenda, where: 'id = ?', whereArgs: [id]);
    if(contador == 0){
      throw ImpossivelDeletarPet();
    }
  }

  Future<DatabaseAgenda> getAgenda({required int id}) async{
    final db = _getDatabase();
    final resultado = await db.query(tabelaAgenda,limit: 1, where: 'id = ?', whereArgs: [id]);
    if(resultado.isEmpty)
    {
      throw AgendaNaoExiste();
    }
    return DatabaseAgenda.fromRow(resultado.first);
  }

  Future<List<DatabaseAgenda>> getAllAgenda({required DatabaseUser dono})async{
    final db = _getDatabase();
    final agendas = await db.query(tabelaAgenda, where: 'id_dono = ?', whereArgs: [dono.id]);
    List<DatabaseAgenda> resultado = [];
    resultado.addAll(agendas.map((agendaRow) => DatabaseAgenda.fromRow(agendaRow)));
    return resultado;
    
  }


  Future<void> deleteUser({required String email, required String password}) async {
    final db = _getDatabase();
    final contadorExclusao = await db.delete
    (
      tabelaUser,
      where: 'email = ? and password = ?',
      whereArgs: [email.toLowerCase(), password.toLowerCase()], 
    );
    if (contadorExclusao != 1){
        throw ImpossivelDeletarUsuario();
    }
  }
  
  Future<DatabaseUser> createUser({required String email, required String password}) async{
    final db = _getDatabase();
    final resultados = await db.query(tabelaUser, limit: 1, where: 'email = ? and password = ?', whereArgs: [email.toLowerCase(), password.toLowerCase()]);
    if(resultados.isNotEmpty)
    {
      return getUser(email: email, password: password);
    }
    final userId = await db.insert(tabelaUser, {
      emailColumn: email.toLowerCase(),
      passwordColumn: password.toLowerCase(),
    });
    return DatabaseUser(id: userId, email: email, password: password);
  }
  
  Future<DatabaseUser> getUser({required String email, required String password}) async {
    final db = _getDatabase();
    final resultados = await db.query(tabelaUser, limit: 1, where: 'email = ?', whereArgs: [email.toLowerCase()]);
    if(resultados.isEmpty)
    {
      throw UsuarioNaoExiste();
    }
    return DatabaseUser.fromRow(resultados.first);
  }
  
  Database _getDatabase(){
    final db = _db;
    if(db == null)
    {
      throw DatabaseNaoEstaAberto();
    }else
    {
      return db;
    }
  }

  
  Future<void> close() async{
    final db = _db;
    if (db == null)
    {
      throw DatabaseNaoEstaAberto();
    }else
    {
      await db.close();
      _db = null;
    }

  }


  Future<void> open() async {
     if(_db != null)
     {
      throw DatabaseJaAberto();
     }
     try
     {
       final docsPath = await getApplicationDocumentsDirectory();
       final dbPath = join(docsPath.path, nomeBanco);
       final db = await openDatabase(dbPath);
       _db = db;

       const criarTabelaUsuario = ''' CREATE TABLE IF NOT EXISTS "user" (
	        "id"	INTEGER NOT NULL,
        	"email"	TEXT NOT NULL UNIQUE,
	        "password"	TEXT NOT NULL,
	        PRIMARY KEY("id" AUTOINCREMENT)
        ); ''';
       await db.execute(criarTabelaUsuario);

       const criarTabelaPets = '''
          CREATE TABLE IF NOT EXISTS "pet" (
          	"id"	INTEGER NOT NULL,
	          "nome"	TEXT NOT NULL,
	          "especie"	TEXT NOT NULL,
	          "porte"	TEXT NOT NULL,
          	"id_dono"	INTEGER NOT NULL,
	          FOREIGN KEY("id_dono") REFERENCES "user"("id"),
	          PRIMARY KEY("id" AUTOINCREMENT)
          );
        ''';
       await db.execute(criarTabelaPets);
       
       const criarTabelaAgenda = '''
          CREATE TABLE IF NOT EXISTS "agenda" (
	        "id"	INTEGER NOT NULL,
	        "id_pet"	INTEGER NOT NULL,
          "id_dono"	INTEGER NOT NULL,
          "servico"	TEXT NOT NULL,
	        "data"	TEXT NOT NULL,
        	"entrega_domicilio"	TEXT NOT NULL,
        	PRIMARY KEY("id" AUTOINCREMENT),
        	FOREIGN KEY("id_pet") REFERENCES "pet"("id")
          FOREIGN KEY("id_dono") REFERENCES "pet"("id")
        );
        ''';
        await db.execute(criarTabelaAgenda);
     }on MissingPlatformDirectoryException
     {
      throw ImpossivelLocalizarDiretorio();
     }
  }
}

@immutable
class DatabaseUser
{
  final int id;
  final String email;
  final String password;
  const DatabaseUser({required this.id, required this.email, required this.password});
  
  DatabaseUser.fromRow(Map<String, Object?> map) : id = map[idColumn] as int, email = map[emailColumn] as String, password = map[passwordColumn] as String;

  @override
  bool operator ==(covariant DatabaseUser other) => id == other.id;

  @override
  int get hashcode => id.hashCode;
}

class DatabasePet
{
  final int id;
  final String nome;
  final String especie;
  final String porte;
  final int idDono;
  const DatabasePet({required this.id, required this.nome, required this.especie, required this.porte, required this.idDono});

  DatabasePet.fromRow(Map<String, Object?> map): 
  id = map[idColumn] as int, 
  nome = map[nomeColumn] as String, 
  especie = map[especieColumn] as String,
  porte = map[porteColumn] as String,
  idDono = map[idDonoColumn] as int;

  @override
  bool operator ==(covariant DatabasePet other) => id == other.id;

  @override
  int get hashcode => id.hashCode;

}

class DatabaseAgenda
{
  final int id;
  final int idPet;
  final int idDono;
  final String servico;
  final String data;
  final String entregaDomicilio;

  const DatabaseAgenda({required this.id, required this.idPet,required this.idDono, required this.servico, required this.data, required this.entregaDomicilio});

  DatabaseAgenda.fromRow(Map<String, Object?> map): 
  id = map[idColumn] as int,
  idPet = map[idPetColumn] as int,
  idDono = map[idDonoColumn] as int,
  servico = map[servicoColumn] as String,
  data = map[dataColumn] as String,
  entregaDomicilio = map[entregaDomicilioColumn] as String;

    @override
  bool operator ==(covariant DatabasePet other) => id == other.id;

  @override
  int get hashcode => id.hashCode;

}

const nomeBanco = "pets.db";

const idColumn = "id";
const emailColumn = "email";
const passwordColumn = "password";

const nomeColumn = "nome";
const especieColumn = "especie";
const porteColumn = "porte";
const idDonoColumn = "id_dono";

const idPetColumn = "id_pet";
const servicoColumn = "servico";
const dataColumn = "data";
const entregaDomicilioColumn = "entrega_domicilio";

const tabelaUser = 'user';
const tabelaPet = 'pet';
const tabelaAgenda = 'agenda';