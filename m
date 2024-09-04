Return-Path: <bpf+bounces-38857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A268E96AE30
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 04:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A8E1F227AF
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 02:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8527618E1A;
	Wed,  4 Sep 2024 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mVzkO+nE"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6699D529;
	Wed,  4 Sep 2024 02:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415347; cv=none; b=mK6HzH5F9an4yCZKDj7VGemdgH5KQuz3aR8f+5WVqfv1hxRpqYeThS3uQ7k29D/PENyc6yu/St1hgT7WH1Ctc95/8tC/FKUDci6T8IBFXR8amIE/9J5CY7agYKVolXKvPWm5q309QfJ2X1yAnrh38fnUYGGRSF0EttTGUFMyHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415347; c=relaxed/simple;
	bh=B28oxwYLmJ4+vU0YbnjwVo6lSTp4OAB5sdR/64EZ3RY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=l/rOpp+fkDBI6UNOu9vHy8e8MmcKK5dT2gr2ldQhBSHIuSaBcT+6oihUfGS4aRtYRhYdARCJHeLcu3yr6lo7tYP3ClfP9EoQWRp65HLklCfzDuQkRUpmCgMRNGG4ij+XHaqmfyYqdi+82A4jk3YCtPdAvXJj+B0yohvNQ6CFSBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=mVzkO+nE; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1725415343;
	bh=vv/ANfe5ReI4atsmhoigATXPp5eYYn2euiExp9SZns0=;
	h=Date:From:To:Cc:Subject:From;
	b=mVzkO+nEsVJcWO1MJq6xFyTgcqhCc8MboIbqzn0htVZvXgnSe7rMYdaN/SpEqYe4H
	 UWJeh9YY1wubx3vuOyQt+wn4drfDzpX/2PlRZLUJIyUk60TsEexX5YbzUAWJMa1ing
	 +ngTqbwqzBVQM3y++cN6Mx1Vbcif/U4eQGgeVed8xO7nsVwMkconbkxPUQDU+0OveT
	 2yhWvWbwZ7aamznOhP0UO653PLdtT07htmV/zvHOs1gpNr4AUxLMHS432AOfRmxToT
	 9gBDr63KdlwV7N5D0kmIsnEftEu0mvJOU7KW5kAD5/at3By9Ka0GlhhKQMl0ueIzvy
	 DZVsc+4tFWFOA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wz5NG2v6xz4wnt;
	Wed,  4 Sep 2024 12:02:22 +1000 (AEST)
Date: Wed, 4 Sep 2024 12:02:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the net-next
 tree
Message-ID: <20240904120221.54e6cfcb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ymGS12FCuyBKBHULoaPTR+s";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ymGS12FCuyBKBHULoaPTR+s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  drivers/net/netkit.c

between commit:

  00d066a4d4ed ("netdev_features: convert NETIF_F_LLTX to dev->lltx")

from the net-next tree and commit:

  d96608794889 ("netkit: Disable netpoll support")

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

diff --cc drivers/net/netkit.c
index 79232f5cc088,0681cf86284d..000000000000
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@@ -255,7 -255,7 +255,8 @@@ static void netkit_setup(struct net_dev
  	dev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE;
  	dev->priv_flags |=3D IFF_PHONY_HEADROOM;
  	dev->priv_flags |=3D IFF_NO_QUEUE;
 +	dev->lltx =3D true;
+ 	dev->priv_flags |=3D IFF_DISABLE_NETPOLL;
 =20
  	dev->ethtool_ops =3D &netkit_ethtool_ops;
  	dev->netdev_ops  =3D &netkit_netdev_ops;

--Sig_/ymGS12FCuyBKBHULoaPTR+s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbXv60ACgkQAVBC80lX
0Gzw1QgAoAFlve1pnH2uAHlsjPUgltj4nXeJuQqELB77BPM6kUjTJkryOsLnm8Np
mvTwdUfa2yjZOPcLWU3Hw/soitYW87J7B3u1K6cRb0LHG52s6A59mQGLJY2egh9t
I2jCgnsiG1GTOUbKRJQHn8QSm5iQ8pk1tg1/075cE9cQDf8TZZjN8472seVrSVI9
JjUla3MlqQB+Q/zf2kR3KjlhHmpDouMcLXsYUxKCibBzcgs132wZu0cK2NbT6p2i
JNhNrgcznITr0X58of4Nxb7oeKtf58tyilDDAKYcP94kRHp5UCu2QcAEpgUNVUno
Z8O1n//E/Pt4wg4Ss9jXO7Yfcaxihw==
=0BeO
-----END PGP SIGNATURE-----

--Sig_/ymGS12FCuyBKBHULoaPTR+s--

