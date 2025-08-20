Return-Path: <bpf+bounces-66074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DB2B2DA28
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 12:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE41C1C46514
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 10:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AAD2E2DE5;
	Wed, 20 Aug 2025 10:36:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCDF24339D;
	Wed, 20 Aug 2025 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755686166; cv=none; b=bXpnh8S/jfWVemVarWt3jh9wO+zAjUHefs8LuvwbXNjswafAN75JdHgWZlG49dJyFK2Lr49WWp7j54IbP/qvLx0XaHjq9HFniCN8+T+uiBhPWEK/UyhPeHpaPoAKwMVKsm2DEp2u6fdLzhm9QbZUjKNFkpZ3ipT7ktGNM8j7u5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755686166; c=relaxed/simple;
	bh=0amSBsSg1VQI4NeDK2M2Sw52aVtcKurqUY+wUMLAKaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxdyQnhZm2AfZQMFV+Gk8maVF5aw4cUwV13cjAWdixhyaJAYpBVVI0HVzbI/zzYbeuJ9+tCceel7zNMG2T+d/bSY5g+wIJ6HxzBrf94UD4HtITc6kGzWgT7Fphb8fX1cLNknYqdOcDUvD0HGrtKp64OJtoczgHtYehB2ecdZy9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 744871e27db111f0b29709d653e92f7d-20250820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1cb5ba09-da8d-4e80-90ab-8a047c07187e,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:1cb5ba09-da8d-4e80-90ab-8a047c07187e,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:8bfd02a35658c3b6214171ca5bbacc6a,BulkI
	D:250820145207GW1MRF9C,BulkQuantity:7,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 744871e27db111f0b29709d653e92f7d-20250820
X-User: duanchenghao@kylinos.cn
Received: from localhost [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1900494786; Wed, 20 Aug 2025 18:35:56 +0800
Date: Wed, 20 Aug 2025 18:35:30 +0800
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
Message-ID: <20250820103530.GA1475460@chenghao-pc>
References: <20250820062520.846720-1-duanchenghao@kylinos.cn>
 <8b836b6e-103a-41c2-b111-0417d8db4dce@huawei.com>
 <20250820092628.GA1289807@chenghao-pc>
 <239193b7-7dab-45b0-ab13-06bfe3f96f22@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <239193b7-7dab-45b0-ab13-06bfe3f96f22@huawei.com>

On Wed, Aug 20, 2025 at 06:10:07PM +0800, Pu Lehui wrote:
> 
> 
> On 2025/8/20 17:26, Chenghao Duan wrote:
> > On Wed, Aug 20, 2025 at 02:52:01PM +0800, Pu Lehui wrote:
> > > 
> > > 
> > > On 2025/8/20 14:25, Chenghao Duan wrote:
> > > > In __arch_prepare_bpf_trampoline(), retval_off is only meaningful when
> > > > save_ret is true, so the current logic is correct. However, in the
> > > 
> > > lgtm, and same for `ip_off`, pls patch it together.
> > 
> > I also checked at the time that ip_off is only initialized and assigned
> > when flags & BPF_TRAMP_F_IP_ARG is true. However, I noticed that the use
> > of ip_off also requires this condition, so the compiler did not issue a
> > warning.
> > 
> > Chenghao
> > 
> > > 
> > > > original logic, retval_off is only initialized under certain
> 
> Can you show how to replay this warning? I guess the warning path is as
> follow. Compiler didn't know fmod_ret prog need BPF_TRAMP_F_CALL_ORIG.
> 
> ```
> if (fmod_ret->nr_links) {
> 	...
> 	emit_sd(RV_REG_FP, -retval_off, RV_REG_ZERO, ctx);
> }
> ```
> 

Exactly, the compiler sees the unconditional use of retval_off.

Chenghao

> > > > conditions, which may cause a build warning.
> > > > 
> > > > So initialize retval_off unconditionally to fix it.
> > > > 
> > > > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > > > ---
> > > >    arch/riscv/net/bpf_jit_comp64.c | 5 ++---
> > > >    1 file changed, 2 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> > > > index 10e01ff06312..49bbda8372b0 100644
> > > > --- a/arch/riscv/net/bpf_jit_comp64.c
> > > > +++ b/arch/riscv/net/bpf_jit_comp64.c
> > > > @@ -1079,10 +1079,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
> > > >    	stack_size += 16;
> > > >    	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
> > > > -	if (save_ret) {
> > > > +	if (save_ret)
> > > >    		stack_size += 16; /* Save both A5 (BPF R0) and A0 */
> > > > -		retval_off = stack_size;
> > > > -	}
> > > > +	retval_off = stack_size;
> > > >    	stack_size += nr_arg_slots * 8;
> > > >    	args_off = stack_size;

