Return-Path: <bpf+bounces-44923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1719CD5E1
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 04:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B8F1F22170
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 03:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FF6170A13;
	Fri, 15 Nov 2024 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAm5z0c9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F5516DC01;
	Fri, 15 Nov 2024 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731641425; cv=none; b=or6TgZVewbwWRQbw2wrVN3LeUntrLcRYmfqHqIunv0nlIWVqLHeVpA2ie8TQXRCMluTTyyg19fan/sSDl6b7jwlBhrkuWQUfRPP7CE7tfwm8Xohx6+95sYM4LVG+jjC8SoPaGTjMpOC7KP6/EZc0JXNyJreir3zPBL66EI3J0dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731641425; c=relaxed/simple;
	bh=Py9vnXsgiVyuBBqGgunlukHcQ6tS6uAdDLyvGN20wDg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EZ/7Ma96laDn2BgtZOo7ELXHpWgqQJT+mZ6c4fk6aXNTisay1eV162mvFMizWw5oHqHM4/9n+PCTn23W9Hpzarbo3+kWW9bJhOPPGlUiQUAQaU1T7ZpqzfcWtJNDMP7aM2XtaPB+8CQ1xuxRFVbzvw1AxRU5d1MQ+Kf9yS/tAyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAm5z0c9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E36C4CED0;
	Fri, 15 Nov 2024 03:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731641425;
	bh=Py9vnXsgiVyuBBqGgunlukHcQ6tS6uAdDLyvGN20wDg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pAm5z0c9wFxMHN/9UgKKNqUUt188rkwO4QCH4ZAX+/CMbeUTmVIgM1dSyVy2vdSlh
	 /pmK6qJYL0i44reiWLbuqxcBdXymnU+5XUBjzuGAjYrwtreLDKuG9zxRMX5DdyNsV2
	 JK9bO+jfqQGyNE+K125eMpsEHyW3lN9loB3CIuSB/9WteJqsBM4AzPF8sAAIRyiM/0
	 341LLIoOmv8v1B8dgwLf5Z56QIuodVE8rSncbojNnheNdoZPS69Ne7NvaDKPJp5L2X
	 JntzOkTdxL99IyU0b/eloevS5CJeZUzu1kkQlvcdCeyuRNeCqfGD6XgjsJcfGPYIX8
	 WWNL1KtrgBhsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BCB3809A80;
	Fri, 15 Nov 2024 03:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-11-14
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173164143599.2139249.221234838078018840.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 03:30:35 +0000
References: <20241114202832.3187927-1-martin.lau@linux.dev>
In-Reply-To: <20241114202832.3187927-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 12:28:32 -0800 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 9 non-merge commits during the last 4 day(s) which contain
> a total of 3 files changed, 226 insertions(+), 84 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-11-14
    https://git.kernel.org/netdev/net-next/c/55c8590129b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



