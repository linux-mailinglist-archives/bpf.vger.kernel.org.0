Return-Path: <bpf+bounces-74621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F91C5FE01
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED81835C2AA
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F211FDE14;
	Sat, 15 Nov 2025 02:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEEftl0t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85F91F1313;
	Sat, 15 Nov 2025 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173242; cv=none; b=ZSjzE+DJRiFtz3XxIqdHe1/8Vv52mtwp5FtMgvKfuAtAkt3AlpRJlEBd1dAsT2lc3+VKZOcTB2p70VJo7g2d6+2+3zMyIZhpBBmLpC1/ul+vVRKL+Hi/58KJDRiLsR7auM0MbwvuDjYxsGbjFoP0GnzW8truoEMPQNmppHaetyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173242; c=relaxed/simple;
	bh=1nbnsS4EqlOU2qhDQ7Tb3xjj4GMZ9cC54/ecuLvYD6I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P8O2h12ZSynJ8orVfhx/fjAJ9MTh6ZVWypreo/KoM+sgcHcgW6LYAW+Z0ikd6tzYqCViysg6LicErOPSqMt7dU+6+mlCh+r7YnkPdJEXl1/YhZORMsSotsgn0kbuyMHVuC1vpfzO25bqnxBiKJB1XMhMtLySh2ZhC63w6FD6aPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEEftl0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579E6C4CEF8;
	Sat, 15 Nov 2025 02:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763173242;
	bh=1nbnsS4EqlOU2qhDQ7Tb3xjj4GMZ9cC54/ecuLvYD6I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vEEftl0tcrRC4jXXSWLWksXw53WnJvCpsY+wntW6mK2dpgZjNceyubJ71a8jB+tv/
	 8ZPe0JgiRR2gOv77GxmhSdaFi7wEZ2Tadt7XA/FVpOmqgrwleeNyW3mZ77Ob+jHpF6
	 oJYNviHJcHkA6HnQDTwqDBStRLV6GNHY9QMKHOIxsSH6VYaVlO8Qvjl9TzJG8NlnT6
	 3mlJSeph8OPia4cjLR3Gu3Unh+KL/fFjwglrR9ans9gxkYQ4YeHznXXBSW610RmP5Q
	 TShRFyWUGdWMnbhLyw+H9ENwegcjcAXQhI1xKdmVwGEVx684czfl5F+AEe9Y3ahNW1
	 DWN9439GWWxvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD083A78A62;
	Sat, 15 Nov 2025 02:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V4] veth: more robust handing of race to avoid txq
 getting
 stuck
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317321050.1911668.3467356936047783737.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 02:20:10 +0000
References: <176295323282.307447.14790015927673763094.stgit@firesoul>
In-Reply-To: <176295323282.307447.14790015927673763094.stgit@firesoul>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, toke@toke.dk, eric.dumazet@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ihor.solodrai@linux.dev, mst@redhat.com, makita.toshiaki@lab.ntt.co.jp,
 toshiaki.makita1@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-team@cloudflare.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 14:13:52 +0100 you wrote:
> Commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to
> reduce TX drops") introduced a race condition that can lead to a permanently
> stalled TXQ. This was observed in production on ARM64 systems (Ampere Altra
> Max).
> 
> The race occurs in veth_xmit(). The producer observes a full ptr_ring and
> stops the queue (netif_tx_stop_queue()). The subsequent conditional logic,
> intended to re-wake the queue if the consumer had just emptied it (if
> (__ptr_ring_empty(...)) netif_tx_wake_queue()), can fail. This leads to a
> "lost wakeup" where the TXQ remains stopped (QUEUE_STATE_DRV_XOFF) and
> traffic halts.
> 
> [...]

Here is the summary with links:
  - [net,V4] veth: more robust handing of race to avoid txq getting stuck
    https://git.kernel.org/netdev/net/c/5442a9da6978

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



