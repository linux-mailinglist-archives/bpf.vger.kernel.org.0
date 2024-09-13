Return-Path: <bpf+bounces-39796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BD197777B
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 05:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C9EB246AA
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 03:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875D11BD503;
	Fri, 13 Sep 2024 03:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NQa5CTvS"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CFB1D4168;
	Fri, 13 Sep 2024 03:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726199110; cv=none; b=klB5ynanR4l/q3kFJVlJKhr64deJZ7BaZ4f8AypCtNZTz6iuIVAj1zCl+ms/5+8QRIgef1HGmjFQqcZ4ADq7psbsAXpU01HxeUDn1600wQR1HLxlmxJz84T58fuvVQ33bR4quGJpVKje9p4PEihyWJJ2pmOTuc205N1WPlDH/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726199110; c=relaxed/simple;
	bh=9az39iUzNwc2pSVtemtzDzPUYfaiOGkRsXpkQKAKe1k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=upQTQHfrkHioEeqMwul44PFst/reeReIVkE0PfsOzBd1+GvkPT1iEnMNFz1ULgGu+8hZmqFhQ6TC0RzArJKnhlX29/eoD99z5JyRmmMAGH13qLCowAwYxqVb8sRpM3JO8GtdLxnJel2K90Z+rORfqPCYBkYdENOTMHwQP6d42iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=NQa5CTvS; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1726199105;
	bh=4YM0AjSQhKAmKD6VD/pyAmrY+sGhMsycC2Y66eXJZwo=;
	h=Date:From:To:Cc:Subject:From;
	b=NQa5CTvS5JMte/Mw+KejpZiCel4VlLH5CKBf/CjYn922XZ5DRxrzjraEr/nH2Sj8p
	 AZO5gd3cUo9DzV/NZaMIvbCmlir6T8er6701pbjgY7RiY42nuymvKZQqGy8RdKTgXX
	 AR7ZJgPeVAtZ8OocPidAMY7WOskR5YrTgJizfGUvpS6bcn6t4Fmwencp+xXqgd/Yli
	 doo3T4aA7bbWgvZ1eCOLzaeB/UW7hNxmmn4AHyMmMub9AVplX1ujxkGyEQbsgO3urU
	 OtCrWl3A2QPTNyaMXLA6KC0gfEknOU1jtJsyzc0LPdswclAYL1p0do75iuRu/JtxL2
	 /xei7zrgKjtuQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X4gDd1KkJz4wy9;
	Fri, 13 Sep 2024 13:45:05 +1000 (AEST)
Date: Fri, 13 Sep 2024 13:45:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240913134504.37384c93@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ymAgkt=IKxQlT3LACG=9wmO";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ymAgkt=IKxQlT3LACG=9wmO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:


Caused by commit

  1da91ea87aef ("introduce fd_file(), convert all accessors to it.")

interacting with commits

  1a61c9d6ec1d ("xattr: handle AT_EMPTY_PATH when setting xattrs")
  278397b2c592 ("xattr: handle AT_EMPTY_PATH when getting xattrs")
  5560ab7ee32e ("xattr: handle AT_EMPTY_PATH when listing xattrs")
  33fce6444e7d ("xattr: handle AT_EMPTY_PATH when removing xattrs")

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 13 Sep 2024 13:40:17 +1000
Subject: [PATCH] fix up 2 for "introduce fd_file(), convert all accessors t=
o it."

interacting with commits

  1a61c9d6ec1d ("xattr: handle AT_EMPTY_PATH when setting xattrs")
  278397b2c592 ("xattr: handle AT_EMPTY_PATH when getting xattrs")
  5560ab7ee32e ("xattr: handle AT_EMPTY_PATH when listing xattrs")
  33fce6444e7d ("xattr: handle AT_EMPTY_PATH when removing xattrs")

