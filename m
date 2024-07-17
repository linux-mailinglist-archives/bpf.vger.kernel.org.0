Return-Path: <bpf+bounces-34971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE67934523
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 01:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3C71C216AC
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 23:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE4C6D1C1;
	Wed, 17 Jul 2024 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Z+LnhLwo"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03555897;
	Wed, 17 Jul 2024 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721260101; cv=none; b=sZSGlyGK5QmvL/+I+gIa/I44Pj6wWURxIJgjzBTsPx5XL1q2vYYUMsKmMBPufrfp+ZPpwnPS+hK5jkLhxViNLkoAk5XR8sNX/RXapN4UdEbGS5OYCBH6t3H1uFZzOJQQVVe9QXHIzDo6tCCrv+Oss+u7F87aUyurDSp5PzWh8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721260101; c=relaxed/simple;
	bh=1xM6sGc3THq9UwwqYh2wtOPw+njKI8xk017U/N0tMTs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qM7iZ2gi5iMx9sOvWMEZvHothJKkMOE+xIVwjZJad4P5KgAflVHlQbkitxQaoj7BY3gefKz3uwddcUvUzNcPItYCPxOzWlXogaKV6iRmPqkeD9FK2q7dJH1oSsY5iQX/cQOGjAXwJpOee58VSjD4ao3vbSo06S0hIzs5RUrIpJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Z+LnhLwo; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1721260090;
	bh=ceg7+ctfX7CD3PPYZQGMs9DNxj+fO0JSKmVo/H/Im/8=;
	h=Date:From:To:Cc:Subject:From;
	b=Z+LnhLwo808NiwJmP1eBRbgeDCtktY3rGl8H2mg+Mloun5AZGZdQDzEqnlfLyLVyR
	 UgdhGBc4qOdGSHudCdNm3IEJTTvdtsfaM3DoW8b+k0lr36WziccZxWu9e93t8dLUPp
	 BwFB07IAvey6HvoxHr2r/zHi/86oYSgMLADmtZpva6sB/kYRUQ9yczROAX90jUT4SB
	 pSzkDeQW9jk1EhTcEvevEyswE10cOCg6VA7FZswoRHHkSVEiTN3J1ulv+GWbBpOKX1
	 0Lb3MOa2D0pRd9QezpksHFp9NzaKboymq8fNqMM17harrqxyN1SW4VWKiXDD27enLI
	 jVnv8zIpFD4Rg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WPXgZ1Vlcz4w2F;
	Thu, 18 Jul 2024 09:48:10 +1000 (AEST)
Date: Thu, 18 Jul 2024 09:48:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>
Cc: Naveen N Rao <naveen@kernel.org>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the powerpc tree with the bpf tree
Message-ID: <20240718094809.204e67dc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sp3SdhcSw_c+G=ot+UMWlot";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/sp3SdhcSw_c+G=ot+UMWlot
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  MAINTAINERS

between commit:

  c638b130e83e ("MAINTAINERS: Update powerpc BPF JIT maintainers")

from the bpf tree and commit:

  e8061392ee09 ("MAINTAINERS: Update powerpc BPF JIT maintainers")

from the powerpc tree.

I fixed it up (I arbitrarily chose the latter version) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/sp3SdhcSw_c+G=ot+UMWlot
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaYWDkACgkQAVBC80lX
0GxyAAf+JmnNzyxJbGRCHXcF0wckEuwkJwYHSRsrKK0g7taq502Z4jbJzqz7luvC
TROzcPrg8XWIA+M37pkKfwT8mYaSfL3GwwR+p3cZEf2s0pqpqkDTcrpsIj70/rHw
zj/T43/aX2yXSV3TzuZXTI2kwqSTNx5WSnQZ+FNjSMn0NwlUX7oi36xjjs+3wwAZ
9Ut8rdlUuEUBlJt5cmZJX6mfFrbfz7GwG9pY7XvzjxDwH1HtP3d3MROs/DuPq48L
7dIuFZoC3IHbNrxpUpUKT+rS/xweyVrQuWiyAAmlJokziK4hy45iwz58WVdaHk8c
hkSCu04Fnpf0tbNtyojvzKjfTHkuWg==
=NjXF
-----END PGP SIGNATURE-----

--Sig_/sp3SdhcSw_c+G=ot+UMWlot--

