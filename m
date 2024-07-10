Return-Path: <bpf+bounces-34351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8BF92C91F
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 05:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B5F1F240B8
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 03:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F5A381AD;
	Wed, 10 Jul 2024 03:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="doDKRHqV"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3888034545;
	Wed, 10 Jul 2024 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720582002; cv=none; b=IEYYwnG+7XiUQT4DImYxSBmMOU0BIQyzmgx61cTe6cZM15dIXhOUSywNeGR3HGYG575Bv6XCnzVdg/veRlMNdf4pQHqQmhnOW3e10XwYYRk4zPQiHfFSSTEOgn/8QMKLoHP9xk5qUxsbg448rrkUEZgRVeJkMJVUKvSyFIOfum8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720582002; c=relaxed/simple;
	bh=aeqJOl5Yl0RUvum8cHOjzEIUVNycs/Tpazowq47HRV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrG0vicSo7wKFk/IANukoDd0u2iMQTy+K8H1FdywpZs4bkUea9kuRACR3pTQcRkPpD19CinHVj6JGiB/fps5+Hkn+d8eKF8KfTbLAVBOLPtzj2eB/cMuE6cz/DemaTUYZ3R8hI/Sq4xCsO85ehD7uXhD9421+p26b2LWPnHRubY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=doDKRHqV; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1720581995;
	bh=bxCCY4MP0XLcRCW/XoCR+a4wcMvC/waROLeyouNvbag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=doDKRHqV/BAhZKcssS/Z2OGsWP+TiQ+YqiIHgIHqjuEYJojIvho3twX4b5FEFB3TJ
	 t82Zw2T2P3Zcpg7DL3LtdQb+f1QqQLprmQ5jQyH1MyoensE5n07WEeWvFESOfvuL7c
	 M1krt9nRib9YAV238uQchzUhx3ELGNtb+kX7fUci9MZ4hg1yIUNeWx7cxK8pcw61Ny
	 x6j5kgXKIWNV6UdBpO/54SUWHW1631KzqvjBgZQqIl2P990Vqm3OOJfNDD/TeBKz5e
	 WteL6ebh2cFUccdQgl/Afe72pe9/lgnlKeDhQtkXd6lb3ghRK4VnjWugYZlD41VmLD
	 jOt6FLZeRjmYQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WJjvC2p47z4w2M;
	Wed, 10 Jul 2024 13:26:30 +1000 (AEST)
Date: Wed, 10 Jul 2024 13:26:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>, Pu
 Lehui <pulehui@huawei.com>, Samuel Holland <samuel.holland@sifive.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the risc-v
 tree
Message-ID: <20240710132629.781c55e4@canb.auug.org.au>
In-Reply-To: <20240702113350.064e4cf2@canb.auug.org.au>
References: <20240702113350.064e4cf2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8KjxN1GIrCEjWs4920ztDGg";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/8KjxN1GIrCEjWs4920ztDGg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 2 Jul 2024 11:33:50 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the bpf-next tree got a conflict in:
>=20
>   arch/riscv/net/bpf_jit_comp64.c
>=20
> between commit:
>=20
>   51781ce8f448 ("riscv: Pass patch_text() the length in bytes")
>=20
> from the risc-v tree and commit:
>=20
>   9f1e16fb1fc9 ("riscv, bpf: Fix out-of-bounds issue when preparing tramp=
oline image")
>=20
> from the bpf-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/riscv/net/bpf_jit_comp64.c
> index 7a34e5b44fc4,351e1484205e..000000000000
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@@ -16,7 -16,8 +16,9 @@@
>   #include "bpf_jit.h"
>  =20
>   #define RV_FENTRY_NINSNS 2
>  +#define RV_FENTRY_NBYTES (RV_FENTRY_NINSNS * 4)
> + /* imm that allows emit_imm to emit max count insns */
> + #define RV_MAX_COUNT_IMM 0x7FFF7FF7FF7FF7FF
>  =20
>   #define RV_REG_TCC RV_REG_A6
>   #define RV_REG_TCC_SAVED RV_REG_S6 /* Store A6 in S6 if program do call=
s */

This is now a conflict between the risc-v tree and the net-next tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/8KjxN1GIrCEjWs4920ztDGg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaN/2UACgkQAVBC80lX
0GxP8gf+ObtQabtoR5ITWclxezEcTHCn5ST/fPMlmAlOvDok4XYq7HMa3aUNdC+T
WpFlY7p1WBBVXmS/bUBkxXBALN0gC78BA8OsxtNN21fwAcZp1BnfJyF++Dnwjnh/
+9EzX6rdlei2O7ZkqLo6GsCDySiT7voha5Dja4OdRdjnZJzS1y6qotaFNQmh+5TS
qkTIHaZEkKNjBj+L+rTtPRyQP4BaBpcEaFn/cWMXt2S0w3X8QstsxJ0MofcwfDOh
2eER+DSyNSUKZ6aOIvdjTOJJxVVZ+Ys4ljdFgNu52sW6MHaR3KtWAT+8wnt3UQJp
sDH5NKL4gsST4k58OkxzqQ3DlXI9+Q==
=2Zgm
-----END PGP SIGNATURE-----

--Sig_/8KjxN1GIrCEjWs4920ztDGg--

