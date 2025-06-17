Return-Path: <bpf+bounces-60872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87644ADDF47
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 01:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B02400502
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10217295D85;
	Tue, 17 Jun 2025 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMal2/kG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803C4296150;
	Tue, 17 Jun 2025 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750201203; cv=none; b=D/vw/dYQGgXFsqRxWJ8YvH7hO+QJ0oGwGHD73Y2hpkOA0jLC7PTSVOQkATlukGDumaaJqhgNNW5IQ3F2V0Sohnx6gSWXcAFuA8dyDZhsOjSadAtO4r6r3OvafvQXH8mU/p/p1ZkBRv2/9+2Gu8qy7IeG5M7HNnGM/dHedcHQDjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750201203; c=relaxed/simple;
	bh=eBnpcYHTpCSmU93N+2v6XceuO10N+zsU0JFmZnOplrI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JdJlNazToSlwWIOC3CgokmWWDQXaDSECyhr96kIKXs3/xZTcS/9Gtp4Sjo6DGwoyZ+af4rBCvQrjljtNkYkrL/cGyAXJ6GP1fvatVEVSySSoxt5O4juECtt3kDZMnMs9mJh7+c8mk1KjLG1+eW7lHDGwlNEVZB3guOrSJAEvo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMal2/kG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED55C4CEE3;
	Tue, 17 Jun 2025 23:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750201203;
	bh=eBnpcYHTpCSmU93N+2v6XceuO10N+zsU0JFmZnOplrI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BMal2/kG7p9adfLOYPsFlwx7QJcfAOR/JkzMnAEsvOTCyLuJg0BbFZ3Yhs+uc8bVZ
	 3qULv+TiUD5kWSaPW4zxoSkuuoSuUe25++naDUWIV54nGQjrvWsospg2xts38Q5pyF
	 Ot0ZnMOdXMIS8RIMJ5H6MtAIxgRFGdKpL0CeR18zpQX+ZlUBOtfNJ/cQgQTpRJ0P0B
	 36SKX0suGdi3objtJmAW2A5pcJ7LPLvVP8y+9bs5sGuGy2TjpcK7bxVhIzNxxZpDfX
	 DMTAbbFJVtifnOYfSyUIspcKUqLmr8PJ7KkKwqcULBhbFMqQOYwMzNuRBE7sl2uePG
	 DKDNQbYhAZq1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADED838111DD;
	Tue, 17 Jun 2025 23:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix packet handling for
 XDP_TX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020123150.3727356.10882505957565617518.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 23:00:31 +0000
References: <20250616063319.3347541-1-m-malladi@ti.com>
In-Reply-To: <20250616063319.3347541-1-m-malladi@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: namcao@linutronix.de, john.fastabend@gmail.com, hawk@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 rogerq@kernel.org, danishanwar@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Jun 2025 12:03:19 +0530 you wrote:
> While transmitting XDP frames for XDP_TX, page_pool is
> used to get the DMA buffers (already mapped to the pages)
> and need to be freed/reycled once the transmission is complete.
> This need not be explicitly done by the driver as this is handled
> more gracefully by the xdp driver while returning the xdp frame.
> __xdp_return() frees the XDP memory based on its memory type,
> under which page_pool memory is also handled. This change fixes
> the transmit queue timeout while running XDP_TX.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ti: icssg-prueth: Fix packet handling for XDP_TX
    https://git.kernel.org/netdev/net/c/60524f1d2bdf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



