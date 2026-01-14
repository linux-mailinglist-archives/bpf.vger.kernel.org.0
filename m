Return-Path: <bpf+bounces-78843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D4BD1C9E9
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 06:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B903130D7E4D
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 05:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F3F36BCCF;
	Wed, 14 Jan 2026 05:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc4Gb6tI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622E9322C78
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768370194; cv=none; b=YjXmO5XWk6Qoz45PQ+2wYraa9iikfVkxsqb94+R3Bjh1VlUFPv9ai2EIsvRWf1Ope/nBCMzqnNxd4PTyYkmTu2CSodhbnDxyxSJPBQVsFAPS95fLkLzuoQVdYiIm3nRZJMD9vrYEaI426ReNVBY8Cv5+vGxOPLQklOQ1Gan3lEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768370194; c=relaxed/simple;
	bh=5S+x16yC32CwEfu95C5pxMG94gVqjan4klbPf628Mb0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lQLxoaAwIFdPmRKhacxy3XRoGvJyPql8K5vO6erh1ilV08uB9IsS+kOHZBq7xdwQJbqoCHZzOaXWWAA48ZgezIDYSjCBve64xUzP1DmKUgtCtuMNERxndCkfk75wfNYiulT3NSTO+KlzK9jNOucN8xOFZ5MJ7+3IH82JVLP6nh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc4Gb6tI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DFDC4CEF7;
	Wed, 14 Jan 2026 05:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768370193;
	bh=5S+x16yC32CwEfu95C5pxMG94gVqjan4klbPf628Mb0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dc4Gb6tIK2Ewbj87LIo2XxWg0kYYYoDHQ92t9Y1qUfAPBjGOWf88Ah1kT7p5hzxeM
	 /awbm/nYLqw975npk3ewVx/8b7vZGgQR+p38KrlFiJ1mr2D8g9NbrEgw7Y0JvZuyUx
	 VyYRiTG6RAWMlrHPK5OBOsFqjEivVjvkWkFzpMxMSv8bUO5seNPvkgb8nGV/OXvLxb
	 Y2fIDnIEV92pF+rqAc5BTghhKgnkA25uuingbf5gI6x8BzHQuaBNoHNj7Henvrzwv7
	 0VARZASpavg55InP20Qn65BBb/DkRcVT5o9YVUc28QVBsv1mlZbZqmStI3UrmVTNS2
	 lQr8RHShQ6cEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BAB63808200;
	Wed, 14 Jan 2026 05:53:07 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.19-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260114021922.47032-1-alexei.starovoitov@gmail.com>
References: <20260114021922.47032-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260114021922.47032-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: ec69daabe45256f98ac86c651b8ad1b2574489a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c537e12daeecaecdcd322c56a5f70659d2de7bde
Message-Id: <176836998584.3000446.14446907092694720425.pr-tracker-bot@kernel.org>
Date: Wed, 14 Jan 2026 05:53:05 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 13 Jan 2026 18:19:22 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c537e12daeecaecdcd322c56a5f70659d2de7bde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

