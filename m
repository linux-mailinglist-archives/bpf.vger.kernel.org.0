Return-Path: <bpf+bounces-71285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1AEBED7A3
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 20:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DF840795D
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 18:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B218258ED4;
	Sat, 18 Oct 2025 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIOx8zov"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E136E1DDDD
	for <bpf@vger.kernel.org>; Sat, 18 Oct 2025 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760811503; cv=none; b=C9DLGBTbe39P3ygxoFfBbUekfWhAh6bRG8Hlo/ge7CzPLk0y5oURLGB/01oqmWkfMEa71F6jKHylf9ZMGHEMPMszyuAtlkB0GFS40mqNBZYS7nRJYKiAdLFkiBqFf1Yq8ulVcSka+4btjSVs6M5HFGwmVGAvQHBugT3jrMskSag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760811503; c=relaxed/simple;
	bh=DezST+NQOE8J9ocOz7am5HOlmX4eZxjryUHYIJJc8wQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fKZ6BhwDPOr/l5Lkzmu0b0SdNCSxz//BA1N1aZuPCHEPHNUz1Eluu4U73uymxs92b3vVepwffilO6EEw1foU1sGqCNGHIqXsTnyD3OFYcLzvnAPW/yoZeHE6vUz8oYIJpw27TFxRkM/v0t6WjH8N8uv2qhkDWehjTDwtghsvF4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIOx8zov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD4DC4CEF8;
	Sat, 18 Oct 2025 18:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760811502;
	bh=DezST+NQOE8J9ocOz7am5HOlmX4eZxjryUHYIJJc8wQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jIOx8zov2E1nZ7KEgGyqbs7U1NIKGkFRcYBtctF076sOgUUP/+Sw81zByKcrDcdvT
	 SxR5pJErdzLOWH5zZG0AaOek7gSxvRiRDDhQ7kG3XuraAPxLNZ0Tt5+K9nADfHbXFQ
	 gXYekEEbkdPFSOijMoxM2eoBaFXAhjxi7FIbuc8r9ljSsEdDfqw0w5ygcScT2E4xhU
	 iEJxlTDyM9m+E9aZB+vv05+NgMuFeIdtLGo59dGtB3n9Xl/sBuwE1flrAIqM1SA3Ub
	 D1qaEpn2285uEqjagSyJy0z/rwDYvwwAmwcFzKHDhaI+sUbVJqU2LkgtoO5juCn6kN
	 VcvVBm16BHjtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0BB39EFBBB;
	Sat, 18 Oct 2025 18:18:06 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251017190342.52125-1-alexei.starovoitov@gmail.com>
References: <20251017190342.52125-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251017190342.52125-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: a1e83d4c0361f4b0e3b7ef8b603bf5e5ef60af86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d303caf5caf453da2abfd84d249d210aaffe9873
Message-Id: <176081148557.3064991.1758168041245781808.pr-tracker-bot@kernel.org>
Date: Sat, 18 Oct 2025 18:18:05 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Oct 2025 12:03:41 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d303caf5caf453da2abfd84d249d210aaffe9873

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

