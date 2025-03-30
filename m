Return-Path: <bpf+bounces-54902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0652DA75C43
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 23:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDF9168A94
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 21:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B531DE89C;
	Sun, 30 Mar 2025 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7Csb/T3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B318A6B0;
	Sun, 30 Mar 2025 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743368715; cv=none; b=YZfHucxfquZ6dMdTBb74U2zfOO9glsnQcH12ogCB1Lao0X6sNT37grIDWOyX4VK8kg+/QLMY7HF5ImV8VzBsP8lN5zzsVaYFVv3sYQEBvSudrix589G2pm3pJMEFGFmsyEQpF9Y4Tw2wK2L2A4VbVYPNSVNO5cfiIWBHKX4HUbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743368715; c=relaxed/simple;
	bh=w/qYlK1L5/+ougRius8bQPAiHYP4utsiOPviZ/mp58c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FOqGmDkCDmiEYmQvS8dQJr9L3h35x10OGJDTuVQklM4q4zTHjcnwyotG31S7NNDbs/KBGX3TLYv4O6um9Fma/YJ+8vtdZ+vNGsvcvBEjO7oVopJ7NKt8+q1F84iGJDolMUcnNCjrs+9tzuQZostY0cxrmQVWgujSq6YIQ1l6sig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7Csb/T3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B90C4CEDD;
	Sun, 30 Mar 2025 21:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743368715;
	bh=w/qYlK1L5/+ougRius8bQPAiHYP4utsiOPviZ/mp58c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P7Csb/T3mB/gnxCTTL13sBdoRm78QAs872OqSlkCyoXh6LP1llvhG4BDYu6pl1WJ/
	 7prVafo6jw6RLhGKZKeEJJkfI/ir3tbrIXG8Ovi8SIUQAStAmzLCqeuVkkqFW5IG1j
	 Gfh+4Q/I7UUEtl2u8ZFR5yjY6UA0aAZby9iTWZvorH+DTR6DkYt2kULtLHXvzje3Er
	 +yrqPDCmRD0KcQg2BO9a0ax/HNov/VPo46Po0hcTl1QgqNDJJEQaUH2dzgU4dmYAmV
	 OpuTUZg9WjeRbmSPHjO5Ow4XHzTWBQvFmX4KHQ48zxW9fv80pZKpEVURBAZyWc1loj
	 GQJVJHx91zfVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712EC380AA7A;
	Sun, 30 Mar 2025 21:05:53 +0000 (UTC)
Subject: Re: [GIT PULL] BPF resilient spin_lock for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250327144823.99186-1-alexei.starovoitov@gmail.com>
References: <20250327144823.99186-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250327144823.99186-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf_res_spin_lock
X-PR-Tracked-Commit-Id: 6ffb9017e9329168b3b4216d15def8e78e1b1fac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 494e7fe591bf834d57c6607cdc26ab8873708aa7
Message-Id: <174336875198.3547747.7647221152816620619.pr-tracker-bot@kernel.org>
Date: Sun, 30 Mar 2025 21:05:51 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, peterz@infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Mar 2025 10:48:23 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf_res_spin_lock

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/494e7fe591bf834d57c6607cdc26ab8873708aa7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

