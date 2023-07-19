Return-Path: <bpf+bounces-5386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 395C075A2F4
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 01:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A80281ACD
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 23:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4DF263C9;
	Wed, 19 Jul 2023 23:50:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66F263AF;
	Wed, 19 Jul 2023 23:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D01B5C433CA;
	Wed, 19 Jul 2023 23:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689810626;
	bh=ASsJSYlbDduovAB9yqUiIgUzuui4lm8M4hRrZqyZ7wo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qMwUj78h/cfc5uVvDZAfZ5BoMDF4ZOha4aeA63uHy2hIigOsdVL28c/SjdFZz3rBD
	 cXzv7SeGQ7J6YBAcZ8zAGiht7/PNuClHeIGI7VvBoGI8vIAqSx74yE09CE3nswMJdZ
	 rJ8hz/hRqMcLNQCdSwL5zboSutAQG8yk6dTKGrHbImAxJYnNDLIyBzDBKCRoXtrTJa
	 kMecPJ1JsV1e1w8j3vxASDUWZ/g+PgVMs2ADc0Ycs8eqZ9cqw4U7niPZWPgXSv+VQW
	 it2Vbpl5hcgBfQV0x0jMAnVAMKKxK9jEogK4zaV7I4XHbIpGHizfVEEk83ioaXJOiy
	 yyoNeZQOUKfjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB11CE21EFF;
	Wed, 19 Jul 2023 23:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2023-07-19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168981062676.16059.265161693073743539.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 23:50:26 +0000
References: <20230719175424.75717-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20230719175424.75717-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Jul 2023 10:54:24 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 45 non-merge commits during the last 3 day(s) which contain
> a total of 71 files changed, 7808 insertions(+), 592 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2023-07-19
    https://git.kernel.org/netdev/net-next/c/e93165d5e75d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



