class AnswersController < ApplicationController
  before_action :set_answer, only: %i[ show update destroy ]

  # GET /answers
  def index
    @answers = Answer.all

    render json: @answers, include: [:vote]
  end

  # GET /answers/1
  def show
    render json: @answer
  end

  # POST /answers
  def create
    user = User.find_or_create_by(id: 1, email: 'a@rippling.com')
    new_params = answer_params.to_h
    new_params['user'] = user

    @answer = Answer.new(new_params)

    if @answer.save
      render json: @answer, status: :created, location: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /answers/1
  def update
    if @answer.update(answer_params)
      render json: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /answers/1
  def destroy
    @answer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:answer).permit(:content, :question_id, :user_id)
    end
end
