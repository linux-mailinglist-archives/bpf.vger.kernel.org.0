Return-Path: <bpf+bounces-64975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AE5B19A24
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 04:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEF1174097
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 02:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A845C1F4CAE;
	Mon,  4 Aug 2025 02:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ1w2wLV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A691DE3BB;
	Mon,  4 Aug 2025 02:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754274297; cv=none; b=h86HaUMeByJj0Hjsb2a6NRUuXljyNyKnjI3a1yr3HbUwJ2sLNjpuNzNOxkUmXz3+DCUlt3wOgz/qfMwYQkUZZlY6NO/yQcES59JPXsPWprVaOjHBs90tGY9iUVv7wHR5aAWfHo2QpXJY05VYG/ngSb24BbUAbDsunelbin+jTCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754274297; c=relaxed/simple;
	bh=vIoLQAriU9QLyBP+GEsvN1SPVlN57wrfxtqM44gQ6uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfQ5NB3uWJt3Juv8mnvV1iVQAGeIjvJw1KP4QDiJlE0lu8vP2ajS58ZZwovAJ1Jdx59I8XFm3g0FSYBAdxmYpGBU2U5oTrCKCErDWMmXmtNC0PsifVuyWxdFvNXjya2jT5yZSK9eHx/i7d5b8VDULAS+WEdUkzQ2M73bIR5C7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQ1w2wLV; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-433f3bc84e0so1114030b6e.3;
        Sun, 03 Aug 2025 19:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754274294; x=1754879094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnRa1JA/UK/K7tosARzyACz2l637qczjgSNLiyAn2po=;
        b=AQ1w2wLVBmsYVEFyk5FcWKoUvUCnjjZ5Xv+8lw7AaoueaWCICHekR9BYLrQ5TcMkdO
         Hpij31COwzvyMux02/zV3boGSS13TkXqMJggGO7qe1Bgsxbz6NRPApsvRo8QaJQwmKQt
         V1aDvBf0kR1RVZqchWcNqToDLfAzcXeSJ0d+GQ/ZHKffMVW09flPQYedDsQBVXPTmf+M
         JId7e8CDmxJJf/cFRwEMxz7IrF1f6FjT9o7GuGSGnsu18k/vRQRx7Lif00HaWqB1yT3T
         qkyGhJ1ATwDAfZzvmVCwInrlPFFqj+emmK3bJDnydkpR8y+W3hj0N33gO499aJEhuztJ
         oeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754274294; x=1754879094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnRa1JA/UK/K7tosARzyACz2l637qczjgSNLiyAn2po=;
        b=khYxAWISO3hKjZId9HTvvMdK9fWcYf7j1zfVkW+l1AIx5Gd+4ZscBdo50MqDYGvcMm
         TANekx7D8dIqi2q9WOyzwZwJKDZj5Yy7iewv/ckHFhvp4Tb/c1tSYTwbXhEO0RzOZF48
         8eD/sFaIk1TMRYkCqPHAb+qnw8KJMSvyvZ71VYrP53Dkt10Mk7m+24Rj+praS5jLa2Ot
         PqI1Me7Inhu4FeCK4Pf0Pc1Fc0kTdsYY5kdqPpNUBhTNSmfvGobQnBFrDWyvd/E9P2aA
         HE2huwfF1CGulBUF88yhw1qsNLK6yWchqrGXWiPLl7HuS65mHxcRDy++qb1d0U5YTwBU
         MFZw==
X-Forwarded-Encrypted: i=1; AJvYcCWbgIx5Af4Zt+IeDKAQgeAim0uxVIQHu090hCAK/becFx74+ta6hAq/qAQiAuiKciOKRkc/c6KAQF5aohTx@vger.kernel.org, AJvYcCWshtaBgWD6l3Uk7gW9J/dkIqQfYt7qwbipv8NT+SZ4vVvc8kjEAHkYeFJCUJOvR37J9ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk46qH6ms2a3W9WG34AS0FWs+ZtKfyJj3AmhEIoNRIhoEea7ny
	7N4nW74wB69YvySAE6IkSV9KGQuN0vYINBkvFMNEQ0FVNQidhgo8fddsEos1nPwuc73SQLPihdS
	81STTKScl99l5dE6JTx48xnXZjnNsslg=
X-Gm-Gg: ASbGnctctjPa3eKJYXcRpAuIjQlsRJ7bX9Q+xUCt1F5/vmU8Nf7yqCDl2fcM743SA56
	1P8X1lmqCbR2Hta8hGs5wYEhw0S0c3/y++fhaQJHgrVh3cROvbVznEhHNd5+khxiMnO/W3oD5LS
	q9PgwEbT6HGLYb1ys48XsGetC7RxgudTW3DNjP46KxMvAqy5s5ilyDnbrHLLYIq0AEMCag6sy6F
	7oauqc=
X-Google-Smtp-Source: AGHT+IHhH1YIlg21cr4MIGPuqerm1W25W6/jSAdfR4y9B8Edf1oakdGia3Vc0Pk46NXYA8Hkr1xOm7gYnffSPLFPPZ0=
X-Received: by 2002:a05:6808:1910:b0:433:ff53:1b7e with SMTP id
 5614622812f47-433ff532639mr2765208b6e.11.1754274294309; Sun, 03 Aug 2025
 19:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730131257.124153-1-duanchenghao@kylinos.cn> <20250730131257.124153-4-duanchenghao@kylinos.cn>
In-Reply-To: <20250730131257.124153-4-duanchenghao@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 4 Aug 2025 10:24:43 +0800
X-Gm-Features: Ac12FXw54_4HRJNzwKhuZVYGpesI_S2zavu44x_15b5aAywWy_Y1r58SRvoBSUo
Message-ID: <CAEyhmHQOeKmQZnq9RvaPANdLfcsAJX=xU+nL+p4=sPwcYPOfGw@mail.gmail.com>
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

The text_mutex and patch_lock inside larch_insn_text_copy() ONLY
prevent concurrent modifications.
You may need stop_machine() to prevent concurrent modifications/executions.

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
> 2.25.1
>

