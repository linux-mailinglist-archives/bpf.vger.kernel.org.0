Return-Path: <bpf+bounces-37141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3FD951296
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 04:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F1AB21C0E
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 02:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836F7224E8;
	Wed, 14 Aug 2024 02:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SRK6Ixpr"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE2D1E4A4;
	Wed, 14 Aug 2024 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723603082; cv=none; b=aT1KNqhcJU0CmZ5i5wFYd4YxiszcGbcuynYAhHOl2Vh0fWG4jyEzMXovRChvVjfcFk4s4lrICpqXby2tDkyfio7BRQ5oyAPBeuuXoUe5rJ6A/t9VMj4GQjGlK3lAwc21EzSPfzTEpZKYd65iSXprg52h+6u5a1EeMwslHTHdy0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723603082; c=relaxed/simple;
	bh=eKIM5ZFdypC0nBgsRBj5o3fYRfWidtgqnbzcMNKdzXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUWOcPNGInk+Q+BMsY3pwmHN8MVQLXNcKSFOEGMGUKxcblnDOU6CXJkPOYX8/mfUwUxASOxc1j6nPiEqie/ztIXN5GikYP9Jlnky63sZHdggmxzw3OyMgeIZq2NDYwKnbtZXbbSJvHyvs3AyzTovkcj4KSX8mTrSJODPAfrAhis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=SRK6Ixpr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1723603075;
	bh=rtvbE0qmkdGcMntdWqvbt6QfVYNElwJh+1J4IukKgFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SRK6IxprkmRaCIhVc7Di2JTB5pb4JB/QjpXj9vBcmQMIUfGmqcgwgLulX3SmyWNZc
	 veb5X142/YUarYbbsgV0rUuqSi0Y/sQEvWBfmN5gxCeiT0hfBhkWaVG4DDEW1dwpGz
	 rLA7KekcStEHV+OMBOw5lSaMkxHhqVfwX53/Q/EtsCH1ekCXFtrdK+0uNzqdgTCwNP
	 NlmgS+Lm+dkUMCDd+9beCrvO96S9zT+K5Co2/aD6pKl5VuoXXOYXllnVPiyKc/eLNe
	 gBkLgMmJAd7ThZYIv4ByCVvVUOS1fB0KrX+m5qWE0UKPo+tTNiXLLGuL3nA5aLUH4z
	 9fM7+5vH33iow==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WkC8z0XTPz4wb0;
	Wed, 14 Aug 2024 12:37:54 +1000 (AEST)
Date: Wed, 14 Aug 2024 12:37:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Christian Brauner
 <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240814123753.70dd1389@canb.auug.org.au>
In-Reply-To: <20240814014157.GM13701@ZenIV>
References: <20240814112504.42f77e3c@canb.auug.org.au>
	<20240814014157.GM13701@ZenIV>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ztEVtAiiMi3qbUtUcPVWd.+";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ztEVtAiiMi3qbUtUcPVWd.+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

On Wed, 14 Aug 2024 02:41:57 +0100 Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Aug 14, 2024 at 11:25:04AM +1000, Stephen Rothwell wrote:
> >  	if (at_flags & AT_EMPTY_PATH && vfs_empty_path(dfd, pathname)) {
> >  		CLASS(fd, f)(dfd);
> > -		if (!f.file)
> > +		if (!fd_file(f)) =20
>=20
> 		if (fd_empty(f))
>=20
> actually, and similar for the rest of it.  Anyway, that'll need to be
> sorted out in vfs/vfs.git; sorry about the delay.

So from tomorrow, the two merge resolution patches will be these:

rom: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 14 Aug 2024 11:07:38 +1000
Subject: [PATCH] fixup for "introduce fd_file(), convert all accessors to i=
t."

interacting with "fs: allow mount namespace fd" from the vfs-brauner tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/namespace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 159be8ed9d24..7aed325c48ad 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5292,13 +5292,13 @@ static struct mnt_namespace *grab_requested_mnt_ns(=
const struct mnt_id_req *kreq
 		struct ns_common *ns;
=20
 		CLASS(fd, f)(kreq->spare);
-		if (!f.file)
+		if (fd_empty(f))
 			return ERR_PTR(-EBADF);
=20
-		if (!proc_ns_file(f.file))
+		if (!proc_ns_file(fd_file(f)))
 			return ERR_PTR(-EINVAL);
=20
-		ns =3D get_proc_ns(file_inode(f.file));
+		ns =3D get_proc_ns(file_inode(fd_file(f)));
 		if (ns->ops->type !=3D CLONE_NEWNS)
 			return ERR_PTR(-EINVAL);
=20
--=20
2.43.0

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 14 Aug 2024 11:20:43 +1000
Subject: [PATCH] fixup2 for "introduce fd_file(), convert all accessors to =
it."

interacting with

  1a61c9d6ec1d ("xattr: handle AT_EMPTY_PATH when setting xattrs")
  278397b2c592 ("xattr: handle AT_EMPTY_PATH when getting xattrs")
  5560ab7ee32e ("xattr: handle AT_EMPTY_PATH when listing xattrs")
  33fce6444e7d ("xattr: handle AT_EMPTY_PATH when removing xattrs")

from the vfs-brauner tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/xattr.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index fa992953fa78..c0ecd0809172 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
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
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/ztEVtAiiMi3qbUtUcPVWd.+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAma8GIEACgkQAVBC80lX
0Gx73wgAmH056FTl+Z9ypBghIBS6OubaRQkj2+EkE0wc9T2KOMhMfdE4JvHztvKU
4kuaozw7ZzMiQLU08SURs/aB2xD7MOMlfskCbOwXghprenlDWZd5uogIEP6ZziAy
99EnKYPFGM40JvQWymnkBo370/6HdiXNTS4Jdf/ouUKqY/PUtye0QEAvUT9/MTQT
Z3mbXiu73KxyFTQHAhvhwqaMkVGtC4AVQvwkx5p9pJJr1OOvA4YmT3okYDtCP8cK
yAPjMq7jDJJRLvfLTJ92ZOcMHrmPAYJKXLZAEst9EHWbYzmlQzxWeHrnPrzw53RO
H977Wp0sEw8ordknMhH7qZXGu9jIJg==
=TtEj
-----END PGP SIGNATURE-----

--Sig_/ztEVtAiiMi3qbUtUcPVWd.+--

