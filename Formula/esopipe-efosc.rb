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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7f3279a605077529c19dd00a8b54b7921e4d8aae165f6b80271aed43da825848"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a1c84c97c822be501e5b7ccdae84e4ad7dc28d669ede47f4126fb6022b7fc32f"
    sha256 cellar: :any_skip_relocation, ventura:       "096b7e859734eb22008f9ba50bdef3c7af6d13946dc29120d1a80e6164668253"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1404ff088169918cbce84bb1cf9944177b453ffffc1c3eebdf9022e68ba5f0c8"
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
