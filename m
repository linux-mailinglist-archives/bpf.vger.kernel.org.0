Return-Path: <bpf+bounces-63083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6936EB02419
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 20:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4861CC34B0
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 18:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863091F4179;
	Fri, 11 Jul 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GUYM47X8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D831D7E41
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259809; cv=none; b=ewwq2bHCBaRd5EHiB6Z/bhFPovHFgYLrCKvtf9cG4DFWOFQ9tX0onQq1G80MLyqqwN6j65Ynr16lf+Q1866QBRTNt1FAXKIPSwHbb9N7Og8lY01iGdrMv8hJt+a2c7XXFrFTAzpddv4S38Jel90ggkWnyeCf1dbxp6/x4fs1QKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259809; c=relaxed/simple;
	bh=uKsxT/BD17OYI1TvueJzTB7MSRcSpvBm5d7/ESnv4X8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqyLF8/vWmqKx2iOQORbQL2Umv5yDhH21512qhwl/n7tm1XTXySljSZefVt6+TR7QwwfN8MrvIMdfbeUzu4szFo/SZyoEhv9GvMbPg/OnVLiWmetO0OGBBpBNpeckgB9r251WJfTz3BnZv58J7ViRfjc1ZpIkVswkMBWjEyJ8G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GUYM47X8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2357c61cda7so24335ad.1
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752259807; x=1752864607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp9Z/2QTyMOyDYIkU7CbCU89ReiAiNnkjU7WZOcGUCk=;
        b=GUYM47X8LVsR3wOMELXsUyddCvP/lkNW/DHB2mPtMyLiLUzA5rK92IRME04ENFA27Y
         z5dusnNDvEmD76u2xwgwqZOJ9umIwRHJ7yCFmaSM1rKYywPT34dAIQNoNCdHzarqx38L
         YZaOyU3BPhed8uF2+x8RZzpJ87b0QwA9H4gkxm2tJu/A7K7juEM7TddhEHneIwN2c2q9
         Wjji76Aj+lEYmETVQCY0pC2k7cK6dd6fzrcOYCRTFkw3q1K8U736oL7TBwFZID92TjkE
         /N74gdPcWdWIoQONowgPF7v8fj3ZCbtPvZ+VQzDcCh6pMFRKhyKqSfUjgK5ITgUHdSE3
         pfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752259807; x=1752864607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp9Z/2QTyMOyDYIkU7CbCU89ReiAiNnkjU7WZOcGUCk=;
        b=NrTu3qdHkPyfz/Jb6bru5d46hf3VRo3pGdVuMY15Y6XMpLSUKboq4sOCmHg5DRUnTz
         AKTppEYogCNXIioap8kOmwDJ5R79jZKvqcdK9P9B4xmPkZj1zFA48yC2l63iPscVehve
         DNuAnBFJzQtbPL43ntYxg7Sgxk+DMRpCDTjKciQ0Jm+gs3Pitx75j+atTWRL+8qNJ6QS
         xbwYWGGXVqm4r+7bG2eETRrB6PTcsPDL/JXeC38dV2QSEUGS0lVZeXUYeUoVjnPR3qyb
         DOjt6ygEuObxm353vYnKehpKBYk/+r9xtMrJ7AboBN5bQhMhJsnqB+/Tbs6jSUyDCTAr
         YpIg==
X-Gm-Message-State: AOJu0YzmtUZzTmzJ0vDZWjZmGT/HoUpkd46j+szj3Pwd+MnK96d6t282
	Klshf4HKo6GYn+T3br8bI8jWBWJIiukBQyUORUK8x2l1T08sMGdzOCh0ENP3hBpLKwa/u9G0fGE
	V0dt4gdTYf1BPrJ9EmEIV8bGFYZ1PHWLq4Rjsi1zD
X-Gm-Gg: ASbGncs06P67gXmLDHEphymne4B0WWAhchJD+PJ4ANX0Fvn/8l28PkgsKnG1XhZtmSU
	0KfztFEnIxONpmWoRZLplqxjPt9IeHOo/eL/px2mHlvMHWAPb5301k5oJOFvraW3fFAmHhdHsvt
	aF0jr1/2VZklpHSk389L1+6Dm96plNIMY+uSiDPgByP7lrKkEACcj21QSN9EPuXgCpCUTpbegaS
	e89
