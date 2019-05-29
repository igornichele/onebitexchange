# Instala as Gems
bundle check || bundle install
 
# Roda nosso servidor
bundle exec puma -C config/puma.rb

#bundle exec rdebug-ide --debug --host 0.0.0.0 --port 1234 -- rails s -p 3000 -b 0.0.0.0
