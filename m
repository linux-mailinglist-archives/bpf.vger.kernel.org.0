Return-Path: <bpf+bounces-39798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CDB97779D
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 05:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814D2286E96
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 03:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236211C6893;
	Fri, 13 Sep 2024 03:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Nir4rlgq"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014C83716D;
	Fri, 13 Sep 2024 03:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726199759; cv=none; b=Ybkw3R+xB+oPCVKq6G0IQ0Zbdul3WKNBiIij7ehLLwaYxPls6qU1WSdydTIx2zFrKDoPOaA7HPMkch+4R1PVsL4I3Eg0CuLbgu4vbpbRUXMOhhXcSXsu0LNXqRKYVepBVpSELdniB5lBQ2UI62tzfrRLbo4hhZ4vp1fZMIX8jxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726199759; c=relaxed/simple;
	bh=XEf+xBWqSZosQFjsRQCHe7OPs4kOLwcwmr/7EEWmscU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=d+L4CtOeyW65BdqEQDE/V+0ZA0KLsBOGbmJ/SLCcVkef+HBCh7yJ+zYbavycs0u+0KI4kj/CxhSXH7fHEqmC27NiI8sH8+WZ3eFQYtcZ5uYkT8IqW/4IalStELqJImb422Btf9Tkhry3ZWZBuPf4myQJvAigXQWQ3vBo6dYKGNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Nir4rlgq; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1726199753;
	bh=SVVUXGwkJdQgfUdfteDebc7NB12XpEgE4fZlbLLMeoI=;
	h=Date:From:To:Cc:Subject:From;
	b=Nir4rlgqnHFqA8NozeRB0Iumduyt4/OkXNFuVSLnUksJcV5SWfZZW/a/wYvbYV3cZ
	 RXX3l/ehTFfmwKBPi0mpxFPl+kpUtDjlX0SdAALD1jIL/UOndfUskYXak4s0akFdtn
	 T7wqpocXR5lwYSIhHV7SmXO+384RsSqOXbJu6oCkWagBDWdIiR42b3HAb0GCaTj4iY
	 JVZJWJgLK3yu9PcYayaA+V5QfXO0/2oYieyuPuHklTczZZZQ2N6ImkIQM8cNNR/EUD
	 nF1pwAOShdFMMb6k8jcCRSOEPGQB7i+YUKdViIxkErdVjUWMeX1wJqG1CanHJcWlvc
	 v5xGtUTDuXz9w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X4gT41v80z4wy9;
	Fri, 13 Sep 2024 13:55:52 +1000 (AEST)
Date: Fri, 13 Sep 2024 13:55:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, David Chinner
 <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, <linux-xfs@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240913135551.4156251c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rXB2FGQB1LHlS=gzzOd7Q/.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/rXB2FGQB1LHlS=gzzOd7Q/.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

fs/xfs/xfs_exchrange.c: In function 'xfs_ioc_commit_range':
fs/xfs/xfs_exchrange.c:938:19: error: 'struct fd' has no member named 'file'
  938 |         if (!file1.file)
      |                   ^
fs/xfs/xfs_exchrange.c:940:26: error: 'struct fd' has no member named 'file'
  940 |         fxr.file1 =3D file1.file;
      |                          ^

Caused by commit

  1da91ea87aef ("introduce fd_file(), convert all accessors to it.")

interacting with commit

  398597c3ef7f ("xfs: introduce new file range commit ioctls")

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 13 Sep 2024 13:53:35 +1000
Subject: [PATCH] fix up 3 for "introduce fd_file(), convert all accessors to
 it."

interacting with commit "xfs: introduce new file range commit ioctls"
from the xfs tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/xfs/xfs_exchrange.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
index 39fe02a8deac..75cb53f090d1 100644
--- a/fs/xfs/xfs_exchrange.c
+++ b/fs/xfs/xfs_exchrange.c
@@ -935,9 +935,9 @@ xfs_ioc_commit_range(
 	fxr.file2_ctime.tv_nsec	=3D kern_f->file2_ctime_nsec;
=20
 	file1 =3D fdget(args.file1_fd);
-	if (!file1.file)
+	if (fd_empty(file1))
 		return -EBADF;
-	fxr.file1 =3D file1.file;
+	fxr.file1 =3D fd_file(file1);
=20
 	error =3D xfs_exchange_range(&fxr);
 	fdput(file1);
--=20
2.45.2

--=20
Cheers,
Stephen Rothwell

--Sig_/rXB2FGQB1LHlS=gzzOd7Q/.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbjt8cACgkQAVBC80lX
0GyDNAf+LQQb+QL9TMZKMLzFxlsmKmHfGwNU9a4yhYswnkWHszjKPEzU8wZlkjcK
MUk0qywdEGYTO8Qvk9d9/ZJLtvUVp5eLS6mH4637OGAB5JrgPF3rHFujLaMNQXmg
6lRXcz2YL1GGwPr/RZjey7AcBWz93hUEbKccCnJ8Sm1wGNwDOmw4Rab/A/ybHrZh
a4omj+z+MnjtckezzzwTwbmVmmD7mKOf6RZC242PF1hPjvMV//wYJ9B/Odw/nU+Q
OVtCAtFidN1hR1avssCcsPqnmsRzrm1o1E8WydakC++DPqld3S/AU0rhAI/ehORG
wxJgS9CDBGYAytFOombExKjZYAfp3w==
=wx01
-----END PGP SIGNATURE-----

--Sig_/rXB2FGQB1LHlS=gzzOd7Q/.--

