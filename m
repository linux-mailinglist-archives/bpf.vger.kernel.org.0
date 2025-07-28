Return-Path: <bpf+bounces-64509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A123B13966
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 12:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3081A189AA50
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 10:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9750257AF3;
	Mon, 28 Jul 2025 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6gPwfFx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A324E4A8;
	Mon, 28 Jul 2025 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753700335; cv=none; b=ee6Fp8TMzi/xB5CPfjXTk109ntgxGQQ3fWfcy9LSM/LsZL3vZMTTDQSgoWNc98McvOLiLXSdJ/T98sVD9OUp4OSg37QGbLpK52TqH/twLbds4LeFLf4HKkhqXQTMKHW8yq5xnM3e8EqN+LM18CEmk6pSNXk28fE3XVhOotTkxZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753700335; c=relaxed/simple;
	bh=PJx5QFJu4D/LZBoDqRYRjZDFXuO2cYXXjGixhwMsXMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrMSMXmnE0ZxBubbwtEsOIFKlvvIPFxX3DL4GnGbWOKgN/FB5nm9eDv9cYFUt1mOIiFsX2VCzFjF66N2lE7qh3pkLvmvY1RimiXA6qmhGikDkuwnJ2pTRMcQMNfM2X49j4SlAxdPL4bxsrHwuCIbiT68aJBW3pVdKgEg7EGM58Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6gPwfFx; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-41b4bf6ead9so2499387b6e.3;
        Mon, 28 Jul 2025 03:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753700333; x=1754305133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDEJIKTxjQ+aMs9QZUcVbyCxKMaauKOrQlNqFqKUv+Q=;
        b=E6gPwfFxJoeyt4j6Ba/Tw+DVeuTcAG/tZaDUExAT1sJDcyjzodMJm1sQ1LU8Nqk/7c
         8CbKsXzsoY5PBfVCL3toKcUFOcNWlb0I6TFU49QUONL8Ra+C4UvtbyvKi/fs8O66VV7G
         iPdHBLGoFrxN+aB8DaLKI4pvh3sD420osoTkVo+HAo0xRvzzetb605ionSPqyAfJtYxJ
         cL4pl1mQkDtpZ8PAXy2WvoDX4mLtnR+f37scI10bRuKs9lNNBUmYIGm4gITMMcv1GAAg
         Dtasn187BBrMIEBeAAJqN66lTim+8UrSfZtUu7VeylcPRkp8+1TisqOKoCbIVYt2LRPu
         S17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753700333; x=1754305133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDEJIKTxjQ+aMs9QZUcVbyCxKMaauKOrQlNqFqKUv+Q=;
        b=VpcOHsOMlU7QsEyLs/7Le0sPvnfBMMNwfYSa4r/gJSRXsMebEbwHYpZykmN5GvXdXY
         KhWcH3Dhj6jRVzPuhIcvzQ+++a5lHi2NVL8FepF2q6TOLW85QG0hQ5Std+4zA/NPzHqE
         VRsTjYIQ9nTKRUub32yBSv7ZBdSHSlC9OmLqt6lt6EII67BGt5dRoFKa5UeXh1FqsaFX
         l27XDbV0yyNOknRHrjpyPK/QHSPrBftcHoS+dnxZoG0ew2jylucDKR4e2JJWLP+l3sWK
         V1+VuJPDyuzNJGxlXAQacAA8luyKUb2dsUgxe856Kw2x3ncqo8/5vEeI2Rmh1FQt9GW6
         U5cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTMbLA4rpFH/Lx9l3/2M1uWJAEvEdkNm6BYKijoKzwe2QknOAYWxXC9guL5FIGDwBRAH8=@vger.kernel.org, AJvYcCUXYiXOeCnMwtBPYG38z/Pe73eAluNlihx1jK4geVGDiV95nbkjxDbKG8Z9IL7uOZ5c5cmd5yXC9QgT8wOL@vger.kernel.org
X-Gm-Message-State: AOJu0YwjF3hC7iDQcnyqk12iOwQv3BtZKHjIY+sz26glpKfyr32XmXNo
	Fo70tioK85GjH/YASKypKyV6ClNHcTX6ArvlA/WxHPnGrrvpZEnRtHbdrUjlLc+lymU3S9+EgfV
	Pjpi7OYYNt3PBs6nBSu9KY/mH8S4hcfY=
