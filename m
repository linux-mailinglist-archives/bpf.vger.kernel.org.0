Return-Path: <bpf+bounces-7414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB1D776ED6
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 06:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB1A281ED1
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 04:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D2910E1;
	Thu, 10 Aug 2023 04:00:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D30A4D;
	Thu, 10 Aug 2023 04:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AD0AC433C9;
	Thu, 10 Aug 2023 04:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691640022;
	bh=O2n+Pg7BVSM3NEBNYuGHjjiP2OZK4gxwbt9RTD8LjBs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eGreAqjmWqka3ccaVt7fp6aqmVsvps0gSZY0O1sz7bsDOi0M3O15MREXQ4c/gYEb6
	 ocjIA4qbjSA3NEDnk6hoceeiM+WtYjEGuxQOjqcJmXifOwj52mMQ3p5TCoHSAUmUQM
	 W+NKUPYLF6gkaIzl4Bz9M90jw7UjVEW5fZA83QDDolUFHmJEARwukn3OluXogZkiht
	 FNVq6ku5BFKPmEqmRwV5sFPIAyNWAWDsO9sq4/PKPqK5DRvzrtmrtkcRWQIFY26sSC
	 NamudCc2B+Tc1JJ29xo7ZA654rBZdkYm+2/yxFX62o8cT48VB+cxb6GjYfxcYqWE3o
	 JFEKeQ155ZJGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FC21E3308E;
	Thu, 10 Aug 2023 04:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/4] bug fixes for sockmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169164002205.12670.13503007839889329935.git-patchwork-notify@kernel.org>
Date: Thu, 10 Aug 2023 04:00:22 +0000
References: <20230804073740.194770-1-xukuohai@huaweicloud.com>
In-Reply-To: <20230804073740.194770-1-xukuohai@huaweicloud.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, john.fastabend@gmail.com,
 bobby.eshleman@bytedance.com, jakub@cloudflare.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@iogearbox.net, ast@kernel.org, cong.wang@bytedance.com

Hello:

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri,  4 Aug 2023 03:37:36 -0400 you wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> bug fixes and a new test case for sockmap.
> 
> v3:
> fix bpf ci failure
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/4] bpf, sockmap: Fix map type error in sock_map_del_link
    https://git.kernel.org/bpf/bpf/c/7e96ec0e6605
  - [bpf,v3,2/4] bpf, sockmap: Fix bug that strp_done cannot be called
    https://git.kernel.org/bpf/bpf/c/809e4dc71a0f
  - [bpf,v3,3/4] selftests/bpf: fix a CI failure caused by vsock sockmap test
    https://git.kernel.org/bpf/bpf/c/90f0074cd9f9
  - [bpf,v3,4/4] selftests/bpf: Add sockmap test for redirecting partial skb data
    https://git.kernel.org/bpf/bpf/c/a4b7193d8efd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



