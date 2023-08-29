Return-Path: <bpf+bounces-8933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BD178CC94
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 21:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CFA28121F
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 19:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102A1802C;
	Tue, 29 Aug 2023 19:00:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01EF1800B;
	Tue, 29 Aug 2023 19:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48EF3C433C9;
	Tue, 29 Aug 2023 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693335624;
	bh=V4juALzediEWIR1K/yW4XNf5fTxbmXpZ+AMUl8JLjyQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UGK5qYOCxn59y+2ojCrYywGU2qLDnxTjE83Gjkeh5Ib+NwendnZqOAeZMORe4IaD/
	 6+wzcvr13HD28hqCS1PnlI/0h7ARL9p+5yceNlxFkYm4Bcx9zaHfHWrB98TjhmR3Vg
	 Ijpg4tlQsGD9P8u2OS6v/61wE37KVgQs2ssu6cC4iy+3pjKDwUgHW2vKhwRyeOMCCT
	 uSmVA4euSpds5pgl3XsbQu7ksl8OzmGvcdRrKqSc3Qr0BGUfye/cjuckGNiOvp+jtK
	 kYERoXWm8xSliX3jsw/vemni7awcO3SiK7nkPjuAofxhebVtoQHCTBrS6Lzz7otG6o
	 SsJXzT7CYe+wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 327B3C595D2;
	Tue, 29 Aug 2023 19:00:24 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 6.6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230829125950.39432-1-pabeni@redhat.com>
References: <20230829125950.39432-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230829125950.39432-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.6
X-PR-Tracked-Commit-Id: c873512ef3a39cc1a605b7a5ff2ad0a33d619aa8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd6c11bc43c496cddfc6cf603b5d45365606dbd5
Message-Id: <169333562420.15412.12056254346182009806.pr-tracker-bot@kernel.org>
Date: Tue, 29 Aug 2023 19:00:24 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Aug 2023 14:59:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd6c11bc43c496cddfc6cf603b5d45365606dbd5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

