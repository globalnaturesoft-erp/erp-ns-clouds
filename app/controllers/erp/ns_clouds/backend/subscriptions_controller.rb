require_dependency "erp/backend/backend_controller"

module Erp
  module NsClouds
    module Backend
      class SubscriptionsController < Erp::Backend::BackendController
        before_action :set_subscription, only: [:archive, :unarchive, :edit, :update, :destroy]
        before_action :set_subscriptions, only: [:delete_all, :archive_all, :unarchive_all]
        
        # GET /subscriptions
        def index
        end
        
        # POST /subscriptions/list
        def list
          @subscriptions = Subscription.search(params).paginate(:page => params[:page], :per_page => 3)
          
          render layout: nil
        end
    
        # GET /subscriptions/new
        def new
          @subscription = Subscription.new
        end
    
        # GET /subscriptions/1/edit
        def edit
        end
    
        # POST /subscriptions
        def create
          @subscription = Subscription.new(subscription_params)
          @subscription.creator = current_user
          @subscription.registed_at = Time.now
    
          if @subscription.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @subscription.name,
                value: @subscription.id
              }
            else
              redirect_to erp_ns_clouds.edit_backend_subscription_path(@subscription), notice: t('.success')
            end
          else
            render :new        
          end
        end
    
        # PATCH/PUT /subscriptions/1
        def update
          if @subscription.update(subscription_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @subscription.name,
                value: @subscription.id
              }              
            else
              redirect_to erp_ns_clouds.edit_backend_subscription_path(@subscription), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /subscriptions/1
        def destroy
          @subscription.destroy
    
          respond_to do |format|
            format.html { redirect_to erp_ns_clouds.backend_subscriptions_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def archive
          @subscription.archive
          respond_to do |format|
            format.html { redirect_to erp_ns_clouds.backend_subscriptions_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def unarchive
          @subscription.unarchive
          respond_to do |format|
            format.html { redirect_to erp_ns_clouds.backend_subscriptions_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # DELETE /subscriptions/delete_all?ids=1,2,3
        def delete_all         
          @subscriptions.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # Archive /subscriptions/archive_all?ids=1,2,3
        def archive_all         
          @subscriptions.archive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # Unarchive /subscriptions/unarchive_all?ids=1,2,3
        def unarchive_all
          @subscriptions.unarchive_all
          
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
              render json: Subscription.dataselect(params[:keyword])
            }
          end
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_subscription
            @subscription = Subscription.find(params[:id])
          end
          
          def set_subscriptions
            @subscriptions = Subscription.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def subscription_params
            params.fetch(:subscription, {}).permit(:account_id, :plan_id, :quantity)
          end
      end
    end
  end
end