X-Gm-Gg: ASbGncvTcemI2mE2qUhgMCu78/VBXk5J25u3k4FBk9tfy7bF1zqlq4M7PM5BrBkBIjE
	n75ZflhpgDRgRgsyxABpI83Zum7O7XHUtekEb4ScUsUUHfi94TrrtP7whMpkqlHr2q+nuezTUc+
	3O8KHQaUm0KMSfljTakkH6XA0mD1V4ewqnJkIODzoiAa0t2eCKWyCPi5A2nNhCapPWatF2MRORS
	uL/ZAI=
X-Google-Smtp-Source: AGHT+IGpUAIuaI/QMGskND7VYzAO96CE8mnJtwOJyCoN9XAfCpbJjoFiBQK5I0m0bWthNQwudSVYkrlN95R2xNODggQ=
X-Received: by 2002:a05:6808:13d6:b0:41c:4d35:c1c2 with SMTP id
 5614622812f47-42bb77d78aamr5784172b6e.11.1753700332574; Mon, 28 Jul 2025
 03:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724141929.691853-1-duanchenghao@kylinos.cn> <20250724141929.691853-4-duanchenghao@kylinos.cn>
In-Reply-To: <20250724141929.691853-4-duanchenghao@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 28 Jul 2025 18:58:41 +0800
X-Gm-Features: Ac12FXyGftQxSZt7TbOWZ5dGm2PuD9KdlQWwA3g-Yhu287iIO8pn3G1CvgOw6Xk
Message-ID: <CAEyhmHQAAE_a7X4UWHVsKq3hp2jd4LRDP31kOjL_E-bz9coqYw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] LoongArch: BPF: Add bpf_arch_xxxxx support for Loongarch
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yangtiezhu@loongson.cn, chenhuacai@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn, 
	vincent.mc.li@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 10:21=E2=80=AFPM Chenghao Duan <duanchenghao@kylino=
s.cn> wrote:
>
> Implement the functions of bpf_arch_text_poke, bpf_arch_text_copy, and
> bpf_arch_text_invalidate on the LoongArch architecture.
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

The subject line seems kind of casual, bpf_arch_xxxxx ?

> Co-developed-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>
> Reviewed-by: Huacai Chen <chenhuacai@kernel.org>

I didn't leave a Reviewed-by tag last time, no ?

> ---
>  arch/loongarch/include/asm/inst.h |  1 +
>  arch/loongarch/kernel/inst.c      | 32 ++++++++++
>  arch/loongarch/net/bpf_jit.c      | 97 +++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+)
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
> index 674e3b322..8d6594968 100644
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
> @@ -218,6 +219,37 @@ int larch_insn_patch_text(void *addr, u32 insn)
>         return ret;
>  }
>
> +int larch_insn_text_copy(void *dst, void *src, size_t len)
> +{
> +       unsigned long flags;
> +       size_t wlen =3D 0;
> +       size_t size;
> +       void *ptr;
> +       int ret =3D 0;
> +
> +       set_memory_rw((unsigned long)dst, round_up(len, PAGE_SIZE) / PAGE=
_SIZE);
> +       raw_spin_lock_irqsave(&patch_lock, flags);
> +       while (wlen < len) {
> +               ptr =3D dst + wlen;
> +               size =3D min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
> +                            len - wlen);
> +
> +               ret =3D copy_to_kernel_nofault(ptr, src + wlen, size);
> +               if (ret) {
> +                       pr_err("%s: operation failed\n", __func__);
> +                       break;
> +               }
> +               wlen +=3D size;
> +       }
> +       raw_spin_unlock_irqrestore(&patch_lock, flags);
> +       set_memory_rox((unsigned long)dst, round_up(len, PAGE_SIZE) / PAG=
E_SIZE);
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
> index 7032f11d3..86504e710 100644
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
> @@ -1367,3 +1376,91 @@ bool bpf_jit_supports_subprog_tailcalls(void)
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
> +       if (larch_insn_text_copy(dst, inst, len))
> +               ret =3D -EINVAL;
> +
> +       kvfree(inst);
> +       return ret;
> +}
> +
> +void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> +{
> +       if (larch_insn_text_copy(dst, src, len))
> +               return ERR_PTR(-EINVAL);
> +
> +       return dst;
> +}
> --
> 2.25.1
>

