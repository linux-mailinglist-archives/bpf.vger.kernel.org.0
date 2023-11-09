Return-Path: <bpf+bounces-14545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 801F27E6216
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 03:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529821C20AC4
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BB14C94;
	Thu,  9 Nov 2023 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv7Mm+sX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205DA137D;
	Thu,  9 Nov 2023 02:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EF7CC433C9;
	Thu,  9 Nov 2023 02:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699496426;
	bh=ShqdX0CQ6z/f/Y1CLAFkoPS3s918vfaiIAXwMLtmAag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bv7Mm+sXUdO+yQEDGXv5Q3JtZTNloY6XkNYq7sb6VkO/KXjvmrzqyg1PCcUjdLvL5
	 IOWBNpwB2pjRyR+UEgEZa1TBKZWKTarQGsrGqsCuqhuUBY0Q4hmFyuoG97rF8ILxrJ
	 84wOFiX/9AkHAaxCHkX9q3mZCqoKzYIT0u06iQCpxjw+sFpBvjnyq5pfH0BqCRrqym
	 OL7XtOxulCJmU82s6dcqsnkxeEkp92nDY7JN3k0kS7bll6qKk/swrbGLG95vrDNkwd
	 qaFxoagrJp+4LM0CQ/NHkLBsBArevc4AhVSfZmu1M6XCRW6mC/ewpjT1/fVfSPG25k
	 sJ8ITsTbsSSug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EDC5E00086;
	Thu,  9 Nov 2023 02:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2023-11-08
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169949642631.19295.14155657698055253547.git-patchwork-notify@kernel.org>
Date: Thu, 09 Nov 2023 02:20:26 +0000
References: <20231108132448.1970-1-daniel@iogearbox.net>
In-Reply-To: <20231108132448.1970-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Nov 2023 14:24:48 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 16 non-merge commits during the last 6 day(s) which contain
> a total of 30 files changed, 341 insertions(+), 130 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2023-11-08
    https://git.kernel.org/netdev/net/c/942b8b38de3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



