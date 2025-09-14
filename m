Return-Path: <bpf+bounces-68343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF00B56B7C
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 21:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C7B3AAAB5
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 19:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686022DCF55;
	Sun, 14 Sep 2025 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1zPJ01d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE97469D;
	Sun, 14 Sep 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757877018; cv=none; b=WsaGkS7ReasE8qj9GJzgL6Sb/N7An/fCXPh2jk/aK8YNvQrmDrBeEEUn6xg7ZClYsXRZqQ61gvOn+8r7kD+h6dkojcI+zJpzIkOpycwo91zqAheG071Y5K9mXaNINMxMWQF0DP7LmWyUDHNveqQZ7tx9X+5l2F6oIAT7ts8maA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757877018; c=relaxed/simple;
	bh=HyErwXZjJxtC9lke1N7NrfDdKBhf9mDw543eo29YW8w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mu07KrV0Kqkhds7MNoH+fSZ40rOibnZvPpryETNU7EhQ5N2UWKsLRQDpBARGzgPMxTG1TF7LmcEvA0sfjTCzAi7tMefl9DiXDcC0qNIsPWn3WNlxAXYNyoNbuUxJYzkfI+ndRxviat1TgLJXTc9I6Mv/B1M6XCJE7kHcTSXkqlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1zPJ01d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F437C4CEF0;
	Sun, 14 Sep 2025 19:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757877017;
	bh=HyErwXZjJxtC9lke1N7NrfDdKBhf9mDw543eo29YW8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E1zPJ01dh7kcko3XfxPCXOE0PzCnY3Y+TW/DO9qYP7YofigcyrnOeNJZZYqewjcaA
	 g1yCXHROYGtXy/JbC++uEb1NWs/JlSOJfqLX7JrDG+0/NF1lnaxT1n0HniKXJs734Y
	 NaYz8max6eY8y4xXrgOMtvqcOaXgyVN9rj24O2l1G//UNKAy83cfi9DFA7QrX1ESIw
	 hHXmHNS5/7ePiSnU2aFvKUImBS3tP2Md+MDk17UmqpPUJhIViDwauA8U5ziKQDr5A0
	 dbd4YiCcnMrnR5W9g6Ncykc/hCLXmc6j/iu0aFTdZjuMaa2/InPKkR0D3DLdSXyLMu
	 LheY9KHtjydDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FFC39B167D;
	Sun, 14 Sep 2025 19:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/11] net: stmmac: timestamping/ptp cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175787701925.3530077.1414169170117971537.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 19:10:19 +0000
References: <aMKtV6O0WqlmJFN4@shell.armlinux.org.uk>
In-Reply-To: <aMKtV6O0WqlmJFN4@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 ast@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 sdf@fomichev.me

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Sep 2025 12:07:03 +0100 you wrote:
> Hi,
> 
> This series cleans up the hardware timestamping / PTP initialisation
> and cleanup code in the stmmac driver. Several key points in no
> particular order:
> 
> 1. Golden rule: unregister first, then release resources.
>    stmmac_release_ptp didn't do this.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/11] net: stmmac: ptp: improve handling of aux_ts_lock lifetime
    https://git.kernel.org/netdev/net-next/c/9a1d6fa0012d
  - [net-next,v2,02/11] net: stmmac: disable PTP clock after unregistering PTP
    https://git.kernel.org/netdev/net-next/c/99a8789afd12
  - [net-next,v2,03/11] net: stmmac: fix PTP error cleanup in __stmmac_open()
    https://git.kernel.org/netdev/net-next/c/454bbe5913b2
  - [net-next,v2,04/11] net: stmmac: fix stmmac_xdp_open() clk_ptp_ref error cleanup
    https://git.kernel.org/netdev/net-next/c/586f1aebc9a1
  - [net-next,v2,05/11] net: stmmac: unexport stmmac_init_tstamp_counter()
    https://git.kernel.org/netdev/net-next/c/ff2e19d5690e
  - [net-next,v2,06/11] net: stmmac: add __stmmac_release() to complement __stmmac_open()
    https://git.kernel.org/netdev/net-next/c/67ec43792b11
  - [net-next,v2,07/11] net: stmmac: move stmmac_init_ptp() messages into function
    https://git.kernel.org/netdev/net-next/c/4fbd180acd57
  - [net-next,v2,08/11] net: stmmac: rename stmmac_init_ptp()
    https://git.kernel.org/netdev/net-next/c/b09f58ddc6ca
  - [net-next,v2,09/11] net: stmmac: add stmmac_setup_ptp()
    https://git.kernel.org/netdev/net-next/c/84b994ac4e4e
  - [net-next,v2,10/11] net: stmmac: move PTP support check into stmmac_init_timestamping()
    https://git.kernel.org/netdev/net-next/c/9d5059228c55
  - [net-next,v2,11/11] net: stmmac: move timestamping/ptp init to stmmac_hw_setup() caller
    https://git.kernel.org/netdev/net-next/c/98d8ea566b85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



