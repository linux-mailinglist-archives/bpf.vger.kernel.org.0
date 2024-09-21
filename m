Return-Path: <bpf+bounces-40164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA1897DE0B
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 19:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6CF282524
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 17:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB7D1779BC;
	Sat, 21 Sep 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvLcu5xp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0735A219F3;
	Sat, 21 Sep 2024 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726938832; cv=none; b=aZndHmrDchyJdcv+qU1Tsu6GOsNpjfS5TAg7bvEVbmLrgqjeoah5TfmV2Bd/MIuuCX+D8PRtYYaeZdVP3RUf1mh8qX6mH9G6PDvVqtJKdWeWClIzj+Y87AjSz1KRMtFvi3HFrAAiRAVNKkDOITyb1Va+Rnj4DvAEb4XtIByNkr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726938832; c=relaxed/simple;
	bh=74UaiF3AOXpiI4E+J3cEkwQO2P9RvdIXhhGIqzzrbns=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pqpp0i9wSQCEWfptGQ1g/5Erwt27e6OqiFlZBM3YOsoADhiE6DKbvhGANAHYzeUfjk5MsyeSBmtbhbwpa1KBSbHpp6D8kHJqb4ZK0I71D/w2F20/WgHzC/svB6QbhNLZdJa6dSiI8yjiRNLCG4VHgd6vTXJWHoF8tdbTFVBA2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvLcu5xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C70DC4CEC2;
	Sat, 21 Sep 2024 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726938831;
	bh=74UaiF3AOXpiI4E+J3cEkwQO2P9RvdIXhhGIqzzrbns=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TvLcu5xpbJ2jBKMIFCseIX3AMYV94KEE/V+6Kjrjdt3hgJ19l/q/07A0hwU3y+Ish
	 oY81GkxDc1ZujOLxPXVGmineC9Ehefqyt5emptYAOIXXRqtIUS0h/rs2S+wIJuRVQU
	 4cRw0JGSGV9lbExGgl8MnSjAfrJJvSfEV57cX9LALQKuC4/CSxy4JJr6M4aXu6mV6E
	 CFkd0bpWP2TsgaKrfCFLV6t/ryFceBzoM0HLGRL1tTpdflagyJgNo4ZCxwmJcYt1UM
	 lmO/0wQal5a2A3ZW/xlGGpIAae31FjB5r0xURWxFqsKodPCMP80kYN1DBbzLMFK4t/
	 68ZSmdEE0D8vQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDCD3806655;
	Sat, 21 Sep 2024 17:13:54 +0000 (UTC)
Subject: Re: [GIT PULL] BPF changes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240914155810.15758-1-alexei.starovoitov@gmail.com>
References: <20240914155810.15758-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240914155810.15758-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.12
X-PR-Tracked-Commit-Id: 5277d130947ba8c0d54c16eed89eb97f0b6d2e5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 440b65232829fad69947b8de983c13a525cc8871
Message-Id: <172693883326.2537618.8513134307356112874.pr-tracker-bot@kernel.org>
Date: Sat, 21 Sep 2024 17:13:53 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Sep 2024 08:58:10 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/440b65232829fad69947b8de983c13a525cc8871

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

