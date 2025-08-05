Return-Path: <bpf+bounces-65062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EA4B1B527
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 15:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77CE1838A2
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 13:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68006275B0D;
	Tue,  5 Aug 2025 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4VAP8s9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E2D27584C;
	Tue,  5 Aug 2025 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401354; cv=none; b=VFWnt/WG4HCc0woB7yhc4aPOPOFzVZzm2ocsTHv+NIHUXHLztP7+QeGujf07Wvpu8MaMs+7Lkn9iggpDK1sRnHCAVHBv6RlHbUrv/NW+1AitAcd9SG/XNEUkwwech6nADBE5ER19xhhwFxlOAds8mCWqBETDA0gsCnzEaAHTfNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401354; c=relaxed/simple;
	bh=jiWRZlu30KCgc0bW1cXmyzwwH+9OjcHfP9ALGv6NbW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpQiN+JsuluaaAJf46WMzw7Qvn1v5ljXrHSAK3w7z5G+NtSY4dHxbzjohJYsGVlUqA8H+FdaovG4llViwMexxZenuD5Fl+m1IjKNjtb/UkLnUq5HEJ0iS/44N2huQ45xuGKcgHlgHObWdFPbVckLzL9F/iJCeAi6F7w4iaNoUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4VAP8s9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4aeb2f73fc0so52584691cf.2;
        Tue, 05 Aug 2025 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754401350; x=1755006150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tqW6prf2C3KdFtzF3A5CcH40D2BcXOPzZkaGzsQogs=;
        b=D4VAP8s98Z5xMJ1gnfrVur0dZO1kK+sWCLWAz2GLTGrz9039h/ai5EWXblWADiK5W3
         24NuibVWRSMDdUQo20TaCrpqytn6NnbZc4fSLi8s1551xbcpji/T4WKF2ykTJX3Wfm4q
         tqAI0WzaoDRoYcpMljVgItOLrnZocSX8re0QzSyD7xbU8CaaBLENpm5Vrgl1urBgVLo+
         kH3vjIT74Icv1C+rScrr7PZce+O1mA/V94Q9fKVJOJYYjBIM62benjFggKpCGRbrVWQr
         lX5B2u31K+RfHoI0I+0XTJG+PYjjy/aNu+XeaBfty7rgQDgHybhbGHm7dZaCMT2Lpsyz
         sKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754401350; x=1755006150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tqW6prf2C3KdFtzF3A5CcH40D2BcXOPzZkaGzsQogs=;
        b=gkhoQM+g/CqS2zB1WQ/9UlaW+DE8IuxeAsUGuwzyOn9pGm9zfQU5jjND6Rjsy5PdH4
         p/TmTGSsO1dYrV/lQLcYhpFG6YZK4Hbx/ZaTt1nc0n5gpFSqiH7n67mc0NjyrXNi1zLY
         aaH6XzqWtfVXIL+moW8g9F5ZlGIDkZcJBS2uULcxyn/3b8KYAxpVqbZIX6PwKivR1009
         sjJciW5LzY7Y7ex6cRK4QYe1IknlFmdrkel2R+qFZpqHQqn8jzB/SOl3VOxGjJwYf+6H
         T3/9wERC1grcL5XUWXbLsRNvYc6jzxpzzn7oiHTAleD3ClbSgroiTb5vKAhCe/oD1CzC
         dovg==
X-Forwarded-Encrypted: i=1; AJvYcCUPMy87f/BrP2N9TpB5puUttaUBIhd99Oy0/Ju69qQpvrYZKvuXt1pMXs3IQlvr7s3Q8YY=@vger.kernel.org, AJvYcCXas3ELqYkm19YPSEjsj/bVkjPtd/tKKcTLtsf8MvgloRetQTAY5kv/rSNLz95zihvZKux4EigR1RK8OWrv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Y0pfKDn3HXQA7gR5CY1beK9+VZIeiWsSW9uSh2ItDSklgDZe
	LtAire6xZgAx+H7RsyCuAywhcQ62NqgIQgUnMZl/VtinzZFt+IW8VsMXcYIwEgmBF+dVAGDf7+5
	ESafz7iVNsOBOfqu63mggaq9ccuhzgYc=
