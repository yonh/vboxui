# -*- coding: utf-8 -*-
require 'sinatra'
require "awesome_print"

class App < Sinatra::Application

	get '/' do
		vh = VboxHelper.new
		@lists = vh.vms

		erb :"vm/vms"
	end

	get '/vm/:uuid/start' do
		vh = VboxHelper.new
		return vh.start(params[:uuid])
	end

	get '/vm/:uuid/stop' do
		vh = VboxHelper.new
		return vh.stop(params[:uuid])
	end

	get '/vm/:uuid/remove' do
		vh = VboxHelper.new
		return vh.remove(params[:uuid])
	end

	get '/vm/:uuid/vminfo' do
		vh = VboxHelper.new
		@vminfo = vh.vminfo(params[:uuid])

		erb :"/vm/vminfo"
	end
end
