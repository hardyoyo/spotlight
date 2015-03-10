//= require spotlight/blocks/browse_block

SirTrevor.Blocks.SearchResults =  (function(){

  return SirTrevor.Blocks.Browse.extend({
      
    type: "search_results",

    title: function() { return "Search Results"; },

    icon_name: 'search_results',

    searches_key: "slug",
    view_key: "view",
    textable: false,
    
    content: function() {
      return _.template([this.items_selector()].join("<hr />\n"))(this);
    },
    
    description: "This widget displays a set of search results on a page. Specify a search result set by selecting an existing browse category. You can also select the view types that are available to the user when viewing the result set.",
    
    item_options: function() {
      var block = this;
      var fields = $('[data-blacklight-configuration-search-views]').data('blacklight-configuration-search-views');
    
      return $.map(fields, function(field) {
        checkbox = ""
        checkbox += "<div>";
        checkbox += "<label for='" + block.formId(block.view_key + field.key) + "'>";
          checkbox += "<input id='" + block.formId(block.view_key + field.key) + "' name='" + block.view_key + "[]' type='checkbox' value='" + field.key + "' /> ";
            checkbox += field.label;
            checkbox += "</label>";
          checkbox += "</div>";
        return checkbox;
      }).join("\n");
    },

  });
})();