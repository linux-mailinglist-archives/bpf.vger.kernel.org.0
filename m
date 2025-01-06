Return-Path: <bpf+bounces-47999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A047A03076
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 20:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A8D3A149E
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 19:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0DB1DE8A3;
	Mon,  6 Jan 2025 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="T3bcXyqc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB01DF740
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736191305; cv=none; b=iaeqW3cSdA9IGaZ/10n/swomzbHiANvQnYEDwnH+w/9eFTMaNB01hcRwfFHdN81XpR+fWr4lJFOs1mjY5wdiCfgSb6zgH86xXaoRjKvk5ccFi5zYXFg/D1uo/prMFAZjEwfXbDnQ+gRxfzTKv3pmleV+WwoPIkddh9SxA92a/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736191305; c=relaxed/simple;
	bh=tWhrnuir+RlYZ6wGTCQXkf2fUV7u1sSQKqIUP3m4mf8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLMCKg9wsbigmv/WSQUb/vmtGzqXIWnH2tYUo3uPvSbWhY/6Fop6P7DU+cf6qVyaq0RXHhv0De40iib/FOrYeiQZ0NYg5TUOKAJcalX9MMWMpUEsWHgPtaYasac6T3USyAQnGGIUg3hx9Mx17urVyGastOB6o+GCCY9pSOurFSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=T3bcXyqc; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736191296; x=1736450496;
	bh=Oy2rbKECJmaPTo9UVtRc74ZMTbP78fd+vnL2/ObTcts=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=T3bcXyqcdiJI61wcoxsbf5bBHzZW8VjTloXXN8zEGDHDawmxbrKmEG23hNFMR3zcE
	 75VkEgJj/CSwX/L2tBzmwf4CjtEdbSDuIDY6X6mCGTHwPe+XYL30sCGUojpNIAfhrv
	 lE1DLqhqlP+ip+IND8oUbjuwnswjznMsg09E0sGQKNSe8uiQdZ2lXYSbNgCNwenKyN
	 iWjjc0X+1oC4SX5xrJuEfgMq9g5NB5fNOeoHZT114Uvm/22aHcyb3J0gHsgD0hlvDb
	 2TGKXYBktdj0oJ+B8xHlTzEFWm7IDGjs5dQl9LG/NjiR2AioN6QhlZtcYuvVE7gB1C
	 y3Fomae8FDNsg==
Date: Mon, 06 Jan 2025 19:21:30 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, jose.marchesi@oracle.com, andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com
Subject: Re: [PATCH v2] selftests/bpf: workarounds for GCC BPF build
Message-ID: <cDuMNyzpES4mR0L6PV40Mg32zr89vCZaKhawXaDo_rgN4cI8GsNiR1gf-eSFuiFgwMpl8ghk0k9U22b0lurlLyq6WWmNAhotqbSwse2KsWc=@pm.me>
In-Reply-To: <4b01f799f25062513fcdb5b64c5d791247b1ee48.camel@gmail.com>
References: <20250106185447.951609-1-ihor.solodrai@pm.me> <4b01f799f25062513fcdb5b64c5d791247b1ee48.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 4b75291afd9e4e291466bc5a8b965e41bd0c45ab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, January 6th, 2025 at 10:59 AM, Eduard Zingerman <eddyz87@gmail.c=
om> wrote:

