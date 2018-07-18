# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include bootstrap
class bootstrap (
  String $environment,
  String $puppet_repo,
) {

  augeas {'puppet.conf':
    context => '/files/etc/puppetlabs/puppet/puppet.conf',
    changes => [
      "set main/environment ${environment}",
    ],
  }

  class {'r10k':
    remote   => $puppet_repo,
    provider => 'puppet_gem',
  }
}
