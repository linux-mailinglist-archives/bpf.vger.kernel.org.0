Return-Path: <bpf+bounces-52727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7F7A47EE6
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 14:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236BE1896D8A
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 13:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A67230997;
	Thu, 27 Feb 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgr5WQkK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D8A22FE13;
	Thu, 27 Feb 2025 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662401; cv=none; b=IGDR4TWCEhTfa8ww6aoa/gVDtKOeaawaFDcjTUURIdCplo8vfES9G+2F/+w5hMtPugmIeNeV4xP00jNxm+SZyUVWA8petDdzl7kQW1ZEufJGmA+GtUFj2fb49iRA5qPZDcl1UILtHJtNWunpsmhd//avDEy6JgOoONk9mtBDx5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662401; c=relaxed/simple;
	bh=fx/Vom5mqh1leEZgG1aXz67lV8T/4Prd0jnHr4TXuX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j8g5f0DdUowvb49CtE3ByEfrcAFRNrCKz3xg9lu8wnUoddkuplauRrIsMesk8PQl8S6XnJyPj46DzvwjU3nGhlWiIs5HUae16YvzoY/DbIFk9gUNFQu2+f9uIcufZl0k3EPtEhio9zz3fQq42G2XO09jMASPJYTG08d3kKydlk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgr5WQkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD9AC4AF0B;
	Thu, 27 Feb 2025 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740662400;
	bh=fx/Vom5mqh1leEZgG1aXz67lV8T/4Prd0jnHr4TXuX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hgr5WQkK6hpAwtpX4s8FDd0cwNjE5K3Xkf/iPiZxefwYhyMLVqUHnnv5Wpsl4uURb
	 4ENKT1yriatYXcREFBFv8sM91bcjBERPpqMv3jrFYge7z3gPnLPfqbw6lbYvXWb5ur
	 z49h2fkQFGGKYb3sVSS4dDHFjbupGWJWZX9yWDqdJ7vKcj+GONP5DoIYHsG+fdg7m1
	 8MLncX2Wc1ORiSRg99UK9LiDHYVTew5IIqRL+Z6oybSl/eXgRPnS0jn/1xp1UAvtUN
	 VyvIfsNzlt7R89/NR3E+xB+RxnUgQCG7t0SJc89jgFVcPigbBQXzlbuLsNvAP1zf69
	 uwl6KLGw4123Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD66380AA7F;
	Thu, 27 Feb 2025 13:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/8] bpf: cpumap: enable GRO for XDP_PASS frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174066243275.1425284.11463138682186483898.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 13:20:32 +0000
References: <20250225171751.2268401-1-aleksander.lobakin@intel.com>
In-Reply-To: <20250225171751.2268401-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lorenzo@kernel.org, dxu@dxuuu.xyz,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 john.fastabend@gmail.com, toke@kernel.org, hawk@kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Feb 2025 18:17:42 +0100 you wrote:
> Several months ago, I had been looking through my old XDP hints tree[0]
> to check whether some patches not directly related to hints can be sent
> standalone. Roughly at the same time, Daniel appeared and asked[1] about
> GRO for cpumap from that tree.
> 
> Currently, cpumap uses its own kthread which processes cpumap-redirected
> frames by batches of 8, without any weighting (but with rescheduling
> points). The resulting skbs get passed to the stack via
> netif_receive_skb_list(), which means no GRO happens.
> Even though we can't currently pass checksum status from the drivers,
> in many cases GRO performs better than the listified Rx without the
> aggregation, confirmed by tests.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/8] net: gro: decouple GRO from the NAPI layer
    (no matching commit)
  - [net-next,v5,2/8] net: gro: expose GRO init/cleanup to use outside of NAPI
    https://git.kernel.org/netdev/net-next/c/388d31417ce0
  - [net-next,v5,3/8] bpf: cpumap: switch to GRO from netif_receive_skb_list()
    https://git.kernel.org/netdev/net-next/c/4f8ab26a034f
  - [net-next,v5,4/8] bpf: cpumap: reuse skb array instead of a linked list to chain skbs
    https://git.kernel.org/netdev/net-next/c/57efe762cd3c
  - [net-next,v5,5/8] net: skbuff: introduce napi_skb_cache_get_bulk()
    https://git.kernel.org/netdev/net-next/c/859d6acd94cc
  - [net-next,v5,6/8] bpf: cpumap: switch to napi_skb_cache_get_bulk()
    (no matching commit)
  - [net-next,v5,7/8] veth: use napi_skb_cache_get_bulk() instead of xdp_alloc_skb_bulk()
    https://git.kernel.org/netdev/net-next/c/1c5bf4de975d
  - [net-next,v5,8/8] xdp: remove xdp_alloc_skb_bulk()
    https://git.kernel.org/netdev/net-next/c/b696d289c07d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



