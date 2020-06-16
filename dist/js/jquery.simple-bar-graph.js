(function($) {
  var methods;
  methods = {
    init: function(elements, options) {
      if ($(elements[0]).find('.simple-bar-graph').length) {
        $.each($(elements[0]).find('.simple-bar-graph__bar'), function(index) {
          $(this).css({
            'height': '0%'
          });
        });
        setTimeout((function() {
          methods.render(elements, options);
        }), $(elements[0]).find('.simple-bar-graph__bar').length * options.delayAnimation + 100);
      } else {
        methods.render(elements, options);
      }
    },
    render: function(elements, options) {
      var columns, columnsWidth, graph, maxValue, rowStepValue, rows, rowsHeight;
      maxValue = methods.getMaxValue(options.data);
      columnsWidth = (100 / options.data.length).toFixed(3).slice(0, -1) + '%';
      rowsHeight = (100 / options.rowsCount).toFixed(3).slice(0, -1) + '%';
      rowStepValue = maxValue / options.rowsCount;
      rows = methods.getRows(options.rowsCount, rowsHeight, rowStepValue, maxValue);
      columns = methods.getColumns(options.rowCaptionsWidth, options.height, options.data, maxValue, columnsWidth, options.barsColor, options.popups, options.delayAnimation);
      graph = $('<div/>', {
        "class": 'simple-bar-graph'
      });
      graph.append(rows);
      graph.append(columns);
      $(elements[0]).html(graph);
      $.each($(elements[0]).find('.simple-bar-graph__bar'), function() {
        $(this).height($(this).data('height'));
      });
    },
    getMaxValue: function(data) {
      var maxValue;
      maxValue = 0;
      $.each(data, function(index, element) {
        if (element.value > maxValue) {
          maxValue = element.value;
        }
      });
      return maxValue;
    },
    bindBar: function(bar) {
      bar.hover((function() {
        $(this).addClass('simple-bar-graph__bar--active');
      }), function() {
        $(this).removeClass('simple-bar-graph__bar--active');
      });
    },
    getRows: function(rowsCount, rowsHeight, rowStepValue, maxValue) {
      var currentValue, rows, rowsIterator;
      rowsIterator = rowsCount - 1;
      rows = $('<div/>', {
        "class": 'simple-bar-graph__rows'
      }).append($('<div/>', {
        "class": 'simple-bar-graph__row',
        css: {
          'height': rowsHeight
        }
      }).append($('<div/>', {
        "class": 'simple-bar-graph__value',
        text: maxValue
      })));
      while (rowsIterator > 0) {
        currentValue = parseInt(rowStepValue * rowsIterator * 10) / 10;
        rows.append($('<div/>', {
          "class": 'simple-bar-graph__row',
          css: {
            'height': rowsHeight
          }
        }).append($('<div/>', {
          "class": 'simple-bar-graph__value',
          text: currentValue.toString()
        })));
        rowsIterator--;
      }
      rows.append($('<div/>', {
        "class": 'simple-bar-graph__null'
      }).append($('<div/>', {
        "class": 'simple-bar-graph__value',
        text: 0
      })));
      return rows;
    },
    getColumns: function(rowCaptionsWidth, height, data, maxValue, columnsWidth, barsColor, popups, delayAnimation) {
      var bar, column, columnHeight, columns, columnsIterator;
      columnsIterator = 0;
      columns = $('<div/>', {
        "class": 'simple-bar-graph__columns',
        css: {
          'padding-right': rowCaptionsWidth,
          'height': height
        }
      });
      while (columnsIterator < data.length) {
        columnHeight = (data[columnsIterator].value / maxValue * 100).toFixed(3).slice(0, -1) + '%';
        column = $('<div/>', {
          "class": 'simple-bar-graph__column',
          css: {
            'width': columnsWidth
          }
        });
        bar = $('<div/>', {
          "class": 'simple-bar-graph__bar',
          css: {
            'height': '0%',
            '-webkit-transition-delay': (columnsIterator * delayAnimation) + "ms",
            '-moz-transition-delay': (columnsIterator * delayAnimation) + "ms",
            'transition-delay': (columnsIterator * delayAnimation) + "ms"
          },
          'data-height': columnHeight
        });
        if (barsColor) {
          bar.css('background-color', barsColor);
        }
        if (popups) {
          bar.append($('<div/>', {
            "class": 'simple-bar-graph__popup',
            text: data[columnsIterator].value
          }));
        }
        methods.bindBar(bar);
        column.append(bar);
        column.append($('<div/>', {
          "class": 'simple-bar-graph__caption',
          text: data[columnsIterator].key
        }));
        columns.append(column);
        columnsIterator++;
      }
      return columns;
    }
  };
  jQuery.fn.simpleBarGraph = function(options) {
    options = $.extend({
      data: [],
      rowsCount: 5,
      height: '300px',
      rowCaptionsWidth: '16px',
      barsColor: '',
      popups: true,
      delayAnimation: 20
    }, options);
    methods.init(this, options);
  };
})(jQuery);
