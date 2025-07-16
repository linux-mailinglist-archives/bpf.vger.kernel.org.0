Return-Path: <bpf+bounces-63430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97239B0757B
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 14:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72421AA3D80
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 12:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887F02F49FD;
	Wed, 16 Jul 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgVlbgOB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2123ABB0;
	Wed, 16 Jul 2025 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668533; cv=none; b=j6jEYH/sfgXinErN5PYqW8i5d6eEDVwklA5qrVojQnHQZTT034ZEHELOmin6Ut4np8XvYyUGimBOFyleQpTBSp007lcND7ljGMjzhWFXVIkHzc5OjD/Uuw8/IknG6s/reSaQ0rguhW0OGo3dRJmmIbJ8XQkydbF6GcycvntUnjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668533; c=relaxed/simple;
	bh=EJGOiFH+EU5CNzkZ/PqBKWLV7F65x+cAx3JuBIlqwMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hC7lNnj5ubunVbaEUnaN9VY4I+GkChnSDP/W2G1DaiaeZ44oLR9KX7DcAq7WwEKhWXhMf7yUzlSdXAd6iXkRlH1cpx24XSAUePkuTtfkzPDlRpJ47PPybfOxxDk01yR3ep9BQrzXX9BmTplR9XEE2uSS277d8FopMsaDcq9iUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgVlbgOB; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-73e650f3c31so250702a34.3;
        Wed, 16 Jul 2025 05:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752668530; x=1753273330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+tnr3e4/mymYLtJajATmZkmmv8sB/rgRTqanOQGPLM=;
        b=EgVlbgOBQgh/E+4O+gjUs5b9p6mZ2kBplWx/7gaJ4/Oa6kYyTtPo/H1yyKuIcTbTYH
         +BWnLtBQbTgMCge49tSL4g/K+Kctu8n1kJ4EfSyzipMPyHVKVIWp0q7uRY9RT3/h8hWa
         OLwTi6aY45LM+HM4dvzHcBNgyS7AlGRg9VrbKqw3pkNFhKde8behbgKFnCokZV1LVh1/
         qk7et4Nc+bO8ihwtPzFlGM2oiO8M0R+lqo18l6zNkz509lKOxH3VBTRyLHxfxUv5IljD
         mfswZ+JUQHuaNKdB2pdZoMbIvX2n9OidfJN2WEm2CDxBvVADaRUrJpaLUD4sSvrT4U8A
         TF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752668530; x=1753273330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+tnr3e4/mymYLtJajATmZkmmv8sB/rgRTqanOQGPLM=;
        b=eHHYWVMz82PKS1bOTMlc3PGyIz/PlOo4tsHOPR1URws3aSvesLKiHEIJ7uLzvTTefY
         Pqabh57Ff0lCNZFwY80MT9SH8sXM3H0/vZn9B31cn+u3y72yaRzJniuDseWK2tT/JIv7
         ydzidxTN/A23s2LDTh35DSMwXxP5AKZ68kzIdtr4ajjcsChpL4/JH/RZeQsas+GqMSLa
         RMvPhQSDRrrvknXt8Cek9LtfDcGQphACJ8ZQfOHWUYwDPeD1pBP0TUHkV3I8nB97wDgn
         /1zGTTl+LkpiKJsRVMcf5vQyB0rikJ0WCNvLlYnwsSZmC9s9Qia3Sf9i03We011/1r/2
         TtMg==
X-Forwarded-Encrypted: i=1; AJvYcCUG5MOT7Ads1MOBFhhqcO58mHzC0v9NQLqbuEx96uVjaPHAudy4KMoxEp/IQ46jbY459Lk=@vger.kernel.org, AJvYcCVtNFhHUHECmOr7N6IYykfOo6sjFTy3o8rTXG/ZHRzdjQ/eFzZbcSfnyRjpNv+K6Cn942GmsNM7SxuXpuh4@vger.kernel.org
X-Gm-Message-State: AOJu0YxPVICbuw1Q9xNr99g0ByIo7wWTK/qlg/E2ioLwVmMQJReff4lN
	AReCL7hTs2/0feGkxeJKTPDgL08urSv3caJ0W3GfGGd4tseBRdVI1qkedAkxy1pUhgXgpWFL4OD
	p57kCEqcQWuyHsjH4ve087pdxtdYG3+c=
