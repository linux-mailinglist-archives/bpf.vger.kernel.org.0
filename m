Return-Path: <bpf+bounces-65189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB96B1D5C9
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 12:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A3A1AA043F
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 10:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F1F261586;
	Thu,  7 Aug 2025 10:27:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBA123D281;
	Thu,  7 Aug 2025 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754562428; cv=none; b=oF24o5yE55ossOpYPZLfpFn+apzAqm8gDy/hsPJjl1NTz27/yIPPIR+mJtq5QCroy+GMzB7mofRFF532lJzPhYK7fk2TcSjLghd7yRUF6GT+LjMGBNNWXW4sYqryKth7c5rH8IE0z8YylbKiLhlc154ta46wo/QqR6Lw3BfQRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754562428; c=relaxed/simple;
	bh=8zgp6Hrxq3hg3DU7yU4BsBAnqWmy+gDYxEGqdUTihXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/AJrVs65FkKKUcDj1tLhca82JUghb/jQmy05BzkzH+v1HmK+Fgmw7shub8FsRzJ0mDO57jpxPx051QrHzZLHHAsANvplXxngRtKkgGnG5+vRKtUbXs4MXKkt/Wdd/zBDWeYxqYfVHLh5wVSXdw9810sT2p3tPfr98wdudgKi1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 06d26c54737911f0b29709d653e92f7d-20250807
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI, GTI_FG_IT
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:78cf0644-c9ff-4665-baec-8b7fbda81c8c,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:78cf0644-c9ff-4665-baec-8b7fbda81c8c,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:7b1e0f23c6d717d722284e6f70270356,BulkI
	D:250805121026AMCKBPYY,BulkQuantity:7,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 06d26c54737911f0b29709d653e92f7d-20250807
