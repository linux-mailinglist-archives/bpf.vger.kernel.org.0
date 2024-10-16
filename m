Return-Path: <bpf+bounces-42146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC859A0109
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 08:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DC128644C
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 06:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94E818C926;
	Wed, 16 Oct 2024 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XEhGoTH5"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A57156E4;
	Wed, 16 Oct 2024 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729058752; cv=none; b=ge9GRtzO8VXhJ1YyK4XuPqqwQrTxKRolhAf3eVIW5mhwkV9qMKfsTtf3djpZPSDhjbvI3Ud1tp19eVJTvdKay0ZQ4F/Tu7lgWK/U+QDo2jLfJLUjYxRrUoQkmjlOWQAzshyK6WsxQUeOATLHOb+3pZDFgAfY9+xSyGq86lO6mNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729058752; c=relaxed/simple;
	bh=7Ofs/TgkfLtnxS2xk40tUtc2ZQLrbIJkZXWkqXUiI00=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n42fqSc7O1f3DcOpNl4GdYgGldT3JXLfDEkSXB5/UmNN404a9q9Yhqt4c92TfmiOPJeE3H6JNZWtWUJ6hNf30LsgECT5ftdlQaDIJ5WdmiUKVi6g83wbacCBfWYri4Zsr/cu2lhgctkQ3hvW7oZUQKLUBdIXy3a8cfcdvY8S9vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=XEhGoTH5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1729058744;
	bh=TVbOf9/AhfF0p9D9eUG4T+B7BKtPRUhvA0yVfxLDpDk=;
	h=Date:From:To:Cc:Subject:From;
	b=XEhGoTH52mSMAA7NPrDBR5RZAnz5ulQAIlRiVW0m0YTL7KfyUTdGbun6q0AWgDMev
	 fvDfGbYgPEwIP1D137xL+4dDnd8F6CZGIZJuIo/XVw4nPxRAW53fvkhT/nvxXEdmdH
	 j7woQyIrlFhb9WKqD8u7bOheAK0UqF8N8z8KR+JjNGHJUO0Pc1DUGABkmgjqY0yKPr
	 Dv/NBeeXbsUzyWz8mPa/MHpBX8vGhJPq5t9G/UteQQpytWpaBhSfrd9e48/rL1RiTg
	 B65YxsTlDk8GF50lWPTILjoVOA+Rizg/yEQxCDXlyfh7UM8S9n9WBSIWOpkhRbFYXW
	 WWCLTF+9uI5jw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XT0ng5JB5z4wxm;
	Wed, 16 Oct 2024 17:05:43 +1100 (AEDT)
Date: Wed, 16 Oct 2024 17:05:42 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20241016170542.7e22b03c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5Pf1JOz7unG6qSw6Vt3251x";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/5Pf1JOz7unG6qSw6Vt3251x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (arm64
defconfig) failed like this:

Building: arm64 defconfig
In file included from arch/arm64/include/asm/thread_info.h:17,
                 from include/linux/thread_info.h:60,
                 from arch/arm64/include/asm/preempt.h:6,
                 from include/linux/preempt.h:79,
                 from include/linux/spinlock.h:56,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:7,
                 from include/linux/slab.h:16,
                 from mm/slab_common.c:7:
mm/slab_common.c: In function 'bpf_get_kmem_cache':
arch/arm64/include/asm/memory.h:427:66: error: passing argument 1 of 'virt_=
to_pfn' makes pointer from integer without a cast [-Wint-conversion]
  427 |         __is_lm_address(__addr) && pfn_is_map_memory(virt_to_pfn(__=
addr));      \
      |                                                                  ^~=
~~~~
      |                                                                  |
      |                                                                  u6=
4 {aka long long unsigned int}
mm/slab_common.c:1260:14: note: in expansion of macro 'virt_addr_valid'
 1260 |         if (!virt_addr_valid(addr))
      |              ^~~~~~~~~~~~~~~
arch/arm64/include/asm/memory.h:382:53: note: expected 'const void *' but a=
rgument is of type 'u64' {aka 'long long unsigned int'}
  382 | static inline unsigned long virt_to_pfn(const void *kaddr)
      |                                         ~~~~~~~~~~~~^~~~~

Caused by commit

  04b069ff0181 ("mm/bpf: Add bpf_get_kmem_cache() kfunc")

I have reverted commit

  08c837461891 ("Merge branch 'bpf-add-kmem_cache-iterator-and-kfunc'")

for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/5Pf1JOz7unG6qSw6Vt3251x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcPV7YACgkQAVBC80lX
0GzzNwf/RIBMPuu2hNEvKh6Jb3c/Eg2WMg25KuC/ixlV32M4y9pfYZJAK/NAlGAN
R1GYP49Gl7P5gYbxE4oqyTD1s4xB4wYnD8+RIegQVQO957Bb/7POqGBn/yVe+y6P
bQ4hTGYQVQumrxbIDVewm3jUvxomoushHUYRoQiZV68Tg0ZKQSdA+5dxmaFIsXnk
UFOaIeiin4Vgd/ZGR0QmE92O21WvZwPjDNIg0oCpUG4o3EyT6nO5UmUyCbhhtCOR
AgHJ3GF7xVJGf68kSJwEImsR/Qbd56TqDgqf8tjqkPBeh3GE8ioCtsbWeugnnfpj
hbC984jeivq2/RPKim5SxndwQtF5Jw==
=BjN8
-----END PGP SIGNATURE-----

--Sig_/5Pf1JOz7unG6qSw6Vt3251x--

