Return-Path: <bpf+bounces-45393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD159D50FD
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 17:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BE01F2488C
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777321A00DF;
	Thu, 21 Nov 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3FUR3Wt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A921ACDE7;
	Thu, 21 Nov 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207828; cv=none; b=aso0Wq8j0KulcR/yZsRPGzkQ5EjERLVfbO9gUM2h6QLtYPYDxP03LS3KSro7/qrqbWQc9c2Eo8waqQ9il5zU7RuMo9fLMLYOb33EiotR0JXjWhzLH75sE/nN3mcPRQJzgVcFgTjNt+HVd49p3fGMxh6ho+kyDqu8UQizix/fhdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207828; c=relaxed/simple;
	bh=B1fOjASoyRPL5DYuONhg5fOxLdlroL4Auo/qZaIjIkU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=inDyIzhfhNF6pXiFlh4i2fYi3zU3RKlfHNcLxr93m1G6zTdY1jHUMNcPpA4JPZGq/UwMJ60PoYJuveXrFo6/Tig7meRrZgzTDtrLoQ2lix9BFlSPm8WmCLHD/lpUJXD3Z3vFaPDQb27TNePXrHSs8I8Xahq3A7mwL3O21NExx5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3FUR3Wt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD78C4CED0;
	Thu, 21 Nov 2024 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732207827;
	bh=B1fOjASoyRPL5DYuONhg5fOxLdlroL4Auo/qZaIjIkU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a3FUR3WtHAkHe9OnyqxY8Tg7WF7Ue31zgNMbrxU3PcKSWMCUscoojtPvEA6Go9L8z
	 3cW+MKfX+gB3E2gpnT3NfMyN/X/ZNCZBKFtBjLtE9rB7lTXiADHtHQnr6YBgO+V0JT
	 IuQPoQCMzeqB8V5l6SVioOWFT6TsHlGrNFHhORWazZZpe+jCeou2e8gJFb23CtELIp
	 zbsDVZwfKw4mgTBncuhO9kw+hY1NJqw0NUMeUuMeTWOCwGTMLMATgFZdI4Op+O4bZE
	 Th3RjQylYfmOTiQEsZuqqJJ65aRjv/YZQ7shW2mM6oHI1glV2vrql1Oj12v47f7hn5
	 0eVUyDhHodmSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBFF63809A01;
	Thu, 21 Nov 2024 16:50:40 +0000 (UTC)
Subject: Re: [GIT PULL] BPF changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118193635.77842-1-alexei.starovoitov@gmail.com>
References: <20241118193635.77842-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118193635.77842-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.13
X-PR-Tracked-Commit-Id: 2c8b09ac2537299511c898bc71b1a5f2756c831c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e95ef0258ff4ee23ae3b06bf6b00b33dbbd5ef7
Message-Id: <173220783976.1988584.17651541466926675916.pr-tracker-bot@kernel.org>
Date: Thu, 21 Nov 2024 16:50:39 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, peterz@infradead.org, mingo@kernel.org, jolsa@kernel.org, martin.lau@kernel.org, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 11:36:35 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e95ef0258ff4ee23ae3b06bf6b00b33dbbd5ef7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

