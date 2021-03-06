require 'spec_helper'

describe Project do
  it { should belong_to(:organization) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:github_repo) }

  context "github-related methods" do

    let(:project) { Project.new }
    let(:organization) { double(github_org: 'codemontage', github_url: 'https://github.com/codemontage') }

    before do
      project.stub(:organization) { organization }
      project.stub(:github_repo) { 'foo'}
    end

    describe "#github_display" do
      it "creates an organization/repo string" do
        expect(project.github_display).to eq('codemontage/foo')
      end
    end

    describe "#github_url" do
      it "creates a repo url" do
        expect(project.github_url).to eq('https://github.com/codemontage/foo')
      end
    end

    describe "#tasks_url" do
      it "creates an issues url" do
        expect(project.tasks_url).to eq('https://github.com/codemontage/foo/issues')
      end
    end

  end

  describe "#related_projects" do

    let(:project_1) { Project.new }
    let(:project_2) { Project.new }
    let(:project_3) { Project.new }

    let(:organization) { Organization.new }

    before do
      project_1.stub(:organization) { organization }
      organization.projects = [project_1, project_2, project_3]
    end

    it "returns its organization's other projects" do
      expect(project_1.related_projects).to eq([project_2, project_3])
    end

  end

end
