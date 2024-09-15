Return-Path: <bpf+bounces-39966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC559979990
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 01:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F9C1C22392
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 23:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5E313D2A9;
	Sun, 15 Sep 2024 23:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lvf+qAV+"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C7B13B590;
	Sun, 15 Sep 2024 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726443018; cv=none; b=nvGu90V1QYVjMbI6foAPA/Q9sowrEZ6xary19FWZbYlWDBq98rQh8+uFhHkrTxLShCHDiA9f2zsxf5D+ykYH7aMtyhoFDvngO9Y3he8G+uCmL37bkt3geo8ClHntbEa6FPA/PWiMvdaujDUBNVR9slAG6Zc2Lh4WLN5J9P/19A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726443018; c=relaxed/simple;
	bh=fNi8iRIHBUc/y5xpNdMAWcrLKlYdm2FtKG98edSv+Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tv2XY886dfu94HotQxqEpIhJzdpLc7MqZTNUbDQYk2Z877i9c86eGoU4nr83xim5yAcWZ9yxEzfVBjJnqefI9e3EQru/C15JMOGeuIqpHrr0K94X+G0kDkKoIVbnYoXbgjAPvJPsOT/ci0qVw1Cc4GcvX2DCPxmfBFzSqsZoUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lvf+qAV+; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1726443013;
	bh=Y1h5tBB4yQZthgHIVPPlEF11vZNIxCjyn316QTsFtvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lvf+qAV+hi6Tjgll66dQTIDb7P/Ov87EbW4wTv3DtGR/V3XlVKR/hNvox0WA2aozw
	 smfCQHGVOApxgg6UtLuyfSAyRT8pYZou4Ttg+b7/6aq8pgVOprk40fY2YeahimlJ/c
	 zwHAPRoqYu9L91TKcHZQse9WL3fVAVIpGNYxT1aQo1VlP67t/hFhpnHqT4WoZ3/008
	 UNs9CiW5BJVig19dOG9N2cjhd2diyFs2eHF+oZHPWcqWePtmLC32iBhQlNek1IP/yZ
	 fnwpfCOQUWtwodvRMFBnFaMOFeAiX+J4ZalM6NVBnB9HCTgm4/pHkb5DgDL1/KvTDD
	 Ktj52D8/H1Dag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X6PR92HCsz4x8H;
	Mon, 16 Sep 2024 09:30:13 +1000 (AEST)
Date: Mon, 16 Sep 2024 09:30:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Chinner <david@fromorbit.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, <linux-xfs@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240916093012.3a4dbb3f@canb.auug.org.au>
In-Reply-To: <20240913135551.4156251c@canb.auug.org.au>
References: <20240913135551.4156251c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n+py4hQiflHSYe1wuWUP..Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/n+py4hQiflHSYe1wuWUP..Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 13 Sep 2024 13:55:51 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the bpf-next tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>=20
> fs/xfs/xfs_exchrange.c: In function 'xfs_ioc_commit_range':
> fs/xfs/xfs_exchrange.c:938:19: error: 'struct fd' has no member named 'fi=
le'
>   938 |         if (!file1.file)
>       |                   ^
> fs/xfs/xfs_exchrange.c:940:26: error: 'struct fd' has no member named 'fi=
le'
>   940 |         fxr.file1 =3D file1.file;
>       |                          ^
>=20
> Caused by commit
>=20
>   1da91ea87aef ("introduce fd_file(), convert all accessors to it.")
>=20
> interacting with commit
>=20
>   398597c3ef7f ("xfs: introduce new file range commit ioctls")
>=20
> I have applied the following patch for today.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 13 Sep 2024 13:53:35 +1000
> Subject: [PATCH] fix up 3 for "introduce fd_file(), convert all accessors=
 to
>  it."
>=20
> interacting with commit "xfs: introduce new file range commit ioctls"
> from the xfs tree.
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/xfs/xfs_exchrange.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
> index 39fe02a8deac..75cb53f090d1 100644
> --- a/fs/xfs/xfs_exchrange.c
> +++ b/fs/xfs/xfs_exchrange.c
> @@ -935,9 +935,9 @@ xfs_ioc_commit_range(
>  	fxr.file2_ctime.tv_nsec	=3D kern_f->file2_ctime_nsec;
> =20
>  	file1 =3D fdget(args.file1_fd);
> -	if (!file1.file)
> +	if (fd_empty(file1))
>  		return -EBADF;
> -	fxr.file1 =3D file1.file;
> +	fxr.file1 =3D fd_file(file1);
> =20
>  	error =3D xfs_exchange_range(&fxr);
>  	fdput(file1);
> --=20
> 2.45.2

This is now required in the merge of the vfs tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/n+py4hQiflHSYe1wuWUP..Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbnbgQACgkQAVBC80lX
0GxOmQf9EqVOabb35jmctfoGwKoCRx2hkULOJK0zMnSI5LXbUbGgjybTQ/hQ3xY2
dPkX0WvpfX2EaGvAAPgqjLrUvKOtAvEWMwzXnwXNimeGI8oDAc0j45X4BekNrkmJ
rr53OSCgdTX/VgT1r/aHSW+XGmvG4fUiK2IDZRytHUMaiwr8uNtuqaEakqYHmfKW
WC01w7FkTBxH/n21XTRXmbGt/9nh0r0IhhBBi9jBXF2obZ8NytYxbOUdUmSuh2tj
WyBBVM6DwKU6RGAcadhvpySOdy/zwhfGjW5fvnAs29nKXc0KeFrp1uH+KELF305S
r0SvOJVp1H6c55YzStwo1Sg2PWSQwA==
=q4nB
-----END PGP SIGNATURE-----

--Sig_/n+py4hQiflHSYe1wuWUP..Q--

