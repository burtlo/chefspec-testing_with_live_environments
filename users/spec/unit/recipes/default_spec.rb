#
# Cookbook Name:: users
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'
require 'json'

describe 'users::default' do
  context 'When all attributes are default, on an unspecified platform' do
    context 'in _default environment' do
      let(:chef_run) do
        runner = ChefSpec::ServerRunner.new
        runner.converge(described_recipe)
      end

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      it 'sets creates the user correctly' do
        expect(chef_run).to create_user('fwebber').with(uid: 2000)
      end
    end

    context 'in staging' do
      let(:chef_run) do
        runner = ChefSpec::ServerRunner.new do |node, server|
          server.create_environment(environment['name'],{ default_attributes: environment['default_attributes'] })
          node.chef_environment = 'staging'
        end
        runner.converge(described_recipe)
      end

      let(:environment) do
        Chef::Environment.load_from_file(environment_name)
      end

      let(:environment_name) do
        'staging'
      end

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      it 'sets creates the user correctly' do
        expect(chef_run).to create_user('fwebber').with(uid: 3000)
      end
    end

    context 'in production' do
      let(:chef_run) do
        runner = ChefSpec::ServerRunner.new do |node, server|
          server.create_environment(environment.name,{ default_attributes: environment.default_attributes })
          node.chef_environment = 'production'
        end
        runner.converge(described_recipe)
      end

      let(:environment) do
        Chef::Environment.load_from_file(environment_name)
      end

      let(:environment_name) do
        'production'
      end

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      it 'sets creates the user correctly' do
        expect(chef_run).to create_user('fwebber').with(uid: 4000)
      end
    end

  end
end
