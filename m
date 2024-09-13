Return-Path: <bpf+bounces-39793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A69977760
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 05:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118851F25679
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 03:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812F01BAEFC;
	Fri, 13 Sep 2024 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOMURo+1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4C1FBA;
	Fri, 13 Sep 2024 03:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726198232; cv=none; b=XE33C98z/JePFs8ZsmfgJejcrtAst2xchrQKi+rAicZXnPjrCPjW/JALmZnzWoSRjxyLqTSw1h7JST/YJeElYzYqCsR2meG66HBmol3g8ll8q/tfWe+8KkWO6BB+TvEbWmIpcdEw29Lo1WIJsv9Xye3xmoVnLB3LFCjEhpXzu/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726198232; c=relaxed/simple;
	bh=PQnqM5o2gj/H+l8XTzQHEQijA+RA3up3dtAWGSg6/+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rq1MAK7bvvBM3KUr+FQbjLLHYgaxbryStTmu9VLYR42ppdfh6lSWxvIuZd4AsaBoL1T/KJjjtL4LYgAso+22IUfgaYhWsk8r3dnLjuDOuHc34Gw3rxsP73DFxI4Z+he1wQjRXiSmWyww8mcdTuwUkPjW2NGStn4fcLxMydIabrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOMURo+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5ECFC4CEC3;
	Fri, 13 Sep 2024 03:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726198230;
	bh=PQnqM5o2gj/H+l8XTzQHEQijA+RA3up3dtAWGSg6/+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YOMURo+17mUpINP/D+K0TPJYSEh9LZBGYvKFk2xuMxxQAgt7b+J9e58VNUfrVw+W6
	 iNxEikfpFHAreJCvvL+SWH/RHR7Ew8iZO4uEL1aFfiqsNQvLxobBEFAt8jkg1QpbND
	 LqYNcFgBIjMtsPa0DR0qvjGZP4hbbDDCwJlnLfG8FrQ1OMyAoyYemSzxO0kiwWA7oO
	 tJgjrXhkoAR1vSkU1h//XBOvxPKNDwBRlrdeRiTHFyi6TC1MgKUI//v4Tw7Fy31UdT
	 wlT/K78roppMhNx6qL8Fw4LKt9DcCqJ8QYUOkspHj7Upi1xfu/vHmE0F8vDbke636Z
	 AztV6xuT4euBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BAD3806644;
	Fri, 13 Sep 2024 03:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-09-11
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172619823201.1803481.18258028885841801312.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 03:30:32 +0000
References: <20240911211525.13834-1-daniel@iogearbox.net>
In-Reply-To: <20240911211525.13834-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Sep 2024 23:15:25 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 12 non-merge commits during the last 16 day(s) which contain
> a total of 20 files changed, 228 insertions(+), 30 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-09-11
    https://git.kernel.org/netdev/net-next/c/3b7dc7000e7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



