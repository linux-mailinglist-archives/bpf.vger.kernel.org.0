Return-Path: <bpf+bounces-3376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177FB73CD38
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 00:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7FA1C20912
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 22:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0522C101D6;
	Sat, 24 Jun 2023 22:10:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F36EAF0;
	Sat, 24 Jun 2023 22:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEC07C433CA;
	Sat, 24 Jun 2023 22:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687644626;
	bh=pJDzN3XhfgJ2p8vuelj5067dgROIrmsrN7/0++fvr3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t5jo2TaFpp6n1a4J5Tt+Z7AFQAAkMmFuX1YywSrkWpe2EtsPKK5bYj838v7kB9gO2
	 S2jsVA0mgrL/k99nhwUUx7AqGot9i67r2LGpNsCnMNqDONaxuhJtGGf1xuslzTeYg0
	 ttLieEtskiMXaPmtb7rtFcmFBoz77zkgtOs60uSitHy+lLS/DFTu4qAE/7lXYh+4yr
	 KpYIlpYvqQfzy4sF0BfWRm/ciSoYIgQf3s/Ut6GEbh4NMaGr4RQIz0aETSIdf6YKxi
	 6F7eTG8fwy7tNZTYKcHYgL5mjUMojBvrcpxZWjanDzKTkA/XX2qBCktKUFHWPL9t67
	 /qzdou23abNvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0603E26D3E;
	Sat, 24 Jun 2023 22:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2023-06-23
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168764462671.18414.5117739342403837116.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 22:10:26 +0000
References: <20230623211256.8409-1-daniel@iogearbox.net>
In-Reply-To: <20230623211256.8409-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Jun 2023 23:12:56 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 49 non-merge commits during the last 24 day(s) which contain
> a total of 70 files changed, 1935 insertions(+), 442 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2023-06-23
    https://git.kernel.org/netdev/net-next/c/a685d0df75b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



