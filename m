Return-Path: <bpf+bounces-15160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D26F7EDBA5
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 07:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173C6280DE8
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 06:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3253C13;
	Thu, 16 Nov 2023 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dud1dTVz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C820E7;
	Thu, 16 Nov 2023 06:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CD9CC433CA;
	Thu, 16 Nov 2023 06:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700116826;
	bh=GGH/pIGrL8hgr3ylZ67IwWn0oBMlkr6WqvmMAqgQIGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dud1dTVzkyzE3+W8rqK24j17wzHTHe5H+XtR1ZPan4IhFH0onZPrkL9AeHHRLCKCL
	 YnwTodBQ74R7JU3FhcdFqO6H0fBmNoaXIvBTnYQPYXTfeA19lWJP0n3/P3bX22z268
	 HsaeejapPIC5aRqNiFVJO3ZNQmW1s2DBTTEuV7vLiymoriFncwowFpdhINt7ciAMMk
	 pcxMzJ/0ohy6XOfHWAUSU8FmhUYUxDftmshcbaJ4wOJuJ6XdHZIB2gAUQ6XWo/4g0G
	 XaW5o4xXyLDsyiaQ47Hwt6Pr5Y6S7We46vJ8cCJOubSuX1pcTIh5MBHX7Fdt9BJ8U3
	 b1pPzbzBGU4Gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C7EBE1F66A;
	Thu, 16 Nov 2023 06:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2023-11-15
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170011682630.8628.10230906787431577857.git-patchwork-notify@kernel.org>
Date: Thu, 16 Nov 2023 06:40:26 +0000
References: <20231115214949.48854-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20231115214949.48854-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Nov 2023 13:49:49 -0800 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 7 non-merge commits during the last 6 day(s) which contain
> a total of 9 files changed, 200 insertions(+), 49 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2023-11-15
    https://git.kernel.org/netdev/net/c/a6a6a0a9fdb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



