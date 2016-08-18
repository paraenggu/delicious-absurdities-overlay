# Copyright 2016 Christian Affolter <c.affolter@purplehaze.ch>
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools autotools-utils

DESCRIPTION="DAB and DAB+ encoder"
HOMEPAGE="https://github.com/Opendigitalradio/fdk-aac-dabplus"
SRC_URI="https://github.com/Opendigitalradio/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0 FraunhoferFDK LGPL-2.1+ GPL-3+"
SLOT="0"
KEYWORDS="amd64"
IUSE="alsa imagemagick jack vlc"

DEPEND="alsa? ( media-libs/alsa-lib )
		imagemagick? ( media-gfx/imagemagick )
		jack? ( media-sound/jack-audio-connection-kit )
		media-sound/odr-libfec
		>=net-libs/zeromq-4.0.4
		vlc? ( media-video/vlc )"

RDEPEND="${DEPEND}"

src_prepare() {
	# Replace the relative path of -Icontrib with an absolute one,
	# otherwise lib_crc.h can't be found (lib_crc.h: No such file or directory)
	sed -i -e 's%\( \+\)-Icontrib\( \+\|$\)%\1-I$(top_srcdir)/contrib\2%' \
		Makefile.am || die "Couldn't sed Makefile.am"

	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_enable alsa)
		$(use_enable jack)
		$(use_enable vlc)
	)
	autotools-utils_src_configure
}
