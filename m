Return-Path: <bpf+bounces-36889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EABC94ED05
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 14:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4A8282C08
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 12:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CCC17AE0F;
	Mon, 12 Aug 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBQJV8AK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F3B17A5B5;
	Mon, 12 Aug 2024 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465828; cv=none; b=Vsp2Ar+9IBiVjAndNBgOVm76xJY9Qim4mCTnLd2S9+q12UJqRLxgpnV4+lFqejXskNCG4hTsTwG0aetfcaWCTpaYKrcQsun9vNweJYfNN5qN4LUgJ/GNMg7PotkYfqz5wQOrpIT1IbBsclH8SSd1+/OZh0YJEO5wij/kNiZip1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465828; c=relaxed/simple;
	bh=daslIMI9OAMAvqRfkYqd0A4uF/CVa60AExTLNpeFK9U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ub7uX0geD8JwyP9Z/Tvu65YgOHkC1uGgwZAQBRxCz3FPsbHmKRctK+u8APlxTDKUWeIgyqMgILcY+TYSHBOkdkaY87jzUvgrRSj9tyLSRTu2+6Zi1uTx21BS1IENrVwmsp7hVDZkbeeZUjYadYsTAgXoUBsiKpiJqbwNyq/HON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBQJV8AK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D7CC4AF0E;
	Mon, 12 Aug 2024 12:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723465827;
	bh=daslIMI9OAMAvqRfkYqd0A4uF/CVa60AExTLNpeFK9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cBQJV8AK+rCicBDSwVUri/rjC57zlg2FU2Hx8gttFSiZbrsEfD6tB+v46ULi98a3B
	 Auq5FZWFhsp3F6szggHozl+fNZoELFMCQshx11bfFB/4Z6UW6zVolneZIUCqASx/ko
	 BO6NJAwQH+KYkIYx5HaVAiSXuCaEQHJ3zCnaO1Fwl0MLOehK1YsxytUJLy2VEc1Cvd
	 /oQxRpGpUlYeMbR4oIZQEgF6JHaqms6XbkwXP2eTrSbJmgp/Xux5Jnz2+xYtt1maJq
	 D2FinY154EiDJjXsVkPjO4oQKB2x+208zpGPye8lOCKgOYxEUmi+Do6RXxe13cT0L5
	 jnEUbQ+z6E06w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC8CC382332D;
	Mon, 12 Aug 2024 12:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mana: Fix RX buf alloc_size alignment and atomic op
 panic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172346582650.1009420.18122025004130803028.git-patchwork-notify@kernel.org>
Date: Mon, 12 Aug 2024 12:30:26 +0000
References: <1723237284-7262-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1723237284-7262-1-git-send-email-haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, decui@microsoft.com,
 stephen@networkplumber.org, kys@microsoft.com, paulros@microsoft.com,
 olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net, wei.liu@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, ssengar@linux.microsoft.com,
 linux-rdma@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  9 Aug 2024 14:01:24 -0700 you wrote:
> The MANA driver's RX buffer alloc_size is passed into napi_build_skb() to
> create SKB. skb_shinfo(skb) is located at the end of skb, and its alignment
> is affected by the alloc_size passed into napi_build_skb(). The size needs
> to be aligned properly for better performance and atomic operations.
> Otherwise, on ARM64 CPU, for certain MTU settings like 4000, atomic
> operations may panic on the skb_shinfo(skb)->dataref due to alignment fault.
> 
> [...]

Here is the summary with links:
  - [net] net: mana: Fix RX buf alloc_size alignment and atomic op panic
    https://git.kernel.org/netdev/net/c/32316f676b4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



