Return-Path: <bpf+bounces-39964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63237979981
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 01:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B2E283096
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 23:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8571813210D;
	Sun, 15 Sep 2024 23:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MG5rhvDw"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A3B381B1;
	Sun, 15 Sep 2024 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726442770; cv=none; b=llBAhOoPjQcYU7cBwjRR/mSyDEB22wy7e8BLYnYtwNFaNN5yjnLrorGXCIyec24rQkSaxHkM5VG48/ZeArsBkZBMZzlzr+IGliFTbmiK5E2IPFFUOEJiPdb1DXEOE6Nov0k+qWwTjimpCvz34/8o4BIsG+QgoUG7W1c4cTH568M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726442770; c=relaxed/simple;
	bh=kZ62W2YsRTaBgy8HyjthoIkT4z+35LiBjjxr8D0SGvM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIWj6gAPPaFHHf0fkMkFh3R42mmUPXs14GGCp8D9q0syneayUZnfC2S1uR2gnqgsXpbfVwHP24UqKHwdWMfKwO5BzV+hcYXoijrs0VViv6T6vQKd4dQCkX7pmxmoXXBrVfs4eXez5ri+y8Z9wQjoXH5s4FUvnsGWrYcK8fPnmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MG5rhvDw; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1726442765;
	bh=b30rzIQxnIQi0GMfY/LorFowRgA1ZkQnQRUlngkM72k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MG5rhvDwWitDemXrLqwXUIeIbuuaZJHLKJPNexWlTFhHzcsmNDd0GHskVLmbxTTVj
	 gSgspQxJjx/cjqIHCmPNvvhFkwV10XIAtVcOrZxnlqZLhBudjewR5HA/oXKqTXfUa3
	 WXEo/Az7N7Jy/CCIa/WLYVB38p25gTNgFdN+iWITMidCbrxOfIIhII8gEH1EPvs0Sa
	 R5fa9JoZMjzW0OyhWUtMlItIP3O8oNQHdRWooYVwQJOLJqZC65ukct+gKJDdhJ/4b2
	 RjBp0dT/0fx0i/AsevRgpCaK27F+t5mc62MTFpWsrIxezxGqwlQDX1hYyDiKHyFp2H
	 X41W/IkJAkDNw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X6PLN6D7dz4x8T;
	Mon, 16 Sep 2024 09:26:04 +1000 (AEST)
Date: Mon, 16 Sep 2024 09:26:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240916092603.19977a40@canb.auug.org.au>
In-Reply-To: <20240913133240.066ae790@canb.auug.org.au>
References: <20240913133240.066ae790@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XD3g5w/qxh6fYulj3c5vd9/";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/XD3g5w/qxh6fYulj3c5vd9/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 13 Sep 2024 13:32:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the bpf-next tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>=20
> fs/namespace.c: In function 'grab_requested_mnt_ns':
> fs/namespace.c:5299:23: error: 'class_fd_t' {aka 'struct fd'} has no memb=
er named 'file'
>  5299 |                 if (!f.file)
>       |                       ^
> fs/namespace.c:5302:36: error: 'class_fd_t' {aka 'struct fd'} has no memb=
er named 'file'
>  5302 |                 if (!proc_ns_file(f.file))
>       |                                    ^
> In file included from fs/namespace.c:25:
> fs/namespace.c:5305:46: error: 'class_fd_t' {aka 'struct fd'} has no memb=
er named 'file'
>  5305 |                 ns =3D get_proc_ns(file_inode(f.file));
>       |                                              ^
> include/linux/proc_ns.h:75:50: note: in definition of macro 'get_proc_ns'
>    75 | #define get_proc_ns(inode) ((struct ns_common *)(inode)->i_privat=
e)
>       |                                                  ^~~~~
>=20
> Caused by commit
>=20
>   1da91ea87aef ("introduce fd_file(), convert all accessors to it.")
>=20
> interacting with commit
>=20
>   7b9d14af8777 ("fs: allow mount namespace fd")
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 13 Sep 2024 13:27:11 +1000
> Subject: [PATCH] fixe up for "introduce fd_file(), convert all accessors =
to it."
>=20
> interacting with "fs: allow mount namespace fd" from the vfs-brauner tree.
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/namespace.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 8e88938d3f19..cad6dd5db2da 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5296,13 +5296,13 @@ static struct mnt_namespace *grab_requested_mnt_n=
s(const struct mnt_id_req *kreq
>  		struct ns_common *ns;
> =20
>  		CLASS(fd, f)(kreq->spare);
> -		if (!f.file)
> +		if (!fd_file(f))
>  			return ERR_PTR(-EBADF);
> =20
> -		if (!proc_ns_file(f.file))
> +		if (!proc_ns_file(fd_file(f)))
>  			return ERR_PTR(-EINVAL);
> =20
> -		ns =3D get_proc_ns(file_inode(f.file));
> +		ns =3D get_proc_ns(file_inode(fd_file(f)));
>  		if (ns->ops->type !=3D CLONE_NEWNS)
>  			return ERR_PTR(-EINVAL);
> =20
> --=20
> 2.45.2
>=20

This is now required in the merge of the vfs tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/XD3g5w/qxh6fYulj3c5vd9/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbnbQsACgkQAVBC80lX
0GxZewf+M+v+j84q3Q/8hMUvzFjultWdUnGiWDRE84mKFoHZBw/QJxsnjrXfaXZe
jr01icI/tKPzjtsR9OHgJN6Kn9ZXa5enemuKEo754SnT/+TcZjcuua8Fg16xGNwr
Z+wFq8CCnpw+g2MnHtm+b9EpU9R1bjm/KhDQdEsyJZ7Qw/a2epRPzsS1thTWNaI/
yjeeEWU7ghyqxO39QsCtLqIqwWRiyWB1MuJYMb6ldXwgNW+vRSME0GQzVjncodTR
cpKHRkHKOIlF6LtmWvYID8p6bLz2ZBHQdvBVM7VN6DIj4WPyfLgKLjUD2TtpiBm4
8v0q2UwkbgwgJd29rCfiNOSU1uQ9qw==
=fSGC
-----END PGP SIGNATURE-----

--Sig_/XD3g5w/qxh6fYulj3c5vd9/--

