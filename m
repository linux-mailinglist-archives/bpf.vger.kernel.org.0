Return-Path: <bpf+bounces-15085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A147EBC89
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 05:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF822812BC
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 04:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBC323D5;
	Wed, 15 Nov 2023 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6jhvRc6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49D6A55;
	Wed, 15 Nov 2023 04:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4318CC433C8;
	Wed, 15 Nov 2023 04:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700021424;
	bh=BnlWG77Jiana2B4H+4APzMxAg7dUTLbjSglg5ybkhqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y6jhvRc6PdO50M2JU4v9L8j6odBB5T8K+y75yidKuM5OiB1W9gexeVvT1oW5e37+h
	 g4qkIeve1mvopVj1Uu3AryWMkwVG3JgmBK3P6QElMAFeE3rWoR68NRYN6kdXMvcwJB
	 N/mVOt7W6jyUHt4APWqJvd3goXYxBS3CSNqhxYUMRat6sFoeL9O0Jx/9cZHX4snCLT
	 PdSpzsL4WMmrrhI667Ty6HjLiOM5Tfnwgh5YLLHTZHrzeHI3Mh5fEPIN4nacode9qO
	 Xu/mylDKxGg3nFJPUaqYFf0vci1pZzWh37i+xyiljN4hricc2RKti9sETZLs2uMJdb
	 1LDwKZouCJg/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BA18E1F66E;
	Wed, 15 Nov 2023 04:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] gve: Fixes for napi_poll when budget is 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170002142417.20125.12281106465320603262.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 04:10:24 +0000
References: <20231114004144.2022268-1-ziweixiao@google.com>
In-Reply-To: <20231114004144.2022268-1-ziweixiao@google.com>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, stable@kernel.org,
 willemb@google.com, csully@google.com, shailend@google.com,
 jeroendb@google.com, pkaligineedi@google.com, jonolson@google.com,
 sagis@google.com, lrizzo@google.com, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Nov 2023 16:41:44 -0800 you wrote:
> Netpoll will explicilty pass the polling call with a budget of 0 to
> indicate it's clearing the Tx path only. For the gve_rx_poll and
> gve_xdp_poll, they were mistakenly taking the 0 budget as the indication
> to do all the work. Add check to avoid the rx path and xdp path being
> called when budget is 0. And also avoid napi_complete_done being called
> when budget is 0 for netpoll.
> 
> [...]

Here is the summary with links:
  - [net,v2] gve: Fixes for napi_poll when budget is 0
    https://git.kernel.org/netdev/net/c/278a370c1766

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



