Return-Path: <bpf+bounces-59216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDBAAC7453
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 01:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8B350293D
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 23:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81EA223320;
	Wed, 28 May 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRztrVhe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC3222573
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748473861; cv=none; b=JVdVeM2INdk8sbOgROuOqtIj8G4JwFVUESdlMBckbS9FKJGGtgcs/G7HwLCaUzjVr162sgcDGRwGKcHRWSi5ltVq5n/abc3lWDkwTty6b8T02o3eSTGKkWApwfwrT+jQ70D7NvUP+eta+mflfDbVImb6Bhyc6KnCHkYezi+pOeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748473861; c=relaxed/simple;
	bh=cxYwgVoeZBQwHDqFtUP//MFnQ/3JyuOLD7uIBXXpAao=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fpfY0UnWkje7+QthhVLZGL/PATXRNax0fv4FlNXDb2CHDEzhLX30r2CV63FikNfVzJJUnk+HWbu1gvED1eTYF1S4M4ppzLzFoZ/j8ZvZe3Drfq55E3/pm6aRKwoj6EqqjHV7OK/P4oz+hZ2qBWNDnUY8nBLOSjowCCn2gH65reQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRztrVhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E67BC4CEED;
	Wed, 28 May 2025 23:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748473861;
	bh=cxYwgVoeZBQwHDqFtUP//MFnQ/3JyuOLD7uIBXXpAao=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JRztrVhe6+K2xFMom7ZWPrt0mUh0++/ULLLb7i13dsCX3HURDMl0jZ3xFB4w/URHq
	 Yj+IE2z9x3ZRYSuUDvL7RxYvUa1COPfzaOjivpewF1a0pDgN3andvibScxxUvKkHku
	 e7uoYENeZWji1SFbZtaH1xABTJ4rSaUO9N28zzjGEIB8mlMXaxdjNEZRcqp5cC6m2a
	 wZvIJPVR1kzJdwNZkxfZVkRzMQcjhSRLAgsm6iSikFJgZhy5Hw6P5KKKxozV7aDN0u
	 9Y6BeWCYE8xqdSM/TwLtAkWRSDOiRzfknMgcm8IS82+yr5TbytQnwYmvs5vrEtrDc4
	 wVeuiPN/ZEckA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6B40B3822D25;
	Wed, 28 May 2025 23:11:36 +0000 (UTC)
Subject: Re: [GIT PULL] BPF changes for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250528164921.57695-1-alexei.starovoitov@gmail.com>
References: <20250528164921.57695-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250528164921.57695-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.16
X-PR-Tracked-Commit-Id: c5cebb241e27ed0c3f4c1d2ce63089398e0ed17e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90b83efa6701656e02c86e7df2cb1765ea602d07
Message-Id: <174847389504.2659935.10421932805383437290.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 23:11:35 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 28 May 2025 09:49:21 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90b83efa6701656e02c86e7df2cb1765ea602d07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

