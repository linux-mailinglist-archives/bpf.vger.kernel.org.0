Return-Path: <bpf+bounces-61716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E651AEACB1
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 04:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37484E31F8
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 02:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AB918FC86;
	Fri, 27 Jun 2025 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dxXwD8rY"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E58D1362;
	Fri, 27 Jun 2025 02:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750990336; cv=none; b=Mz3Tf8Zpm8MHWvQJQICWq0wu08TeATtK6R3xG4aa17pM4WqdQDdxkq+X+6hoL0JBHKkYoPEV9iywSQGNt+VXZ4+JAdkRsAkeym2h8CvNiejc2bUADb2aQppuegTvFpcu3207sI888u9WQss4KJMqCBtBXN/klLHKsAHx1nPEVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750990336; c=relaxed/simple;
	bh=hQlu0hKYxkCpICQhY9mfNGhQS4yGwClVDCpzW8NSc+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BhmVavaCUpqkthHgYspbQ3vW3MkkZZ1fUmwertuF4iMrBC2DRRxupnvjOVc4o/RRO2iipRdkP4v6mwUxP14kOMNmLA5dQZrVRI5h7+W9gPyo8G482yf4LEqnSoMxKrPOF+r/EWsvEBMWxfrRG8TcArV+D2EGguG/9YMT9qa2edA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=dxXwD8rY; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1750990330;
	bh=JanwckLnl59YfMksurgqNb9FK7UN+BG+oDbEDAn1wKU=;
	h=Date:From:To:Cc:Subject:From;
	b=dxXwD8rY2Du5OuYjK0Qlk8RWAdXAXcnfjVfy3kXf9hMOz1mP6jqAXYcokxDjnYK8T
	 lXsNwQfQy1Q5O7WQsfp7eEE3tkjmej1M1gRoYhCqyZZ945qbz09cIUPtUJcF89Ye47
	 mZxDyllCY/yRBZosbwGzv3KZj2Jm7MSelvL2DN/lh4D8dVpCh5Iq5aGzzPGJWYQTzT
	 i2bx6EoXFQNk1KrsCqaoIVfdARsAwdaF8wnb/4eZ/53lWRVGnuxvT+5Bdku5U5xsyf
	 3fyCxsma1b6F6oaI9kTs5KTvkfsNNjVGBf0D+V6BNWqYCPD1JBHlglzD9X2DP5y6I7
	 xVoAGzsmmSCfA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bSzZy0y0qz4x5d;
	Fri, 27 Jun 2025 12:12:09 +1000 (AEST)
Date: Fri, 27 Jun 2025 12:12:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Song Liu <song@kernel.org>, Viktor Malik
 <vmalik@redhat.com>
Subject: linux-next: manual merge of the bpf-next tree with the vfs-brauner
 tree
Message-ID: <20250627121206.31048e14@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Rld/0tADYcuiMbL4Bid75+J";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Rld/0tADYcuiMbL4Bid75+J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/helpers.c

between commit:

  535b070f4a80 ("bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgro=
up's node")

from the vfs-brauner tree and commit:

  e91370550f1f ("bpf: Add kfuncs for read-only string operations")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/bpf/helpers.c
index 9ff1b4090289,2cdcf7b2c91e..000000000000
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@@ -3397,9 -3768,17 +3768,20 @@@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_next
  BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABL=
E)
  #endif
  BTF_ID_FLAGS(func, __bpf_trap)
 +#ifdef CONFIG_CGROUPS
 +BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 +#endif
+ BTF_ID_FLAGS(func, bpf_strcmp);
+ BTF_ID_FLAGS(func, bpf_strchr);
+ BTF_ID_FLAGS(func, bpf_strchrnul);
+ BTF_ID_FLAGS(func, bpf_strnchr);
+ BTF_ID_FLAGS(func, bpf_strrchr);
+ BTF_ID_FLAGS(func, bpf_strlen);
+ BTF_ID_FLAGS(func, bpf_strnlen);
+ BTF_ID_FLAGS(func, bpf_strspn);
+ BTF_ID_FLAGS(func, bpf_strcspn);
+ BTF_ID_FLAGS(func, bpf_strstr);
+ BTF_ID_FLAGS(func, bpf_strnstr);
  BTF_KFUNCS_END(common_btf_ids)
 =20
  static const struct btf_kfunc_id_set common_kfunc_set =3D {

--Sig_/Rld/0tADYcuiMbL4Bid75+J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmhd/fYACgkQAVBC80lX
0GwBCgf/aPkb0txzfUNKMwN29bEfJFOG4O+Hd9hEM6tpdjmwyixgd1hcU4ard63p
khauQj4rTvkDFTJnFT5+mCW43ILGJLmDxjW+WJiWWe55FUhvKnq8KoDIxy8zFx7n
O0iRHO1GA2D/uwG5KtukysWT5CIkU71rGABvHtU9Si9FFTyrWGdjchLbGWePmnRZ
YEXt/y+pySPLOyViB84IjBir9Zf470FldkfYCPuWE/z7RxNkabxyLuMBkc6ix557
Q9XEzxvT/SbnSN0jxtAcTTbBRTwgu7bIEDyV9y91cyM3xpPhDY8FcQXrLUcSun5S
X3FPwVpzN+bcVdkynJVQvobJqgwLSQ==
=PORs
-----END PGP SIGNATURE-----

--Sig_/Rld/0tADYcuiMbL4Bid75+J--

