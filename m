Return-Path: <bpf+bounces-46994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA75D9F21A1
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 01:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E192D165F47
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 00:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712958479;
	Sun, 15 Dec 2024 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlVued09"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE05DEBE;
	Sun, 15 Dec 2024 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734224052; cv=none; b=lnubIVUN+ng/HCQovVFfM3gwTBwDUOPorZystm2b5Cv3zvSNhAlkMyHqmsRAASPYI8EarasSAU51NEaz2z5ew9LK5JKT4vhnHas21O4Vg8elUOJ4Q4MLmApb2na2eSnLndyQTABN+eqEyhzqcpAH3z1i1C907I9kfWe+B2my8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734224052; c=relaxed/simple;
	bh=Nf9amvmniof6HHtlDxLLcudPMbvThXxmJGLVYNc6cnk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MsUThmICCTAIjZpK7JoWvUcR9On2Rqy046pHniWvw0fceOxqJ08mNt4e107o2SSgzsqcfk2Oz4Ig+QrSxZhX4VQ9BytOKx8A++YTmeXY8eEotDCQZfX1EAZEYLjAkceb0XuBnDBVwGj1WWfDUZFJCWV+q6JyxCgpfaSaWkVmn2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlVued09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4105C4CED1;
	Sun, 15 Dec 2024 00:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734224051;
	bh=Nf9amvmniof6HHtlDxLLcudPMbvThXxmJGLVYNc6cnk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tlVued09k1gBlaXCs0uTy9F56zB8IVzRL+Rty8e9X0iK/GwLuF/gQmBFJ8zjiPqhY
	 7fKJ4uinag8iozng4AmkEkjeeihkVbHcE+ydAlzwa10KHxdwBlc3F88ahDqcp7nI+y
	 bX0sHbVq/YNebJo9rPVfuHdUiy8alvuS8OZWKcfBhrf4lSD0L2CcZ9WBPA+mw2ucyM
	 3MR9nxmCcYK/flllLfgjaFvNNw/seJrWjmPAWbq8gCwslKgSJe7l/SXUyGFnXP/p1u
	 WwYOiYawzWGBsG0XaFDEBcvyTVlYM7Ad4KKEC2iZr7mcLDda9E7Ub5AFq/9l6z7bLY
	 dXARhX6NhJw2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE576380A959;
	Sun, 15 Dec 2024 00:54:29 +0000 (UTC)
Subject: Re: [GIT PULL] bpf for v6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241214203600.423120-1-daniel@iogearbox.net>
References: <20241214203600.423120-1-daniel@iogearbox.net>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241214203600.423120-1-daniel@iogearbox.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: c83508da5620ef89232cb614fb9e02dfdfef2b8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35f301dd4551fa731db4834f915e8351838f6f19
Message-Id: <173422406828.3425667.18113242419848009966.pr-tracker-bot@kernel.org>
Date: Sun, 15 Dec 2024 00:54:28 +0000
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Dec 2024 21:36:00 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35f301dd4551fa731db4834f915e8351838f6f19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

