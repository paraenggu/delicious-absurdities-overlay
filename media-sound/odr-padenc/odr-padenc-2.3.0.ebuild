# Copyright 2017 - 2018 Christian Affolter <c.affolter@purplehaze.ch>
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools systemd user

MY_PN="ODR-PadEnc"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Opendigitalradio Programme Associated Data (PAD) encoder"
HOMEPAGE="https://github.com/Opendigitalradio/ODR-PadEnc"
SRC_URI="https://github.com/Opendigitalradio/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64"
IUSE="imagemagick"

DEPEND="imagemagick? ( media-gfx/imagemagick )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	default
	eautoreconf
}

# Note, that it is not possible to actually enable or disable the magickwand
# support via configure. So the following src_configure() snippet can't be
# used.
#src_configure() {
#	econf $(use_enable imagemagick magickwand )
#}

src_install() {
	default

	systemd_dounit "${FILESDIR}/${PN}@.service"
	systemd_dotmpfilesd "${FILESDIR}/${PN}.conf"
}

pkg_postinst() {
	enewgroup odr
	enewuser odr-padenc -1 -1 -1 "odr"

	elog "There is a systemd service unit template provided for systemd users"
	elog "It creates the necessary directory structure and the FIFOs."
	elog ""
	elog "Use 'systemctl start ${PN}@default.service' to start the service"
	elog ""
	elog "DLS texts will be read from the following input file:"
	elog "/var/tmp/odr/padenc/default/texts/dls-01.txt"
	elog ""
	elog "Put your MOT slides into the following input directory:"
	elog "/var/tmp/odr/padenc/default/slides"
	elog ""
	elog "You can then point odr-audioenc to the following output FIFO:"
	elog "/var/tmp/odr/padenc/default/pad.fifo"
	elog ""
	elog "To start a different ${PN} instances:"
	elog "'systemctl start ${PN}@<INSTANCE>.service'"
}
