# Copyright 2017 Christian Affolter <c.affolter@purplehaze.ch>
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools systemd user

MY_PN="ODR-AudioEnc"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="DAB and DAB+ audio encoder"
HOMEPAGE="https://github.com/Opendigitalradio/ODR-AudioEnc"
SRC_URI="https://github.com/Opendigitalradio/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64"
IUSE="alsa jack static-libs vlc"

RDEPEND="alsa? ( media-libs/alsa-lib )
		jack? ( virtual/jack )
		media-libs/fdk-aac-dabplus-odr
		>=net-libs/zeromq-4.0.4
		vlc? ( media-video/vlc )"
DEPEND="${RDEPEND}
		app-admin/chrpath"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable alsa ) \
		$(use_enable jack ) \
		$(use_enable static-libs static) \
		$(use_enable vlc )
}

src_install() {
	default

	# Remove Rpath to get rid of hardcoded library paths
	# and pass the QA check:
	# QA Notice: The following files contain insecure RUNPATHs
	#
	# Unfortunately, passing --disable-rpath to configure is not supported,
	# that's why chrpath is used. This should be fixed within the buildsystem
	# someday.
	chrpath --delete "${D}/usr/bin/odr-audioenc"
	systemd_dounit "${FILESDIR}/${PN}@.service"
}

pkg_postinst() {
	enewgroup odr
	enewuser odr -1 -1 -1 "odr,audio"

	elog "There is a systemd service template unit provided for systemd users"
	elog "It uses an ALSA input and outputs ZMQ to localhost by default."
	elog "Use 'systemctl start ${PN}@default.service' to start the service"
	elog ""
	elog "All the ${PN} command arguments can be overridden via the systemd"
	elog "service Environment=\"AUDIOENC_*\" options."
	elog "See 'systemctl cat ${PN}@default.service' for available parameters."
	elog "Use 'systemctl edit ${PN}@default.service' to override parameters."
	elog ""
	elog "To start a different ${PN} instances:"
	elog "Use 'systemctl start ${PN}@<INSTANCE>.service' to start an instance."
	elog "Use 'systemctl edit ${PN}@<INSTANCE>.service' to override."
}
