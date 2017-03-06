require './lib/deployer'

desc "Deploy current branch"
task :deploy do
  deploy_sha = `git rev-parse --verify HEAD`

  Deployer.deploy(deploy_sha: deploy_sha)
end
