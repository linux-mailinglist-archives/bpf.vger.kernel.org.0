Return-Path: <bpf+bounces-22836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C43986A725
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 04:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A751C2378B
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 03:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E415C2032E;
	Wed, 28 Feb 2024 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFGXVGR1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697821EA84;
	Wed, 28 Feb 2024 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709090432; cv=none; b=pGiSL3+O3DFfZClhVQlMMxpJvAoKGrnNSjsuoz+6NKGnvlk5OiktMNri4HfbdfD0jDYNTDJzUi60/qUvRaHrfDgNOMns1Qr2bxE9FpL39huuZxjO2fXKighkvKdSvBmO7LT+RbraaDhYWRZ9Jb8O7zNwuZu23B+p+PF1AJrRB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709090432; c=relaxed/simple;
	bh=G/G1oButwF41ut3ZIuOiyg1G4uJOT5AFCqYpQIx/8FI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RTsAlhCgC6oqCvkzT6B7edFP7YIIPhgb6L2qNVV5VdcaIwRj8IqokRnLgqDYUbKc3pOadAASlp1SGPLj8r2SKuk/C6OECZ0lO33XaUrB7EkRxxejx3JklhOgJ2bnHBx4uWH9wNX/1kcO5t+X3IIy8QRWkjqQ2DdEuANleNqudeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFGXVGR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFF99C433B2;
	Wed, 28 Feb 2024 03:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709090431;
	bh=G/G1oButwF41ut3ZIuOiyg1G4uJOT5AFCqYpQIx/8FI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sFGXVGR1wYleJqY+qqrIVo71LSeSdwb/1YTAi35lxE8h3whwfFabbdMAIRwjR6CLS
	 dvaiYlX7u4HC1EhNssRdjiJTi+PS4Lp1njIUH3H8aYYVXFsncXL5UfSOGZq4NXHcg1
	 jVdDUXmwrNbd3rxR64EGsg1vrkUSlf3KR5yOM2+GaLlMmd9NRzsabrhtuHduQ+/aDO
	 vfjkMP0aPMyMEB38r4505UCe9p5/oVQOlUQtw/Eg5nNkuBt3JczNJeB8H+AZYiLByi
	 TTTS0aep+uT5buqxLHxV67xqJcGc/xM9A8tdijV1vbVfNlgK9s9jm8kLIvH+60jdWw
	 n8m0zrqs8av2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5386D990A8;
	Wed, 28 Feb 2024 03:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: stmmac: Complete meta data only when enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170909043166.27277.9836937383707472245.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 03:20:31 +0000
References: <20240222-stmmac_xdp-v2-1-4beee3a037e4@linutronix.de>
In-Reply-To: <20240222-stmmac_xdp-v2-1-4beee3a037e4@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, yoong.siang.song@intel.com,
 sdf@google.com, maciej.fijalkowski@intel.com, fancer.lancer@gmail.com,
 bigeasy@linutronix.de, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 25 Feb 2024 12:38:37 +0100 you wrote:
> Currently using plain XDP/ZC sockets on stmmac results in a kernel crash:
> 
> |[  255.822584] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> |[...]
> |[  255.822764] Call trace:
> |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: Complete meta data only when enabled
    https://git.kernel.org/netdev/net/c/f72a1994698e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



