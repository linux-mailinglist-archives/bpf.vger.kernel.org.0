Return-Path: <bpf+bounces-37136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C83951180
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 03:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5504C2841C1
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 01:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA9B1643A;
	Wed, 14 Aug 2024 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j06q4w+A"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44A6EA4;
	Wed, 14 Aug 2024 01:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723598323; cv=none; b=q31E5XthLNppvOzLvYehtiXI5LPHnJLPWO52+mGDsnS1FgoLRv8n8Fdsb5sGLPJcXbkOyLm1bIvpxZYeM6VbJgz7m/5WtKPpeD+UKRLYEG2wtOT6ySV5FD1AvBv+LNtENqA0xZBGmBoKB7r/v2BpL+Gj8bzj7m30TOyWVzDm5as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723598323; c=relaxed/simple;
	bh=9AN1aK0mVOw+4AMqAA7eA3E7CftcUJUPCGhvtus+yHI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=J1YewQiXPcguJxIdcrGmSbqOp4iyFr5XMO5IdyAj3wNw1qlqZ9X4e4C+uACKP5Jp6u1438J9dVvbbJgR8owzjjuQbqQA67lS7uRxLYrCgVeXMvfl589amYbYLUmcVidOGuu1NWbo6Vd7V4wzURUIALLFKs0/yKhLMUE4ybBahZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=j06q4w+A; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1723598317;
	bh=Br9qH9Jk7Tl93g+nwXetRusfuXievN8ptR19hgTy48g=;
	h=Date:From:To:Cc:Subject:From;
	b=j06q4w+ArXj1QPIbSOExuMWd4ltqBssrp7zjvhqEpE4HAyx3T2jI9esz962iYDf+Q
	 rD2pWIAAWPGSA0jW8p8hDlEdXw3Ryl6Tv8ILaq3zfp348d2aFmIvn4DYFXUI+wJRbt
	 wgAD6oyVCafHtioJIXbX9sCVlikQbfhJBNhs/dPvCEdr6/NuMekSfX5yle80zAthrn
	 ZE4TUQJ5kgIpI2KZUT+iLL6G6IDKsht4X7pQnUP42xwWZ8e2evQQGx0V54WLe8HmG3
	 2GjjSNNghjO29uBl+yrEp1Hgbrryv0XDtfCQlQDvWXRJEv02wIOwpKFFh74ngIiK/W
	 s+YMhJNnTueQg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wk9PS55bCz4x2J;
	Wed, 14 Aug 2024 11:18:36 +1000 (AEST)
Date: Wed, 14 Aug 2024 11:18:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240814111836.6368311a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TfZx_yJwhKhclQMIBV=B4BZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/TfZx_yJwhKhclQMIBV=B4BZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

fs/namespace.c: In function 'grab_requested_mnt_ns':
fs/namespace.c:5295:23: error: 'class_fd_t' {aka 'struct fd'} has no member=
 named 'file'
 5295 |                 if (!f.file)
      |                       ^
fs/namespace.c:5298:36: error: 'class_fd_t' {aka 'struct fd'} has no member=
 named 'file'
 5298 |                 if (!proc_ns_file(f.file))
      |                                    ^
In file included from fs/namespace.c:25:
fs/namespace.c:5301:46: error: 'class_fd_t' {aka 'struct fd'} has no member=
 named 'file'
 5301 |                 ns =3D get_proc_ns(file_inode(f.file));
      |                                              ^
include/linux/proc_ns.h:75:50: note: in definition of macro 'get_proc_ns'
   75 | #define get_proc_ns(inode) ((struct ns_common *)(inode)->i_private)
      |                                                  ^~~~~

Caused by commit

  1da91ea87aef ("introduce fd_file(), convert all accessors to it.")

interacting with commit

  7b9d14af8777 ("fs: allow mount namespace fd")

from the vfs-brauner tree.

I applied the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 14 Aug 2024 11:07:38 +1000
Subject: [PATCH] fixup for "introduce fd_file(), convert all accessors to i=
t."

interacting with "fs: allow mount namespace fd" from hte vfs-brauner tree.

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
+		if (!fd_file(f))
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

--=20
Cheers,
Stephen Rothwell

--Sig_/TfZx_yJwhKhclQMIBV=B4BZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAma8BewACgkQAVBC80lX
0GzM9QgAjSRyVeP1ciq/55IBfR7IdFBIXY4wt3a54vqsfk94K8HbQ4yDp5KD4Avr
HIVK7d1xQu1R2GpWsnP1KO74L15i5lk/ETw5pvD+FZbxTY8GrepDzoWQioe5QA3b
mqxYf52jSoC0t1fgfdYJLZc4t4e2+28pdAcgi9i6ELz2vIWtopsTIgaHVYasMQz7
j+hQDwzdQXsuwhFR/At9kSZM0ty1QHcKRLV+ePwxUFlL6gfCTn1HOmh2lIFocyhK
ryn+W2MP9SQrflcF8kj6zgKxw/hQfbLz8uzL8H4vswlINke2L9o8EKP/bmb/mSZa
E0mbFBipwxlAYDpXf/6tsJ7sOeTOhQ==
=5Hnt
-----END PGP SIGNATURE-----

--Sig_/TfZx_yJwhKhclQMIBV=B4BZ--