X-Google-Smtp-Source: AGHT+IHU8vaSeRw3fnyhcApiWIogTWqlYunNBPIhkLH9T3BHCSjrfAUuHQ1RgOSIgmx/uz7hFi2rTfco22+EbD0PTx8=
X-Received: by 2002:a17:903:1b0c:b0:215:65f3:27ef with SMTP id
 d9443c01a7336-23df6954f30mr379485ad.12.1752259806082; Fri, 11 Jul 2025
 11:50:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505223437.3722164-4-samitolvanen@google.com>
 <20250505223437.3722164-6-samitolvanen@google.com> <aHEfJZjW9dTXCgw3@willie-the-truck>
In-Reply-To: <aHEfJZjW9dTXCgw3@willie-the-truck>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 11 Jul 2025 11:49:29 -0700
X-Gm-Features: Ac12FXxCyxWVkaFXO4hBzmagkiWunDFY19ZG9WQU670r1_7gDr_nTSfNwBp2hpE
Message-ID: <CABCJKued2XsLp5+ZW1ZWQn6=CgYkhjEDyJdfTRTR1MGkvDtmXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 2/2] arm64/cfi,bpf: Support kCFI + BPF on arm64
To: Will Deacon <will@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Catalin Marinas <catalin.marinas@arm.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Maxwell Bland <mbland@motorola.com>, 
	Puranjay Mohan <puranjay12@gmail.com>, Dao Huang <huangdao1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Fri, Jul 11, 2025 at 7:26=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, May 05, 2025 at 10:34:40PM +0000, Sami Tolvanen wrote:
> > From: Puranjay Mohan <puranjay12@gmail.com>
> >
> > Currently, bpf_dispatcher_*_func() is marked with `__nocfi` therefore
> > calling BPF programs from this interface doesn't cause CFI warnings.
> >
> > When BPF programs are called directly from C: from BPF helpers or
> > struct_ops, CFI warnings are generated.
> >
> > Implement proper CFI prologues for the BPF programs and callbacks and
> > drop __nocfi for arm64. Fix the trampoline generation code to emit kCFI
> > prologue when a struct_ops trampoline is being prepared.
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > Co-developed-by: Maxwell Bland <mbland@motorola.com>
> > Signed-off-by: Maxwell Bland <mbland@motorola.com>
> > Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Tested-by: Dao Huang <huangdao1@oppo.com>
> > ---
> >  arch/arm64/include/asm/cfi.h    | 23 +++++++++++++++++++++++
> >  arch/arm64/kernel/alternative.c | 25 +++++++++++++++++++++++++
> >  arch/arm64/net/bpf_jit_comp.c   | 22 +++++++++++++++++++---
> >  3 files changed, 67 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/cfi.h
> >
> > diff --git a/arch/arm64/include/asm/cfi.h b/arch/arm64/include/asm/cfi.=
h
> > new file mode 100644
> > index 000000000000..670e191f8628
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/cfi.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_ARM64_CFI_H
> > +#define _ASM_ARM64_CFI_H
> > +
> > +#ifdef CONFIG_CFI_CLANG
> > +#define __bpfcall
> > +static inline int cfi_get_offset(void)
> > +{
> > +     return 4;
>
> Needs a comment.

Ack.

> > +}
> > +#define cfi_get_offset cfi_get_offset
> > +extern u32 cfi_bpf_hash;
> > +extern u32 cfi_bpf_subprog_hash;
> > +extern u32 cfi_get_func_hash(void *func);
> > +#else
> > +#define cfi_bpf_hash 0U
> > +#define cfi_bpf_subprog_hash 0U
> > +static inline u32 cfi_get_func_hash(void *func)
> > +{
> > +     return 0;
> > +}
> > +#endif /* CONFIG_CFI_CLANG */
> > +#endif /* _ASM_ARM64_CFI_H */
>
> This looks like an awful lot of boiler plate to me. The only thing you
> seem to need is the CFI offset -- why isn't that just a constant that we
> can define (or a Kconfig symbol?).

