Return-Path: <bpf+bounces-62888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F49AFFAC2
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 09:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F40B7AC3F7
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 07:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A388288CBA;
	Thu, 10 Jul 2025 07:23:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D629C288C19;
	Thu, 10 Jul 2025 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132236; cv=none; b=XecWTdlk/f0siECePnqExsnD6kg9FZvv6lwNQiVATnFIi1IBFIPdLRtfDJX/wFK7fWobnb1Od9+dOBGF7MDK6J1rMrVD889dn+IbsnlslI737mVSQzR6DJcTKg95Ht/UbaYtrF3h+1zleYWBX6zdWqrwceKrDnC9D9ZAeOqf5OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132236; c=relaxed/simple;
	bh=3vkiv57mP9xfFhVaGyv56KfVZIbDJpCAnb1c0mx3LKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEBbrZCz+2ThyMBdQpd5u7NMtAIK9F+x4YjyfENFYx46WD3p7GaAKP8hjZz8epQHFBmU+k+oDe678XACUpbxOmxLPeB0N2dchDcXaX1vQYToObCrgNz5cfbIyYMvbIMe8p7LxQjAkhOcWmCutmSX0L/gkvxoGCMtHCoCixlEBas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d01e447e5d5e11f0b29709d653e92f7d-20250710
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:42077a11-c60b-4522-a5ba-6b2e9012c48c,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:42077a11-c60b-4522-a5ba-6b2e9012c48c,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:85fad4899d1e4b836f56ae973c67bf77,BulkI
	D:250709232349WQEXQ1X6,BulkQuantity:2,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: d01e447e5d5e11f0b29709d653e92f7d-20250710
X-User: duanchenghao@kylinos.cn
Received: from localhost [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 241051403; Thu, 10 Jul 2025 15:23:44 +0800
Date: Thu, 10 Jul 2025 15:23:37 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yangtiezhu@loongson.cn, hengqi.chen@gmail.com, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	bpf@vger.kernel.org, guodongtai@kylinos.cn, youling.tang@linux.dev,
	jianghaoran@kylinos.cn
Subject: Re: [PATCH v3 3/5] LoongArch: BPF: Add EXECMEM_BPF memory to execmem
 subsystem
Message-ID: <20250710072337.GA839477@chenghao-pc>
References: <20250709055029.723243-1-duanchenghao@kylinos.cn>
 <20250709055029.723243-4-duanchenghao@kylinos.cn>
 <CAAhV-H6bKrnDpVouriAoMUN5i26G6a+UuOGMyEj5h9kJGd6qnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6bKrnDpVouriAoMUN5i26G6a+UuOGMyEj5h9kJGd6qnQ@mail.gmail.com>

On Wed, Jul 09, 2025 at 11:23:12PM +0800, Huacai Chen wrote:
> Hi, Chenghao,
> 
> On Wed, Jul 9, 2025 at 1:50 PM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> >
> > The bpf_jit_alloc_exec function serves as the core mechanism for BPF
> > memory allocation, invoking execmem_alloc(EXECMEM_BPF, size) to
> > allocate memory. This change explicitly designates the allocation space
> > for EXECMEM_BPF.
> Without this patch, BPF JIT is allocated from MODULES region; with
> this patch, BPF JIT will be allocated from VMALLOC region. However,
> BPF JIT is similar to modules that the target of direct branch
> instruction is limited, so it should also be allocated from the
> MODULES region.
> 
> So, it is better to drop this patch.
> 
> 
> Huacai

Dear Chen,

I understand your technical considerations. Whether to keep or remove
the current patch has no impact on trampoline, so we can drop this
patch.

Chenghao

> 
> >
> > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > ---
> >  arch/loongarch/mm/init.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> > index c3e4586a7..07cedd9ee 100644
> > --- a/arch/loongarch/mm/init.c
> > +++ b/arch/loongarch/mm/init.c
> > @@ -239,6 +239,12 @@ struct execmem_info __init *execmem_arch_setup(void)
> >                                 .pgprot = PAGE_KERNEL,
> >                                 .alignment = 1,
> >                         },
> > +                       [EXECMEM_BPF] = {
> > +                               .start  = VMALLOC_START,
> > +                               .end    = VMALLOC_END,
> > +                               .pgprot = PAGE_KERNEL,
> > +                               .alignment = PAGE_SIZE,
> > +                       },
> >                 },
> >         };
> >
> > --
> > 2.43.0
> >
> >

