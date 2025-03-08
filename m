Return-Path: <bpf+bounces-53633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C26AA577FC
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 04:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53AD0177DDF
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 03:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B4E18DB2F;
	Sat,  8 Mar 2025 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeAntDnO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D267188006;
	Sat,  8 Mar 2025 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405217; cv=none; b=O+WAuVkbjVeu5Yt/MJHDOcAVOW/vdgnWEdexFO6ANH9MnGQMsPIYo/gIGE7FcaDPLZRaDKgeyoYAi0gqGHP0AILpRTZS+hoOP9/r+l1Gqy/oJmC2WxSnWwRDx/9KqnEKZmwH6EnnAMSNJI2lH5CUPr2bvOiZLdYAKfZCzzqRqZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405217; c=relaxed/simple;
	bh=U/LYTdUiiTEHa6ZIs90C3mimTrjgdeBkNgGCyj30R+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ktbYs1yP/+y9jFhxnT86S5inr5Oog+W1x8BGybR1s6dgmZSjGP76BMX88P/sBsWIsuSb6885XjRkUB9zRDMnLBQi26CawqOZI0whtFJKMRByQw5XmSYSPMR10+tVXHXHIKyoMwHVx+2BK7OVGU7wu9UHa8A/omto1QADxabVrK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeAntDnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6C2C4CEE8;
	Sat,  8 Mar 2025 03:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405217;
	bh=U/LYTdUiiTEHa6ZIs90C3mimTrjgdeBkNgGCyj30R+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UeAntDnOWF92hVrFNFyCxfdC+y6/3ozsLCxIRrz0tlmShpjd/wT3E8Yqrq3H+k8Pq
	 oHC0hfg77YRtaWSVZ3vG0RiLsAkv/R9kdRFoRm3Hn9VsIkONx7tnfjcaKOWcjyJtfM
	 kP6BdIJMG5SfC4mY47NR+YtW3pJWugWlyfhNdJsDp04aGOTrjfE9b6JqtJiTZ2t08W
	 LgShFHrjyVWCQ/ffvbdETo8wnZ8htHj3V4w30Fw5W7UxtcH2+kkQxo8ADesX5jhUSh
	 LL0EYOYu6PkQ07w42c43L+1L8adkjtUSrGI6xNWOZJ+ccY90Ue9Zovi1nfi8w2WP50
	 7GEMXtVGkSPvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B86380CFFB;
	Sat,  8 Mar 2025 03:40:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2025-03-06
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140525073.2565853.8563625669606759758.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:40:50 +0000
References: <20250307055335.441298-1-martin.lau@linux.dev>
In-Reply-To: <20250307055335.441298-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Mar 2025 21:53:35 -0800 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 6 non-merge commits during the last 13 day(s) which contain
> a total of 6 files changed, 230 insertions(+), 56 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2025-03-06
    https://git.kernel.org/netdev/net-next/c/93b1e055174b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



