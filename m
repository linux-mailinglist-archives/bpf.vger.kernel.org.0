Return-Path: <bpf+bounces-39816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69450977CBE
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 12:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC2B281F0C
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 10:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FA41D7E3C;
	Fri, 13 Sep 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUN5AZyR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132B042AB0;
	Fri, 13 Sep 2024 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221636; cv=none; b=NHAxI17ZjntrTqMszw2CJBNF7GJILQx9DNRpKoTz2g7vndpuWxLTYwaIo9CCXvL73lvfjtycFcHNo0EpbnsuRyWwasw8ABOr5l1ETBnNUKp0GIlYHj49A3b3PJoRx7WgNwZPTWYD3lx5uNoaEyHwO3mmJQ2yt/ylO2eWYeUDarg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221636; c=relaxed/simple;
	bh=WhuIWQzoLBX9it0DI5Fpwm2hnpFhkxt35Dwh1mTwbvw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aSo83tF6IhWdW79Vy81H0yXI9WfGYttwWOERIg9RlTMm3JkDwNnvjRY9kauU0ikF1kLht2LRAcgGgVRoqxZo3zmAXiW/vLguyOQb+ahFRHcTnAdk8cXRNk1418GknGh+JaoVpHj5cdajIZfbzJdPON9rLbrTXZlnx67qCN0nzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUN5AZyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86623C4CEC0;
	Fri, 13 Sep 2024 10:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726221634;
	bh=WhuIWQzoLBX9it0DI5Fpwm2hnpFhkxt35Dwh1mTwbvw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MUN5AZyR2zLsmdmnutZWC14FBD1Y5PNmz0vM7HHTCpZ1SMI26eWUYSb1xlxDQgxhF
	 Lxkd2P9OXYPZ9mTskiSDA4nPva7vgMaCsEClW3Kk5f32WiSNrGrgpF4GoZu00LThIv
	 HKBPgL8NHSCzhxEudwAjBQi96+ASB0nMJVdQCOtLeGSEO3kCXdPwLeyk1iIGyHa13L
	 hLK7CrG/Jn+bQZEWyiUQOII52X+ZXUe1DutUsT+9MISM778xIWX6NHx48ZpgGPq5ch
	 59N1FfAmgg4CRRq2jkP6z2PYzOtn6e+qsThkuhXTQRDSHgotyiH+ENPD0L5P6n/bed
	 7URqdRKYAnPTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECECA3806644;
	Fri, 13 Sep 2024 10:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/6] net: ethernet: ti: am65-cpsw: Add multi
 queue RX support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172622163550.2181261.13716711151965173829.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 10:00:35 +0000
References: <20240910-am65-cpsw-multi-rx-v4-0-077fa6403043@kernel.org>
In-Reply-To: <20240910-am65-cpsw-multi-rx-v4-0-077fa6403043@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, s-vadapalli@ti.com, jpanis@baylibre.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 horms@kernel.org, andrew@lunn.ch, jdamato@fastly.com, srk@ti.com,
 vigneshr@ti.com, danishanwar@ti.com, p-varis@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 10 Sep 2024 12:23:57 +0300 you wrote:
> Hi,
> 
> am65-cpsw can support up to 8 queues at Rx. So far we have
> been using only one queue (i.e. default flow) for all RX traffic.
> 
> This series adds multi-queue support. The driver starts with
> 1 RX queue by default. User can increase the RX queues via ethtool,
> e.g. 'ethtool -L ethx rx <N>'
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/6] net: ethernet: ti: am65-cpsw: Introduce multi queue Rx
    https://git.kernel.org/netdev/net-next/c/da70d184a8c3
  - [net-next,v4,2/6] net: ethernet: ti: cpsw_ale: use regfields for ALE registers
    https://git.kernel.org/netdev/net-next/c/bbfc7e2b9ebe
  - [net-next,v4,3/6] net: ethernet: ti: cpsw_ale: use regfields for number of Entries and Policers
    https://git.kernel.org/netdev/net-next/c/11cbcfeaa79e
  - [net-next,v4,4/6] net: ethernet: ti: cpsw_ale: add Policer and Thread control register fields
    https://git.kernel.org/netdev/net-next/c/eb41dd76abce
  - [net-next,v4,5/6] net: ethernet: ti: cpsw_ale: add policer/classifier helpers and setup defaults
    https://git.kernel.org/netdev/net-next/c/961d4187c702
  - [net-next,v4,6/6] net: ethernet: ti: am65-cpsw: setup priority to flow mapping
    https://git.kernel.org/netdev/net-next/c/b7468c0fe148

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



