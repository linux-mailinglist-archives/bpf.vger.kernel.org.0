Return-Path: <bpf+bounces-65775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE74B2828A
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 17:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DDBAE2D1C
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176CF28504B;
	Fri, 15 Aug 2025 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIoz1QsG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A026A1BB;
	Fri, 15 Aug 2025 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755269971; cv=none; b=b80r2XpiehDvTmU05hwMfsZus1g/2LH+gMNkxpz/rOcwY57PXUpG2O4OEMoaEQ4FTbXH/DBmgjLtmSK5dU/9yoiNzlILeC50bE7nNqTKxXEluXD7AHmJ35DXRti7jUKOCnRWaVPjDiRwrjwfLruHM5H8o8iY94scZ8sTi+mC7Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755269971; c=relaxed/simple;
	bh=K2HCrlZN3WAPvhfqlDgI0HwTxr0z7vN0Dze152XGvxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQtaSEEhmzn9/BbgIHQYgWniEx8DbFm0+wytrlhrIqn/bKOsS28tRUs+MxftLhpQRA/BFvbxLxTqdL+NqBqmY/HLGkqt6JgkiwBwwqWkh5aKO1KNsblyMExP86u7DJIjZF4CTdNYTVGmNTFk+AuG5LfBpg0uYIcllP9ZyMtH1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIoz1QsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DA1C4CEF5;
	Fri, 15 Aug 2025 14:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755269971;
	bh=K2HCrlZN3WAPvhfqlDgI0HwTxr0z7vN0Dze152XGvxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eIoz1QsGfZ++g0ntpzGQz7rXt4xHHVvQ2CbxlJ5uHFRLtTK0zmCO0Fp9dgnYkNdRI
	 PYAaD3UqD228zU6iYWJKO1qTB8nCKELKq3LKCyCYQoECrWV8dc+t9lIM6stKdslpi2
	 52iuMPsFI6CINkUhNDJMEJ1Xd9Bq3IuqJJWF71QVJjJNr2eb1oGE4+VDJ7TiI7gaAv
	 AXX76uDqywqdCc5p0ez0JWpnc2n/bnFBuBy/cBZfGbN7XlCUhH1ef5PwzJlOuXAuJH
	 tCKssakIbb4xE0Nsci2/Tpoh/Bm0u3sMdInEKcrUo09GryrMG3pk/GiGSxNh+IsI1M
	 TJmEbMjbBEaAw==
Date: Fri, 15 Aug 2025 07:59:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Chris Arges
 <carges@cloudflare.com>, Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team
 <kernel-team@cloudflare.com>, tariqt@nvidia.com, saeedm@nvidia.com, Leon
 Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Simon Horman <horms@kernel.org>, Andrew Rzeznik <arzeznik@cloudflare.com>,
 Yan Zhai <yan@cloudflare.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [BUG] mlx5_core memory management issue
Message-ID: <20250815075929.6a19662d@kernel.org>
In-Reply-To: <8d165026-1477-46cb-94d4-a01e1da40833@kernel.org>
References: <aJTYNG1AroAnvV31@861G6M3>
	<hlsks2646fmhbnhxwuihheri2z4ymldtqlca6fob7rmvzncpat@gljjmlorugzw>
	<aqti6c3imnaffenkgnnw5tnmjwrzw7g7pwbt47bvbgar2c4rbv@af4mch7msf3w>
	<9b27d605-9211-43c9-aa49-62bbf87f7574@cloudflare.com>
	<72vpwjc4tosqt2djhyatkycofi2hlktulevzlszmhb6w3mlo46@63sxu3or7suc>
	<aJuxY9oTtxSn4qZP@861G6M3>
	<aJzfPFCTlc35b2Bp@861G6M3>
	<5hinwlan55y6fl6ocilg7iccatuu5ftiyruf7wwfi44w5b4gpa@ainmdlgjtm5g>
	<4zkm7dmkxhfhf3cm7eniim26z6nbp3zsm4qttapg3xbvkrqhro@cvjnbr624m5h>
	<e60404e2-4782-409f-8596-ae21ce7272c4@kernel.org>
	<tyioy6vj2os2lnlirqxdbiwdaquoxd64lf3j3quqmyz6qvryft@xrfztbgfk7td>
	<8d165026-1477-46cb-94d4-a01e1da40833@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 17:58:21 +0200 Jesper Dangaard Brouer wrote:
> Found-by: Dragos Tatulea <dtatulea@nvidia.com>

ENOSUCHTAG?

> Reported-by: Chris Arges <carges@cloudflare.com>

> >> The XDP code have evolved since the xdp_set_return_frame_no_direct()
> >> calls were added.  Now page_pool keeps track of pp->napi and
> >> pool-> cpuid.  Maybe the __xdp_return [1] checks should be updated?
> >> (and maybe it allows us to remove the no_direct helpers).
> >>  
> > So you mean to drop the napi_direct flag in __xdp_return and let
> > page_pool_put_unrefed_netmem() decide if direct should be used by
> > page_pool_napi_local()?  
> 
> Yes, something like that, but I would like Kuba/Jakub's input, as IIRC
> he introduced the page_pool->cpuid and page_pool->napi.
> 
> There are some corner-cases we need to consider if they are valid.  If
> cpumap get redirected to the *same* CPU as "previous" NAPI instance,
> which then makes page_pool->cpuid match, is it then still valid to do
> "direct" return(?).

I think/hope so, but it depends on xdp_return only being called from
softirq context.. Since softirqs can't nest if producer and consumer 
of the page pool pages are on the same CPU they can't race.
I'm slightly worried that drivers which don't have dedicated Tx XDP
rings will clean it up from hard IRQ when netpoll calls. But that'd
be a bug, right? We don't allow XDP processing from IRQ context.

