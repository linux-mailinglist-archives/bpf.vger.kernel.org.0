Return-Path: <bpf+bounces-9390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F45796F53
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 05:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188B51C20A93
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 03:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCF9ED6;
	Thu,  7 Sep 2023 03:40:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EF7EA9;
	Thu,  7 Sep 2023 03:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5211DC433C9;
	Thu,  7 Sep 2023 03:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694058024;
	bh=Fy8k/8wjjWoXGPv0tFJrk/fP+1tHKwcb4obh0eEu3rM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xw6yNqh6kxSKo4eqD201mRsVuvqwESvMDIZ9RV83yrQBpNwuVPmoyzj9ZiH9Cy1mM
	 bdzbnm1zdM6j0qsIp2gfj2BSqB81nwJQOqvpFaz6r7MUGeGvsNlSCxsdYNpIDRtb+l
	 g2x8gt8bSiFd/aFcYTC06NruOjrvaDn+zV+sG+ieP4qWnIkQZmIETXfU4iOCz3ajc6
	 wPFm1bjsO60DaDnlET6wASgTdimBROYajOK9xNMgZhxzW5RU9PH573YVX+Bl49d+dy
	 JbfUwzr5UXA/F1j0RJ9LoGpdl8k98wdygU34Grwjq+H1/+ZWEV28CdZ6uxl/eVFGb1
	 revbl5qXw0nzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38F4CE22AFC;
	Thu,  7 Sep 2023 03:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2023-09-06
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169405802422.28195.13851983714928088068.git-patchwork-notify@kernel.org>
Date: Thu, 07 Sep 2023 03:40:24 +0000
References: <20230906095117.16941-1-daniel@iogearbox.net>
In-Reply-To: <20230906095117.16941-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Sep 2023 11:51:17 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 9 non-merge commits during the last 6 day(s) which contain
> a total of 12 files changed, 189 insertions(+), 44 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2023-09-06
    https://git.kernel.org/netdev/net/c/f16d411c290b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



