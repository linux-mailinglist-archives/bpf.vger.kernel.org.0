Return-Path: <bpf+bounces-18328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 475C2818FC6
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 19:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE601C21E2D
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 18:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC24437D2B;
	Tue, 19 Dec 2023 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1GsgsMn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC4439842;
	Tue, 19 Dec 2023 18:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDE7EC433C9;
	Tue, 19 Dec 2023 18:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703010487;
	bh=D0fcTEAAFSCmLxh1LkZKV/2B1uzuba+fsanijw7HBC8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S1GsgsMnxAftCEEErPML2X0u4qiNpNOLiFZ8E9Kq/+BglWFDxHIKPZOVL+het4lzj
	 ARiIFuiJ5Sqs3grqPeXACPs2pOyiwbbf5akIOWFThXDq60taWpAMgBPG1yaEl/dv+l
	 qBvdv/Ib3zQYQvKvd8cW/6TeOpWknrpV8dq3wMUJS0fUXz2Q5OJE+czi3Y18uk3JMO
	 rMmE6VerHDidXf5tyYBd7GAhAZz5nuN3EjjY6dghVfYzV1fAEZjfERWkpMUQVWdKGS
	 HlubNSB3NbcvAscs5FBR6UMm6A0XPRVu8KMjMjIpWECZ0GWyahqAiZii1Ej06Bvk+K
	 rq2W0qBIGBUcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8FC7C41677;
	Tue, 19 Dec 2023 18:28:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2023-12-19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170301048775.15177.13917603647139192115.git-patchwork-notify@kernel.org>
Date: Tue, 19 Dec 2023 18:28:07 +0000
References: <20231219170359.11035-1-daniel@iogearbox.net>
In-Reply-To: <20231219170359.11035-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 brauner@kernel.org, torvalds@linuxfoundation.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This pull request was applied to bpf/bpf-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 19 Dec 2023 18:03:59 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 2 non-merge commits during the last 1 day(s) which contain
> a total of 40 files changed, 642 insertions(+), 2926 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2023-12-19
    https://git.kernel.org/bpf/bpf-next/c/1728df7fc11b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



