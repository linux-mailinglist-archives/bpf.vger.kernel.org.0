Return-Path: <bpf+bounces-65779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A23B283E2
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 18:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E422DAE0705
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EED3093B2;
	Fri, 15 Aug 2025 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1ytxYsG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FDD19DF8D;
	Fri, 15 Aug 2025 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275806; cv=none; b=FASUmkD/8xkYtPenxGR6Wsg96l8vXUtuUA+iXTEUt0dj31TRqvPnExhOVrQbc09P9YiN5LA24RdHbPkuOKP3ciXHf+88W/UMktWTkEN88vv0tT/U52z79ptgWMDQk/hKezo4PK62AaNuBcWgM9Yk3ibu/Au0PFIRRkBPh7bxPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275806; c=relaxed/simple;
	bh=OaNdnUJ5541nY169u1OMWAmmuLtXxMh24hdDnqIn1lc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kz+Wha07vJc9r9MvzTSOdGiKR3iGsgYg27hWBjbehfON2kw1MPqTxYGJyxZ62qZhncP0xlqQe+zRDjLMLOg18LLOB2SvKR8M82mZiZ8zUjJA1KA6J0HUyglUzbI5ZuaD8wEHsqhjzATYC46NWoKVeL14YIy4S3jeE0//mzJrIUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1ytxYsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C5CC4CEEB;
	Fri, 15 Aug 2025 16:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755275805;
	bh=OaNdnUJ5541nY169u1OMWAmmuLtXxMh24hdDnqIn1lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E1ytxYsGLYOu+Jli5OeCBHqqimXwnR80A01MeT9rHQpvoJUHf7xYLgMcts5p3Tir9
	 cGaiGze5KHN/PSQ2ENVR/F6LpAAb3lcid9XWusBvdtdgPx4TpNh1ORpFd7I3wMuEQy
	 iRgBv5sd2/plDOC5OnmBmW3HGzThBVfJs934EeQAKCjbsS/XlN7aCgOvAiGyfnh9dh
	 ELicg3BPBm62Qkuz90h3590wtC1cUZxMutwkcjjeR/P+vBVe46KZJtVmrCzX0Tdm17
	 xtMtGDahjk0oQ/o+a3ZKcfrb7NQ5g76uVyyDrkgJlnmhlKZM7PBtfq3HeJW2XGPzgq
	 dFO1ugSdyLt2A==
Date: Fri, 15 Aug 2025 09:36:44 -0700
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
 Yan Zhai <yan@cloudflare.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mina Almasry <almasrymina@google.com>
Subject: Re: [BUG] mlx5_core memory management issue
Message-ID: <20250815093644.5447c581@kernel.org>
In-Reply-To: <bd1a2f1f-20bb-4cc0-82ed-150c5e36b1da@kernel.org>
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
	<20250815075929.6a19662d@kernel.org>
	<bd1a2f1f-20bb-4cc0-82ed-150c5e36b1da@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 18:02:10 +0200 Jesper Dangaard Brouer wrote:
> >> Yes, something like that, but I would like Kuba/Jakub's input, as IIRC
> >> he introduced the page_pool->cpuid and page_pool->napi.
> >>
> >> There are some corner-cases we need to consider if they are valid.  If
> >> cpumap get redirected to the *same* CPU as "previous" NAPI instance,
> >> which then makes page_pool->cpuid match, is it then still valid to do
> >> "direct" return(?).  
> > 
> > I think/hope so, but it depends on xdp_return only being called from
> > softirq context.. Since softirqs can't nest if producer and consumer
> > of the page pool pages are on the same CPU they can't race.  
> 
> That is true, softirqs can't nest.
> 
> Jesse pointed me at the tun device driver, where we in-principle are 
> missing a xdp_set_return_frame_no_direct() section. Except I believe, 
> that the memory type cannot be page_pool in this driver. (Code hint, 
> tun_xdp_act() calls xdp_do_redirect).
> 
> The tun driver made me realize, that we do have users that doesn't run 
> under a softirq, but they do remember to disable BH. (IIRC BH-disable 
> can nest).  Are we also race safe in this case(?).

Yes, it should be. But chances of direct recycling happening in this
case are rather low since NAPI needs to be pending to be considered
owned. If we're coming from process context BHs are likely not pending.

> Is the code change as simple as below or did I miss something?
> 
> void __xdp_return
>    [...]
>    case MEM_TYPE_PAGE_POOL:
>     [...]
>      if (napi_direct && READ_ONCE(pool->cpuid) != smp_processor_id())
> 	napi_direct = false;

cpuid is a different beast, NAPI-based direct recycling logic is in
page_pool_napi_local() (and we should not let it leak out to XDP,
just unref the page and PP will "override" the "napi_safe" argument).

> It is true, that when we exit NAPI, then pool->cpuid becomes -1.
> Or what that only during shutdown?

