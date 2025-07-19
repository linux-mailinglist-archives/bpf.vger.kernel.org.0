Return-Path: <bpf+bounces-63780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFC6B0ACB0
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 02:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0943E5684A5
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 00:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396803FF1;
	Sat, 19 Jul 2025 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVyDqCVT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D87FD;
	Sat, 19 Jul 2025 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752883788; cv=none; b=NbgzHR68joBi5l6KdwOfRDvE3i/yp8FQiA5dhjkhNOIMIvrABWPwPJ1VEN2VAeLEEZBr2b6CT+xQtWFbgAmR32spWOlW8pvmx+SOnVtjaQqZPXuTADXQQgmCBAED/4SP3ucELqi9btYQEuLXnH/mX8XadcOowv8XZf4Lw4NbKa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752883788; c=relaxed/simple;
	bh=fAFUe3fvv1ulm6S6+uD+7u+U8IEY0IigIU64nRcD0h4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EvmSlYQg5ZRaaHCWYDRGs0gk+1F7JwnXJJdWJUhI+w1GbDWLvDEynkGfFxMhEAQHWg5Baur7jy6aewt2t/mzzGzY+q/zD04B6UgP7jtD4v+WloQDNbMpMXrv5rMkZNIfUK+SFC+asOmKuEP9QnzoIRdfUvQjQXfA8Mw9TYY9y+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVyDqCVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C178C4CEEB;
	Sat, 19 Jul 2025 00:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752883788;
	bh=fAFUe3fvv1ulm6S6+uD+7u+U8IEY0IigIU64nRcD0h4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TVyDqCVTXPpOXOFWdR1RNE9wOFWG+RHvgg4UPbLsWoDPT+sl1l8BQBlVRotEPL6I8
	 qjkSTFq2Q5ERdlg9+NKYzgGgpcdmv6Dqjzb6pv1IIHdz+t7OAyYyMgJTD/sZaVvkYA
	 CZfoEVvdlQm7M4jZpDofUnYDdlla3ZMOvUJAwEIRnKlbs+J3EwsgHBvgHvQRiSj5Er
	 tHyDL8IVkJtW3smmnLGtAUGlCl1puVFdFsHCydsq3nMztFZ+xhzjkZgU11is7hPsjc
	 qlau5Y7M48p0PAEGn39BClznfSpJTsznSTGKnqFa7/4Q/3mvMqUcdVPx8I3ovTtIgH
	 TNENICxtZxzTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0A9383BA3C;
	Sat, 19 Jul 2025 00:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V5] net: track pfmemalloc drops via
 SKB_DROP_REASON_PFMEMALLOC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175288380777.2831723.3410083035136520170.git-patchwork-notify@kernel.org>
Date: Sat, 19 Jul 2025 00:10:07 +0000
References: <175268316579.2407873.11634752355644843509.stgit@firesoul>
In-Reply-To: <175268316579.2407873.11634752355644843509.stgit@firesoul>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, bpf@vger.kernel.org,
 eric.dumazet@gmail.com, davem@davemloft.net, pabeni@redhat.com, toke@toke.dk,
 kernel-team@cloudflare.com, mfleming@cloudflare.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 18:26:53 +0200 you wrote:
> Add a new SKB drop reason (SKB_DROP_REASON_PFMEMALLOC) to track packets
> dropped due to memory pressure. In production environments, we've observed
> memory exhaustion reported by memory layer stack traces, but these drops
> were not properly tracked in the SKB drop reason infrastructure.
> 
> While most network code paths now properly report pfmemalloc drops, some
> protocol-specific socket implementations still use sk_filter() without
> drop reason tracking:
> - Bluetooth L2CAP sockets
> - CAIF sockets
> - IUCV sockets
> - Netlink sockets
> - SCTP sockets
> - Unix domain sockets
> 
> [...]

Here is the summary with links:
  - [net-next,V5] net: track pfmemalloc drops via SKB_DROP_REASON_PFMEMALLOC
    https://git.kernel.org/netdev/net-next/c/a6f190630d07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



