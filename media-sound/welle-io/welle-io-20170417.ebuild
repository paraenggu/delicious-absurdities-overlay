# Copyright 2017 Christian Affolter <c.affolter@purplehaze.ch>
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="welle.io"
MY_P="${MY_PN}-${PV}"

inherit eutils qmake-utils

DESCRIPTION="A DAB/DAB+ Software Radio"
HOMEPAGE="http://www.welle.io/"
SRC_URI="https://github.com/AlbrechtL/${MY_PN}/archive/V${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-qt/qtcharts:5/5.7[qml]
		dev-qt/qtdeclarative:5/5.7
		dev-qt/qtmultimedia:5/5.7
		dev-qt/qtquickcontrols:5/5.7
		dev-qt/qtquickcontrols2:5/5.7
		net-wireless/rtl-sdr
		sci-libs/fftw:3.0
		virtual/glu
		virtual/libusb:1"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	# Disable (comment) airspy support for now as there is currently no
	# ebuild available (as of 2017-05-16)
	sed -i \
		-e 's|^\([[:space:]]*CONFIG[[:space:]]\++=[[:space:]]\+airspy\)|#\1|' \
		welle.io.pro || die "Couldn't disable airspy support"

	eapply_user
}

src_configure() {
	eqmake5
}

src_install() {
	# Performing a manual installation as "make install" is not implemented.
	dodoc README.md
	newicon icon.png "${PN}.png"
	domenu "${PN}.desktop"
	dobin "${PN}"
}
