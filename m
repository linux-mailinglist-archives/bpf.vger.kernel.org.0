Return-Path: <bpf+bounces-70067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0288BAEFCB
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 04:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EA81896294
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 02:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7803262FDC;
	Wed,  1 Oct 2025 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmFzW2+m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B7260583;
	Wed,  1 Oct 2025 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759284658; cv=none; b=BKi7+yJ+434/mJWP0y+gNlb8csydGv4NE8+pNPb6lUvKWK+DjPb/WhyTAC0IHCt/KpoPEKCCicxNpjo+6si7PcrdRThtirdDcavaZp8oUVNsIhdv/snV8dLiLickuTe8NxlKIl09DQYdwrRrtxmyXnEq/VjKn4fbAAcSRuFjICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759284658; c=relaxed/simple;
	bh=fJOY2ud5mTU7OZ8TJ5fMK1JQA7AnibjnqeviMPs0uDE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pUBhc4AEqeEbYyuy36RZVrMgzszrWm1C2yyguEDLT3jxgLZM1pCN8sX6YYZ0CCrxojAosROI6xQsV9ZmTmsG/2D8YoqwvjhR0h7rzF/5zK+AkCBK288c8q9RuAWW42QWEJrCqbhq1ujJ4ozcPbrWxxTTXt1qVSspk98chGqVNuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmFzW2+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D12C113D0;
	Wed,  1 Oct 2025 02:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759284658;
	bh=fJOY2ud5mTU7OZ8TJ5fMK1JQA7AnibjnqeviMPs0uDE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NmFzW2+ma4MY5RrKXAv/SQSL56GH07aiJl5Z85SRa14SPubBfjSpXoHcgPFDuFYnh
	 9PF2HMPGA+Mi/TLAb2Z7sDdLtohISs4Ohar7cZV37ic+RF2lnTDkJRwpaMVo22RdY3
	 7tL/UtMuHKkwzDk8+hpuI+wL4taYWCNU1EjOPE8ZNMXwh0DwFpQwiaoaQvEzJ7MLGb
	 NgtQ0JSS8T0G+y6JOkqx5xtR2OLM9W/PQRalAAwf/AGyXN8NkTNQTbZDzA1sKHR4Ns
	 LlQZfp73iMKo5STjVzwOs9ewybRrt2eQLqtTyYrHv1r/NVp1eSosaCWnwLMbL73YxL
	 oi6nrX8tjXmwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DF039D0C1B;
	Wed,  1 Oct 2025 02:10:52 +0000 (UTC)
Subject: Re: [GIT PULL] BPF changes for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
References: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.18
X-PR-Tracked-Commit-Id: 4ef77dd584cfd915526328f516fec59e3a54d66e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae28ed4578e6d5a481e39c5a9827f27048661fdd
Message-Id: <175928465112.2270056.17601767767010267155.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 02:10:51 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, peterz@infradead.org, kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@kernel.org, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Sep 2025 16:46:06 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae28ed4578e6d5a481e39c5a9827f27048661fdd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

