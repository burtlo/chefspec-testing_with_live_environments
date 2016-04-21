#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

user node['users']['id'] do
  comment node['users']['comment']
  uid node['users']['uid']
  home node['users']['home']
  shell node['users']['shell']
  password node['users']['password']
end
