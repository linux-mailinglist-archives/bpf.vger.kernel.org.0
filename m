Return-Path: <bpf+bounces-63758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE690B0AA54
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 20:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887EF1C8312E
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EC12E8896;
	Fri, 18 Jul 2025 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7vFOiKf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0172E7F33
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864588; cv=none; b=LIo5GgTJ7YJNWjdNaHn1qGtfNThq5hkJUXBW4he3BlHDhsyrg/EEVaV5cuwDeQKakSx47hkSTB4Cl+9F2MK1zL0pE0YsP7A1vMS5JevgiK5CyjQzI1rLHFhaXpP6kD8LB0vbIbT7lLVRA9HBOH32pip4VA3cdAn5j/La/tqozL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864588; c=relaxed/simple;
	bh=yqNqxgn1ARqJ3rz7zE9CHpNB3PgctepgOS1HIYkyBRs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D3XBk0EhxQbSWBTMHM9agVOf3mSDNp+YZRSXaNlKUQ9vw4qCAfpS7GuiRr4EkG/ObqoBdoPkH341UGdV3dm3A0Gu09oEMPSXm99j52OiBjeEntxZQWouJq7moG0a2UvPkA8MFHe/SZyH3+CGR+Gr4NyD1a4YmsDr2ccsh2kr50Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7vFOiKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC42C4CEED;
	Fri, 18 Jul 2025 18:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752864588;
	bh=yqNqxgn1ARqJ3rz7zE9CHpNB3PgctepgOS1HIYkyBRs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=c7vFOiKfeiWLgretEmZCij0EGpWklJTcqc/6N4Mdm55Q5Q14iby/Ie3xPT4RAd99X
	 +gvqmJb6YnCPiKQhFIhfWe4OsPBMlKiUKnIWRMAvSA//eRV5PKu6ozthyiwpW52CMU
	 jAYlCfEB9j5Ztrmu2Quv9CuLeKdZiDTizYa5EGeP5HlDmjn6ORwr24acfJixG/UwgB
	 hXcKMrLpQyOflDGTU1EIjy3Ucjk6v/wmIS2H13/GbWxj42p4cK4H8dLvRI1XLTuv4z
	 lnqziwp1PcB42ItJqxHlMmxviGlmIAKUmlcXOxCT0jbzevCYfgk1PtfxJxctQhB8e3
	 aagWIisR4wwiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 012D2383BF4E;
	Fri, 18 Jul 2025 18:50:09 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250718023048.78396-1-alexei.starovoitov@gmail.com>
References: <20250718023048.78396-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250718023048.78396-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 0238c45fbbf8228f52aa4642f0cdc21c570d1dfe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d786aba32000f20a58bb79c2e3ae326e4fb377a1
Message-Id: <175286460768.2758519.9113157585069395941.pr-tracker-bot@kernel.org>
Date: Fri, 18 Jul 2025 18:50:07 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Jul 2025 19:30:48 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d786aba32000f20a58bb79c2e3ae326e4fb377a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

