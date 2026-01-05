Return-Path: <bpf+bounces-77793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ACFCF199C
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 03:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C1F63008D6A
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 02:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6275030DD36;
	Mon,  5 Jan 2026 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="q3Dg18ZH"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A74C284884;
	Mon,  5 Jan 2026 02:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767578663; cv=none; b=Xo2BkJoWTpnJ6fws2vZLcda4UhQQYuIjPXaUhL4Pjui8bfjMkO6HRSjFxXbNfZtAigBAJqQHfi5Cw6oBrBvmDAy3NEqk7BHP4vtDyiBAckQuS5VAKzhcA3EPaMLvI6Mw7eXyxHL3Q0q6fy9ONMaHL68PsO+Qt5yDyS6pKCYzLs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767578663; c=relaxed/simple;
	bh=VD2g4x30tYK0IfHuRuTFEHsGFn/v4l2BNWMOsIXqhR4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bA5fjLX+N01AVJMkJHiEdUrC1aqnpmYZzs8wI/ml6qA59doxbWuTiq1iBiNULlWJwOBbeUkQ/HflD3cEgsMO7bmX1aOKiubnGfzp+q+/94hwzCJh95zuPpIyabyHc2O3WXq2kPqH9hg69wyig5lyKWl6j6qbYsf48x/VMqNrqIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=q3Dg18ZH; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1767578656;
	bh=MOc4tm5hzHeN7w9Q5mQExScYl5WcFW9QovEg1i1Se3Q=;
	h=Date:From:To:Cc:Subject:From;
	b=q3Dg18ZH4rmLqswOG/zOHemv8hfDNAwIeVB24W48E+A6382/AXszIzLEokz5rcsfG
	 g9ndmoxjmlrlPxcL/6rkKgr0oxPUV9A7HBS24u8TUaXSZ4NRYbG6EyEIEsDdEPy6c5
	 W6UdjvZ9yxd6gZYZJSuDseWlyQKYCCQqtC5SAN+MzqImbgmD16RZqb89gGH073d3sL
	 vCO46wTBXSUca/aCJAfRf309A1eDZbFTINC3BBSOIc7LJPCQVo+sAI/hEJXbuAVc6A
	 Zj/m5V10NRqww/gtO4aKLYSa2YG2ExGwz9dQOdrE5CORI/UamKzZOWZ19/a+jSApt5
	 EdTFtlLd6EXPw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4dkyKB6s4qz4wCZ;
	Mon, 05 Jan 2026 13:04:14 +1100 (AEDT)
Date: Mon, 5 Jan 2026 13:04:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Chen
 Ridong <chenridong@huawei.com>, JP Kobryn <inwardvessel@gmail.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: linux-next: manual merge of the bpf-next tree with the mm-unstable
 tree
Message-ID: <20260105130413.273ee0ee@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QTThylcdXK9Df2AdQpaZlv1";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/QTThylcdXK9Df2AdQpaZlv1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a semantic conflict in:

  include/linux/memcontrol.h
  mm/memcontrol-v1.c
  mm/memcontrol.c

between commit:

  eb557e10dcac ("memcg: move mem_cgroup_usage memcontrol-v1.c")

from the mm-unstable tree and commit:

  99430ab8b804 ("mm: introduce BPF kfuncs to access memcg statistics and ev=
ents")

from the bpf-next tree producing this build failure:

mm/memcontrol-v1.c:430:22: error: static declaration of 'mem_cgroup_usage' =
follows non-static declaration
  430 | static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, boo=
l swap)
      |                      ^~~~~~~~~~~~~~~~
In file included from mm/memcontrol-v1.c:3:
include/linux/memcontrol.h:953:15: note: previous declaration of 'mem_cgrou=
p_usage' with type 'long unsigned int(struct mem_cgroup *, bool)' {aka 'lon=
g unsigned int(struct mem_cgroup *, _Bool)'}
  953 | unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
      |               ^~~~~~~~~~~~~~~~

I fixed it up (I reverted the mm-unstable tree commit) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/QTThylcdXK9Df2AdQpaZlv1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmlbHB0ACgkQAVBC80lX
0Gx0UQf9GEIs+Ocj8boEp+QMp8DUQ1aNk3ovf1auZzQ8bFN3wB/0VeAdZRI0su/t
CDEecB/ND0fkbO7Ts2lBRsv4qUl1Scu9WFulyrbK1ngXYJ2yfbSkuZQjANnS1b3w
lIi1+oz1BV4/8ofHfcqpLuf8s2LFpDxbv4YnxFPwz6ku+meyZxKiyrvJ37Mb1OAD
uGJl5t8hhnZM2E+weQ3VTgIzLcdVGnB1D8VdaxJRjGWKBnfR3yqXvOnh/jEPD0XT
TVSXLZGu+GZyhhbanshyv2FoXZjNVYNzEvpLDcxHRIxt8jRGTYHVlkywVBraPeyV
LGdu9L4ERO9m3sWIYeRw/W1fJ7dy2g==
=KjcO
-----END PGP SIGNATURE-----

--Sig_/QTThylcdXK9Df2AdQpaZlv1--

