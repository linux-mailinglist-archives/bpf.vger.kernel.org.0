Return-Path: <bpf+bounces-12345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1EF7CB3BD
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 22:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBD51F21EF2
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 20:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB3136B04;
	Mon, 16 Oct 2023 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2KZtDtL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE196341AD;
	Mon, 16 Oct 2023 20:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6376EC433C7;
	Mon, 16 Oct 2023 20:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697487025;
	bh=CO77rI2HXT51ImgJFyYIYCfXFuoLbKbp7ISnaBSdoT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i2KZtDtL1GZMVLtFragizRecCYV4z//Ldt2LZZw7vDWMABlv1GQjujCHffAnySaZ+
	 YfducSuXVjuGNDEN12QmGlgoSzt+Zpf/OP/Y0+AD7dYMRZQGMNnlNoEsLIS3Ny6BDg
	 ZK+vODjsLTHU7c91+yOHQ7Jx6GkdztxpZ0dXN2cFcRrHva9k3jdAtnMnRWm2vINlwr
	 5NFYTK+qEZHXJlOoRDC1IEVQH6E/nSmRdI9YJeX/y7zzEILUXFKO14HkkUVjNk1ko2
	 EDH9lfMEiEOatOl7W9gBYBtMGvNvFpKaczCdBJDMWECypIvVOMH+AKT5CHpNEUoOS9
	 uPbn+A0Z6jzJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46A51E4E9B6;
	Mon, 16 Oct 2023 20:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] net,
 sched: Make tc-related drop reason more flexible
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169748702528.8961.1562952105472956838.git-patchwork-notify@kernel.org>
Date: Mon, 16 Oct 2023 20:10:25 +0000
References: <20231009092655.22025-1-daniel@iogearbox.net>
In-Reply-To: <20231009092655.22025-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 jhs@mojatatu.com, victor@mojatatu.com, martin.lau@linux.dev, dxu@dxuuu.xyz,
 xiyou.wangcong@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Oct 2023 11:26:54 +0200 you wrote:
> Currently, the kfree_skb_reason() in sch_handle_{ingress,egress}() can only
> express a basic SKB_DROP_REASON_TC_INGRESS or SKB_DROP_REASON_TC_EGRESS reason.
> 
> Victor kicked-off an initial proposal to make this more flexible by disambiguating
> verdict from return code by moving the verdict into struct tcf_result and
> letting tcf_classify() return a negative error. If hit, then two new drop
> reasons were added in the proposal, that is SKB_DROP_REASON_TC_INGRESS_ERROR
> as well as SKB_DROP_REASON_TC_EGRESS_ERROR. Further analysis of the actual
> error codes would have required to attach to tcf_classify via kprobe/kretprobe
> to more deeply debug skb and the returned error.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net, sched: Make tc-related drop reason more flexible
    https://git.kernel.org/netdev/net-next/c/54a59aed395c
  - [net-next,v2,2/2] net, sched: Add tcf_set_drop_reason for {__,}tcf_classify
    https://git.kernel.org/netdev/net-next/c/39d08b91646d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



