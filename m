Return-Path: <bpf+bounces-64472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59511B132F8
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 04:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09FA3B3986
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 02:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44881BD9CE;
	Mon, 28 Jul 2025 02:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2szHauA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204812745C;
	Mon, 28 Jul 2025 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753669853; cv=none; b=Tp3XE7Aqo4GpUkcCgr+h1IxQkcyBkvwuZDATGEIJilqkUgfi35gks+hi2h4w1F8OkmfVyAGGvPXNj6zBXCQIqoWAkzmRtj4vbSTgDT9k3bfNCK4SbxL22CbvfO1IHZAScAi7mqkOIEzgMXQtJfjsDgeucdnbT/RcPNDcVxWYo0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753669853; c=relaxed/simple;
	bh=abe/GrKqpjf7spXcZ2NMUAFd4nRCvRcL7pPsKohOVpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f33toy5kYtNKHxXKFgz7/ukmSo564trHlnWHqkWsgV16JyTHo23qr7MVM5H7BmdGnzEcVPBXJXIYUFP0o0YhDD55mRil2qbaWEMyTmn7uvE4hwFFDLoWT3jzHBsUECiPjXjgKtajA0StYH7VzWVjOrU8Mh+kunAZZ4LzB2yNo5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2szHauA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8978C4CEF7;
	Mon, 28 Jul 2025 02:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753669852;
	bh=abe/GrKqpjf7spXcZ2NMUAFd4nRCvRcL7pPsKohOVpI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M2szHauA4dw7cKq1kGhS9714whad8+d/xaITyqyJCpxtYeJ1RJ4quztR1l2P/iQsM
	 gGDkBnOXjQrsu718CyfcWhhmORumYp2lH+mFNGVrWxooSX+hYzf5nL/wj07LaceFra
	 9IhginRjlTc8+Hoo759AA4SBIXIXvXQEmMDQGmo1jHlhY0V6mFVf5jluMzVDprknRb
	 YXy5p6NZDIkqm3/hcREoLcR8liR0byFRAwXdtL5O3KFhrpUc6zU3+JS9EloVm63VSU
	 Fd8151u1DqdwlTN0+mtI8WFj/1EpGrY0IfT0Ctu+BwIgsXB7NSsItwLfXEv3mR5Ewa
	 VDKIfXk6Dkkzw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so7151482a12.2;
        Sun, 27 Jul 2025 19:30:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWz4e4g/yap4T6869Worz1CDr62W/57T4LH2JDeTZDntYJirQr7x7GLMpmOTAEjmYgmdTt2NbhwDVlo59Un@vger.kernel.org, AJvYcCXTYt9KdvVtmjrPX7nNYMepuzJGmmkZmcc3cWrkqbRo2zJ5bKiX8vuEr0awXa4h1uaad8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Ru12PepZKMeGuFFU7Ux8QNANMR0lIjuKPWOeuOUI33XOjvIQ
	cCHoDagCawZV2rmSIb6PSbNmDqmjo5eBNup8KQtf1iBxQNimJaOzYALBuDwLmZHKaWi4iJt/zzY
	4VhHp05nrTDD1MkVM6XdzI47Q76Urf7o=
X-Google-Smtp-Source: AGHT+IGuabYn5OrkcJrOnow1DUa1NsmT3e5/9YxCXXPuAbbpoidHV1UPoSLqHnmRc/MMBPFNm9fBBAnPCYSVnOIB1Tc=
X-Received: by 2002:a05:6402:280a:b0:602:b6fd:150a with SMTP id
 4fb4d7f45d1cf-614f1e09b1fmr9500565a12.33.1753669851140; Sun, 27 Jul 2025
 19:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724141929.691853-1-duanchenghao@kylinos.cn> <20250724141929.691853-4-duanchenghao@kylinos.cn>
In-Reply-To: <20250724141929.691853-4-duanchenghao@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 28 Jul 2025 10:30:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5-LAD=SJhWKCBmytdD3os=mgYU+UNEbhiQ4tSB-hxeXA@mail.gmail.com>
X-Gm-Features: Ac12FXzK75CFt2aVxwsxeoDTleSh10PrQvLxQfQTDqDaH9RSONa735b_75gRztI
Message-ID: <CAAhV-H5-LAD=SJhWKCBmytdD3os=mgYU+UNEbhiQ4tSB-hxeXA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] LoongArch: BPF: Add bpf_arch_xxxxx support for Loongarch
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yangtiezhu@loongson.cn, hengqi.chen@gmail.com, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn, 
	vincent.mc.li@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Chenghao,

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
> Co-developed-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>
> Reviewed-by: Huacai Chen <chenhuacai@kernel.org>
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
I have an off-list discussion with Hengqi, and I know why he has
questions on this. He said we don't need a loop, we can just copy the
whole thing in a single operation, and I think he is right. RISC-V
uses a loop because it uses fixmap, and with fixmap they can only
handle a single page every time. We use set_memory_{rw, rox} so we
have no limitation.

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
To save time, please test this method:
+int larch_insn_text_copy(void *dst, void *src, size_t len)
+{
+ int ret =3D 0;
+ unsigned long flags;
+
+    WARN_ON(!PAGE_ALIGNED(src));  //maybe this is unneeded
+    WARN_ON(!PAGE_ALIGNED(dst));
+    WARN_ON(!PAGE_ALIGNED(size));
+
+ set_memory_rw((unsigned long)dst, len / PAGE_SIZE);
+ raw_spin_lock_irqsave(&patch_lock, flags);
+
+ ret =3D copy_to_kernel_nofault(dst, src, len);
+ if (ret)
+ pr_err("%s: operation failed\n", __func__);
+
+ raw_spin_unlock_irqrestore(&patch_lock, flags);
+ set_memory_rox((unsigned long)dst, len / PAGE_SIZE);
+
+ if (!ret)
+ flush_icache_range((unsigned long)dst, (unsigned long)dst + len);
+
+ return ret;
+}
Huacai

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

