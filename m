Return-Path: <bpf+bounces-34610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D764A92F2F7
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 02:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFF61F2327E
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 00:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033011FBA;
	Fri, 12 Jul 2024 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lVjESjg4"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80200621;
	Fri, 12 Jul 2024 00:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720743439; cv=none; b=me/cEs+RTpCNMMOcQAslji3F2mbjcf/tH3wxvYihJ0J6Sbg3VEEyLYnJBf/POlVfGa78jUmMSyEhk2klJWIOqBRHiFwaIv4lGCuV4+SepaRZV6ysEwjt58kHGcv3F48PzJsAW0ywYiRt7BJzbTQDyApGjDkxxe9JndNRdQQuAQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720743439; c=relaxed/simple;
	bh=n+l8j3zXDVmrCyjD/AKm3cdf3Dekt08k92V5tenRSow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2uQtKcBNeKXH7vabHx6J4c/iVHb6xB8+Jn7MltXbQVElsaKVMYM1KmXJNuZnTG/IMjpTZq4SUzBeWw64+BmbQQMQ2IaalOgixCXTwVkrShhBeY23rn4yU9Qf8Rft60ofZCdTBAnWZO0MRB6dDe7oheHIIuFX9n/onSBic5YWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lVjESjg4; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1720743433;
	bh=Bw03T/wXA3hX+oFkbo08Y3OH9ztHLzh+baF8k8tN74Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lVjESjg4k6s1GG2NZLeADAtRJPYJdUw+Yf8zh1lze6ptbQlTpQf18j030KIYVqfBi
	 aAimcdiirfc74mMKqPHF+3sihskpvyvJd0M1bmlEwF9kuW+FBQXI1/fgVjJ13wF2Kt
	 5ph5kHLiO/TfhsyZdeoSOJOfat3fp4BzS/k0mWDyxHfgL35zYt2lDCrPhWQ70o3BEq
	 61Gxa8q6Mxl8/MU6nLiSGkwAUcNSVUSyKPtXFPKcg25/bcv/DsLVMcSeCYmN3o0ntj
	 IzUMO4DybGC4Eia2o4Fr3tad+gqGKNpYMNjINKfWVlX3zHzPO5rmIduILjlyay7v48
	 05hea2m4NWf3w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WKsbr3pxSz4wxs;
	Fri, 12 Jul 2024 10:17:12 +1000 (AEST)
Date: Fri, 12 Jul 2024 10:17:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the bpf-next tree
Message-ID: <20240712101711.272eda17@canb.auug.org.au>
In-Reply-To: <CAADnVQKVC4NGsEU0X3XJmmCot40Vvik-9KNFU07F=VBF-4UVRQ@mail.gmail.com>
References: <20240712083603.10cbdec3@canb.auug.org.au>
	<CAADnVQKVC4NGsEU0X3XJmmCot40Vvik-9KNFU07F=VBF-4UVRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lBVNIj918H/bfEVTwa/d5bZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/lBVNIj918H/bfEVTwa/d5bZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Thu, 11 Jul 2024 16:51:28 -0700 Alexei Starovoitov <alexei.starovoitov@g=
mail.com> wrote:
>
> Argh.
> So the fix was applied to bpf-next back in May and the same people
> come back to complain in July that it's somehow still broken and must be
> fixed in Linus's tree.
> So the new patch was applied to bpf and pulled to net
> and on the way to Linus now.
>=20
> We will ffwd bpf-next in a day or so, if git cannot handle it,
> we will revert from bpf-next.

Don't bother, it is not causing any conflicts.  Occasional duplicates
like this are not really a problem.  I report them just in case they
were done in error.

--=20
Cheers,
Stephen Rothwell

--Sig_/lBVNIj918H/bfEVTwa/d5bZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaQdgcACgkQAVBC80lX
0GzBiQf/W+jGo/+m8c27dNIUHQUGYmS9UmptbTzzgDyglqx89/bMp8rfDmkrUgM/
ULhUhLmPilTJOnOb3lz7kdyTPNFsSFSFPm2KsvZqg5pRwcPsZ0sKv999IoLoFwIN
jzvxJbW2Uz+YUEedLxLhBuCgZChj9t5ujx2gY4sdzSduyYAHzS9J8cjs9c2rf2P3
Prz4JudqiXoeS40dfwCk+2xKqQI0cWXFYIqrlt5uMjClsU8dm8+S+u9Qvh++lT9A
HNfCQQlPAMKAnRl6YMu7814GRaTuG8sC8aDMPTua8P8ffG7L7gDYgy/AekybGlBL
zCUv/M7VYrxb/Kz3an5gmVMJV8BHJw==
=vcnk
-----END PGP SIGNATURE-----

--Sig_/lBVNIj918H/bfEVTwa/d5bZ--

