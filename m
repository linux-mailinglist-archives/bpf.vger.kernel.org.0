Return-Path: <bpf+bounces-33115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A3B917582
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 03:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D95F1F2368E
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F78D2F0;
	Wed, 26 Jun 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frbwpl6h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7232E28FA
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719364829; cv=none; b=hcX7cs8aQ3lzA/mUZoEHZyMTo7V1RLtZiRNuHHzp0h9EVNsAdWE/xTGRz4qX25eqb0TtBxLxlim61b+ryxQEuNMKBZ80QBaIoHE60AScOuxv849MmVkGo0/s9DMUWw6o95oh/sv+3yUKBtcn+Uuph1m72gqBDVwqqcowyqacRNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719364829; c=relaxed/simple;
	bh=bA4s941KjSvDs7bKCA2fi8Ie2NTWlMY0Agxsj4tmniQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gNPsMG6XVwu4L+OGkztLj6o1Th5Lknnft+YDLe5EDowxcYCeKuKe6iW+q2epbEryZMo5quPRFGRyEOGoVO+tnacWFlmC3N/1j7UV8D8L936Z5jcqeSfzHD2Be5DDJ+hQ7TmBJ4Wxu9T/vSr/MHZLRqrx6zmSBJsZDSM2QKCgnXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frbwpl6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF3B1C4AF07;
	Wed, 26 Jun 2024 01:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719364829;
	bh=bA4s941KjSvDs7bKCA2fi8Ie2NTWlMY0Agxsj4tmniQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=frbwpl6hV7aEhV2NDrIl3YuZlyJvgZlAi5CZmuNoc2aSYAYYRe8/noVp6oCdONU5y
	 LdUS/B1/pyg1P90JN9KqVR44htfUWM+eoJT3gtE+41Xh+pCqtrZh3ZHUar+9UoQ8WP
	 aif95tJXXThK+m/20jwZh18Mx7lD25Gwmt6ymf/Gr8Z6RZ9yORPwSCJ+/loBKRjP2i
	 mJfmZblZXMmRTIzuc5TPo5sbwqHTzktZRtzR9IWfLPeIEZkzEPSa7Lp5YugOo2jM8K
	 OeOuChxb8Z11WaawvSEF6IbFVKipD9H1bjBsip1gRYfwGrTeGhMzNUPDCfg/x89DfQ
	 Vu1dEBOS6xrhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE5BCDE8DF2;
	Wed, 26 Jun 2024 01:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix tailcall cases in test_bpf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171936482890.9672.3499810105297564812.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 01:20:28 +0000
References: <20240625145351.40072-1-hffilwlqm@gmail.com>
In-Reply-To: <20240625145351.40072-1-hffilwlqm@gmail.com>
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, oliver.sang@intel.com, kernel-patches-bot@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 25 Jun 2024 22:53:51 +0800 you wrote:
> Since f663a03c8e35 ("bpf, x64: Remove tail call detection"),
> tail_call_reachable won't be detected in x86 JIT. And, tail_call_reachable
> is provided by verifier.
> 
> Therefore, in test_bpf, the tail_call_reachable must be provided in test
> cases before running.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix tailcall cases in test_bpf
    https://git.kernel.org/bpf/bpf-next/c/d65f3767de20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



