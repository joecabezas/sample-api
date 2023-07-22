class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show update destroy ]

  # GET /questions
  def index
    @questions = Question.all

    render json: @questions, include: [:answer]
  end

    render json: @products, include: [:category], except: [:category_id]
  # GET /questions/1
  def show
    render json: @question
  end

  # POST /questions
  def create
    user = User.find_or_create_by(id: 1, email: 'a@rippling.com')
    new_params = question_params.to_h
    new_params['user'] = user

    @question = Question.new(new_params)

    if @question.save
      render json: @question, status: :created, location: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:title, :content, :user_id)
    end
end
