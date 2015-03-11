//= require spotlight/blocks/solr_documents_block

SirTrevor.Blocks.SolrDocumentsOsd = (function(){

  return SirTrevor.Blocks.SolrDocuments.extend({
    type: "solr_documents_Osd",
    title: function() { return "Item OSD"; },

    icon_name: "item_osd",
    blockGroup: 'Exhibit item widgets',
    description: "This widget displays items in an OpenSeaDragon environment",

    item_options: function() { return "" }
  });

})();