X-Gm-Gg: ASbGncsinR6lFvoDFTQLoT3QOMbv7dkWAbKYbyqueOB3pj85i5Cv/+SJyH1vqF9/e/6
	KilSkG1oRTyUu7C/E8GDA+mIwO3l85G4kWcsnw6ec1QSQC4//iKYQtEEtq/jsY3QSW+0k8L1G8t
	abPNbqIMqKHzlrw6c49gtDU4mx5CwDn31V8/HMwm6rV1v8nDQpfLjm+ZZab5+iUouYgWyedpPqQ
	LmGyzo=
X-Google-Smtp-Source: AGHT+IGrQcY12vRWP7gowk1Nks+lt6a2YGRtJlkkMeGyN7pv8Ai/zBG8ooVw/Sp4UQnK+kFf4YCyfypD3T99/Sp8qPQ=
X-Received: by 2002:a05:622a:648:b0:4b0:7e88:8cd3 with SMTP id
 d75a77b69052e-4b07e889188mr49195961cf.34.1754401349437; Tue, 05 Aug 2025
 06:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730131257.124153-1-duanchenghao@kylinos.cn>
 <20250730131257.124153-4-duanchenghao@kylinos.cn> <CAEyhmHTE8yd0-N5YkMvJScv+Dsw3sAvgyZt8h1sd1=rzaCoTwQ@mail.gmail.com>
 <CAAhV-H55VoFdK8B-PBhYfzHAOQJLnOxLUZGZyHqqdvt=5K3Zhg@mail.gmail.com>
 <20250805063014.GA543627@chenghao-pc> <CAAhV-H4W6z2CRBJ2VDsKTmmGNS+NmfH4aZCRB6K9+XQ4i3vPCA@mail.gmail.com>
In-Reply-To: <CAAhV-H4W6z2CRBJ2VDsKTmmGNS+NmfH4aZCRB6K9+XQ4i3vPCA@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Tue, 5 Aug 2025 06:42:17 -0700
X-Gm-Features: Ac12FXxGXbn8ATQiQdyqqOFnSullYE9xAtYRrrJlWDYEI3JCfvaDdXd3edk3VY8
Message-ID: <CAK3+h2wGeVFuzpUroiPcOGt9Tu76fV=aZMFy6yxub8MOF569YQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] LoongArch: BPF: Implement dynamic code
 modification support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Chenghao Duan <duanchenghao@kylinos.cn>, Hengqi Chen <hengqi.chen@gmail.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, yangtiezhu@loongson.cn, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn, 
	geliang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 4:13=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org> =
