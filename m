Return-Path: <bpf+bounces-9821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0099479DC88
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A001E282442
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6338111704;
	Tue, 12 Sep 2023 23:15:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BF233D2;
	Tue, 12 Sep 2023 23:15:15 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7900310F7;
	Tue, 12 Sep 2023 16:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1694560509;
	bh=chwvPJalX+Ozmkh/w9KERyWn7/ZC9Ubo0zmQdN07HMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AsMVOpKQBA75D8UQrFf/5n3kvjRI/HeAtk9QOTzbNcKVxQGnujDlcjEqk3QTjprGv
	 AkdqxW6dENqeO5xh7cAbyOYfrPkAv/65fPi7KQnC0Dbt6LdSxs61MqhrjeTjSm/8sP
	 nx18I2joUkswWvAGqmt45+TwR6yCTi5suDmBB5PPLxPir8iWCYYhsoacA0nHfLC2uy
	 JbMkbFiz9Af7qjjo1DAn5MuhqWPn/tQcjoYTvQPjWeqTIC6AhYQZsmkKgXid5x9xfI
	 EbYm2xRdojpFf9T7pYDdii1eDciDziivap5KP+FgstWPyKO97QYpqmQMy3Ny3xlowa
	 +C9ZIcsqMrDTA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RlfZ51YSmz4xPy;
	Wed, 13 Sep 2023 09:15:09 +1000 (AEST)
Date: Wed, 13 Sep 2023 09:15:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the bpf tree
Message-ID: <20230913091507.71869bba@canb.auug.org.au>
In-Reply-To: <CAADnVQKt_oCgJpVv+jqi5yhO4XUb2RWzajNSsNWk4fJWD4cJ7A@mail.gmail.com>
References: <20230913081050.5e0862bd@canb.auug.org.au>
	<CAADnVQKt_oCgJpVv+jqi5yhO4XUb2RWzajNSsNWk4fJWD4cJ7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I=4haB8J/btKzaA=ncLCje0";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/I=4haB8J/btKzaA=ncLCje0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Tue, 12 Sep 2023 15:18:45 -0700 Alexei Starovoitov <alexei.starovoitov@g=
mail.com> wrote:
>
> On Tue, Sep 12, 2023 at 3:10=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.o=
rg.au> wrote:
> >
> > Hi all,
> >
> > Commit
> >
> >   3903802bb99a ("libbpf: Add basic BTF sanity validation")
> >
> > is missing a Signed-off-by from its committer. =20
>=20
> Hmm. It's pretty difficult to fix.
> We'd need to force push a bunch of commits and add a ton of
> unnecessary SOBs to commits after that one.
> Can you make a note of it somehow?

No, I can't - git has no mechanism to do so.  However, I note that this
commit is signed off by one of the BPF maintainers, so maybe it can be
left as is and try to remember next time ;-)

--=20
Cheers,
Stephen Rothwell

--Sig_/I=4haB8J/btKzaA=ncLCje0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUA8PsACgkQAVBC80lX
0Gy6Xwf/XHXF3tyUT6ZmY0lkWZopyNSjsncPibigZOTc1sgU74x8xOrI32/AdIie
c9DVWNdUqWQP3axULeSqfQSFEOp1ENi30NOiUtL57U3aS7u5GOLdPPlG4gkPiBlm
tJoi9yqGfRVNFrKDS5TrxYbUjg4Ju6AtIBVOifBVwtZ7NYDJD01PabIYTd5sCpVU
T2nLVYwLAwf7oJs6Hhw6HlZjL2G941pvL+tnOdx2wfQoeCxxXoBaUwDX/BBVJnv3
8unII/MprOhpgUvi5q8tFt+ziCJFZqsOcvgjJeC8VH47q1R3Ob0nkKYvZRWL6gPK
WejeedhQO/6lRAFPQzwgahk7wPcgRw==
=4R9g
-----END PGP SIGNATURE-----

--Sig_/I=4haB8J/btKzaA=ncLCje0--

