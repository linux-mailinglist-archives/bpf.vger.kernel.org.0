Return-Path: <bpf+bounces-47414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C9A9F92BA
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 14:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F0D16DE62
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2582A215769;
	Fri, 20 Dec 2024 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg6v9eLn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9C42156F3;
	Fri, 20 Dec 2024 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734699618; cv=none; b=eMNLxkKNnk4yXdGhH5HvX6B5XEw1e3dXC+v5wW4o4cDb/bVp7u1mJGBewi4CTp4MEobYFLbK2da/12nsttGOg6ol6XgeD0QTAV7uQ6q1okU4YgqmlKS6vUlaaLmtgA0NVfAIOUOWtI6BKxgP01rsOZ+kg3BQojQ7POV7JpcKYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734699618; c=relaxed/simple;
	bh=3JQ9ZfN5ioufoK7K0DrG50y58gPQcrUNsg7oXkjbzU8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jo+dH2ZljAPWvJAinzGd3NItl3Hsvi0NiGxMdYjHCCvdJentxsr5RZsRQmRk5RNADRt8QXjCPryT9XnfRti6bzrlB59+Zw0W7DPAfovAoHOjWGNz5WwjYHq6J3U69ptfBHEJ8k9tgYJm57mEIPLibaOsKHGmiXn+xtU/z/z/nIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg6v9eLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBCDC4CECD;
	Fri, 20 Dec 2024 13:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734699617;
	bh=3JQ9ZfN5ioufoK7K0DrG50y58gPQcrUNsg7oXkjbzU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cg6v9eLnE/rvSiFzFe69ZEJcawLij5y/1Gfi8P8hJ1ox10Ktvk9/zEE7iq00mVEwD
	 gml2BguUBxb6e72JuGw0ozhHQS4B6EGGtenN2DWFy54SA0W9HK2mgRTHScow9NF2gb
	 18oTfXsNpo/5u5HYUeuiHdDZTMdb5kTO8KSDhDytZW1EfjfOlBbXSl54mHs8FQkzpr
	 9TLV6hhq4Bsr4RxD3KVG6MbgetokZOREqcjSEA6ilm4VOCujkgQZZffD/c6pN/wDja
	 iZWJekDDkpWOBReF+C2F7TifYYDlOFgDQeK52f3ByHxaiD8Wlh+oM1uxeLPaChsOGF
	 gN5U0H98VoW7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC82A3806656;
	Fri, 20 Dec 2024 13:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] gve: various XDP fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173469963470.2895973.2113580557517865563.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 13:00:34 +0000
References: <20241218133415.3759501-1-pkaligineedi@google.com>
In-Reply-To: <20241218133415.3759501-1-pkaligineedi@google.com>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, shailend@google.com,
 willemb@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 horms@kernel.org, hramamurthy@google.com, joshwash@google.com,
 ziweixiao@google.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 18 Dec 2024 05:34:10 -0800 you wrote:
> From: Joshua Washington <joshwash@google.com>
> 
> This patch series contains the following XDP fixes:
>  - clean up XDP tx queue when stopping rings
>  - use RCU synchronization to guard existence of XDP queues
>  - perform XSK TX as part of RX NAPI to fix busy polling
>  - fix XDP allocation issues when non-XDP configurations occur
> 
> [...]

Here is the summary with links:
  - [net,1/5] gve: clean XDP queues in gve_tx_stop_ring_gqi
    https://git.kernel.org/netdev/net/c/6321f5fb70d5
  - [net,2/5] gve: guard XDP xmit NDO on existence of xdp queues
    https://git.kernel.org/netdev/net/c/ff7c2dea9dd1
  - [net,3/5] gve: guard XSK operations on the existence of queues
    https://git.kernel.org/netdev/net/c/40338d7987d8
  - [net,4/5] gve: process XSK TX descriptors as part of RX NAPI
    https://git.kernel.org/netdev/net/c/ba0925c34e0f
  - [net,5/5] gve: fix XDP allocation path in edge cases
    https://git.kernel.org/netdev/net/c/de63ac44a527

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



