class MolecfitThirdParty < Formula
  desc "MolecfitThirdParty"
  homepage "https://www.eso.org"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/molecfit_third_party/molecfit_third_party-1.9.3.tar"
  sha256 "2786e34accf63385932bad66c39deab8c8faf4c9095a23173146a9820f4f0183"
  license "GPL-2.0-or-later"

  depends_on "gcc" => :build
  depends_on "pkgconf" => :build

  uses_from_macos "curl"
  uses_from_macos "zlib"

  def install
    ENV.deparallelize
    system "make", "-f", "BuildThirdParty.mk",
                   "CC=#{Formula["gcc"].bin}/gcc-14",
                   "FC=#{Formula["gcc"].bin}/gfortran-14",
                   "lnfl_target=customOsxGNUsgl",
                   "lblrtm_target=customOsxGNUsgl",
                   "prefix=#{prefix}", "install"
  end

  test do
    system "true"
  end
end