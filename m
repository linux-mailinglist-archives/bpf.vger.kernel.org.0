Return-Path: <bpf+bounces-20845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8148445A9
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8ED529537D
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D66212DD80;
	Wed, 31 Jan 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="T5iPnbAR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="srIFDtbB"
X-Original-To: bpf@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058CD12CDB9
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720795; cv=none; b=QyCy0HgcGnGhl6Q5ZJebew13jZnbczn4NFLJOs4r7Z4ti/FWzS+7y76ZfCeBOQW41W75SYpWdGmIw05B6M4w8QBzLPSTV1l8wpXgn5i+5jAHCeE1AieaKHExDG8m6OeYWIEQJ5o5ip8bxskruYg3kQy2bj192C5OLqne9lJB86o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720795; c=relaxed/simple;
	bh=nu8+6yKAAcTm+mnEIpJhlHyVysTNlVxyBylabbZd/MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuJMGYleBHP7PteIvFgXwE8VVLkT/RZlt1/5QOBLY9lEANA00YrH7dAOjt+s5wqmMdngC6UOoa3EGxJIpb6XNxv0fvX9iPFuw8T4hK/4M10yCOGU07AFclu59KlOKFByUJ1ZSOdONdYPv+FASMg1YrGCj8UmXZmYhTI+3iiDXpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=T5iPnbAR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=srIFDtbB; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id D7C2B5C0065;
	Wed, 31 Jan 2024 12:06:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 31 Jan 2024 12:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706720791; x=1706807191; bh=KBpbO/KFac
	zOvR4B7CvXFZygAZSzPgh7ANV5YxEBUJQ=; b=T5iPnbARRYcAgeD1CCsLbIYFby
	u/F/bkI0CwH+7viFCKWdJEtTrICaORZxJLge6XF9lpZKL+lxSrTEELYY4AXjylC5
	SKKo35Nh3fUEnHdFRFN/GTDJAXVidhH5Q7JvcZY8L4XCn+ASkAWPuVYe3dekqCxx
	bCrT4Sj+t2ozu4vQlyM4SCmrKcTZEWwTrWnQ8LRHxc//UU6oz2boP6wV70v0aPKV
	YpPAqSGuqkZgL/fUm6osSVE+fXhaAuRAnxGbzlcyvGX/gtJ08WP+blYT/6kn6yhp
	qYlMydkBTBdqL/L7ysw8usRO+b9foLNJRqI6ZWjYPxRGkAorzJjrAY5Ta7jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706720791; x=1706807191; bh=KBpbO/KFaczOvR4B7CvXFZygAZSz
	Pgh7ANV5YxEBUJQ=; b=srIFDtbBKgYwQIAGgt59xhk8si2rAYBzbI5dewnXbcX5
	O9D8DnfuGB7JZJX6y7nzqPXNyL2mZ1zDR+aGDE2CwRGk3ewL6JpWLpHtbMSyRjz9
	bIa/SVqAZ+Vyr1fU6LqtyVZ+zmMd6+ReEhKOl9ylBXG3jevkorKts8Z+0TX7T2W6
	mWQB8i/bS1MqYmHJh/wXzNNbSyXge4TSi8TTb7+zN3Tk0UBfif4jVQ48HC/xFdRb
	tGn0WDMmExm6wmZEjODKFGVjiAMPQnXuiS0tUk1Zly02x8b7N4z1CCpiO26y5XZC
	iiVcuUtdA5d6XcGw3ISV0EvCFnCke3xlXRHXjxOAvQ==
X-ME-Sender: <xms:F366ZRqGvVqFpLci2uFKo9av-toebyAeJTQJhjHbp56DOvni8tMudQ>
    <xme:F366ZTqRG13LKzpzYb0yZI8Lpj5SgdQ6s6KxomFcghp6naPDoekULzoCVRWBkEnnR
    icWMBhqetvBe-fAzQ>
