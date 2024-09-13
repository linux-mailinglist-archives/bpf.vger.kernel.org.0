Return-Path: <bpf+bounces-39797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DB0977790
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 05:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EDB1B24054
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 03:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929D51B9837;
	Fri, 13 Sep 2024 03:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ph6ibLqC"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4B11FBA;
	Fri, 13 Sep 2024 03:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726199331; cv=none; b=M5ZNAzRFRt2f+86444CtiY6IcvS45fdURHd7MtUXFEooAOwBtE2MFx4TXIfoKn6FxDT6JRxH28xYVLqck2HD93P4zGolk+Nk6DXH/8XYdEr/ldQM1La7CGGIfxVc5qGU03r0OvCybW8Gzj7d0Cd1L+82cLWFscM50VHJdszEzDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726199331; c=relaxed/simple;
	bh=fDpA3RDB7hpc6BAZBMruruc+OR8VJqYh9Ls8EcHd+Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7Zp6YjZBskoIpLeWw/ceCAihBYwM0vIhiD2VqYLYfmlseX2tofiSfHsiKU35T74CZhLv1PJpP6UP2zEgp9Zn8ykT3I9xbwsIOFJZlJk1UASclu36/OtTqn84T4siVvTo3rh7OnBE2bu3Y1SY6GVOKBzsxfUkrxSojun+dcISqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Ph6ibLqC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1726199325;
	bh=eurdrrX2w1B85hXJM5O97JrTykPGKFdVnn61W9DTr6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ph6ibLqCIkb+XpaJpKMzHd/HcnykBWnvkNcjP1xlJgS+b4036J0FSH19antNSwXfg
	 KLvX591OIz2UPyhnv0yx/fTHfS6Wdd+1MKT+dVmx6GpMV6jDGj/1DtVVUUz+3noVE0
	 rnqlLdHcV0BqVAZLrXmV2wL6rmEQeg2C80UTKALvX0pOOBMKBopE4fSMggu3DgWz71
	 fYZspKUsgowEJmdd7aCnJGeLN46qJPTQnnuuB346mXVLeQg7jmFrN/jfsEVaDEfXCR
	 4fAGVAmA+feIVrNBb9WyMjvYsqiQdqB1f/oGcolLjWFZwe0Kzg6WEnaA89S4xqcp7y
	 UYadLuAd2l66g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X4gJs4MJHz4wy9;
	Fri, 13 Sep 2024 13:48:45 +1000 (AEST)
Date: Fri, 13 Sep 2024 13:48:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240913134844.39c6518d@canb.auug.org.au>
In-Reply-To: <20240913134504.37384c93@canb.auug.org.au>
References: <20240913134504.37384c93@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JnM3raJoyIOuU6seij8prmZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/JnM3raJoyIOuU6seij8prmZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 13 Sep 2024 13:45:04 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the bpf-next tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:

/home/sfr/next/next/fs/xattr.c: In function 'path_getxattrat':
/home/sfr/next/next/fs/xattr.c:832:23: error: 'class_fd_t' {aka 'struct fd'=
} has no member named 'file'
  832 |                 if (!f.file)
      |                       ^
/home/sfr/next/next/fs/xattr.c:834:29: error: 'class_fd_t' {aka 'struct fd'=
} has no member named 'file'
  834 |                 audit_file(f.file);
      |                             ^
/home/sfr/next/next/fs/xattr.c:835:49: error: 'class_fd_t' {aka 'struct fd'=
} has no member named 'file'
  835 |                 return getxattr(file_mnt_idmap(f.file), file_dentry=
(f.file),
      |                                                 ^
/home/sfr/next/next/fs/xattr.c:835:70: error: 'class_fd_t' {aka 'struct fd'=
} has no member named 'file'
  835 |                 return getxattr(file_mnt_idmap(f.file), file_dentry=
(f.file),
      |                                                                    =
  ^
/home/sfr/next/next/fs/xattr.c: In function 'path_listxattrat':
/home/sfr/next/next/fs/xattr.c:952:23: error: 'class_fd_t' {aka 'struct fd'=
} has no member named 'file'
  952 |                 if (!f.file)
      |                       ^
/home/sfr/next/next/fs/xattr.c:954:29: error: 'class_fd_t' {aka 'struct fd'=
} has no member named 'file'
  954 |                 audit_file(f.file);
      |                             ^
/home/sfr/next/next/fs/xattr.c:955:47: error: 'class_fd_t' {aka 'struct fd'=
} has no member named 'file'
  955 |                 return listxattr(file_dentry(f.file), list, size);
      |                                               ^
/home/sfr/next/next/fs/xattr.c: In function 'do_fremovexattr':
/home/sfr/next/next/fs/xattr.c:1021:15: error: 'class_fd_t' {aka 'struct fd=
'} has no member named 'file'
 1021 |         if (!f.file)=20
      |               ^
/home/sfr/next/next/fs/xattr.c:1023:21: error: 'class_fd_t' {aka 'struct fd=
'} has no member named 'file'
 1023 |         audit_file(f.file);
      |                     ^
/home/sfr/next/next/fs/xattr.c:1031:38: error: 'class_fd_t' {aka 'struct fd=
'} has no member named 'file'
 1031 |         error =3D mnt_want_write_file(f.file);
      |                                      ^
/home/sfr/next/next/fs/xattr.c:1033:53: error: 'class_fd_t' {aka 'struct fd=
'} has no member named 'file'
 1033 |                 error =3D removexattr(file_mnt_idmap(f.file),
      |                                                     ^
/home/sfr/next/next/fs/xattr.c:1034:38: error: 'class_fd_t' {aka 'struct fd=
'} has no member named 'file'
 1034 |                                     f.file->f_path.dentry, kname);
      |                                      ^
/home/sfr/next/next/fs/xattr.c:1035:38: error: 'class_fd_t' {aka 'struct fd=
'} has no member named 'file'
 1035 |                 mnt_drop_write_file(f.file);
      |                                      ^

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

--=20
Cheers,
Stephen Rothwell

--Sig_/JnM3raJoyIOuU6seij8prmZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbjth0ACgkQAVBC80lX
0GzhyAf/agcBqbt389FISsU3rVssd13n9dAkHFnbGeFNY8G4QEkTM2J41O/uVtzI
j8aKvPyQtNpEdByooNSxeGITQHM1TkKtB5XApbNt0Z7vyKJraFUTKb7kwB6RfAuJ
MGR+6QwqMimdkgClVCNqXBtQwovYjgw1fff8Q6EwwyqLSaizuSqfAiTSdMts+9mJ
cLu8zKWVHQNUb58LrRcEzU52unWDrNZMeArvbhENPWCDoZqRBFUQ/gFhQdvcRdjy
hxwVSL1AzWGjmkgdqBOsK8YrRb9KSxY8SJE0buKEHr4qvv7Of7vGN/PCd1z5gKuT
DO+0yVEBXTZC+YgJtG/1z1Mj14wC1A==
=ZCj8
-----END PGP SIGNATURE-----

--Sig_/JnM3raJoyIOuU6seij8prmZ--

