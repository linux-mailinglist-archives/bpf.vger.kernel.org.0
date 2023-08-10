Return-Path: <bpf+bounces-7472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD959777F97
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 19:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EFD28203E
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 17:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA83821D25;
	Thu, 10 Aug 2023 17:50:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0405E20FBF;
	Thu, 10 Aug 2023 17:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9231CC433C7;
	Thu, 10 Aug 2023 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691689824;
	bh=9wpOO+wCEmWVMwu6bb4XqazWdi8z9X+n9E2nJLjeq1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HNyI7dJ4TV7cltwqwfrUkO8qq1QwTXTFZxCmkCRLF/TvUQ/a3Wvh1ygRQ4g4ojg+K
	 pdtMkRglOwbIeGN1PhYoA1Kz8HVlELFIQgZ7swVrHu4gf8/Hls/f8UwYfDnjyZsR6K
	 GnoPObRHkjE6ekXP4SY2JO4ov4wnnyhrDn7bH8ckMTxZxFf15DnvRE4cJIAedmCEJJ
	 YYpES3qF3bk1beBVrKwRh1RyurHmZFP4ME120dnjKlhOcyK2Je8rsjt/QJRO9gN6/J
	 bdvLokEBUtknBQUJOfsM/EvZtfDeIvaRT565/+qEeqEC5tWFJ6exl6zYgDJ2NINYNC
	 WuyutU1nxlrZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7005BE1CF31;
	Thu, 10 Aug 2023 17:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2023-08-09
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169168982445.6158.212539030658902181.git-patchwork-notify@kernel.org>
Date: Thu, 10 Aug 2023 17:50:24 +0000
References: <20230810055303.120917-1-martin.lau@linux.dev>
In-Reply-To: <20230810055303.120917-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Aug 2023 22:53:03 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 5 non-merge commits during the last 7 day(s) which contain
> a total of 6 files changed, 102 insertions(+), 8 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2023-08-09
    https://git.kernel.org/netdev/net/c/62d02fca8be5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



