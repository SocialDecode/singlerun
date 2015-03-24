#!/usr/bin/env coffee

doPid = ([killother, includeparams, verbose]..., callback)->
	killother ?= false
	includeparams ?= true
	verbose ?= false
	# process and stuff (stick to 1 instance per execution)
	delpid = true
	fs = require "fs"
	leargs = ""
	leargs+=arg for arg,i in process.argv when arg isnt "coffee" and arg isnt "node" and arg isnt __filename if includeparams
	pidfile = __dirname + "/" + __filename.split('/').pop() + (new Buffer(leargs).toString('base64')) + '.pid'
	console.log('[SingleRun] Hash key: '+(new Buffer(leargs).toString('base64'))) if verbose
	console.log("[SingleRun] Args: ", leargs) if verbose
	process.on 'exit', (code) ->
		if fs.existsSync(pidfile) and delpid
			console.log('[SingleRun] Removing pid file..') if verbose
			fs.unlinkSync pidfile
			return

	isrunning = (pid, callback)->
		require('child_process').exec 'ps -A -o pid', (error, stdout, stderr)->
			if error
				#console.log cmdline, error, stdout, stderr
				throw new Error (error)
			callback (stdout.split("\n").indexOf(pid) isnt -1)

	check = (cback)->
		if fs.existsSync(pidfile)
			#there is already a process running
			delpid = false
			console.log "[SingleRun] Pid file exists"
			data = fs.readFileSync pidfile, "utf8"
			if data?
				isrunning data,(isit)->
					if isit
						console.log('[SingleRun] '+__filename+' IS already running') if verbose
						process.exit 1
					else
						if verbose
							console.log('[SingleRun] %s Process not found, running it (and removing pid in proces)', data)
						cback()
			else
				if verbose
					console.log("[SingleRun] Pid file found but no data in it, erasing pid")
				cback()
		else
			cback()
	check ()->
		#create a pid file and run main
		fs.unlink pidfile, (err) ->
			# just in case
			fs.writeFile pidfile, process.pid, { encoding: 'utf8' }, (err) ->
				throw err if err
				console.log('[SingleRun] created ', pidfile) if verbose
				callback()

if !module.parent
	doPid false,true,->
		console.log("[SingleRun] Running") if verbose
		setTimeout ->
			console.log("[SingleRun] Not anymore") if verbose
			process.exit 0
		,1000
else
	module.exports = doPid
