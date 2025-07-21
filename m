Return-Path: <bpf+bounces-63882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E67B0BE53
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 09:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2593A7547
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 07:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F342285CA8;
	Mon, 21 Jul 2025 07:59:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EDCE555;
	Mon, 21 Jul 2025 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084773; cv=none; b=ovyECbHgZTi1g2BcpzylAgPmWZnq4B+bwLrwgEpNJ0YBuRhIEyzXd4aAsFHrrzFuAq3cRVUsB/oTU6fz0y+/hsuETyEwYHaTW9zU8JhsQNEgOUmjSvfz4mXYUWLeyRvBlsuPEuN4bY4dFanjGS0V0aBO3Pxcvv3NByBdgCI2KvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084773; c=relaxed/simple;
	bh=dCKyaPuMdmxVthC9fq2PvFaRriA546vr8fuuezJD5aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgonMY1s2Ooa8K1ZK7Cmzyoq3oqkxupgR3g53UtA8yNgQEwpfkgDqLGv/6MviQFKywZuFCL0bPwLZiM+7w6wwDOHyCVApnPC0njjWQyvnfjfZJikfDfJmOi6MfjALx0D4KDinQrDreVO9cf3rW6YoHP5Trlq4bbF97uWDagMEoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9bf5b12a660811f0b29709d653e92f7d-20250721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:7b406206-964a-4c4b-ab5f-f800871faf3b,IP:0,U
	RL:0,TC:0,Content:8,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:8
X-CID-META: VersionHash:6493067,CLOUDID:0a3659fc6bb702fa72899da2be79adf2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9bf5b12a660811f0b29709d653e92f7d-20250721
X-User: duanchenghao@kylinos.cn
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1961975670; Mon, 21 Jul 2025 15:59:21 +0800
Date: Mon, 21 Jul 2025 15:59:17 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yangtiezhu@loongson.cn, chenhuacai@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	bpf@vger.kernel.org, guodongtai@kylinos.cn, youling.tang@linux.dev,
	jianghaoran@kylinos.cn
Subject: Re: [PATCH v3 4/5] LoongArch: BPF: Add bpf_arch_xxxxx support for
 Loongarch
Message-ID: <20250721075917.GA264612@chenghao-pc>
References: <20250709055029.723243-1-duanchenghao@kylinos.cn>
 <20250709055029.723243-5-duanchenghao@kylinos.cn>
 <CAEyhmHS__fqHS8Bpg7+4apO7OuXG1sP3miCcAMT+Y3uU0+_xjg@mail.gmail.com>
 <20250717092746.GA993901@chenghao-pc>
 <CAEyhmHTpJ0OKbW1QEFV+XMxCC9kL2eSwKMkk7=YyLprjNxc8iA@mail.gmail.com>
 <20250718021658.GA203872@chenghao-pc>
 <CAEyhmHRL0FFwSqyir9DcKm24_k1idX02CtwFStwBL-Fxc2ukMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEyhmHRL0FFwSqyir9DcKm24_k1idX02CtwFStwBL-Fxc2ukMQ@mail.gmail.com>

