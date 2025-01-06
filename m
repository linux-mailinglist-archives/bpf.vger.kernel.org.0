Return-Path: <bpf+bounces-47980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB14A02DDF
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 17:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4818318860B0
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAC214600C;
	Mon,  6 Jan 2025 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="PXru3/B3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344CACA64
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181252; cv=none; b=XimKDtq9VBMF7Pl6oup3PBktTWnvt3PmYIUKZSI5TX3wpO+GEcFKfFS0jsKEKirPoWL3I5jheSEA0kwxV3U9Tv3cYV0y47SmyuSu9QJBfUKRw3lota/U4A8BKqcmxRebH3SeJ1KdGHYYaVFpTFf6Rid8T5q2W+RG4NMc7p9spNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181252; c=relaxed/simple;
	bh=1NHsbAhAWCO9fiUnzFmbDCodHISnsE52w6KZpYoxmSM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zsr6ec4D2sjWoLhwK4KQHM+9czyq/48ThvWCFbPuBU+yKjLTiJ3cNQfZyyODNtjfzKuEz3N27nAcSOcwNS8K/UNVYBNDou6LARbQbYs7WNABWmWmAXkTVBiK5qm2vSdp1vRsJOXxoGY6qFB/ZTixIKyrsExtMwr8WdfA7uevWbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=PXru3/B3; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736181242; x=1736440442;
	bh=1NHsbAhAWCO9fiUnzFmbDCodHISnsE52w6KZpYoxmSM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=PXru3/B3sS8OmWoAI59kDir0EjjpuS1TDrMMZ8tu7Kk/mei3cRii/wyStDossifQY
	 cM1H73SBKmbIJMsPyISLAwoTkJMg4OqlBctv71wQZU/u+czNMFhRXPm490VjW7l26n
	 IlVZKotFM+Z0FFNnc5o7/WkIoDsVTvvhCoz5tvwmYHqk3eKlSxg1Cdl1F17RGRA3KQ
	 I6E1VftqWkNhc610x8ttAcf6IMfgya17KRRkOn6DPWJdvEDVu4MtMTmhbjktn7E/dI
	 ImqYdMyC8mzXmwO4gpWLRopLi8/On2KN7PHXJSlgXr5GY3EfQi+99DY+OirKGgIbPs
	 eb4VaTcoEfh8w==
Date: Mon, 06 Jan 2025 16:34:00 +0000
To: Daniel Borkmann <daniel@iogearbox.net>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com, mykolal@fb.com, jose.marchesi@oracle.com
Subject: Re: [PATCH] selftests/bpf: workarounds for GCC BPF build
Message-ID: <MG8drPPVIAyVxcJH5MSGOL3MpkeWvz98F2xuJaeuL3Hm_85V8xXifo-zzbLAc3GMOp0wtw96r7ftOKa-jlZEuu4eIxBgk80c5bkKh3S1d2M=@pm.me>
In-Reply-To: <ac06c94d-34a9-4606-a2d6-196575d3877e@iogearbox.net>
References: <20250104001751.1869849-1-ihor.solodrai@pm.me> <ac06c94d-34a9-4606-a2d6-196575d3877e@iogearbox.net>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 327e39c8f85ccd1ed95a9003c67bec0e95572744
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, January 6th, 2025 at 7:05 AM, Daniel Borkmann <daniel@iogearbox.=
net> wrote:

>=20
> On 1/4/25 1:17 AM, Ihor Solodrai wrote:
>=20
> > Various compilation errors happen when BPF programs in selftests/bpf
> > are built with GCC BPF. For more details see the discussion at [1].
>=20
>=20
> Thanks for the patch!

Hi Daniel, thanks for review.

>=20
> > The changes only affect test_progs-bpf_gcc, which is built only if
> > BPF_GCC is set:
> > * Pass -std=3Dgnu17 when to avoid errors on bool
> > types declarations in vmlinux.h
> > * Pass -nostdinc for tests that trigger int64_t declaration
> > collision due to a difference between gcc and clang stdint.h
> > * Pass -Wno-error for tests that trigger uninitialized variable
> > warning pm BPF_RAW_INSNS
> >=20
> > [1] https://lore.kernel.org/bpf/EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzX=
m2qi6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=3D@pm.=
me/
> >=20
> > Signed-off-by: Ihor Solodrai ihor.solodrai@pm.me
>=20
>=20
> [ pls also add Jose to Cc (done here) ]
>=20
> > ---
> > tools/testing/selftests/bpf/Makefile | 11 ++++++++++-
> > 1 file changed, 10 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index 9e870e519c30..2e1fe53efa83 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -103,6 +103,15 @@ progs/btf_dump_test_case_packing.c-bpf_gcc-CFLAGS =
:=3D -Wno-error
> > progs/btf_dump_test_case_padding.c-bpf_gcc-CFLAGS :=3D -Wno-error
> > progs/btf_dump_test_case_syntax.c-bpf_gcc-CFLAGS :=3D -Wno-error
> >=20
> > +# Uninitialized variable warning on BPF_RAW_INSN
> > +progs/verifier_bpf_fastcall.c-CFLAGS :=3D -Wno-error
> > +progs/verifier_search_pruning.c-CFLAGS :=3D -Wno-error
>=20
>=20
> See previous feedback from Jose:
>=20
> Ignoring the warning doesn't cure the resulting undefined behavior.
> These selftests seems to be violating strict aliasing rules, so it is
> better to either change the testcase to work well with anti-aliasing
> rules or to disable strict aliasing, like it is done for many other
> tests already:
>=20
> progs/verifier_bpf_fastcall.c-CFLAGS :=3D -fno-strict-aliasing
> progs/verifier_search_pruning.c-CFLAGS :=3D -fno-strict-aliasing

Yeah, I haven't seen this message before sending the patch.

>=20
> > +# int64_t declaration collision
> > +progs/test_cls_redirect.c-CFLAGS :=3D -nostdinc
> > +progs/test_cls_redirect_dynptr.c-CFLAGS :=3D -nostdinc
> > +progs/test_cls_redirect_subprogs.c-CFLAGS :=3D -nostdinc
>=20
>=20
> iiuc, this hunk is not needed given [1] got merged which addresses the
> collision issue already?
>=20
> [0] https://lore.kernel.org/bpf/87pll3c8bt.fsf@oracle.com/
> [1] https://gcc.gnu.org/pipermail/gcc-patches/2025-January/672508.html
>=20

I am going to test the GCC change, and will send v2 shortly after.

Thanks!

> > # The following tests do type-punning, via the __imm_insn macro, from
> > # `struct bpf_insn' to long and then uses the value. This triggers an
> > # "is used uninitialized" warning in GCC due to strict-aliasing
> > @@ -507,7 +516,7 @@ endef
> > # Build BPF object using GCC
> > define GCC_BPF_BUILD_RULE
> > $(call msg,GCC-BPF,$4,$2)
> > - $(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 =
-c $1 -o $2
> > + $(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 =
-std=3Dgnu17 -c $1 -o $2
> > endef
> >=20
> > SKEL_BLACKLIST :=3D btf__% test_pinning_invalid.c test_sk_assign.c


