Return-Path: <bpf+bounces-3678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F41741CAA
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 01:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E33B280D06
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 23:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61831DCC6;
	Wed, 28 Jun 2023 23:58:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF011DCAC;
	Wed, 28 Jun 2023 23:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FDBCC433C0;
	Wed, 28 Jun 2023 23:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687996689;
	bh=N8+ozCHnJlm7x262G/IWW5P1T59+/h3535cMtXvyhpQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cgRff7dFf07j+tMUD6o1QH2Mj7Y3C6vKUtmURBqNEYjBdN2LjF+H/oDvnsd2dhqzR
	 VNS+bDtfEn94gQ3UROZ8zdp3pD04rE4rikS7l3wB+lrjPu16Mb6VWFiYLVM5Qv6tm+
	 JEMg+Ii4ED2788zdHIi5MfQT/X//bLK2aMJa7T2R6HhSDg5sRUSM9xncOyPyQRpWvm
	 zIeGFMvrdu/ZOnVgJX6YBUciroacdFzUYuC0NyFikmvOASBYCS+cShGUxcmM36bA3x
	 TKztOUYJg/axWmZKYtBU730BMiU3TUHaZnLscpqjvlIfBzLJyIdA2PUSyr4X/3ouXE
	 LdZI9dRqicC3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A944C0C40E;
	Wed, 28 Jun 2023 23:58:09 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230627184830.1205815-1-kuba@kernel.org>
References: <20230627184830.1205815-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230627184830.1205815-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.5
X-PR-Tracked-Commit-Id: ae230642190a51b85656d6da2df744d534d59544
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a8a670eeeaa40d87bd38a587438952741980c18
Message-Id: <168799668955.4861.7004023441610460029.pr-tracker-bot@kernel.org>
Date: Wed, 28 Jun 2023 23:58:09 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 Jun 2023 11:48:30 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a8a670eeeaa40d87bd38a587438952741980c18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