The cfi_get_offset function was originally added in commit
4f9087f16651 ("x86/cfi,bpf: Fix BPF JIT call") because the offset can
change on x86 depending on which CFI scheme is enabled at runtime.
Starting with commit 2cd3e3772e41 ("x86/cfi,bpf: Fix bpf_struct_ops
CFI") the function is also called by the generic BPF code, so we can't
trivially replace it with a constant. However, since this defaults to
`4` unless the architecture adds pre-function NOPs, I think we could
simply move the default implementation to include/linux/cfi.h (and
also drop the RISC-V version). Come to think of it, we could probably
move most of this boilerplate to generic code. I'll refactor this and
send a new version.

> > diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/altern=
ative.c
> > index 8ff6610af496..71c153488dad 100644
> > --- a/arch/arm64/kernel/alternative.c
> > +++ b/arch/arm64/kernel/alternative.c
> > @@ -8,11 +8,13 @@
> >
> >  #define pr_fmt(fmt) "alternatives: " fmt
> >
> > +#include <linux/cfi_types.h>
> >  #include <linux/init.h>
> >  #include <linux/cpu.h>
> >  #include <linux/elf.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/alternative.h>
> > +#include <asm/cfi.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/insn.h>
> >  #include <asm/module.h>
> > @@ -298,3 +300,26 @@ noinstr void alt_cb_patch_nops(struct alt_instr *a=
lt, __le32 *origptr,
> >               updptr[i] =3D cpu_to_le32(aarch64_insn_gen_nop());
> >  }
> >  EXPORT_SYMBOL(alt_cb_patch_nops);
> > +
> > +#ifdef CONFIG_CFI_CLANG
> > +struct bpf_insn;
> > +
> > +/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
> > +extern unsigned int __bpf_prog_runX(const void *ctx,
> > +                                 const struct bpf_insn *insn);
> > +DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
> > +
> > +/* Must match bpf_callback_t */
> > +extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
> > +DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
> > +
> > +u32 cfi_get_func_hash(void *func)
> > +{
> > +     u32 hash;
> > +
> > +     if (get_kernel_nofault(hash, func - cfi_get_offset()))
> > +             return 0;
> > +
> > +     return hash;
> > +}
> > +#endif /* CONFIG_CFI_CLANG */
>
> I don't think this should be in alternative.c. It's probably better off
> either as a 'static inline' in the new cfi.h header.

Sure, I'll find a better place for this. RISC-V again seems to have
the exact same function, so I think a __weak implementation in
kernel/cfi.c would work here, allowing x86 to still conveniently
override the function.

> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_com=
p.c
> > index 70d7c89d3ac9..3b3691e88dd5 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -9,6 +9,7 @@
> >
> >  #include <linux/bitfield.h>
> >  #include <linux/bpf.h>
> > +#include <linux/cfi.h>
> >  #include <linux/filter.h>
> >  #include <linux/memory.h>
> >  #include <linux/printk.h>
> > @@ -164,6 +165,12 @@ static inline void emit_bti(u32 insn, struct jit_c=
tx *ctx)
> >               emit(insn, ctx);
> >  }
> >
> > +static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
> > +{
> > +     if (IS_ENABLED(CONFIG_CFI_CLANG))
> > +             emit(hash, ctx);
> > +}
> > +
> >  /*
> >   * Kernel addresses in the vmalloc space use at most 48 bits, and the
> >   * remaining bits are guaranteed to be 0x1. So we can compose the addr=
ess
> > @@ -474,7 +481,6 @@ static int build_prologue(struct jit_ctx *ctx, bool=
 ebpf_from_cbpf)
> >       const bool is_main_prog =3D !bpf_is_subprog(prog);
> >       const u8 fp =3D bpf2a64[BPF_REG_FP];
> >       const u8 arena_vm_base =3D bpf2a64[ARENA_VM_START];
> > -     const int idx0 =3D ctx->idx;
> >       int cur_offset;
> >
> >       /*
> > @@ -500,6 +506,9 @@ static int build_prologue(struct jit_ctx *ctx, bool=
 ebpf_from_cbpf)
> >        *
> >        */
> >
> > +     emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx=
);
> > +     const int idx0 =3D ctx->idx;
> > +
> >       /* bpf function may be invoked by 3 instruction types:
> >        * 1. bl, attached via freplace to bpf prog via short jump
> >        * 2. br, attached via freplace to bpf prog via long jump
> > @@ -2009,9 +2018,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_p=
rog *prog)
> >               jit_data->ro_header =3D ro_header;
> >       }
> >
> > -     prog->bpf_func =3D (void *)ctx.ro_image;
> > +     prog->bpf_func =3D (void *)ctx.ro_image + cfi_get_offset();
> >       prog->jited =3D 1;
> > -     prog->jited_len =3D prog_size;
> > +     prog->jited_len =3D prog_size - cfi_get_offset();
>
> Why do we add the offset even when CONFIG_CFI_CLANG is not enabled?

The function returns zero if CFI is not enabled, so I believe it's
just to avoid extra if (IS_ENABLED(CONFIG_CFI_CLANG)) statements in
the code. IMO this is cleaner, but I can certainly change this if you
prefer.

Thanks for taking a look!

Sami