On Mon, Jul 21, 2025 at 09:38:47AM +0800, Hengqi Chen wrote:
> On Fri, Jul 18, 2025 at 10:17 AM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> >
> > On Thu, Jul 17, 2025 at 06:12:55PM +0800, Hengqi Chen wrote:
> > > On Thu, Jul 17, 2025 at 5:27 PM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> > > >
> > > > On Wed, Jul 16, 2025 at 08:21:59PM +0800, Hengqi Chen wrote:
> > > > > On Wed, Jul 9, 2025 at 1:50 PM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> > > > > >
> > > > > > Implement the functions of bpf_arch_text_poke, bpf_arch_text_copy, and
> > > > > > bpf_arch_text_invalidate on the LoongArch architecture.
> > > > > >
> > > > > > On LoongArch, since symbol addresses in the direct mapping
> > > > > > region cannot be reached via relative jump instructions from the paged
> > > > > > mapping region, we use the move_imm+jirl instruction pair as absolute
> > > > > > jump instructions. These require 2-5 instructions, so we reserve 5 NOP
> > > > > > instructions in the program as placeholders for function jumps.
> > > > > >
> > > > > > Co-developed-by: George Guo <guodongtai@kylinos.cn>
> > > > > > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > > > > > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > > > > > ---
> > > > > >  arch/loongarch/include/asm/inst.h |  1 +
> > > > > >  arch/loongarch/kernel/inst.c      | 32 +++++++++++
> > > > > >  arch/loongarch/net/bpf_jit.c      | 90 +++++++++++++++++++++++++++++++
> > > > > >  3 files changed, 123 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> > > > > > index 2ae96a35d..88bb73e46 100644
> > > > > > --- a/arch/loongarch/include/asm/inst.h
> > > > > > +++ b/arch/loongarch/include/asm/inst.h
> > > > > > @@ -497,6 +497,7 @@ void arch_simulate_insn(union loongarch_instruction insn, struct pt_regs *regs);
> > > > > >  int larch_insn_read(void *addr, u32 *insnp);
> > > > > >  int larch_insn_write(void *addr, u32 insn);
> > > > > >  int larch_insn_patch_text(void *addr, u32 insn);
> > > > > > +int larch_insn_text_copy(void *dst, void *src, size_t len);
> > > > > >
> > > > > >  u32 larch_insn_gen_nop(void);
> > > > > >  u32 larch_insn_gen_b(unsigned long pc, unsigned long dest);
> > > > > > diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> > > > > > index 674e3b322..8d6594968 100644
> > > > > > --- a/arch/loongarch/kernel/inst.c
> > > > > > +++ b/arch/loongarch/kernel/inst.c
> > > > > > @@ -4,6 +4,7 @@
> > > > > >   */
> > > > > >  #include <linux/sizes.h>
> > > > > >  #include <linux/uaccess.h>
> > > > > > +#include <linux/set_memory.h>
> > > > > >
> > > > > >  #include <asm/cacheflush.h>
> > > > > >  #include <asm/inst.h>
> > > > > > @@ -218,6 +219,37 @@ int larch_insn_patch_text(void *addr, u32 insn)
> > > > > >         return ret;
> > > > > >  }
> > > > > >
> > > > > > +int larch_insn_text_copy(void *dst, void *src, size_t len)
> > > > > > +{
> > > > > > +       unsigned long flags;
> > > > > > +       size_t wlen = 0;
> > > > > > +       size_t size;
> > > > > > +       void *ptr;
> > > > > > +       int ret = 0;
> > > > > > +
> > > > > > +       set_memory_rw((unsigned long)dst, round_up(len, PAGE_SIZE) / PAGE_SIZE);
> > > > > > +       raw_spin_lock_irqsave(&patch_lock, flags);
> > > > > > +       while (wlen < len) {
> > > > > > +               ptr = dst + wlen;
> > > > > > +               size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
> > > > > > +                            len - wlen);
> > > > > > +
> > > > > > +               ret = copy_to_kernel_nofault(ptr, src + wlen, size);
> > > > > > +               if (ret) {
> > > > > > +                       pr_err("%s: operation failed\n", __func__);
> > > > > > +                       break;
> > > > > > +               }
> > > > > > +               wlen += size;
> > > > > > +       }
> > > > >
> > > > > Again, why do you do copy_to_kernel_nofault() in a loop ?
> > > >
> > > > The while loop processes all sizes. I referred to how ARM64 and
> > > > RISC-V64 handle this using loops as well.
> > >
> > > Any pointers ?
> >
> > I didn't understand what you meant.
> >
> 
> It's your responsibility to explain why we need a loop here, not mine.
> I checked every callsite of copy_to_kernel_nofault(), no one uses a loop.
> 

I referred to ARM and RISC-V. ARM copies a maximum length of PAGE_SIZE
each time, while RISC-V copies a maximum length of PAGE_SIZE*2 each time.
ARM and RISC-V use loops because Fixmap can map PAGE_SIZE at a time.

arm64: arch/arm64/kernel/patching.c	__text_poke
riscv: arch/riscv/kernel/patch.c	atch_insn_write

Although the internal implementation of copy_to_kernel_nofault also uses
a loop and employs store word instructions for copying, I've retained
the approach of processing each page individually. This is because I'm
concerned that misalignment might lead to other hidden issues.

Currently, the tests show that not using a loop works fine, but I've
kept this method as a precaution.

> > >
> > > >
> > > > > This larch_insn_text_copy() can be part of the first patch like
> > > > > larch_insn_gen_{beq,bne}. WDYT ?
> > > >
> > > > From my perspective, it is acceptable to include both
> > > > larch_insn_text_copy and larch_insn_gen_{beq,bne} in the same patch,
> > > > or place them in the bpf_arch_xxxx patch. larch_insn_text_copy is
> > > > solely used for BPF; the application scope of larch_insn_gen_{beq,bne}
> > > > is not limited to BPF.
> > > >
> > >
> > > The implementation of larch_insn_text_copy() seems generic.
> >
> > The use of larch_insn_text_copy() requires page_size alignment.
> > Currently, only the size of the trampoline is page-aligned.
> >
> 
> Then clearly document it.

Okay, I will provide an explanation in the next version of the commit.

