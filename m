Return-Path: <bpf+bounces-65047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC066B1B273
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 13:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 693377AAE26
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 11:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965DB245005;
	Tue,  5 Aug 2025 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0Dnbh2u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB023CB;
	Tue,  5 Aug 2025 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754392399; cv=none; b=U4o5wlGZIX7p3hHhIkuSTVb+v9rq8jbWrZPqvZLmRtKxYLkd9U9HvxBiR2xSBcC6GOX2jBECHtD/e+5r7TMBeRK1PM2NLzUNwAhwj8VjbDDSY1O4sm5aXINxggw7v4BiQeMBSDuIivDqeq1o/S5nLfxD30jfzMBeIdS4S5qET8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754392399; c=relaxed/simple;
	bh=RFcRESqUpkogxrGw4VvRhqTb5GHVfoyAmffD4nuh4as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKONqWVLaXvsWCBNbMHjKDjb8nZsuTkrNB4u1QQAM7Pkp9ewj+iJOEKyj4Lx+m36+RdfJKbQ2o22Gx9DXJSDMuLlf0lLd3u71Ts7DxGTtvfrzTeSMbJojugYE54h24uwDp1fnkFzLsSCX73o/7eoovQL2Lo7Msbh+2y0O9UOmKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0Dnbh2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDE6C4CEFA;
	Tue,  5 Aug 2025 11:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754392398;
	bh=RFcRESqUpkogxrGw4VvRhqTb5GHVfoyAmffD4nuh4as=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g0Dnbh2u3p+zXqKguTy4g8StE8pqg9ocHBFIv5ESjOshpTjHsEejqY8wZJ+ofAOOO
	 d9vRCSroQUln6LxCJju6O3+Teg00fXYVXUSVlvRSjcLAOeIUpIL4IkdsEm4rEX4fOt
	 zIzxuAxUv5HtVQpHm1z0+ZcoysMjzERkyDwB7/EZ3PZmuGb4UH8TJ+qwLkv2OqVhve
	 dOimU5rd4W0PaoW8qqsXgT8dqeSXbfBB4T8OTLvbWvYzEIiAL0cy4kYdB0Arbj1hqW
	 OxKv2VMHu2qw7sxWG4dPuwTiu98scrvgWfzQF+pdIdC0tZqHAQA37AsoAv7SyTBhDO
	 coEhRv/6Qxe2g==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61530559887so7258123a12.1;
        Tue, 05 Aug 2025 04:13:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlCy9jrkn8e6CodAjCnGeMiGGcQDhJ5S/oVRULZZzXCVe4Q8ovKQ9g8WmuFs/S+Rx4+ik=@vger.kernel.org, AJvYcCVpMnmlymZqtwpvuEnBSzfUGyCN0oRSMm9L9wXQSIzxQFyVy6Bq9+r9zY/triF0XpPa3zJ1Uwo6FNkvT5SL@vger.kernel.org
X-Gm-Message-State: AOJu0YwXutJnixFUFRVIXVz6T/560RpJvcVB9WrvczV8XEA1VWQP4zvB
	iGJc4q8I74iR12uZ1IEd4s4IFVm+3zqTSPtaGEEnDzn5NqVdOwmp5qdCLeP1CpxGrA5VRzVEdZD
	iKr92fFS1Gmr98IEtlc6JH1KoR0xE3hQ=
X-Google-Smtp-Source: AGHT+IEfNL59yghY3uqGFNzFVFKXAzUzfJesNHxLgKbcIjdTdDvjQKf2m/l27tCO8YVAuWn1J0NaMWz4P6rzkNxEiCk=
X-Received: by 2002:a05:6402:3593:b0:60e:404:a931 with SMTP id
 4fb4d7f45d1cf-615e6f015fcmr11564780a12.15.1754392397212; Tue, 05 Aug 2025
 04:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730131257.124153-1-duanchenghao@kylinos.cn>
 <20250730131257.124153-4-duanchenghao@kylinos.cn> <CAEyhmHTE8yd0-N5YkMvJScv+Dsw3sAvgyZt8h1sd1=rzaCoTwQ@mail.gmail.com>
 <CAAhV-H55VoFdK8B-PBhYfzHAOQJLnOxLUZGZyHqqdvt=5K3Zhg@mail.gmail.com> <20250805063014.GA543627@chenghao-pc>
