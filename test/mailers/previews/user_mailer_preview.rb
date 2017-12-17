<<<<<<< 4b1bb129326d45fd36b57774bb93b55a4923aed9
<<<<<<< a6ab824ab4db9629f39caf6f8d44cc376a3aa05f
class UserMailerPreview < ActionMailer::Preview

  def account_activation
    user = User.first
    user.activation_token = User.new_token
    UserMailer.account_activation user
  end

  def password_reset
    user = User.first
    user.reset_token = User.new_token
    UserMailer.password_reset user
  end
=======
# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
=======
>>>>>>> Add password reset
class UserMailerPreview < ActionMailer::Preview

  def account_activation
    user = User.first
    user.activation_token = User.new_token
    UserMailer.account_activation user
  end

  def password_reset
    user = User.first
    user.reset_token = User.new_token
    UserMailer.password_reset user
  end

>>>>>>> Add account activation
end
