Return-Path: <bpf+bounces-6534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C9776AA25
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 09:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBCE1C20DF4
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 07:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1CC1EA94;
	Tue,  1 Aug 2023 07:40:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E64A611B;
	Tue,  1 Aug 2023 07:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7B3FC433C9;
	Tue,  1 Aug 2023 07:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690875620;
	bh=yhoYUQN89C9hlJXvlCdA6QYNBshanRV5aOwNFd+hzVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mmqppk8jyyJWHPeYMngwXWoSDVp8Idgrk011pXwWaVg22ePfxLE3JFj8++h5R+e1V
	 4TNbpcvYyRJw8tpq3Pq1HNb/ntGlcHwM20vkAuaVwxnH1RPX/bCF8IbEws/zAbHk8e
	 +w8KrZ2+Rjt9dljI/J1VKP/tVkMWgeeUj668O6P4Xj5NMCo1B/MsAuDuxYwlEeyLzR
	 2OPAhRlRtxi+twAFUOAQqqwA0s008qvuoDDu7lEDBak+xsJxHA8sfSkT25WNRl54g/
	 eXVDfgpSH42TCEwQTK3Kin5k5WkPFlLu4eH9yWXT8KwBYbVWjolEhMzTtQYxePLnzY
	 DPE31FaQM0/NA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9793BC43168;
	Tue,  1 Aug 2023 07:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bpf: sockmap: Remove preempt_disable in
 sock_map_sk_acquire
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169087562061.30595.15880034182820578061.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 07:40:20 +0000
References: <20230728064411.305576-1-tglozar@redhat.com>
In-Reply-To: <20230728064411.305576-1-tglozar@redhat.com>
To: None <tglozar@redhat.com>
Cc: linux-kernel@vger.kernel.org, john.fastabend@gmail.com,
 jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 28 Jul 2023 08:44:11 +0200 you wrote:
> From: Tomas Glozar <tglozar@redhat.com>
> 
> Disabling preemption in sock_map_sk_acquire conflicts with GFP_ATOMIC
> allocation later in sk_psock_init_link on PREEMPT_RT kernels, since
> GFP_ATOMIC might sleep on RT (see bpf: Make BPF and PREEMPT_RT co-exist
> patchset notes for details).
> 
> [...]

Here is the summary with links:
  - [net] bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire
    https://git.kernel.org/netdev/net/c/13d2618b48f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



