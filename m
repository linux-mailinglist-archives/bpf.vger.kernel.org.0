Return-Path: <bpf+bounces-55825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A533AA86FB5
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 22:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6BF17B304
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 20:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB712221FD4;
	Sat, 12 Apr 2025 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmWrIo04"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D521D3EE;
	Sat, 12 Apr 2025 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744491529; cv=none; b=ipwJmVnwStzmY0qLf/flvDEcwJzon6ct7dwUkz14MQZP0Q4ckXBX6koX+7PC8jGW9sTsfL9IUKwD3ntxo6RmQ9dgUsCQlgi4K/Jj78z4rU1RL/Hu176rQM3P8ss0XCT4m3ZBUFgUTEeIREWo/nSptabV0qFx9WaOzLspu8eQnMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744491529; c=relaxed/simple;
	bh=9QDgZiGGPT+SOjTJ3/U31CUZVzGlsc8DDX0Q+18Tils=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tEEYGmLhuPScAYFs4zZ3Fx0EJS1W1XZrcF95cWJC5zExCExqG/3tvZvujuiKf2vciawofjknTs1YgbQyZAXMBcY1txOvY9jcFc0ANcoY0Qx4XGjj3Q9Fz1d7NHkYE2VF4VMdJ+CStZEeK7uWUVE4CZ9dez+Rxg1HynuiEmm6f+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmWrIo04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0767BC4CEE3;
	Sat, 12 Apr 2025 20:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744491529;
	bh=9QDgZiGGPT+SOjTJ3/U31CUZVzGlsc8DDX0Q+18Tils=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QmWrIo04/RLWN34KFXkANRxS6mvQqZrr4ef3gV7/6g2i5Z3kws1sfgEixxiOdn4Ee
	 yFO7dPMMKocNO91SV6geFB0MZ1rs/kAMiza5AjrLOkDoAoXtPXoXw5Ek2Jmuvxmmhp
	 eLfqOfFDZnSg8iWdu17d1s2ys+Wly3WYZa1DMeJFXlpATcN5S+qFC5lthjVB3Z4r71
	 q9U8E/SnXTwex12bkX+j+pzwNIVr2gt9d6ele7Dh+GcPWKgZhAVSWdf2+kLGXdgPep
	 O06zbsacfx+2o+7rL/Q4T0uIxT/Aj6Bx7W+8OR9KnaeUfPuV65La/Lb+SzMynvvcTN
	 HX0AY4K9zNR1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB036380CED9;
	Sat, 12 Apr 2025 20:59:27 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.15-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250412183804.36400-1-alexei.starovoitov@gmail.com>
References: <20250412183804.36400-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250412183804.36400-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: a650d38915c194b87616a0747a339b20958d17db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b676ac484f847bbe5c7d29603f41475b64fefe55
Message-Id: <174449156658.752726.18363607173128379033.pr-tracker-bot@kernel.org>
Date: Sat, 12 Apr 2025 20:59:26 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 12 Apr 2025 11:38:04 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b676ac484f847bbe5c7d29603f41475b64fefe55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

