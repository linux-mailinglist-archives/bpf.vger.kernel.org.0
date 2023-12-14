Return-Path: <bpf+bounces-17901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A37E813E70
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2681283D2F
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 23:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E882DB70;
	Thu, 14 Dec 2023 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XYU7jVEx"
X-Original-To: bpf@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821712DB63;
	Thu, 14 Dec 2023 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702598212;
	bh=kdaqb+qL+sKQKweMgh3BTaVI6c3ywDEdnrXH5XQmY9Q=;
	h=Date:From:To:Cc:Subject:From;
	b=XYU7jVExQdM6oeWGiq1bI3oV+raixNUkyDKqnsD+dkXsy2Wrv3DLPyx9dB/fu1zp5
	 vbUqs22wcBs/ewf0Yd0g2cfrVa2P4l230BGzp69VDHNQZv8ycQi7GJ12vC4sSK9SMi
	 RQAMmZqVpk+laso5ybeWpSjM48pCAF8chq/1hzapRXFE6uYUyzH4oKQlaNBqcxi2eg
	 Cs0HylxUAQH63/BPVjxEddEiW3bXsQNUZNIrwIo46AJ7q14BE4Kq/7BCu98YvzJYT/
	 b2M7sWJb0VHUBdNrbSaLQF5RydEyAKlUFAtvZhUVxH2RrdAMyMCS6noB2gzJQqFlwy
	 OKzuybFZz73+A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Srq5J0W8jz4wcJ;
	Fri, 15 Dec 2023 10:56:51 +1100 (AEDT)
Date: Fri, 15 Dec 2023 10:56:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Larysa
 Zaremba <larysa.zaremba@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the net-next
 tree
Message-ID: <20231215105650.5eb8d2a4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CLPTXkepDjGLf88u5G7zcrp";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/CLPTXkepDjGLf88u5G7zcrp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/net/ynl/generated/netdev-user.c

between commit:

  f7c0e362a25f ("tools: ynl: remove generated user space code from git")

from the net-next tree and commit:

  e6795330f88b ("xdp: Add VLAN tag hint")

from the bpf-next tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/CLPTXkepDjGLf88u5G7zcrp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV7lkIACgkQAVBC80lX
0Gyv/QgAmdgxoieVX+RuS74JGn0oucUyO+YZNdN1+Q/Wx0quGXyfCus34AZzy8Wc
/ng370Ky6puQEAPtv7p4ZdocU4kK7rBWyyqYzgDz6JcQ2rWaOXng4ClQ0cS1S8KU
aOSTUcVnDWqCtoX04qw8qOGbKnD69T97Bc2UnBjrLpDrNdimXmBTQKbUjj9P6YuU
hYDlCTK7KCwP+ZgpBKRZNLHBq62hjpTq1kh41+WCJmTPMt2NxXcYeeJlFi5y4ZSg
CbZdaL5caMrU5UZ1qYDcP+KhhuUjIfWW/h1vD9rtE29EeJChd3Rt8hsrhftdIzkO
M5qzya5888mLzxyOhw3ZABGcCHxFtQ==
=QuYy
-----END PGP SIGNATURE-----

--Sig_/CLPTXkepDjGLf88u5G7zcrp--

