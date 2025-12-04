Return-Path: <bpf+bounces-76017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 228B1CA2375
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 03:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 920CC3022A9C
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 02:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846D62FDC53;
	Thu,  4 Dec 2025 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uC2MNKTE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D62FC00B
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764816867; cv=none; b=IcoIq/R7eGQUXpA9QwvsnnT1+JjRUPOr96zdU9cMqwNJnskt7JxYuKEAL3E17we91nM07O6gzEiwQaokZ3M8RODApF5JW6/jwPPLd6ZBc1p1onlH9+xroYoTbVkc4Fzhe9dsvZgu/VN83NOT6iY8wxHbmUUfCMJL6PN4yR6Zso8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764816867; c=relaxed/simple;
	bh=RSAdNq/ZAJJNnzI5GKbtlnkFbCMDPjfFOVgZx7CH1d8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N+usOvb7EdI5o3H/UfTmANT3oM5HwDEyRt46H9bk5VGvBZmlLcP8oDBujasKSXum5fnhuqgPy2D7igHCEK1nlkD5gXIChn2Hy2EZ+0dOblDRAB0SxupbO5Gkt0c2nPzfONCvCc/ZRYq5hB9gcV2FIGzgv2HhqfXK1YzH7cTli/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uC2MNKTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57D9C16AAE;
	Thu,  4 Dec 2025 02:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764816866;
	bh=RSAdNq/ZAJJNnzI5GKbtlnkFbCMDPjfFOVgZx7CH1d8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uC2MNKTETjTrhxgSjFwF3/JMIVAJuI486zSqr/QFuq8WGMPbbIbh7znox+4zvbdrT
	 EPKru57McRR8oPr+yW6ZX3LwPgB2wnJfHyjdfPQ4ur5njOv40hLzxaX6Q3b9h1edfB
	 stcWFKnc/B1WVPEgwhgwcWorlnPIMEK6wOJ8dFt1dIAkQm14Uzc0HuYWmkT+34WzOM
	 Leb/L7e4Zwg+wGaWUHNUSttih3qFQB6bM0px5+cnbcl0zlqjGtnCCYIz4u27QAIXzU
	 l1hLkjd8W8vQRtUMeWmQTCsOWUpLFv1jtiuVymdE1L1npkhm0I3Hmzuj29LjD63v4q
	 9YctmKGQr3Lxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5BEA3AA9A83;
	Thu,  4 Dec 2025 02:51:26 +0000 (UTC)
Subject: Re: [GIT PULL] BPF changes for 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251201182229.95029-1-alexei.starovoitov@gmail.com>
References: <20251201182229.95029-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251201182229.95029-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.19
X-PR-Tracked-Commit-Id: ff34657aa72a4dab9c2fd38e1b31a506951f4b1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 015e7b0b0e8e51f7321ec2aafc1d7fc0a8a5536f
Message-Id: <176481668540.180085.16378598336599222714.pr-tracker-bot@kernel.org>
Date: Thu, 04 Dec 2025 02:51:25 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, rostedt@goodmis.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  1 Dec 2025 10:22:28 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/015e7b0b0e8e51f7321ec2aafc1d7fc0a8a5536f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

