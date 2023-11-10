Return-Path: <bpf+bounces-14746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C47E7A3A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 09:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C61BB21020
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 08:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42ED79F9;
	Fri, 10 Nov 2023 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="h1mvIt3j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZF49hbKX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A1BCA73
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 08:41:37 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C0446A6
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 00:41:35 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 866505C0226;
	Fri, 10 Nov 2023 03:41:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 Nov 2023 03:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1699605694; x=
	1699692094; bh=unlKO9QUlToC6z1la40+BL1VJ6L0Ji5ODoL43sqV4Cc=; b=h
	1mvIt3jhf00YQ858bfCujrHw8SGAUiny+1j5KaqgVh4YcbjP5AaGdttQlzvmlIn6
	6OnLGpsUnkMI9zyNfcovPnkbJvbeJ4ymHfIXkGt0XZLIzk0WOlMF4SF2e7144ICO
	tQPpaAH7952lCTV+MfNWsj5LMQD5eje+cam1u03dWGKscLcQ5McwNRyro9gxNYvy
	9ixqDYcAXD39v8ZYP5o5wvV0mf0hWrQnUNqn5DVuyUturoej5TuACKlQrmD3yb1d
	ChSc8e7Gw7wrrvGE6E+vM3+uL6oq3G+KNjdSi6D7tjGifcWslZICk8TmeQdiUySW
	JGh+xGbsSzYxxQ9hP6q0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699605694; x=1699692094; bh=unlKO9QUlToC6
	z1la40+BL1VJ6L0Ji5ODoL43sqV4Cc=; b=ZF49hbKX6A/VE7L7UdUk4h0ceQuK6
	L7gJ05sGVRRZK7Vud6iBy8rYRWwTCjeZniVnQ7aRw6ZOJhoGsbGI55WNztYpJcyB
	AUpm/LaYoJOUBAbzsv7c2IV+vKGnIexLe+wgmtdzMzA3oCflQlqfqKodDpISMufC
	mGBbl4u7DwXBmHGaLxvNRLgUPRoKtrVMtOaF0BjyX7U/aIg2ZRRjOvgDPkmlPXOR
	nXNh0kk3dtZI3jG+CyVDaTZZ7zVYn56nANe9GlU0/sHWr/fHwVJ9u7GxJPSRfcca
	/nh9NvtLFd/nMrbNKOSeAk0aezEKPPs2p3QKLhHx99n+wLCWXq/NDkGSA==
X-ME-Sender: <xms:vuxNZYkE1hhoIUS8CdsiXWFJ8z_Q0Hu4ouHCMjpQJumpW78PsrZSEA>
    <xme:vuxNZX0gdR982KI5RQrdbycp7PZ8MlEoX-k_LwlbJKQjYywA_-py3yAJeM9eJbF_S
    mqxeD749zDfPGyBkaY>
X-ME-Received: <xmr:vuxNZWp7q_AvaAvJb7XRXoHxUf992CHHo2PefsUEevT_1e18rH89f166F0SHOPqIWwtMJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvvddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetucdrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeetueekfeffuddthfehveekkeethefgveeg
    hfekieeukeeiieffgfekieeigefhtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhi
    lhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:vuxNZUk0gIDq3QZAvsEGCeD-bvwgCT9LbOtzAVezrDbd7Ho2OLy4YA>
    <xmx:vuxNZW2dH6MSq7xpkwGd9yrxM2czTNgmF4C6cvvzCBTcq-lKzHHewg>
    <xmx:vuxNZbuRSAOZocwySjodRq4MXHHgXabWZysiRJYIkzUGFzpTqPW5Fg>
    <xmx:vuxNZS_DlCRWXlhXr6MGFO6-5vzdDXnDekoA3tcfA2owxl-_pkSx5w>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Nov 2023 03:41:33 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 9E1FE10A31E; Fri, 10 Nov 2023 11:41:29 +0300 (+03)
Date: Fri, 10 Nov 2023 11:41:29 +0300
From: "Kirill A . Shutemov" <kirill@shutemov.name>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf] bpf: Do not allocate percpu memory at init stage
Message-ID: <20231110084129.25id5clodjx4o4rw@box.shutemov.name>
References: <20231110061734.2958678-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110061734.2958678-1-yonghong.song@linux.dev>

On Thu, Nov 09, 2023 at 10:17:34PM -0800, Yonghong Song wrote:
> Kirill Shutemov reported significant percpu memory increase after booting

s/memory increase/memory consumption increase/ ?

> in 288-cpu VM ([1]) due to commit 41a5db8d8161 ("bpf: Add support for
> non-fix-size percpu mem allocation"). The percpu memory is increased
> from 111MB to 969MB. The number is from /proc/meminfo.
> 
> I tried to reproduce the issue with my local VM which at most supports
> upto 255 cpus. With 252 cpus, without the above commit, the percpu memory
> immediately after boot is 57MB while with the above commit the percpu
> memory is 231MB.
> 
> This is not good since so far percpu memory from bpf memory allocator
> is not widely used yet. Let us change pre-allocation in init stage
> to on-demand allocation when verifier detects there is a need of
> percpu memory for bpf program. With this change, percpu memory
> consumption after boot can be reduced signicantly.
> 
>   [1] https://lore.kernel.org/lkml/20231109154934.4saimljtqx625l3v@box.shutemov.name/
> 
> Fixes: 41a5db8d8161 ("bpf: Add support for non-fix-size percpu mem allocation")
> Cc: Kirill A. Shutemov <kirill@shutemov.name>

Reported-and-tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

