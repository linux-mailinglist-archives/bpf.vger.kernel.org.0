Return-Path: <bpf+bounces-54113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1E7A632CF
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 00:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3957A6CD5
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 22:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F041C6FE1;
	Sat, 15 Mar 2025 22:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBiVECmO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3208197A8B
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742079595; cv=none; b=SxC3mW70pcJ0CefNiLTDTYn9JPii9m3In8D8fLJqa0Yuf+d82bna07tWCXAOPm8k0B9F8lqmGnB4F+shWRUqH8QMZ30+Rk3ulddYb/FVvegDFO4VMFB3FGN147IYOpy6BoUs4wKL5UlCxCp9g6itRxOcdfEvK0ghtjaBmAuKigg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742079595; c=relaxed/simple;
	bh=Qj7ee2wB5VCpMlykRREoTfHolhqPCK2kDuRmhCf8DYA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ga87OIzE3ymbaJbfRhHdOjB1RE7fy33bbTgmLpQJoU/IXw9Nic62zN91TzNIfq4v1gPu/9fc92bvA5FZqxyxgBXYXiWmp+BinEknT/wXDa0FpaGEXp0RCph2AbQq+ok6rWhmRpa9Z2LUtrNcwEJ+p3xoS82quwU5ljy+sNeLev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBiVECmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799EFC4CEE5;
	Sat, 15 Mar 2025 22:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742079594;
	bh=Qj7ee2wB5VCpMlykRREoTfHolhqPCK2kDuRmhCf8DYA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LBiVECmOtHSas0bAJJ7L2h4w+JNMuYqZqTguRvbE1xn5ZonbomVifWuKXkrHlrjlH
	 YLQW1yvIG457kPJbHIP82mBtCRpaecplnHgvp4ehUjLpgJ6MySts107lycnPV6KOuB
	 vtYMdI8WCxWmVAN4yMbHCnHQAkWNjl3aTvvc/fMAOFKlHcTXdZCIlbZTV/mIDVWgTs
	 Hi8W+okJzJdJOPp3WGYEyu4qnST6IVEtaPNTXiyo/rCN39In2pL6hqLiymYCiSnF8q
	 /KtNrNwBxS+tVsH0Uzgn/WIq/1i9GoO0xmib1bHl3ySUlvI8/Mnn8BnqPvzK/ka8gG
	 y+fVKRnBrbcHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDA7380DBDD;
	Sat, 15 Mar 2025 23:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf, x86: Fix objtool warning for timed may_goto
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174207962951.2670890.4290092846660019802.git-patchwork-notify@kernel.org>
Date: Sat, 15 Mar 2025 23:00:29 +0000
References: <20250315013039.1625048-1-memxor@gmail.com>
In-Reply-To: <20250315013039.1625048-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, lkp@intel.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 14 Mar 2025 18:30:39 -0700 you wrote:
> Kernel test robot reported "call without frame pointer save/setup"
> warning in objtool. This will make stack traces unreliable on
> CONFIG_UNWINDER_FRAME_POINTER=y, however it works on
> CONFIG_UNWINDER_ORC=y. Fix this by creating a stack frame for the
> function.
> 
> Fixes: 2cb0a5215274 ("bpf, x86: Add x86 JIT support for timed may_goto")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503071350.QOhsHVaW-lkp@intel.com/
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpf, x86: Fix objtool warning for timed may_goto
    https://git.kernel.org/bpf/bpf-next/c/812f7702d83d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



