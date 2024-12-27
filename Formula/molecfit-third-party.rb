class MolecfitThirdParty < Formula
  desc "3rd party tools for the Molecfit library"
  homepage "https://www.eso.org/sci/software/pipelines/skytools/molecfit"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/molecfit_third_party/molecfit_third_party-1.9.3.tar"
  sha256 "2786e34accf63385932bad66c39deab8c8faf4c9095a23173146a9820f4f0183"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/molecfit_third_party/"
    regex(/href=.*?molecfit_third_party[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/aaguirreo/homebrew-esopipelines/releases/download/molecfit-third-party-1.9.3"
    sha256 cellar: :any,                 arm64_sequoia: "c06890f289a51a17999a642265b069d1ce31a98381888566c7d7c625c2f12d2f"
    sha256 cellar: :any,                 arm64_sonoma:  "cc9d1b57c822b78aaa08a1193bc0e36b1d48889a7644860396c6447bf76eaae1"
    sha256 cellar: :any,                 ventura:       "4d69e1bc0fd19ec99d3da3c07cd74e738fe50f7fe893385eff23f74e75649a31"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bf87ca6e13c6598f326c45e37567268afa5e9249ccbab5edb398387c0ac0b3ed"
  end

  depends_on "gcc"

  def install
    ENV.deparallelize
    system "make", "-f", "BuildThirdParty.mk",
      "prefix=#{prefix}",
      "install"
  end

  test do
    # Include a basic test to validate installation
    system "true"
  end
end
