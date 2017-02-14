# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 cmake-utils
EGIT_REPO_URI="https://github.com/Opendigitalradio/ka9q-fec.git"

DESCRIPTION="Opendigitalradio's fork of KA9Q's FEC library"
HOMEPAGE="https://github.com/Opendigitalradio/ka9q-fec"
SRC_URI=""

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	# Reorder project languages to pass the ASM compiler test.
	# Otherwise cmake complains with the following error message
	# The CMAKE_ASM_COMPILER:
	# <COMPILER>
	# is not a full path and was not found in the PATH.
	sed -i -e 's/^project(libfec ASM C)/project(libfec C ASM)/' \
		CMakeLists.txt

	eapply_user
}
