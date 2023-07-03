Return-Path: <bpf+bounces-3918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BF374635B
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 21:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9454B1C20A67
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 19:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B9F11C80;
	Mon,  3 Jul 2023 19:33:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6B100C6;
	Mon,  3 Jul 2023 19:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5A6C433C7;
	Mon,  3 Jul 2023 19:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688412784;
	bh=5GiKGXz2Jjawc0vw5ewoGxNpn1aEI74Qx6QeMHdP0mY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EqiVzHAyn+iKQLe7BUBjNx5Zbc3h9gqQa35t6mLJnAgtPnlEVeaWjkbF6bChLVT8U
	 K5uKjKaiWKknlauWMtCcYmmy5Q1SSV+6AEg53Hq0IP0KofE7nUrM7dO6EG+RD0Lab1
	 eDw2YFjoMb5ZpUOJKPkpb46C0Mh5ypv0FXDzFC3JihjhtYIqjtSE98ABwY+/QC+OSm
	 X5j8gR7YnCywItsh5DJDPQEn6hMIbh7dVFwaW9ZmnCIR0VDCI1ospxUmXZ/G4sQ8mx
	 uhC1oNH4+FcOTrKToshmRbObVn/21PFwv9O1ioEH+ZI3+TnfcBsO1TbE3MCOWceEVa
	 PJh+oncs/mzAg==
Date: Mon, 3 Jul 2023 12:33:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
 Stanislav Fomichev <sdf@google.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Donald Hunter <donald.hunter@gmail.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Network Development
 <netdev@vger.kernel.org>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp
 metadata
Message-ID: <20230703123303.220ee6ef@kernel.org>
In-Reply-To: <64a313d41bd2c_5fc9a20839@john.notmuch>
References: <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
	<CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
	<CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
	<CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
	<CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
	<m2bkh69fcp.fsf@gmail.com>
	<649637e91a709_7bea820894@john.notmuch>
	<CAADnVQKUVDEg12jOc=5iKmfN-aHvFEtvFKVEDBFsmZizwkXT4w@mail.gmail.com>
	<20230624143834.26c5b5e8@kernel.org>
	<ZJeUlv/omsyXdO/R@google.com>
	<ZJoExxIaa97JGPqM@google.com>
	<CAADnVQKePtxk6Nn=M6in6TTKaDNnMZm-g+iYzQ=mPoOh8peoZQ@mail.gmail.com>
	<CAKH8qBv-jU6TUcWrze5VeiVhiJ-HUcpHX7rMJzN5o2tXFkS8kA@mail.gmail.com>
	<649b581ded8c1_75d8a208c@john.notmuch>
	<20230628115204.595dea8c@kernel.org>
	<87y1k2fq9m.fsf@toke.dk>
	<649f78b57358c_30943208c4@john.notmuch>
	<20230630201100.0bb9b1f3@kernel.org>
	<64a313d41bd2c_5fc9a20839@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 03 Jul 2023 11:30:44 -0700 John Fastabend wrote:
> Jakub Kicinski wrote:
> > On Fri, 30 Jun 2023 17:52:05 -0700 John Fastabend wrote:  
> > > I would expect BPF/driver experts would write the libraries for the
> > > datapath API that the network/switch developer is going to use. I would
> > > even put the BPF programs in kernel and ship them with the release
> > > if that helps.
> > > 
> > > We have different visions on who the BPF user is that writes XDP
> > > programs I think.  
> > 
> > Yes, crucially. What I've seen talking to engineers working on TC/XDP
> > BPF at Meta (and I may not be dealing with experts, Martin would have
> > a broader view) is that they don't understand basics like s/g or
> > details of checksums.  
> 
> Interesting data point. But these same engineers will want to get
> access to the checksum, but don't understand it? Seems if your
> going to start reading/writing descriptors even through kfuncs
> we need to get some docs/notes on how to use them correctly then.
> We certainly wont put guardrails on the read/writes for performance
> reasons.

Dunno about checksum, but it's definitely the same kind of person
that'd want access to timestamps.

> > I don't think it is reasonable to call you, Maxim, Nik and co. "users".
> > We're risking building system so complex normal people will _need_ an
> > overlay on top to make it work.  
> 
> I consider us users. We write networking CNI and observability/sec
> tooling on top of BPF. Most of what we create is driven by customer
> environments and performance. Maybe not typical users I guess, but
> also Meta users are not typical and have their own set of constraints
> and insights.

One thing Meta certainly does (and I think is a large part of success
of BPF) is delegating the development of applications away from the core
kernel team. Meta is different than a smaller company in that it _has_
a kernel team, but the "network application" teams I suspect are fairly
typical.

> > > Its pushing complexity into the kernel that we maintain in kernel
> > > when we could push the complexity into BPF and maintain as user
> > > space code and BPF codes. Its a choice to make I think.  
> > 
> > Right, and I believe having the code in the kernel, appropriately
> > integrated with the drivers is beneficial. The main argument against 
> > it is that in certain environments kernels are old. But that's a very
> > destructive argument.  
> 
> My main concern here is we forget some kfunc that we need and then
> we are stuck. We don't have the luxury of upgrading kernels easily.
> It doesn't need to be an either/or discussion if we have a ctx()
> call we can drop into BTF over the descriptor and use kfuncs for
> the most common things. Other option is to simply write a kfunc
> for every field I see that could potentially have some use even
> if I don't fully understand it at the moment.
> 
> I suspect I am less concerned about raw access because we already
> have BTF infra built up around our network observability/sec
> solution so we already handle per kernel differences and desc.
> just looks like another BTF object we want to read. And we
> know what dev and types we are attaching to so we don't have
> issues with is this a mlx or intel or etc device.
> 
> Also as a more practical concern how do we manage nic specific
> things? 

What are the NIC specific things?

> Have nic spcific kfuncs? Per descriptor tx_flags and
> status flags. Other things we need are ptr to skb and access
> to the descriptor ring so we can pull stats off the ring. I'm
> not arguing it can't be done with kfuncs, but if we go kfunc
> route be prepared for a long list of kfuncs and driver specific
> ones.

IDK why you say that, I gave the base list of offloads in an earlier
email.

