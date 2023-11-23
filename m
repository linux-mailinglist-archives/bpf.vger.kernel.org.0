Return-Path: <bpf+bounces-15771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27D27F670E
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 20:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80241C21075
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 19:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA9B4C3A7;
	Thu, 23 Nov 2023 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxi1O8Iq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4674B5A9;
	Thu, 23 Nov 2023 19:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D90FC433C9;
	Thu, 23 Nov 2023 19:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700767339;
	bh=R6XsSadM5I2yXfIdaPIQgY509tpbrMFgDxEb4kwI94I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hxi1O8Iq7Fh36dXc8H+L2W2SmRulDZoZjizjVeTdbcoXqs9uqbTQyuSm5th9QPCXP
	 fEbbOc+PveOQ97Qsa7p1jdXyi+R7Rz58Nh6/UrlR0DeujTFMbXUD+qlV9Zs1OtoN8f
	 xJXHTOxhgtKwYOf9ZP3CXWQg8KxdPQ5PSzu0jtAdWB5GoNPNVOKAqxoRk9/9IJbmko
	 OrSsnRhn2t1QL6+4wCMTHYnG8IzYICnDxW4d1hOj9IVXfWzyQqhkf+FBJ5BkLmbrQM
	 +QKJM/7loigbcS8VS7KhSBvDHYRPQw4gTQGC98GDIkWxSiEcgCMUr3r8mynkwzwVAs
	 UJyjIQoZJb09A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B2E4EAA95A;
	Thu, 23 Nov 2023 19:22:19 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.7-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231123171825.957077-1-kuba@kernel.org>
References: <20231123171825.957077-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231123171825.957077-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc3
X-PR-Tracked-Commit-Id: 39f04b1406b23fcc129a67e70d6205d5a7322f38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7
Message-Id: <170076733930.13126.8602329933324976229.pr-tracker-bot@kernel.org>
Date: Thu, 23 Nov 2023 19:22:19 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 Nov 2023 09:18:25 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

