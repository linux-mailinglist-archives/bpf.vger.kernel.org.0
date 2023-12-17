Return-Path: <bpf+bounces-18140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E263981636C
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 00:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B10282339
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 23:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9F64B126;
	Sun, 17 Dec 2023 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="D6CYSRvS"
X-Original-To: bpf@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC648CC7;
	Sun, 17 Dec 2023 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702855845;
	bh=YB2dFiDcE/7I5Sv39W5ZIfPPERRMneL2j2F4B0Hk8fs=;
	h=Date:From:To:Cc:Subject:From;
	b=D6CYSRvSHmCuTCzrOxKRLDwhDShCVdr4y6K1hazxFFQyHEXQaFxMJZbZSjJ4xAp2Y
	 TnEF4IuVe+KDI6oNvZ4R85EET12qk1g08brpk7MdXtnvvYlgqSmuHopcKNMtzPwVZB
	 jTwE/ZVSvfGC3PtktmlJ7lx9iidpWMqkksnvwrs97WqoCkl2OVFJymZLTosYzOLD2z
	 Mgc2g88W3VJ7xlloTsAFhx71unsg2mlMU2R7YQGgeR+ooG6depVbjO65UGiOiNSN5e
	 hEkv8bVj6AiXt27gRsRqbj3iFBYRibTNL7cGqRfHLu0sK6Dvm7EFeztOFJojR8WPI7
	 t9M6HcAA5ryAA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4StfMm4V21z4x5q;
	Mon, 18 Dec 2023 10:30:44 +1100 (AEDT)
Date: Mon, 18 Dec 2023 10:29:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
 Aleksander Lobakin <aleksander.lobakin@intel.com>, Larysa Zaremba
 <larysa.zaremba@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: linux-next: manual merge of the bpf-next tree with the net-next
 tree
Message-ID: <20231218102952.2428bd06@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cDv_OgwexhiKmz_AYOhw3a5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/cDv_OgwexhiKmz_AYOhw3a5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  include/linux/skbuff.h

between commit:

  bf873a800ac3 ("net: skbuff: fix spelling errors")

from the net-next tree and commit:

  2ebe81c81435 ("net, xdp: Allow metadata > 32")

from the bpf-next tree.

I fixed it up (the latter removed a line that was updated by the former,
so I just removed it) and can carry the fix as necessary. This is now
fixed as far as linux-next is concerned, but any non trivial conflicts
should be mentioned to your upstream maintainer when your tree is
submitted for merging.  You may also want to consider cooperating with
the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/cDv_OgwexhiKmz_AYOhw3a5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV/hHAACgkQAVBC80lX
0GzFlwf+Kpf/rnj71gHs66yQd/EoHmcA/wPjDai4NGfF2YrGTXDCcwZaL2gEoCtk
I/QBDSVDAIddfwkGz1+UFQdl+saaBHcOHAyy8vxebve/6VLV2DveU+4nq7uz7sB4
C++FPLqkQQgsUb/+WdZ0LZsZyNGjWBpSFiOV78pCBmJ12VPZu813MBfx0rp8JhMj
d+Ri+BGECNJqDbyyZUcNj0SF2wlAzf8bk42KX6dGHrKvnuu7ncyslAqyepgKFLAh
/q2Xc7gqPbPddp3cqqLuPoyiCxIVK10CJF+DZUIF0421QrPfjwizb+SPwmuzHaR8
nLBkWO+Brrff0rLs8RlmZCu1F0tXZQ==
=h0WP
-----END PGP SIGNATURE-----

--Sig_/cDv_OgwexhiKmz_AYOhw3a5--

