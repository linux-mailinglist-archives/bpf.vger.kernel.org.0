Return-Path: <bpf+bounces-71483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178FDBF4308
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 02:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2DE3ADA15
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 00:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAF82264A0;
	Tue, 21 Oct 2025 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hImnxlmm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550CC21ABA2;
	Tue, 21 Oct 2025 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007829; cv=none; b=Y4Z5tNTGOVmZbCbFlXnBsvOS9xbQWZj6St2HbCTouKiu+dy3JNE7Nlmeg9LC9Kxh916KBaNMXklu0fSD9GsFdZZ4tQIKJIbAdiLfCSvny+Ojb5gH+lMDi6ZiB6/p38nrQKeQomMrpOyLXVNAfY8Er3m/UldwLQd9rs9h3z7SyH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007829; c=relaxed/simple;
	bh=bzmcmedR+/oRYhh3Nqj00XK2dASrP5tyVfaCA9zCadU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FzNPe7qNYcR9K8dp5RIL1PjbBJuOziPZEXYuK+l9y44+kNC92cwVSHnkn4y7R9hHTlsIUbO4xCfQOtt7zXbM1xjr4KqQYA7BquNnJ3auA5Mhtlcfj84p0xPSymsYCgsEH9+F3NPJQI+4yRhQwG0ruMUHE8JI9Oph6gUsnyaWmRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hImnxlmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DEAC113D0;
	Tue, 21 Oct 2025 00:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761007828;
	bh=bzmcmedR+/oRYhh3Nqj00XK2dASrP5tyVfaCA9zCadU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hImnxlmmxo7CdP2ALHohtKNXez9qHzTZEBw3nzNpFiX7j0WUK6QPxm34Yn3e51T9j
	 hATUnmFSddkFEb9muf5s1tt4QZAgau6Ea5OArEOuaZiN2B2cafD/puKSclEWS9jTHF
	 AfhR/A8UGoRVYwdGw4LqOOQg78LDP0R/R3tM2qEZthSaLcIqmN/ZrxNJdTM8kGaPU1
	 Z4wHkCdfOY21X2kGvs3XHT5DqeChVJBhm+oMi7if9VOdT0eDkviDKrxvoOOuWSS9/l
	 R4TQrQEFSkBGykuB9/aUx4+O4XXBgJtZSbyOFGbOBVIcV1PUBIVOZtg4J5wAV8sJEg
	 6uh7y/jxVRy1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0B13A4102D;
	Tue, 21 Oct 2025 00:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V3 0/2] Fix generating skb from non-linear xdp_buff
 for
 mlx5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176100781074.473459.8876799932189706217.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 00:50:10 +0000
References: <1760644540-899148-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1760644540-899148-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, gal@nvidia.com, moshe@nvidia.com, dtatulea@nvidia.com,
 ameryhung@gmail.com, martin.lau@kernel.org, noren@nvidia.com,
 cpaasch@openai.com, kernel-team@meta.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Oct 2025 22:55:38 +0300 you wrote:
> v3
>  - checkpatch fixes
> 
> v2
>  - Simplify truesize calculation (Tariq)
>  - Narrow the scope of local variables (Tariq)
>  - Make truesize adjustment conditional (Tariq)
> 
> [...]

Here is the summary with links:
  - [net,V3,1/2] net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for legacy RQ
    https://git.kernel.org/netdev/net/c/afd5ba577c10
  - [net,V3,2/2] net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for striding RQ
    https://git.kernel.org/netdev/net/c/87bcef158ac1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



