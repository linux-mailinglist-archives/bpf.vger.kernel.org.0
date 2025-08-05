Return-Path: <bpf+bounces-65023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A10B1AD07
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 06:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB058189DD2C
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 04:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E326D20101D;
	Tue,  5 Aug 2025 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQc5omiK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA31191;
	Tue,  5 Aug 2025 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754367017; cv=none; b=jEeXSeNr9gL0k0H0wjCK8jSMaoR7+eJJDZulLF8bhK15Pr4R7eDjU81tR82b1jVku1eaQUYNaQooQYgqsxUz3kFGkuB87sIoNARQ7Kb72UsuLUuiY5V5UXLH+IDjFXD0XzpYbwMYmurb8HdUX4c/EtD8Wo6exEI/weNtd6Jbh4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754367017; c=relaxed/simple;
	bh=64P8pSgWRTEQfuAptx9GYG4bN1DE4P+iylnftchW8Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isbPXl7FN1y+rbycskKJkE6+285k3AwxkPwqvKONfyThoe7e5seKzposPHm6Eg1IzdLb3RJIBp36JI3aig7XDRx6Zy8RWi4OlhNiddPZEMAyZrq1Mb5Q0etpoVfareQePZGZvIscaRQ6XZboS5mVtUsW6E62DNbnDCjyCAPyLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQc5omiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2A9C4CEF9;
	Tue,  5 Aug 2025 04:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754367017;
	bh=64P8pSgWRTEQfuAptx9GYG4bN1DE4P+iylnftchW8Dk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KQc5omiKKrrFCPFfxkOCKcP9Tjw0AwYD0W/VcP6iYlA5zlQogHbMHwhsxVq7zvEWH
	 5NnvMpPrjOKsmGMQ1dXgk9D4aoga4Hy6STgn6n1VnmN93/UVQx+CapuZje2ZUhIU84
	 4wV67CSlFkP8316sdFso0uJsAFUEpicbyYaMQKAnbjRMSY8ip0UxiJ/o9nECvpX2OU
	 a70OIyppCqVp+FymgTIOujkqKpNvMUukVwE0X5JuTC/5v4uxFn2X++eND3kcLP7N+1
	 AocxH4jLvooePHLV+Jk6dPfxRIHSKhgyfjNY2iaCHC2+KkSRXl8Vle0B2+MVRzkgnc
	 72MbiSFZiSC9A==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-615c29fc31eso8028316a12.0;
        Mon, 04 Aug 2025 21:10:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWA7MPIPZAVqmKyXUUxspdtXUvfSzDc6Musl7ddCIkquQA4U+kA9v60FChSjJImogYCdzY=@vger.kernel.org, AJvYcCWrn4FHNWLqQXZE+GTzPuS/Feq9jKfQLaZD7FFTdfV+yE5VwzTSuFpb8FOoEc+pR+4Fym99E3mClCr/NDwB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7xuY+f2P/wcDY2oxmr2tQq2Kxau03MfJOl/+aLgPSSaU2QMTH
	VdJFK+POgCpfhI9QIiwCOQ1NawA9SjfDJkV4Hy1QUgspg4NWfMH2bycmKz24e+zYWPHpF8ye2Or
	tKJ/C9avOEevVAt58mRbaVB7N4Qo4mXc=
X-Google-Smtp-Source: AGHT+IFFdGalkzEDOhiMqtySgAjMgg9p+qGKfo/qw4KsE/XtJQIeY6lgS3iyyM262Zz1WGqIcPLLmlKJrB5Jb5T27+E=
X-Received: by 2002:a05:6402:3513:b0:612:b552:5a4d with SMTP id
 4fb4d7f45d1cf-615e6f5193fmr10341888a12.17.1754367015478; Mon, 04 Aug 2025
 21:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730131257.124153-1-duanchenghao@kylinos.cn>
 <20250730131257.124153-4-duanchenghao@kylinos.cn> <CAEyhmHTE8yd0-N5YkMvJScv+Dsw3sAvgyZt8h1sd1=rzaCoTwQ@mail.gmail.com>
In-Reply-To: <CAEyhmHTE8yd0-N5YkMvJScv+Dsw3sAvgyZt8h1sd1=rzaCoTwQ@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 5 Aug 2025 12:10:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H55VoFdK8B-PBhYfzHAOQJLnOxLUZGZyHqqdvt=5K3Zhg@mail.gmail.com>
X-Gm-Features: Ac12FXyzsU_qg2XlgmRI5NlJB2DhVAs82VKcpEOI79jGgaztykcOv6GwsUIaeak
Message-ID: <CAAhV-H55VoFdK8B-PBhYfzHAOQJLnOxLUZGZyHqqdvt=5K3Zhg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] LoongArch: BPF: Implement dynamic code
 modification support
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Chenghao Duan <duanchenghao@kylinos.cn>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yangtiezhu@loongson.cn, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn, 
	vincent.mc.li@gmail.com, geliang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 10:02=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> On Wed, Jul 30, 2025 at 9:13=E2=80=AFPM Chenghao Duan <duanchenghao@kylin=
