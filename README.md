RUN PROJECT
===========

* make up

REBUILD PROJECT
===========

* make up

* make rebuild

* docker exec -it ${APP_ID} bash
      - rake db:create
      - rake db:migrate


COMMON COMMANDS
===============

* rails new MySite
  - Create project directories

* bundle install
  - Install Gems from Gemfile

* rails server
  - Run Rails Server

* rails generate controler demo
  - Create app/controllers/demo_controller.rb
  - Create app/views/demo/ggwp.html.erb
  - Edit app/config/routes.rb "get 'welcome' => 'demo#ggwp'"
  - Browser: localhost:3000/welcome

* For DB:
  - rake db:create
  - rails g scaffold note title body:text
  - rake db:migrate

* rails generate model Message
  - Create file db/migrate/xxx_create_messages.rb

* rake db:migrate

* rake db:seed

* rails generate controller Messages
  - Edit app/config/routes.rb "get 'messages' => 'messages#index'"
  - Create app/controllers/demo_controller.rb
  - Edit "index" method, write "@messages = Message.all"
  - Create app/views/index.html.erb and populate

* Migrations
  - rails g scaffold roomtype description:string beds:integer tvs:integer baths:integer
  - rails g scaffold room roomtype:references correlative:string available:boolean bedsExtra:integer tvsExtra:integer bathsExtra:integer
  - rake db:migrate
