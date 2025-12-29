Return-Path: <bpf+bounces-77472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CA9CE7AF8
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 17:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C69D6302E062
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918A532FA36;
	Mon, 29 Dec 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESIE5I3D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAFF32F741;
	Mon, 29 Dec 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767026604; cv=none; b=BVQ1FOaALvKLyN39P5N8zM4n9OAkdUZ0NykMXyaUzS8c2J98P1gtXBbZ7c9GMEhjhADMI4FOR1v61FZXfICpSnHKIQZmCJ3+sL8PUT7AvLxF76z2YkoDb4c9RFt52gGUuc8fyfPCSFtdborNbdPSNi2GxCwKa5PUxY9F004I+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767026604; c=relaxed/simple;
	bh=lnxWlId6PQ4och+lJMqlnXFu7vv7RTBCRW9v7SAjrAw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AiM6cB/3cs4FRvpuqNyN9IY9Vovl5wsB8bgHdmmCrpqQOZ30CVQrFrN5SUoujY24unIqrKWmkIZhae10eFljzl7uLEv/gGTCfj2GHsL85cOOCHdZoqtGI7Tuj89MEPA+Psxb9KY9oSnkhEMCPBKiU8rKNEh5GpQgg1w46iUgbmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESIE5I3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6683DC4CEF7;
	Mon, 29 Dec 2025 16:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767026603;
	bh=lnxWlId6PQ4och+lJMqlnXFu7vv7RTBCRW9v7SAjrAw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ESIE5I3D4iCVueW0ZOTmyF5JoDd4C/Y64q8wc4ZoqPn8wHI3MKG9a8LsB5mQ6wylG
	 0NGjl4SvV/TuAJ0/O6e2IZOWObzK4fNNbsUxr2G0zQNcLiZ1fNt9im0+ViUGN3zdBY
	 OPLN9LRIFOozLmpN0Inwdn86KpgAa0mkjuHMME0FGyydwH3jFegS7GeVlpfCba8WDe
	 C/G27X7lfv5+nw+klTFAgAS/LNwrCVLMMu2NilvlHEXBDdyltmHTZx0IhsmMH4fsGW
	 8ltZKP7o6oqMhyzV2yoEDYQGqlNeQsBpvfm82YMlWwfGuMzCJy2zXul57aIniQdt2S
	 0rh58ElxoMBZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B7C63808200;
	Mon, 29 Dec 2025 16:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: fix the crash issue for zero copy XDP_TX
 action
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176702640604.3003866.8845654519033252561.git-patchwork-notify@kernel.org>
Date: Mon, 29 Dec 2025 16:40:06 +0000
References: <20251204071332.1907111-1-wei.fang@nxp.com>
In-Reply-To: <20251204071332.1907111-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 rmk+kernel@armlinux.org.uk, 0x1207@gmail.com, hayashi.kunihiko@socionext.com,
 vladimir.oltean@nxp.com, boon.leong.ong@intel.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  4 Dec 2025 15:13:32 +0800 you wrote:
> There is a crash issue when running zero copy XDP_TX action, the crash
> log is shown below.
> 
> [  216.122464] Unable to handle kernel paging request at virtual address fffeffff80000000
> [  216.187524] Internal error: Oops: 0000000096000144 [#1]  SMP
> [  216.301694] Call trace:
> [  216.304130]  dcache_clean_poc+0x20/0x38 (P)
> [  216.308308]  __dma_sync_single_for_device+0x1bc/0x1e0
> [  216.313351]  stmmac_xdp_xmit_xdpf+0x354/0x400
> [  216.317701]  __stmmac_xdp_run_prog+0x164/0x368
> [  216.322139]  stmmac_napi_poll_rxtx+0xba8/0xf00
> [  216.326576]  __napi_poll+0x40/0x218
> [  216.408054] Kernel panic - not syncing: Oops: Fatal exception in interrupt
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: fix the crash issue for zero copy XDP_TX action
    https://git.kernel.org/netdev/net/c/a48e23221000

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



