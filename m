Return-Path: <bpf+bounces-61639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC36AE94BD
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 05:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE5007AE830
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 03:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B58B2080C4;
	Thu, 26 Jun 2025 03:54:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC51A0728;
	Thu, 26 Jun 2025 03:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750910077; cv=none; b=DSxZzROvhg/NNx9Xt0VQqsJBzgUYJoQpZ34DIP7UHZfcQgC7oIPirUYv762HV3BtHvoWfVDEs/CUbHyj+PukuyPeJa78XyxQKFkssSkwpJ4v+FJLEfjIcUy1rh+j0m8q9J7LxrKFSdD/QSiI0Tu2aaLDlSan5JRWZa9CU/hOwys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750910077; c=relaxed/simple;
	bh=W69Sh8U89J7pQtIt0QufN1Tq/U+T0/SmKCjwqwczS5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRBSSb4UONoQrT8iw7hvtOp22vi9dWEk3uAg8xQmaBKsMa8233UpY3c0FEMbrEvvM9Z4RPInKLtdkd6jcllsjm94NjJklc51BQiNLUCHV5BUULOT0s9OXFAM0CSRtC+peRfWITOoXuyCPhFrUNu3pZkcVJ5gCJwuzikVAhYooBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 41cb6cd8524111f0b29709d653e92f7d-20250626
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c2cb00be-2c47-4fa5-bfe6-0d7233a87b8a,IP:0,U
	RL:0,TC:0,Content:6,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:1
X-CID-INFO: VERSION:1.1.45,REQID:c2cb00be-2c47-4fa5-bfe6-0d7233a87b8a,IP:0,URL
	:0,TC:0,Content:6,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:1
X-CID-META: VersionHash:6493067,CLOUDID:1dff51c8eff28d8923e87fb0fe31e4c9,BulkI
	D:250626093924HZVC9G85,BulkQuantity:2,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|841,TC:nil,Content:4|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:4
	0,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 41cb6cd8524111f0b29709d653e92f7d-20250626
X-User: duanchenghao@kylinos.cn
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1415082984; Thu, 26 Jun 2025 11:54:27 +0800
Date: Thu, 26 Jun 2025 11:54:24 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yangtiezhu@loongson.cn, chenhuacai@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	bpf@vger.kernel.org, guodongtai@kylinos.cn, youling.tang@linux.dev,
	jianghaoran@kylinos.cn, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH v2 1/4] LoongArch: BPF: The operation commands needed to
 add a trampoline
Message-ID: <20250626035424.GA436557@chenghao-pc>
References: <20250618105048.1510560-1-duanchenghao@kylinos.cn>
 <20250618105048.1510560-2-duanchenghao@kylinos.cn>
 <CAEyhmHTA+6RdD4CbQuMn2E887Z3E6RudJQb3Wnmqosj1ozrXPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEyhmHTA+6RdD4CbQuMn2E887Z3E6RudJQb3Wnmqosj1ozrXPw@mail.gmail.com>

On Thu, Jun 26, 2025 at 09:39:04AM +0800, Hengqi Chen wrote:
> On Wed, Jun 18, 2025 at 6:51 PM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> >
> > Add branch jump function:
> > larch_insn_gen_beq
> > larch_insn_gen_bne
> >
> > Add instruction copy function: larch_insn_text_copy
> >
> 
> Please rewrite the commit message properly.
> These functions are generic, so you can drop the `BPF` prefix from subject line.
> 
Okay, I will make the changes in the next version.

> > Co-developed-by: George Guo <guodongtai@kylinos.cn>
> > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > Co-developed-by: Youling Tang <tangyouling@kylinos.cn>
> > Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > ---
> >  arch/loongarch/include/asm/inst.h |  3 ++
> >  arch/loongarch/kernel/inst.c      | 57 +++++++++++++++++++++++++++++++
> >  2 files changed, 60 insertions(+)
> >
> > diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> > index 3089785ca..88bb73e46 100644
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
> > @@ -511,6 +512,8 @@ u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm);
> >  u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
> >  u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
> >  u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
> > +u32 larch_insn_gen_beq(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
> > +u32 larch_insn_gen_bne(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
> >
> >  static inline bool signed_imm_check(long val, unsigned int bit)
> >  {
> > diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> > index 14d7d700b..7423b0772 100644
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
> > @@ -218,6 +219,34 @@ int larch_insn_patch_text(void *addr, u32 insn)
> >         return ret;
> >  }
> >
> > +int larch_insn_text_copy(void *dst, void *src, size_t len)
> > +{
> > +       unsigned long flags;
> 
> Initialize flags ?

To be precise, it saves the IRQ (Interrupt Request) status. My
understanding is that it involves passing parameters between the lock
and unlock operations.

> 
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
> 
> I am not familiar with this mm thing, but looking at other callsites
> of copy_to_kernel_nofault(),
> it seems like you can do this copy cross page boundaries.
> 

I didn't understand your point. May I ask if there's any issue with
using it this way?

> > +               if (ret) {
> > +                       pr_err("%s: operation failed\n", __func__);
> > +                       break;
> > +               }
> > +               wlen += size;
> > +       }
> > +       raw_spin_unlock_irqrestore(&patch_lock, flags);
> > +       set_memory_rox((unsigned long)dst, round_up(len, PAGE_SIZE) / PAGE_SIZE);
> > +
> 
> Do we need flush_icache_range() here ?
> 

I understand it is necessary. After all, the trampoline code needs to
be fetched by the PC (Program Counter) for instruction fetching, and
flushing the I-cache (Instruction Cache) is required for the code to
go through the I-cache.

> > +       return ret;
> > +}
> > +
> >  u32 larch_insn_gen_nop(void)
> >  {
> >         return INSN_NOP;
> > @@ -336,3 +365,31 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
> >
> >         return insn.word;
> >  }
> > +
> > +u32 larch_insn_gen_beq(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
> > +{
> > +       union loongarch_instruction insn;
> > +
> > +       if ((imm & 3) || imm < -SZ_128K || imm >= SZ_128K) {
> > +               pr_warn("The generated beq instruction is out of range.\n");
> > +               return INSN_BREAK;
> > +       }
> > +
> > +       emit_beq(&insn, rd, rj, imm >> 2);
> > +
> 
> This does NOT match emit_beq's signature, should be:
>     emit_beq(&insn, rj, rd, imm >> 2);

Okay, I will make the changes and conduct testing in the next version.

> 
> > +       return insn.word;
> > +}
> > +
> > +u32 larch_insn_gen_bne(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
> > +{
> > +       union loongarch_instruction insn;
> > +
> > +       if ((imm & 3) || imm < -SZ_128K || imm >= SZ_128K) {
> > +               pr_warn("The generated bne instruction is out of range.\n");
> > +               return INSN_BREAK;
> > +       }
> > +
> > +       emit_bne(&insn, rj, rd, imm >> 2);
> > +
> > +       return insn.word;
> > +}
> > --
> > 2.43.0
> >

