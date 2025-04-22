Return-Path: <bpf+bounces-56382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5320A963B2
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 11:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDC61885F8E
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 09:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BE21F03F2;
	Tue, 22 Apr 2025 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G72da2Xe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BB822A7E9;
	Tue, 22 Apr 2025 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745312966; cv=none; b=oFBRlmBG8wtWsLGLwaZXT7RN+hw71961vW/Mx4NsI7mgNojObwBoEdwXHVaeLp59HCH8d+MCcq6asEFl5535BBpjplqPb+IF0C+KXqqiKhCsqh8Py6ZmK7iKlumHmXBFd10wlD1iNrZ3zt+dm+9aqs2K3rNVpc/MxddjTHMIutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745312966; c=relaxed/simple;
	bh=mFSwkrwc/woqReWcRrFiToGptgj6JqGT5qUZ8w0yzC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j58kxJsbk9HroLgzEQfq6v5avm3Sz+5dzMajFpC2KWiWxeUABJ+aIVySjLc7ShXpa8Zwm4egY7N8TEoVEJXlidsxb9OrfIKybIP035QNxiwJuKbL/7rl4ze3IXdJ2WnLRTaTOExc13OX1GpBv+oqUrjGGZMLmXBlXfmWLbJFfMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G72da2Xe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839B6C4CEE9;
	Tue, 22 Apr 2025 09:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745312966;
	bh=mFSwkrwc/woqReWcRrFiToGptgj6JqGT5qUZ8w0yzC4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G72da2XeldJj1UW6a12w3l89rBt7tfbC0GAHsKxGXq5cDoel8/3end4ShFVgDGk7F
	 R7tui1x9mW/eg82FVn7oCpOUm0ubFuN3zWlMjXzuAykDXexnl25q9XA2bkFX5Faxj4
	 UOXSS2jExqUda3NcBOYo3eUs0NLboTEMu5DiRcEbP2xUSkyXvPKRBQTpIcLGzjPiW8
	 FTlSp7RK1PT1ZWJqou2Yuo9r2L0GR98AP1h7NLEgg+JMat4+oHejT86yefa//T9LEa
	 WzivRLcXqyMI2db7VfjL5jOzYAc7sSOIZQqpjK2ADlkmk/3LdE3GZDTKi/Hm8VgDqx
	 Vgo59FAFX7Qbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DD739D6546;
	Tue, 22 Apr 2025 09:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] ENETC bug fixes for bpf_xdp_adjust_head() and
 bpf_xdp_adjust_tail()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174531300475.1477965.2995189751191314193.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:10:04 +0000
References: <20250417120005.3288549-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250417120005.3288549-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, vlatko.markovikj@etas.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, lorenzo@kernel.org, toke@redhat.com,
 aleksander.lobakin@intel.com, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 15:00:02 +0300 you wrote:
> It has been reported that on the ENETC driver, bpf_xdp_adjust_head()
> and bpf_xdp_adjust_tail() are broken in combination with the XDP_PASS
> verdict. I have constructed a series a simple XDP programs and tested
> with various packet sizes and confirmed that this is the case.
> 
> Patch 3/3 fixes the core issue, which is that the sk_buff created on
> XDP_PASS is created by the driver as if XDP never ran, but in fact the
> geometry needs to be adjusted according to the delta applied by the
> program on the original xdp_buff. It depends on commit 539c1fba1ac7
> ("xdp: add generic xdp_build_skb_from_buff()") which is not available in
> "stable" but perhaps should be.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net: enetc: register XDP RX queues with frag_size
    https://git.kernel.org/netdev/net/c/2768b2e2f7d2
  - [net,2/3] net: enetc: refactor bulk flipping of RX buffers to separate function
    https://git.kernel.org/netdev/net/c/1d587faa5be7
  - [net,3/3] net: enetc: fix frame corruption on bpf_xdp_adjust_head/tail() and XDP_PASS
    https://git.kernel.org/netdev/net/c/020f0c8b3d39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



