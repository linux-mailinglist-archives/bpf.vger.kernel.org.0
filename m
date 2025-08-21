Return-Path: <bpf+bounces-66148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB7BB2EB7E
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 04:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0C05C89C7
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 02:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FD72D3ECF;
	Thu, 21 Aug 2025 02:55:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EB41C4A10;
	Thu, 21 Aug 2025 02:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744949; cv=none; b=H/VY/E5zen8jQL2GGikQk8B8Qrr7yj/Ps7Yf895V9z+nuEtUYJMthyZ7y/be6cD1sM8ENbPUV262cWmpLwzPslg9lIy917c4ZY6JV/DXae42MFlpOqVIAQpPX2gfqvUfS9cBy8lcnaviTTo+Doto73y8Sfrs1+inzrDFC9m8c1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744949; c=relaxed/simple;
	bh=QvMUeM4pDlP632rKfYRBprYpHIkWELPeq80btpP7l6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfQH9L6qa/uCcD6yZT/lRumfmiPwL/X4++d5HBXNGVc3cDSLIhj4onkY4SEH6eBMsT736EOTaMJwWo9K3LiNlsYtu44stiHmvFOiOBG6YFa72qIX9W9zxYeN72ksPcfVEgU9RZLTBvzoyfqhggEVcbIY2rOqCI6zet7v/jZt+tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4fcfd56a7e3a11f0b29709d653e92f7d-20250821
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:31331416-7b38-4d16-a261-b0cb1ce5c005,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:33274ee4927d2cea1b83a9d1f9bfd892,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4fcfd56a7e3a11f0b29709d653e92f7d-20250821
X-User: duanchenghao@kylinos.cn
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 519076177; Thu, 21 Aug 2025 10:55:36 +0800
Date: Thu, 21 Aug 2025 10:55:32 +0800
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
Message-ID: <20250821025532.GA287128@chenghao-pc>
References: <20250820062520.846720-1-duanchenghao@kylinos.cn>
 <8b836b6e-103a-41c2-b111-0417d8db4dce@huawei.com>
 <20250820092628.GA1289807@chenghao-pc>
 <239193b7-7dab-45b0-ab13-06bfe3f96f22@huawei.com>
 <20250820103530.GA1475460@chenghao-pc>
 <9cbdefd6-a757-44b3-a1db-69ca8117aacb@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9cbdefd6-a757-44b3-a1db-69ca8117aacb@huawei.com>

On Thu, Aug 21, 2025 at 09:58:20AM +0800, Pu Lehui wrote:
> 
> 
> On 2025/8/20 18:35, Chenghao Duan wrote:
> > On Wed, Aug 20, 2025 at 06:10:07PM +0800, Pu Lehui wrote:
> > > 
> > > 
> > > On 2025/8/20 17:26, Chenghao Duan wrote:
> > > > On Wed, Aug 20, 2025 at 02:52:01PM +0800, Pu Lehui wrote:
> > > > > 
> > > > > 
> > > > > On 2025/8/20 14:25, Chenghao Duan wrote:
> > > > > > In __arch_prepare_bpf_trampoline(), retval_off is only meaningful when
> > > > > > save_ret is true, so the current logic is correct. However, in the
> 
> OK, I think we should make commit msg more explicit. Such like the follow.
> wdyt?
> 
> `However, in the fmod_ret logic, the compiler is not aware that the flags of
> the fmod_ret prog have set BPF_TRAMP_F_CALL_ORIG, resulting in an
> uninitialized symbol compilation warning.`
> 

Good idea

> > > > > 
> > > > > lgtm, and same for `ip_off`, pls patch it together.
> > > > 
> > > > I also checked at the time that ip_off is only initialized and assigned
> > > > when flags & BPF_TRAMP_F_IP_ARG is true. However, I noticed that the use
> > > > of ip_off also requires this condition, so the compiler did not issue a
> > > > warning.
> > > > 
> > > > Chenghao
> > > > 
> > > > > 
> > > > > > original logic, retval_off is only initialized under certain
> > > 
> > > Can you show how to replay this warning? I guess the warning path is as
> > > follow. Compiler didn't know fmod_ret prog need BPF_TRAMP_F_CALL_ORIG.
> > > 
> > > ```
> > > if (fmod_ret->nr_links) {
> > > 	...
> > > 	emit_sd(RV_REG_FP, -retval_off, RV_REG_ZERO, ctx);
> > > }
> > > ```
> > > 
> > 
> > Exactly, the compiler sees the unconditional use of retval_off.
> > 
> > Chenghao
> > 
> > > > > > conditions, which may cause a build warning.
> > > > > > 
> > > > > > So initialize retval_off unconditionally to fix it.
> > > > > > 
> > > > > > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > > > > > ---
> > > > > >     arch/riscv/net/bpf_jit_comp64.c | 5 ++---
> > > > > >     1 file changed, 2 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> > > > > > index 10e01ff06312..49bbda8372b0 100644
> > > > > > --- a/arch/riscv/net/bpf_jit_comp64.c
> > > > > > +++ b/arch/riscv/net/bpf_jit_comp64.c
> > > > > > @@ -1079,10 +1079,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
> > > > > >     	stack_size += 16;
> > > > > >     	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
> > > > > > -	if (save_ret) {
> > > > > > +	if (save_ret)
> > > > > >     		stack_size += 16; /* Save both A5 (BPF R0) and A0 */
> > > > > > -		retval_off = stack_size;
> > > > > > -	}
> > > > > > +	retval_off = stack_size;
> > > > > >     	stack_size += nr_arg_slots * 8;
> > > > > >     	args_off = stack_size;

