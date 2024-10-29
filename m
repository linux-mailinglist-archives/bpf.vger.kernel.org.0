Return-Path: <bpf+bounces-43399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 029D99B514F
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 18:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3BD1F24A32
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFE61DC068;
	Tue, 29 Oct 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwh2zoV3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92F6196D9D;
	Tue, 29 Oct 2024 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224221; cv=none; b=GFwIxNvz0xQ9OsifQIGwq2F9MjxfhhojcM7LcPgN1uXExA/krWJhG54VLRbHx6sBz9hST1ZXpEzQDYMENTQblKcyvv6UaFD2unCB/Q1ajiA80ZkQhY2UVyfrgXCZYq10kS7M3UAQY3DCE6kXYHCs6nsTq8/uArN4MFQtcUUbqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224221; c=relaxed/simple;
	bh=8Fau3lPqblwysCShZlOT2FMXP/dIssBCVTNO20d02fg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QBhz9Cz1WrXwU/fFQDW8mkL+xgX/jc+j5PJeWjZeeCon26XJs7VpWG1cU8FmHv1I5eWp5DM6xaZzWUnAlr7PezNWh7YTq0Eo9yAOpA42/rcdmqR0vMszENhwLY/41ku/T9EYO3hNTHBIAnnts2smOupVB6L6hSqXyrQMy2C1oRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwh2zoV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DD2C4CECD;
	Tue, 29 Oct 2024 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730224220;
	bh=8Fau3lPqblwysCShZlOT2FMXP/dIssBCVTNO20d02fg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rwh2zoV3PCWXuTMPix9zeYWS2+n+I1pCxOwQ1SFlMQijSkN+TawobxLtwnTaxSJbN
	 fue5UIHnlJYc6rjWeURruTioOt9B0KsXM2lktyxivjvL4+y6yAxW6H/kDIhHpEM7Y4
	 UqsCK3YQ+XjHCaOeP61C1SBvUFl3WXpFLavWFwnGeiMrQntk2jSPi9/WvVprcav2ga
	 lxkblRfV2bRQWZpcytq7v1TPjh4IDBJ4cXsDnhNKnvJ8Vk4gBhnxxHnQeqvRccmIyB
	 Jb7lquNd8JCZWiC9hz0cWUEDODVMUMhYaVKsnexD9aeZF7a7DE6xjnfZY6SMOvpbat
	 ERQ0nFtCHZqww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E19380AC08;
	Tue, 29 Oct 2024 17:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf: fix filed access without lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022422800.772061.4721556452097618907.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 17:50:28 +0000
References: <20241028065226.35568-1-mrpre@163.com>
In-Reply-To: <20241028065226.35568-1-mrpre@163.com>
To: mrpre <mrpre@163.com>
Cc: xiyou.wangcong@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, edumazet@google.com, jakub@cloudflare.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 28 Oct 2024 14:52:26 +0800 you wrote:
> The tcp_bpf_recvmsg_parser() function, running in user context,
> retrieves seq_copied from tcp_sk without holding the socket lock, and
> stores it in a local variable seq. However, the softirq context can
> modify tcp_sk->seq_copied concurrently, for example, n tcp_read_sock().
> 
> As a result, the seq value is stale when it is assigned back to
> tcp_sk->copied_seq at the end of tcp_bpf_recvmsg_parser(), leading to
> incorrect behavior.
> 
> [...]

Here is the summary with links:
  - [v2] bpf: fix filed access without lock
    https://git.kernel.org/bpf/bpf/c/2ce9abd6e1e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