X-User: duanchenghao@kylinos.cn
Received: from localhost [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 415827434; Thu, 07 Aug 2025 18:26:49 +0800
Date: Thu, 7 Aug 2025 18:26:31 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, yangtiezhu@loongson.cn,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, kernel@xen0n.name, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, bpf@vger.kernel.org,
	guodongtai@kylinos.cn, youling.tang@linux.dev,
	jianghaoran@kylinos.cn, vincent.mc.li@gmail.com, geliang@kernel.org
Subject: Re: [PATCH v5 3/5] LoongArch: BPF: Implement dynamic code
 modification support
Message-ID: <20250807102631.GA1401760@chenghao-pc>
References: <20250730131257.124153-1-duanchenghao@kylinos.cn>
 <20250730131257.124153-4-duanchenghao@kylinos.cn>
 <CAEyhmHTE8yd0-N5YkMvJScv+Dsw3sAvgyZt8h1sd1=rzaCoTwQ@mail.gmail.com>
 <CAAhV-H55VoFdK8B-PBhYfzHAOQJLnOxLUZGZyHqqdvt=5K3Zhg@mail.gmail.com>
 <20250805063014.GA543627@chenghao-pc>
 <CAAhV-H4W6z2CRBJ2VDsKTmmGNS+NmfH4aZCRB6K9+XQ4i3vPCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4W6z2CRBJ2VDsKTmmGNS+NmfH4aZCRB6K9+XQ4i3vPCA@mail.gmail.com>

On Tue, Aug 05, 2025 at 07:13:04PM +0800, Huacai Chen wrote:
> On Tue, Aug 5, 2025 at 2:30 PM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> >
> > On Tue, Aug 05, 2025 at 12:10:05PM +0800, Huacai Chen wrote:
> > > On Mon, Aug 4, 2025 at 10:02 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> > > >
> > > > On Wed, Jul 30, 2025 at 9:13 PM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> > > > >
> > > > > This commit adds support for BPF dynamic code modification on the
> > > > > LoongArch architecture.:
> > > > > 1. Implement bpf_arch_text_poke() for runtime instruction patching.
> > > > > 2. Add bpf_arch_text_copy() for instruction block copying.
> > > > > 3. Create bpf_arch_text_invalidate() for code invalidation.
> > > > >
> > > > > On LoongArch, since symbol addresses in the direct mapping
> > > > > region cannot be reached via relative jump instructions from the paged
> > > > > mapping region, we use the move_imm+jirl instruction pair as absolute
> > > > > jump instructions. These require 2-5 instructions, so we reserve 5 NOP
> > > > > instructions in the program as placeholders for function jumps.
> > > > >
> > > > > larch_insn_text_copy is solely used for BPF. The use of
> > > > > larch_insn_text_copy() requires page_size alignment. Currently, only
> > > > > the size of the trampoline is page-aligned.
> > > > >
> > > > > Co-developed-by: George Guo <guodongtai@kylinos.cn>
> > > > > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > > > > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > > > > ---
> > > > >  arch/loongarch/include/asm/inst.h |   1 +
> > > > >  arch/loongarch/kernel/inst.c      |  27 ++++++++
> > > > >  arch/loongarch/net/bpf_jit.c      | 104 ++++++++++++++++++++++++++++++
> > > > >  3 files changed, 132 insertions(+)
> > > > >
> > > > > diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> > > > > index 2ae96a35d..88bb73e46 100644
> > > > > --- a/arch/loongarch/include/asm/inst.h
> > > > > +++ b/arch/loongarch/include/asm/inst.h
> > > > > @@ -497,6 +497,7 @@ void arch_simulate_insn(union loongarch_instruction insn, struct pt_regs *regs);
> > > > >  int larch_insn_read(void *addr, u32 *insnp);
> > > > >  int larch_insn_write(void *addr, u32 insn);
> > > > >  int larch_insn_patch_text(void *addr, u32 insn);
> > > > > +int larch_insn_text_copy(void *dst, void *src, size_t len);
> > > > >
> > > > >  u32 larch_insn_gen_nop(void);
> > > > >  u32 larch_insn_gen_b(unsigned long pc, unsigned long dest);
> > > > > diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
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
> > > > > @@ -218,6 +219,32 @@ int larch_insn_patch_text(void *addr, u32 insn)
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > > +int larch_insn_text_copy(void *dst, void *src, size_t len)
> > > > > +{
> > > > > +       int ret;
> > > > > +       unsigned long flags;
> > > > > +       unsigned long dst_start, dst_end, dst_len;
> > > > > +
> > > > > +       dst_start = round_down((unsigned long)dst, PAGE_SIZE);
> > > > > +       dst_end = round_up((unsigned long)dst + len, PAGE_SIZE);
> > > > > +       dst_len = dst_end - dst_start;
> > > > > +
> > > > > +       set_memory_rw(dst_start, dst_len / PAGE_SIZE);
> > > > > +       raw_spin_lock_irqsave(&patch_lock, flags);
> > > > > +
> > > > > +       ret = copy_to_kernel_nofault(dst, src, len);
> > > > > +       if (ret)
> > > > > +               pr_err("%s: operation failed\n", __func__);
> > > > > +
> > > > > +       raw_spin_unlock_irqrestore(&patch_lock, flags);
> > > > > +       set_memory_rox(dst_start, dst_len / PAGE_SIZE);
> > > > > +
> > > > > +       if (!ret)
> > > > > +               flush_icache_range((unsigned long)dst, (unsigned long)dst + len);
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > >  u32 larch_insn_gen_nop(void)
> > > > >  {
> > > > >         return INSN_NOP;
> > > > > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
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
> > > > > +#define LOONGARCH_LONG_JUMP_NBYTES (LOONGARCH_LONG_JUMP_NINSNS * 4)
> > > > > +
> > > > >  #define REG_TCC                LOONGARCH_GPR_A6
> > > > >  #define TCC_SAVED      LOONGARCH_GPR_S5
> > > > >
> > > > > @@ -88,6 +92,7 @@ static u8 tail_call_reg(struct jit_ctx *ctx)
> > > > >   */
> > > > >  static void build_prologue(struct jit_ctx *ctx)
> > > > >  {
> > > > > +       int i;
> > > > >         int stack_adjust = 0, store_offset, bpf_stack_adjust;
> > > > >
> > > > >         bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
> > > > > @@ -98,6 +103,10 @@ static void build_prologue(struct jit_ctx *ctx)
> > > > >         stack_adjust = round_up(stack_adjust, 16);
> > > > >         stack_adjust += bpf_stack_adjust;
> > > > >
> > > > > +       /* Reserve space for the move_imm + jirl instruction */
> > > > > +       for (i = 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
> > > > > +               emit_insn(ctx, nop);
> > > > > +
> > > > >         /*
> > > > >          * First instruction initializes the tail call count (TCC).
> > > > >          * On tail call we skip this instruction, and the TCC is
> > > > > @@ -1367,3 +1376,98 @@ bool bpf_jit_supports_subprog_tailcalls(void)
> > > > >  {
> > > > >         return true;
> > > > >  }
> > > > > +
> > > > > +static int emit_jump_and_link(struct jit_ctx *ctx, u8 rd, u64 target)
> > > > > +{
> > > > > +       if (!target) {
> > > > > +               pr_err("bpf_jit: jump target address is error\n");
> > > > > +               return -EFAULT;
> > > > > +       }
> > > > > +
> > > > > +       move_imm(ctx, LOONGARCH_GPR_T1, target, false);
> > > > > +       emit_insn(ctx, jirl, rd, LOONGARCH_GPR_T1, 0);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int gen_jump_or_nops(void *target, void *ip, u32 *insns, bool is_call)
> > > > > +{
> > > > > +       struct jit_ctx ctx;
> > > > > +
> > > > > +       ctx.idx = 0;
> > > > > +       ctx.image = (union loongarch_instruction *)insns;
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
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next
> 
> Huacai

The following test items have been successfully tested:

./test_progs -a fentry_test/fentry
./test_progs -a fexit_test/fexit
./test_progs -a fentry_fexit
./test_progs -a modify_return
./test_progs -a fexit_sleep
./test_progs -a test_overhead
./test_progs -a trampoline_count
./test_progs -a fexit_bpf2bpf

./test_progs -t struct_ops -d struct_ops_multi_pages
#15/1    bad_struct_ops/invalid_prog_reuse:OK
#15/2    bad_struct_ops/unused_program:OK
#15      bad_struct_ops:OK
#408/1   struct_ops_autocreate/cant_load_full_object:OK
#408/2   struct_ops_autocreate/can_load_partial_object:OK
#408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
#408/4   struct_ops_autocreate/optional_maps:OK
#408     struct_ops_autocreate:OK
#409/1   struct_ops_kptr_return/kptr_return:OK
#409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
#409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
#409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
#409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
#409     struct_ops_kptr_return:OK
#410/1   struct_ops_maybe_null/maybe_null:OK
#410/2   struct_ops_maybe_null/maybe_null_fail:OK
#410     struct_ops_maybe_null:OK
#411/1   struct_ops_module/struct_ops_load:OK
#411/2   struct_ops_module/struct_ops_not_zeroed:OK
#411/3   struct_ops_module/struct_ops_incompatible:OK
#411/4   struct_ops_module/struct_ops_null_out_cb:OK
#411/5   struct_ops_module/struct_ops_forgotten_cb:OK
#411/6   struct_ops_module/test_detach_link:OK
#411/7   struct_ops_module/unsupported_ops:OK
#411     struct_ops_module:OK
#413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
#413     struct_ops_no_cfi:OK
#414/1   struct_ops_private_stack/private_stack:SKIP
#414/2   struct_ops_private_stack/private_stack_fail:SKIP
#414/3   struct_ops_private_stack/private_stack_recur:SKIP
#414     struct_ops_private_stack:SKIP
#415/1   struct_ops_refcounted/refcounted:OK
#415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
#415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
#415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
#415     struct_ops_refcounted:OK
Summary: 8/25 PASSED, 3 SKIPPED, 0 FAILED

while true; do ./test_progs -a fentry_attach_stress; sleep 1; done
(Loop 60 times.)

Chenghao
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
> >         for (i = 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
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
> > > > > +       return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_T0 : LOONGARCH_GPR_ZERO,
> > > > > +                                 (unsigned long)target);
> > > > > +}
> > > > > +
> > > > > +int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
> > > > > +                      void *old_addr, void *new_addr)
> > > > > +{
> > > > > +       u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
> > > > > +       u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
> > > > > +       bool is_call = poke_type == BPF_MOD_CALL;
> > > > > +       int ret;
> > > > > +
> > > > > +       if (!is_kernel_text((unsigned long)ip) &&
> > > > > +               !is_bpf_text_address((unsigned long)ip))
> > > > > +               return -ENOTSUPP;
> > > > > +
> > > > > +       ret = gen_jump_or_nops(old_addr, ip, old_insns, is_call);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       if (memcmp(ip, old_insns, LOONGARCH_LONG_JUMP_NBYTES))
> > > > > +               return -EFAULT;
> > > > > +
> > > > > +       ret = gen_jump_or_nops(new_addr, ip, new_insns, is_call);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       mutex_lock(&text_mutex);
> > > > > +       if (memcmp(ip, new_insns, LOONGARCH_LONG_JUMP_NBYTES))
> > > > > +               ret = larch_insn_text_copy(ip, new_insns, LOONGARCH_LONG_JUMP_NBYTES);
> > > > > +       mutex_unlock(&text_mutex);
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +int bpf_arch_text_invalidate(void *dst, size_t len)
> > > > > +{
> > > > > +       int i;
> > > > > +       int ret = 0;
> > > > > +       u32 *inst;
> > > > > +
> > > > > +       inst = kvmalloc(len, GFP_KERNEL);
> > > > > +       if (!inst)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       for (i = 0; i < (len/sizeof(u32)); i++)
> > > > > +               inst[i] = INSN_BREAK;
> > > > > +
> > > > > +       mutex_lock(&text_mutex);
> > > > > +       if (larch_insn_text_copy(dst, inst, len))
> > > > > +               ret = -EINVAL;
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
> > > > > +       ret = larch_insn_text_copy(dst, src, len);
> > > > > +       mutex_unlock(&text_mutex);
> > > > > +       if (ret)
> > > > > +               return ERR_PTR(-EINVAL);
> > > > > +
> > > > > +       return dst;
> > > > > +}
> > > > > --
> > > >
> > > > bpf_arch_text_invalidate() and bpf_arch_text_copy() is not related to
> > > > BPF trampoline, right ?
> >
> > From the perspective of BPF core source code calls, the two functions
> > bpf_arch_text_invalidate() and bpf_arch_text_copy() are not only used for
> > trampolines.
> >
> > > >
> > > > > 2.25.1
> > > > >
> >

