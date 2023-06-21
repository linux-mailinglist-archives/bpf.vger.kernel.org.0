Return-Path: <bpf+bounces-3073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE23573914B
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 23:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87CA281515
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 21:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28311C77B;
	Wed, 21 Jun 2023 21:10:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07177134A2;
	Wed, 21 Jun 2023 21:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57E2AC433C9;
	Wed, 21 Jun 2023 21:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687381822;
	bh=BlZyTydpPU6kMRAOer18QqZvxbUSULvgahvQKVKwZHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UWZ/1vCHd6oNHkZTRTkNl12ROx8DTeAgKOKfiO7+/AL3MpUavw5v2+dfoMplmKscu
	 2jrFMK8hNxqHuYP0yG/vaw2Zx3/CWhBjGIfHvIZ6m3LWHLXSIrSPOxwd1wrCEFmHai
	 T653D29GUh7UM8B2F2nZYZLs2ZvGfpCDVuzVQ6rfFnVRBh4g7z5Z3k8G4tc5xZOJ1U
	 rcY7ofUgnHvMU8nLwfvsme9ghUDuiBWd2Gbaqzoxh0mBiJrPHztZl6ui6/V6pyAthX
	 tlSWbnpj9UCpeyXmS9w+QG8GsN9ypnMHPTW5Jw7M0NVPJ+w58QKC+c+abPm7q+p3n/
	 dwDTy9wTAYo6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3729EC395FF;
	Wed, 21 Jun 2023 21:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2023-06-21
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168738182222.695.18332943948329560734.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jun 2023 21:10:22 +0000
References: <20230621101116.16122-1-daniel@iogearbox.net>
In-Reply-To: <20230621101116.16122-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 12:11:16 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 7 non-merge commits during the last 14 day(s) which contain
> a total of 7 files changed, 181 insertions(+), 15 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2023-06-21
    https://git.kernel.org/netdev/net/c/59bb14bda2f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



