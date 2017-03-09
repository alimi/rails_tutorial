require "rake/file_utils"

class Deployer
  include FileUtils

  attr_reader :build_dir, :deploy_branch, :deploy_sha

  def self.deploy(options={})
    self.new(options).deploy
  end

  def initialize(options={})
    @build_dir = options.fetch(:build_dir, "_site")
    @deploy_branch = options.fetch(:deploy_branch, "gh-pages")
    @deploy_sha = options.fetch(:deploy_sha)
  end

  def deploy
    build
    prepare_deploy_branch
    promote_build
  end

  private

  def build
    sh "jekyll build --destination #{build_dir}"
  end

  def prepare_deploy_branch
    sh "git checkout #{deploy_branch}"
    sh "rm -rf .sass-cache"
    sh "git rm -rf ."
  end

  def promote_build
    sh "mv #{build_dir}/* ."
    sh "rm -rf #{build_dir}"
    sh "git add ."
    sh "git commit -m 'Deploy #{deploy_sha}'"
  end
end
