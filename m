Return-Path: <bpf+bounces-16222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB20A7FE7D0
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 04:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8765FB20EAD
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 03:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA8413ADB;
	Thu, 30 Nov 2023 03:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyLK0/Vt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BC44CB2D;
	Thu, 30 Nov 2023 03:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97F36C433C9;
	Thu, 30 Nov 2023 03:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701316225;
	bh=ypFNY8ee3ie8JnUajqMFvGIm9IV7mfj8dkchXV+5NOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EyLK0/Vtd/jdLw5f4khwIV+wuoMAJBhyNdjNH4pFL7zY820KA8yR7gL3rVn+fqp7j
	 Qkzi6vkDu7VCI05UbBHu7mfcLJcC6dhMSSCfCixoWK1il+Umwe4wqw6Nb+QHXUSulV
	 il70JthZJz92HUaGBdQMNJPEgmF1NXXn2n8dQEmCpq5+bg4zNtmsj2rPfCQTwa7S00
	 /JLDD+f79ZypNnEOgcnIk5xpRjo8/Mou1xtlfjZc/Rz9gKbhWqhh7vHZ2ECdkFP8di
	 6XjLxPh2RR5njWAFMljzERr/bsbHRtQe/15n9nB/4zovs/0YKrJMqmPKiPLEcV5/xS
	 xXQaM7dpZWjJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DA5EC64459;
	Thu, 30 Nov 2023 03:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2023-11-30
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170131622550.14621.2493962538463944835.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 03:50:25 +0000
References: <20231129234916.16128-1-daniel@iogearbox.net>
In-Reply-To: <20231129234916.16128-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Nov 2023 00:49:16 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 5 non-merge commits during the last 7 day(s) which contain
> a total of 10 files changed, 66 insertions(+), 15 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2023-11-30
    https://git.kernel.org/netdev/net/c/0d47fa5cc91b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



