Return-Path: <bpf+bounces-55264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E34A7AF76
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 22:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1384F7A5F0B
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 20:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E37926560A;
	Thu,  3 Apr 2025 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZQgf2eW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E2C264FA5
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708787; cv=none; b=jGDH33uS4pLrgIFNUMIZWVTJ39TD6clJKhuNKntGQR2JDkcArFwY0CE+kFnFzpuJnfntHIUtO14ieVpE4ZQHlHykTOPEZGgT7bbibnQWF2Yqh+6VJmHN4j0xz6xpteqXY9tasALj9n226rxAsIY6oEzs6RG6xBS/RHjZcOUuSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708787; c=relaxed/simple;
	bh=WpvzLMUEeQ7hWN5EhC7SNf9xLtfnSAVVIqcQkIRlm3k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dpIB9/XNLYk8LwOljrPK+IdJ4KbSj9qKhc8w7SEuMqKRtP4hNqnCtwz3Tz68x+bG0raeCcD2JrkQmH1oH1vd/IIch0xCTlimQ5DduIYfPF7cbBlTWfRxTsl4Lj5sAtx4w2OeQFfv4EQem4VlCIyPgcGcNvGR4p2ArTo/85Inc9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZQgf2eW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01508C4CEE3;
	Thu,  3 Apr 2025 19:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743708787;
	bh=WpvzLMUEeQ7hWN5EhC7SNf9xLtfnSAVVIqcQkIRlm3k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fZQgf2eWq7LRTy2C3YbnrPd1kdHbAModJSp7v52BK+RJ/1lL0TsElQfx1OCyzaYYX
	 5gO4Z4DQqg7nUaQxc/k86SVB9iXLydmtC1VAza5o7Sz7Oo63mV68GRM52r7z4b86ce
	 bVceDLpxT99Z7ZjlrpaV/8+tRmLkaGOY8ROCNFN8Ak3ED/nyPi2BHRQ/JAmnwU488G
	 Rw5w5WKgl25JclYiCGS7c/GUD3bCkVvweEOt/zw07CUe0cw/x//rwSLRJjHSBaIhyj
	 dcOLfLZ02eqFkQXesCRfjivb9QMcS28e+/K+m6DA/TDyFwikUDr89Zf+Mlz8od9gjA
	 MjEs9WW4vf0Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34356380664C;
	Thu,  3 Apr 2025 19:33:45 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250403152526.9565-1-alexei.starovoitov@gmail.com>
References: <20250403152526.9565-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250403152526.9565-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 3f8ad18f81841a9ce70f603c45d5a278528c67e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 531a62f223d2f4c0d01df3b3387f0836b5006256
Message-Id: <174370882381.2657822.8179196238206686778.pr-tracker-bot@kernel.org>
Date: Thu, 03 Apr 2025 19:33:43 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  3 Apr 2025 08:25:26 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/531a62f223d2f4c0d01df3b3387f0836b5006256

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

