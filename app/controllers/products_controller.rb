class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
helper_method :sort_column,:sort_direction
  autocomplete :brand, :name

  def home
    
  end

  def index
    @products = Product.paginate :per_page => 5, :page =>params[:page],:order=> (sort_column + " " + sort_direction)
#    @products = Product.order(params[:sort])

    respond_to do |format|
      format.html # index.html.erb
      format.csv  { send_data :csv => @products}
      format.xls  #{ send_data @products.to_csv(col_sep:"\t") }
    end
  end

  def import
      Product.import(params[:file])
      redirect_to root_url, :notice => 'Product imported.'
  end


  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
#    raise params[:product][:photo].inspect
    @product = Product.new(params[:product])
    respond_to do |format|
      if @product.save
        status = @product.update_attributes(:photo_file_name=>params[:product][:photo].original_filename ,:photo_content_type=>params[:product][:photo].content_type)        
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  

  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : "name"    
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end

  def about
    
  end

  def contact
    
  end

  def bus_search
#  raise params.inspect
  end

end


