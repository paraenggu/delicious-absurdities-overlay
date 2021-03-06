# Copyright 2017-2020 Christian Affolter <c.affolter@purplehaze.ch>
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="DAB/DAB+ receiver for Linux (including ETI-NI and EDI AF playback)"
HOMEPAGE="https://github.com/Opendigitalradio/dablin"
SRC_URI="https://github.com/Opendigitalradio/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT=0
KEYWORDS="amd64"
IUSE="fdk gtk +sdl"

DEPEND="fdk? ( || ( media-libs/fdk-aac media-libs/fdk-aac-dabplus-odr ) )
		!fdk? ( media-libs/faad2 )
		gtk? ( dev-cpp/gtkmm:3.0 )
		sdl? ( media-libs/libsdl2 )
		>=media-sound/mpg123-1.14.0"

RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DUSE_FDK-AAC="$(usex fdk)"
		-DUSE_SDL="$(usex sdl)"
	)

	cmake-utils_src_configure
}
