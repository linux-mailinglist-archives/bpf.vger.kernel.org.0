Return-Path: <bpf+bounces-76953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA103CC9FAE
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 02:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7997301D32F
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 01:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A252566D3;
	Thu, 18 Dec 2025 01:27:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DC3242925;
	Thu, 18 Dec 2025 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766021249; cv=none; b=UbaedbQVGNDG5oO37s8Y3IzRZnmMe0iOZLgd63RaSXyQTNiW/aycjgPRNCu8apK6+5xxrCBdZ3xVPxK9Ew3LBvYKokr0hdvp+ZCdMZl5PeaP5KUeq/5FA0PJqR1japrbcKkgCv/su4kNRjda21MZAKeSvBelcV2tOxFGMRQgD98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766021249; c=relaxed/simple;
	bh=U5LXjrO7KGM2ptZOPxaLP/Gu/0RCs4prZyeCjReoqVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hpwe+XQTIlJntWJyd6i++41UAt8OEljVCveK552Y9eN/7ZsLOQiQjGd8HxNk3NQnozP/Cw47R7vMUPPwkjnpseZWFoZF9KajaXbKh1X7ZToInEWPmjFTNd/03rwzoKjD+G7GYntDCguD1CsEu5wutieU93LFKFstbB6xFpFncv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a70cac44dbb011f0a38c85956e01ac42-20251218
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_MISS, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:b51ade3f-e58b-49b9-939b-9355ac6ebb6d,IP:20,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.6,REQID:b51ade3f-e58b-49b9-939b-9355ac6ebb6d,IP:20,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:a9d874c,CLOUDID:2590479f08db1a65a2554039a2c7bd8b,BulkI
	D:251217145516TLVAJ57F,BulkQuantity:2,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:
	nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:
	0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a70cac44dbb011f0a38c85956e01ac42-20251218
X-User: duanchenghao@kylinos.cn
Received: from localhost [(183.242.174.20)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 996175428; Thu, 18 Dec 2025 09:27:01 +0800
Date: Thu, 18 Dec 2025 09:26:56 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: bot+bpf-ci@kernel.org
Cc: yangtiezhu@loongson.cn, rostedt@goodmis.org, mhiramat@kernel.org,
	mark.rutland@arm.com, hengqi.chen@gmail.com, chenhuacai@kernel.org,
	kernel@xen0n.name, zhangtianyang@loongson.cn, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	bpf@vger.kernel.org, youling.tang@linux.dev, jianghaoran@kylinos.cn,
	vincent.mc.li@gmail.com, linux-trace-kernel@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v4 1/7] LoongArch: ftrace: Refactor register restoration
 in ftrace_common_return
Message-ID: <20251218012656.GA75051@chenghao-pc>
References: <20251217061435.802204-2-duanchenghao@kylinos.cn>
 <5c7c7239a6f89e685f69093ff84fe686c75cf6b9b051dcbf812841f00ab3bc31@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c7c7239a6f89e685f69093ff84fe686c75cf6b9b051dcbf812841f00ab3bc31@mail.kernel.org>

On Wed, Dec 17, 2025 at 06:55:00AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
> > index d6b474ad1d5e..5729c20e5b8b 100644
> > --- a/arch/loongarch/kernel/mcount_dyn.S
> > +++ b/arch/loongarch/kernel/mcount_dyn.S
> > @@ -94,7 +94,6 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
> >   * at the callsite, so there is no need to restore the T series regs.
> >   */
> >  ftrace_common_return:
> > -	PTR_L		ra, sp, PT_R1
> >  	PTR_L		a0, sp, PT_R4
> >  	PTR_L		a1, sp, PT_R5
> >  	PTR_L		a2, sp, PT_R6
> > @@ -104,12 +103,17 @@ ftrace_common_return:
> >  	PTR_L		a6, sp, PT_R10
> >  	PTR_L		a7, sp, PT_R11
> >  	PTR_L		fp, sp, PT_R22
> > -	PTR_L		t0, sp, PT_ERA
> >  	PTR_L		t1, sp, PT_R13
> > -	PTR_ADDI	sp, sp, PT_SIZE
> >  	bnez		t1, .Ldirect
> > +
> > +	PTR_L		ra, sp, PT_R1
> > +	PTR_L		t0, sp, PT_ERA
> > +	PTR_ADDI	sp, sp, PT_SIZE
> >  	jr		t0
> >  .Ldirect:
> > +	PTR_L		t0, sp, PT_R1
> > +	PTR_L		ra, sp, PT_ERA
>                      ^^^^^^^^^^^^^^^^^^^
> Does this break existing ftrace direct trampolines?
> 
> Before this change, direct trampolines received:
>   ra = parent return address (from PT_R1)
>   t0 = traced function address (from PT_ERA)
> 
> After this change, direct trampolines receive:
>   t0 = parent return address (from PT_R1)
>   ra = traced function address (from PT_ERA)
> 
> The sample trampolines in samples/ftrace/ were written for the old
> convention. For example, samples/ftrace/ftrace-direct.c does:
> 
>   my_tramp:
>     st.d  $t0, $sp, 8    # Save what it thinks is traced func addr
>     st.d  $ra, $sp, 16   # Save what it thinks is parent addr
>     bl    my_direct_func
>     ld.d  $t0, $sp, 8    # Restore
>     ld.d  $ra, $sp, 16   # Restore
>     jr    $t0            # Jump to what it thinks is traced function
> 
> With the new convention, the sample would save parent address in the
> t0 slot, restore it to t0, and then jump to the parent instead of the
> traced function, skipping the traced function entirely.
> 
> This was fixed later in commit 055e392f3be7 "LoongArch: ftrace: Adjust
> register stack restore order in direct call trampolines" which updated
> all the samples to match the new convention. However, any out-of-tree
> direct trampolines written before this commit would be broken by this
> change.
> 
> Was this ABI break intentional? The commit message mentions matching
> "the state when ftrace was entered" but doesn't explain why breaking
> compatibility was necessary. RISC-V uses the opposite convention
> (t0 = traced func, ra = parent), which the original LoongArch code
> matched.

The patch "LoongArch: ftrace: Refactor register restoration in
ftrace_common_return" changed the conventions for t0 and ra after
entering the direct call function, which is exactly the reason forthe
changes made in this patch.

Chenghao

> 
> > +	PTR_ADDI	sp, sp, PT_SIZE
> >  	jr		t1
> >  SYM_CODE_END(ftrace_common)
> 
> [ ... ]
> 
> > @@ -161,6 +165,8 @@ SYM_CODE_END(return_to_handler)
> >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >  SYM_CODE_START(ftrace_stub_direct_tramp)
> >  	UNWIND_HINT_UNDEFINED
> > -	jr		t0
> > +	move		t1, ra
> > +	move		ra, t0
> > +	jr		t1
> >  SYM_CODE_END(ftrace_stub_direct_tramp)
> >  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20293821855


