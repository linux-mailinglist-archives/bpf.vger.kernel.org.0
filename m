Return-Path: <bpf+bounces-42489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA549A4A42
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 01:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB9F1C21AAC
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 23:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC501917F9;
	Fri, 18 Oct 2024 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcKl0SIk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09EF152E12;
	Fri, 18 Oct 2024 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729295226; cv=none; b=gAGXu61RZqMplIzHz2DF7N10CKLLf+76521MiJm2nhea27jDAoG06Lk4aW+eVpyob9yiAgXesMuJkrPuHQx7cCeFkEX3XT6qa45rXXoucPrPG4FFYwmU1kuCk3nll12XeZwXObfOW2lA+n/ATgO0laHA7n3X+9G84/b/8Y83u5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729295226; c=relaxed/simple;
	bh=0ufzcRrsmb21/qrwoVKV9ZRAr/nCyaaGpsRJ41J3u6A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jH/i9Bh0Cby79k0Xmukza36JO5jgJ/GOiQ+E/WXiYK5QWJUbEFs+dmDkAJxo3v7MQI9mPowWAnxcLfLZL4sHxhbhCpSMUs6mKq94hls8UhYCx3znAA/lWaAoJpllZPiV25W4xzfFZU2Tcig2pZqGYnd2C6QSm4k0LQOG3ftb2Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcKl0SIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93144C4CEC3;
	Fri, 18 Oct 2024 23:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729295226;
	bh=0ufzcRrsmb21/qrwoVKV9ZRAr/nCyaaGpsRJ41J3u6A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WcKl0SIkuJ8dDBQ8VXsPni3ZpQFxpyRZfmSMULricHefYhAZ+xF47mt8KEMAlX1Ck
	 wPUyZhsk500vj0TQw+2R+VzQCxZ6Kuewa44040kjkfbo1sRNa/4oq1aiPASgiiIKRt
	 dlLF6OYa+3XYV34D1Bs8aJ9jLaAhLDfkUTzHIgqczs5LO4oJsrGGx/HDUza6bq6IG5
	 e5J3efeDXADXoHAhKcodxSw9/M9aE6BtoB03cFCMN6W0HlOQMwx7QkfOlZuNG2qDEb
	 jZz2nP5ZmI0F4rbzYJngMD9hULD3C0ll7fSdTzsC5j7WS3ocI+gl/BmdiH7rz6GXiN
	 GuuOK4FfnbZKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FF23805CC0;
	Fri, 18 Oct 2024 23:47:13 +0000 (UTC)
Subject: Re: [GIT PULL] bpf for v6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241018202420.17746-1-daniel@iogearbox.net>
References: <20241018202420.17746-1-daniel@iogearbox.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241018202420.17746-1-daniel@iogearbox.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d5ad2d4eca337e80f38df77de89614aa5aaceb9
Message-Id: <172929523208.3295109.5294002829281223394.pr-tracker-bot@kernel.org>
Date: Fri, 18 Oct 2024 23:47:12 +0000
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Oct 2024 22:24:20 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d5ad2d4eca337e80f38df77de89614aa5aaceb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