os.cn> wrote:
> >
> > This commit adds support for BPF dynamic code modification on the
> > LoongArch architecture.:
> > 1. Implement bpf_arch_text_poke() for runtime instruction patching.
> > 2. Add bpf_arch_text_copy() for instruction block copying.
> > 3. Create bpf_arch_text_invalidate() for code invalidation.
> >
> > On LoongArch, since symbol addresses in the direct mapping
> > region cannot be reached via relative jump instructions from the paged
> > mapping region, we use the move_imm+jirl instruction pair as absolute
> > jump instructions. These require 2-5 instructions, so we reserve 5 NOP
> > instructions in the program as placeholders for function jumps.
> >
> > larch_insn_text_copy is solely used for BPF. The use of
> > larch_insn_text_copy() requires page_size alignment. Currently, only
> > the size of the trampoline is page-aligned.
> >
> > Co-developed-by: George Guo <guodongtai@kylinos.cn>
> > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > ---
> >  arch/loongarch/include/asm/inst.h |   1 +
> >  arch/loongarch/kernel/inst.c      |  27 ++++++++
> >  arch/loongarch/net/bpf_jit.c      | 104 ++++++++++++++++++++++++++++++
> >  3 files changed, 132 insertions(+)
> >
> > diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include=
/asm/inst.h
> > index 2ae96a35d..88bb73e46 100644
> > --- a/arch/loongarch/include/asm/inst.h
> > +++ b/arch/loongarch/include/asm/inst.h
> > @@ -497,6 +497,7 @@ void arch_simulate_insn(union loongarch_instruction=
 insn, struct pt_regs *regs);
