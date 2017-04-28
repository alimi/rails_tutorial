require './lib/deployer'

task default: :build

desc "Build the current branch"
task :build do
  sh "jekyll build"
end

desc "Prepare the current branch for deployment"
task :prepare_deploy do
  deploy_sha = `git rev-parse --verify HEAD`

  Deployer.prepare_deploy(deploy_sha: deploy_sha)
end
