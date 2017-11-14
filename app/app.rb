# -*- coding: utf-8 -*-
require 'sinatra'
require "awesome_print"

class App < Sinatra::Application

	# basic http auth
	use Rack::Auth::Basic, "Restricted Area" do |username, password|
		    [username, password] == ['admin', 'admin']  
	end

	
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

	get '/vm/:uuid/snapshot_take' do
		@uuid = params[:uuid]
		erb :"/vm/snapshot_take"
	end

	post '/vm/:uuid/snapshot_restore/:snapshot_id' do
		vh = VboxHelper.new
		vh.snapshot_restore(params[:uuid], params[:snapshot_id])
	end

	post '/vm/:uuid/snapshot_take' do
		vh = VboxHelper.new
		vh.snapshot_take(params[:uuid], params[:name])

		redirect to '/vm/' + params[:uuid] + '/snapshots'
	end
	get '/vm/:uuid/snapshots' do
		vh = VboxHelper.new
		snapshots_s = vh.snapshots(params[:uuid])
		@snapshots = []
		snapshots_s.gsub(/Name: /, '').gsub(' (UUID: ', ',').gsub(') *',',*').gsub(')',',-').split("\n").each do |s|
			arr = s.split ','
			hash = Hash.new
			hash['name'] = arr[0].gsub(' ', "&nbsp;")
			hash['snapshot_id'] = arr[1]
			hash['is_current'] = arr[2]
			@snapshots.push hash
		end
		#puts @snapshots

		erb :"/vm/snapshots"
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

	get '/vm/:uuid/info' do
		vh = VboxHelper.new
		@vminfo = vh.vminfo(params[:uuid])

		erb :"/vm/info"
	end
end