from the vfs-brauner tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/xattr.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index fa992953fa78..f3559ed3279f 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -645,7 +645,7 @@ static int do_fsetxattr(int fd, const char __user *name,
 	int error;
=20
 	CLASS(fd, f)(fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
=20
 	audit_file(fd_file(f));
@@ -829,10 +829,10 @@ static ssize_t path_getxattrat(int dfd, const char __=
user *pathname,
=20
 	if (at_flags & AT_EMPTY_PATH && vfs_empty_path(dfd, pathname)) {
 		CLASS(fd, f)(dfd);
-		if (!f.file)
+		if (fd_empty(f))
 			return -EBADF;
-		audit_file(f.file);
-		return getxattr(file_mnt_idmap(f.file), file_dentry(f.file),
+		audit_file(fd_file(f));
+		return getxattr(file_mnt_idmap(fd_file(f)), file_dentry(fd_file(f)),
 				name, value, size);
 	}
=20
@@ -895,7 +895,7 @@ SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *=
, name,
 	struct fd f =3D fdget(fd);
 	ssize_t error =3D -EBADF;
=20
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return error;
 	audit_file(fd_file(f));
 	error =3D getxattr(file_mnt_idmap(fd_file(f)), fd_file(f)->f_path.dentry,
@@ -949,10 +949,10 @@ static ssize_t path_listxattrat(int dfd, const char _=
_user *pathname,
=20
 	if (at_flags & AT_EMPTY_PATH && vfs_empty_path(dfd, pathname)) {
 		CLASS(fd, f)(dfd);
-		if (!f.file)
+		if (fd_empty(f))
 			return -EBADF;
-		audit_file(f.file);
-		return listxattr(file_dentry(f.file), list, size);
+		audit_file(fd_file(f));
+		return listxattr(file_dentry(fd_file(f)), list, size);
 	}
=20
 	lookup_flags =3D (at_flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
@@ -993,7 +993,7 @@ SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, lis=
t, size_t, size)
 	struct fd f =3D fdget(fd);
 	ssize_t error =3D -EBADF;
=20
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return error;
 	audit_file(fd_file(f));
 	error =3D listxattr(fd_file(f)->f_path.dentry, list, size);
@@ -1018,9 +1018,9 @@ static int do_fremovexattr(int fd, const char __user =
*name)
 	int error =3D -EBADF;
=20
 	CLASS(fd, f)(fd);
-	if (!f.file)
+	if (fd_empty(f))
 		return error;
-	audit_file(f.file);
+	audit_file(fd_file(f));
=20
 	error =3D strncpy_from_user(kname, name, sizeof(kname));
 	if (error =3D=3D 0 || error =3D=3D sizeof(kname))
@@ -1028,11 +1028,11 @@ static int do_fremovexattr(int fd, const char __use=
r *name)
 	if (error < 0)
 		return error;
=20
-	error =3D mnt_want_write_file(f.file);
+	error =3D mnt_want_write_file(fd_file(f));
 	if (!error) {
-		error =3D removexattr(file_mnt_idmap(f.file),
-				    f.file->f_path.dentry, kname);
-		mnt_drop_write_file(f.file);
+		error =3D removexattr(file_mnt_idmap(fd_file(f)),
+				    fd_file(f)->f_path.dentry, kname);
+		mnt_drop_write_file(fd_file(f));
 	}
 	return error;
 }
@@ -1099,7 +1099,7 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __u=
ser *, name)
 	char kname[XATTR_NAME_MAX + 1];
 	int error =3D -EBADF;
=20
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return error;
 	audit_file(fd_file(f));
=20
--=20
2.45.2

--=20
Cheers,
Stephen Rothwell

--Sig_/ymAgkt=IKxQlT3LACG=9wmO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbjtUAACgkQAVBC80lX
0GziIwf8C8tPIrJTuCttaL0u+tumNFBhWHcAFxdPfcD66l1dcjHTZzOQIjRxRoT6
QYWZQkBUEp+Hel5SVPydnu17nK+W5xawGdGwZcR39cRO/gt7MaCZUAqk5f/HAjCN
QJ6HRqqrJQrb9G01oBtYu6ZMNhMZ7JQQ1cGgItbNfF40eJgfIeWfEjB2w9OTCcN4
ePzr8A8K76j1deEilDxGpXtMwRreOa5kdnsf1GRds16OUkxTs/5MZtF6OptiU+2Q
Wy2DIbNhs1yuArfdpJwJhNKMtaWyJFK3cVtsEB6qgAyouaqzZGkoK+/WIjIwKhL4
YekgHt68RSCYY1BslF9QvNDP+p0C3g==
=4Qob
-----END PGP SIGNATURE-----

--Sig_/ymAgkt=IKxQlT3LACG=9wmO--

