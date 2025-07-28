Return-Path: <bpf+bounces-64511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C67FB13AE2
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 15:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F221894DFF
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0059F1A0BD0;
	Mon, 28 Jul 2025 13:00:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBCE72633;
	Mon, 28 Jul 2025 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753707616; cv=none; b=Oo/WgAigPAtFO4kmF3pYiu+mRrOnKrW2KkSUQPOFypalKTv+m7flIhaLmhZdPV4UmrHSwngaBCDinZPodnus8usOY8EfNtz5Mk9c1U2Eh3s0WE/FUHPlD6jFxV6XV64HaxTiR/7EUtzMtk7aHrTnMO4xuKUNO6MH/Q5LKyS04B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753707616; c=relaxed/simple;
	bh=DlYCEKDtDh0DnKbrp4IPzsLeQlsdlD1wyM+xD7uMpu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADGGVNIzOWd19AI1neShZu+7owOWOFRwNlCSfcMwZxl5LUumCSoWaiVGlU740merIRowPqqokGO+AGCYE8dKGeXFYrLq6MOv+llySRzwA4MsX1b2JDY+vsHY2kQcKdYzY/7GTYcvfSKnh+OTZy9X/WOQBAglUgdUNIjyfmiW25E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c661f9286bb211f0b29709d653e92f7d-20250728
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:2d6abe41-8cbd-4f2f-a551-d86b80dae557,IP:10,
	URL:0,TC:0,Content:9,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:14
X-CID-INFO: VERSION:1.1.45,REQID:2d6abe41-8cbd-4f2f-a551-d86b80dae557,IP:10,UR
	L:0,TC:0,Content:9,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:14
X-CID-META: VersionHash:6493067,CLOUDID:59e4b8029e56e93a67df1883ccf2387d,BulkI
	D:250728103101KH33AOP9,BulkQuantity:6,Recheck:0,SF:17|19|23|43|64|66|74|78
	|80|81|82|83|102|841,TC:nil,Content:4|50,EDM:-3,IP:-2,URL:0,File:nil,RT:ni
	l,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,B
	RR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: c661f9286bb211f0b29709d653e92f7d-20250728
