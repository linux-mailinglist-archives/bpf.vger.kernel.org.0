Return-Path: <bpf+bounces-39967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B6A979998
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 01:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04B3B22624
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 23:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D66130A47;
	Sun, 15 Sep 2024 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rh/93whM"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A8E17BA7;
	Sun, 15 Sep 2024 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726443729; cv=none; b=PNFwvjl9Ucykp2/9pz1wQGtnDlgNvU6n09p5V4uqtLlEgBtzmRlnt2dOJ0rvFvw/1t6qv/yBtjV063nbiD7jTgvRlw8yCP0kl8jh9y8OX5EY1T+M3irjXDVBt910S4B0YrbgPD+IZ/G91BWn96skjVsZVD93cuTyYt4a7hj2SFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726443729; c=relaxed/simple;
	bh=R0GPPeKHAbFbXFW+ljpOdYlAFUC/6BJEokBZh4E9gB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qw7Ep/I+nkmX3+ba83OeGy76QDwuO/5RDBpcV4yDiYOToyTyoU6sVwnsPVci8g0SXbmEheKzV8nE/t1AsJR4/ThbIRpblCuCk2bAFk+M+pKyhAR8hXj1ceNPZP+zLwsCzO2mWYO0x/EOAQaKgnHu6YcFqHsYOfNPzPrJYf/XiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rh/93whM; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1726443723;
	bh=N62nmdW/mIjLgwLjyQ9RXaf/g2kvV724xrfZkUHciBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rh/93whMBR8iPEyWGJzyBu9wqjXpsq7y3VA4+hODh1AIJrS+Hd5MoNa1QcLFQy0kX
	 7CBe7B2O7nPi3pHGSK8CJ44D7vNczODVnzWFcGCllqHwHceUpz3OkDhw1bhxoRmLce
	 QwBgfRakRnzEfXYl4xykZxDRz9GlucoAZVQ6a8oW09D4VlaPYuBJTq0lZu5ueCn6TR
	 XH4xdt5JG2/TjovRdm8T39h6DS6WX4NX00kQIh5MyvNWnVwOL8IWvHAIMhQw9sSxNt
	 b2+W6U0kxyaK+XUJe25sDKtF1xu/dwkOgQh0alaoglDlruoHAxRMQwSWcAanTOXQO/
	 /QacaJEjSSc0g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X6Phn4Xw7z4x8H;
	Mon, 16 Sep 2024 09:42:01 +1000 (AEST)
Date: Mon, 16 Sep 2024 09:42:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Aleksa Sarai
 <cyphar@cyphar.com>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the
 vfs-brauner tree
Message-ID: <20240916094201.212c3b23@canb.auug.org.au>
In-Reply-To: <20240814105629.0ad9631b@canb.auug.org.au>
References: <20240814105629.0ad9631b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ed2Nn8F8WPVJvnATdGlcyLf";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Ed2Nn8F8WPVJvnATdGlcyLf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 14 Aug 2024 10:56:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>=20
>   fs/coda/inode.c
>=20
> between commit:
>=20
>   626c2be9822d ("coda: use param->file for FSCONFIG_SET_FD")
>=20
> from the vfs-brauner tree and commit:
>=20
>   1da91ea87aef ("introduce fd_file(), convert all accessors to it.")
>=20
> from the bpf-next tree.
>=20
> I fixed it up (the former removed the code modified by the latter, so I
> used the former) and can carry the fix as necessary. This is now fixed
> as far as linux-next is concerned, but any non trivial conflicts should
> be mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.

This is now a conflict between the vfs tree and the vfs-branuer tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Ed2Nn8F8WPVJvnATdGlcyLf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbncMkACgkQAVBC80lX
0GwuvQf/dvsPxheb2d2OlHJSqWC9TwnVGKJmNFVej4FdL3DNp08Ok6+Yj29PsP/2
vnSGMQFxpZVEOSXnlSl5Yhk5UksSc91AWpdO6358xekh2vG2GvltByCc3JdkaCNn
1jIDsvIXEkeRyKIT7XR3yrLvwe+yOsIcY7Q36/jjp8ndIl/Uo4ExSZuYGFRXPARh
cUVLI0ROJGGWGr68WUoggHcEu1WaeekyQnpelYHTtP0p6m7MREBdDvLKfPiSfOMz
Xoi5bWYcoJ2Hz+N7w6VZU9SxRFIpRVgb/BBkxQ7vMGOkHVXF139N4ZZoAA6z1rP1
M0OZiYi0PHNlNA2x6/hWjW/s7eSM/w==
=f/Ds
-----END PGP SIGNATURE-----

--Sig_/Ed2Nn8F8WPVJvnATdGlcyLf--

