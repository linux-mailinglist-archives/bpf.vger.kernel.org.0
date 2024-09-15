Return-Path: <bpf+bounces-39965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBF597998B
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 01:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610421C21E18
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 23:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F7813211A;
	Sun, 15 Sep 2024 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sqeRATEC"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46B4381B1;
	Sun, 15 Sep 2024 23:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726442881; cv=none; b=qJwJQlJQ4RLsaMCg5dWqQwV7b1LP4li0D5qRVSo5yaSsViFErPKXOiGoblv4ac3Nz0KvP5hb59+7uKU5PvvCUC2p3WDtzAY67hY6kgcSV5b9XgeYarxUoZilINYfAobT64pO4aRYiKbE0UgWvs1BSIVpUL72EeUt+YhKa5DAdHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726442881; c=relaxed/simple;
	bh=qCZr0Athwa1l++25hTH96MjiT0T7930XP0xjtmIo2xo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YS9BQoYTmClmPKbH7DS4qjRhXWkdzhzUWJM986ZhxYROZuUdJDaBxURE5EfULMIFHPWu5kjbOwJI2g7IIWQU8Ji+I4VYXy9Piq8ayha7r2oVe58bxAK0/KaoFBWP4bB4orenvTPCimJ4sjbQD0hq2TWE8I5sxBf3lj5eY/qlUFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=sqeRATEC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1726442877;
	bh=TYE+uszZZVVLC+xupuJroi9NKnZWMcDz7zqFA1Gs3IA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sqeRATECNazbtx9NZk+vkOPcKPbLbaw5ePy1rCaeaWcyYNWrVPi+Yc/m5TEvXxqZR
	 JFUVt6Ci4diQqqI1ZE5mhNZvCrfaeCYHt55+jRAoenzYbeJ9g2li/0/ROc2NKiPziC
	 oRe3qs/yGRpxaHrsq+qaEn+zplEjgH4m2cqT1QaNpCM97miOkvfOFDr36F15s+NVTY
	 at0CaU/gadH+r6c3IpJ62WdEeJi9INnTcAzTs+Y4Bx6mc648t1QmJCPqEnxocHg1iO
	 mt6W86IikR9tm8TjkwxyUt25lU+sn+ibzjR5i4RKhTMeJhOFfomEF9qB6C3syDWyGE
	 ndvLlOAHtKpbg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X6PNY4J5Lz4x8T;
	Mon, 16 Sep 2024 09:27:57 +1000 (AEST)
Date: Mon, 16 Sep 2024 09:27:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240916092756.74401da1@canb.auug.org.au>
In-Reply-To: <20240913134504.37384c93@canb.auug.org.au>
References: <20240913134504.37384c93@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TCeZXJ2bh8d18/N43jTjMH_";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/TCeZXJ2bh8d18/N43jTjMH_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 13 Sep 2024 13:45:04 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the bpf-next tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>=20
>=20
> Caused by commit
>=20
>   1da91ea87aef ("introduce fd_file(), convert all accessors to it.")
>=20
> interacting with commits
>=20
>   1a61c9d6ec1d ("xattr: handle AT_EMPTY_PATH when setting xattrs")
>   278397b2c592 ("xattr: handle AT_EMPTY_PATH when getting xattrs")
>   5560ab7ee32e ("xattr: handle AT_EMPTY_PATH when listing xattrs")
>   33fce6444e7d ("xattr: handle AT_EMPTY_PATH when removing xattrs")
>=20
> I have applied the following patch for today.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 13 Sep 2024 13:40:17 +1000
> Subject: [PATCH] fix up 2 for "introduce fd_file(), convert all accessors=
 to it."
