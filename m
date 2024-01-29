Return-Path: <bpf+bounces-20603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDA88409F6
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 16:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C6C1C24D1D
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CE7153BDA;
	Mon, 29 Jan 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5gwh+QI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC517153BC8;
	Mon, 29 Jan 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542227; cv=none; b=duZ65ez1ipnOgbPt2hT+7g+e8WAsL8LHFyBDTlAomocFZmtyBNOOXUoJ3h/f0Qa3h2C/GI2k4zOYasQYEvwVEXpR2NxFZNk9GLGgEz7KC/6fN1Ns6I0994PY/xu342uv2FXSjivqVBL5WGp9sXD0gYfnrWlrLgP7Tuxb2gGNo4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542227; c=relaxed/simple;
	bh=ixi8kL7I86gBrHfmeQ/hZc+GdJatpUL8KGDJK72LYAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=muilmh1Erdnkg2j4j1U2PSG83lIijfNp/QhaFB0z8ngx31DNpRg7qnmu1OB0h6BC8iEhL/ce0/yAL8SvEQ7oorkfFEZS6KSfIKw/M9pHDLQzK3xSkZWOkVakVAEacKmj1HCDnKsuj06ktnXITsPe4N8bPE/1tZ8bZ8C6txedMvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5gwh+QI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85D23C433C7;
	Mon, 29 Jan 2024 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706542226;
	bh=ixi8kL7I86gBrHfmeQ/hZc+GdJatpUL8KGDJK72LYAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a5gwh+QIq4ZeTsxtmZ8+aIsNKWJ/brKgOggIog+p3Jk5uZqM1l8Qyrt6CL3F+aX72
	 bLF1Gyuk0+aeINi5T5tVR9gcNJgfoJ4hzC9HEIKaFpDfoXYQcn9B2toux7xLXLV0IP
	 Z0s1PUogO6Xa3EMQH1sVdWvVvMDb9hj85f5NaJt+hvKSdqdDTL1cThAIHywL1/IAPj
	 jgAHEJTfO1n5XwXaJHTGWRHnzEsuJ4tTyuzpmC5ya1qLJwUcud67O1hVNyZjdB85Ww
	 QR5ba/9MXfzlGJ8bfjYY8tM7FsCjn2a+GtsEUvoClIUMAA3kurhKvsxCy73h89Ta5U
	 jFsUYDN+CU14A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64CF4C3274C;
	Mon, 29 Jan 2024 15:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND bpf-next v3 0/6] Zbb support and code simplification
 for RV64 JIT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170654222640.3521.12964970085967863074.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 15:30:26 +0000
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
In-Reply-To: <20240115131235.2914289-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, palmer@dabbelt.com,
 conor@kernel.org, luke.r.nels@gmail.com, pulehui@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 15 Jan 2024 13:12:29 +0000 you wrote:
> Add Zbb support [0] to optimize code size and performance of RV64 JIT.
> Meanwhile, adjust the code for unification and simplification. Tests
> test_bpf.ko and test_verifier have passed, as well as the relative
> testcases of test_progs*.
> 
> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bitmanip-1.0.0-38-g865e7a7.pdf [0]
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf-next,v3,1/6] riscv, bpf: Unify 32-bit sign-extension to emit_sextw
    https://git.kernel.org/bpf/bpf-next/c/e33758f7493c
  - [RESEND,bpf-next,v3,2/6] riscv, bpf: Unify 32-bit zero-extension to emit_zextw
    https://git.kernel.org/bpf/bpf-next/c/914c7a5ff18a
  - [RESEND,bpf-next,v3,3/6] riscv, bpf: Simplify sext and zext logics in branch instructions
    https://git.kernel.org/bpf/bpf-next/c/361db44c3c59
  - [RESEND,bpf-next,v3,4/6] riscv, bpf: Add necessary Zbb instructions
    https://git.kernel.org/bpf/bpf-next/c/647b93f65daa
  - [RESEND,bpf-next,v3,5/6] riscv, bpf: Optimize sign-extention mov insns with Zbb support
    https://git.kernel.org/bpf/bpf-next/c/519fb722bea0
  - [RESEND,bpf-next,v3,6/6] riscv, bpf: Optimize bswap insns with Zbb support
    https://git.kernel.org/bpf/bpf-next/c/06a33d024838

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



