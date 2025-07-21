Return-Path: <bpf+bounces-63866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB93AB0B9CA
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 03:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221323B8E01
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 01:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A791B1714B7;
	Mon, 21 Jul 2025 01:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUuIxxgs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CAD8460;
	Mon, 21 Jul 2025 01:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753061941; cv=none; b=WhEfeVmgJtgLjI63zEqZ24qijOxdSX/+zBc9DNljg+wrCYuxb6rghKxpHt8mapn+h5UkxBEofGmrUd25wZ0gU/hl/AundjdQqatV6d7RJgWdMalymjskMmwjxXF+RTTsbzYd9yOO8rhfmleDhYywHFIS7hzT57hIu+dX74uK+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753061941; c=relaxed/simple;
	bh=PO4MwsGmW9qPk9qjtrdQ41wKEw14fK2NLOmzYqtm4Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xo3UX7jYG8cl57sVDJLDL6Alsp6zYwz59SHaODuJaHKZRxxNUaJeeSS0y/8SHqo1t1ytbZlg86GZkTCRDCN+WaauAxTNoDHV/NJmTLk0pygaQ39AxtQhohScey3TQ7e6CahdKPOIeN0e5QsPcf2W0qE5J1E598Ai0jaOqUFn0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUuIxxgs; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-41eaf6805ebso1580422b6e.3;
        Sun, 20 Jul 2025 18:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753061938; x=1753666738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VvhFlhsZQMCnpfYYt4dMxY8vbQNulzPjC3pPcEi758=;
        b=lUuIxxgsmuoG5B3Q0PvRXuHr46GUrYch/KLA0NfXQ8aXH1j0O2Zx+fPqRLbUOv46vh
         oyfPEOP0UZAHDWWCAkmmTx9Lr2fvVFhRCmTyJn91A71/fWNdqgZFPnDsMwEs0EmA2CUm
         IN19hKVVQC3PAPBvrZlMsa8HyM4Dhy8zbV1C1Gd7G+m4DV6p413s/uCw3dSfd7tjBqDl
         LIEYmkFiJT3bBOyHxrTWuw/xNdiC3kcr8xBZAtFkQtP1Ffh0qSTkJZZAJvzOXGTr4aGM
         vLoy2pzfkW2JKx7hWrvy/tRc6ZrwvrztrI8mK59WcjgcLZzps5BCAtNOETBgMT5siKqr
         Zz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753061938; x=1753666738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VvhFlhsZQMCnpfYYt4dMxY8vbQNulzPjC3pPcEi758=;
        b=WiLauSkrDfra0aovu5Nuhw4KU8RKKB6Wmf2aDdpSAK52R6Upr4Pae8vJa7Hqavp3ik
         N1csF00RHr0z/8EpRJBEYdAQyOGCiIrBV/zxhC9Vs9Q11bIs0Dx7T83rNWtdbFLq3vmk
         mfJ3VkhxC9lWYwKE5nFqVHG4C5rCTalA38Jq/q/QfUvgEorZAoJguj/UU0o8Ocj7Ss4M
         WJkoOFF4vdjuJxyca6VVeZIdJlIYqMx0rZ23ZISMx1Y4TcaGS+PehkApvrXZtCKfOhpQ
         fUPm95a1kl9iYw3247Wtevo4A5zOp0AsJOk8Pnf24f4ggZ2kSGSLrcuXrfbaAOfKsv97
         TLIg==
X-Forwarded-Encrypted: i=1; AJvYcCV5VnUpmMc49g0pd/vXpbadsmIP9MWjZmYHVJXF16yWJoFsGKxqKlRS/kHORvbPfENMwTKfZvZyyWRWfBz1@vger.kernel.org, AJvYcCX05Tn9A/QlLB/d6txzJf13b4tK0fvYcoyJRmK6q88Q9w8FrZS28JTHEy59CmJxPFEzzFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTdyzyhgCt54xbQjwiUVSM7GfxX8VWpRNkX5JM7my5+3HeiKx7
	O0Am1HN0ZLEwUognHux6lfggBf7suMRNivpcRqJu5eX9m0IEP97exoAbf8TBaDlZzAM557ZOtKJ
	wGPO3LUco3pE3spVg8BSmM5eRA3N/yKo=