>=20
> interacting with commits
>=20
>   1a61c9d6ec1d ("xattr: handle AT_EMPTY_PATH when setting xattrs")
>   278397b2c592 ("xattr: handle AT_EMPTY_PATH when getting xattrs")
>   5560ab7ee32e ("xattr: handle AT_EMPTY_PATH when listing xattrs")
>   33fce6444e7d ("xattr: handle AT_EMPTY_PATH when removing xattrs")
>=20
> from the vfs-brauner tree.
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/xattr.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/xattr.c b/fs/xattr.c
> index fa992953fa78..f3559ed3279f 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -645,7 +645,7 @@ static int do_fsetxattr(int fd, const char __user *na=
me,
>  	int error;
> =20
>  	CLASS(fd, f)(fd);
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EBADF;
> =20
>  	audit_file(fd_file(f));
> @@ -829,10 +829,10 @@ static ssize_t path_getxattrat(int dfd, const char =
__user *pathname,
> =20
>  	if (at_flags & AT_EMPTY_PATH && vfs_empty_path(dfd, pathname)) {
>  		CLASS(fd, f)(dfd);
> -		if (!f.file)
> +		if (fd_empty(f))
>  			return -EBADF;
> -		audit_file(f.file);
> -		return getxattr(file_mnt_idmap(f.file), file_dentry(f.file),
> +		audit_file(fd_file(f));
> +		return getxattr(file_mnt_idmap(fd_file(f)), file_dentry(fd_file(f)),
>  				name, value, size);
>  	}
> =20
> @@ -895,7 +895,7 @@ SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user=
 *, name,
>  	struct fd f =3D fdget(fd);
>  	ssize_t error =3D -EBADF;
> =20
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return error;
>  	audit_file(fd_file(f));
>  	error =3D getxattr(file_mnt_idmap(fd_file(f)), fd_file(f)->f_path.dentr=
y,
> @@ -949,10 +949,10 @@ static ssize_t path_listxattrat(int dfd, const char=
 __user *pathname,
> =20
>  	if (at_flags & AT_EMPTY_PATH && vfs_empty_path(dfd, pathname)) {
>  		CLASS(fd, f)(dfd);
> -		if (!f.file)
> +		if (fd_empty(f))
>  			return -EBADF;
> -		audit_file(f.file);
> -		return listxattr(file_dentry(f.file), list, size);
> +		audit_file(fd_file(f));
> +		return listxattr(file_dentry(fd_file(f)), list, size);
>  	}
> =20
>  	lookup_flags =3D (at_flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
> @@ -993,7 +993,7 @@ SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, l=
ist, size_t, size)
>  	struct fd f =3D fdget(fd);
>  	ssize_t error =3D -EBADF;
> =20
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return error;
>  	audit_file(fd_file(f));
>  	error =3D listxattr(fd_file(f)->f_path.dentry, list, size);
> @@ -1018,9 +1018,9 @@ static int do_fremovexattr(int fd, const char __use=
r *name)
>  	int error =3D -EBADF;
> =20
>  	CLASS(fd, f)(fd);
> -	if (!f.file)
> +	if (fd_empty(f))
>  		return error;
> -	audit_file(f.file);
> +	audit_file(fd_file(f));
> =20
>  	error =3D strncpy_from_user(kname, name, sizeof(kname));
>  	if (error =3D=3D 0 || error =3D=3D sizeof(kname))
> @@ -1028,11 +1028,11 @@ static int do_fremovexattr(int fd, const char __u=
ser *name)
>  	if (error < 0)
>  		return error;
> =20
> -	error =3D mnt_want_write_file(f.file);
> +	error =3D mnt_want_write_file(fd_file(f));
>  	if (!error) {
> -		error =3D removexattr(file_mnt_idmap(f.file),
> -				    f.file->f_path.dentry, kname);
> -		mnt_drop_write_file(f.file);
> +		error =3D removexattr(file_mnt_idmap(fd_file(f)),
> +				    fd_file(f)->f_path.dentry, kname);
> +		mnt_drop_write_file(fd_file(f));
>  	}
>  	return error;
>  }
> @@ -1099,7 +1099,7 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char _=
_user *, name)
>  	char kname[XATTR_NAME_MAX + 1];
>  	int error =3D -EBADF;
> =20
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return error;
>  	audit_file(fd_file(f));
> =20
> --=20
> 2.45.2

This is not longer required as the above commits have been removed from
the vfs-brauner tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/TCeZXJ2bh8d18/N43jTjMH_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbnbX0ACgkQAVBC80lX
0GxHtQf+MhOQt4VAvNhsP2d82XA0E2w7dLP3spKKDDh28tVcqsKqZu879VGoVBlN
vD4ao0dYA0MIuIMruRDhqYko0JBawQ8fH38KuuDltWb2z3VoOxOxgGmIldp6cveJ
hU4xCmSUxdLQ+One3CHWLLH1culot4tiLEz7tGneqAXys5eVlA2tQm8KrDiFQX5C
r9dCBUJjZLcIZbX3bQWaPVlikgqJi9MVPKplwYlDyh02wZMdxh6ZuXzR/1Au8AQ6
YPx9TxPtM++sPHRQcvpvCk28nnNprNn7L+1FJizf0q5YhUbnPeqTnLZ1f7JidCz6
Brd3KqzDz1+KkvX8UVlQoPc6tbOuQA==
=fgQy
-----END PGP SIGNATURE-----

--Sig_/TCeZXJ2bh8d18/N43jTjMH_--

