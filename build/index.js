(function() {
  'use strict';
  var e, module;

  module = null;

  try {
    module = angular.module('ndx');
  } catch (error) {
    e = error;
    module = angular.module('ndx', []);
  }

  module.factory('Sorter', function() {
    return {
      create: function(opts) {
        return {
          set: function(field) {
            if (opts.sort !== field) {
              opts.sort = field;
              return opts.sortDir = 'ASC';
            } else {
              if (opts.sortDir === 'DESC') {
                return opts.sortDir = 'ASC';
              } else {
                return opts.sortDir = 'DESC';
              }
            }
          },
          setLocal: function(field) {
            if (!opts.sort) {
              opts.sort = '';
            }
            if (opts.sort.indexOf(field) === -1) {
              opts.sort = field;
              return opts.sortDir = 'ASC';
            } else {
              if (opts.sort.indexOf('-') === 0) {
                opts.sort = field;
                return opts.sortDir = 'ASC';
              } else {
                opts.sort = `-${field}`;
                return opts.sortDir = 'DESC';
              }
            }
          },
          class: function(field) {
            var ref;
            return {
              "has-sort": true,
              sorting: (-1 < (ref = opts.sort.indexOf(field)) && ref < 2),
              desc: opts.sortDir === 'DESC'
            };
          }
        };
      }
    };
  });

}).call(this);

//# sourceMappingURL=index.js.map
