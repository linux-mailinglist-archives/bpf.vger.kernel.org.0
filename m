Return-Path: <bpf+bounces-43120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1239AF5F9
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 02:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9080B1F214E1
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 00:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F4C6FC5;
	Fri, 25 Oct 2024 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiGZoFk8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6FC22B664;
	Fri, 25 Oct 2024 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729815583; cv=none; b=gc+X7fMSkVQQWgqy0Hn92/cPg5Bw4tDsMH0vRDVZSNojGCBFqz5bPYFEDAeIkgyUQwK3MPKvZ+XWCWTC8xPQDqRhiFslKjRXYT3+qm21PjhquSa3N96vOqmdMcaeYPh9unNLQ3/gK6pBwibCQsjlN/U/7WYkNuLFsiHYldpLPz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729815583; c=relaxed/simple;
	bh=usDGYQDbBb5hSybuwgzHq3en3MlNbjr6NXbX5kcrg4g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZLO8eqsFdB76o1FIm5RlH0AJWlAgUihRgyyMT/F8934sMqd9lQqEqZjan+tsDBl58kpaAvKi5C4pDWhESF9RxLIHG/GJAFAlyZspAVaJft9sKAXGqEVihC6Rb/shpStpGEVNeYMxFGq8DJbF+0GHQhMgdksP0IJsMFbR+3+tz6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiGZoFk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DE5C4CEC7;
	Fri, 25 Oct 2024 00:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729815583;
	bh=usDGYQDbBb5hSybuwgzHq3en3MlNbjr6NXbX5kcrg4g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FiGZoFk8EQ/3dHtoBYz6pjZ4kmNgCkMWyHsA2shWUw7ArI5IrcwbT5BTW5iSMA6sr
	 jt6xYJdDQULNYRVBeI0uwG4ulYWHQj+RMCmcxfjT8YiOiOfG4w7zGsCPAGQ0q7KaR3
	 BvbxlyQtFd6nfuOYYhICDAJBycpT9Y3nInWmNHHgjdCeHrU9nfwUgfshMDWbrpbT2f
	 m8tO0JJMla6Pv7OIcuI7KP3Q/A7dG8tosQGqnvfl64YG1nCKs/JCbRfKOsHhR0oqKz
	 v8NapCBvSn3iHGrG/AoQ0hWMLNpceQqqulDYxhMONYiQ+pcmAIoslvr//lIjWWnboV
	 LMHo5PF8IKUTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EC6380DBDC;
	Fri, 25 Oct 2024 00:19:51 +0000 (UTC)
Subject: Re: [GIT PULL] bpf for v6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241024215724.60017-1-daniel@iogearbox.net>
References: <20241024215724.60017-1-daniel@iogearbox.net>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241024215724.60017-1-daniel@iogearbox.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: d5fb316e2af1d947f0f6c3666e373a54d9f27c6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae90f6a6170d7a7a1aa4fddf664fbd093e3023bc
Message-Id: <172981558970.2421084.5438151528711559995.pr-tracker-bot@kernel.org>
Date: Fri, 25 Oct 2024 00:19:49 +0000
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Oct 2024 23:57:24 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae90f6a6170d7a7a1aa4fddf664fbd093e3023bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

