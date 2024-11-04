Return-Path: <bpf+bounces-43861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56779BAA0C
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 01:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130DF1C20B07
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 00:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424C770816;
	Mon,  4 Nov 2024 00:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WClie5S3"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A40A2B9B9;
	Mon,  4 Nov 2024 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730681975; cv=none; b=QpaMwWbZi/HUL5V/OFjpVNVkKOLI8dSFn6crds2SZl9wXjDSlBmJu1TAxW6NnLiH6Ko9n3FZIa3PINmYE9sBPDJ1Psn57w+ICZh9DmqW6LgyDURN/9BvZgYypHxk137D/QCQeu4YXF684tQoyhkD53X1ZiyEJ2d82n3btNSYe3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730681975; c=relaxed/simple;
	bh=mCmkE4KC0S6H3ElFbSOdrrAUl+RGfHoqDfh7iIUGvtU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LdYGH1ctyj2CQgICQBufhX57fstG8zsVduIq0r8ge/GsYzwbI3vmIbJhe6PUK/hxBVUtpUjDOYUqqUSTFOV+qmhkEteqW3LxjsekMeA1/Lzbtqvs9V0hxSqq9XPc4/SPDDYZlxEmxW9zbU0ysLCbw3HycekX8/A8sEAesbE+DG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=WClie5S3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1730681964;
	bh=f/sR8dnm/aLqRzOQCfDkA3QQgE4vsYwa9jg/D8Glbp8=;
	h=Date:From:To:Cc:Subject:From;
	b=WClie5S3oIjdW+eX3M6bZIu2TfI+d38iyfapqTrjR8iFAmaiI2aqpk7fjDyKiBuNo
	 AybNsGLZD6B/qJpe9EbcpADRCt15jd27WGykhLgB6z8LIi2jEIi/xUarLMkC0j8Enj
	 XZVyHe64RI7AC0inxEZf0t4BXXCH44AYfG7w2mvupQWQXhpdiKJVmB2Gc9ofKVPIbJ
	 3Ut+hJURpwFjQeJJFNWnln/jZEd6Xrl34oaEtGvYiKTdyIZAyZ6hxq7/ZOhb4AP/0q
	 AQ2tmr2a8ucyLMPcTj7LP4W9frvVGu88jTyjHq0wr7JuVmA9ZdOglsY+Fetx63G+Do
	 5POthf4HvBIAA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XhY5R1vhZz4x3p;
	Mon,  4 Nov 2024 11:59:22 +1100 (AEDT)
Date: Mon, 4 Nov 2024 11:59:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the net-next
 tree
Message-ID: <20241104115924.2615858f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eTZL+obPJQ99AGrfxDS_OJU";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/eTZL+obPJQ99AGrfxDS_OJU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/testing/selftests/bpf/Makefile

between commit:

  cbf49bed6a8c ("Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/bpf/bpf-next")

from the net-next tree and commit:

  34419b2def88 ("Merge branch 'bpf-next/master' into for-next")

from the bpf-next tree.

The former reordered and reformatted a list.

I fixed it up (I used the former) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/eTZL+obPJQ99AGrfxDS_OJU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcoHGwACgkQAVBC80lX
0GxMIAf/VpUaLcRN2iwlrlEagMya7GmnS18kOgrDeiPVkyiSnzsVwhgE2MzOFzvi
Bh4/jjC4HHoNAwhqJuaivUzGkqoltv+qIuiDRaJgVvvYiTNSQrOjZxHqNYhFIGis
++zC7DlxPDtSZRasbm0QVCk7Kdy91SuOA6Z/7kkqqQOZGrMQ7i1we+hr02EsqaTX
cwT2M6rIUSyqQEtX0FYY8VI/vFtyDGmNY/CI/lNNKWLZiCkhHosGubbhVSK83aNB
su6jXDEavgjIsUqpLKWlKV6aUb39fn1111omT/O9gWxoCS6b37T5UVx2nAh94dRB
ijVFrX5iLx01XJ66Qzx77uSgygj7Qw==
=cQNc
-----END PGP SIGNATURE-----

--Sig_/eTZL+obPJQ99AGrfxDS_OJU--

