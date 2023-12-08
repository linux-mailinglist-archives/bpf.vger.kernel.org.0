Return-Path: <bpf+bounces-17082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC07809864
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 02:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C712820DB
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 01:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAAEED8;
	Fri,  8 Dec 2023 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdTBoNjh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CAA382;
	Fri,  8 Dec 2023 01:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49F09C433C8;
	Fri,  8 Dec 2023 01:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701997805;
	bh=+FdWeHCsxQI5D3Hb4cdTMCTr0/hP3EFVMVP2Wrflmko=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GdTBoNjhJ0fVE1Gsi9JG7j/t/d3CFxxd3hgX5l6X3CQTpIPMf6U4dvbeDu+79Dkp/
	 KSQlgstxbK5P9Bj497I50ghnFZG7jAYgGz9y6uM9qWBkGtZjQQJH99dtfaS+SEEu50
	 dLDUkkQZaZViEzOObfaNSV3dtLT5B+FEp75DcA6oMlK3vyrRHxdDWe1RBtnvnidFKO
	 2yMH6zDu5q06Yw7cZccPMftGdH5mc9AF7yqWHZgH2/jCPZyGtmIjeYBdpIwcMdX8+/
	 lt3/36bwwHh+BkMhH2dD5NIO/+4lZu3MuzhBu01gxx4ywK2RtXoeLKrKzGfQoUVjGq
	 ZZeZSt2a0/SwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35431DFAAA6;
	Fri,  8 Dec 2023 01:10:05 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.7-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231207192853.448914-1-kuba@kernel.org>
References: <20231207192853.448914-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231207192853.448914-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc5
X-PR-Tracked-Commit-Id: b0a930e8d90caf66a94fee7a9d0b8472bc3e7561
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e3f5b81de80c98338bcb47c233aebefee5a4801
Message-Id: <170199780520.17399.8154365972166288437.pr-tracker-bot@kernel.org>
Date: Fri, 08 Dec 2023 01:10:05 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  7 Dec 2023 11:28:53 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e3f5b81de80c98338bcb47c233aebefee5a4801

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

