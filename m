Return-Path: <bpf+bounces-54360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 364E0A683B8
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 04:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A50179E1C
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 03:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB1C24EA9A;
	Wed, 19 Mar 2025 03:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GPnbqtPC"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F952C9A;
	Wed, 19 Mar 2025 03:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742354962; cv=none; b=EPqOgWcQ2AgKV8h9y5WVEvzybnSpIkJfY7gwOM29yklNFyBgJV5cRVJVx3jjqgHBsmirSpJqkII+cYxxMqGQUnCVYZossR+epmjSG8pqP4onY8fKG1cf4vf+sNpJf8MntmHji5IMvvGMYnMSbdd6iihtENne8NMqxsY6B9GQHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742354962; c=relaxed/simple;
	bh=yixH79nzV5SukJr4oLn6BIm0JyYNUponYIuxik4xeAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8cvdMs9EeVv/GX6igOEnc2ks2XYBsbeLuDd+mId4NwBrdZaJJJP6AhRe0Hr0lsxpFIpxDwITD9+435urv4slOeD7eD8qaFTlsU77lQUjENb+vLti7YRs+mDJukrXp9zdUSgZ24+YK4nDF/qtDS4HqB6dlAdUm3PkYpe4gLiuJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=GPnbqtPC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1742354954;
	bh=dznLdSdOJ6Kn7aI90N3XVX6/Rk2l5EKH8sSqpI3uMuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GPnbqtPCz+mhNnmnD7SIn4Xu+hQEQWkLLReQGoVmoPG0ANvK6gq/GUYMWd2O3/8rQ
	 BvtfUclUnHxbKMoiC1FqtSN0bfF+HFnvlI7pssySC+zp0FwpNoNbEKDeRNLtnnZqZv
	 sN+Ghoe7NW2FvUg1KSAkYB3P8nBpdcwLFwdfrOWlByuERxbxhJRmUWGHalf51ba853
	 bX8dsppac1DQDD0QziF1yZgE3fd7uYKcLIe+oizXUDRay9ANSeIkTOZuxGOoCHy+0S
	 dmCwlbMjME3xvOivRFcEv1O46531ESBG0KMpoBTGLIrM5E/V4s5EndZy1X/OIeJRas
	 oOF3DcWxRwjyA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZHZ223xt6z4wcT;
	Wed, 19 Mar 2025 14:29:14 +1100 (AEDT)
Date: Wed, 19 Mar 2025 14:28:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Uros Bizjak <ubizjak@gmail.com>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20250319142829.1dabd7b9@canb.auug.org.au>
In-Reply-To: <CAADnVQKotSrp8CkVpFw-y800NJ_R7An-iw-twrQZaOdYUeRtqQ@mail.gmail.com>
References: <20250319133309.6fce6404@canb.auug.org.au>
	<CAADnVQKotSrp8CkVpFw-y800NJ_R7An-iw-twrQZaOdYUeRtqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IDNOidSBs28tcVU.pAzxLe1";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/IDNOidSBs28tcVU.pAzxLe1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Tue, 18 Mar 2025 19:46:52 -0700 Alexei Starovoitov <alexei.starovoitov@g=
mail.com> wrote:
>
> > Caused by the resilient-queued-spin-lock branch of the bpf-next tree
> > interacting with the "Enable strict percpu address space checks" series
> > form the mm-stable tree. =20
>=20
> Do you mean this set:
> https://lore.kernel.org/all/20250127160709.80604-1-ubizjak@gmail.com/

Yes.  Also available as commits up to commit

 6a367577153a ("percpu/x86: enable strict percpu checks via named AS qualif=
iers")

in the mm-stable branch of the mm tree
(git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm#mm-stable) and
yesterday's linux-next tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/IDNOidSBs28tcVU.pAzxLe1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmfaOd0ACgkQAVBC80lX
0GxC9ggAozjI+xDE1SXkYAXd+bUykzAfIdlk55eVdb8K48i53hMnUTOrCwDHAvhT
rt0/gy69ZajdxHM/c4lMvbJtbja+vRRtLQ0JVkd0tTAmDbGk2mUXsOuFfM7QclEn
HTSAZ0cS9LEKYD/edWW1W+8PQfa/dA4Y3EuqeBRFVkpDuBBG4Ud1x30YqEBRL8Kd
NXCBTEI6ShTtqiifKGfyFR8R7lcaifV4d02JfQs69jYI/SelCGwueOQ20cnIBr7d
pHNtowms/7bGk2sMcy3gJ2IHOLBIarZfR7HYEucJhZsd/6MNyvVaq4j0xG93p/8h
7ixXXIqWn1yjQx2yvdKxxJyF1TGt0Q==
=KO9M
-----END PGP SIGNATURE-----

--Sig_/IDNOidSBs28tcVU.pAzxLe1--

