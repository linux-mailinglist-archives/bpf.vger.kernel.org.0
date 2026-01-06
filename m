Return-Path: <bpf+bounces-78009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D27CFB1C0
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 22:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 731253001817
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 21:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA77280CE5;
	Tue,  6 Jan 2026 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="n2rJarLz"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60942C11C9;
	Tue,  6 Jan 2026 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767735653; cv=none; b=HvQo8vi4ti9CADf39CaD+zDOs8hRvi5llCGJ0sqjoyvVNhE7W7Y9dJZjWlNH7qOXb0pAaW7hZBrRQS26T9iZ0Y7girrckXjJEcG6uMKaLeX7EgJ302w42tdAyvEixZ2UN1PeE9vnzSoPasmSsF9aUrrvSgUeIJ/J/535neF8Mk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767735653; c=relaxed/simple;
	bh=lt3ESn2LiHLMfhrKCphnHt3guZ9CwHi/PiRANsNm2Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDnSGd3rpqz20PU9oEG+P9HR0vCEahGaTdGWvTNQcXbtImmvHlm3cq0cOtadO4CWdw55AfxTMstfYENSY0utcF3FULnDdSHsj6Tt9qz9klw3dEmR4k61Sfy1wFrVWKxBH7tyTGrMaShmS1ShdGDGlgGU7b4Oqnl5awfGkZiW1dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=n2rJarLz; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1767735647;
	bh=RgHPzQzSosAry1NZJDik9UsLNQ8sKedCtJPnPYXavI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n2rJarLzpSrDXVzAj6XFnTp96BghFEIcE0jbIwxXYXfWmqJHDwRAQvK+XjIgW32wz
	 70KSA3uSe/XRfDUEfw+cm6wT7Rd/HI380hh+14Zmd4m6uSnxPXQ5lyk+c+Ld3sI7hT
	 BYJAJEdk8AvcjbCzRkU6psU0wgNQprfI9DBMBnmnKTk/3RqcAXr3H0iW1pvJ+A8xUM
	 9H/czwiezFtrCPi8LMN167LcEmfmUEm6f7qiwmIz6coTese99RwWSMAvylOMvhdzGp
	 dRE/mc3hzUU+MAD04OHDaq43bxtNKGRWSOmEJZ/7ghsopy/OuKenCX3hGvvKOH78m1
	 JCbh+LnKz2gXA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4dm4NF7334z4wGx;
	Wed, 07 Jan 2026 08:40:45 +1100 (AEDT)
Date: Wed, 7 Jan 2026 08:40:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Chen Ridong
 <chenridong@huawei.com>, JP Kobryn <inwardvessel@gmail.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the
 mm-unstable tree
Message-ID: <20260107084045.6cf12b2b@canb.auug.org.au>
In-Reply-To: <87tswz74jb.fsf@linux.dev>
References: <20260105130413.273ee0ee@canb.auug.org.au>
	<CAADnVQKkphWpwKE17bGQao36dH8xqCyV-iXDcagrO7s-VOPE-w@mail.gmail.com>
	<87tswz74jb.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uGLsXwKcDd4kwp+aLuz4vFb";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/uGLsXwKcDd4kwp+aLuz4vFb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 05 Jan 2026 20:23:36 -0800 Roman Gushchin <roman.gushchin@linux.dev=
> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>=20
> > On Sun, Jan 4, 2026 at 6:04=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.=
org.au> wrote: =20
> >>
> >> Today's linux-next merge of the bpf-next tree got a semantic conflict =
in:
> >>
> >>   include/linux/memcontrol.h
> >>   mm/memcontrol-v1.c
> >>   mm/memcontrol.c
> >>
> >> between commit:
> >>
> >>   eb557e10dcac ("memcg: move mem_cgroup_usage memcontrol-v1.c")
> >>
> >> from the mm-unstable tree and commit:
> >>
> >>   99430ab8b804 ("mm: introduce BPF kfuncs to access memcg statistics a=
nd events")
> >>
> >> from the bpf-next tree producing this build failure:
> >>
> >> mm/memcontrol-v1.c:430:22: error: static declaration of 'mem_cgroup_us=
age' follows non-static declaration
> >>   430 | static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg=
, bool swap)
> >>       |                      ^~~~~~~~~~~~~~~~
> >> In file included from mm/memcontrol-v1.c:3:
> >> include/linux/memcontrol.h:953:15: note: previous declaration of
> >> 'mem_cgroup_usage' with type 'long unsigned int(struct mem_cgroup *,
> >> bool)' {aka 'long unsigned int(struct mem_cgroup *, _Bool)'}
> >>   953 | unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool =
swap);
> >>       |               ^~~~~~~~~~~~~~~~
> >>
> >> I fixed it up (I reverted the mm-unstable tree commit) and can carry t=
he
> >> fix as necessary. This is now fixed as far as linux-next is concerned,
> >> but any non trivial conflicts should be mentioned to your upstream
> >> maintainer when your tree is submitted for merging.  You may also want
> >> to consider cooperating with the maintainer of the conflicting tree to
> >> minimise any particularly complex conflicts. =20
> >
> > what's the proper fix here?
> >
> > Roman,
> >
> > looks like adding mem_cgroup_usage() to include/linux/memcontrol.h
> > wasn't really necessary, since kfuncs don't use it anyway?
> > Should we just remove that line in bpf-next? =20
>=20
> Yep. It was used in the previous version, but not in the latest one.
>=20
> Just sent an official fix.

And with that now applied to the bpf-next tree, I will no longer revert
the mm-unstable commit.

Thanks.
--=20
Cheers,
Stephen Rothwell

--Sig_/uGLsXwKcDd4kwp+aLuz4vFb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmldgV0ACgkQAVBC80lX
0GxRVQf/Twa1J9FzjynS32iiUyX/z7YDLzpmdyTCVv/CsN2Reex55MtPNiyuqeO7
bPTSWe4QsCKjuNXm313TDf9PDsXBZYwuaAFXKWFWkNR/six3xlPt3NVzUu++fXY1
EDaGrA/rI86C6X1pC0Y5GUnacX+NeRz3Qpa7hZe8MIKFXfkye89732g2IKQwDB77
XLLjWaAA1oWqIliP8Y2zg12giBx7MAib0Cfvkb/mf5uOQL2VWuBtgzCkSU+5jdQl
z8+cIGyhX2mF/15IVrE+G9YZiq6Mjk6/xDFJthYz1yAJjutHiSmuqFvrjpHk1NI5
dV7yI/yDwwdZtCRx/wEykSsK7CGuSw==
=wvNN
-----END PGP SIGNATURE-----

--Sig_/uGLsXwKcDd4kwp+aLuz4vFb--

