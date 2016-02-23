# Copyright 2016 Christian Affolter <c.affolter@purplehaze.ch>
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PN="OpenOB"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Open Audio over IP for Broadcasters"
HOMEPAGE="https://jamesharrison.github.io/openob/ https://github.com/JamesHarrison/openob"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-minimal"

RDEPEND="=dev-python/gst-python-0.10*[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/redis-py[${PYTHON_USEDEP}]
	!minimal? ( dev-db/redis )
	=media-libs/gst-plugins-bad-0.10*
	=media-libs/gst-plugins-base-0.10*
	=media-libs/gst-plugins-good-0.10*
	=media-plugins/gst-plugins-opus-0.10*
	=media-libs/gst-plugins-ugly-0.10*
	=media-plugins/gst-plugins-ffmpeg-0.10*
	virtual/ffmpeg[opus]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}"/${MY_P}