X-User: duanchenghao@kylinos.cn
Received: from localhost [(39.144.190.111)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1021292728; Mon, 28 Jul 2025 21:00:02 +0800
Date: Mon, 28 Jul 2025 20:59:56 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yangtiezhu@loongson.cn, chenhuacai@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	bpf@vger.kernel.org, guodongtai@kylinos.cn, youling.tang@linux.dev,
	jianghaoran@kylinos.cn, vincent.mc.li@gmail.com
Subject: Re: [PATCH v4 3/5] LoongArch: BPF: Add bpf_arch_xxxxx support for
 Loongarch
Message-ID: <20250728125956.GA1439240@chenghao-pc>
References: <20250724141929.691853-1-duanchenghao@kylinos.cn>
 <20250724141929.691853-4-duanchenghao@kylinos.cn>
 <CAEyhmHQAAE_a7X4UWHVsKq3hp2jd4LRDP31kOjL_E-bz9coqYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEyhmHQAAE_a7X4UWHVsKq3hp2jd4LRDP31kOjL_E-bz9coqYw@mail.gmail.com>

On Mon, Jul 28, 2025 at 06:58:41PM +0800, Hengqi Chen wrote:
> On Thu, Jul 24, 2025 at 10:21 PM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> >
> > Implement the functions of bpf_arch_text_poke, bpf_arch_text_copy, and
> > bpf_arch_text_invalidate on the LoongArch architecture.
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
> 
> The subject line seems kind of casual, bpf_arch_xxxxx ?

Here is the modified commit log. Please take a look.

LoongArch: BPF: Implement dynamic code modification support

This commit adds the necessary infrastructure for BPF dynamic code
modification on LoongArch architecture:
1. Implement bpf_arch_text_poke() for runtime instruction patching.
2. Add bpf_arch_text_copy() for instruction block copying.
3. Create bpf_arch_text_invalidate() for code invalidation.

On LoongArch, since symbol addresses in the direct mapping
region cannot be reached via relative jump instructions from the paged
mapping region, we use the move_imm+jirl instruction pair as absolute
jump instructions. These require 2-5 instructions, so we reserve 5 NOP
instructions in the program as placeholders for function jumps.

arch_insn_text_copy is solely used for BPF. The use of
larch_insn_text_copy() requires page_size alignment. Currently, only
the size of the trampoline is page-aligned.

> 
> > Co-developed-by: George Guo <guodongtai@kylinos.cn>
> > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>
> > Reviewed-by: Huacai Chen <chenhuacai@kernel.org>
> 
> I didn't leave a Reviewed-by tag last time, no ?

I added this. If there are any mistakes, please correct them.

> 
> > ---
> >  arch/loongarch/include/asm/inst.h |  1 +
> >  arch/loongarch/kernel/inst.c      | 32 ++++++++++
> >  arch/loongarch/net/bpf_jit.c      | 97 +++++++++++++++++++++++++++++++
> >  3 files changed, 130 insertions(+)
> >
> > diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> > index 2ae96a35d..88bb73e46 100644
> > --- a/arch/loongarch/include/asm/inst.h
> > +++ b/arch/loongarch/include/asm/inst.h
> > @@ -497,6 +497,7 @@ void arch_simulate_insn(union loongarch_instruction insn, struct pt_regs *regs);
> >  int larch_insn_read(void *addr, u32 *insnp);
> >  int larch_insn_write(void *addr, u32 insn);
> >  int larch_insn_patch_text(void *addr, u32 insn);
> > +int larch_insn_text_copy(void *dst, void *src, size_t len);
> >
> >  u32 larch_insn_gen_nop(void);
> >  u32 larch_insn_gen_b(unsigned long pc, unsigned long dest);
> > diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> > index 674e3b322..8d6594968 100644
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
> > @@ -218,6 +219,37 @@ int larch_insn_patch_text(void *addr, u32 insn)
> >         return ret;
> >  }
> >
> > +int larch_insn_text_copy(void *dst, void *src, size_t len)
> > +{
> > +       unsigned long flags;
> > +       size_t wlen = 0;
> > +       size_t size;
> > +       void *ptr;
> > +       int ret = 0;
> > +
> > +       set_memory_rw((unsigned long)dst, round_up(len, PAGE_SIZE) / PAGE_SIZE);
> > +       raw_spin_lock_irqsave(&patch_lock, flags);
> > +       while (wlen < len) {
> > +               ptr = dst + wlen;
> > +               size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
> > +                            len - wlen);
> > +
> > +               ret = copy_to_kernel_nofault(ptr, src + wlen, size);
> > +               if (ret) {
> > +                       pr_err("%s: operation failed\n", __func__);
> > +                       break;
> > +               }
> > +               wlen += size;
> > +       }
> > +       raw_spin_unlock_irqrestore(&patch_lock, flags);
> > +       set_memory_rox((unsigned long)dst, round_up(len, PAGE_SIZE) / PAGE_SIZE);
> > +
> > +       if (!ret)
> > +               flush_icache_range((unsigned long)dst, (unsigned long)dst + len);
> > +
> > +       return ret;
> > +}
> > +
> >  u32 larch_insn_gen_nop(void)
> >  {
> >         return INSN_NOP;
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> > index 7032f11d3..86504e710 100644
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
> >         int stack_adjust = 0, store_offset, bpf_stack_adjust;
> >
> >         bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
> > @@ -98,6 +103,10 @@ static void build_prologue(struct jit_ctx *ctx)
> >         stack_adjust = round_up(stack_adjust, 16);
> >         stack_adjust += bpf_stack_adjust;
> >
> > +       /* Reserve space for the move_imm + jirl instruction */
> > +       for (i = 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
> > +               emit_insn(ctx, nop);
> > +
> >         /*
> >          * First instruction initializes the tail call count (TCC).
> >          * On tail call we skip this instruction, and the TCC is
> > @@ -1367,3 +1376,91 @@ bool bpf_jit_supports_subprog_tailcalls(void)
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
> > +static int gen_jump_or_nops(void *target, void *ip, u32 *insns, bool is_call)
> > +{
> > +       struct jit_ctx ctx;
> > +
> > +       ctx.idx = 0;
> > +       ctx.image = (union loongarch_instruction *)insns;
> > +
> > +       if (!target) {
> > +               emit_insn((&ctx), nop);
> > +               emit_insn((&ctx), nop);
> > +               return 0;
> > +       }
> > +
> > +       return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_T0 : LOONGARCH_GPR_ZERO,
> > +                                 (unsigned long)target);
> > +}
> > +
> > +int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
> > +                      void *old_addr, void *new_addr)
> > +{
> > +       u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
> > +       u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
> > +       bool is_call = poke_type == BPF_MOD_CALL;
> > +       int ret;
> > +
> > +       if (!is_kernel_text((unsigned long)ip) &&
> > +               !is_bpf_text_address((unsigned long)ip))
> > +               return -ENOTSUPP;
> > +
> > +       ret = gen_jump_or_nops(old_addr, ip, old_insns, is_call);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (memcmp(ip, old_insns, LOONGARCH_LONG_JUMP_NBYTES))
> > +               return -EFAULT;
> > +
> > +       ret = gen_jump_or_nops(new_addr, ip, new_insns, is_call);
> > +       if (ret)
> > +               return ret;
> > +
> > +       mutex_lock(&text_mutex);
> > +       if (memcmp(ip, new_insns, LOONGARCH_LONG_JUMP_NBYTES))
> > +               ret = larch_insn_text_copy(ip, new_insns, LOONGARCH_LONG_JUMP_NBYTES);
> > +       mutex_unlock(&text_mutex);
> > +       return ret;
> > +}
> > +
> > +int bpf_arch_text_invalidate(void *dst, size_t len)
> > +{
> > +       int i;
> > +       int ret = 0;
> > +       u32 *inst;
> > +
> > +       inst = kvmalloc(len, GFP_KERNEL);
> > +       if (!inst)
> > +               return -ENOMEM;
> > +
> > +       for (i = 0; i < (len/sizeof(u32)); i++)
> > +               inst[i] = INSN_BREAK;
> > +
> > +       if (larch_insn_text_copy(dst, inst, len))
> > +               ret = -EINVAL;
> > +
> > +       kvfree(inst);
> > +       return ret;
> > +}
> > +
> > +void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> > +{
> > +       if (larch_insn_text_copy(dst, src, len))
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       return dst;
> > +}
> > --
> > 2.25.1
> >

