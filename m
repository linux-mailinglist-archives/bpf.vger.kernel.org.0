Return-Path: <bpf+bounces-4982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4EC752F4E
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 04:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690B3281F75
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 02:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8226BEC8;
	Fri, 14 Jul 2023 02:21:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA18806;
	Fri, 14 Jul 2023 02:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B598C433CA;
	Fri, 14 Jul 2023 02:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689301265;
	bh=gcOWOcoU3m4AKQgrhUcZd930T6NkJk8Bd3Kg/KylIxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kj5zj6Esoz/jR1eGzxf8CYW6Ow5b+CCJOk7iIRDUjEhn95F8Q1fDBXu5oulNs7TRB
	 eacaMu/TyarIzRmNn/NV9K8YwEb1d5ciT4DJkj1gFq8O0mnf5VnIzhoLatilmzYA+X
	 KPT7diCwmHkd1HOTrY/M3FXba8afua2ZB1Tz6lJHQ7tTxtpfFS/5PixAzrUFOTJCF3
	 3H23V/seTnfllnaATztTO4mYlphLS5PUZpUQGhEjs7VpQ3twmWGCPbOZFjctKvUQwI
	 j8fsL8Zp7X9vYMyaBq9623XF4pVsBYuxSpY5J023+je49lJAKvmFX3CTp3PzghtnPw
	 AuZUaZ6S/8DVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 609D7E4D006;
	Fri, 14 Jul 2023 02:21:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2023-07-13
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168930126539.23383.7014345364901035760.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 02:21:05 +0000
References: <20230714020910.80794-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20230714020910.80794-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Jul 2023 19:09:10 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 67 non-merge commits during the last 15 day(s) which contain
> a total of 106 files changed, 4444 insertions(+), 619 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2023-07-13
    https://git.kernel.org/netdev/net-next/c/b0b0ab6f0131

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



