Return-Path: <bpf+bounces-70368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC1FBB889D
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 04:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44B1C4F1AB8
	for <lists+bpf@lfdr.de>; Sat,  4 Oct 2025 02:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726572116F4;
	Sat,  4 Oct 2025 02:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC/FHygp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873234BA31
	for <bpf@vger.kernel.org>; Sat,  4 Oct 2025 02:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759545748; cv=none; b=lyjMKvBcQ44bW7P14M46lhrzRSxn3oS5INOhsBKbLYh5J4UCkSTUZI88RI4jkTzr+b/oQZwF9quEBsuGPQ8CnRtTbdm/gXASpXeNv/NWMPeylN+Yez00fjuFwp79Ffk4ojaco+hXkjLBQmj2MMv7rdqM5fn12kVhrM0SCMFf7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759545748; c=relaxed/simple;
	bh=Z0rWcx86a+wMnipgpZixaiPtzEBDHRwR3fDIm+sF7XE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MAefEZGdjb7dRjPE2dKO+7FBxSGhGFBe8YLm6eYssVqDMrjBMQNty1Wxvkn+5iTXF9HlOhY6x4iXiEMR59zfvkENAFGV7qfGMTBw8poolC+bFc5ypCNdSIpA1SpzDpShqKMP7OhnqDDM+eR53OC03aoVR3xiSf3MEFDf+OXKvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC/FHygp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58CAC4CEF5;
	Sat,  4 Oct 2025 02:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759545747;
	bh=Z0rWcx86a+wMnipgpZixaiPtzEBDHRwR3fDIm+sF7XE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BC/FHygp9TaWkeQxHIjR5g8mlDj20g88nM6gQ1o6WFt/GMOnhS29Az//Syg6WHUis
	 neHuo5B9QRoKdRVQxVVTYpBovkk5OwwGql6qZkuJT/yC8nlIpoqt3Xsv/Ky3gyMcB+
	 X+0vpEMkZrZbiqJcrYVAT2On2HkR6foDXEt3r81qvy9LI/WWOVUs9BW0r5pOXkAE8a
	 vh6CoO7lrH3/cEzALtCV+2+8CgRfFEHsJzYufDNy4XJRD8+VovzDNSSZsXInbtPL5e
	 BgMIjDv2GMyc4r/5mqEIfWpKam5ZWAzS+LZKCZ7lSitANq2fSB8xxAlelbGCNHTjhS
	 lK25jfQwXA+eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EE039D0C1A;
	Sat,  4 Oct 2025 02:42:20 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251002232448.57255-1-alexei.starovoitov@gmail.com>
References: <20251002232448.57255-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251002232448.57255-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 63d2247e2e37d9c589a0a26aa4e684f736a45e29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbf33b8e0b360f667b17106c15d9e2aac77a76a1
Message-Id: <175954573878.166651.716292636038518748.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 02:42:18 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  2 Oct 2025 16:24:48 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbf33b8e0b360f667b17106c15d9e2aac77a76a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

