
assert = require "assert"
describe 'Pid Creation', ->
	argument_base64 = (new Buffer("--testargument").toString('base64'))
	it 'should create a pid file', (done)->
		require('child_process').exec __dirname + '/../index.coffee', (err, stdout, sdterr)->
			throw err if err
		setTimeout ->
			require('fs').exists __dirname + '/../index.coffee.pid', (exists)->
				assert.equal true, exists
				done()
		,500
	it 'should erase the pid file', (done)->
		setTimeout ->
			require('fs').exists __dirname + '/../index.coffee.pid', (exists)->
				assert.equal false, exists
				done()
		,1000
	it 'should create a pid with arguments', (done)->
		require('child_process').exec __dirname + '/../index.coffee --testargument', (err, stdout, sdterr)->
			throw err if err
		setTimeout ->
			require('fs').exists __dirname + '/../index.coffee'+argument_base64+'.pid', (exists)->
				assert.equal true, exists
				done()
		,500
	it 'should erase the pid file with arguments', (done)->
		setTimeout ->
			require('fs').exists __dirname + '/../index.coffee'+argument_base64+'.pid', (exists)->
				assert.equal false, exists
				done()
		,1000

  describe '#indexOf()', ->
		it 'should return -1 when the value is not present', ->
			assert.equal -1, [1,2,3].indexOf(5)
			assert.equal -1, [1,2,3].indexOf(0)
