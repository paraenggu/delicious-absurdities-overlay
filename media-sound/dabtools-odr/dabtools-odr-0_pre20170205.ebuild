# Copyright 2017 Christian Affolter <c.affolter@purplehaze.ch>
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="DAB/DAB+ software for RTL-SDR dongles and the Psion Wavefinder"
HOMEPAGE="https://github.com/Opendigitalradio/dabtools"

EGIT_REPO_URI="https://github.com/Opendigitalradio/dabtools.git"
EGIT_COMMIT="67123c5b164412915ab9c00f890bcd4826e55bfc"

LICENSE="GPL-3+"
SLOT=0
KEYWORDS="amd64"
IUSE=""

DEPEND="sci-libs/fftw:3.0
		net-wireless/rtl-sdr"

RDEPEND="${DEPEND}"
