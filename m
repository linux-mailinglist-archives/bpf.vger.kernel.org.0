Return-Path: <bpf+bounces-32042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9F990631D
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 06:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29600283D5D
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 04:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEDE134409;
	Thu, 13 Jun 2024 04:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gpq9ev/7"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178F018C05;
	Thu, 13 Jun 2024 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718253768; cv=none; b=Ms+nhGkycYmq+AwQDdWBzd/4k+fvXYhWx4rRlEsyylPF1UhE51fPR+Z/bP+38f7Hq+oKWSlsB2IupjjZYJOSlkL5p+eBnRbKp6jvZgAMNG6oy3Icff0De9+4mZvZQ50+NN4g96j5MWa6GxfdVxSGephPz1wfDsUg87wEVAqjARs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718253768; c=relaxed/simple;
	bh=/EyUgm1yoB7eof62PEx7Ofgi2vQkDZgHLobAhfPNB1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=h2Yzex/qUGId77sOR+Y5+xaPAqX0pwrddlB4Y8fGJCIQh5LUqZmIbPOQIwOve6EZRsEC98/Lb2gVtb6XlsiqztAWKMuYgOMoKxe+/23N43XNbQs6woOKS4BJ6f2K5+7tqRSKtxNc4cSiU8xAAZiZfHncprMt3oUHqJiuPZehhlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=gpq9ev/7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1718253761;
	bh=7qO7EzA9rD1PL86979ZCSCQVHKyHCTng3OZfZscJ9Y4=;
	h=Date:From:To:Cc:Subject:From;
	b=gpq9ev/7DD8yZxEZPb9Y1zybe1cw6vsauwAedsTeMbVPK4yZ5LZTfvvCKi0R6o1M+
	 zg4S0UaCafhXAuho5oC67zhkazQaENIeTO73D5o3mX8QgVp/fcTtYTSfN3p6Qy67yL
	 u5qBdvY5rTLP734VNhtFbA0bofoeAAONoEu3dEdsKLP2vZ9MqFehoVMLJsYn3q/uGL
	 F5a8qjBv2JXWkSM2COZYMKSupoJUnjQHgJ5pDzwZvl+BsMSfKSGaGojCeoLeUSgRDv
	 G5Q1z6GUTiyM1BOnO4h0XYB9vNemhQxj/JyFGOQmdVpnEw/ggsOYnyr6VOb8XVEZzO
	 EpMon1Nf9x6sQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W08sY50KLz4wc3;
	Thu, 13 Jun 2024 14:42:41 +1000 (AEST)
Date: Thu, 13 Jun 2024 14:42:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the bpf-next tree
Message-ID: <20240613144239.29675ebc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DlxQB5IW+Lsmscq1pfX+kNx";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/DlxQB5IW+Lsmscq1pfX+kNx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (htmldocs)
produced these warnings:

kernel/bpf/helpers.c:2464: warning: Excess function parameter 'ptr' descrip=
tion in 'bpf_dynptr_slice'
kernel/bpf/helpers.c:2549: warning: Excess function parameter 'ptr' descrip=
tion in 'bpf_dynptr_slice_rdwr'

Introduced by commit

  cce4c40b9606 ("bpf: treewide: Align kfunc signatures to prog point-of-vie=
w")

--=20
Cheers,
Stephen Rothwell

--Sig_/DlxQB5IW+Lsmscq1pfX+kNx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmZqeL8ACgkQAVBC80lX
0Gzmlgf8CyjBTKA1bjYF5XbhznrXCPisBUHgOTDpcf4VMyGEJlK+BW7cpblDazhL
cUvv9NxH7vGjlTSNmfOfPo4f5RbhvsocZWwaGx0q94AeTusNrpE1zHOPYQUzsxoP
fmCVvrAELV9XQptLemXO6ncpWQRKzBCN7hwVqumF1jt+efnd6b4QBD2tgbczkcOv
5mWwaOYW4Xp0i8OTsLEKBhzAsb7iBd5rtbOnt1/vs5MwK2hq+dzBWt0+xAEpBZ5c
U35aPI498MYx72DjrXE52c79qsJeQRqx9VjKmt/0RGoWZl9M/M+qzChbdNEl5p6D
bfRkJAGXD5j8PevyZepO3GO3bfWh+w==
=WDA9
-----END PGP SIGNATURE-----

--Sig_/DlxQB5IW+Lsmscq1pfX+kNx--

