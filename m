Return-Path: <bpf+bounces-63588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54531B089A8
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 11:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99EC358106C
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2D9267B19;
	Thu, 17 Jul 2025 09:47:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED4E1D7E42;
	Thu, 17 Jul 2025 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745619; cv=none; b=D4SqAZ07rD4gwevCqSK0RntlxfB3zGmSaxl5vJBUvTZF2AFlphOLwV55qL/s9vT5i85fw97pJAquFwDtY6zVipxs9aqYhZbjp/9WTqeSxKFDs4UdnCTTpsBrNpzzR+tuOsVTDVRoK9+w4pnnGk8z2C4JS89H4KSvg4Jt68q5ErA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745619; c=relaxed/simple;
	bh=2W3mjajt3UpuuZjO3Y9cpSPwMyLuGz4Shz2+P/xKfcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO0XXbgnrdvH+rT5EjTk/beuB/gIaTdrq3mSk9/4phgNxLAqBlkbpEkdU4oRiid33snbDhwmtZWEWk/BYzUmut9Ruxbm2hnyhl5i92i078lrhVSQt3fGckX0M1d5kBezmv2Zc0k+Cq5nowdlteYJQ1dkF6Iz+nIFp6i04yMsW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f78941a062f211f0b29709d653e92f7d-20250717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c2429e14-6776-4f1a-bd22-dedff88d8aba,IP:0,U
	RL:0,TC:0,Content:8,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:8
X-CID-META: VersionHash:6493067,CLOUDID:90797c94ccdd88f3ad99e6c6f7e681b6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f78941a062f211f0b29709d653e92f7d-20250717
X-User: duanchenghao@kylinos.cn
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1087187952; Thu, 17 Jul 2025 17:46:52 +0800
Date: Thu, 17 Jul 2025 17:46:48 +0800
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
Subject: Re: [PATCH v3 2/5] LoongArch: BPF: Update the code to rename
 validate_code to validate_ctx.
Message-ID: <20250717094648.GC993901@chenghao-pc>
References: <20250709055029.723243-1-duanchenghao@kylinos.cn>
 <20250709055029.723243-3-duanchenghao@kylinos.cn>
 <CAEyhmHSs5Ev5LBp8KWDnK93NcJnfvVZPy=X80Miy9PnP4rMA=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEyhmHSs5Ev5LBp8KWDnK93NcJnfvVZPy=X80Miy9PnP4rMA=A@mail.gmail.com>

On Wed, Jul 16, 2025 at 07:55:46PM +0800, Hengqi Chen wrote:
> On Wed, Jul 9, 2025 at 1:50 PM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> >
> > Update the code to rename validate_code to validate_ctx.
> > validate_code is used to check the validity of code.
> > validate_ctx is used to check both code validity and table entry
> > correctness.
> >
> 
> The commit message is awkward to read.
> Please describe the purpose of this change.
> * Rename the existing validate_code() to validate_ctx()
> * Factor out the code validation handling into a new helper validate_code()
> 
> The new validate_code() will be used in subsequent changes.
> 

Hi Hengqi,

Thank you very much for your suggestions. I will refer to your advice
to revise the commit message in Version V4.

Chenghao

> > Co-developed-by: George Guo <guodongtai@kylinos.cn>
> > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > ---
> >  arch/loongarch/net/bpf_jit.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> > index fa1500d4a..7032f11d3 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -1180,6 +1180,14 @@ static int validate_code(struct jit_ctx *ctx)
> >                         return -1;
> >         }
> >
> > +       return 0;
> > +}
> > +
> > +static int validate_ctx(struct jit_ctx *ctx)
> > +{
> > +       if (validate_code(ctx))
> > +               return -1;
> > +
> >         if (WARN_ON_ONCE(ctx->num_exentries != ctx->prog->aux->num_exentries))
> >                 return -1;
> >
> > @@ -1288,7 +1296,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> >         build_epilogue(&ctx);
> >
> >         /* 3. Extra pass to validate JITed code */
> > -       if (validate_code(&ctx)) {
> > +       if (validate_ctx(&ctx)) {
> >                 bpf_jit_binary_free(header);
> >                 prog = orig_prog;
> >                 goto out_offset;
> > --
> > 2.43.0
> >

