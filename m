Return-Path: <bpf+bounces-3923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE047464BA
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 23:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745381C204F5
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 21:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B37125C0;
	Mon,  3 Jul 2023 21:12:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63D11CB6
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 21:12:06 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A126E59
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 14:12:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A89135C0296;
	Mon,  3 Jul 2023 17:12:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Jul 2023 17:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1688418721; x=1688505121; bh=7I
	TtN3iNIrwLq3MTX8AEVfFnq0FDh5dLqH/Wyo+0gsk=; b=CPqC1RwrkqDg3Qxn6A
	ZiQpO5pV+OhU8j1afB1UUndP+No9VzueaZl06OBNG4+U2TCmYu+L5pyfj92E/uTp
	xZTSj2mGDFbmrZOxbEcR0i+ohCnuT/do7kH7oYv0oCyvYHW2gTV4abIHxP6LORaC
	L5bHypAdi7q9IiLg6ALqwczNHXBlsVrctRZiq4qUH8+dn/rdh2OY5s/cU3xWO9wg
	hB1XwEpJbvGg+MhrL5ryZupqn6abmU7vq2Si+Qrv1KwhSCruzVv+FFJ8zNVu60EA
	v5xRs39Mv82xpNoYCJetS5oUbQTzCO28X6dH7YMzA0gJ9wmHpcRd414TNXYJkjOG
	S9AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1688418721; x=1688505121; bh=7ITtN3iNIrwLq
	3MTX8AEVfFnq0FDh5dLqH/Wyo+0gsk=; b=WGIhOgEUVd8mdebOdR51vJn8qtpjc
	o0P7l0rMtZZdvIgPeNO7hqyfdZjvfLi2f0FYY86i5TZZK/ToPVFFLUZv/Y9gwa0S
	r4nx/Yz0A9AnwiPeec48fXy1R9WVC1ylMoSsMyMNcY2AoX+W2fEiyuBPFmMdavs4
	69YWZvv/nlEtlVgg+Fblb8K0ys2RWvw6ZKIQGmR/Svk0L7tW4zvw/GG4h154M47F
	k6yb5CKWB7fIeO+PUvw/o8DOWGCyfTdhDo0ascTh1o2/rPzxxjWVBokV1M+1mVAJ
	AhzmuPaaG/nNDEQjX6+g7YCFllfhaRO6q8t07r8sFXSw89o8rHwmYLOoA==
X-ME-Sender: <xms:oTmjZPT7Q-j7mdGDjzblKttHv_MDDrNedOwI4fe5uUVZOcw8MHK4AQ>
    <xme:oTmjZAybNR5g06v6D74XFu-4FixiFoqhBaDkaKJnu4qYp5tmRG-zYqgG8MASE9G1g
    kLCeKZ3WuktBlccBg>
X-ME-Received: <xmr:oTmjZE0kkFSSIhvkKPtp70GycfTZ92fCXWCoQpWmLeBC-feU3DJ4d7viRbbP1PpFEASgY2cMbUO3xc0BixrcKP8dJ37unkORpNdB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:oTmjZPAO3APbE9JxWPDjhvwGIymvWWV9P6lQzzRznSQtc4Hu4igVew>
    <xmx:oTmjZIjAoXu83UFcykJCl9KeDo2Ub7ZkoDM8V-wKiDoXxHKnctnaxQ>
    <xmx:oTmjZDrGH-W4PAnGb5lmTU6J5iHw0Ollg7nPXfUEbGxhtdJcWfXoPg>
    <xmx:oTmjZEgArMq9yqbuVOnLZDwqC9CwszDH8q2b9aQI6i9z-wr1kMr1AQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jul 2023 17:12:00 -0400 (EDT)
Date: Mon, 3 Jul 2023 15:11:59 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Yonghong Song <yhs@meta.com>
Cc: Dave Thaler <dthaler@microsoft.com>, Yonghong Song <yhs@fb.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Fangrui Song <maskray@google.com>, "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Support new insns from cpu v4
Message-ID: <klq6m6gvliobcibcq5icuz6wst33xhe7rg6cs3kr66y4kkiug7@5r4mk44zjfkq>
References: <20230629063715.1646832-1-yhs@fb.com>
 <PH7PR21MB38786422B9929D253E279810A325A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <1b8e956e-ebfd-bfa1-713a-37c8039bf92a@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b8e956e-ebfd-bfa1-713a-37c8039bf92a@meta.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Yonghong,

On Thu, Jun 29, 2023 at 07:17:56AM -0700, Yonghong Song wrote:
> 
> 
> On 6/29/23 6:42 AM, Dave Thaler wrote:
> > Yonghong Song <yhs@fb.com> wrote:
> > > In previous discussion ([1]), it is agreed that we should introduce cpu version
> > > 4 (llvm flag -mcpu=v4) which contains some instructions which can simplify
> > > code, make code easier to understand, fix the existing problem, or simply for
> > > feature completeness. More specifically, the following new insns are
> > > proposed:
> > [...]
> > 
> > What about also updating instruction-set.rst?
> 
> Will update doc in the next revision.
> 
> > 
> > Dave
> > 
> 

I think bpf_design_QA.rst needs to be updated as well:

    Q: Why there is no BPF_SDIV for signed divide operation?
    [..]

Thanks,
Daniel

