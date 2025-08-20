Return-Path: <bpf+bounces-66069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8109B2D855
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 11:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209565C35DD
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCF52D9EDF;
	Wed, 20 Aug 2025 09:26:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF31220322;
	Wed, 20 Aug 2025 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682005; cv=none; b=Y3y8ptUcdMj1rlrK7nAJ0SANrpfiCukWq+LOdE58NSFCOdnCIxgikNP9m8EhI/tLvUaVEhVUPRrtMI2xajHYlJna33pEKcofTvGNH9uhhnTGc2hF+L4YzBH6KlFyUUc68SG7vwGXnr4fDTa1wWasIRLMsy7kiT2usUmP2r+qvP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682005; c=relaxed/simple;
	bh=2uU5ZrZ3dDyK5rPaTauckpsLKjSNLSaN7NEv0euQgVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyYWJm+RKtomDa9EU/qiKBu5RinqiTQJGQeG196/gAkMCKGsY+e5kg4GuOxn5Nff4JML6LzYt/InKHVBnDwAyYQ3A0Ieymvu6yiZ5U+otvAyApE1NmbVaiqh4Bi3AtpFhRd8Ri3X9CI0+tfoiYW15CV/30QVj5Ejko6SpJ10LPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c4a19ca47da711f0b29709d653e92f7d-20250820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:fd378d40-514e-4215-996f-0aeebd413e45,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:fd378d40-514e-4215-996f-0aeebd413e45,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:336d5cb5b5924752fdd99b4725ca7b31,BulkI
	D:250820145207GW1MRF9C,BulkQuantity:3,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: c4a19ca47da711f0b29709d653e92f7d-20250820
X-User: duanchenghao@kylinos.cn
Received: from localhost [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 382454535; Wed, 20 Aug 2025 17:26:36 +0800
Date: Wed, 20 Aug 2025 17:26:28 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Pu Lehui <pulehui@huawei.com>
Cc: ast@kernel.org, bjorn@kernel.org, puranjay@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, alex@ghiti.fr,
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: bpf: Fix uninitialized symbol 'retval_off'
Message-ID: <20250820092628.GA1289807@chenghao-pc>
References: <20250820062520.846720-1-duanchenghao@kylinos.cn>
 <8b836b6e-103a-41c2-b111-0417d8db4dce@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b836b6e-103a-41c2-b111-0417d8db4dce@huawei.com>

On Wed, Aug 20, 2025 at 02:52:01PM +0800, Pu Lehui wrote:
> 
> 
> On 2025/8/20 14:25, Chenghao Duan wrote:
> > In __arch_prepare_bpf_trampoline(), retval_off is only meaningful when
> > save_ret is true, so the current logic is correct. However, in the
> 
> lgtm, and same for `ip_off`, pls patch it together.

I also checked at the time that ip_off is only initialized and assigned
when flags & BPF_TRAMP_F_IP_ARG is true. However, I noticed that the use
of ip_off also requires this condition, so the compiler did not issue a
warning.

Chenghao

> 
> > original logic, retval_off is only initialized under certain
> > conditions, which may cause a build warning.
> > 
> > So initialize retval_off unconditionally to fix it.
> > 
> > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > ---
> >   arch/riscv/net/bpf_jit_comp64.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> > index 10e01ff06312..49bbda8372b0 100644
> > --- a/arch/riscv/net/bpf_jit_comp64.c
> > +++ b/arch/riscv/net/bpf_jit_comp64.c
> > @@ -1079,10 +1079,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
> >   	stack_size += 16;
> >   	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
> > -	if (save_ret) {
> > +	if (save_ret)
> >   		stack_size += 16; /* Save both A5 (BPF R0) and A0 */
> > -		retval_off = stack_size;
> > -	}
> > +	retval_off = stack_size;
> >   	stack_size += nr_arg_slots * 8;
> >   	args_off = stack_size;

