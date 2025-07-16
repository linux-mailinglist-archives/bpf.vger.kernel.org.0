Return-Path: <bpf+bounces-63476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6367EB07D0F
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 20:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB133A9587
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFFD29B20D;
	Wed, 16 Jul 2025 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrHgDB4R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9252188A3A;
	Wed, 16 Jul 2025 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752691298; cv=none; b=rm4mY7Ud+1SZehjnvjxK7VFi/X5g6aysZD6xcUGjflc2fQAri1Z+TANR4m24EW21K2AQWfZDIIPJ+PkypnGX7APMJC6lyCuS2PCV9JkIWDXFJMfBbHi/UQJ6pzgU71uzEWXCBCMtNc3E8lXQTn5lztUejzTx2ceGL4w25cLvu1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752691298; c=relaxed/simple;
	bh=VumIU/sQM3hsahHgvU+bHUnU0BcQF4aFEvHlkCVGo4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uE9SvjaIPI282l1EYjKtxNvG0WewB0PptPWc/7Eq1gdGA1gYqLuxtSpqATwxV2cM8IpXxCA9+lDITtcYIAns7cTLX5RI1jbWjpE0QJIXNNKbwSuYpfny9lzwsXI1P/FOOLDvrlzix/Yl368HgZzqL1KXyawG+L+JGaWIzw6O4Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrHgDB4R; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab7384b108so2787631cf.0;
        Wed, 16 Jul 2025 11:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752691296; x=1753296096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20DFtMKXGjzMStkeiX0rV+WhW7MQLkFjtE1G1H2gznA=;
        b=SrHgDB4RVsv0n+H4mlhVtq60euYC8/aUf/SF2M5tNpH/NrSLNpSBzsYm8GxnR1lyfQ
         QhjBuwPdXaDIu4pQEde3FXIIFVR11xg06bIJdGuGZJkL3ROGDIl4ExgxIiQhN44lWviL
         dPkqZDsO0TnJNHXORDXepenxEfp0TlIvZj1Z/7LSkhcEodmFFC0NztRuM6h2cRYP4m5P
         j3Yn481TbaZphfy6sj0XASirqpvqUoHvBxNDW2LOERUH6mvKB9LZSZ4bTd+OCIkbokeJ
         LI5C8Jv/4psRJleSxsJOEyxbUU8nwqdPA4A6qaWtwmmZTrFs+ED7BuoHa9zkmkfUiYo8
         Egog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752691296; x=1753296096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20DFtMKXGjzMStkeiX0rV+WhW7MQLkFjtE1G1H2gznA=;
        b=g02QK2pnmIItj/kTrEWpNjYxKwIXBYZjUqhQ/8MFXujF2l/f5XYT0+gSqTFFMus9Kf
         m0wU79zwosA/FkB5NvcGFNZDvKn32sbEIpCR6ahDrxyQD8an70zMA+pvenGycKIKITX3
         +Qs1uqecSXM3VsQCowMfwO7S+30GWCHrbQ0f6gianFlyi+uiIwc3tqWKhCHHMtv4oUPi
         z8SEYmvolAS1mkhlIlr+RbeT69TNESowh8xoIKKErEWmLrQyw2m7f5MD7xR2ilOw1feG
         lHQ89ydjLKh6GUGqRpweVHbEC/LA+7JNH48Z0DjcQuAUi5k8pk9q8SkWOH2siP0D6QWP
         fMqA==
X-Forwarded-Encrypted: i=1; AJvYcCUmi39hFR8cw2jGx7f0wg7MfVlkwHTCVhpoa5Elc8DCRhlCWqLJr7je0tn5p/ix8wk1DG3SY9vJEpr0S708@vger.kernel.org, AJvYcCXchK2EkHa3wMmP0tcGKLQZRpWYLmgZbeIfvvJl1Mo4ipiqyxM74kP7oCuZVG3y+rdQSPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbdiQVAStAaO87GowEDG9+hTIeYYehYL/0EfEgtPAi+/beJxbH
	i43S8CG9LapWFjAlSO3AcEDssOuTvET0rvS5PihrKJk8hZk7mnxZ7i963h7YAid+Bq70sep5bda
	ChrVey4GY6pJMlM5FtAL+l/h+TeEkOg8=
X-Gm-Gg: ASbGncttPLYOxhww/pqkPMJcmbGgqrydckk3FFu6/iJKZTRgaPwH6XIHeevcw7G2+ux
	x0BlE/lqB/5zAe5ohjQsEFdlNVEJD38jrWju/PscDloHYnfIPgDyXzdBFBnAKXu25HCkWci06Zr
	8KMdL2/Fk5695vXMT9ESm7i4dUJmp+o5NKEVQwxcHNRZH8ox9kzh79UZ4W5TPJijUInO3HyrrPU
	6dXVQg=
X-Google-Smtp-Source: AGHT+IFZwWhnvlktHUbt+Kieuk0AwdbSCwlwmi+WtIYajV9/Z+Oy1x/flaxD7uD3ONgFDnnoPfGTonQLpOquT9UuWu8=
X-Received: by 2002:a05:622a:7289:b0:4ab:9586:bdd8 with SMTP id
 d75a77b69052e-4ab9586c4f5mr41812881cf.55.1752691295354; Wed, 16 Jul 2025
 11:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709055029.723243-1-duanchenghao@kylinos.cn> <20250709055029.723243-5-duanchenghao@kylinos.cn>
In-Reply-To: <20250709055029.723243-5-duanchenghao@kylinos.cn>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Wed, 16 Jul 2025 11:41:24 -0700
X-Gm-Features: Ac12FXwCRPmy4fnOAV5BMBHHNEa-DFWYMRw-qWQJNXIcPq2W8Wh-_O30cTGVz84
Message-ID: <CAK3+h2zbcumLibRXi0Oh5zc1FB6JcQco5CTjTYd8o0DOkijjAw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LoongArch: BPF: Add bpf_arch_xxxxx support for Loongarch
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yangtiezhu@loongson.cn, hengqi.chen@gmail.com, chenhuacai@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 11:02=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
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

I recommend to add comment for bpf_arch_text_poke() similar to
bpf_arch_text_poke() in arch/arm64/net/bpf_jit_comp.c so we have clear
understanding on how it works, given we already have issue with it
when running xdp-filter from xdp-tools that I reported from another
email thread.

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
>

