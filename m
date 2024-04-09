Return-Path: <bpf+bounces-26315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6AE89E1B0
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 19:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB09B21113
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990E7156678;
	Tue,  9 Apr 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/G5C83T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D164C85
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712684429; cv=none; b=McR3gYjdp5mykvGCUdP2HjeTlCzLPrF5WVZx+GZhyMEMRJKJ6eauXniXH54YsZa3p85fqichDKjBIIsJOm2A4aqoCSZRfuOyeUpW8oMIN4QnGYlfPdR7VV7Ak6tEWC/QQr0505IDmgiyJbRvOXPlw6VZ+qpoMM06EsFjZ1111N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712684429; c=relaxed/simple;
	bh=nV2oKy13AXr4kD5+qdBvCXPafWccMosBntSXY2M/oM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r/Q9w2nwlSrmYqUM7orZz//bWicMsNHNxXqbbHRhDnJKpVLI5vH6wAJXOFPwa4taFZOUOAH2QVc1EM7E+0mnmUvtl8azfD/8ALAKr0rh2lgqUqD+kRmfig4zOoT+4uUaJCKBoBM1LLWwiJ36XO+LyI3p9NstyzFRYdmoNHUMJVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/G5C83T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2DDEC433C7;
	Tue,  9 Apr 2024 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712684428;
	bh=nV2oKy13AXr4kD5+qdBvCXPafWccMosBntSXY2M/oM0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D/G5C83T3BndIE+MVZRjyWBDu0eK56+gMCBQuq9m6DWEkcliiZHaznovO2bFOS4Fc
	 rmDkDuH/juot8Je181+dCUEd9ihBj21ZSewOG9a4sAvqAwUrchBx8e+HmngU6ADyq5
	 mkV3Mtg4JyXeqy6aR8Cl3Eg7u/FdECV4llsq/nLtPsOLaXyCJ9+jkmjJA9K2oauvIF
	 Bvl1n/KJ12C0+VABD8muimF+pbVusQFkeM0A3W9NsDwR92JRbhhM7yi7vWWpke7aZh
	 K2eioWCo8JfamYL3phOjgTrp9h/8sj+Rl80aAhVn5yO5yXITbnmGAxnk4NaV0hxwtp
	 vpneJfpI9DM6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93BBBC395F6;
	Tue,  9 Apr 2024 17:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Add support for certain atomics in
 bpf_arena to x86 JIT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171268442859.13915.577516884304371123.git-patchwork-notify@kernel.org>
Date: Tue, 09 Apr 2024 17:40:28 +0000
References: <20240405231134.17274-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240405231134.17274-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
 puranjay@kernel.org, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri,  5 Apr 2024 16:11:33 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Support atomics in bpf_arena that can be JITed as a single x86 instruction.
> Instructions that are JITed as loops are not supported at the moment,
> since they require more complex extable and loop logic.
> 
> JITs can choose to do smarter things with bpf_jit_supports_insn().
> Like arm64 may decide to support all bpf atomics instructions
> when emit_lse_atomic is available and none in ll_sc mode.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Add support for certain atomics in bpf_arena to x86 JIT
    https://git.kernel.org/bpf/bpf-next/c/d503a04f8bc0
  - [bpf-next,2/2] selftests/bpf: Add tests for atomics in bpf_arena.
    https://git.kernel.org/bpf/bpf-next/c/d0a2ba197bcb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