X-ME-Received: <xmr:F366ZeNJD46jF3hkmNS5XtpryOVBlJr2xULAgFf5fmOA4kQldiMvf56igL_wrSOyNA_3UTbKDblhe8EfJMMsTHFdY4POiGE1ynIVQqo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtledgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:F366Zc7TC3VWx9c9S-UKP0H-s0spIGOoPfIE6tPHBRw-qwPrHe7FLg>
    <xmx:F366ZQ4HgJgEqfy8FTkdMaRM6R-FH6_4nCuarN6qGqgTcURUDJSeSw>
    <xmx:F366ZUgxqBpO6B5nE27lYOuiXW_lHf2zfQlROixtkUFVdqFEzMbxXA>
    <xmx:F366ZQzlLuFlI5j1h75Sk10iBJ5XlPjl4qEa3Xram1-ZQgF30LTjfQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jan 2024 12:06:30 -0500 (EST)
Date: Wed, 31 Jan 2024 10:06:29 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC bpf-next 0/2] libbpf Userspace Runtime-Defined Tracing
 (URDT)
Message-ID: <vtkysqjcvf7yi6cwa4l5w44nuk6hvpe47f6ikchob3djzxfi7q@udajgkhv2rdq>
References: <20240131162003.962665-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131162003.962665-1-alan.maguire@oracle.com>

Hi Alan,

On Wed, Jan 31, 2024 at 04:20:01PM +0000, Alan Maguire wrote:
> Adding userspace tracepoints in other languages like python and
> go is a very useful for observability.  libstapsdt [1]
> and language bindings like python-stapsdt [2] that rely on it
> use a clever scheme of emulating static (USDT) userspace tracepoints
> at runtime.  This involves (as I understand it):
> 
> - fabricating a shared library
> - annotating it with ELF notes that describe its tracepoints
> - dlopen()ing it and calling the appropriate probe fire function
>   to trigger probe firing.
> 
> bcc already supports this mechanism (the examples in [2] use
> bcc to list/trigger the tracepoints), so it seems like it
> would be a good candidate for adding support to libbpf.
> 
> However, before doing that, it's worth considering if there
> are simpler ways to support runtime probe firing.  This
> small series demonstrates a simple method based on USDT
> probes added to libbpf itself.
> 
> The suggested solution comprises 3 parts
> 
> 1. functions to fire dynamic probes are added to libbpf itself
>    bpf_urdt__probeN(), where N is the number of probe arguemnts.
>    A sample usage would be
> 	bpf_urdt__probe3("myprovider", "myprobe", 1, 2, 3);
> 
>    Under the hood these correspond to USDT probes with an
>    additional argument for uniquely identifying the probe
>    (a hash of provider/probe name).
> 
> 2. we attach to the appropriate USDT probe for the specified
>    number of arguments urdt/probe0 for none, urdt/probe1 for
>    1, etc.  We utilize the high-order 32 bits of the attach
>    cookie to store the hash of the provider/probe name.
> 
> 3. when urdt/probeN fires, the BPF_URDT() macro (which
>    is similar to BPF_USDT()) checks if the hash passed
>    in (identifying provider/probe) matches the attach
>    cookie high-order 32 bits; if not it must be a firing
>    for a different dynamic probe and we exit early.
> 
> Auto-attach support is also added, for example the following
> would add a dynamic probe for provider:myprobe:
> 
> SEC("udrt/libbpf.so:2:myprovider:myprobe")
> int BPF_URDT(myprobe, int arg1, char *arg2)
> {
>  ...
> }
> 
> (Note the "2" above specifies the number of arguments to
> the probe, otherwise it is identical to USDT).
> 
> The above program can then be triggered by a call to
> 
>  BPF_URDT_PROBE2("myprovider", "myprobe", 1, "hi");
> 
> The useful thing about this is that by attaching to
> libbpf.so (and firing probes using that library) we
> can get system-wide dynamic probe firing.  It is also
> easy to fire a dynamic probe - no setup is required.
> 
> More examples of auto and manual attach can be found in
> the selftests (patch 2).
> 
> If this approach appears to be worth pursing, we could
> also look at adding support to libstapsdt for it.

This is quite interesting, thanks for the RFC. I hope to take a closer
look at it this week.

At a high level, it looks like you're basically defining a scheme for
well-known USDT probes, right? Since, not all languages enjoy linking
against C (looking at you golang...), perhaps it would make sense to
codify the scheme in a "spec". Probably just located in Documentation/
or something. That way there can be independent implementations.

This is something that would be nice to support in bpftrace as well. I'm
sure other tracers would probably find use as well.

Thanks,
Daniel

