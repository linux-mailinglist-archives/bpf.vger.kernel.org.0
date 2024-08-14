Return-Path: <bpf+bounces-37133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C881D951142
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 02:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074621C229E3
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 00:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CDFAD49;
	Wed, 14 Aug 2024 00:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PCjWXKf8"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CBD631;
	Wed, 14 Aug 2024 00:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723596999; cv=none; b=B9tH9j2vc4XMi8rkaS/o6y+S05i1269SmP+6HG5dKubadggmrC4yThjY8h2ttsIU3RoBEglrj2n0pQeLXdlTSaawdUWd0FnDLuM35ImG+avxZ42xC8vy4tUZbhiB2N6unifVbBtpMwzZCvWez2eZbStDIxze+mRkWyphO0KdMLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723596999; c=relaxed/simple;
	bh=s26VK5D6rODby0hbFOsWZfmhFOFicsXVKPbKZHObdho=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=a5rXGD7u7vie44fN7AnC2t2JgMc9GCvuIvpNE7VcWTkoIaLhWhBecLV5EXWdV4TMuR3/K1Oqm6gc3GEYoGsKmoVDSQj+mFl1GrD5e/0/tCHyYUGSvlCk9CkG9qYq6wChEjhEpPIpkhSF+ZEpNPU7V/zE3uFyapHitmXNbaKO1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=PCjWXKf8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1723596991;
	bh=jL3EW3LeDBnw+HJN4rMqLHVzMyLEnU32IiLBXSRaqmg=;
	h=Date:From:To:Cc:Subject:From;
	b=PCjWXKf8XQuJ5dIfxLhVe6CgH7OOGst9IJghwBvyuGhZQen02Fea98d7uGib7Ddsy
	 sQJit2pjjfbJz6GTlgVK01nIZsiFe7GNchIuXl5lu2dRJTKiR06Y3G9LVRW0yaR+8z
	 vFoCj1rSY0OPWQiID+Dom447lAgMQqaVssi+eDBUrf8BKITniJ63nzAhhHfbIcKLtD
	 sY9MJt4eoRuEoUN6MpT6BcPiCLbIHxvlp7hRrGR+RXibQfBSznWxB46dBV/+J+DU1/
	 jzULu7wUGOd7/TJwMkwyvcohjdEK+N/T1uvbLDRulim/eoCEczVgQzvhgiHaT/fT7F
	 2s1C+M7+UlTtA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wk8vy4hwKz4x2g;
	Wed, 14 Aug 2024 10:56:30 +1000 (AEST)
Date: Wed, 14 Aug 2024 10:56:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Aleksa Sarai <cyphar@cyphar.com>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the vfs-brauner
 tree
Message-ID: <20240814105629.0ad9631b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/y.4N6Ob3DH9QvXRaBKCbT3J";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/y.4N6Ob3DH9QvXRaBKCbT3J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  fs/coda/inode.c

between commit:

  626c2be9822d ("coda: use param->file for FSCONFIG_SET_FD")

from the vfs-brauner tree and commit:

  1da91ea87aef ("introduce fd_file(), convert all accessors to it.")

from the bpf-next tree.

I fixed it up (the former removed the code modified by the latter, so I
used the former) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/y.4N6Ob3DH9QvXRaBKCbT3J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAma8AL0ACgkQAVBC80lX
0GwhuQf8DgEk5BrDWaRWIzqw39VULj1hSejMHDxHAwBCxv8MGhqU2SGEUgz36a1q
WVev+yjnDD9EocyN2Nyc+rhvrdRUYwgqDuV5UUa23hNJzMa1SlWD0Zr+9z1NrPSp
lIRaGC5QjW2vrbE0TL8lgssFxnhxNlb3yOtRKQfbv2t5xbbqUGWRqvAF1eBcZUD0
1VXwt0S/qs8I3aFSq6dVzu3wEkXN05Orn0uOsUcVyocyAkdrRMEWwmxHxd9bWwkM
8Wej1TMEv8ueBcc6dTzrgmJXVlxEq18P2D7bcanjhEPSbl382cy83a2XNMfc5Cnh
ampwRYz2FVFRUrseRh2YzPoRDTxyLw==
=NGE0
-----END PGP SIGNATURE-----

--Sig_/y.4N6Ob3DH9QvXRaBKCbT3J--

