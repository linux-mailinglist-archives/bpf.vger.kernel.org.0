Return-Path: <bpf+bounces-37189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B02951FF7
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 18:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4191F26517
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2631BBBD7;
	Wed, 14 Aug 2024 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTdLG4lc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55011BB6BD;
	Wed, 14 Aug 2024 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652893; cv=none; b=NbHF0JOA0EtsflWvwP9aEFri+fFY4nftpmNc78NeLknbalOA6C3Uq1Po9ef2anT+lz4F7xZKstPmWyNCkTWVz/ZP4LmaCSh9J7IMHbPV4UYUyUJ1o3vBmganLMef6K/jOiuyvejOLmil90ApSEM/1VOBO3WXs7eOVmemR1ChrZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652893; c=relaxed/simple;
	bh=3pHAVPG/JjLvks2x/pyy7uLrB8RXR/4vpyIl+dQDsB0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Q3AnOSpstZHZLZWy6tYYdcpvEEvPpgjz7LCsFT0FVVIYZYCQ7YLNBvodATYT/LFo3dgfZuTLklnJfepL2WzW8YdxjqiGPzvhrTEKVPieTgD0erSB2rSxKaks4KtMwHkwvnYQjwq/aDed+J6o5OiN4iLVcTFvveQf+7VHpSTKDts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTdLG4lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D32C4AF0B;
	Wed, 14 Aug 2024 16:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723652892;
	bh=3pHAVPG/JjLvks2x/pyy7uLrB8RXR/4vpyIl+dQDsB0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bTdLG4lcB6hTEYtwhv9f7GOOmuGKG9tMC99BuP5bVSZRC+dVpt9nJizDGGqzmlDeb
	 npgsWVn21qmjQWtPHiGfWawoFY9fVDkGdHSvhjQN6CjfpuR82vhan9JMp1/UBFhFJ4
	 OAgD/PFlGXg4PlVCDIk3GZrzuGl6sqRgPobOu/S9/cLyeBgMMVJRZ5gn80lclGopCk
	 /nCwzdE+aSky7h8b4IBZ+zgXZGJE5i0M8XvXYhDXSjLlBZKQvxS/7ZhajTosTiuk6m
	 Csg1JMADAyu6fV46nF5la5e3ClC2rLjNed+ZCPbS0LAli2EMFOpSAtA9qKYMKPUxqY
	 loXYBJMtJHg4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE638232A8;
	Wed, 14 Aug 2024 16:28:13 +0000 (UTC)
Subject: Re: [GIT PULL] bpf for v6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240813234307.82773-1-alexei.starovoitov@gmail.com>
References: <20240813234307.82773-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240813234307.82773-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-6.11-rc4
X-PR-Tracked-Commit-Id: 100bff23818eb61751ed05d64a7df36ce9728a4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02f8ca3d49055788f112c17052a3da65feb01835
Message-Id: <172365289166.2319409.3503600854683589130.pr-tracker-bot@kernel.org>
Date: Wed, 14 Aug 2024 16:28:11 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 13 Aug 2024 16:43:07 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-6.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02f8ca3d49055788f112c17052a3da65feb01835

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

