class EsopipeEfosc < Formula
  desc "ESO EFOSC instrument pipeline (static data)"
  homepage "https://www.eso.org/sci/software/pipe_aem_table.html"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/efosc/efosc-kit-2.3.9-2.tar.gz"
  sha256 "515a11ddaa6f71d2ebcfff91433b782089f93af5fb7ce3daf973ccfb456f9bba"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?efosc-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/aaguirreo/homebrew-esopipelines/releases/download/esopipe-efosc-2.3.9-2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c09faf650875dcd39980f3b3610ee2ee4799f5748b7df8ccea5924f54152e483"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e3ae81b24b37c462e60e0b8339fb82e97e49db4c1670fb6fc3e5002d38b3273a"
    sha256 cellar: :any_skip_relocation, ventura:       "c10e78b4a258a3b7094afb5a5573c2a0a5b60ff75c0aeb846cc9f60534cd6c51"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a80df7c0b42d326099c2e368e671f335a2ac68fe9fa2c509222bf30c461f46c1"
  end

  def pipeline
    "efosc"
  end

  depends_on "esopipe-efosc-recipes"

  def install
    system "tar", "xf", "#{pipeline}-calib-#{version.major_minor_patch}.tar.gz"
    (prefix/"share/esopipes/datastatic/#{pipeline}-#{version.major_minor_patch}").install Dir["#{pipeline}-calib-#{version.major_minor_patch}/cal/*"]
  end

  test do
    system "true"
  end
end
