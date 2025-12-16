Return-Path: <bpf+bounces-76652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C8BCC0733
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D2CE301CD3E
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 01:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25597274B37;
	Tue, 16 Dec 2025 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jMPVFjfr"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76326CE0A;
	Tue, 16 Dec 2025 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765848322; cv=none; b=fFcMPoeO1Rrw7ZX0YgKam2X9RLrv166+oyG8RHg1usIDsWEiyiXGr3bNNgl9HVKl33xgyWQYmNdPHGNg30RpAy4iT/pAVQJUadEUi4fO41Jn4od2CzbXpOfIZtazJUjgCIQDIB8lQItDGHZz1O1Buiy9DjP5/58LqsRyzKIIHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765848322; c=relaxed/simple;
	bh=3zSPmz/NCkE7wWGBlwPS2JqQRbZqsgUd+xF3nDaHKA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqzDIQGL64E59irC6MGubLMKDGt/GH8RUPYv0ArKZA6Jf7je2jIVXFZAc8YDDIh42AFcH9ZHDUqrMVI3BEDuv+g3AYpR8c5X76mEOrOrsQYOImiznRvp3N3ObA/BiR6Fx2ouOkb6qHTl3SJjznANOms8mtag5/0Q3nqrBp7CgO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=jMPVFjfr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1765848317;
	bh=0plY8aRXrmAzEnRYdeWviS9sqQo6p5zP5wPOiczpzbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jMPVFjfrFR+MtukDfHy7Qw4juRI0EqSXNyoaQ/soObaLLCnEbK679LqGLWFCUB8Ub
	 587xYIhje4IAUflSFydVt6rDw13De8l4Mo4L+vtfHSVFSdhQFFaLkR4/QAoTMIbkFm
	 2OzHdJ7cBz2xLJDN1jJJZ480L+CjmKLvZgkCB3v3OSNRuuU+5LOAtScOc+x70z1GQO
	 enF4kIHe8IFkzbBs7K7IoPdY1cuj4Gv6XsK50j9BSNIbwCXXTOGEVfoqyNQVW0s9Gd
	 FSXz7Vbl1/Cj7i+Hdja9PyhNDgLXnssFrUapfOswQ3mnZ1K1ebhdytgWlzIdoW2SxN
	 pfpKyDVcDaQzQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4dVfPR2z5Kz4wCm;
	Tue, 16 Dec 2025 12:25:15 +1100 (AEDT)
Date: Tue, 16 Dec 2025 12:25:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: KernelCI bot <bot@kernelci.org>, kernelci@lists.linux.dev,
 kernelci-results@groups.io, regressions@lists.linux.dev, gus@collabora.com,
 linux-next@vger.kernel.org, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [REGRESSION] next/pending-fixes: (build) error: unknown warning
 option '-Wno-suggest-attribute=format'; did...
Message-ID: <20251216122514.7ee70d5f@canb.auug.org.au>
In-Reply-To: <176584314280.2550.10885082269394184097@77bfb67944a2>
References: <176584314280.2550.10885082269394184097@77bfb67944a2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/69et5i_lNvN.91T_ot13ewr";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/69et5i_lNvN.91T_ot13ewr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 15 Dec 2025 23:59:03 -0000 KernelCI bot <bot@kernelci.org> wrote:
>
> Hello,
>=20
> New build issue found on next/pending-fixes:
>=20
> ---
>  error: unknown warning option '-Wno-suggest-attribute=3Dformat'; did you=
 mean '-Wno-property-attribute-mismatch'? [-Werror,-Wunknown-warning-option=
] in kernel/bpf/helpers.o (scripts/Makefile.build:287) [logspec:kbuild,kbui=
ld.compiler.error]
> ---
>=20
> - dashboard: https://d.kernelci.org/i/maestro:32e32983183c2c586f588a4a3a7=
cda83311d5be9
> - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git
> - commit HEAD:  326785a1dd4cea4065390fb99b0249781c9912bf
>=20
>=20
> Please include the KernelCI tag when submitting a fix:
>=20
> Reported-by: kernelci.org bot <bot@kernelci.org>
>=20
>=20
> Log excerpt:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>   CC      kernel/bpf/helpers.o
> error: unknown warning option '-Wno-suggest-attribute=3Dformat'; did you =
mean '-Wno-property-attribute-mismatch'? [-Werror,-Wunknown-warning-option]
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>=20
>=20
> # Builds where the incident occurred:
>=20
> ## defconfig on (arm64):
> - compiler: clang-21
> - config: https://files.kernelci.org/kbuild-clang-21-arm64-mainline-69409=
7d2cbfd84c3cdba292d/.config
> - dashboard: https://d.kernelci.org/build/maestro:694097d2cbfd84c3cdba292d
>=20
>=20
> #kernelci issue maestro:32e32983183c2c586f588a4a3a7cda83311d5be9
>=20
> --
> This is an experimental report format. Please send feedback in!
> Talk to us at kernelci@lists.linux.dev
>=20
> Made with love by the KernelCI team - https://kernelci.org
>=20

Presumably caused by commit

 ba34388912b5 ("bpf: Disable false positive -Wsuggest-attribute=3Dformat wa=
rning")

in the bpf tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/69et5i_lNvN.91T_ot13ewr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmlAtPoACgkQAVBC80lX
0Gwnlwf/c8kn9K6aG0sl1X13gll7DqASHge6iKGaTEZHx/RSIDn/b4V+PGysnXHe
MAymJ9jhvWXmxAsbQ7Jz9wS1D17NALYYSWinxetr8gxKKqd4q4+pL4R56r0yqqQz
u7PGLi0RUPSvX7rlHtT0Fs2PECd0i18O3z7omnRfITxLTKhJXF7th1GE5XBEHdSI
JQPfqDKe7zwencS4pZSksdkCAmOE68IQDvODSiXwe1C5v3+owbGde2XF0u39Q0q3
yuBB6D1/s7T9uy1n1N547bPs+QK3HWGrTigsrYUTuuoYs0ZF9xJKahyWG76+MDfo
rrwxXS9dFO/HcmRmV7LpwhzWzwZcWg==
=OyqN
-----END PGP SIGNATURE-----

--Sig_/69et5i_lNvN.91T_ot13ewr--

