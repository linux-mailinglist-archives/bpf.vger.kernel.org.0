Return-Path: <bpf+bounces-20155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F6C839E15
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 02:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DBC1C225A9
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 01:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5BE15AB;
	Wed, 24 Jan 2024 01:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iFn+xfyu"
X-Original-To: bpf@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D91710EF;
	Wed, 24 Jan 2024 01:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058974; cv=none; b=Nxg9a2W2+7GTNNGYxM2k2la0DHGpwXEnWSiPzOF23KrjRy1A0R7ntupk5bZRooa7JHAWrf4kVe4gHFEMNF2o/hkh1UyjsQxOCabpuQaad6jNK01xdjNG9hnr6wRNKP2q6ZGc76YcOzxN2/PXl1sO6UjTwgx67L9vc+7vGuCHeew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058974; c=relaxed/simple;
	bh=wRseWmJPXz7aqNO/ctjSMnoJYjhzaRL5IflagLmEnQE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oxxZDGHaRN/S8NKIDTjWEqWC6Y1VvJro9mi1SLaRkq/jxG03KoR6Pd5sJ1YQ6UwZrnXxMDSCEauKN4xXSvCJaElVDLMClaan/99an0nBnFEktEgtI1+tjRFBMm6P+IVECCxoVylCDP8YXLfL4WYG8Wvi3Kt8opUiSMDfG6BNja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=iFn+xfyu; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706058967;
	bh=IzCdaQPRMP0/kNniT6G5izBxADuefXsXFjHRaSBV0zI=;
	h=Date:From:To:Cc:Subject:From;
	b=iFn+xfyuznGV+LTDi85MMQbc4VR5C9tq8qyc9ATaoqinIz5e6EyqS9M0GW7jI3TjF
	 1HvU7pX/a0Z9T9EW+oG6cZd0y4ILXqKen880XUimDZ7S+rYURjvKuOGG6RTOe3YfHu
	 vGMvKM7CesppNsu8oyuPCSapA5Rv+9PDW+n0ca7YJcFVwrKVbLyOREHe3uChTdulTX
	 RGbpY8nOQkt/+lcA6fvny363eRyQXv8ee45Dgc5/6BV2X7EAII1+M23coHrV8Qccai
	 eleu1nHB16kwbcfOMhZGvxyrP8Cvf25YqCvqO8NV/o4LJdtvTArpUNLGyARsvSQecW
	 wNAge6947xv3A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TKQyH01wyz4wcK;
	Wed, 24 Jan 2024 12:16:06 +1100 (AEDT)
Date: Wed, 24 Jan 2024 12:16:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the mm tree
Message-ID: <20240124121605.1c4cc5bc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bcC3kCdxM15K5zgImia09FZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/bcC3kCdxM15K5zgImia09FZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/testing/selftests/bpf/README.rst

between commit:

  0d57063bef1b ("selftests/bpf: update LLVM Phabricator links")

from the mm-nonmm-unstable branch of the mm tree and commit:

  f067074bafd5 ("selftests/bpf: Update LLVM Phabricator links")

from the bpf-next tree.

I fixed it up (the latter has one more digit in a SHA1 in a URL, so
I used that) and can carry the fix as necessary. This is now fixed as
far as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/bcC3kCdxM15K5zgImia09FZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWwZNUACgkQAVBC80lX
0GyyUQf/d5uTmSG4zpZtl0z6FSlZCyVLnwvSa5t84gqsWZCuk1cq+lMpzA0ue/iL
NMOcXYIvG5/vQuEqpG+PrFgfUnml//o+kSF6Nxlt+wLWtmAFKx2ZNu5jZgpNeobw
Pjm8MC3a9rGwia18M2FOdsEhmJkxYY/aecL6m0mf5mzO66hComaT06uLgxwnM47v
hQh61L+/7nZGnsVnNnNpO76wNhzSovyY+rc2AdlhnSImADQ/u6OhG2rdRYJRd7aU
Tyj4igaSDU1aUqwSW/asV40HhVdqdQF65teBEWrNi/ixS2y8W8/Kz9i1LsBZJ7iU
Eqm+If5a/YttmwLJU3STXSyEx7djfA==
=a589
-----END PGP SIGNATURE-----

--Sig_/bcC3kCdxM15K5zgImia09FZ--

