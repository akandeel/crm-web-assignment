# Implement the new web-based CRM here.
# Do NOT copy the CRM class from the old crm assignment, as it won't work at all for the web-based version!
# You'll have to implement it from scratch.


require relative 'contact'
require 'sinatra'

## Temporary fake data so that we always find contact with id 1.
Contact.create('Betty', 'Maker', 'betty@bitmakerlabs.com', 'Developer')

# # Fake data
# Contact.create('Mark', 'Zuckerberg', 'mark@facebook.com', 'CEO')
# Contact.create('Sergey', 'Brin', 'sergey@google.com', 'Co-Founder')
# Contact.create('Steve', 'Jobs', 'steve@apple.com', 'Visionary')

get "/" do
   @crm_app_name = "CRM Project"
   return erb(:index)
 end

 get "/contacts" do
   @count = Contact.all.count
   #links to contacts.erb file
   return erb(:contacts)
 end


 get "/contacts/new" do
   #links to new_contact.erb
   return erb(:new_contact)
 end


 post "/contacts" do
  contact = Contact.create(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    note: params[:note]
  )
  redirect to ("/contacts")
   #creates new contact from user input
  Contact.create(params[:first_name], params[:last_name], params[:email], params[:note])
    # Contact.create(params[:first_name], params[:last_name], params[:email], params[:note])
   # redirects you back to /contacts page
 end
 get '/contacts/:id' do
   @contact = Contact.find(params[:id].to_i)
   if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/view" do
  @contact = Contact.find(params[:id].to_i)
  return erb(:show_contact)
  end


get "/contacts/:id/edit" do
  @contact = Contact.find(params[:id].to_i)
    if @contact
    erb(:edit_contact)
  else
    raise Sinatra::NotFound
  end
end




get "/contacts/:id/delete" do
  contact = Contact.find(params[:id].to_i)
  if contact
    contact.delete
  else
    raise Sinatra::NotFound
  end
  redirect to ("/contacts")
end


 after do
   ActiveRecord::Base.connection.close
 end
