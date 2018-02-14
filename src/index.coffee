'use strict'
module = null
try
  module = angular.module 'ndx'
catch e
  module = angular.module 'ndx', []

module.factory 'Sorter', ->
  create: (opts) ->
    if Object.prototype.toString.call(opts.sort) is '[object Object]'
      set: (field) ->
        firstKey = Object.keys(opts.sort)[0]
        outobj = {}
        if firstKey isnt field
          outobj[field] = 1
        else
          outobj[firstKey] = if opts.sort[firstKey] is 1 then -1 else 1
        i = 0
        for key of opts.sort
          if i++ > 0
            outobj[key] = opts.sort[key]
        opts.sort = outobj
      setLocal: (field) ->
        true
      class: (field) ->
        firstKey = Object.keys(opts.sort)[0]
        "has-sort": true
        sorting: firstKey is field
        desc: opts.sort[firstKey] isnt 1
    else
      set: (field) ->
        if opts.sort isnt field
          opts.sort = field
          opts.sortDir = 'ASC'
        else
          if opts.sortDir is 'DESC'
            opts.sortDir = 'ASC'
          else
            opts.sortDir = 'DESC'
      setLocal: (field) ->
        if not opts.sort
          opts.sort = ''
        if opts.sort.indexOf(field) is -1
          opts.sort = field
          opts.sortDir = 'ASC'
        else
          if opts.sort.indexOf('-') is 0
            opts.sort = field
            opts.sortDir = 'ASC'
          else
            opts.sort = '-' + field
            opts.sortDir = 'DESC'
      class: (field) ->
        "has-sort": true
        sorting: -1 < opts.sort.indexOf(field) < 2
        desc: opts.sortDir is 'DESC'