Return-Path: <bpf+bounces-54911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6A6A75D57
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 01:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61006188A720
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 23:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716C71BEF77;
	Sun, 30 Mar 2025 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TOa23D1F"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C92B2CF;
	Sun, 30 Mar 2025 23:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743377278; cv=none; b=MEeFLbfZY0Nq1clWfaPmE0egq/ZdXvjQUkTy6zdwBj9KQIyahUCtBFxU0WVo8oriN/7a4WRuJp5EVADGDLqzAsqHRWIwo35dVSNeIZjRoR5rj06t0FlnVM92lDx5v9y2bWWc84CEjrh4x3jfWSaEgReTFtYdI3Opar0lbNDsXEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743377278; c=relaxed/simple;
	bh=uABQICpb5JOJgV/Cp/Kl1YpgC4t3mLdzre5bn5FDk0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2obM7hMyjtOkWHdRdR0FBp5ELZVOhzOHryOPwYOQimt99jhvS4O3KaQzGA0VDbzw9JGO9ZZE9Rm13quQykXu43EGjmhLe9K8zZLpDVuiyTFgAF6+ul9YorFwgqFrnJhBG+CaX9QyZLSXvPWrV+A0LkYB+JhQrH4/FHLp/Uevo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=TOa23D1F; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1743377270;
	bh=21CJhFAzmfRuzVtEe/k7/TVHSYBH4KcMA1jSdJWgpYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TOa23D1Fc8a6Ykma1S4zIYAuZqpLfy5SnD0gXOClPgltUqlJ7mstTIyWQxOuUWW3G
	 IT/ua/x6R55ezoD/yy5alF5slK2NP7A1QaO0tMfe/EWNFMC5Hb7/yZCFYT9bb/a6ZR
	 0RBUcS49meS0BJWoibAcYFYJY4ljby9ObWiJ3/ryPEqZXIZB9Rt4Yi/gHDnyyod2Cx
	 7SceqYj7fMeubvlSiquGlexq0OyrvOa78bwF6gqUDCa7Q/9NQ8sOKQx3Ptk1Ud4UD1
	 vY6O23wv7xTQDKUJ8Ce+3u6jWG9z76S1yZ96i35HaWZwP4X4aoVlCaibFyz+mWgVdK
	 o2FPgarNTnIRw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZQr5y2Dvnz4wcT;
	Mon, 31 Mar 2025 10:27:49 +1100 (AEDT)
Date: Mon, 31 Mar 2025 10:27:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Luiz Capitulino <luizcap@redhat.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the mm tree
Message-ID: <20250331102749.205e92cc@canb.auug.org.au>
In-Reply-To: <20250311120422.1d9a8f80@canb.auug.org.au>
References: <20250311120422.1d9a8f80@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DkaGAb9f2IcT/mUQcffppWW";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/DkaGAb9f2IcT/mUQcffppWW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 11 Mar 2025 12:04:22 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>=20
>   mm/page_owner.c
>=20
> between commit:
>=20
>   a5bc091881fd ("mm: page_owner: use new iteration API")
>=20
> from the mm-unstable branch of the mm tree and commit:
>=20
>   8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
>=20
> from the bpf-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc mm/page_owner.c
> index 849d4a471b6c,90e31d0e3ed7..000000000000
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@@ -297,11 -293,17 +297,17 @@@ void __reset_page_owner(struct page *pa
>  =20
>   	page_owner =3D get_page_owner(page_ext);
>   	alloc_handle =3D page_owner->handle;
>  +	page_ext_put(page_ext);
>  =20
> - 	handle =3D save_stack(GFP_NOWAIT | __GFP_NOWARN);
> + 	/*
> + 	 * Do not specify GFP_NOWAIT to make gfpflags_allow_spinning() =3D=3D =
false
> + 	 * to prevent issues in stack_depot_save().
> + 	 * This is similar to try_alloc_pages() gfp flags, but only used
> + 	 * to signal stack_depot to avoid spin_locks.
> + 	 */
> + 	handle =3D save_stack(__GFP_NOWARN);
>  -	__update_page_owner_free_handle(page_ext, handle, order, current->pid,
>  +	__update_page_owner_free_handle(page, handle, order, current->pid,
>   					current->tgid, free_ts_nsec);
>  -	page_ext_put(page_ext);
>  =20
>   	if (alloc_handle !=3D early_handle)
>   		/*

This is now a conflict between the mm-stable tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/DkaGAb9f2IcT/mUQcffppWW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmfp03UACgkQAVBC80lX
0GydHAf/SSl7CnfA+w1FjKBoEKuslXX0qm4HBei/YnODIiR00ivzayOxItK0j8q8
TdMqZN07KPmXhTJo1Fns+tr+mc3NDZ3o7GXpRC4fTOKGPFKUM9MwU2ZKGjxZ4wck
Oy0Du2DIrooPAkpg1xXVgTQYdRinpvxhRvXFxrEuUhNkA27CQjDnTW+ZYKjA9L5Z
gkUe89+JU/RwlAnCheJDMD+CwIg+xh6GYlXPevd3xswvOC3x2ahToRk3LWMycm8k
b0BVEIR0Oxx430ujXf0nsRMTcdLzj1q3Fi2M07FtG28pAAuY9hXzE/Ru6ZgSpbXZ
30hjcfI4hX0crtcDoRxOxwNI1gCaFA==
=B7tM
-----END PGP SIGNATURE-----

--Sig_/DkaGAb9f2IcT/mUQcffppWW--

