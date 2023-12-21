Return-Path: <bpf+bounces-18522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BF981B543
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 12:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0981C23AB4
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 11:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A475A6E594;
	Thu, 21 Dec 2023 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLNnhNHq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328F06E2D2;
	Thu, 21 Dec 2023 11:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 820C9C433C9;
	Thu, 21 Dec 2023 11:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703159424;
	bh=AkIjZoUcWVnSXLd8w2xZXNK3Zq3ETLixPIcMhkXpCQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RLNnhNHqeugdleNfFj1WddTKWf1vCmLhvOiOuzrEJLo6VOuicF5/svJZwDYCZjAQw
	 mLP6cHru1CyeWhWPXVEAeG+3briG4Z7+xhvohOgTS4Vqz/gr576SWKOV2n8RUY/VB+
	 /vuR6XjoHVd3Xtu2JV3TZ/SGb0nxCv3P6VsJx98zOiqozYoS9M07kGBHj1RMOFWrpn
	 FfpeLiNppzt4RrOljCuXJKNFx8kQYRm3/XFnfB7FvCZDR8oPoenJeo29jDaTj7FbrD
	 6h79Aica31OLlJT9ZtECEQeN68arNsG+7VjojgitAwxHOjjKJDpiL5hhsUUeMFLq8t
	 AU6uDMjmnZSNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 687CCDD4EEA;
	Thu, 21 Dec 2023 11:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2023-12-21
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170315942442.18802.14003180670109829473.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 11:50:24 +0000
References: <20231221104844.1374-1-daniel@iogearbox.net>
In-Reply-To: <20231221104844.1374-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 21 Dec 2023 11:48:44 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 3 non-merge commits during the last 5 day(s) which contain
> a total of 4 files changed, 45 insertions(+).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2023-12-21
    https://git.kernel.org/netdev/net/c/74769d810ead

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