X-Gm-Gg: ASbGncv0FD9dIZxnGh7PEwSvYQkbsZ0Kb89YFFf6RXKLAnz/tPl6hWVYeUyfQRfH5l+
	FOAvmoibxAnyuPqXbimLqass3HL/UyTl29OFLmIV/f+qwGqurx4AxnzI/njL+yiOFwwtqZ5gQag
	mTov4pD0lCswqkXFCWF7JQU+1bgQgs9tVNiSedZhLoZwZt3ms8thXk9utXwEFXUnxzFFQXgH3jb
	Y8hmns=
X-Google-Smtp-Source: AGHT+IGL7XLsKwtMZM/7v+p6warUqLB5ZMqihYIBn4laUW39QjxxtyX3/q++rHGgY6HE0TYuHA1qbA7pXZ2XHUIrfDk=
X-Received: by 2002:a05:6808:d4a:b0:409:52f:b361 with SMTP id
 5614622812f47-41ceb405866mr2082913b6e.0.1752668530359; Wed, 16 Jul 2025
 05:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709055029.723243-1-duanchenghao@kylinos.cn> <20250709055029.723243-5-duanchenghao@kylinos.cn>
In-Reply-To: <20250709055029.723243-5-duanchenghao@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 16 Jul 2025 20:21:59 +0800
X-Gm-Features: Ac12FXyuUgPud7MHnYU5OY6d35OPLh1aCxgn6SeR3TFritbJv3zps56X5lpe79c
Message-ID: <CAEyhmHS__fqHS8Bpg7+4apO7OuXG1sP3miCcAMT+Y3uU0+_xjg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LoongArch: BPF: Add bpf_arch_xxxxx support for Loongarch
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yangtiezhu@loongson.cn, chenhuacai@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 1:50=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos.=
cn> wrote:
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
> Co-developed-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  arch/loongarch/include/asm/inst.h |  1 +
>  arch/loongarch/kernel/inst.c      | 32 +++++++++++
>  arch/loongarch/net/bpf_jit.c      | 90 +++++++++++++++++++++++++++++++
>  3 files changed, 123 insertions(+)
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

Again, why do you do copy_to_kernel_nofault() in a loop ?
This larch_insn_text_copy() can be part of the first patch like
larch_insn_gen_{beq,bne}. WDYT ?

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
> index 7032f11d3..9cb01f0b0 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright (C) 2022 Loongson Technology Corporation Limited
>   */
> +#include <linux/memory.h>
>  #include "bpf_jit.h"
>
>  #define REG_TCC                LOONGARCH_GPR_A6
> @@ -1367,3 +1368,92 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>  {
>         return true;
>  }
> +
> +static int emit_jump_and_link(struct jit_ctx *ctx, u8 rd, u64 ip, u64 ta=
rget)
> +{
> +       s64 offset =3D (s64)(target - ip);
> +
> +       if (offset && (offset >=3D -SZ_128M && offset < SZ_128M)) {
> +               emit_insn(ctx, bl, offset >> 2);
> +       } else {
> +               move_imm(ctx, LOONGARCH_GPR_T1, target, false);
> +               emit_insn(ctx, jirl, rd, LOONGARCH_GPR_T1, 0);
> +       }
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
> +                                 (unsigned long)ip, (unsigned long)targe=
t);
> +}
> +
> +int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
> +                      void *old_addr, void *new_addr)
> +{
> +       u32 old_insns[5] =3D {[0 ... 4] =3D INSN_NOP};
> +       u32 new_insns[5] =3D {[0 ... 4] =3D INSN_NOP};
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
> +       if (memcmp(ip, old_insns, 5 * 4))
> +               return -EFAULT;
> +
> +       ret =3D gen_jump_or_nops(new_addr, ip, new_insns, is_call);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&text_mutex);
> +       if (memcmp(ip, new_insns, 5 * 4))
> +               ret =3D larch_insn_text_copy(ip, new_insns, 5 * 4);
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
> 2.43.0
>

