Return-Path: <bpf+bounces-58792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7902DAC1806
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 01:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8CFA27833
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C953255F4A;
	Thu, 22 May 2025 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1n0tcJo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5A32494C2;
	Thu, 22 May 2025 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956594; cv=none; b=gpwxUjG2R2PjSIpso9X5gHIXI964qADvK2ccW5Jyz6DYrDdbQ7fTkrabrVaCpOgxdQhqdjGaC/aUWwOCK9BAewS7yzmXZuwFz2lGKeYT1ZGgWaQaD1OHVrso+PV37v2nbuqxXwh7fJ9XF2TkKCZUT0aq3sFolFRoFxAZTcIpd/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956594; c=relaxed/simple;
	bh=MeW5pPhQF1xCw2S1LWnR5gWs0b7UH9jyUgcMQW/u9xw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ih/6Lx5ZHZCbaKm2qSDWNsz87qYSNV8YEwhyVILYI/mkLPFUzO8c2ehi7bCaLZb7VOb3BPb7+/xV96xLtx7zJreZjZLaJRSf9qO1jhVSqV/HjB8wSvyKsWKArco9RJa1YdFSfCMOG61v55ULdjoAMPhPp4YEtVYQk/YjNE5BGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1n0tcJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888F1C4CEE4;
	Thu, 22 May 2025 23:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956594;
	bh=MeW5pPhQF1xCw2S1LWnR5gWs0b7UH9jyUgcMQW/u9xw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L1n0tcJoXwmHWEJJQC0Esuv71dNsTQGeGrrJNbXnjjGFNeISTw4EcsIdJ8f/4VcK8
	 6ZOXfAP7fNcmx0U/FxOeHi7DfXXZRCtQgm9hjo9PbpHtVOHJowYMgBNH50c4EBdJnQ
	 I03ZMxSgbYHc5mn6+onXtz+AH0PURnWe05iXkGJ+QjlnJHnsbutbUnnfj0dXI8Fzo6
	 vjff5WDwDvixjSd7ZAEDNPGloEir/01fHgB+M9CB619sxmyJpQuwLq/u+ePUBJy3xR
	 zLxwyFMjKQrGJA21SDYJAsQKTNTCsox9IpjUhPQLNymlBBKGfE+1Y09zSS+7xAMIig
	 FXeu1YfSDziLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EF23805D89;
	Thu, 22 May 2025 23:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6] bpf,
 sockmap: avoid using sk_socket after free when sending
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174795663002.3054474.9274449552031955126.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 23:30:30 +0000
References: <20250516141713.291150-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250516141713.291150-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, mhal@rbox.co, john.fastabend@gmail.com,
 jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, cascardo@igalia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 16 May 2025 22:17:12 +0800 you wrote:
> The sk->sk_socket is not locked or referenced in backlog thread, and
> during the call to skb_send_sock(), there is a race condition with
> the release of sk_socket. All types of sockets(tcp/udp/unix/vsock)
> will be affected.
> 
> Race conditions:
> '''
> CPU0                               CPU1
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6] bpf, sockmap: avoid using sk_socket after free when sending
    https://git.kernel.org/bpf/bpf-next/c/8259eb0e06d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



