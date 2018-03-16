# Copyright 2017 - 2018 Christian Affolter <c.affolter@purplehaze.ch>
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools systemd user

MY_PN="ODR-DabMux"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="ODR-DabMux is a DAB (Digital Audio Broadcasting) multiplexer"
HOMEPAGE="https://github.com/Opendigitalradio/ODR-DabMux"
SRC_URI="https://github.com/Opendigitalradio/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64"
IUSE="curl"

DEPEND=">=dev-util/boost-build-1.48.0
		>=net-libs/zeromq-4.0.0
		curl? ( net-misc/curl )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default

	dodir "/etc/${PN}"
	dodoc doc/*.mux doc/*.txt
	doman doc/DabMux.1

	systemd_dounit "${FILESDIR}/${PN}.service"
}

pkg_postinst() {
	enewgroup odr-dabmux
	enewuser odr-dabmux -1 -1 -1 odr-dabmux

	elog "There is a systemd service unit provided for systemd users."
	elog "To use it, you will have to create a valid configuration first:"
	elog "bzcat /usr/share/doc/${P}/example.mux.bz2 > /etc/${PN}/dab.mux"
	elog "\$EDITOR /etc/${PN}/dab.mux"
	elog "systemctl start ${PN}"
}
