require 'sinatra'
require "sinatra/reloader"
require "sinatra/json"
require 'mongoid'
require 'active_support/inflector'
require 'active_model'
require 'logger'



class AutoApi::Base < Sinatra::Base
logger = Logger.new(STDOUT)
  configure :development do
    register Sinatra::Reloader
  end

  Mongoid.load!('./config/mongoid.yml')

  #WE ARE RETURNING JSON
  before '/*' do
    content_type 'application/json'
  end

  before '/:resource1/:id1/:resource2/?' do | resource1, id1, resource2 |
    @resource1 = Object.const_set(resource1.classify, Class.new)
    @resource1.include(Mongoid::Document)
    @resource1.has_many resource2
    @resource2 = Object.const_set(resource2.classify, Class.new)
    @resource2.include(Mongoid::Document)
    @resource2.belongs_to resource1.singularize
  end

  ['/:resource/?', '/:resource/:id/?'].each do |path|
    before path do
      @resource = Object.const_set(params['resource'].classify, Class.new)
      @resource.include(Mongoid::Document)
    end
  end

  get '/:resource/?' do | resource |
    webtry(lambda { json @resource.all })
  end

  get '/:resource/:id/?' do | resource, id |
    webtry(lambda { json @resource.find(id) })
  end

  post '/:resource/?' do | resource |
    logger.debug(request.body.read)
    request.body.rewind
    webtry(lambda {
    resource = @resource.new(JSON.parse request.body.read)
    resource.save!
    json resource
  })
  end

  put '/:resource/:id/?' do | resource, id |
    webtry(lambda {
    resource =  @resource.find(id)
    resource.update_attributes!(JSON.parse request.body.read)
  })
  end

  delete '/:resource/:id/?' do | resource, id |
    webtry(lambda { json @resource.find(id).delete })
  end

  delete '/:resource/?' do
    webtry(lambda { json @resource.all.delete })
  end

  #NESTED
  get '/:resource1/:id1/:resource2/?' do | resource1, id1, resource2 |
    webtry(lambda { json @resource1.find(id1).send(resource2) })
  end

  post '/:resource1/:id1/:resource2/?' do | resource1, id1, resource2 |
    webtry(lambda {
    parent_resource = @resource1.find(id1)
    child_resource = @resource2.new(request.body.read)
    child_resource.save!
    parent_resource.send(resource2) << child_resource
    json child_resource
  })
  end

  delete '/:resource1/:id1/:resource2/?' do | resource1, id1, resource2 |
    webtry(lambda { json @resource1.find(id1).send(resource2).all.delete })
  end

  def webtry(block)
    begin
     status 200
     block.call
    rescue Mongoid::Errors::DocumentNotFound
      status 404
    rescue
      status 500
    end
  end
end
