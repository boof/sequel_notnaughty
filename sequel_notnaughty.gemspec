spec = Gem::Specification.new do |s|
  s.name              = "sequel_notnaughty"
  s.version           = "0.6.2"
  s.date              = "2008-10-31"
  s.platform          = Gem::Platform::RUBY
  s.has_rdoc          = true
  s.extra_rdoc_files  = ["README.rdoc", "CHANGELOG.rdoc", "COPYING"]
  s.summary           = "Gifts Ruby Sequel with heavily armed validations."
  s.description       = "Gifts Ruby Sequel with heavily armed validations."
  s.author            = "Florian Aßmann"
  s.email             = "boof@monkey-patch.me"
  s.homepage          = "http://monkey-patch.me/p/not-naughty"
  s.required_ruby_version = ">= 1.8.6"
  s.add_dependency("not-naughty", "= 0.6.2")

  s.files = %w(COPYING README.rdoc Rakefile) + ["lib/sequel_notnaughty.rb", "lib/validations", "lib/validations/uniqueness_validation.rb"]
  s.test_files = ["spec/rcov.opts", "spec/sequel_spec_helper.rb", "spec/sequel_validated_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/validations_spec.rb"]

  s.require_path = "lib"

  s.rdoc_options = [
    "--quiet",
    "--title", "Ruby Sequel adapater for NotNaughty: The Validation Framework",
    "--opname", "index.html",
    "--inline-source",
    "--line-numbers",
    "--main", "README.rdoc",
    "--inline-source",
    "--charset", "utf-8"
  ]
end
