Return-Path: <bpf+bounces-64973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8781DB19A0A
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 04:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F396189771E
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 02:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D50D1F4191;
	Mon,  4 Aug 2025 02:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvyLfsKW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523FC2E3719;
	Mon,  4 Aug 2025 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754272952; cv=none; b=PWNTD0uBfxHk77CX2IjtnHjuqQsB8gZ6cS1YsZbIIpXXcr2d/gF1E8NMT06WD6pCnqfEMYbHrGhmErUjvdjBN3lICaL9+usY85+lw7tFsxh+DGt3QE9FxnGMaN81YwWQgLzhV23nofhUO3z9ycSkoMvpwd6fLA96XS3/9NUMsh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754272952; c=relaxed/simple;
	bh=F4Bedh5WlxxR+lX1eEZ5PNboTWQkZDsPZgFxQgOSY/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGhF5DLVgbM3kxyVpQRm4mOAXEnKo/9DFrop2c67Wr+ZP+3kXJ2U5p5mxLiReatwVCg7yAuml1i2tj75sgFB3yUlGvaWuWDfgpxVahxPc3xuGd6I+/cNVs5wIIe+sK+tTzNgWD47xlJZqjgAILItYAErqj11p31bBcduMUo5PNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvyLfsKW; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-433fa926cb9so1038781b6e.2;
        Sun, 03 Aug 2025 19:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754272949; x=1754877749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wCFktz3K42j3e8OfkTWxJxSNMWVDU+M6mYp7e3GMMQ=;
        b=CvyLfsKWOs457wNq41Nh4VdY/2ktoDAeDI2BQp7xPqNOXzdyMATXr+wSMtbip0CK00
         g6rCEfLeiRRvQcMCsnYV2bFHOp6ojppP3l1/bheS9JzHPnlAguZYJkg68/yKIyvDqChm
         6KzFaBhkIl9HACW9sMTmTVdjqpoa43z7JHDwg5wXIHdNYDyuT01B0mJBYJS6pHOMYKCt
         JNy1lYVSDhmYTVL5UsGZsgwWsDzEJvTEarzxcjFTk2au/Wl+UwW4AuS2ygSbFdEpaK8b
         0GpIDdiBOcrI1GX5/5PnTdIB/+sX5N+qYQ/W4F6gGe5YMNvIC7RGO2UuMlqTzciJBoZw
         9ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754272949; x=1754877749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wCFktz3K42j3e8OfkTWxJxSNMWVDU+M6mYp7e3GMMQ=;
        b=ThmIRKBoEaBRtHLRrFd2eAq4Vt5BZ7ywYR5tZCAaDxxUp+N/iQTlXBELucQ25jZf2V
         xY925yOl149EL75QWZE3ZNlTpP40jVPBXI7zfnLNb7Vy22X2JFlEbKHNYWPZgL3M7fK2
         E2vu6resvdxzfpuUfeXoqBUJZsNCmbMVjFOvTYQWhKEBM6D7J2sDBEcHelGKshGapWkB
         tDlEUqssFxkf4W9gZ19j1VL9+hJemAd/Os5kDF60yZcP1PCPNjeCCKxdqx1XgZriVwsC
         pb7qRyGrtuhnjoTUsXRG5vDMXwKpxcEkphg3zI/8Wu4SFp2Qk9WghHcflLq5c+jykKFs
         YI6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOrMZ4f8WOv2EO7s03vX3ucxrQGZU85xGBV2lR3RdfWxSQggDAjApGVEDNiRpepiZpo830/lOvY5m66aXW@vger.kernel.org, AJvYcCX+kgJAsLg8JEM10fiw47a8wCy+2FL9lCq47KQmoi+OGv7GoE7mCvQlJlbH1HEMqEkK4Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlCTekNvUh2jN8s87qjFsj+UkbRN/2U/X31la4ebAUZmepL6f6
	UDrWvGCUgzkYUbmGYXb/heiMxGUeQ04rqymWRSTYuGEiv3ILCz4PgGH3oAjtXWk1jVi0r591HxS
	laXHGns1/SpZKzmA6HQ2vndogQw8/F/g=
X-Gm-Gg: ASbGncuwdeNt8stRGOCb2IgbembLV0uBdrnt23lLzI1baT1vjK1tdtrMNfdXi+0em5y
	oO5lXgThBzGRx0vgYysf58R69QuM2moeZrLB2f2DnYs0whANvOlt6G8wjgelTPfY2HDn0mI7ey5
	XtHNTaDtpkkqSCLZuH6Uv3fzr8jVIZ4xgZPLqFAiWqaJw+Ql9ncmvAOx0x2qWecCsDc/WOLr33u
	3Dj6HI3z8WDMwjD
