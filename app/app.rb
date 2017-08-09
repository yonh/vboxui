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
		vh.start(params[:uuid])

		redirect to '/'
	end

	get '/vm/:uuid/stop' do
		vh = VboxHelper.new
		vh.stop(params[:uuid])

		redirect to '/'
	end

	get '/vm/:uuid/pause' do
		vh = VboxHelper.new
		vh.pause(params[:uuid])

		redirect to '/'
	end

	get '/vm/:uuid/save_state' do
		vh = VboxHelper.new
		vh.save_state(params[:uuid])

		redirect to '/'
	end

	get '/vm/:uuid/remove' do
		vh = VboxHelper.new
		vh.remove(params[:uuid])

		redirect to '/'
	end

	get '/vm/:uuid/vminfo' do
		vh = VboxHelper.new
		@vminfo = vh.vminfo(params[:uuid])

		erb :"/vm/vminfo"
	end
end
