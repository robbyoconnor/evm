require 'pathname'

module Evm
  def self.root
    Pathname.new(__FILE__).parent.parent.expand_path
  end

  def self.local
    Pathname.new('/').join('usr', 'local', 'evm')
  end

  def self.die(*args)
    args.each do |arg|
      STDERR.print(arg)
      STDERR.puts
    end

    exit 1
  end

  def self.print_usage_and_die
    die <<-EOS
USAGE: evm COMMAND [OPTIONS]

Emacs Version Manager

COMMANDS:
 install <name>             Install package name
 uninstall <name>           Uninstall package name
 bin [name]                 Show path to Emacs binary for package name
 list                       List all available packages
 use <name>                 Select name as current package

OPTIONS:
 --force                    Force install even when already installed
 --help, -h                 Display this help message
    EOS
  end
end

require 'evm/os'
require 'evm/cli'
require 'evm/recipe'
require 'evm/package'
require 'evm/command'
require 'evm/exception'
require 'evm/builder'
require 'evm/tar_file'
require 'evm/system'