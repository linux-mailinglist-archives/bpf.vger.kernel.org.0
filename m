Return-Path: <bpf+bounces-74599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 07527C5FA1D
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 00:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 122543570DE
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643AC30EF69;
	Fri, 14 Nov 2025 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j54igzLe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775D30C627;
	Fri, 14 Nov 2025 23:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763164447; cv=none; b=P5l/GCuKpGiW+tFfof2tfaydnQZ2AJ3jpyS8OAxVhX9rsaagm+vKLv/iY+I8BckujAbOgb7jtlVbW2+wNpkwB0xw4dIBHxHEuC/KTxC3AbSsXuXqAXu2VL5oMVxw30rFSQsZ+ycEYIaEMilGPhua8zEuv2HUkBcoPoDEDsNaDnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763164447; c=relaxed/simple;
	bh=2asm0htS23zr0AsNy6jkmsnZsQXI2w/DrBZ+Jis+V5Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TiCcfmivQS09Gs/gsjnaLH/DZnay50E9Teq2moOsj2Rs0emuDRX86ZX8r/2YQI7Tw8cXPyYAUiZUwZocyDzQ1GOKMSwCoZWFsIN0ymwt2OGigGl84WvYUaKuqJRxMJxJUTP6rd4BIVgtY6KMMK0l0dfN26S2e3eceJoouormlKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j54igzLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F69C113D0;
	Fri, 14 Nov 2025 23:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763164447;
	bh=2asm0htS23zr0AsNy6jkmsnZsQXI2w/DrBZ+Jis+V5Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=j54igzLe8fVCvbOnH+U8hydDklIhwuTMse6hWAkUGb46qGVANH09MNtSIK2VzsTeo
	 q8dTTUDVMz0pFKDxmkInmmrTpB47sly9lu0DvybtNUBol0REdBxU5pQI+7YkWxx0gw
	 evFm45C4ZYmOUyT+l3PEy/c9LEmT35dbELSnQhDYXsYyvSQQaElX4YM/moKlR/F/eE
	 6S4xj0nx+cVCfPQ8Wt6h4GlFxPTlJHbLdJ7DApM4EXaWyY0hhafmEzdnoIdDA/5rkz
	 9a0bGbIevnMeAzTsu1J2JxCYe7b7EBw37w/MAp99hC9rZL7XQIlO3eD+sc5EpgeGMV
	 x0Y9c0Jh7nZvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE863A78A61;
	Fri, 14 Nov 2025 23:53:36 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251114221358.71656-1-alexei.starovoitov@gmail.com>
References: <20251114221358.71656-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251114221358.71656-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 6c762611fed7365790000925f3d14f20037d0061
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbba5d1b53fb82209feacb459edecb1ef8427119
Message-Id: <176316441543.1879382.2814213443829801980.pr-tracker-bot@kernel.org>
Date: Fri, 14 Nov 2025 23:53:35 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, netdev@vger.kernel.org, rostedt@goodmis.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Nov 2025 14:13:58 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbba5d1b53fb82209feacb459edecb1ef8427119

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

