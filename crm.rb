# Implement the new web-based CRM here.
# Do NOT copy the CRM class from the old crm assignment, as it won't work at all for the web-based version!
# You'll have to implement it from scratch.


require relative 'contact'
require 'sinatra'


# # Fake data
# Contact.create('Mark', 'Zuckerberg', 'mark@facebook.com', 'CEO')
# Contact.create('Sergey', 'Brin', 'sergey@google.com', 'Co-Founder')
# Contact.create('Steve', 'Jobs', 'steve@apple.com', 'Visionary')


get '/' do
  'Main Menu'
end


# Home Page---------
 get "/" do
  erb :index
 end


 # contacts Home Page----------
 get "/contacts" do
   @count = Contact.all.count
   #links to contacts.erb file
   return erb(:contacts)
 end

 # create a New Contact Page----------
  get "/contacts/new" do
    #links to new_contact.erb
    return erb(:new_contact)
  end


 # Creating a Contact Page-----------
  post "/contacts" do
    contact = Contact.create(
      first_name: params[:first_name],
      last_name:  params[:last_name],
      email:      params[:email],
      note:       params[:note]
      last_name:  params[:last_name],
      email:      params[:email],
      note:       params[:note]
    )
   #creates new contact from user input
   # Contact.create(params[:first_name], params[:last_name], params[:email], params[:note])
   # redirects you back to /contacts page
    redirect to ("/contacts")
  end


 # Viewing Specific Contact----------
  get "/contacts/:id/view" do
    @contact = Contact.find(params[:id].to_i)
    #link to show_contact.erb
    return erb(:show_contact)
  end


 # Editing Contact----------
  get "/contacts/:id/edit" do
    @contact = Contact.find(params[:id].to_i)
    if @contact
 @@ -57,7 +54,22 @@
    end
  end

 # Editing Contact Page Input--------
 put "/contacts/:id" do
   @contact = Contact.find(params[:id].to_i)
   if @contact.update({
     first_name: params[:first_name],
     last_name:  params[:last_name],
     email:      params[:email],
     note:       params[:note],
     })
     redirect to("/contacts")
   else
     raise Sinatra::NotFound
   end
 end

 # Deleting Contact----------