X-Gm-Gg: ASbGncsOjTiAgL1w8BWu+8DbiFKg1rKIMVUsdIrrmnyrAUMrz/AqVh2LkGsZ3lVK8Qc
	QgMjIV8QhHODdag2ba35sIAaClqJpB5PxlsaeeV6/bXmAPxGgM/Z+CT2/QNl+Pt2P8QYLIGxoDM
	nerB9uOkyuz9lRY7G0nZc1gJ6u2hpIAfKGlyw9pnNEBb8r3AyzncDvcjYbVmTWqPv1QNpgaxAf0
	c5QMRo=
X-Google-Smtp-Source: AGHT+IFGpEW1mdQOV07ps+z7zGHj/SHi0zMpi1/Owyf6XyhxVieE95N5nioKlkCZb5ZNc1b+Clyf7hTMNXm8rXNutzI=
X-Received: by 2002:a05:6808:4f54:b0:41b:51c4:3db0 with SMTP id
 5614622812f47-41cee274b50mr15015805b6e.1.1753061938265; Sun, 20 Jul 2025
 18:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709055029.723243-1-duanchenghao@kylinos.cn>
 <20250709055029.723243-5-duanchenghao@kylinos.cn> <CAEyhmHS__fqHS8Bpg7+4apO7OuXG1sP3miCcAMT+Y3uU0+_xjg@mail.gmail.com>
 <20250717092746.GA993901@chenghao-pc> <CAEyhmHTpJ0OKbW1QEFV+XMxCC9kL2eSwKMkk7=YyLprjNxc8iA@mail.gmail.com>
 <20250718021658.GA203872@chenghao-pc>
In-Reply-To: <20250718021658.GA203872@chenghao-pc>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 21 Jul 2025 09:38:47 +0800
X-Gm-Features: Ac12FXzElR97SWvvE_bw_O8oDY9xd9oLIQXI1mxXQHZXvgj_GlG9MSrK1vSrj_k
Message-ID: <CAEyhmHRL0FFwSqyir9DcKm24_k1idX02CtwFStwBL-Fxc2ukMQ@mail.gmail.com>
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

