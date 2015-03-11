require 'spec_helper'

describe 'spotlight/sir_trevor/blocks/_solr_documents_osd_block.html.erb', type: :view do

  let(:p) { "spotlight/sir_trevor/blocks/solr_documents_osd_block.html.erb" }
  let(:page) { double("Page") }
  let(:block) do
    SirTrevorRails::Blocks::SolrDocumentsGridBlock.new({type: "block", data: { title: "Some title", text: "Some text", "text-align" => "right" }}, page)
  end
  let(:doc) { ::SolrDocument.new(id: 1) }

  before do
    allow(block).to receive(:documents).and_return([doc])
    allow(block).to receive(:document_options).and_return({})
  end

  before do
    allow(view).to receive_messages(has_thumbnail?: true, render_thumbnail_tag: 'thumb')
  end

  it "should have a slideshow block" do
    expect(view).to receive(:render_document_partial).with(doc, "openseadragon", hash_including()).and_return("OSD")
    render partial: p, locals: { solr_documents_osd_block: block}
    expect(rendered).to have_selector 'h3', text: 'Some title'
    expect(rendered).to have_content "Some text"
    expect(rendered).to have_selector '.box', text: 'OSD'
    expect(rendered).to have_selector '.text-col.pull-right'
  end
end