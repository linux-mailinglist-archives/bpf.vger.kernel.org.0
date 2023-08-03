Return-Path: <bpf+bounces-6888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A35476F1DF
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 20:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4400B282322
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 18:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C5D24198;
	Thu,  3 Aug 2023 18:30:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A73C25928;
	Thu,  3 Aug 2023 18:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD426C433C7;
	Thu,  3 Aug 2023 18:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691087426;
	bh=8TebnuGooZeufGfl182ar0DYL1wKECgopKkg8IFxasQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h5awdJ75UHeqNn/TsKKJWt7s3FSf6XuaR13iNcS8jjIX5DKQXNTGqAGX8Q2+L/c+t
	 DAu3zHDnjRaGIY3WvlmIC7HfciIekaEFi/MhHg5MIsLEGf6UuKyqSUG0L6vCnlzKzr
	 zB3BK+0L73Xz/TyndebK9FusEcXMiDdA8hxViGYhRPwlx40UR69fiIc6JH5LssbUh5
	 I3MJHHiGQlnWGMnr/D/beqiC3wmveo/i6R/5UilEHZ3TdIXO4Gc39AcgVp1D32b0M9
	 vs6nHRZeVLixRgJZG7lJ5qd0/zINuADzmJV3ibb9wHQl47XEtIKYOMVRp/5BkaabKC
	 MTZdBjaxtq3eQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0E0BC595C1;
	Thu,  3 Aug 2023 18:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2023-08-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169108742665.1891.10634226651396174137.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 18:30:26 +0000
References: <20230803174845.825419-1-martin.lau@linux.dev>
In-Reply-To: <20230803174845.825419-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Aug 2023 10:48:45 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 54 non-merge commits during the last 10 day(s) which contain
> a total of 84 files changed, 4026 insertions(+), 562 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2023-08-03
    https://git.kernel.org/netdev/net/c/3932f2272313

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



