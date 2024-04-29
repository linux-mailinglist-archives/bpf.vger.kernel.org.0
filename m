Return-Path: <bpf+bounces-28057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EAF8B4F49
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 03:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5A7281FF5
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 01:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D44117FD;
	Mon, 29 Apr 2024 01:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bM5GcVQ1"
X-Original-To: bpf@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5937F;
	Mon, 29 Apr 2024 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714355384; cv=none; b=fUaRPhxc+LOAlisQ87j5saVMOAfvZ4vcqhQIH38Yr6t8tVk3+XH3eD7TlfLIQUfQVPiRgP2+dhrQF4KeEi097tNeaAC1AlTmsROLAhwTBc7RDBJmjusIcUf6AplPsGdRIaJoKfsG+DgWab/9/+nUlzyxktUgI7098LOBxG889n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714355384; c=relaxed/simple;
	bh=w9r09G9ouq8go6rLsCNNHrKjBjY+D3CT2rZRkIVGUJs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=P+BL/EfJUz4crCiRG4mYTtpSg8ahTtZVZUJJD+V/dLNSzRcPBth2mmo5bOx915WRoDs2Og9iFLXaHI1Vgd4WWqnYhklweD5HSPP7AZ7dYRyAsqndEuA7YQ/CDUZhEFxs2OTHwAL0pSbovLX/y3WzXHXKgbL494rduGcl6tzomiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=bM5GcVQ1; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714355381;
	bh=w2cdMhiy6tblzMZH6pdXm9gKC5PfIyxq9cFSsg19XLQ=;
	h=Date:From:To:Cc:Subject:From;
	b=bM5GcVQ1AhKIBQJ3MzaxJC/EoReRipzmeaf60UNqtNomiNStEligZcDmFI112k7KO
	 ujT4e9DNDy2/02ZyrlPU36xdjQYtQmtTa9yyxg/yiYWq+KUkebKJXrKDP5nXV5CLuc
	 YbGODr7g6n2ZvDht26n2kU3hKFKT2Gcfc+NTMCj+6M4LMQ/SdPm/6AORcEFKyKh0pK
	 /70PIlS5KFkUJsQ6SjaiQpAzUOwQAC21oHptJhLYbX0fRs92hCOn6VL3gSOgD3DLFI
	 p12lc6Nqx8MovmueLptZLl6IWax01I4MmbTn+yJNMqQTTPSpyNKrLG5dNmdbF38KTI
	 ndNHpYsq3pAdw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VSR8h522vz4wyk;
	Mon, 29 Apr 2024 11:49:40 +1000 (AEST)
Date: Mon, 29 Apr 2024 11:49:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>,
 Puranjay Mohan <puranjay12@gmail.com>, Puranjay Mohan <puranjay@kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the net tree
Message-ID: <20240429114939.210328b0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=4d1luGBKfxf+mOMcFr0nF.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/=4d1luGBKfxf+mOMcFr0nF.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got conflicts in:

  include/linux/filter.h
  kernel/bpf/core.c

between commit:

  66e13b615a0c ("bpf: verifier: prevent userspace memory access")

from the net tree and commit:

  d503a04f8bc0 ("bpf: Add support for certain atomics in bpf_arena to x86 J=
IT")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/filter.h
index 42dbceb04ca6,7a27f19bf44d..000000000000
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@@ -975,7 -1000,7 +1000,8 @@@ bool bpf_jit_supports_far_kfunc_call(vo
  bool bpf_jit_supports_exceptions(void);
  bool bpf_jit_supports_ptr_xchg(void);
  bool bpf_jit_supports_arena(void);
 +u64 bpf_arch_uaddress_limit(void);
+ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
  void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp,=
 u64 bp), void *cookie);
  bool bpf_helper_changes_pkt_data(void *func);
 =20
diff --cc kernel/bpf/core.c
index a04695ca82b9,95c7fd093e55..000000000000
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@@ -2958,15 -2965,11 +2965,20 @@@ bool __weak bpf_jit_supports_arena(void
  	return false;
  }
 =20
 +u64 __weak bpf_arch_uaddress_limit(void)
 +{
 +#if defined(CONFIG_64BIT) && defined(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDR=
ESS_SPACE)
 +	return TASK_SIZE;
 +#else
 +	return 0;
 +#endif
 +}
 +
+ bool __weak bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
+ {
+ 	return false;
+ }
+=20
  /* Return TRUE if the JIT backend satisfies the following two conditions:
   * 1) JIT backend supports atomic_xchg() on pointer-sized words.
   * 2) Under the specific arch, the implementation of xchg() is the same

--Sig_/=4d1luGBKfxf+mOMcFr0nF.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYu/LMACgkQAVBC80lX
0GxRbgf+OGy7yQHWICx3VdFZX+/3+CmXwEHaKe0hVPbQXhuGGT2ZekkGCbqyNS5+
6/ilo+mZMpwXT2R1ZgnWbVdD86hFum2sOW4xNUwyK+6XbpKZ/l893x0NXg1JHYbE
OOQGvMpR/A58980zb4JeVOXb8UIYcsrX3KpG9tA8/kyNgogl5y8NxwcYtSi8sPhf
gFRcSCL3APSfy/qoPCFsbpT01gzLbvDu0GJ2Gg6Vx695agS3/vwXd6U0dGA2YTRh
oU8CQpEE/fHQNdBl9qBN7NQhpqAThKHphgR7Ep7RqqrYpKDKSMgD/9Ysw7ARZVFK
aEXu2EbkL1XKXdWB6/FFJ5gJMLbw8w==
=nPAe
-----END PGP SIGNATURE-----

--Sig_/=4d1luGBKfxf+mOMcFr0nF.--

