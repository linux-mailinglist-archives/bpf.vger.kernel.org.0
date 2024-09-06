Return-Path: <bpf+bounces-39093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB2596E825
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 05:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A701C21AD9
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 03:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B552213B7A1;
	Fri,  6 Sep 2024 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ1+UoGr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D8A13B2AF;
	Fri,  6 Sep 2024 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592821; cv=none; b=Bs8SH2zZS4tyzsXYZl6pwlZp0swZ3/i4XTdktjIOUMBPRBQiXWj6itoTPxSjb2eTuZliBZlpoT7MbRwLyls9kwpCITvQkflOKhV5qdL7Gc0Kwhy7aOF81ipShWVDvOu7EOzyTuwBCG+UzUDcl7y4YaaNl7nqQlZ/V7tftiM+at4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592821; c=relaxed/simple;
	bh=n1fjfuNb5Od9ydMGOE7ejPdaCorEcnxNTMSZgBnuFiQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jDiuSQ1ZWTTqub8epLc/+Gp/WjK9UA6yiim3TEmR8LtahU/4tIvOXDsfqdChl68oxZvEWY7ktY3THFhDErDQE4tNWqCGueRwXZZ07umyTPI1S/dfrVbeLDLKVPgXo9c5NjrqdAFSHHS7ZHNG48G+97DBfNKiQcMl7BPh+UXRUDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ1+UoGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16786C4CEC6;
	Fri,  6 Sep 2024 03:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725592821;
	bh=n1fjfuNb5Od9ydMGOE7ejPdaCorEcnxNTMSZgBnuFiQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FZ1+UoGrNMuP+KnT8omlAKs4fiiu2y3Ltv8Qwl9HERx8OkZ4VS+FpECrgJ74y23nP
	 EOteieg1lFbF0h08wWZc3bZhuIXHpdB9fdFNf5cl5aDY55JyymvwxVDdGrBY3Ybndl
	 RUTshy49mPuFqjigEfImntri5nRPOzyD1emCKvPaklmWvXZ2rxT3IYqbunLb4aqZ0x
	 agV38zaJIfZ8EUpxcg1JI6XstHhjH62Yh91kVC7Xxg0R63SJJdo1HJYdiKJdnh4W9B
	 Dzzyi7EUOcu8kUwj3VOTdgkOmEe9tb3/XUokfkgQ/ZMZdS1h3MIV3tMbscDi9I617W
	 gKByotTSCxmrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D663806656;
	Fri,  6 Sep 2024 03:20:23 +0000 (UTC)
Subject: Re: [GIT PULL] bpf for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240906020750.13732-1-alexei.starovoitov@gmail.com>
References: <20240906020750.13732-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240906020750.13732-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-6.11-rc7
X-PR-Tracked-Commit-Id: 5390f315fc8c9b9f48105a0d88b56bc59fa2b3e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b831f83e40a24f07c8dcba5be408d93beedc820f
Message-Id: <172559282201.1917326.14100285670558306572.pr-tracker-bot@kernel.org>
Date: Fri, 06 Sep 2024 03:20:22 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  5 Sep 2024 19:07:50 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-6.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b831f83e40a24f07c8dcba5be408d93beedc820f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

