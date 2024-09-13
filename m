Return-Path: <bpf+bounces-39794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD91977763
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 05:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C0E1F25672
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 03:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AF11C5789;
	Fri, 13 Sep 2024 03:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gu+bYdFF"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5F71FBA;
	Fri, 13 Sep 2024 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726198368; cv=none; b=PX2PDuHhdmWIsNj63PPdnWbi5Wreq2qVztSaVNnTG5MiRK9x+2/BvJ1v7Mt2UlqWxU+68/9tLPjeXSWm/xqsQTe2dQ3VCAYzDhpb+18O9n6PhGYfF4OTlGp9LdTLEIf214nZ0hY2oob8vjABiCJhDr+jYSsMU0azyuDMmlvsP00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726198368; c=relaxed/simple;
	bh=5dswRtaI/cekzP52OoQleybfqeZaDsEgMK2pzxPaJWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=a5oWuj7WhPcrB6Uzkb/p/Gjmp1mPVDqLBYBNiWI6sccrj/uEk1a4kEw/Ydk8zwgZ+k4mH89l7W+x4aF9Mp20aZNBzlCpV6fF3/WD/UYmWjsdv+72axHOAJNFHARQinig0EBXN1Oeyq09sCUsLHuir7W/VbuqyIDpkvLufiswe08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=gu+bYdFF; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1726198362;
	bh=cRIdHbf/TesTZNAEoHkiUXJnt7mDLW4aOPV/tSvre20=;
	h=Date:From:To:Cc:Subject:From;
	b=gu+bYdFFk+bkAfHJir3vqwmYlvUQRLWMxDW09zx0KrSKpSGpcZzEDcnM5uX/q+zxF
	 PdXv7NzGbJQToBv07yCRRtn0Lf7e3Jmk7JXGMvbWa6NLqlnENO71HcE5ouj1eUmfSx
	 TLQm9H7AMDmYLTVXa4OnBadBR3yP0oEyTNmjsxU2YUI56KdZTRtkxb+mFQCSnWmsTU
	 NwXpaLpO/l2z69FQXF0b7Ah37xTe+mt+L5E9q5ljN/ngVxP8uNp4o3cEGKz3Kr/ky8
	 cgnQk0Vyq7c5Aqs5ZoCWuH7iSr0nLNYQe4cJFDa+noKWMKfTYtgFeiArK84WzJczPQ
	 iEy1inLYUZihg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X4fyK5y72z4wcL;
	Fri, 13 Sep 2024 13:32:41 +1000 (AEST)
Date: Fri, 13 Sep 2024 13:32:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240913133240.066ae790@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vJXuRdN4yvPhnKzzD_FG./j";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/vJXuRdN4yvPhnKzzD_FG./j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

fs/namespace.c: In function 'grab_requested_mnt_ns':
fs/namespace.c:5299:23: error: 'class_fd_t' {aka 'struct fd'} has no member=
 named 'file'
 5299 |                 if (!f.file)
      |                       ^
fs/namespace.c:5302:36: error: 'class_fd_t' {aka 'struct fd'} has no member=
 named 'file'
 5302 |                 if (!proc_ns_file(f.file))
      |                                    ^
In file included from fs/namespace.c:25:
fs/namespace.c:5305:46: error: 'class_fd_t' {aka 'struct fd'} has no member=
 named 'file'
 5305 |                 ns =3D get_proc_ns(file_inode(f.file));
      |                                              ^
include/linux/proc_ns.h:75:50: note: in definition of macro 'get_proc_ns'
   75 | #define get_proc_ns(inode) ((struct ns_common *)(inode)->i_private)
      |                                                  ^~~~~

Caused by commit

  1da91ea87aef ("introduce fd_file(), convert all accessors to it.")

interacting with commit

  7b9d14af8777 ("fs: allow mount namespace fd")

--=20
Cheers,
Stephen Rothwell

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 13 Sep 2024 13:27:11 +1000
Subject: [PATCH] fixe up for "introduce fd_file(), convert all accessors to=
 it."

interacting with "fs: allow mount namespace fd" from the vfs-brauner tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/namespace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 8e88938d3f19..cad6dd5db2da 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5296,13 +5296,13 @@ static struct mnt_namespace *grab_requested_mnt_ns(=
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
2.45.2


--Sig_/vJXuRdN4yvPhnKzzD_FG./j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbjslgACgkQAVBC80lX
0GxBNAf+K7uK2PSZICbtD+dSF0840bhX761imx5iH7yKbDC1bNOfgUhOZaD3/W6/
AC1mZvz+NARuaimrFCkfr/Z1K/GzGCpcsvig1jkmI/v1JurtHpRAkcmSx5++Mmu8
vDRXXjB7WFVPqXPxu0Yrzk/1B8j2ErCP3JlxWf7AeEjHtLzdyGGxI4GvetvwfEv9
jxJR/tsXWGZRYdMymlcilwTj1dp8aN3jLkhyr0lcDAl9MQVWc68e2rqgt4MdkUeN
4koTtYpZk833Az87ZHOImsdbv4eu1NthGcq6UypebqBY8/JXDsHJN33ALyaCzpwY
gJpGto/5WffbmS+Qoml3xf0VfOJ2Jw==
=TnZj
-----END PGP SIGNATURE-----

--Sig_/vJXuRdN4yvPhnKzzD_FG./j--

