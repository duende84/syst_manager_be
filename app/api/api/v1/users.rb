module API
  module V1
    class Users < Grape::API
      include APIDefaults
      include APIGuard

      guard_all!

      resource :users do
        desc "Return all users"
        get "" do
          users = User.all
          present :users, users, with: UserEntity
        end

        desc "Return a user by ID"
        params do
          requires :id, type: Integer, desc: "ID of the user"
        end
        get ":id" do
          user = User.where(id: permitted_params[:id]).first!
          present :users, user, with: UserEntity
        end
      end
    end
  end
end