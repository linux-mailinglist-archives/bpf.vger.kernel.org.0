Return-Path: <bpf+bounces-36203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905C6943FCB
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 03:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18481C20372
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 01:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D8B3A1B6;
	Thu,  1 Aug 2024 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBsdbE7y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53982D7A8;
	Thu,  1 Aug 2024 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722473432; cv=none; b=pImAK2dPvJ4tFVsLjcr6+PHoFInKY21LTFcLJOdRyrTPy1dqNRQIXjNLl2lfp/5BG8VTYq6WREpoofU4os+kdQZ2Du6IOviypmx38htejdhPknC1XyqFVqDcq79k3Iol3HoCzZ0jmemNqeXzdlsCjRicMaFxt3eQPr9n+IlUfbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722473432; c=relaxed/simple;
	bh=hUCmHDHln5FmaSza9s94M/ZS+65Tu8W5FdeKsl+HQz0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f7WPlDdX7KwyDTXxE8VtUGQA6B80iX9KAJSla+XuL0GdXN0R/KIUpnebk+LBpvqm3WrXkUtenv9SX1WDgVrUBGS6/38t1oux2/QxUtUBi3kIMtNDzNCUJ1kKnY9Rr0h4gaiJI/lngyvphQYBUThSbo01Gh8V2nnF5bxEA3LA4L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBsdbE7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20CF5C4AF0E;
	Thu,  1 Aug 2024 00:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722473432;
	bh=hUCmHDHln5FmaSza9s94M/ZS+65Tu8W5FdeKsl+HQz0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lBsdbE7y7mrRhPW5L0fbqw6Fig2qBQhotlYhhAK20+NQ53yLevmgRHZb0l21JbDGZ
	 r9TvhMR8cQfJsilZMXk0QFPS0H4vaLLeKfwe51w4z6+HVlGeVcFXT2FO+iYXool/qo
	 NmnBQA5uT+ALL+gkLj71Cbdy3gAKEtzxmd8ZLMtwNw7AfXM1fZ1uTx2ruP1fqj8/+x
	 PL+oVzla7OG6N3hVji5bgSC6uFM0Sf+DjMC+XJhkEeUNRLpBxzGKQ6aYYdDGK4noqD
	 SUjC9qohu1QOTvM7cBfZM/WsMcC4IIdaKIYkKc4qXG8xBNweqLCUJf2ypuyn/nbY9G
	 +bOT7Hmu8mgcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11F0EC4332F;
	Thu,  1 Aug 2024 00:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2024-07-31
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172247343207.10818.7355552776863243243.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 00:50:32 +0000
References: <20240731115706.19677-1-daniel@iogearbox.net>
In-Reply-To: <20240731115706.19677-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Jul 2024 13:57:06 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 2 non-merge commits during the last 2 day(s) which contain
> a total of 2 files changed, 2 insertions(+), 2 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2024-07-31
    https://git.kernel.org/netdev/net/c/601df205896d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



