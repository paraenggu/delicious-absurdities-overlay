# Copyright 1999-2017 Christian Affolter <c.affolter@purplehaze.ch>
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="BS1770GAIN is a loudness scanner implementing ITU-R BS.1770."
HOMEPAGE="http://bs1770gain.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="media-sound/sox
		virtual/ffmpeg
		"
RDEPEND="${DEPEND}"
