Return-Path: <bpf+bounces-65098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48501B1BE2E
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 03:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 781CC7A73AB
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 01:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F99165F16;
	Wed,  6 Aug 2025 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDrN3ZD1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CF72E36E7;
	Wed,  6 Aug 2025 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442592; cv=none; b=nR5yB0RGdqduJFFQleNsOIVOCz3C+J18AXVfguHA4YTUcrBVcgBfooJhx0svpDfsRZk+xnZwk+7yxyhAMKUwSeFP7EBCd4bHn4wX5ERklNGt87uQKCzV9nC0Et2ZhDVySDHk3gAgSEzhO2SGmaKlzr8KPrz71pBqD0mOpErPcPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442592; c=relaxed/simple;
	bh=3tS+wAYkpgkrdZK8wc8gi2qjSh3qJT1gxLr9GvDEwzk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LKI8R0k1T1cc23NE9hbRW1H2puER15WsvXrNqvLjY7B6fmpczUrvQC4y3s04j7mbz2mFulA5k5IsF0s3v/OaA6GqKglp82B9nHyC2xUhMXVFUDwl0bwOqKqTcYAfXrEAhrrydbqZ3j1J5Pc4KNYoVv6fZccnvOiheNx8QBW74SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDrN3ZD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DB8C4CEF0;
	Wed,  6 Aug 2025 01:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754442591;
	bh=3tS+wAYkpgkrdZK8wc8gi2qjSh3qJT1gxLr9GvDEwzk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dDrN3ZD1bGqoaFM+Gf+3bitCrKEpCCziRcLWeryBJwSEb3gBFROAzfP7KEw6BUv9N
	 ZaofsK6a6POIWdPqaNSQbNOWElYwXhspku7WSGmpqHAD0jeXSHA7Te4XwjwoqCJwol
	 cJiQhZuqvglmb1YjOOmWzXjm6MTKYbY4EgRl8xQbnp+AM4zDkJzdcseRSdrRNmkt3X
	 vB4YwtVq8mkzBTGdo/isbMLj4QFZ93x6m1ew8GsjOFsRz0nXaHU4vhRJ37imxv0g49
	 754KDDnuqM0cR4RX6pZOSdezTj9+W6lNsBgpgRuyPSZdNMfdZfATdAG2Y7J39r7Wvn
	 5wvltn+iaZYHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB1383BF63;
	Wed,  6 Aug 2025 01:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix skb handling for
 XDP_PASS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175444260551.2227515.8563697587474144829.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 01:10:05 +0000
References: <20250803180216.3569139-1-m-malladi@ti.com>
In-Reply-To: <20250803180216.3569139-1-m-malladi@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: namcao@linutronix.de, r-gunasekaran@ti.com, jacob.e.keller@intel.com,
 sdf@fomichev.me, john.fastabend@gmail.com, hawk@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 rogerq@kernel.org, danishanwar@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 3 Aug 2025 23:32:16 +0530 you wrote:
> emac_rx_packet() is a common function for handling traffic
> for both xdp and non-xdp use cases. Use common logic for
> handling skb with or without xdp to prevent any incorrect
> packet processing. This patch fixes ping working with
> XDP_PASS for icssg driver.
> 
> Fixes: 62aa3246f4623 ("net: ti: icssg-prueth: Add XDP support")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ti: icssg-prueth: Fix skb handling for XDP_PASS
    https://git.kernel.org/netdev/net/c/d942fe13f72b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



