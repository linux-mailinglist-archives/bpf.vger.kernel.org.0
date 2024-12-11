Return-Path: <bpf+bounces-46593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC21C9EC430
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 06:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B7728578A
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 05:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370D41C1AB1;
	Wed, 11 Dec 2024 05:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D8LakECd"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E81514F8;
	Wed, 11 Dec 2024 05:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733894255; cv=none; b=fwvhpZN8By7ophuyPLdkaJxXsnllnv5VAUrM7JWRB2h9tGt3Dom6GHJcK8pMrg1+aRMKxqfR+GT/JCVmKwjFaZ25yj+DcWFPZlQhc5kWxsoi8d6IFupIRNl6/Ml6TtKLNO9SHLDYvMAdhTYpS0amFPFsxuLli4XW7nEi0BN32Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733894255; c=relaxed/simple;
	bh=RPWCoG4RhG6ryjnD0ys4kpDDuDXeC7eMtJBFDhrGKLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVMp0odaEvkrtqfZdTABe84Mv0KQl/7RF0BwBC+OIWgzzm0hd66Py8Cp9JbV8z+OsacILVA2iY+VatycdIjx7D40j+yolrsP4C195Y1KaSOxiZHssFWmeFY8gTmMQhYVamPb3iBGoqI5Ayc6uSZTPDGboJdi439A+CS31wSM3Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D8LakECd; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733894248; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=nQcLfV2xZwKTL2O3SG540LsNxNtq3k+Lv38jppzlJyg=;
	b=D8LakECdV6PtHFpA4aH2HxB7yZRpxlFj5nHsy5nsCH4VFPiPgSBCb5IQq9lGQqoYk28AEKwslYMaETNTDqPCltk3syqkJM97KVGQAo9utHBOd5v327lEJ3Kftprb8p5Cx/7BM5AGHLIMZcmW+jZAKwGjphWfKyw/l/T9PLkYCro=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WLH6tub_1733894245 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 13:17:26 +0800
Date: Wed, 11 Dec 2024 13:17:25 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Yonghong Song <yhs@fb.com>, Eric Dumazet <edumazet@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	guwen@linux.alibaba.com, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Network Development <netdev@vger.kernel.org>,
	linux-s390 <linux-s390@vger.kernel.org>, linux-rdma@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 5/5] bpf/selftests: add simple selftest for
 bpf_smc_ops
Message-ID: <20241211051725.GA97570@j66a10360.sqa.eu95>
References: <20241210040404.10606-1-alibuda@linux.alibaba.com>
 <20241210040404.10606-6-alibuda@linux.alibaba.com>
 <CAADnVQJisbHFpS2==pw4aOAmKsbo6m6EDvOBntF_ATMrbp0G=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJisbHFpS2==pw4aOAmKsbo6m6EDvOBntF_ATMrbp0G=w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Dec 10, 2024 at 10:01:38AM -0800, Alexei Starovoitov wrote:
> On Mon, Dec 9, 2024 at 8:04 PM D. Wythe <alibuda@linux.alibaba.com> wrote:
> >
> > +SEC("struct_ops/bpf_smc_set_tcp_option_cond")
> > +int BPF_PROG(bpf_smc_set_tcp_option_cond, const struct tcp_sock *tp, struct inet_request_sock *ireq)
> > +{
> > +       return 0;
> > +}
> > +
> > +SEC("struct_ops/bpf_smc_set_tcp_option")
> > +int BPF_PROG(bpf_smc_set_tcp_option, struct tcp_sock *tp)
> > +{
> > +       return 1;
> > +}
> > +
> > +SEC(".struct_ops.link")
> > +struct smc_ops  sample_smc_ops = {
> > +       .name                   = "sample",
> > +       .set_option             = (void *) bpf_smc_set_tcp_option,
> > +       .set_option_cond        = (void *) bpf_smc_set_tcp_option_cond,
> > +};
> 
> These stubs don't inspire confidence that smc_ops api
> will be sufficient.
> Please implement a real bpf prog that demonstrates the actual use case.
> 
> See how bpf_cubic was done. On the day one it was implemented
> as a parity to builtin cubic cong control.
> And over years we didn't need to touch tcp_congestion_ops.
> To be fair that api was already solid due to in-kernel cc modules,
> but bpf comes with its own limitations, so it wasn't a guarantee
> that tcp_congestion_ops would be enough.
> Here you're proposing a brand new smc_ops api while bpf progs
> are nothing but stubs. That's not sufficient to prove that api
> is viable long term.

Hi Alexei,

Thanks a lot for your advices. I will add actual cases in the
next version to prove why we need it.

> 
> In terms of look and feel the smc_ops look ok.
> The change from v1 to v2 was a good step.

I'm glad that you feel it looks okay. If you have any questions,
please let me know.

Thanks,
D. Wythe

> 
> pw-bot: cr