In-Reply-To: <20250805063014.GA543627@chenghao-pc>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 5 Aug 2025 19:13:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4W6z2CRBJ2VDsKTmmGNS+NmfH4aZCRB6K9+XQ4i3vPCA@mail.gmail.com>
X-Gm-Features: Ac12FXxRva0sY7oLsQiu-9qYHIn5ht6xkElgXXAS-LtQVDIo4QcHUP2VeyHczUg
Message-ID: <CAAhV-H4W6z2CRBJ2VDsKTmmGNS+NmfH4aZCRB6K9+XQ4i3vPCA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] LoongArch: BPF: Implement dynamic code
 modification support
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yangtiezhu@loongson.cn, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn, 
	vincent.mc.li@gmail.com, geliang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 2:30=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos.=
cn> wrote:
>
> On Tue, Aug 05, 2025 at 12:10:05PM +0800, Huacai Chen wrote:
> > On Mon, Aug 4, 2025 at 10:02=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.=
com> wrote:
> > >
> > > On Wed, Jul 30, 2025 at 9:13=E2=80=AFPM Chenghao Duan <duanchenghao@k=
ylinos.cn> wrote:
> > > >
> > > > This commit adds support for BPF dynamic code modification on the
> > > > LoongArch architecture.:
> > > > 1. Implement bpf_arch_text_poke() for runtime instruction patching.
> > > > 2. Add bpf_arch_text_copy() for instruction block copying.
> > > > 3. Create bpf_arch_text_invalidate() for code invalidation.
> > > >
> > > > On LoongArch, since symbol addresses in the direct mapping
> > > > region cannot be reached via relative jump instructions from the pa=
ged
> > > > mapping region, we use the move_imm+jirl instruction pair as absolu=
te
> > > > jump instructions. These require 2-5 instructions, so we reserve 5 =
NOP
> > > > instructions in the program as placeholders for function jumps.
> > > >
> > > > larch_insn_text_copy is solely used for BPF. The use of
> > > > larch_insn_text_copy() requires page_size alignment. Currently, onl=
y
> > > > the size of the trampoline is page-aligned.
> > > >
> > > > Co-developed-by: George Guo <guodongtai@kylinos.cn>
> > > > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > > > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > > > ---
> > > >  arch/loongarch/include/asm/inst.h |   1 +
> > > >  arch/loongarch/kernel/inst.c      |  27 ++++++++
> > > >  arch/loongarch/net/bpf_jit.c      | 104 ++++++++++++++++++++++++++=
++++
> > > >  3 files changed, 132 insertions(+)
> > > >
> > > > diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/inc=
lude/asm/inst.h
> > > > index 2ae96a35d..88bb73e46 100644
> > > > --- a/arch/loongarch/include/asm/inst.h
> > > > +++ b/arch/loongarch/include/asm/inst.h
> > > > @@ -497,6 +497,7 @@ void arch_simulate_insn(union loongarch_instruc=
tion insn, struct pt_regs *regs);
> > > >  int larch_insn_read(void *addr, u32 *insnp);
> > > >  int larch_insn_write(void *addr, u32 insn);
> > > >  int larch_insn_patch_text(void *addr, u32 insn);
> > > > +int larch_insn_text_copy(void *dst, void *src, size_t len);
> > > >
> > > >  u32 larch_insn_gen_nop(void);
> > > >  u32 larch_insn_gen_b(unsigned long pc, unsigned long dest);
> > > > diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/i=
nst.c
> > > > index 674e3b322..7df63a950 100644
> > > > --- a/arch/loongarch/kernel/inst.c
> > > > +++ b/arch/loongarch/kernel/inst.c
> > > > @@ -4,6 +4,7 @@
> > > >   */
> > > >  #include <linux/sizes.h>
> > > >  #include <linux/uaccess.h>
> > > > +#include <linux/set_memory.h>
> > > >
> > > >  #include <asm/cacheflush.h>
> > > >  #include <asm/inst.h>
> > > > @@ -218,6 +219,32 @@ int larch_insn_patch_text(void *addr, u32 insn=
)
> > > >         return ret;
> > > >  }
> > > >
> > > > +int larch_insn_text_copy(void *dst, void *src, size_t len)
> > > > +{
> > > > +       int ret;
> > > > +       unsigned long flags;
> > > > +       unsigned long dst_start, dst_end, dst_len;
> > > > +
> > > > +       dst_start =3D round_down((unsigned long)dst, PAGE_SIZE);
> > > > +       dst_end =3D round_up((unsigned long)dst + len, PAGE_SIZE);
> > > > +       dst_len =3D dst_end - dst_start;
> > > > +
> > > > +       set_memory_rw(dst_start, dst_len / PAGE_SIZE);
> > > > +       raw_spin_lock_irqsave(&patch_lock, flags);
> > > > +
> > > > +       ret =3D copy_to_kernel_nofault(dst, src, len);
> > > > +       if (ret)
> > > > +               pr_err("%s: operation failed\n", __func__);
> > > > +
> > > > +       raw_spin_unlock_irqrestore(&patch_lock, flags);
> > > > +       set_memory_rox(dst_start, dst_len / PAGE_SIZE);
> > > > +
> > > > +       if (!ret)
> > > > +               flush_icache_range((unsigned long)dst, (unsigned lo=
ng)dst + len);
> > > > +
> > > > +       return ret;
> > > > +}
> > > > +
> > > >  u32 larch_insn_gen_nop(void)
> > > >  {
> > > >         return INSN_NOP;
> > > > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_=
jit.c
> > > > index 7032f11d3..5e6ae7e0e 100644
> > > > --- a/arch/loongarch/net/bpf_jit.c
> > > > +++ b/arch/loongarch/net/bpf_jit.c
> > > > @@ -4,8 +4,12 @@
> > > >   *
> > > >   * Copyright (C) 2022 Loongson Technology Corporation Limited
> > > >   */
> > > > +#include <linux/memory.h>
> > > >  #include "bpf_jit.h"
> > > >
> > > > +#define LOONGARCH_LONG_JUMP_NINSNS 5
> > > > +#define LOONGARCH_LONG_JUMP_NBYTES (LOONGARCH_LONG_JUMP_NINSNS * 4=
)
> > > > +
> > > >  #define REG_TCC                LOONGARCH_GPR_A6
> > > >  #define TCC_SAVED      LOONGARCH_GPR_S5
> > > >
> > > > @@ -88,6 +92,7 @@ static u8 tail_call_reg(struct jit_ctx *ctx)
> > > >   */
> > > >  static void build_prologue(struct jit_ctx *ctx)
> > > >  {
> > > > +       int i;
> > > >         int stack_adjust =3D 0, store_offset, bpf_stack_adjust;
> > > >
> > > >         bpf_stack_adjust =3D round_up(ctx->prog->aux->stack_depth, =
16);
> > > > @@ -98,6 +103,10 @@ static void build_prologue(struct jit_ctx *ctx)
> > > >         stack_adjust =3D round_up(stack_adjust, 16);
> > > >         stack_adjust +=3D bpf_stack_adjust;
> > > >
> > > > +       /* Reserve space for the move_imm + jirl instruction */
> > > > +       for (i =3D 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
> > > > +               emit_insn(ctx, nop);
> > > > +
> > > >         /*
> > > >          * First instruction initializes the tail call count (TCC).
> > > >          * On tail call we skip this instruction, and the TCC is
> > > > @@ -1367,3 +1376,98 @@ bool bpf_jit_supports_subprog_tailcalls(void=
)
> > > >  {
> > > >         return true;
> > > >  }
> > > > +
> > > > +static int emit_jump_and_link(struct jit_ctx *ctx, u8 rd, u64 targ=
et)
> > > > +{
> > > > +       if (!target) {
> > > > +               pr_err("bpf_jit: jump target address is error\n");
> > > > +               return -EFAULT;
> > > > +       }
> > > > +
> > > > +       move_imm(ctx, LOONGARCH_GPR_T1, target, false);
> > > > +       emit_insn(ctx, jirl, rd, LOONGARCH_GPR_T1, 0);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int gen_jump_or_nops(void *target, void *ip, u32 *insns, bo=
ol is_call)
> > > > +{
> > > > +       struct jit_ctx ctx;
> > > > +
> > > > +       ctx.idx =3D 0;
> > > > +       ctx.image =3D (union loongarch_instruction *)insns;
> > > > +
> > > > +       if (!target) {
> > > > +               emit_insn((&ctx), nop);
> > > > +               emit_insn((&ctx), nop);
> > >
> > > There should be 5 nops, no ?
> > Chenghao,
> >
> > We have already fixed the concurrent problem, now this is the only
> > issue, please reply tas soon as possible.
> >
> > Huacai
>
> Hi Hengqi & Huacai,
>
> I'm sorry I just saw the email.
> This position can be configured with 5 NOP instructions, and I have
> tested it successfully.
OK, now loongarch-next [1] has integrated all needed changes, you and
Vincent can test to see if everything is OK.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongs=
on.git/log/?h=3Dloongarch-next

Huacai

>
> sudo ./test_progs -a fentry_test/fentry
> sudo ./test_progs -a fexit_test/fexit
> sudo ./test_progs -a fentry_fexit
> sudo ./test_progs -a modify_return
> sudo ./test_progs -a fexit_sleep
> sudo ./test_progs -a test_overhead
> sudo ./test_progs -a trampoline_count
> sudo ./test_progs -a fexit_bpf2bpf
>
> if (!target) {
>         int i;
>         for (i =3D 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
>                 emit_insn((&ctx), nop);
>         return 0;
> }
>
>
> Chenghao
>
> >
> > >
> > > > +               return 0;
> > > > +       }
> > > > +
> > > > +       return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_T0 =
: LOONGARCH_GPR_ZERO,
> > > > +                                 (unsigned long)target);
> > > > +}
> > > > +
> > > > +int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type=
,
> > > > +                      void *old_addr, void *new_addr)
> > > > +{
> > > > +       u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =
=3D INSN_NOP};
> > > > +       u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =
=3D INSN_NOP};
> > > > +       bool is_call =3D poke_type =3D=3D BPF_MOD_CALL;
> > > > +       int ret;
> > > > +
> > > > +       if (!is_kernel_text((unsigned long)ip) &&
> > > > +               !is_bpf_text_address((unsigned long)ip))
> > > > +               return -ENOTSUPP;
> > > > +
> > > > +       ret =3D gen_jump_or_nops(old_addr, ip, old_insns, is_call);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       if (memcmp(ip, old_insns, LOONGARCH_LONG_JUMP_NBYTES))
> > > > +               return -EFAULT;
> > > > +
> > > > +       ret =3D gen_jump_or_nops(new_addr, ip, new_insns, is_call);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       mutex_lock(&text_mutex);
> > > > +       if (memcmp(ip, new_insns, LOONGARCH_LONG_JUMP_NBYTES))
> > > > +               ret =3D larch_insn_text_copy(ip, new_insns, LOONGAR=
CH_LONG_JUMP_NBYTES);
> > > > +       mutex_unlock(&text_mutex);
> > > > +       return ret;
> > > > +}
> > > > +
> > > > +int bpf_arch_text_invalidate(void *dst, size_t len)
> > > > +{
> > > > +       int i;
> > > > +       int ret =3D 0;
> > > > +       u32 *inst;
> > > > +
> > > > +       inst =3D kvmalloc(len, GFP_KERNEL);
> > > > +       if (!inst)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       for (i =3D 0; i < (len/sizeof(u32)); i++)
> > > > +               inst[i] =3D INSN_BREAK;
> > > > +
> > > > +       mutex_lock(&text_mutex);
> > > > +       if (larch_insn_text_copy(dst, inst, len))
> > > > +               ret =3D -EINVAL;
> > > > +       mutex_unlock(&text_mutex);
> > > > +
> > > > +       kvfree(inst);
> > > > +       return ret;
> > > > +}
> > > > +
> > > > +void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> > > > +{
> > > > +       int ret;
> > > > +
> > > > +       mutex_lock(&text_mutex);
> > > > +       ret =3D larch_insn_text_copy(dst, src, len);
> > > > +       mutex_unlock(&text_mutex);
> > > > +       if (ret)
> > > > +               return ERR_PTR(-EINVAL);
> > > > +
> > > > +       return dst;
> > > > +}
> > > > --
> > >
> > > bpf_arch_text_invalidate() and bpf_arch_text_copy() is not related to
> > > BPF trampoline, right ?
>
> From the perspective of BPF core source code calls, the two functions
> bpf_arch_text_invalidate() and bpf_arch_text_copy() are not only used for
> trampolines.
>
> > >
> > > > 2.25.1
> > > >
>

