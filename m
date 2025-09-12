Return-Path: <bpf+bounces-68206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81178B54096
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 04:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66651C88287
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 02:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E403E22126D;
	Fri, 12 Sep 2025 02:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BAB07N4W"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82C1F582E;
	Fri, 12 Sep 2025 02:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644867; cv=none; b=nN6/e13ZhxztfLdnCMG6ct4+1G1BQ0dKdrRBqDomqNeOTEw3IQ7xHk2ERVs6pnA1ohqZApltXr7Jgu1gRQNGP+UeAGakd3vy2eTfBWJ50oZFIVmwVksf9SHxOeCKm/KJPUJVNjum1fawzFh/3giaU+bMdo4aKUgiFLt2TiLRSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644867; c=relaxed/simple;
	bh=NsauGeiklvzZmSjLPeSDEaoxcNrSuaYWf8M3YHJQe4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NMkw+Gx2pgm/1A5v/ZA57QX1IWcqErwV6pv9InsEOPOykNoqtOEuuAmwsVKL3LhWBjhi78v59ijecoc9rkw8Sly+r+4DZU2XIt/FgK9wN7v+zofX+Ug9HCOr4JZ0tRRBUXvk1AJbjtATCgwtN9M5cWk1efFMaifXfvSE4yp22TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BAB07N4W; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1757644861;
	bh=Mxz+MJMpxgcjbcJa8tZchrjniFjVcmYRhAdQ4VJ3mEw=;
	h=Date:From:To:Cc:Subject:From;
	b=BAB07N4WQbbiv9utw13tmckecOGdQcNBaWpBJovcu1tcIpiMVTGp8CDHwCh9l55dh
	 VjGRjzQ3PxIxBAmpSGF1QFEw2SAGIxqgk84vZFubZEQt2XVYgqg/qHlAa1cI3gYke1
	 TSlTtfhXUMOBQGp+ykbWeNFCKDb+t7rdWijoE5tslxW2TD5Lg5INLchkL1D6EsdMoR
	 jBAwLaz2HUpyUsuH32k40wqGvzC2+QkjTdlM1ZkpHMDqQpN0j+oIa087/l69xI1SEE
	 GfIbUTOQky9W8hdmUV9YcdLOTOw4Pi46QJxL+sk2UiXDD8sqNO8KjvmWdfaigQQpWX
	 25xkpjOE4/VVA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4cNJZh1c8sz4w90;
	Fri, 12 Sep 2025 12:41:00 +1000 (AEST)
Date: Fri, 12 Sep 2025 12:40:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: Jiawei Zhao <phoenix500526@163.com>, Jiri Olsa <jolsa@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the bpf-next tree
Message-ID: <20250912124059.0428127b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/506VhIn.sowjLdO/xYsUGH_";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/506VhIn.sowjLdO/xYsUGH_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  tools/testing/selftests/bpf/prog_tests/usdt.c

between commit:

  69424097ee10 ("selftests/bpf: Enrich subtest_basic_usdt case in selftests=
 to cover SIB handling logic")

from the bpf-next tree and commit:

  875e1705ad99 ("selftests/bpf: Add optimized usdt variant for basic usdt t=
est")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/bpf/prog_tests/usdt.c
index 615e9c3e93bf,833eb87483a1..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@@ -40,73 -40,20 +40,80 @@@ static void __always_inline trigger_fun
  	}
  }
 =20
 +#if defined(__x86_64__) || defined(__i386__)
 +/*
 + * SIB (Scale-Index-Base) addressing format: "size@(base_reg, index_reg, =
scale)"
 + * - 'size' is the size in bytes of the array element, and its sign indic=
ates
 + *   whether the type is signed (negative) or unsigned (positive).
 + * - 'base_reg' is the register holding the base address, normally rdx or=
 edx
 + * - 'index_reg' is the register holding the index, normally rax or eax
 + * - 'scale' is the scaling factor (typically 1, 2, 4, or 8), which match=
es the
 + *    size of the element type.
 + *
 + * For example, for an array of 'short' (signed 2-byte elements), the SIB=
 spec would be:
 + * - size: -2 (negative because 'short' is signed)
 + * - scale: 2 (since sizeof(short) =3D=3D 2)
 + *
 + * The resulting SIB format: "-2@(%%rdx,%%rax,2)" for x86_64, "-2@(%%edx,=
%%eax,2)" for i386
 + */
 +static volatile short array[] =3D {-1, -2, -3, -4};
 +
 +#if defined(__x86_64__)
 +#define USDT_SIB_ARG_SPEC -2@(%%rdx,%%rax,2)
 +#else
 +#define USDT_SIB_ARG_SPEC -2@(%%edx,%%eax,2)
 +#endif
 +
 +unsigned short test_usdt_sib_semaphore SEC(".probes");
 +
 +static void trigger_sib_spec(void)
 +{
 +	/*
 +	 * Force SIB addressing with inline assembly.
 +	 *
 +	 * You must compile with -std=3Dgnu99 or -std=3Dc99 to use the
 +	 * STAP_PROBE_ASM macro.
 +	 *
 +	 * The STAP_PROBE_ASM macro generates a quoted string that gets
 +	 * inserted between the surrounding assembly instructions. In this
 +	 * case, USDT_SIB_ARG_SPEC is embedded directly into the instruction
 +	 * stream, creating a probe point between the asm statement boundaries.
 +	 * It works fine with gcc/clang.
 +	 *
 +	 * Register constraints:
 +	 * - "d"(array): Binds the 'array' variable to %rdx or %edx register
 +	 * - "a"(0): Binds the constant 0 to %rax or %eax register
 +	 * These ensure that when USDT_SIB_ARG_SPEC references %%rdx(%edx) and
 +	 * %%rax(%eax), they contain the expected values for SIB addressing.
 +	 *
 +	 * The "memory" clobber prevents the compiler from reordering memory
 +	 * accesses around the probe point, ensuring that the probe behavior
 +	 * is predictable and consistent.
 +	 */
 +	asm volatile(
 +		STAP_PROBE_ASM(test, usdt_sib, USDT_SIB_ARG_SPEC)
 +		:
 +		: "d"(array), "a"(0)
 +		: "memory"
 +	);
 +}
 +#endif
 +