On Fri, Jul 18, 2025 at 10:17=E2=80=AFAM Chenghao Duan <duanchenghao@kylino=
s.cn> wrote:
>
> On Thu, Jul 17, 2025 at 06:12:55PM +0800, Hengqi Chen wrote:
> > On Thu, Jul 17, 2025 at 5:27=E2=80=AFPM Chenghao Duan <duanchenghao@kyl=
inos.cn> wrote:
> > >
> > > On Wed, Jul 16, 2025 at 08:21:59PM +0800, Hengqi Chen wrote:
> > > > On Wed, Jul 9, 2025 at 1:50=E2=80=AFPM Chenghao Duan <duanchenghao@=
kylinos.cn> wrote:
> > > > >
> > > > > Implement the functions of bpf_arch_text_poke, bpf_arch_text_copy=
, and
> > > > > bpf_arch_text_invalidate on the LoongArch architecture.
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
> > > > > Co-developed-by: George Guo <guodongtai@kylinos.cn>
> > > > > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > > > > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > > > > ---
> > > > >  arch/loongarch/include/asm/inst.h |  1 +
> > > > >  arch/loongarch/kernel/inst.c      | 32 +++++++++++
> > > > >  arch/loongarch/net/bpf_jit.c      | 90 +++++++++++++++++++++++++=
++++++
> > > > >  3 files changed, 123 insertions(+)
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
> > > > > index 674e3b322..8d6594968 100644
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
> > > > > @@ -218,6 +219,37 @@ int larch_insn_patch_text(void *addr, u32 in=
sn)
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > > +int larch_insn_text_copy(void *dst, void *src, size_t len)
> > > > > +{
> > > > > +       unsigned long flags;
> > > > > +       size_t wlen =3D 0;
> > > > > +       size_t size;
> > > > > +       void *ptr;
> > > > > +       int ret =3D 0;
> > > > > +
> > > > > +       set_memory_rw((unsigned long)dst, round_up(len, PAGE_SIZE=
) / PAGE_SIZE);
> > > > > +       raw_spin_lock_irqsave(&patch_lock, flags);
> > > > > +       while (wlen < len) {
> > > > > +               ptr =3D dst + wlen;
> > > > > +               size =3D min_t(size_t, PAGE_SIZE - offset_in_page=
(ptr),
> > > > > +                            len - wlen);
> > > > > +
> > > > > +               ret =3D copy_to_kernel_nofault(ptr, src + wlen, s=
ize);
> > > > > +               if (ret) {
> > > > > +                       pr_err("%s: operation failed\n", __func__=
);
> > > > > +                       break;
> > > > > +               }
> > > > > +               wlen +=3D size;
> > > > > +       }
> > > >
> > > > Again, why do you do copy_to_kernel_nofault() in a loop ?
> > >
> > > The while loop processes all sizes. I referred to how ARM64 and
> > > RISC-V64 handle this using loops as well.
> >
> > Any pointers ?
>
> I didn't understand what you meant.
>

It's your responsibility to explain why we need a loop here, not mine.
I checked every callsite of copy_to_kernel_nofault(), no one uses a loop.

> >
> > >
> > > > This larch_insn_text_copy() can be part of the first patch like
> > > > larch_insn_gen_{beq,bne}. WDYT ?
> > >
> > > From my perspective, it is acceptable to include both
> > > larch_insn_text_copy and larch_insn_gen_{beq,bne} in the same patch,
> > > or place them in the bpf_arch_xxxx patch. larch_insn_text_copy is
> > > solely used for BPF; the application scope of larch_insn_gen_{beq,bne=
}
> > > is not limited to BPF.
> > >
> >
> > The implementation of larch_insn_text_copy() seems generic.
>
> The use of larch_insn_text_copy() requires page_size alignment.
> Currently, only the size of the trampoline is page-aligned.
>

Then clearly document it.

> >
> > > >
> > > > > +       raw_spin_unlock_irqrestore(&patch_lock, flags);
> > > > > +       set_memory_rox((unsigned long)dst, round_up(len, PAGE_SIZ=
E) / PAGE_SIZE);
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
> > > > > index 7032f11d3..9cb01f0b0 100644
> > > > > --- a/arch/loongarch/net/bpf_jit.c
> > > > > +++ b/arch/loongarch/net/bpf_jit.c
> > > > > @@ -4,6 +4,7 @@
> > > > >   *
> > > > >   * Copyright (C) 2022 Loongson Technology Corporation Limited
> > > > >   */
> > > > > +#include <linux/memory.h>
> > > > >  #include "bpf_jit.h"
> > > > >
> > > > >  #define REG_TCC                LOONGARCH_GPR_A6
> > > > > @@ -1367,3 +1368,92 @@ bool bpf_jit_supports_subprog_tailcalls(vo=
id)
> > > > >  {
> > > > >         return true;
> > > > >  }
> > > > > +
> > > > > +static int emit_jump_and_link(struct jit_ctx *ctx, u8 rd, u64 ip=
, u64 target)
> > > > > +{
> > > > > +       s64 offset =3D (s64)(target - ip);
> > > > > +
> > > > > +       if (offset && (offset >=3D -SZ_128M && offset < SZ_128M))=
 {
> > > > > +               emit_insn(ctx, bl, offset >> 2);
> > > > > +       } else {
> > > > > +               move_imm(ctx, LOONGARCH_GPR_T1, target, false);
> > > > > +               emit_insn(ctx, jirl, rd, LOONGARCH_GPR_T1, 0);
> > > > > +       }
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
> > > > > +               return 0;
> > > > > +       }
> > > > > +
> > > > > +       return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_T=
0 : LOONGARCH_GPR_ZERO,
> > > > > +                                 (unsigned long)ip, (unsigned lo=
ng)target);
> > > > > +}
> > > > > +
> > > > > +int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_ty=
pe,
> > > > > +                      void *old_addr, void *new_addr)
> > > > > +{
> > > > > +       u32 old_insns[5] =3D {[0 ... 4] =3D INSN_NOP};
> > > > > +       u32 new_insns[5] =3D {[0 ... 4] =3D INSN_NOP};
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
> > > > > +       if (memcmp(ip, old_insns, 5 * 4))
> > > > > +               return -EFAULT;
> > > > > +
> > > > > +       ret =3D gen_jump_or_nops(new_addr, ip, new_insns, is_call=
);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       mutex_lock(&text_mutex);
> > > > > +       if (memcmp(ip, new_insns, 5 * 4))
> > > > > +               ret =3D larch_insn_text_copy(ip, new_insns, 5 * 4=
);
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
> > > > > +       if (larch_insn_text_copy(dst, inst, len))
> > > > > +               ret =3D -EINVAL;
> > > > > +
> > > > > +       kvfree(inst);
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> > > > > +{
> > > > > +       if (larch_insn_text_copy(dst, src, len))
> > > > > +               return ERR_PTR(-EINVAL);
> > > > > +
> > > > > +       return dst;
> > > > > +}
> > > > > --
> > > > > 2.43.0
> > > > >

