# Copyright 2017 - 2018 Christian Affolter <c.affolter@purplehaze.ch>
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

EGIT_REPO_URI="https://github.com/Opendigitalradio/fdk-aac.git"
EGIT_COMMIT="3eab23670d4d9fb2a8ee01c1be7b4acfc14c1552"

DESCRIPTION="Opendigitalradio's fork of the Fraunhofer FDK AAC code from Android"
HOMEPAGE="https://github.com/Opendigitalradio/fdk-aac"
SRC_URI=""

LICENSE="FraunhoferFDK"
SLOT="0"
KEYWORDS="amd64"
IUSE="static-libs"

DEPEND=""
RDEPEND="!media-libs/fdk-aac"

DOCS="ChangeLog README.md documentation/*.pdf"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	# Uses pkg-config .pc file
	find "${D}" -name '*.la' -delete || die
}
