Return-Path: <bpf+bounces-37137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670C951191
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 03:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F761F23C60
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 01:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E3417578;
	Wed, 14 Aug 2024 01:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JhoE86FQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339417BDC;
	Wed, 14 Aug 2024 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723598709; cv=none; b=E/gzS/hpTSmUBrlVzhZLdmo+Y4BfMKAXjy0la8Z2PKdp/WrP+InughVWndWn9SwCAMaz+Q3/RhXGlKOuWYN1AQl+BJW2mI4uOuBT//Qb41KatNg7OzXqHS0J6hZsfLL8TA9tnrSgi70tskAKkK52O3UBgbTb7mWHXKZUJDGg6hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723598709; c=relaxed/simple;
	bh=AnrR+HslWCmvPbMpOhOeuDtvEL/9DJlKpJi1ZOxB3Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aK0ivlpIvwFPnXvJc0R9E1n5U1ILdRcE265tjh1SNvd33N3Gxt7dcL3kfIh++gTdtZFUL5tUChQ7L7qW2kgMhV88g9ltQa4Qwuv+Psuc13taIbbQZVyl3g7BcepqPgQN7ywP/GE9MSEN55QrcuWD4AR7H2KYMDk6DQJ8tJBa/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=JhoE86FQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1723598705;
	bh=dapUYXZHr2iIMDY1tVygGcHMlFdztGl+en2VJzpIn+Q=;
	h=Date:From:To:Cc:Subject:From;
	b=JhoE86FQyTdwqOos24cckaoGYsKXbJaV583AipUCjSKOcZ9N8egS0OSQQhq7VFfjj
	 +tB15cT8PPm95bWmqjF3fBkA8kMiLn+qRH5VO0cGgCzSEbtsSXj43IQTVAibFqa90I
	 iGNylgyWoImCdmvrZwzepMlsSbTDKoY4afw5FeaU41kGLqTUe1LstUB2kukK8+a9XQ
	 UFmtAc+Sd5J0ZW4AubWwnpsVuVduiUOyKffEtjgF/RX5K0gcO1NegOE+q2i/ztL1Ss
	 cIwyvDtm2qB+lutCLC60xMmZ5vrJliSHuY1n0/GlqNv9mKvJfcGIR01V0/MZeeg0ku
	 hzAVZwhjaed1A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wk9Xw6S9hz4wnx;
	Wed, 14 Aug 2024 11:25:04 +1000 (AEST)
Date: Wed, 14 Aug 2024 11:25:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240814112504.42f77e3c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pzZi8j5ndXd9/=wZyty6Nrb";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/pzZi8j5ndXd9/=wZyty6Nrb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

fs/xattr.c: In function 'path_getxattrat':
fs/xattr.c:832:23: error: 'class_fd_t' {aka 'struct fd'} has no member name=
d 'file'
  832 |                 if (!f.file)
      |                       ^
fs/xattr.c:834:29: error: 'class_fd_t' {aka 'struct fd'} has no member name=
d 'file'
  834 |                 audit_file(f.file);
      |                             ^
fs/xattr.c:835:49: error: 'class_fd_t' {aka 'struct fd'} has no member name=
d 'file'
  835 |                 return getxattr(file_mnt_idmap(f.file), file_dentry=
(f.file),
      |                                                 ^
fs/xattr.c:835:70: error: 'class_fd_t' {aka 'struct fd'} has no member name=
d 'file'
  835 |                 return getxattr(file_mnt_idmap(f.file), file_dentry=
(f.file),
      |                                                                    =
  ^
fs/xattr.c: In function 'path_listxattrat':
fs/xattr.c:952:23: error: 'class_fd_t' {aka 'struct fd'} has no member name=
d 'file'
  952 |                 if (!f.file)
      |                       ^
fs/xattr.c:954:29: error: 'class_fd_t' {aka 'struct fd'} has no member name=
d 'file'
  954 |                 audit_file(f.file);
      |                             ^
fs/xattr.c:955:47: error: 'class_fd_t' {aka 'struct fd'} has no member name=
d 'file'
  955 |                 return listxattr(file_dentry(f.file), list, size);
      |                                               ^
fs/xattr.c: In function 'do_fremovexattr':
fs/xattr.c:1021:15: error: 'class_fd_t' {aka 'struct fd'} has no member nam=
ed 'file'
 1021 |         if (!f.file)
      |               ^
fs/xattr.c:1023:21: error: 'class_fd_t' {aka 'struct fd'} has no member nam=
ed 'file'
 1023 |         audit_file(f.file);
      |                     ^
fs/xattr.c:1031:38: error: 'class_fd_t' {aka 'struct fd'} has no member nam=
ed 'file'
 1031 |         error =3D mnt_want_write_file(f.file);
      |                                      ^
fs/xattr.c:1033:53: error: 'class_fd_t' {aka 'struct fd'} has no member nam=
ed 'file'
 1033 |                 error =3D removexattr(file_mnt_idmap(f.file),
      |                                                     ^
fs/xattr.c:1034:38: error: 'class_fd_t' {aka 'struct fd'} has no member nam=
ed 'file'
 1034 |                                     f.file->f_path.dentry, kname);
      |                                      ^
fs/xattr.c:1035:38: error: 'class_fd_t' {aka 'struct fd'} has no member nam=
ed 'file'
 1035 |                 mnt_drop_write_file(f.file);
      |                                      ^

Caused by commit

  1da91ea87aef ("introduce fd_file(), convert all accessors to it.")

interacting with commits

  1a61c9d6ec1d ("xattr: handle AT_EMPTY_PATH when setting xattrs")
  278397b2c592 ("xattr: handle AT_EMPTY_PATH when getting xattrs")
  5560ab7ee32e ("xattr: handle AT_EMPTY_PATH when listing xattrs")
  33fce6444e7d ("xattr: handle AT_EMPTY_PATH when removing xattrs")

from the vfs-brauner tree.

I applied the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 14 Aug 2024 11:20:43 +1000
Subject: [PATCH] fixup2 for "introduce fd_file(), convert all accessors to
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
+		if (!fd_file(f))
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
+		if (!fd_file(f))
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
+	if (!fd_file(f))
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

--Sig_/pzZi8j5ndXd9/=wZyty6Nrb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAma8B3AACgkQAVBC80lX
0Gzq0wf/RWyW1xqpPI90Iz9fPG9kUgKg5vLBkm0Ml649kgTyLh/IxSNLKjBYdWwi
ptH46Zb0WiPfQukkt7O5fQrYivm7DDJYcceuZ+/zdb5pKv6x3ic7uOa2A5RT/2fv
Lbw3q61pUqDzzihvLl9QdHTFPdjrD2omb90ZBD1H7MElS/3iqG+dVEO0rUEw4SOl
Dh8KwZNE6GcCFvcliamRFrUf7n0E6USMQy6M4+yUM9lO5TiYLSr1T7/NebEt/bZF
On4wH9sNhxMUNeOgokEnYzQV1lpZ0fAVQisLWRc9NCxFLYgJev4F+5TqjPugnB39
L4nzk+D2ZkQFdmGtBI/Jc/nlIvgdjA==
=j1Jk
-----END PGP SIGNATURE-----

--Sig_/pzZi8j5ndXd9/=wZyty6Nrb--

