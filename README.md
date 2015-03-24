# singlerun
Make sure an instance of the currently running script is only instanced once.

By default, singlerun will process exit when there is another process with the same script file running.


## Install

    npm install --save singlerun

## Usage

    singlerun = require('singlerun')

    singlerun(function(){
      console.log('we are single running!');
    });

## Options

singlerun ( [bool killother] [, bool includeParams] [, bool verbose], callback )


### Killother

Optional  
Default: False  
Set it to true to kill other identical process

### IncludeParams

Optional  
Default: False  
Set it to true to include all process params in the creation of a unique PID hash. Usefull when you need to run more than one of the same process but with different parameters.

### Verbose

Optional  
Default: False
Set it to true to display SingleRun logs in your code

### Callback

Required
The callback to run when SingleRun has evaluated true

## TODO
Killother is not implemented yet.


## Changelog
- 0.15.0324-c: Created the required index.js and added coffeescript to dependencies
- 0.15.0324-b: Readme upgraded, some bugfixes
- 0.15.0324-a: Release to npm
