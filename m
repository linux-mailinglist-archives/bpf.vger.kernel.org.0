Return-Path: <bpf+bounces-47528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEF39FA23D
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 20:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA067A208B
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 19:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDB71898E8;
	Sat, 21 Dec 2024 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8qdZLq0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5A63B9;
	Sat, 21 Dec 2024 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734809384; cv=none; b=QvJoeTOQ5kjB9QGPAI37yMspb89XoU/Fp5FZKpYWUYqOuh7q8G67Sz8WA6owRmPeBYxb3g2Uib8LnRD0ScU2YuJTZ2RR+VprXvYfg58sabY9y4e0/IuT0TGmuf9E/6LnjdpsM/+EV3kL9LCP6pLVK6TWdFdy7LsWTHIfyUNgkq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734809384; c=relaxed/simple;
	bh=tH6g2jg7wiXFV2weys/8iW3P+mMUCVmk5ncWFKgo7rg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EZsb7eNIvKFuVc02HtNc7gGQjunjwWp0Tqux0P1dph1pPpPxztyzXWYbHanptUhzoWvNz1p3L6r0wVNVNRifXTi65KHxcfHEOeiW3n/e65RRvkiKc63rHpTmlnw2Phnea7AHfsE4lRHO0O6kKJ64DBM6SKYYaLS+Q3yK3nohF/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8qdZLq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74F3C4CECE;
	Sat, 21 Dec 2024 19:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734809383;
	bh=tH6g2jg7wiXFV2weys/8iW3P+mMUCVmk5ncWFKgo7rg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h8qdZLq0XVWy9rUnk0E/KBoDWzhTQ0nvFSu3XFtTdUfbK6eQ8zexfa18n6IYsNCUC
	 73YVpDFPbxH4dYSaPnFnemDRX8pW7yIPikvqepyxIT63cVhSJOy5QgDq3/bZC8E56f
	 FBSjcSzORFf/DnosoloLBK9PQXnQezGRWMnRiIPI8lpupRX12ysWCOufnksJys/K/q
	 o2NLEN1Tt7/iMLZDfVnzUEnIeIXjcvXv0Thk+jApj0waGrgDu3W+O0FGWZOg3Zt3+Q
	 kzOaWveQR6MXOY9VIaaHS0u20i+eEOr+hkhNX4/mQZadpS5hIkPgryNDFI8XRHVrEz
	 ekFSurRnV1G5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E54C63806656;
	Sat, 21 Dec 2024 19:30:02 +0000 (UTC)
Subject: Re: [GIT PULL] bpf for v6.13-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241221002123.491623-1-daniel@iogearbox.net>
References: <20241221002123.491623-1-daniel@iogearbox.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241221002123.491623-1-daniel@iogearbox.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 4a58963d10fa3cb654b859e3f9a8aecbcf9f4982
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c707ba99f1b638e32724691b18fd1429e23b7f4
Message-Id: <173480940144.3212515.3548299208335198456.pr-tracker-bot@kernel.org>
Date: Sat, 21 Dec 2024 19:30:01 +0000
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 21 Dec 2024 01:21:23 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c707ba99f1b638e32724691b18fd1429e23b7f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

