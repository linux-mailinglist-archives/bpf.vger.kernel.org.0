Return-Path: <bpf+bounces-9096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F29D78F6D8
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 03:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECE028170E
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 01:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9644615B2;
	Fri,  1 Sep 2023 01:50:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4A1380;
	Fri,  1 Sep 2023 01:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 799B5C433C7;
	Fri,  1 Sep 2023 01:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693533024;
	bh=abgTGUCEeaZ9uKG6QhHUQjpxwm4Oc0NH3M0GDgPU/Pc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fQrCv09/GsaXvrVqnQCcCAsu9W+FTkTLnUUNn2TzHtDgi5aHUijnDZgz+yvGdzpqA
	 X7fS8lSZ+OJwxnTKGVy1waCk+3a2P3WgOpOLePH23ksfSFgil0V98h8wINkMNgwwS2
	 ds1rIYjki77l/nvXVG7cNYohtLG1KH9LxLqhUGvaP62hgP18dq70LRpTy5PERiS6ot
	 9eCbPnt4C8W53MUrwa1Ce5PrZ7yTrFJnmhhzNlz+O1YM3AmcWELVJJvAQYN4CcFwma
	 VH5/NRqNk+xxXv0x972zsjy97WOzgliUSjxD0XwgkxR+bitcAYxRtv7VxLfVOJYvXA
	 WXEFv+WXQSRjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E569E29F32;
	Fri,  1 Sep 2023 01:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2023-08-31
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169353302438.22154.13522542058191626119.git-patchwork-notify@kernel.org>
Date: Fri, 01 Sep 2023 01:50:24 +0000
References: <20230831210019.14417-1-daniel@iogearbox.net>
In-Reply-To: <20230831210019.14417-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 31 Aug 2023 23:00:19 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 15 non-merge commits during the last 3 day(s) which contain
> a total of 17 files changed, 468 insertions(+), 97 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2023-08-31
    https://git.kernel.org/netdev/net/c/ddaa935d33fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



