Return-Path: <bpf+bounces-56875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB7AA9FD00
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 00:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3063B1390
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 22:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D631F211491;
	Mon, 28 Apr 2025 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6bKrC9z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D35620E6EC;
	Mon, 28 Apr 2025 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745878798; cv=none; b=NxI03NgJr6HkWrZe6AvkgfxHY9MNHxpW++JG8XHT0g7V+LRDgJJWmAGJeitLaV/jR//u826H8DWIN91pJMO+1AL3YACdjvohFqAd6v9hV1U6Tfy+wWagUjDdnZ4mLqCh688uc7aVnqQmZKFKHWD9bFNGgX+HSBnW/kwR+OvUWS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745878798; c=relaxed/simple;
	bh=Lahajb51jEfObe1Hyp6/chmzs0TWo8lfU1EyfH2VAgY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=utwwpBCv8Xv/hdbUScnnRrK/CMhfO5qH1TNHX6N/Td4ASfeqoxRjewQlq5Qc+HKJ4uQ2/xbQS2d/fK+3T2xoODtL2rinsLmNBjoRpYHQSbWjCtkEQ33EKBv8J9ThnP5/2LB4RVeXJTON+RabaCeoM4QsRpcbbUIWoHoC3uwJ1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6bKrC9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD0EC4CEE4;
	Mon, 28 Apr 2025 22:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745878797;
	bh=Lahajb51jEfObe1Hyp6/chmzs0TWo8lfU1EyfH2VAgY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y6bKrC9zrywMNQNOy4nFFHbTO4mnCiiv0aDoz5eFkHF9lqtzfX+uYfRI4RnneU/2e
	 WFRjTOO1cArBxKU3PHyiVgTYgdPmlS7+J91kkPoO0+2C3CYv+Fnf56edyvCEM01ZEE
	 BnPJqc6L4DladHKFWT0fAOT5R8yPUXHUNCbjFhfRMa4CM0X9IiQI0I26cuW2RrpQ+k
	 rtSDiFrhPkz6wAS9YsUEobh1QbSwLTFgcj2Q/dc1f2+PRcCvzrtvJSTZPAU8xiNyyJ
	 opPofMxVl7hTRs95W9zUd7vIi2i6/2lSPBGzDgyjffOomp9iG+0y/ObR03A/sk3g8G
	 QmfG/hK3MxzSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD3F3822D43;
	Mon, 28 Apr 2025 22:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V7 0/2] veth: qdisc backpressure and qdisc check
 refactor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174587883648.1063939.13609783923065664545.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 22:20:36 +0000
References: <174559288731.827981.8748257839971869213.stgit@firesoul>
In-Reply-To: <174559288731.827981.8748257839971869213.stgit@firesoul>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, bpf@vger.kernel.org,
 tom@herbertland.com, eric.dumazet@gmail.com, davem@davemloft.net,
 pabeni@redhat.com, toke@toke.dk, dsahern@kernel.org,
 makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com, phil@nwl.cc

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 16:55:25 +0200 you wrote:
> This patch series addresses TX drops seen on veth devices under load,
> particularly when using threaded NAPI, which is our setup in production.
> 
> The root cause is that the NAPI consumer often runs on a different CPU
> than the producer. Combined with scheduling delays or simply slower
> consumption, this increases the chance that the ptr_ring fills up before
> packets are drained, resulting in drops from veth_xmit() (ndo_start_xmit()).
> 
> [...]

Here is the summary with links:
  - [net-next,V7,1/2] net: sched: generalize check for no-queue qdisc on TX queue
    https://git.kernel.org/netdev/net-next/c/34dd0fecaa02
  - [net-next,V7,2/2] veth: apply qdisc backpressure on full ptr_ring to reduce TX drops
    https://git.kernel.org/netdev/net-next/c/dc82a33297fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



