Return-Path: <bpf+bounces-48181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CD9A04E18
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 01:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8677A233C
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 00:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372B98F4A;
	Wed,  8 Jan 2025 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzyAyfRn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668316FC5;
	Wed,  8 Jan 2025 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736296213; cv=none; b=YVJX3d8zlNOh5gxPz3d9XS2G4s0Gak0/iXGKd4Iu3y7SQNp+AbzU2iV0GZaf4y97tIeCrWLd6yGt9CapTw3M+c9M/QjdxIlrMKz7hzF2val1HItQQOVp5hMjtk63qw9P+k46uAe0Xn1KTA1y2VK1Or2ygxqK4n805kyzzec4FKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736296213; c=relaxed/simple;
	bh=RHbV4e/K7fxd1zuzXLUqHEOViJKe0X7X+Q1DKVBG48o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RCNEFetYEyErTIZozJ2W0KnCJTf/ie9WXSMehzYTQoaq/O/amUlfF+2WTem8+tyKyLbPke/v7tYAhibEfDX6bA7ybHzICv5lIJIAuR0bZl02FcHwTdofPOMxFbcONgQCH2gywm3g//mzxWljuagx/EQZ6U0W/SBoJ/YiVcGhE/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzyAyfRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6132C4CED6;
	Wed,  8 Jan 2025 00:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736296212;
	bh=RHbV4e/K7fxd1zuzXLUqHEOViJKe0X7X+Q1DKVBG48o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pzyAyfRn2vujbpCATFpI/WD2PojxywNDy2EjZJkm3s+nUvBWKmzbouwSzQALCw+b7
	 A3CeF6zHL0NiJreM9BsIVrcTIiXPMbIOQC9/66wdfdhOvm291qPE5OwRqdLAtgWV3o
	 cO9it0W9PnTQTrAQsieq9Q1peSHS12M+TlwwIRCKxzAjfaBa08M+eFc29GkbKuzSTd
	 RNdEPuDaE5/sxq15uzeStJrKIhkEmnIfi5I9pnhrBM5zcdbT3aEXbIIdx+ygotnQsw
	 NB7P9Gl1WOmpKBQmpOa090l2AIFsVCSj/LH2i4ISg8XAqvAaVWQPnFIkXyhye9WNha
	 l+4ubZ+RrHLDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B44380A97E;
	Wed,  8 Jan 2025 00:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2025-01-07
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173629623426.141886.6773620888261223576.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 00:30:34 +0000
References: <20250107130908.143644-1-daniel@iogearbox.net>
In-Reply-To: <20250107130908.143644-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Jan 2025 14:09:08 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 7 non-merge commits during the last 32 day(s) which contain
> a total of 11 files changed, 190 insertions(+), 103 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2025-01-07
    https://git.kernel.org/netdev/net-next/c/a8a6531164e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



