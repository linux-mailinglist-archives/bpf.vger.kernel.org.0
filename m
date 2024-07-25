Return-Path: <bpf+bounces-35672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5603093C9B2
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 22:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106D5283059
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 20:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E02147C82;
	Thu, 25 Jul 2024 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgZVR8gI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E161442F6;
	Thu, 25 Jul 2024 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939826; cv=none; b=Nqf4ZZe8/3x7LnPENH/U1qbrK3E4ETX9hJyXOOT6ssDVDzYqgWUHcJg/QWZJDMZjhBtEwITY13z5jA+iEkKSh2mFyVzKWDNnhgLCiAuP96r+Tti0QeEpOKjLemoDOfYLjaPwnRTFXgOHmL1JrCZzkf+YwDp8ofUsb52OrmQ/3Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939826; c=relaxed/simple;
	bh=Y9lBV2YGgAc9g3sEnvP+gabpaLD95ViikuWXyqSwEJI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BcUB2SlTZ/HvTCbJtQ8OHr4TI2OdYCe3PBRxvPdRuAnvzwfYtyE+1rrVwbxQenWwO4e8yTw0S+MyNHB6s3dXNWkhZk/OuwYOPS3pT32cpcwQDkbWM2QyIH6djh+fGIkj4d8+I9ZDm5Dv/yYia91GLl2nUlaOGB5nafJQeylQ7XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgZVR8gI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55564C32786;
	Thu, 25 Jul 2024 20:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721939826;
	bh=Y9lBV2YGgAc9g3sEnvP+gabpaLD95ViikuWXyqSwEJI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BgZVR8gI0zSM4k/PxzkKDsno9gpno3pPitpzRkKAr6SJdXEOg77yUuZ4CJA6P2504
	 MCODshG6JS+uZit2XasILT0VmVZRX2rNsn7xOTq15c39d/ygtQaTiW+hpbEM9pJGAK
	 Eq1zUKdXgvTRjZdUVwjMY9M3T8on9tYtw3gDV5glmdnI36/hJESAUQl8XKx31kF7GH
	 JGNTkbquoMaHa0/rKEUgCFjHYguXU8TC1FAef1G05W2v/0Cok+1cnEl7k76yGEZTaT
	 BasraFfutynKAU3P93jybyWmPdjrfISxwpR0SD6z1x6zMXgMLHyiTcN1v/Z0tDK/eH
	 /V9OjYEtOlPww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B90DC4332D;
	Thu, 25 Jul 2024 20:37:06 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240725153035.808889-1-kuba@kernel.org>
References: <20240725153035.808889-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240725153035.808889-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.11-rc1
X-PR-Tracked-Commit-Id: af65ea42bd1d28d818b74b9b3b4f8da7ada9f88b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1722389b0d863056d78287a120a1d6cadb8d4f7b
Message-Id: <172193982630.17931.12978912053528387766.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jul 2024 20:37:06 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jul 2024 08:30:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1722389b0d863056d78287a120a1d6cadb8d4f7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

