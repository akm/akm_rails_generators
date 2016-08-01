require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

<% module_namespacing do -%>
RSpec.describe <%= controller_class_name %>Controller, <%= type_metatag(:controller) %> do

  login_user
<%-
  # UPDATE attributes with DB schema
  db_cols = ActiveRecord::Base.connection.select_all("DESC #{table_name}")
  db_cols_hash = db_cols.each_with_object({}){|col, d| d[col['Field']] = col }
  attributes.each do |attr|
    if col = db_cols_hash[attr.column_name]
      attr.attr_options[:required] ||= (col['Null'] =~ /NO/i)
    end
  end

  required_ref_attrs  = attributes.select{|attr|  attr.reference? && attr.required? }
  required_data_attrs = attributes.select{|attr| !attr.reference? && attr.required? }
-%>
<%- required_ref_attrs.each do |attr| -%>
  let(:<%= attr.name %>){ FactoryGirl.create(:<%= attr.name %>) }
<%- end -%>

  # This should return the minimal set of attributes required to create a valid
  # <%= class_name %>. As you add validations to <%= class_name %>, be sure to
  # adjust the attributes here as well.
  let(:valid_parameters) {
<%-
 extra_options = required_ref_attrs.map{|attr| "#{attr.name}_id: #{attr.name}.id"}
 extra_options_str = extra_options.blank? ? nil : ".merge(#{extra_options.join(', ')})"
-%>
    FactoryGirl.attributes_for(:<%= ns_file_name %>)<%= extra_options_str %>
  }

  let(:invalid_parameters) {
<%- if !required_data_attrs.empty? -%>
    valid_parameters.merge('<%= required_data_attrs.first.name %>' => '')
<%- elsif !required_ref_attrs.empty? -%>
    valid_parameters.merge('<%= required_ref_attrs.first.name %>_id' => '')
<%- else -%>
    skip("Add a hash of attributes invalid for your model")
<%- end -%>
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # <%= controller_class_name %>Controller. Be sure to keep this updated too.
  let(:valid_session) { {} }

<% unless options[:singleton] -%>
  describe "GET #index" do
    it "assigns all <%= table_name.pluralize %> as @<%= table_name.pluralize %>" do
      <%= file_name %> = FactoryGirl.create(:<%= ns_file_name %>)
      get :index, {}, valid_session
      expect(assigns(:<%= table_name %>)).to eq([<%= file_name %>])
    end
  end

<% end -%>
  describe "GET #show" do
    it "assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>" do
      <%= file_name %> = FactoryGirl.create(:<%= ns_file_name %>)
      get :show, {:id => <%= file_name %>.to_param}, valid_session
      expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>)
    end
  end

  describe "GET #new" do
    it "assigns a new <%= ns_file_name %> as @<%= ns_file_name %>" do
      get :new, {}, valid_session
      expect(assigns(:<%= ns_file_name %>)).to be_a_new(<%= class_name %>)
    end
  end

  describe "GET #edit" do
    it "assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>" do
      <%= file_name %> = FactoryGirl.create(:<%= ns_file_name %>)
      get :edit, {:id => <%= file_name %>.to_param}, valid_session
      expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new <%= class_name %>" do
        expect {
          post :create, {:<%= ns_file_name %> => valid_parameters}, valid_session
        }.to change(<%= class_name %>, :count).by(1)
      end

      it "assigns a newly created <%= ns_file_name %> as @<%= ns_file_name %>" do
        post :create, {:<%= ns_file_name %> => valid_parameters}, valid_session
        expect(assigns(:<%= ns_file_name %>)).to be_a(<%= class_name %>)
        expect(assigns(:<%= ns_file_name %>)).to be_persisted
      end

      it "redirects to the created <%= ns_file_name %>" do
        post :create, {:<%= ns_file_name %> => valid_parameters}, valid_session
        expect(response).to redirect_to(<%= class_name %>.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved <%= ns_file_name %> as @<%= ns_file_name %>" do
        post :create, {:<%= ns_file_name %> => invalid_parameters}, valid_session
        expect(assigns(:<%= ns_file_name %>)).to be_a_new(<%= class_name %>)
      end

      it "re-renders the 'new' template" do
        post :create, {:<%= ns_file_name %> => invalid_parameters}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
<%- if !required_data_attrs.empty? -%>
  <%- required_data_attrs.each do |required_data_attr| -%>
      let(:new_<%= required_data_attr.name %>){ valid_parameters[:<%= required_data_attr.name %>].succ }
  <%- end -%>
<%- elsif !required_ref_attrs.empty? -%>
      let(:another_<%= required_ref_attrs.last.name %>){ FactoryGirl.create(:<%= required_ref_attrs.last.name %>) }
<%- end -%>

      let(:new_parameters) {
<%- if !required_data_attrs.empty? -%>
        valid_parameters.merge(<%= required_data_attrs.map{|attr| "#{attr.name}: new_#{attr.name}"}.join(', ') %>)
<%- elsif !required_ref_attrs.empty? -%>
        valid_parameters.merge(<%= required_ref_attrs.last.name %>_id: another_<%= required_ref_attrs.last.name %>.id)
<%- else required_data_attrs.empty? -%>
        skip("Add a hash of attributes valid for your model")
<%- end -%>
      }

      it "updates the requested <%= ns_file_name %>" do
        <%= file_name %> = FactoryGirl.create(:<%= ns_file_name %>)
        put :update, {:id => <%= file_name %>.to_param, :<%= ns_file_name %> => new_parameters}, valid_session
        <%= file_name %>.reload
<%- if !required_data_attrs.empty? -%>
  <%- required_data_attrs.each do |attr| -%>
        expect(<%= file_name %>.<%= attr.name %>).to eq new_<%= attr.name %>
  <%- end -%>
<%- elsif !required_ref_attrs.empty? -%>
        expect(<%= file_name %>.<%= required_ref_attrs.last.name %>_id).to eq another_<%= required_ref_attrs.last.name %>.id
<%- else -%>
        skip("Add assertions for updated state")
<%- end -%>
      end

      it "assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>" do
        <%= file_name %> = FactoryGirl.create(:<%= ns_file_name %>)
        put :update, {:id => <%= file_name %>.to_param, :<%= ns_file_name %> => valid_parameters}, valid_session
        expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>)
      end

      it "redirects to the <%= ns_file_name %>" do
        <%= file_name %> = FactoryGirl.create(:<%= ns_file_name %>)
        put :update, {:id => <%= file_name %>.to_param, :<%= ns_file_name %> => valid_parameters}, valid_session
        expect(response).to redirect_to(<%= file_name %>)
      end
    end

    context "with invalid params" do
      it "assigns the <%= ns_file_name %> as @<%= ns_file_name %>" do
        <%= file_name %> = FactoryGirl.create(:<%= ns_file_name %>)
        put :update, {:id => <%= file_name %>.to_param, :<%= ns_file_name %> => invalid_parameters}, valid_session
        expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>)
      end

      it "re-renders the 'edit' template" do
        <%= file_name %> = FactoryGirl.create(:<%= ns_file_name %>)
        put :update, {:id => <%= file_name %>.to_param, :<%= ns_file_name %> => invalid_parameters}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested <%= ns_file_name %>" do
      <%= file_name %> = FactoryGirl.create(:<%= ns_file_name %>)
      expect {
        delete :destroy, {:id => <%= file_name %>.to_param}, valid_session
      }.to change(<%= class_name %>, :count).by(-1)
    end

    it "redirects to the <%= table_name %> list" do
      <%= file_name %> = FactoryGirl.create(:<%= ns_file_name %>)
      delete :destroy, {:id => <%= file_name %>.to_param}, valid_session
      expect(response).to redirect_to(<%= index_helper %>_url)
    end
  end

end
<% end -%>