X-Google-Smtp-Source: AGHT+IFk16Yl1a9juBd5R456DMxGHKpk6jdVCop+o0MOzGG97j6GRCebS33AP/zNGQ7vYm0/mj+O0XlnPIBD1qVeYTA=
X-Received: by 2002:a05:6808:2104:b0:41c:7cb1:fb47 with SMTP id
 5614622812f47-433f0221dabmr4827890b6e.8.1754272949201; Sun, 03 Aug 2025
 19:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730131257.124153-1-duanchenghao@kylinos.cn> <20250730131257.124153-4-duanchenghao@kylinos.cn>
In-Reply-To: <20250730131257.124153-4-duanchenghao@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 4 Aug 2025 10:02:17 +0800
X-Gm-Features: Ac12FXy_Hpx83BD3NKqW37mC1mFXzXpedHvsdnKm12ci_clLq_s4qS-9GD7a7po
Message-ID: <CAEyhmHTE8yd0-N5YkMvJScv+Dsw3sAvgyZt8h1sd1=rzaCoTwQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] LoongArch: BPF: Implement dynamic code
 modification support
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yangtiezhu@loongson.cn, chenhuacai@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn, 
	vincent.mc.li@gmail.com, geliang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 9:13=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
>
> This commit adds support for BPF dynamic code modification on the
> LoongArch architecture.:
> 1. Implement bpf_arch_text_poke() for runtime instruction patching.
> 2. Add bpf_arch_text_copy() for instruction block copying.
> 3. Create bpf_arch_text_invalidate() for code invalidation.
>
> On LoongArch, since symbol addresses in the direct mapping
> region cannot be reached via relative jump instructions from the paged
> mapping region, we use the move_imm+jirl instruction pair as absolute
> jump instructions. These require 2-5 instructions, so we reserve 5 NOP
> instructions in the program as placeholders for function jumps.
>
> larch_insn_text_copy is solely used for BPF. The use of
> larch_insn_text_copy() requires page_size alignment. Currently, only
> the size of the trampoline is page-aligned.
>
> Co-developed-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  arch/loongarch/include/asm/inst.h |   1 +
>  arch/loongarch/kernel/inst.c      |  27 ++++++++
>  arch/loongarch/net/bpf_jit.c      | 104 ++++++++++++++++++++++++++++++
>  3 files changed, 132 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/a=
sm/inst.h
> index 2ae96a35d..88bb73e46 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -497,6 +497,7 @@ void arch_simulate_insn(union loongarch_instruction i=
nsn, struct pt_regs *regs);
>  int larch_insn_read(void *addr, u32 *insnp);
>  int larch_insn_write(void *addr, u32 insn);
>  int larch_insn_patch_text(void *addr, u32 insn);
> +int larch_insn_text_copy(void *dst, void *src, size_t len);
>
>  u32 larch_insn_gen_nop(void);
>  u32 larch_insn_gen_b(unsigned long pc, unsigned long dest);
> diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> index 674e3b322..7df63a950 100644
> --- a/arch/loongarch/kernel/inst.c
> +++ b/arch/loongarch/kernel/inst.c
> @@ -4,6 +4,7 @@
>   */
>  #include <linux/sizes.h>
>  #include <linux/uaccess.h>
> +#include <linux/set_memory.h>
>
>  #include <asm/cacheflush.h>
>  #include <asm/inst.h>
> @@ -218,6 +219,32 @@ int larch_insn_patch_text(void *addr, u32 insn)
>         return ret;
>  }
>
> +int larch_insn_text_copy(void *dst, void *src, size_t len)
> +{
> +       int ret;
> +       unsigned long flags;
> +       unsigned long dst_start, dst_end, dst_len;
> +
> +       dst_start =3D round_down((unsigned long)dst, PAGE_SIZE);
> +       dst_end =3D round_up((unsigned long)dst + len, PAGE_SIZE);
> +       dst_len =3D dst_end - dst_start;
> +
> +       set_memory_rw(dst_start, dst_len / PAGE_SIZE);
> +       raw_spin_lock_irqsave(&patch_lock, flags);
> +
> +       ret =3D copy_to_kernel_nofault(dst, src, len);
> +       if (ret)
> +               pr_err("%s: operation failed\n", __func__);
> +
> +       raw_spin_unlock_irqrestore(&patch_lock, flags);
> +       set_memory_rox(dst_start, dst_len / PAGE_SIZE);
> +
> +       if (!ret)
> +               flush_icache_range((unsigned long)dst, (unsigned long)dst=
 + len);
> +
> +       return ret;
> +}
> +
>  u32 larch_insn_gen_nop(void)
>  {
>         return INSN_NOP;
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 7032f11d3..5e6ae7e0e 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -4,8 +4,12 @@
>   *
>   * Copyright (C) 2022 Loongson Technology Corporation Limited
>   */
> +#include <linux/memory.h>
>  #include "bpf_jit.h"
>
> +#define LOONGARCH_LONG_JUMP_NINSNS 5
> +#define LOONGARCH_LONG_JUMP_NBYTES (LOONGARCH_LONG_JUMP_NINSNS * 4)
> +
>  #define REG_TCC                LOONGARCH_GPR_A6
>  #define TCC_SAVED      LOONGARCH_GPR_S5
>
> @@ -88,6 +92,7 @@ static u8 tail_call_reg(struct jit_ctx *ctx)
>   */
>  static void build_prologue(struct jit_ctx *ctx)
>  {
> +       int i;
>         int stack_adjust =3D 0, store_offset, bpf_stack_adjust;
>
>         bpf_stack_adjust =3D round_up(ctx->prog->aux->stack_depth, 16);
> @@ -98,6 +103,10 @@ static void build_prologue(struct jit_ctx *ctx)
>         stack_adjust =3D round_up(stack_adjust, 16);
>         stack_adjust +=3D bpf_stack_adjust;
>
> +       /* Reserve space for the move_imm + jirl instruction */
> +       for (i =3D 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
> +               emit_insn(ctx, nop);
> +
>         /*
>          * First instruction initializes the tail call count (TCC).
>          * On tail call we skip this instruction, and the TCC is
> @@ -1367,3 +1376,98 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>  {
>         return true;
>  }
> +
> +static int emit_jump_and_link(struct jit_ctx *ctx, u8 rd, u64 target)
> +{
> +       if (!target) {
> +               pr_err("bpf_jit: jump target address is error\n");
> +               return -EFAULT;
> +       }
> +
> +       move_imm(ctx, LOONGARCH_GPR_T1, target, false);
> +       emit_insn(ctx, jirl, rd, LOONGARCH_GPR_T1, 0);
> +
> +       return 0;
> +}
> +
> +static int gen_jump_or_nops(void *target, void *ip, u32 *insns, bool is_=
call)
> +{
> +       struct jit_ctx ctx;
> +
> +       ctx.idx =3D 0;
> +       ctx.image =3D (union loongarch_instruction *)insns;
> +
> +       if (!target) {
> +               emit_insn((&ctx), nop);
> +               emit_insn((&ctx), nop);

There should be 5 nops, no ?

> +               return 0;
> +       }
> +
> +       return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_T0 : LOON=
GARCH_GPR_ZERO,
> +                                 (unsigned long)target);
> +}
> +
> +int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
> +                      void *old_addr, void *new_addr)
> +{
> +       u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D INSN=
_NOP};
> +       u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D INSN=
_NOP};
> +       bool is_call =3D poke_type =3D=3D BPF_MOD_CALL;
> +       int ret;
> +
> +       if (!is_kernel_text((unsigned long)ip) &&
> +               !is_bpf_text_address((unsigned long)ip))
> +               return -ENOTSUPP;
> +
> +       ret =3D gen_jump_or_nops(old_addr, ip, old_insns, is_call);
> +       if (ret)
> +               return ret;
> +
> +       if (memcmp(ip, old_insns, LOONGARCH_LONG_JUMP_NBYTES))
> +               return -EFAULT;
> +
> +       ret =3D gen_jump_or_nops(new_addr, ip, new_insns, is_call);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&text_mutex);
> +       if (memcmp(ip, new_insns, LOONGARCH_LONG_JUMP_NBYTES))
> +               ret =3D larch_insn_text_copy(ip, new_insns, LOONGARCH_LON=
G_JUMP_NBYTES);
> +       mutex_unlock(&text_mutex);
> +       return ret;
> +}
> +
> +int bpf_arch_text_invalidate(void *dst, size_t len)
> +{
> +       int i;
> +       int ret =3D 0;
> +       u32 *inst;
> +
> +       inst =3D kvmalloc(len, GFP_KERNEL);
> +       if (!inst)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < (len/sizeof(u32)); i++)
> +               inst[i] =3D INSN_BREAK;
> +
> +       mutex_lock(&text_mutex);
> +       if (larch_insn_text_copy(dst, inst, len))
> +               ret =3D -EINVAL;
> +       mutex_unlock(&text_mutex);
> +
> +       kvfree(inst);
> +       return ret;
> +}
> +
> +void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> +{
> +       int ret;
> +
> +       mutex_lock(&text_mutex);
> +       ret =3D larch_insn_text_copy(dst, src, len);
> +       mutex_unlock(&text_mutex);
> +       if (ret)
> +               return ERR_PTR(-EINVAL);
> +
> +       return dst;
> +}
> --

bpf_arch_text_invalidate() and bpf_arch_text_copy() is not related to
BPF trampoline, right ?

> 2.25.1
>

