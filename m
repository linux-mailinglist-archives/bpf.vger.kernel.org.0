Return-Path: <bpf+bounces-76565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF11CBC41E
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 03:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E83E3011337
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 02:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D683258EDB;
	Mon, 15 Dec 2025 02:32:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ED2C8E6;
	Mon, 15 Dec 2025 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765765930; cv=none; b=cPDs0eiubPJEiLmJwD66xDZgQoN7ZupUNFGfWpMBB4EVCrDicqUogf/2+yyqLanJfdhrcE41TAl8pdkZHJr1NN33RraD+4uv0o57RZB/O+w7R2B9RnoveSqa5lqk7Ac+vKhpHTMx4OnSfxD2EnfzU/8UKjP9W/Wd1eK2op+xbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765765930; c=relaxed/simple;
	bh=6IbUxyt5nMMZsf/8FipGsa72EHayUi2Wi9lUBgwq3Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRVFkVprPXiUSmNNLMFxSuHKLg2XAf3bjFHKdL1QNvK47awjjrZlkmdtkirbQDB2SW1c4nxFeoDxL6j9/HfJVEqI96955uyeeeYa7WOnRXq+uMy2Aui0fYubS7sY6ysaNPTuMPVNYGU9C3dIQwr8sWTrtdrPCbnVsLiTRZMrXKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3e596420d95e11f0a38c85956e01ac42-20251215
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_MISS, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5ad9d0bb-d1ec-42a7-b8b7-219af699f5fc,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:5ad9d0bb-d1ec-42a7-b8b7-219af699f5fc,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:e2fa61a66ef449b6272add91f1745c64,BulkI
	D:251214203619ATES2BWC,BulkQuantity:2,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3e596420d95e11f0a38c85956e01ac42-20251215
X-User: duanchenghao@kylinos.cn
Received: from localhost [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1061847816; Mon, 15 Dec 2025 10:32:04 +0800
Date: Mon, 15 Dec 2025 10:32:00 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: hengqi.chen@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name,
	zhangtianyang@loongson.cn, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	bpf@vger.kernel.org, youling.tang@linux.dev, jianghaoran@kylinos.cn,
	vincent.mc.li@gmail.com
Subject: Re: [PATCH v2 3/4] LoongArch: BPF: Enhance trampoline support for
 kernel and module tracing
Message-ID: <20251215023200.GB141785@chenghao-pc>
References: <20251212091103.1247753-1-duanchenghao@kylinos.cn>
 <20251212091103.1247753-4-duanchenghao@kylinos.cn>
 <c6c385b0-60cf-b0c4-1962-974e783b131a@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6c385b0-60cf-b0c4-1962-974e783b131a@loongson.cn>

On Sun, Dec 14, 2025 at 08:36:16PM +0800, Tiezhu Yang wrote:
> On 12/12/25 17:11, Chenghao Duan wrote:
> > This patch addresses two main issues in the LoongArch BPF trampoline
> > implementation:
> > 
> > 1. BPF-to-BPF call handling:
> >   - Modify the build_prologue function to ensure that the value of the
> >   return address register ra is saved to t0 before entering the
> >   trampoline operation.
> >   - This ensures that the return address handling logic is accurate and
> >   error-free when a BPF program calls another BPF program.
> > 
> > 2. Enable Module Function Tracing Support:
> >   - Remove the previous restrictions that blocked the tracing of kernel
> >   module functions.
> >   - Fix the issue that previously caused kernel lockups when attempting
> >   to trace module functions
> > 
> > 3. Related Function Optimizations:
> >   - Adjust the jump offset of tail calls to ensure correct instruction
> >     alignment.
> >   - Enhance the bpf_arch_text_poke() function to enable accurate location
> >   of BPF program entry points.
> >   - Refine the trampoline return logic to ensure that the register data
> >   is correct when returning to both the traced function and the parent
> >   function.
> > 
> > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> 
> As described in the commit message, your changes include many kinds
> of contents, thanks for the fixes and optimizations.
> 
> In order to avoid introducing bugs in the middle, please separate each
> logical change into a separate patch, each patch should make an easily
> understood change that can be verified by reviewers, each patch should
> be justifiable on its own merits.
> 
> The current patch #4 can be put after the current patch #2 as a
> preparation for the bpf patches.
> 

Got it. I will incorporate your suggestions in the next version.

> Furthermore, it would be better to put the related test cases in the
> commit message of each patch rather than in the cover letter, so that
> it can be verified easily to know what this patch affected and can be
> recorded in the git log.

I fully agree with your suggestions. In fact, the current three patches
(excluding 0002-ftrace-samples-xxx.patch) are all fixes for the failed
test cases of module_attach. The test items included in the cover letter
of 0000-xxx.patch are intended to verify that the trampoline-related
test cases can pass after the current changes. I will follow your advice
and place the relevant test cases in the commit message of the
corresponding patches in the next version.

Chenghao

> 
> And also please add Fixes tag for each patch if possible.
> 
> Thanks,
> Tiezhu

