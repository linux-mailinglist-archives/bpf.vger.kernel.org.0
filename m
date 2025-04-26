Return-Path: <bpf+bounces-56765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE6BA9D6DE
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 02:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60538178281
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 00:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEB21E5B9F;
	Sat, 26 Apr 2025 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6lAviND"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4797A190462
	for <bpf@vger.kernel.org>; Sat, 26 Apr 2025 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745629137; cv=none; b=QUscAFDj8lUOI9xno3tdV57WFRsa2R3ClhMTmRR9jtS/Qm3S/otZYSoAE1nW+V2KcPdbFXUIbpHxftnLsR055u6gKt3qL4D8Bu2EFmb0P9WQc4J+ADe5HkPH6LS11QhwAanxzuYCs2m3hxoHw3Lr4h/q2z/fNzih8Q8EbVpKT3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745629137; c=relaxed/simple;
	bh=/MNSnlt3LbkO/s348CnEWcJCW1qNG5uY+hYOAdMaisM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jwGZ+Uy+xXQqD4HQ15AZigEDGcYaywCePvHAEF28phoogTRbw2dorL7qm49lFxa13AxxNeoZeHj7uvwWa+8gdxHa2DI2N0JW7+KxE4EY5atpFWnEzMdghjYisFvnn4oQGtxYJDlsj/skghKSyNzXqT3Z2KsJ4rqm3pkt2FkwG/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6lAviND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1222FC4CEE4;
	Sat, 26 Apr 2025 00:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745629137;
	bh=/MNSnlt3LbkO/s348CnEWcJCW1qNG5uY+hYOAdMaisM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T6lAviNDslXZVlinzKlUU9IYKkRAR4G7LWzMExJrujEbpzdlUkHjOk1ilAGzcadfq
	 VguC4O5dZAZXETSbhb3YK0q4jn0shtSaE2w41fhfZc/MHdGLbqpYOiWEKMoDADr6oC
	 Djp4cU6o2SApBLRixm8J66ZkORF6qWmA7DqLCA9NoGQXTS2RTmQYtdziJ+o3BMSUWA
	 8Qf1D3yi/pZtWwkF/dyLB3DSfTHLvQdTmOe3abCOO0rGo8XI92vMb+rzOC1W4jESvN
	 k7RKVuWYeUNSdS/RJjE14ZgAa46BR0c5L5M27hNRDg8HWUKBL9xu1uZiKFIhwSsJDp
	 usH93dHyJv28A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB085380CFD7;
	Sat, 26 Apr 2025 00:59:36 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.15-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250426000827.84560-1-alexei.starovoitov@gmail.com>
References: <20250426000827.84560-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250426000827.84560-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: f0007910784a61556e94c42b401a38116a899c73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1a3944c860b0615d0513110d8cf62bb94adbb41
Message-Id: <174562917544.3891037.358316272579570167.pr-tracker-bot@kernel.org>
Date: Sat, 26 Apr 2025 00:59:35 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Apr 2025 17:08:27 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1a3944c860b0615d0513110d8cf62bb94adbb41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

