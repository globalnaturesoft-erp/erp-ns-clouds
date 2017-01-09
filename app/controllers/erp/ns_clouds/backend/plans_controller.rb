require_dependency "erp/backend/backend_controller"

module Erp
  module NsClouds
    module Backend
      class PlansController < Erp::Backend::BackendController
        before_action :set_plan, only: [:archive, :unarchive, :edit, :update, :destroy]
        before_action :set_plans, only: [:delete_all, :archive_all, :unarchive_all]
        
        # GET /plans
        def index
        end
        
        # POST /plans/list
        def list
          @plans = Plan.search(params).paginate(:page => params[:page], :per_page => 3)
          
          render layout: nil
        end
    
        # GET /plans/new
        def new
          @plan = Plan.new
          @plan.plan_details << PlanDetail.new
        end
    
        # GET /plans/1/edit
        def edit
        end
    
        # POST /plans
        def create
          @plan = Plan.new(plan_params)
          @plan.creator = current_user
    
          if @plan.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @plan.name,
                value: @plan.id
              }
            else
              redirect_to erp_ns_clouds.edit_backend_plan_path(@plan), notice: t('.success')
            end
          else
            render :new        
          end
        end
    
        # PATCH/PUT /plans/1
        def update
          if @plan.update(plan_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @plan.name,
                value: @plan.id
              }              
            else
              redirect_to erp_ns_clouds.edit_backend_plan_path(@plan), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /plans/1
        def destroy
          @plan.destroy
    
          respond_to do |format|
            format.html { redirect_to erp_ns_clouds.backend_plans_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def archive
          @plan.archive
          respond_to do |format|
            format.html { redirect_to erp_ns_clouds.backend_plans_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def unarchive
          @plan.unarchive
          respond_to do |format|
            format.html { redirect_to erp_ns_clouds.backend_plans_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # DELETE /plans/delete_all?ids=1,2,3
        def delete_all         
          @plans.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # Archive /plans/archive_all?ids=1,2,3
        def archive_all         
          @plans.archive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # Unarchive /plans/unarchive_all?ids=1,2,3
        def unarchive_all
          @plans.unarchive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        def dataselect
          respond_to do |format|
            format.json {
              render json: Plan.dataselect(params[:keyword])
            }
          end
        end
        
        def form_plan_detail
          @plan_detail = PlanDetail.new
          render partial: params[:partial], locals: { plan_detail: @plan_detail, uid: helpers.unique_id() }
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_plan
            @plan = Plan.find(params[:id])
          end
          
          def set_plans
            @plans = Plan.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def plan_params
            params.fetch(:plan, {}).permit(:name, :price, :period, :description,
                                           :plan_details_attributes => [:id, :name, :icon, :description, :plan_id, :_destroy])
          end
      end
    end
  end
end
