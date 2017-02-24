module Erp
  module NsClouds
    module Backend
      class AccountsController < Erp::Backend::BackendController
        before_action :set_account, only: [:archive, :unarchive, :edit, :update, :destroy]
        before_action :set_accounts, only: [:delete_all, :archive_all, :unarchive_all]
        
        # GET /accounts
        def index
        end
        
        # POST /accounts/list
        def list
          @accounts = Account.search(params).paginate(:page => params[:page], :per_page => 3)
          
          render layout: nil
        end
    
        # GET /accounts/new
        def new
          @account = Account.new
        end
    
        # GET /accounts/1/edit
        def edit
        end
    
        # POST /accounts
        def create
          @account = Account.new(account_params)
          @account.creator = current_user
          
          if @account.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @account.name,
                value: @account.id
              }
            else
              redirect_to erp_ns_clouds.edit_backend_account_path(@account), notice: t('.success')
            end
          else
            render :new        
          end
        end
    
        # PATCH/PUT /accounts/1
        def update
          
          if @account.update(account_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @account.name,
                value: @account.id
              }              
            else
              redirect_to erp_ns_clouds.edit_backend_account_path(@account), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /accounts/1
        def destroy
          @account.destroy
    
          respond_to do |format|
            format.html { redirect_to erp_ns_clouds.backend_accounts_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # ARCHIVE /accounts/archive?id=1
        def archive
          @account.archive
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # UNARCHIVE /accounts/unarchive?id=1
        def unarchive
          @account.unarchive
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # DELETE ALL /accounts/delete_all?ids=1,2,3
        def delete_all         
          @accounts.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # ARCHIVE ALL /accounts/archive_all?ids=1,2,3
        def archive_all         
          @accounts.archive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # UNARCHIVE ALL /accounts/unarchive_all?ids=1,2,3
        def unarchive_all
          @accounts.unarchive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # DATASELECT
        def dataselect
          respond_to do |format|
            format.json {
              render json: Account.dataselect(params[:keyword])
            }
          end
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_account
            @account = Account.find(params[:id])
          end
          
          def set_accounts
            @accounts = Account.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def account_params
            params.fetch(:account, {}).permit(:image_url, :domain, :username, :password, :name, :legal_representative, :phone, :email,
                                              :address, :website, :fax, :tax, :industry_id, :country_id, :state_id)
          end
      end
    end
  end
end
