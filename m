Return-Path: <bpf+bounces-68151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA92EB536CF
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 17:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6805A6E58
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9143834A307;
	Thu, 11 Sep 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfqRsG56"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEA4346A0E
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602806; cv=none; b=FMGYa+iNmiJyoll4pFWKJbewxnz9d14AF78El/wxUlW1QF7dD5aUCIAbGtjtzEI5RO5d0UOGFramokEor1R1Z17JQ2JbCQFSY9goTpI7ZP89rysN2KvH9m517vSVLatiqPrkT/e0iftxWZbCsFQ2rxjCK4kyvnL2B93NPJg4bms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602806; c=relaxed/simple;
	bh=0aeYnuW1k1CMCvjOUQ1n4kNNkF88cDR22rmea35R+HY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oXG1/UEqsqLgk1NP2Bfob50WD5akEscZlXbvQdKzlnskB/XWOEGy/WvbpN0jGx0/S28cJPzoshXKwP58qACf3s74P2gdI9/q+EGyq4/sO+FqwIDo/9srrDZsDMwheC3TSY3c+14GXiOTwNnjemjS/zqVdjTPZZA+uB3QRBZ2j4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfqRsG56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827ADC4CEF0;
	Thu, 11 Sep 2025 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757602805;
	bh=0aeYnuW1k1CMCvjOUQ1n4kNNkF88cDR22rmea35R+HY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CfqRsG56pBEgGkc4dNXWKKwir0/Vn43Yo6zR1iixpsk0m9joyF382P+dIccdnOyCV
	 6u5aq5jsz4aa2KXzdSjTLzyL+bBaadoJACAtb7WQ0G1AJVKdkg3N722TQ+h51afv/W
	 6B8warlQZObDIW9JlcQIXbzi7iL+OtUcFdxeE1CUSpn8VXX7dFN65+j4kDz1o9qjgu
	 yW1aKJB2jXSx+24Yuxe6Xct7iLcB/zS9tyy68HSmAeOD1PnHI8qgkeqfCf2mfv9dUp
	 sDbl5aRf4PVlx4E3NKN70o9CBDga1wMwLrwAZv9LR2vj3lBLuUW5Yps8ZBihigd5rX
	 KqjLe4HzcH73w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7135A383BF69;
	Thu, 11 Sep 2025 15:00:09 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.17-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250910231250.3511-1-alexei.starovoitov@gmail.com>
References: <20250910231250.3511-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250910231250.3511-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 91f34aaae06e425e4644afde92ddff949b6abb54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02ffd6f89c50ca0bff0c4578949ff99e70451757
Message-Id: <175760280827.2208976.2525984898818567704.pr-tracker-bot@kernel.org>
Date: Thu, 11 Sep 2025 15:00:08 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Sep 2025 16:12:50 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02ffd6f89c50ca0bff0c4578949ff99e70451757

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

