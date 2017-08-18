# Copyright 2017 Christian Affolter <c.affolter@purplehaze.ch>
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="DAB/DAB+ receiver for Linux (including ETI-NI playback)"
HOMEPAGE="https://github.com/Opendigitalradio/dablin"
SRC_URI="https://github.com/Opendigitalradio/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT=0
KEYWORDS="amd64"
IUSE="fdk gtk +sdl"

DEPEND="fdk? ( || ( media-libs/fdk-aac media-sound/fdk-aac-dabplus ) )
		!fdk? ( media-libs/faad2 )
		gtk? ( dev-cpp/gtkmm:3.0 )
		sdl? ( media-libs/libsdl2 )
		>=media-sound/mpg123-1.14.0"

RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_use fdk FDK-AAC)
		$(cmake-utils_use_disable sdl SDL)
	)

	cmake-utils_src_configure
}
