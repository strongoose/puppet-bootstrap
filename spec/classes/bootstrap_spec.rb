require 'spec_helper'

describe 'bootstrap' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'without required parameters set' do
        it { is_expected.to compile.and_raise_error(%r{Evaluation Error}) }
      end

      context 'with required parameters set' do
        let(:params) do
          {
            'environment' => 'test',
            'puppet_repo' => 'git@example.com:example/puppet.git',
          }
        end

        it { is_expected.to compile }
        it {
          is_expected.to contain_augeas('puppet.conf')
            .with_context('/files/etc/puppetlabs/puppet/puppet.conf')
        }
        it { is_expected.to contain_class('r10k') }
      end
    end
  end
end
