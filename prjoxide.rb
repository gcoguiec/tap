class Prjoxide < Formula
  desc 'A project to document the Lattice Nexus (28nm) devices bitstream and internal architecture'
  homepage 'https://github.com/gatecat/prjoxide'
  version '20220926'
  license 'ISC Licence'
  url 'https://github.com/gatecat/prjoxide/archive/ea89720449915ab73afdb6f1f2f48939dae6a9e7.tar.gz'
  sha256 '0056106fe251ad9cbbb43897f2a20082860173bd8221aa9acf1dbe4b3929b7a8'
  head 'https://github.com/gatecat/prjoxide.git'

  depends_on 'rust' => :build

  resource 'prjoxide-db' do
    url 'https://github.com/gatecat/prjoxide-db/archive/56009be1ca77a7123ffdb50a813216302a42ac27.tar.gz'
    sha256 '164f7c3b93f778465b5a72ece445a1f9fc7af3a6fd303b7090b9540fb803f9c6'
  end unless build.head?

  resource 'prjoxide-db' do
    url 'https://github.com/gatecat/prjoxide-db/archive/refs/heads/master.tar.gz'
  end if build.head?

  def install
    (buildpath/'database').install resource('prjoxide-db')

    cd 'libprjoxide/prjoxide' do
      system 'cargo', 'install', *std_cargo_args
    end
  end

  test do
    system "#{bin}/prjoxide", '-h'
  end
end
