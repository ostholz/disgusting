class NoisesController < ApplicationController
  before_action :set_noise, only: [:show, :edit, :update, :destroy]

  # GET /noises
  # GET /noises.json
  def index
    @noise = Noise.new
    @noises = Noise.all
    params[:page] ||= 1

    respond_to do |format|
      format.html { @noises = Noise.paginate(per_page: 20, page: params[:page]) }
      format.json do 
        list = @noises.map
        render json: Noise.all.select('id, name, icon') 
      end
    end
    
  end

  # GET /noises/1
  # GET /noises/1.json
  def show
  end

  # GET /noises/new
  def new
    @noise = Noise.new
  end

  # GET /noises/1/edit
  def edit
  end

  # POST /noises
  # POST /noises.json
  def create
    # @noise = Noise.new(noise_params)
    icon_dir = 'app/assets/images/'
    audio_dir = 'public/audios/'
    #origin filenames
    noise_name_o = params[:noise][:name].original_filename
    noise_icon_o = params[:noise][:icon].original_filename

    time_as_filename = Time.now.strftime('%Y%d%m%M%S')

    # Target names
    noise_name_t = time_as_filename + File.extname(noise_name_o)
    noise_icon_t = time_as_filename + File.extname(noise_icon_o)

    # save into directory
    audio_path = File.join(Rails.root, audio_dir, noise_name_t)
    icon_path = File.join(Rails.root, icon_dir, noise_icon_t)

    File.open(audio_path, 'wb') { |f| f.write(params[:noise][:name].read)}
    File.open( icon_path, 'wb') { |f| f.write(params[:noise][:icon].read)}

    @noise = Noise.new
    @noise.name = noise_name_t
    @noise.icon = noise_icon_t
    @noise.tag = params[:tag]
    @noise.description = params[:description]

    respond_to do |format|
      if @noise.save
        format.html { redirect_to action: :index}
        format.json { render action: 'show', status: :created, location: @noise }
      else
        format.html { render action: :index}
        format.json { render json: @noise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /noises/1
  # PATCH/PUT /noises/1.json
  def update
    respond_to do |format|
      if @noise.update(noise_params)
        format.html { redirect_to @noise, notice: 'Noise was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @noise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /noises/1
  # DELETE /noises/1.json
  def destroy
    @noise.destroy

    # TODO: delete icon and audio files
    respond_to do |format|
      format.html { redirect_to noises_url }
      format.json { head :no_content }
    end
  end

  def audio_file
    file_path = "#{Rails.root}/public/audios/#{params[:filename]}.#{params[:format]}"
    send_file( file_path, filename: params[:filename], disposition: 'attachment')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_noise
      @noise = Noise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def noise_params
      params[:noise]
    end
end
