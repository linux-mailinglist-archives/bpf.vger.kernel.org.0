Return-Path: <bpf+bounces-31517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758518FF350
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 19:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20335285959
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E2B198E7F;
	Thu,  6 Jun 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlJ8k98I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6691726AE3;
	Thu,  6 Jun 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693623; cv=none; b=H5rKFVlUYy3QYPlOegzRa0Rsf/HBWPX6nOW6AhH5OuvQ57dFil26vhNSxxPCXJ0iFnO3LmjSxjNok3mVMvpOP0OX6wT/p3UOFDvzWlN3DFFKwWAYJzNjbW+SzSk7+ZYuC3mjfrQ7gD+FRcs0eUVoWl6wGhqlRDPteodAF1zP0wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693623; c=relaxed/simple;
	bh=S/8x/45CPvrugAN4JH93A19CpjVt/ALoFE8Jgrvv3zw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eGL0tT1L9hxJUDNpIuK18Ty0E2d15cAHS9b4t3jQGq6wCiQO7FqD1HJhHg3jPrNYAec55tfPRfiUqDVyV6oCHfIbwm9AGTVmrf0/5PhBuoYqs8SBuAyvIES7DKIroTXy+UGg1w90lVzfnS3pYqgD0c0JCCDzZCWzzRtzx+rLRqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlJ8k98I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40B78C32782;
	Thu,  6 Jun 2024 17:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717693623;
	bh=S/8x/45CPvrugAN4JH93A19CpjVt/ALoFE8Jgrvv3zw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rlJ8k98IBDEEkLmUyWpk4Oi2qKz7pBg3NuF+QAfgMkHCny2KYJDj0BfFciuzYayNE
	 sq5rjuAUyRQl2zT7BDKFbBAl8fZZvy81Ui2cLmULOg3psLTKMxBVGYmlYvoyUfNCyE
	 hbNNCLhDgM+D8s00xkITlFBasXUujN5sGQTARkuojmBII0ZkuANoWItdwy822h1PPc
	 8x/jOoR9Y7Yz310h8JigPAxaTHJiFhVZ8UKMBV1DNlVwcjCytxOxmRuq4+b9VUIrcs
	 clr97Qqv1L9Yovs5BpNHjqXOtiRFHjk+Q1LtR6M+yLQeDMBZ1cIz/oFczttIyyxRc/
	 4bjvG4Y4rhN8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3653FD20380;
	Thu,  6 Jun 2024 17:07:03 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240606162217.3203895-1-kuba@kernel.org>
References: <20240606162217.3203895-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240606162217.3203895-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc3
X-PR-Tracked-Commit-Id: 27bc86540899ee793ab2f4c846e745aa0de443f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d30d0e49da71de8df10bf3ff1b3de880653af562
Message-Id: <171769362321.23076.7425920420760200165.pr-tracker-bot@kernel.org>
Date: Thu, 06 Jun 2024 17:07:03 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  6 Jun 2024 09:22:17 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d30d0e49da71de8df10bf3ff1b3de880653af562

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

