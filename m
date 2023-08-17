Return-Path: <bpf+bounces-7951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDEA77EF7A
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 05:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13E5281D2D
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 03:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A9DA34;
	Thu, 17 Aug 2023 03:20:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B47E802;
	Thu, 17 Aug 2023 03:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3D8FC43391;
	Thu, 17 Aug 2023 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692242424;
	bh=c3AiC2CMfPhoqnnE9Oe3/+97YmuK+JAkuKmb+e5rnMM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JCH5f/8ztBDWAI2cZ53T2o4asFM86SauZ8uPiarxOHea5GG7Xj+fyWdgW5hnK/DOs
	 AxG7PWaUN7ftBiAiq9e7apkBR+KmnxEQ8WvutdVPdRpsbKBfWPoC2Ict/WgtrL4Q5j
	 EEYMx8cqtUFWZVMbUnUWWGN7iMUONuWPvBjHM6bqMSPKw8XPV4lKZ1xzzLIj+WL540
	 mqN9VzZZNUPXTPv2m4BafwxjJqQJKjk1aEmAdU2Au0jZZkMBC4xnU/HnHZUFF22L+M
	 9KvBVMXM6TqwBgVHgxw9YGwiJVGxxkTu8jHQljcwp3ruXAvw4c7/tqgCtahQej3smp
	 54sWx47ZySrWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C68ADE93B30;
	Thu, 17 Aug 2023 03:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2023-08-16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169224242380.22058.620959262762837738.git-patchwork-notify@kernel.org>
Date: Thu, 17 Aug 2023 03:20:23 +0000
References: <20230816212840.1539-1-daniel@iogearbox.net>
In-Reply-To: <20230816212840.1539-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Aug 2023 23:28:40 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 17 non-merge commits during the last 6 day(s) which contain
> a total of 20 files changed, 1179 insertions(+), 37 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2023-08-16
    https://git.kernel.org/netdev/net-next/c/f54a2a132a9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



