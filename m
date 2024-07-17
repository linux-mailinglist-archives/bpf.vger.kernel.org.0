Return-Path: <bpf+bounces-34973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6162934534
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 01:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D0E1F22519
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 23:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D216F2E3;
	Wed, 17 Jul 2024 23:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MZaVdVjj"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E6E6A332;
	Wed, 17 Jul 2024 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721260765; cv=none; b=izpD2hYAOBhJBg0pmTJiK3bhWMCxa6wlthHZuPOtiPkFDU4CRlhFEP1V8OAIM+r74alIRU3TfC5y58NnrfcdASwpgiVG1gCiEfLIh1JmXlqT9DP8GnBLyebYG7MG5s8qVgFYIc9oz7IVRp4A+pJa0lnSwhL3Dk9BH+vjjENU660=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721260765; c=relaxed/simple;
	bh=uHHDX10Mmadmwn6A7ZG/22VWyNM5ZdwL/k8upgEJCRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=caPHb1N3L2S5CR5tGbvrBq+2ke1+mQajkuerthEFp1C16HWq3hhhF0FEWoXvSk9mTVYgjWPKTkGRnQVq9loDFJm8He478VZ6nbZ8GV6XOIGj2O6zhCvpyS0H9HsjZ+0w9pKHyiDqK8XMsRljzZ0V+bkn+qv6Q2j+lj2YAHHaaZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MZaVdVjj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1721260761;
	bh=HNAD2TzP2tdT9UZ/RqiaOzX6n/bA7D/ydjF9zjFPRuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MZaVdVjj7tZsDuipMkR2aUf2s4R56yy/xZsj6ABR9NET7qPqedH6iRlqbVfsLJCu/
	 +hDHz6qY/MO6QlF8pkXM6p8ECz8GaA5sfB8nMC9VSPy3R+H4fLt8gbRzJ3nKt7gxm8
	 JLt3mZEzx/271Fv7rMg2SBaJvoN4NuTjDcseBLKC0qpVlJ/00ThmRAJufmL+UjQgz2
	 HemoU+nwx9BuVZ9eBSRixbq1Q6aewhgoKqz3HSxtpFAXbzAsWc0e6iJdVnPdB3GTGP
	 U8ic53zYVsf+6TxVKieyxa9tHLsrDI+3r1UzdOm5Clz9Uss56I2L5d4A6o02LP+OtP
	 WHNyKn6N2KaaQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WPXwQ62f1z4wbh;
	Thu, 18 Jul 2024 09:59:18 +1000 (AEST)
Date: Thu, 18 Jul 2024 09:59:18 +1000
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
Message-ID: <20240718095918.5684ebf0@canb.auug.org.au>
In-Reply-To: <20240710132629.781c55e4@canb.auug.org.au>
References: <20240702113350.064e4cf2@canb.auug.org.au>
	<20240710132629.781c55e4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Jkw8XGc+u1_70MC+5sdgO8+";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Jkw8XGc+u1_70MC+5sdgO8+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 10 Jul 2024 13:26:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Tue, 2 Jul 2024 11:33:50 +1000 Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
> >=20
> > Today's linux-next merge of the bpf-next tree got a conflict in:
> >=20
> >   arch/riscv/net/bpf_jit_comp64.c
> >=20
> > between commit:
> >=20
> >   51781ce8f448 ("riscv: Pass patch_text() the length in bytes")
> >=20
> > from the risc-v tree and commit:
> >=20
> >   9f1e16fb1fc9 ("riscv, bpf: Fix out-of-bounds issue when preparing tra=
mpoline image")
> >=20
> > from the bpf-next tree.
> >=20
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >=20
> > --=20
> > Cheers,
> > Stephen Rothwell
> >=20
> > diff --cc arch/riscv/net/bpf_jit_comp64.c
> > index 7a34e5b44fc4,351e1484205e..000000000000
> > --- a/arch/riscv/net/bpf_jit_comp64.c
> > +++ b/arch/riscv/net/bpf_jit_comp64.c
> > @@@ -16,7 -16,8 +16,9 @@@
> >   #include "bpf_jit.h"
> >  =20
> >   #define RV_FENTRY_NINSNS 2
> >  +#define RV_FENTRY_NBYTES (RV_FENTRY_NINSNS * 4)
> > + /* imm that allows emit_imm to emit max count insns */
> > + #define RV_MAX_COUNT_IMM 0x7FFF7FF7FF7FF7FF
> >  =20
> >   #define RV_REG_TCC RV_REG_A6
> >   #define RV_REG_TCC_SAVED RV_REG_S6 /* Store A6 in S6 if program do ca=
lls */ =20
>=20
> This is now a conflict between the risc-v tree and the net-next tree.

And now a conflict between the risc-v tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Jkw8XGc+u1_70MC+5sdgO8+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaYWtYACgkQAVBC80lX
0GyR1gf+KAKg5oLtV+jWKGm2Acob5mKEEfTl4Z7p6kkICzD9eQoAYAB9bLtuHxUa
hGOxJaOrjcdVgCUicuyuqwua9RcGw3N5zyRCikYUJrNKG+SiSwIKgj/TpMAehzBX
XgQCzLbiuI5pzcQFNRNI3M0wO5gjczD4QYAr7JG0I6yT+5zJUjFtUfFKg/Lgssak
5USYZ41Y+meCV8qxWKyx8lot0e9A+iNucyDrIPAbmbg+hpxiomTsw5RdZ8tveI/E
WEmQSsrfdpSv8Y2tlHRczMSgxppl7AQ0LnhFVtj7XcAb9Hzov5F7meI9Neou7UsN
nJUwxOudABdLCdLM0gGHWYiq3djvtw==
=+pLu
-----END PGP SIGNATURE-----

--Sig_/Jkw8XGc+u1_70MC+5sdgO8+--

