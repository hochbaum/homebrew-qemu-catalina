class QemuSystemX8664 < Formula
    desc "x86 and PowerPC Emulator"
    homepage "https://www.qemu.org/"
    url "https://download.qemu.org/qemu-4.2.0.tar.xz"
    sha256 "d3481d4108ce211a053ef15be69af1bdd9dde1510fda80d92be0f6c3e98768f0"
    head "https://git.qemu.org/git/qemu.git"

    bottle do
        sha256 "738f6075543fc5868177dcc5567ea1ce29feaedc711233e829dded7a546a2abc" => :catalina
    end
    
    depends_on "libtool" => :build
    depends_on "pkg-config" => :build
    depends_on "glib"
    depends_on "gnutls"
    depends_on "jpeg"
    depends_on "libpng"
    depends_on "libssh"
    depends_on "libusb"
    depends_on "lzo"
    depends_on "ncurses"
    depends_on "pixman"
    depends_on "vde"
    depends_on "sdl2"
    depends_on "sdl2_image"

    # 820KB floppy disk image file of FreeDOS 1.2, used to test QEMU
    resource "test-image" do
        url "https://dl.bintray.com/homebrew/mirror/FD12FLOPPY.zip"
        sha256 "81237c7b42dc0ffc8b32a2f5734e3480a3f9a470c50c14a9c4576a2561a35807"
    end

    def install
        ENV["LIBTOOL"] = "glibtool"
    
        args = %W[
          --prefix=#{prefix}
          --cc=#{ENV.cc}
          --host-cc=#{ENV.cc}
          --disable-bsd-user
          --disable-guest-agent
          --disable-cocoa
          --enable-curses
          --enable-libssh
          --enable-vde
          --enable-sdl
          --enable-sdl-image
          --extra-cflags=-DNCURSES_WIDECHAR=1
          --target-list=x86_64-softmmu
        ]
        # Sharing Samba directories in QEMU requires the samba.org smbd which is
        # incompatible with the macOS-provided version. This will lead to
        # silent runtime failures, so we set it to a Homebrew path in order to
        # obtain sensible runtime errors. This will also be compatible with
        # Samba installations from external taps.
        args << "--smbd=#{HOMEBREW_PREFIX}/sbin/samba-dot-org-smbd"
    
        system "./configure", *args
        system "make", "V=1", "install"
      end
end