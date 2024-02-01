Return-Path: <bpf+bounces-20914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20DF84507C
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662DB1F22C82
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD3B3C067;
	Thu,  1 Feb 2024 04:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PJ00XLhD"
X-Original-To: bpf@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6B538DE1;
	Thu,  1 Feb 2024 04:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762856; cv=none; b=tPZDP9A1aUTYyhahdZnGqAlGJwfOVtsX0Zz9oaHyAxPENEd9QlqBF5R2nUlzRnq9vAns9sP/hx/CjnTt30V0bg2xoRzqdW0LqmLA+XaPV38H44X3J+DX7ZqngSE/gg1xKoH/y+wWI68lR654kS0VDD6AfdJi0YID3g0wNwvWNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762856; c=relaxed/simple;
	bh=TO5EoA5D34t9gL56uly/Y17i1sqa2TP9ujAaDNI3dUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/Izw51tTuCCyix6d/aJVAJaNIrVv8K6KX5PLO0nBMIdQlQFDR7rHPnMDzs7v1dTJsHNOnlH3j/+uuWACTfN3+Y20WNFq7MYcAGLwlg1UbjoeebFLysyozyTi9Vpk7exMugbeBxvkvCmrB8gdy04pW0DuRlYxdnk0dR8ozUjhzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=PJ00XLhD; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706762849;
	bh=TO5EoA5D34t9gL56uly/Y17i1sqa2TP9ujAaDNI3dUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PJ00XLhDIgZPSO3B5zSUPYBpGdHLpkqei/mzpkLVeW5gCLR9YM/rSJNzIlOE8SULe
	 MryzVypOej3qNiBMgMOC5uqvXWUsu6oQd0ucItu6s9mrIgPFHmU88oY1PgcIe1vwlT
	 zDM8BUjU3uzlUEo+LvaLndpWjK/QqhO/eXyUPrbJpR2pUdqMcyP5H1flZAqBqr02hf
	 H8Y1ZSfwtMfBc4N5bi7AVLoMr8S60M2WAh5b2yTXEUnXsL0iV70xNJ6wZ1dTH1PvEG
	 ydIk6ztKhSYQTWY7zgunBQpwq0UZsBLymMTEDWR1GbMoqVudTBeIv32ftG9oVnVcDP
	 xsAg/zfCo0m4w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TQRGT4LwDz4x5K;
	Thu,  1 Feb 2024 15:47:29 +1100 (AEDT)
Date: Thu, 1 Feb 2024 15:47:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: runtime warnings after merge of the bpf-next tree
Message-ID: <20240201154727.6dff97a1@canb.auug.org.au>
In-Reply-To: <CAADnVQLGZFf64X+HinDzCkVxzhB0ja62aMSeMG7Lm0=KLd977g@mail.gmail.com>
References: <20240201142348.38ac52d5@canb.auug.org.au>
	<CAADnVQLGZFf64X+HinDzCkVxzhB0ja62aMSeMG7Lm0=KLd977g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/q69lYkRZLZHjA3cPQ7CUxDU";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/q69lYkRZLZHjA3cPQ7CUxDU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Wed, 31 Jan 2024 19:55:01 -0800 Alexei Starovoitov <alexei.starovoitov@g=
mail.com> wrote:
>
> On Wed, Jan 31, 2024 at 7:23=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.o=
rg.au> wrote:
> >
> > After merging the bpf-next tree, today's linux-next build (powerpc
> > pseries_le_defconfig) produced these runtime warnings in my qemu boot
> > tests: =20
>=20
> le - little endian?

Yes.

> Do you see this on other architectures or powerpr_le only?

I only do qemu boot tests on powerpc le, sorry.

--=20
Cheers,
Stephen Rothwell

--Sig_/q69lYkRZLZHjA3cPQ7CUxDU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW7Il8ACgkQAVBC80lX
0GySmgf/es4uAQiBgmiHmyiELu8GssMwzoSJ/D3tvPYhcNymcUWsbHAtGlUL7t/M
lWibW4wmfmT7MK16C+J9Okr524vqGYoQkTIgdYdFYDXIDifADd4uNvGCjpwtwd8A
kL+OFWZIFqnAa7BZaGBCPRt6CTta/DHOCeam0qfJkOyoK9RsC84k6PoZhTkH8tvQ
HA0NbLBuWp+0I1fEPFhEqK+9Jlv+mKoOGeMvPEMDLbKetC3XM8EAliNuZRJMOvPn
tnwW7snK8bzlbXJCEmE+bzISCjIJid9sg6CfP7qdk3ubwc8iGgytcJ2YTH/vAc30
HXGaq8K59I5lECw8F729H9ac0gX//Q==
=ixwz
-----END PGP SIGNATURE-----

--Sig_/q69lYkRZLZHjA3cPQ7CUxDU--

