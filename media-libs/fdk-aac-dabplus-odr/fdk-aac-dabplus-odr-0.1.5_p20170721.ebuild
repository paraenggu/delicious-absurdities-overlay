# Copyright 2017 Christian Affolter <c.affolter@purplehaze.ch>
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

EGIT_REPO_URI="https://github.com/Opendigitalradio/fdk-aac.git"
EGIT_COMMIT="89639e36b29a622c641c3de3a4737a4c848dc365"

DESCRIPTION="Opendigitalradio's fork of the Fraunhofer FDK AAC code from Android"
HOMEPAGE="https://github.com/Opendigitalradio/fdk-aac"
SRC_URI=""

LICENSE="FraunhoferFDK"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="!media-libs/fdk-aac"

DOCS="ChangeLog README.md documentation/*.pdf"

src_prepare() {
	default
	eautoreconf
}