- static void subtest_basic_usdt(void)
+ static void subtest_basic_usdt(bool optimized)
  {
  	LIBBPF_OPTS(bpf_usdt_opts, opts);
  	struct test_usdt *skel;
  	struct test_usdt__bss *bss;
- 	int err, i;
+ 	int err, i, called;
 +	const __u64 expected_cookie =3D 0xcafedeadbeeffeed;
 =20
+ #define TRIGGER(x) ({			\
+ 	trigger_func(x);		\
+ 	if (optimized)			\
+ 		trigger_func(x);	\
+ 	optimized ? 2 : 1;		\
+ 	})
+=20
  	skel =3D test_usdt__open_and_load();
  	if (!ASSERT_OK_PTR(skel, "skel_open"))
  		return;
@@@ -126,22 -73,13 +133,22 @@@
  	if (!ASSERT_OK_PTR(skel->links.usdt0, "usdt0_link"))
  		goto cleanup;
 =20
 +#if defined(__x86_64__) || defined(__i386__)
 +	opts.usdt_cookie =3D expected_cookie;
 +	skel->links.usdt_sib =3D bpf_program__attach_usdt(skel->progs.usdt_sib,
 +							 0 /*self*/, "/proc/self/exe",
 +							 "test", "usdt_sib", &opts);
 +	if (!ASSERT_OK_PTR(skel->links.usdt_sib, "usdt_sib_link"))
 +		goto cleanup;
 +#endif
 +
- 	trigger_func(1);
+ 	called =3D TRIGGER(1);
 =20
- 	ASSERT_EQ(bss->usdt0_called, 1, "usdt0_called");
- 	ASSERT_EQ(bss->usdt3_called, 1, "usdt3_called");
- 	ASSERT_EQ(bss->usdt12_called, 1, "usdt12_called");
+ 	ASSERT_EQ(bss->usdt0_called, called, "usdt0_called");
+ 	ASSERT_EQ(bss->usdt3_called, called, "usdt3_called");
+ 	ASSERT_EQ(bss->usdt12_called, called, "usdt12_called");
 =20
 -	ASSERT_EQ(bss->usdt0_cookie, 0xcafedeadbeeffeed, "usdt0_cookie");
 +	ASSERT_EQ(bss->usdt0_cookie, expected_cookie, "usdt0_cookie");
  	ASSERT_EQ(bss->usdt0_arg_cnt, 0, "usdt0_arg_cnt");
  	ASSERT_EQ(bss->usdt0_arg_ret, -ENOENT, "usdt0_arg_ret");
  	ASSERT_EQ(bss->usdt0_arg_size, -ENOENT, "usdt0_arg_size");
@@@ -225,18 -163,9 +232,19 @@@
  	ASSERT_EQ(bss->usdt3_args[1], 42, "usdt3_arg2");
  	ASSERT_EQ(bss->usdt3_args[2], (uintptr_t)&bla, "usdt3_arg3");
 =20
 +#if defined(__x86_64__) || defined(__i386__)
 +	trigger_sib_spec();
 +	ASSERT_EQ(bss->usdt_sib_called, 1, "usdt_sib_called");
 +	ASSERT_EQ(bss->usdt_sib_cookie, expected_cookie, "usdt_sib_cookie");
 +	ASSERT_EQ(bss->usdt_sib_arg_cnt, 1, "usdt_sib_arg_cnt");
 +	ASSERT_EQ(bss->usdt_sib_arg, nums[0], "usdt_sib_arg");
 +	ASSERT_EQ(bss->usdt_sib_arg_ret, 0, "usdt_sib_arg_ret");
 +	ASSERT_EQ(bss->usdt_sib_arg_size, sizeof(nums[0]), "usdt_sib_arg_size");
 +#endif
 +
  cleanup:
  	test_usdt__destroy(skel);
+ #undef TRIGGER
  }
 =20
  unsigned short test_usdt_100_semaphore SEC(".probes");

--Sig_/506VhIn.sowjLdO/xYsUGH_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmjDiDsACgkQAVBC80lX
0Gwn2wf+JdEg0JBrrqOJ/mxKRiIsOTu4bxuxaLCeAgoa0DJNc5hvVaIYnFx/nuAX
ys9BuJ10hkEWzuJqBSWBKIunMipD1vPZNXQypHYAbu7hTlue2C1uWOTI/xyMEKHw
bQciNXwP9FAsZoEYse0Hyb9CjYUARd/WN195DAv0IQn1Om1Rh24xr0+WpCCNS8Si
HCNiZ0L20BHUn3k2t75wme5i77PFWrsdsv24PwzDgSFQ66W+iY1z/d9ZF3J2rClO
dx/VNN0hkkQ/qnmb4Fxa8LbwNNZaWmQYZBost00aiqEZW9bq9SNPL6956OH9/Ltb
F/CXavvsytxkpOPiYC3R9mLG6505PA==
=Su5e
-----END PGP SIGNATURE-----

--Sig_/506VhIn.sowjLdO/xYsUGH_--

