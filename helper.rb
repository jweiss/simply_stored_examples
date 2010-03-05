
CouchPotato::Config.database_name = "rugb"

CouchPotato.couchrest_database.delete! rescue nil
CouchPotato.couchrest_database.server.create_db('rugb')
