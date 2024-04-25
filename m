Return-Path: <bpf+bounces-27793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C2F8B1C5E
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 10:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3368282FCA
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 08:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817C66EB51;
	Thu, 25 Apr 2024 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBzLtcdP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CB16CDBF;
	Thu, 25 Apr 2024 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032028; cv=none; b=sR6YWMuAMo9TQAdx6sVrcnkBy/ZsfpLcdHTkRk2r6UllAfAxVGu1m/L2Y8suAo7wAdXifpmfWtKf/iyHdpGTGxoywEKrnpL80GtrH8jyZa6N3FX3HQddA13f6g5894HtIotEegktc8Shu2r+Md/P0BEIGqMV8axUwsPVJ/cnACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032028; c=relaxed/simple;
	bh=ptjAnjo4tFXKMp06ugTvfSuexjaunMRo+HICTqz+l5A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lIGPcaiRLvtJmloht1Ysr0CcYsOE7zye7O7PXFy5aoIpZ26grXf+1cZzBGhaOSkzjlmtqNV0QKxNjFjRF46zWMk2HBrBo72KZzJWD6bno18acEtTXihYwYTSXQ5WmkOOHNxjmB1NP9KbObDNADP8jP51e+0zwHI5upQUEVA4PpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBzLtcdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83254C2BD11;
	Thu, 25 Apr 2024 08:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714032027;
	bh=ptjAnjo4tFXKMp06ugTvfSuexjaunMRo+HICTqz+l5A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tBzLtcdP1/Lr9qAU24yu0IcON76IP8KIUoXSRT7ExXpQVgEDEWQmvIjVpDclxeMt1
	 cAWzCyUAz7uGR5dQyAmn87PgYBQwbgft09LzJSKkyz2aL9i37rHiydA5+FVOLA2xiG
	 hcbwAoYK4EEkGD5o4OqfAXyKpjB8OaTWocvmB3TvNEgT2H1z5Vmb8YfLpdbgQJ+8Fp
	 qdYlo67A3Dw/+kt3owCiRng9RX32bufpevjvhwQghRQbOD817wHwyK34tIvyeV30SF
	 crtTpCUHEAjalptCcpmPzRjt5g2Ucd09bbmtog7nW8SJ7nxgiMcXuWgBHJSlL+5fCA
	 mQLOZPzYZlkgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D843C43140;
	Thu, 25 Apr 2024 08:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] tcp: update TCPCB_EVER_RETRANS after
 trace_tcp_retransmit_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171403202744.24256.9216557508325738302.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 08:00:27 +0000
References: <20240421042009.28046-1-lulie@linux.alibaba.com>
In-Reply-To: <20240421042009.28046-1-lulie@linux.alibaba.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, edumazet@google.com,
 davem@davemloft.net, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, xuanzhuo@linux.alibaba.com, fred.cc@alibaba-inc.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 21 Apr 2024 12:20:07 +0800 you wrote:
> Move TCPCB_EVER_RETRANS updating after the trace_tcp_retransmit_skb()
> in __tcp_retransmit_skb(), and then we are aware of whether the skb has
> ever been retransmitted in this tracepoint. This can be used, e.g., to get
> retransmission efficiency by counting skbs w/ and w/o TCPCB_EVER_RETRANS
> (through bpf tracing programs).
> 
> For this purpose, TCPCB_EVER_RETRANS is also needed to be exposed to bpf.
> Previously, the flags are defined as macros in struct tcp_skb_cb. I moved them
> out into a new enum, and then they can be accessed with vmlinux.h.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] tcp: move tcp_skb_cb->sacked flags to enum
    https://git.kernel.org/netdev/net-next/c/14b5fb2145ca
  - [net-next,2/2] tcp: update sacked after tracepoint in __tcp_retransmit_skb
    https://git.kernel.org/netdev/net-next/c/2bf90a57f0e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