> >  int larch_insn_read(void *addr, u32 *insnp);
> >  int larch_insn_write(void *addr, u32 insn);
> >  int larch_insn_patch_text(void *addr, u32 insn);
> > +int larch_insn_text_copy(void *dst, void *src, size_t len);
> >
> >  u32 larch_insn_gen_nop(void);
> >  u32 larch_insn_gen_b(unsigned long pc, unsigned long dest);
> > diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.=
c
> > index 674e3b322..7df63a950 100644
> > --- a/arch/loongarch/kernel/inst.c
> > +++ b/arch/loongarch/kernel/inst.c
> > @@ -4,6 +4,7 @@
> >   */
> >  #include <linux/sizes.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/set_memory.h>
> >
> >  #include <asm/cacheflush.h>
> >  #include <asm/inst.h>
> > @@ -218,6 +219,32 @@ int larch_insn_patch_text(void *addr, u32 insn)
> >         return ret;
> >  }
> >
> > +int larch_insn_text_copy(void *dst, void *src, size_t len)
> > +{
> > +       int ret;
> > +       unsigned long flags;
> > +       unsigned long dst_start, dst_end, dst_len;
> > +
> > +       dst_start =3D round_down((unsigned long)dst, PAGE_SIZE);
> > +       dst_end =3D round_up((unsigned long)dst + len, PAGE_SIZE);
> > +       dst_len =3D dst_end - dst_start;
> > +
> > +       set_memory_rw(dst_start, dst_len / PAGE_SIZE);
> > +       raw_spin_lock_irqsave(&patch_lock, flags);
> > +
> > +       ret =3D copy_to_kernel_nofault(dst, src, len);
> > +       if (ret)
> > +               pr_err("%s: operation failed\n", __func__);
> > +
> > +       raw_spin_unlock_irqrestore(&patch_lock, flags);
> > +       set_memory_rox(dst_start, dst_len / PAGE_SIZE);
> > +
> > +       if (!ret)
> > +               flush_icache_range((unsigned long)dst, (unsigned long)d=
st + len);
> > +
> > +       return ret;
> > +}
> > +
> >  u32 larch_insn_gen_nop(void)
> >  {
> >         return INSN_NOP;
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index 7032f11d3..5e6ae7e0e 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -4,8 +4,12 @@
> >   *
> >   * Copyright (C) 2022 Loongson Technology Corporation Limited
> >   */
> > +#include <linux/memory.h>
> >  #include "bpf_jit.h"
> >
> > +#define LOONGARCH_LONG_JUMP_NINSNS 5
> > +#define LOONGARCH_LONG_JUMP_NBYTES (LOONGARCH_LONG_JUMP_NINSNS * 4)
> > +
> >  #define REG_TCC                LOONGARCH_GPR_A6
> >  #define TCC_SAVED      LOONGARCH_GPR_S5
> >
> > @@ -88,6 +92,7 @@ static u8 tail_call_reg(struct jit_ctx *ctx)
> >   */
> >  static void build_prologue(struct jit_ctx *ctx)
> >  {
> > +       int i;
> >         int stack_adjust =3D 0, store_offset, bpf_stack_adjust;
> >
> >         bpf_stack_adjust =3D round_up(ctx->prog->aux->stack_depth, 16);
> > @@ -98,6 +103,10 @@ static void build_prologue(struct jit_ctx *ctx)
> >         stack_adjust =3D round_up(stack_adjust, 16);
> >         stack_adjust +=3D bpf_stack_adjust;
> >
> > +       /* Reserve space for the move_imm + jirl instruction */
> > +       for (i =3D 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
> > +               emit_insn(ctx, nop);
> > +
> >         /*
> >          * First instruction initializes the tail call count (TCC).
> >          * On tail call we skip this instruction, and the TCC is
> > @@ -1367,3 +1376,98 @@ bool bpf_jit_supports_subprog_tailcalls(void)
> >  {
> >         return true;
> >  }
> > +
> > +static int emit_jump_and_link(struct jit_ctx *ctx, u8 rd, u64 target)
> > +{
> > +       if (!target) {
> > +               pr_err("bpf_jit: jump target address is error\n");
> > +               return -EFAULT;
> > +       }
> > +
> > +       move_imm(ctx, LOONGARCH_GPR_T1, target, false);
> > +       emit_insn(ctx, jirl, rd, LOONGARCH_GPR_T1, 0);
> > +
> > +       return 0;
> > +}
> > +
> > +static int gen_jump_or_nops(void *target, void *ip, u32 *insns, bool i=
s_call)
> > +{
> > +       struct jit_ctx ctx;
> > +
> > +       ctx.idx =3D 0;
> > +       ctx.image =3D (union loongarch_instruction *)insns;
> > +
> > +       if (!target) {
> > +               emit_insn((&ctx), nop);
> > +               emit_insn((&ctx), nop);
>
> There should be 5 nops, no ?
Chenghao,

We have already fixed the concurrent problem, now this is the only
issue, please reply tas soon as possible.

Huacai

>
> > +               return 0;
> > +       }
> > +
> > +       return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_T0 : LO=
ONGARCH_GPR_ZERO,
> > +                                 (unsigned long)target);
> > +}
> > +
> > +int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
> > +                      void *old_addr, void *new_addr)
> > +{
> > +       u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D IN=
SN_NOP};
> > +       u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D IN=
SN_NOP};
> > +       bool is_call =3D poke_type =3D=3D BPF_MOD_CALL;
> > +       int ret;
> > +
> > +       if (!is_kernel_text((unsigned long)ip) &&
> > +               !is_bpf_text_address((unsigned long)ip))
> > +               return -ENOTSUPP;
> > +
> > +       ret =3D gen_jump_or_nops(old_addr, ip, old_insns, is_call);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (memcmp(ip, old_insns, LOONGARCH_LONG_JUMP_NBYTES))
> > +               return -EFAULT;
> > +
> > +       ret =3D gen_jump_or_nops(new_addr, ip, new_insns, is_call);
> > +       if (ret)
> > +               return ret;
> > +
> > +       mutex_lock(&text_mutex);
> > +       if (memcmp(ip, new_insns, LOONGARCH_LONG_JUMP_NBYTES))
> > +               ret =3D larch_insn_text_copy(ip, new_insns, LOONGARCH_L=
ONG_JUMP_NBYTES);
> > +       mutex_unlock(&text_mutex);
> > +       return ret;
> > +}
> > +
> > +int bpf_arch_text_invalidate(void *dst, size_t len)
> > +{
> > +       int i;
> > +       int ret =3D 0;
> > +       u32 *inst;
> > +
> > +       inst =3D kvmalloc(len, GFP_KERNEL);
> > +       if (!inst)
> > +               return -ENOMEM;
> > +
> > +       for (i =3D 0; i < (len/sizeof(u32)); i++)
> > +               inst[i] =3D INSN_BREAK;
> > +
> > +       mutex_lock(&text_mutex);
> > +       if (larch_insn_text_copy(dst, inst, len))
> > +               ret =3D -EINVAL;
> > +       mutex_unlock(&text_mutex);
> > +
> > +       kvfree(inst);
> > +       return ret;
> > +}
> > +
> > +void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> > +{
> > +       int ret;
> > +
> > +       mutex_lock(&text_mutex);
> > +       ret =3D larch_insn_text_copy(dst, src, len);
> > +       mutex_unlock(&text_mutex);
> > +       if (ret)
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       return dst;
> > +}
> > --
>
> bpf_arch_text_invalidate() and bpf_arch_text_copy() is not related to
> BPF trampoline, right ?
>
> > 2.25.1
> >