> 
> > >
> > > > >
> > > > > > +       raw_spin_unlock_irqrestore(&patch_lock, flags);
> > > > > > +       set_memory_rox((unsigned long)dst, round_up(len, PAGE_SIZE) / PAGE_SIZE);
> > > > > > +
> > > > > > +       if (!ret)
> > > > > > +               flush_icache_range((unsigned long)dst, (unsigned long)dst + len);
> > > > > > +
> > > > > > +       return ret;
> > > > > > +}
> > > > > > +
> > > > > >  u32 larch_insn_gen_nop(void)
> > > > > >  {
> > > > > >         return INSN_NOP;
> > > > > > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> > > > > > index 7032f11d3..9cb01f0b0 100644
> > > > > > --- a/arch/loongarch/net/bpf_jit.c
> > > > > > +++ b/arch/loongarch/net/bpf_jit.c
> > > > > > @@ -4,6 +4,7 @@
> > > > > >   *
> > > > > >   * Copyright (C) 2022 Loongson Technology Corporation Limited
> > > > > >   */
> > > > > > +#include <linux/memory.h>
> > > > > >  #include "bpf_jit.h"
> > > > > >
> > > > > >  #define REG_TCC                LOONGARCH_GPR_A6
> > > > > > @@ -1367,3 +1368,92 @@ bool bpf_jit_supports_subprog_tailcalls(void)
> > > > > >  {
> > > > > >         return true;
> > > > > >  }
> > > > > > +
> > > > > > +static int emit_jump_and_link(struct jit_ctx *ctx, u8 rd, u64 ip, u64 target)
> > > > > > +{
> > > > > > +       s64 offset = (s64)(target - ip);
> > > > > > +
> > > > > > +       if (offset && (offset >= -SZ_128M && offset < SZ_128M)) {
> > > > > > +               emit_insn(ctx, bl, offset >> 2);
> > > > > > +       } else {
> > > > > > +               move_imm(ctx, LOONGARCH_GPR_T1, target, false);
> > > > > > +               emit_insn(ctx, jirl, rd, LOONGARCH_GPR_T1, 0);
> > > > > > +       }
> > > > > > +
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int gen_jump_or_nops(void *target, void *ip, u32 *insns, bool is_call)
> > > > > > +{
> > > > > > +       struct jit_ctx ctx;
> > > > > > +
> > > > > > +       ctx.idx = 0;
> > > > > > +       ctx.image = (union loongarch_instruction *)insns;
> > > > > > +
> > > > > > +       if (!target) {
> > > > > > +               emit_insn((&ctx), nop);
> > > > > > +               emit_insn((&ctx), nop);
> > > > > > +               return 0;
> > > > > > +       }
> > > > > > +
> > > > > > +       return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_T0 : LOONGARCH_GPR_ZERO,
> > > > > > +                                 (unsigned long)ip, (unsigned long)target);
> > > > > > +}
> > > > > > +
> > > > > > +int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
> > > > > > +                      void *old_addr, void *new_addr)
> > > > > > +{
> > > > > > +       u32 old_insns[5] = {[0 ... 4] = INSN_NOP};
> > > > > > +       u32 new_insns[5] = {[0 ... 4] = INSN_NOP};
> > > > > > +       bool is_call = poke_type == BPF_MOD_CALL;
> > > > > > +       int ret;
> > > > > > +
> > > > > > +       if (!is_kernel_text((unsigned long)ip) &&
> > > > > > +               !is_bpf_text_address((unsigned long)ip))
> > > > > > +               return -ENOTSUPP;
> > > > > > +
> > > > > > +       ret = gen_jump_or_nops(old_addr, ip, old_insns, is_call);
> > > > > > +       if (ret)
> > > > > > +               return ret;
> > > > > > +
> > > > > > +       if (memcmp(ip, old_insns, 5 * 4))
> > > > > > +               return -EFAULT;
> > > > > > +
> > > > > > +       ret = gen_jump_or_nops(new_addr, ip, new_insns, is_call);
> > > > > > +       if (ret)
> > > > > > +               return ret;
> > > > > > +
> > > > > > +       mutex_lock(&text_mutex);
> > > > > > +       if (memcmp(ip, new_insns, 5 * 4))
> > > > > > +               ret = larch_insn_text_copy(ip, new_insns, 5 * 4);
> > > > > > +       mutex_unlock(&text_mutex);
> > > > > > +       return ret;
> > > > > > +}
> > > > > > +
> > > > > > +int bpf_arch_text_invalidate(void *dst, size_t len)
> > > > > > +{
> > > > > > +       int i;
> > > > > > +       int ret = 0;
> > > > > > +       u32 *inst;
> > > > > > +
> > > > > > +       inst = kvmalloc(len, GFP_KERNEL);
> > > > > > +       if (!inst)
> > > > > > +               return -ENOMEM;
> > > > > > +
> > > > > > +       for (i = 0; i < (len/sizeof(u32)); i++)
> > > > > > +               inst[i] = INSN_BREAK;
> > > > > > +
> > > > > > +       if (larch_insn_text_copy(dst, inst, len))
> > > > > > +               ret = -EINVAL;
> > > > > > +
> > > > > > +       kvfree(inst);
> > > > > > +       return ret;
> > > > > > +}
> > > > > > +
> > > > > > +void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> > > > > > +{
> > > > > > +       if (larch_insn_text_copy(dst, src, len))
> > > > > > +               return ERR_PTR(-EINVAL);
> > > > > > +
> > > > > > +       return dst;
> > > > > > +}
> > > > > > --
> > > > > > 2.43.0
> > > > > >

