class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all 
    erb :'/pets/new'
  end

  post '/pets' do
    if params.key?("pet")
      @pet = Pet.create(name: params["pet_name"], owner_id: params["pet"]["owner_id"])
    elsif !params["owner"]["name"].empty?
      @pet = Pet.create(name: params["pet_name"], owner_id: Owner.create(name:params["owner"]["name"]).id)
    end
    redirect "pets/#{@pet.id}"
  end
  
  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    #binding.pry 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    #binding.pry
    ####### bug fix
    # if !params["pet"].keys.include?("owner_id")
    #   params["pet"]["owner_id"] = nil
    # end
      #######
   
      @pet = Pet.find(params[:id])
      @pet.update(name: params["pet_name"], owner_id: params["pet"]["owner_id"])
      if !params["owner"]["name"].empty?
        @pet.owner_id = Owner.create(name: params["owner"]["name"]).id
        @pet.save
      end
      redirect "pets/#{@pet.id}"
  end
end