>=20
>=20
> On Mon, 2025-01-06 at 18:54 +0000, Ihor Solodrai wrote:
>=20
> > Various compilation errors happen when BPF programs in selftests/bpf
> > are built with GCC BPF. For more details see the discussion at [1].
> >=20
> > The changes only affect test_progs-bpf_gcc, which is built only if
> > BPF_GCC is set:
> > * Pass -std=3Dgnu17 to gcc in order to avoid errors on bool types
> > declarations in vmlinux.h
> > * Pass -fno-strict-aliasing for tests that trigger uninitialized
> > variable warning on BPF_RAW_INSNS [2]
> >=20
> > [1] https://lore.kernel.org/bpf/EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzX=
m2qi6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=3D@pm.=
me/
> > [2] https://lore.kernel.org/bpf/87pll3c8bt.fsf@oracle.com/
> >=20
> > CC: Jose E. Marchesi jose.marchesi@oracle.com
> > Signed-off-by: Ihor Solodrai ihor.solodrai@pm.me
> >=20
> > ---
> >=20
> > v1: https://lore.kernel.org/bpf/20250104001751.1869849-1-ihor.solodrai@=
pm.me/
> >=20
> > tools/testing/selftests/bpf/Makefile | 6 +++++-
> > 1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index eb4d21651aa7..b043791fe6db 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -69,6 +69,10 @@ progs/timer_crash.c-CFLAGS :=3D -fno-strict-aliasing
> > progs/test_global_func9.c-CFLAGS :=3D -fno-strict-aliasing
> > progs/verifier_nocsr.c-CFLAGS :=3D -fno-strict-aliasing
> >=20
> > +# Uninitialized variable warning on BPF_RAW_INSN
> > +progs/verifier_bpf_fastcall.c-CFLAGS :=3D -fno-strict-aliasing
> > +progs/verifier_search_pruning.c-CFLAGS :=3D -fno-strict-aliasing
>=20
>=20
> Specifying -fno-strict-aliasing for a sub-set of tests is not convenient,
> as this list would have to be extended each time __imm_insn macro is used=
.
> Either this flag should be used for test_progs compilation as a whole,
> or the macro should be updated to use union as it was suggested previousl=
y.
> Personally, I don't like the aliasing rules and would prefer -fno-strict-=
aliasing,
> but changing macro is a simple and non-intrusive update, so I think it's =
a better option.

__imm_insn is not the only thing breaking the aliasing rules. An
example from bind* tests:

    In file included from progs/bind4_prog.c:15:
    progs/bind4_prog.c: In function =E2=80=98bind_v4_prog=E2=80=99:
    progs/bind_prog.h:9:36: error: dereferencing type-punned pointer will b=
reak strict-aliasing rules [-Werror=3Dstrict-aliasing]
        9 |         (((volatile __u16 *)&(src))[w] << 16 * w)
          |                                    ^
    progs/bind4_prog.c:138:21: note: in expansion of macro =E2=80=98load_wo=
rd=E2=80=99
      138 |         user_ip4 |=3D load_word(ctx->user_ip4, 0, sizeof(user_i=
p4));
          |                     ^~~~~~~~~
    In file included from progs/bind6_prog.c:15:
    progs/bind6_prog.c: In function =E2=80=98bind_v6_prog=E2=80=99:
    progs/bind_prog.h:9:36: error: dereferencing type-punned pointer will b=
reak strict-aliasing rules [-Werror=3Dstrict-aliasing]
        9 |         (((volatile __u16 *)&(src))[w] << 16 * w)
          |                                    ^
    progs/bind6_prog.c:151:29: note: in expansion of macro =E2=80=98load_wo=
rd=E2=80=99
      151 |                 user_ip6 |=3D load_word(ctx->user_ip6[i], 0, si=
zeof(user_ip6));
          |                             ^~~~~~~~~

And also:

    $ grep -rl --include=3D"[Mm]akefile*" 'fno-strict-aliasing' | sort
    arch/arm64/kernel/vdso32/Makefile
    arch/loongarch/vdso/Makefile
    arch/mips/vdso/Makefile
    arch/parisc/boot/compressed/Makefile
    arch/powerpc/boot/Makefile
    arch/s390/purgatory/Makefile
    arch/x86/boot/compressed/Makefile
    arch/x86/Makefile
    drivers/firmware/efi/libstub/Makefile
    Makefile
    selftests/bpf/Makefile
    selftests/kvm/Makefile
    selftests/net/tcp_ao/Makefile
    tools/scripts/Makefile.include
    tools/testing/selftests/bpf/Makefile
    tools/testing/selftests/kvm/Makefile
    tools/testing/selftests/net/tcp_ao/Makefile
    tools/testing/vsock/Makefile
    tools/virtio/Makefile

So yeah, just setting this flag for all tests makes sense.

I was wondering how clang handles this, and it turns out
-fno-strict-aliasing is true by default in clang [1]:

    -fno-strict-aliasing    Disable optimizations based on strict aliasing =
rules (default)

[1]: https://clang.llvm.org/docs/UsersManual.html

>=20
> > # Some utility functions use LLVM libraries
> > jit_disasm_helpers.c-CFLAGS =3D $(LLVM_CFLAGS)
> >=20
> > @@ -507,7 +511,7 @@ endef
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
>=20
>=20