wrote:
>
> On Tue, Aug 5, 2025 at 2:30=E2=80=AFPM Chenghao Duan <duanchenghao@kylino=
s.cn> wrote:
> >
> > On Tue, Aug 05, 2025 at 12:10:05PM +0800, Huacai Chen wrote:
> > > On Mon, Aug 4, 2025 at 10:02=E2=80=AFAM Hengqi Chen <hengqi.chen@gmai=
l.com> wrote:
> > > >
> > > > On Wed, Jul 30, 2025 at 9:13=E2=80=AFPM Chenghao Duan <duanchenghao=
@kylinos.cn> wrote:
> > > > >
> > > > > This commit adds support for BPF dynamic code modification on the
> > > > > LoongArch architecture.:
> > > > > 1. Implement bpf_arch_text_poke() for runtime instruction patchin=
g.
> > > > > 2. Add bpf_arch_text_copy() for instruction block copying.
> > > > > 3. Create bpf_arch_text_invalidate() for code invalidation.
> > > > >
> > > > > On LoongArch, since symbol addresses in the direct mapping
> > > > > region cannot be reached via relative jump instructions from the =
paged
> > > > > mapping region, we use the move_imm+jirl instruction pair as abso=
lute
> > > > > jump instructions. These require 2-5 instructions, so we reserve =
5 NOP
> > > > > instructions in the program as placeholders for function jumps.
> > > > >
> > > > > larch_insn_text_copy is solely used for BPF. The use of
> > > > > larch_insn_text_copy() requires page_size alignment. Currently, o=
nly
> > > > > the size of the trampoline is page-aligned.
> > > > >
> > > > > Co-developed-by: George Guo <guodongtai@kylinos.cn>
> > > > > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > > > > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > > > > ---
> > > > >  arch/loongarch/include/asm/inst.h |   1 +
> > > > >  arch/loongarch/kernel/inst.c      |  27 ++++++++
> > > > >  arch/loongarch/net/bpf_jit.c      | 104 ++++++++++++++++++++++++=
++++++
> > > > >  3 files changed, 132 insertions(+)
> > > > >
> > > > > diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/i=
nclude/asm/inst.h
> > > > > index 2ae96a35d..88bb73e46 100644
> > > > > --- a/arch/loongarch/include/asm/inst.h
> > > > > +++ b/arch/loongarch/include/asm/inst.h
> > > > > @@ -497,6 +497,7 @@ void arch_simulate_insn(union loongarch_instr=
uction insn, struct pt_regs *regs);
> > > > >  int larch_insn_read(void *addr, u32 *insnp);
> > > > >  int larch_insn_write(void *addr, u32 insn);
> > > > >  int larch_insn_patch_text(void *addr, u32 insn);
> > > > > +int larch_insn_text_copy(void *dst, void *src, size_t len);
> > > > >
> > > > >  u32 larch_insn_gen_nop(void);
> > > > >  u32 larch_insn_gen_b(unsigned long pc, unsigned long dest);
> > > > > diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel=
/inst.c
> > > > > index 674e3b322..7df63a950 100644
> > > > > --- a/arch/loongarch/kernel/inst.c
> > > > > +++ b/arch/loongarch/kernel/inst.c
> > > > > @@ -4,6 +4,7 @@
> > > > >   */
> > > > >  #include <linux/sizes.h>
> > > > >  #include <linux/uaccess.h>
> > > > > +#include <linux/set_memory.h>
> > > > >
> > > > >  #include <asm/cacheflush.h>
> > > > >  #include <asm/inst.h>
> > > > > @@ -218,6 +219,32 @@ int larch_insn_patch_text(void *addr, u32 in=
sn)
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > > +int larch_insn_text_copy(void *dst, void *src, size_t len)
> > > > > +{
> > > > > +       int ret;
> > > > > +       unsigned long flags;
> > > > > +       unsigned long dst_start, dst_end, dst_len;
> > > > > +
> > > > > +       dst_start =3D round_down((unsigned long)dst, PAGE_SIZE);
> > > > > +       dst_end =3D round_up((unsigned long)dst + len, PAGE_SIZE)=
;
> > > > > +       dst_len =3D dst_end - dst_start;
> > > > > +
> > > > > +       set_memory_rw(dst_start, dst_len / PAGE_SIZE);
> > > > > +       raw_spin_lock_irqsave(&patch_lock, flags);
> > > > > +
> > > > > +       ret =3D copy_to_kernel_nofault(dst, src, len);
> > > > > +       if (ret)
> > > > > +               pr_err("%s: operation failed\n", __func__);
> > > > > +
> > > > > +       raw_spin_unlock_irqrestore(&patch_lock, flags);
> > > > > +       set_memory_rox(dst_start, dst_len / PAGE_SIZE);
> > > > > +
> > > > > +       if (!ret)
> > > > > +               flush_icache_range((unsigned long)dst, (unsigned =
long)dst + len);
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > >  u32 larch_insn_gen_nop(void)
> > > > >  {
> > > > >         return INSN_NOP;
> > > > > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bp=
f_jit.c
> > > > > index 7032f11d3..5e6ae7e0e 100644
> > > > > --- a/arch/loongarch/net/bpf_jit.c
> > > > > +++ b/arch/loongarch/net/bpf_jit.c
> > > > > @@ -4,8 +4,12 @@
> > > > >   *
> > > > >   * Copyright (C) 2022 Loongson Technology Corporation Limited
> > > > >   */
> > > > > +#include <linux/memory.h>
> > > > >  #include "bpf_jit.h"
> > > > >
> > > > > +#define LOONGARCH_LONG_JUMP_NINSNS 5
> > > > > +#define LOONGARCH_LONG_JUMP_NBYTES (LOONGARCH_LONG_JUMP_NINSNS *=
 4)
> > > > > +
> > > > >  #define REG_TCC                LOONGARCH_GPR_A6
> > > > >  #define TCC_SAVED      LOONGARCH_GPR_S5
> > > > >
> > > > > @@ -88,6 +92,7 @@ static u8 tail_call_reg(struct jit_ctx *ctx)
> > > > >   */
> > > > >  static void build_prologue(struct jit_ctx *ctx)
> > > > >  {
> > > > > +       int i;
> > > > >         int stack_adjust =3D 0, store_offset, bpf_stack_adjust;
> > > > >
> > > > >         bpf_stack_adjust =3D round_up(ctx->prog->aux->stack_depth=
, 16);
> > > > > @@ -98,6 +103,10 @@ static void build_prologue(struct jit_ctx *ct=
x)
> > > > >         stack_adjust =3D round_up(stack_adjust, 16);
> > > > >         stack_adjust +=3D bpf_stack_adjust;
> > > > >
> > > > > +       /* Reserve space for the move_imm + jirl instruction */
> > > > > +       for (i =3D 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
> > > > > +               emit_insn(ctx, nop);
> > > > > +
> > > > >         /*
> > > > >          * First instruction initializes the tail call count (TCC=
).
> > > > >          * On tail call we skip this instruction, and the TCC is
> > > > > @@ -1367,3 +1376,98 @@ bool bpf_jit_supports_subprog_tailcalls(vo=
id)
> > > > >  {
> > > > >         return true;
> > > > >  }
> > > > > +
> > > > > +static int emit_jump_and_link(struct jit_ctx *ctx, u8 rd, u64 ta=
rget)
> > > > > +{
> > > > > +       if (!target) {
> > > > > +               pr_err("bpf_jit: jump target address is error\n")=
;
> > > > > +               return -EFAULT;
> > > > > +       }
> > > > > +
> > > > > +       move_imm(ctx, LOONGARCH_GPR_T1, target, false);
> > > > > +       emit_insn(ctx, jirl, rd, LOONGARCH_GPR_T1, 0);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int gen_jump_or_nops(void *target, void *ip, u32 *insns, =
bool is_call)
> > > > > +{
> > > > > +       struct jit_ctx ctx;
> > > > > +
> > > > > +       ctx.idx =3D 0;
> > > > > +       ctx.image =3D (union loongarch_instruction *)insns;
> > > > > +
> > > > > +       if (!target) {
> > > > > +               emit_insn((&ctx), nop);
> > > > > +               emit_insn((&ctx), nop);
> > > >
> > > > There should be 5 nops, no ?
> > > Chenghao,
> > >
> > > We have already fixed the concurrent problem, now this is the only
> > > issue, please reply tas soon as possible.
> > >
> > > Huacai
> >
> > Hi Hengqi & Huacai,
> >
> > I'm sorry I just saw the email.
> > This position can be configured with 5 NOP instructions, and I have
> > tested it successfully.
> OK, now loongarch-next [1] has integrated all needed changes, you and
> Vincent can test to see if everything is OK.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loon=
gson.git/log/?h=3Dloongarch-next
>

Tested-by: Vincent Li <vincent.mc.li@gmail.com>

> Huacai
>
> >
> > sudo ./test_progs -a fentry_test/fentry
> > sudo ./test_progs -a fexit_test/fexit
> > sudo ./test_progs -a fentry_fexit
> > sudo ./test_progs -a modify_return
> > sudo ./test_progs -a fexit_sleep
> > sudo ./test_progs -a test_overhead
> > sudo ./test_progs -a trampoline_count
> > sudo ./test_progs -a fexit_bpf2bpf
> >
> > if (!target) {
> >         int i;
> >         for (i =3D 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
> >                 emit_insn((&ctx), nop);
> >         return 0;
> > }
> >
> >
> > Chenghao
> >
> > >
> > > >
> > > > > +               return 0;
> > > > > +       }
> > > > > +
> > > > > +       return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_T=
0 : LOONGARCH_GPR_ZERO,
> > > > > +                                 (unsigned long)target);
> > > > > +}
> > > > > +
> > > > > +int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_ty=
pe,
> > > > > +                      void *old_addr, void *new_addr)
> > > > > +{
> > > > > +       u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =
=3D INSN_NOP};
> > > > > +       u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =
=3D INSN_NOP};
> > > > > +       bool is_call =3D poke_type =3D=3D BPF_MOD_CALL;
> > > > > +       int ret;
> > > > > +
> > > > > +       if (!is_kernel_text((unsigned long)ip) &&
> > > > > +               !is_bpf_text_address((unsigned long)ip))
> > > > > +               return -ENOTSUPP;
> > > > > +
> > > > > +       ret =3D gen_jump_or_nops(old_addr, ip, old_insns, is_call=
);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       if (memcmp(ip, old_insns, LOONGARCH_LONG_JUMP_NBYTES))
> > > > > +               return -EFAULT;
> > > > > +
> > > > > +       ret =3D gen_jump_or_nops(new_addr, ip, new_insns, is_call=
);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       mutex_lock(&text_mutex);
> > > > > +       if (memcmp(ip, new_insns, LOONGARCH_LONG_JUMP_NBYTES))
> > > > > +               ret =3D larch_insn_text_copy(ip, new_insns, LOONG=
ARCH_LONG_JUMP_NBYTES);
> > > > > +       mutex_unlock(&text_mutex);
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +int bpf_arch_text_invalidate(void *dst, size_t len)
> > > > > +{
> > > > > +       int i;
> > > > > +       int ret =3D 0;
> > > > > +       u32 *inst;
> > > > > +
> > > > > +       inst =3D kvmalloc(len, GFP_KERNEL);
> > > > > +       if (!inst)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       for (i =3D 0; i < (len/sizeof(u32)); i++)
> > > > > +               inst[i] =3D INSN_BREAK;
> > > > > +
> > > > > +       mutex_lock(&text_mutex);
> > > > > +       if (larch_insn_text_copy(dst, inst, len))
> > > > > +               ret =3D -EINVAL;
> > > > > +       mutex_unlock(&text_mutex);
> > > > > +
> > > > > +       kvfree(inst);
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> > > > > +{
> > > > > +       int ret;
> > > > > +
> > > > > +       mutex_lock(&text_mutex);
> > > > > +       ret =3D larch_insn_text_copy(dst, src, len);
> > > > > +       mutex_unlock(&text_mutex);
> > > > > +       if (ret)
> > > > > +               return ERR_PTR(-EINVAL);
> > > > > +
> > > > > +       return dst;
> > > > > +}
> > > > > --
> > > >
> > > > bpf_arch_text_invalidate() and bpf_arch_text_copy() is not related =
to
> > > > BPF trampoline, right ?
> >
> > From the perspective of BPF core source code calls, the two functions
> > bpf_arch_text_invalidate() and bpf_arch_text_copy() are not only used f=
or
> > trampolines.
> >
> > > >
> > > > > 2.25.1
> > > > >
> >

