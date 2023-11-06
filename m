Return-Path: <bpf+bounces-14283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00A7E1CE0
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 10:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1539028129C
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 09:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FC515ADA;
	Mon,  6 Nov 2023 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAClbO+f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA451156D4;
	Mon,  6 Nov 2023 09:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A769C433BC;
	Mon,  6 Nov 2023 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699261225;
	bh=92BTUWwZg5i5Xw2EeJokaShyqsQMhNOyHnMbHhiVpEU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VAClbO+fFtISv3ZmwuIJK0OiIdXeEYxNj1Hl+ouPIjzofSfCtW9LJztYxezbi17R9
	 Z89rZpjS1N8eM8wAIdwjlksvAUMSkLbfEVMTXRskr66QXOAnaXP+ql7SQ7+t5O71wn
	 W8p3mynfWINADZbD9WBBWWNTNmRcSPgHDYPX2w7W+sdgT7m/r95XfNfoxHG/5Hs5LD
	 PAMVrXME5jwbctyN9u/WKFpSoE+9YAym2wTNssB4riDx2TxR/atoxNHkX4h5x6P6uV
	 gQBJl08a71ITNslOQ1eJZONtjNQzcmTU+NFON4rsS82w4ySQzKeKcyQgFFd4awXS8l
	 6B2d0IW+jgVrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D90CE00097;
	Mon,  6 Nov 2023 09:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-pf: Free pending and dropped SQEs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169926122544.1218.5315983018632672939.git-patchwork-notify@kernel.org>
Date: Mon, 06 Nov 2023 09:00:25 +0000
References: <20231031112345.25291-1-gakula@marvell.com>
In-Reply-To: <20231031112345.25291-1-gakula@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, sgoutham@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 31 Oct 2023 16:53:45 +0530 you wrote:
> On interface down, the pending SQEs in the NIX get dropped
> or drained out during SMQ flush. But skb's pointed by these
> SQEs never get free or updated to the stack as respective CQE
> never get added.
> This patch fixes the issue by freeing all valid skb's in SQ SG list.
> 
> Fixes: b1bc8457e9d0 ("octeontx2-pf: Cleanup all receive buffers in SG descriptor")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Free pending and dropped SQEs
    https://git.kernel.org/netdev/net/c/3423ca23e08b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



