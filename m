Return-Path: <bpf+bounces-76564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9B7CBC3E1
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 03:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60D113007698
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 02:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6275F26F44D;
	Mon, 15 Dec 2025 02:18:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9F92A1BF;
	Mon, 15 Dec 2025 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765765121; cv=none; b=uAhsmDLNCeCcdUe5PdTAfduWcfE8qODcvuA5pKVlfFshI+9HECjsUk5fi86KICCS4Kx7QLP0v9vT1TZZYRanJAd5KK9v74ikTxOcyY/vMMcWM9xSIqel3im+g1owdkhEpJOHByEPlMxEM7+dhqk9XyN+x0eZ1PkCx3hq1EbIb9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765765121; c=relaxed/simple;
	bh=MjNWDa1Utb2FSU2vHMGxAZAMxCY2K1N3AimOMWo1kBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSyPaE195VpwuqvpRSyoqlUGxiwKy4RUHIjrVLgRkdkQvUA2p6IW7jvmeOclvl5KNIcUemCJGhdw41xGeBWFAav1PJxzM9n7kY2iC/dqhqWduBzdGo4eRa4ilm8LiqL60qPOPBrTorGmTCS31MX8hM9IWe5tZBQB3pk+OShAhUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 55ef38bed95c11f0a38c85956e01ac42-20251215
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:4d2852ea-23b5-4c94-b72f-79f995771ed7,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:4d2852ea-23b5-4c94-b72f-79f995771ed7,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:308dbeb326b784dc295e1266a7f8be21,BulkI
	D:251213211600WWYCZSF1,BulkQuantity:2,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 55ef38bed95c11f0a38c85956e01ac42-20251215
X-User: duanchenghao@kylinos.cn
Received: from localhost [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 853044840; Mon, 15 Dec 2025 10:18:25 +0800
Date: Mon, 15 Dec 2025 10:18:22 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: yangtiezhu@loongson.cn, hengqi.chen@gmail.com, kernel@xen0n.name,
	zhangtianyang@loongson.cn, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	bpf@vger.kernel.org, youling.tang@linux.dev, jianghaoran@kylinos.cn,
	vincent.mc.li@gmail.com
Subject: Re: [PATCH v2 4/4] LoongArch: BPF: Enable BPF exception fixup for
 specific ADE subcode
Message-ID: <20251215021822.GA141785@chenghao-pc>
References: <20251212091103.1247753-1-duanchenghao@kylinos.cn>
 <20251212091103.1247753-5-duanchenghao@kylinos.cn>
 <CAAhV-H5-AaD9SuRWt5gK4ODVA356EO7byqf-AnXvr_0C+FuUPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5-AaD9SuRWt5gK4ODVA356EO7byqf-AnXvr_0C+FuUPg@mail.gmail.com>

On Sat, Dec 13, 2025 at 09:16:00PM +0800, Huacai Chen wrote:
> Hi, Chenghao,
> 
> On Fri, Dec 12, 2025 at 5:11 PM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> >
> > This patch allows the LoongArch BPF JIT to handle recoverable memory
> > access errors generated by BPF_PROBE_MEM* instructions.
> >
> > When a BPF program performs memory access operations, the instructions
> > it executes may trigger ADEM exceptions. The kernel’s built-in BPF
> > exception table mechanism (EX_TYPE_BPF) will generate corresponding
> > exception fixup entries in the JIT compilation phase; however, the
> > architecture-specific trap handling function needs to proactively call
> > the common fixup routine to achieve exception recovery.
> >
> > do_ade(): fix EX_TYPE_BPF memory access exceptions for BPF programs,
> > ensure safe execution.
> >
> > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > ---
> >  arch/loongarch/kernel/traps.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> > index da5926fead4a..4cf72e0af6a3 100644
> > --- a/arch/loongarch/kernel/traps.c
> > +++ b/arch/loongarch/kernel/traps.c
> > @@ -534,7 +534,13 @@ asmlinkage void noinstr do_fpe(struct pt_regs *regs, unsigned long fcsr)
> >
> >  asmlinkage void noinstr do_ade(struct pt_regs *regs)
> >  {
> > -       irqentry_state_t state = irqentry_enter(regs);
> > +       irqentry_state_t state;
> > +       unsigned int esubcode = FIELD_GET(CSR_ESTAT_ESUBCODE, regs->csr_estat);
> > +
> > +       if ((esubcode == EXSUBCODE_ADEM) && fixup_exception(regs))
> > +               return;
> No chance for ADEF? And I don't think ixup_exception() can be done out
> of irqentry_enter().

At present, exception fixes are only applied to memory-type BPF programs,
with no handling implemented for ADEF.

In the next version, fixup_exception will be processed internally within
irqentry_enter()/irqentry_exit, and the title will be revised with
reference to your suggestions.

Chenghao

> 
> This patch is needed by BPF but not part of BPF, so I think the
> subject should be:
> LoongArch: Enable exception fixup for specific ADE subcode
> 
> Huacai
> 
> > +
> > +       state = irqentry_enter(regs);
> >
> >         die_if_kernel("Kernel ade access", regs);
> >         force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)regs->csr_badvaddr);
> > --
> > 2.25.1
> >

