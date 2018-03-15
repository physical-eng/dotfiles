gem_group :doc do
  gem 'yard'
end

gem 'rb-readline'
gem 'slim-rails'

gem_group :development do
  gem 'rubocop', require: false
  gem 'rails_best_practices'
  gem 'guard'

  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'guard-rails_best_practices', git: 'https://github.com/logankoester/guard-rails_best_practices.git'
# ...
  gem 'ruby-debug-ide'
  gem 'debase'
end

gem_group :development, :test do
  gem 'rspec-rails'
  gem "spring-commands-rspec"
# ...
end

gem_group :test do
  gem 'timecop'
# ...
end

after_bundle do
  run 'mkdir .vscode'
  run 'cp ~/.dotfiles/ruby/vscod_launch.json .vscode/launch.json'
  run 'mv README.rdoc README.md'
  run 'curl https://www.gitignore.io/api/vim,visualstudiocode,rails > .gitignore'
  run 'curl -L https://github.com/bbatsov/rubocop/raw/master/.rubocop.yml > .rubocop.yml'
  run 'rbenv rehash'
  run 'bundle exec guard init rspec'
  run 'echo \'guard :rails_best_practices, notify: true, run_at_start: false do\' >> Guardfile'
  run 'echo \'watch(%r{^app/(.+)\.rb$})\' >> Guardfile'
  run 'echo \'end\' >> Guardfile'
  run 'bundle exec guard init rails_best_practices'
  run 'bundle exec guard init rubocop'
  run 'spring stop'
  run 'bundle exec rails generate rspec:install'

  git :init
  git commit: "--allow-empty -m 'Initial Commit'"
  git add: '.'
  git commit: "-a -m 'Generate Project from Template'"
end