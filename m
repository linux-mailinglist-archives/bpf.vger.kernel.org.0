Return-Path: <bpf+bounces-16958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5F3807D9A
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 02:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862C51C20B80
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 01:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AC5EA6;
	Thu,  7 Dec 2023 01:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lb0l514G"
X-Original-To: bpf@vger.kernel.org
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A8512F;
	Wed,  6 Dec 2023 17:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1701911315;
	bh=phe4O51H7/V3YS47hEgMUqHs3d968ZCnQlFDHma9U1Y=;
	h=Date:From:To:Cc:Subject:From;
	b=lb0l514GhPPpUFUIO2g5tSXP3nYjAIvM8WKSPJQ/fjLwmG9cLD0f+iEhGrvlvx+yF
	 obQMBK4np8Rh7BumQsBoT/OkM9nuxFo+AvlN6JnEzVeXENefpZnUBxf6ob9iq1K7gs
	 KCITTzuDDMHnv0pDEnocyCdfnAHhz0RGuNJoP48tHKFr57T+tyxcvgxW5S38iGriMJ
	 Xxh/X2WJYdWZ4EcpHN97ubJgevzcjSGmI9KU/c5QvAIHcAEvPHxFEC7tv6H2wXKJMv
	 7Kk893gKFzyCMtQczY/Ah+tf8w3H5aLUBuiGcEMlE6Mi5x7mZii9/N2s881S4wQNGG
	 QTFrxiy1MdkZA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Slx3k4BP6z4wc3;
	Thu,  7 Dec 2023 12:08:34 +1100 (AEDT)
Date: Thu, 7 Dec 2023 12:08:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Moore <paul@paul-moore.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Casey
 Schaufler <casey@schaufler-ca.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the security tree with the bpf-next
 tree
Message-ID: <20231207120833.46ebfc2d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XLz+L06gsoqiomsd0nyAVro";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/XLz+L06gsoqiomsd0nyAVro
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the security tree got a conflict in:

  include/linux/security.h

between commit:

  d734ca7b33db ("bpf,lsm: add BPF token LSM hooks")

from the bpf-next tree and commit:

  e1ca7129db2c ("LSM: Helpers for attribute names and filling lsm_ctx")

from the security tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/security.h
index 00809d2d5c38,750130a7b9dd..000000000000
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@@ -32,7 -32,7 +32,8 @@@
  #include <linux/string.h>
  #include <linux/mm.h>
  #include <linux/sockptr.h>
 +#include <linux/bpf.h>
+ #include <uapi/linux/lsm.h>
 =20
  struct linux_binprm;
  struct cred;

--Sig_/XLz+L06gsoqiomsd0nyAVro
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVxGxEACgkQAVBC80lX
0Gy4Vgf+O274EwUxOtVS9S2Y1V4GBLB4rb1nfBXkGFaZcVFEb0Me3AaxcaEzpg8d
Kt4r6LSKFPfCR3vLi372ixaQSUJSYthQL8hoUNVDuCo1dVq7I2pFHfH/C/BsSFut
xww4WgQOAp2iWekkU7/5XjPQLgqDGTd1fB+4fiNTW/2rOluhVOeOsqrf+pfymLHD
7kwej6pieq63GjksZD2462AGiYkwiS7vedj2smlvYBACVCB5sZ+L1NCWMZE6nKtc
FG1/UsFpuIBvmaEGz8QlW20AFMB85SqxOnXSG/qvmfi5jINU3y32I6WEBGuGN0xT
BgO0o1aotXB2X/z9yezZPGO329pBqA==
=dqeK
-----END PGP SIGNATURE-----

--Sig_/XLz+L06gsoqiomsd0nyAVro--

