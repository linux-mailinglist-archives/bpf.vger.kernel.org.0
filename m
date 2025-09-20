Return-Path: <bpf+bounces-69117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ECFB8D223
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 01:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4277AFC82
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 22:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15C928313A;
	Sat, 20 Sep 2025 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgYaQbl1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A8B1A704B
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758409208; cv=none; b=mA1aY5OkZFDcCepLliiWlhautuvIWXVMpbK4oCR5ySqYJ/XJXP5Wr43sw4mSiAO2KH052YwHwYVcp85A7pGxKMdSdGlknrxA1DIzv2j+qQXVt2Nfqj6CeYuc2I5lw/5VM/3jvF/AIevcVnz0Bro30CA71aW9fQn4PHVtBSx5MXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758409208; c=relaxed/simple;
	bh=oJkktscVmvOLgfBv3zWX4TPIsRUR/mzN9v1FmZB5dGM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ryVl4yIQQNqz2qyvdbmOplTOqviL5PVzMiBsdgPC45BQPloIPFpa1k4jKUKtKjuc3hXU1s61lVBePZUVTgt+QDl/+cQ2gEiB9Vw/UhBsEGC+syNI68f67oA41KcUjEylLNVV8PVQkzG3t34QLRmrMDlqKu2a3MBdYGr4K788l6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgYaQbl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1637C4CEEB;
	Sat, 20 Sep 2025 23:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758409207;
	bh=oJkktscVmvOLgfBv3zWX4TPIsRUR/mzN9v1FmZB5dGM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sgYaQbl1I9AW5yfHcMYbxVhwupCDRVEK8NIeuyHCUWrmv2AzTciIqgeWuBx7Tear8
	 cLuO8tOCQd2cD5Hh861F0ppp87F9uIePfWmDkwtSqrkugTUDOz7cUnw8mOvfTvgdZp
	 PDP6whQ6vRX/te4oh6yrcSJEhh9SbGYcGDECNxdX/Qci2BLXXz5x1mkeOr7QlgIcnx
	 ACBM6Yuyzkw+cRz6Snp3EvMgs/ZfjuG2ZqJbOGLyoClUgo5G1Cfss5dOksEwhVaw5h
	 /hNsW31mSsNIPRdxrYUmaqzEHJ5g3R0uWkJcE7jfBqSL/CMLfXEO/UKppb3Sen71mc
	 V6e1f4Agjw5/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF1139D0C20;
	Sat, 20 Sep 2025 23:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix selftest verifier_arena_large
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175840920651.4006312.8663001268461878820.git-patchwork-notify@kernel.org>
Date: Sat, 20 Sep 2025 23:00:06 +0000
References: <20250920045805.3288551-1-yonghong.song@linux.dev>
In-Reply-To: <20250920045805.3288551-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 19 Sep 2025 21:58:05 -0700 you wrote:
> With latest llvm22, I got the following verification failure:
> 
>   ...
>   ; int big_alloc2(void *ctx) @ verifier_arena_large.c:207
>   0: (b4) w6 = 1                        ; R6_w=1
>   ...
>   ; if (err) @ verifier_arena_large.c:233
>   53: (56) if w6 != 0x0 goto pc+62      ; R6=0
>   54: (b7) r7 = -4                      ; R7_w=-4
>   55: (18) r8 = 0x7f4000000000          ; R8_w=scalar()
>   57: (bf) r9 = addr_space_cast(r8, 0, 1)       ; R8_w=scalar() R9_w=arena
>   58: (b4) w6 = 5                       ; R6_w=5
>   ; pg = page[i]; @ verifier_arena_large.c:238
>   59: (bf) r1 = r7                      ; R1_w=-4 R7_w=-4
>   60: (07) r1 += 4                      ; R1_w=0
>   61: (79) r2 = *(u64 *)(r9 +0)         ; R2_w=scalar() R9_w=arena
>   ; if (*pg != i) @ verifier_arena_large.c:239
>   62: (bf) r3 = addr_space_cast(r2, 0, 1)       ; R2_w=scalar() R3_w=arena
>   63: (71) r3 = *(u8 *)(r3 +0)          ; R3_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
>   64: (5d) if r1 != r3 goto pc+51       ; R1_w=0 R3_w=0
>   ; bpf_arena_free_pages(&arena, (void __arena *)pg, 2); @ verifier_arena_large.c:241
>   65: (18) r1 = 0xff11000114548000      ; R1_w=map_ptr(map=arena,ks=0,vs=0)
>   67: (b4) w3 = 2                       ; R3_w=2
>   68: (85) call bpf_arena_free_pages#72675      ;
>   69: (b7) r1 = 0                       ; R1_w=0
>   ; page[i + 1] = NULL; @ verifier_arena_large.c:243
>   70: (7b) *(u64 *)(r8 +8) = r1
>   R8 invalid mem access 'scalar'
>   processed 61 insns (limit 1000000) max_states_per_insn 0 total_states 6 peak_states 6 mark_read 2
>   =============
>   #489/5   verifier_arena_large/big_alloc2:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix selftest verifier_arena_large failure
    https://git.kernel.org/bpf/bpf-next/c/5a427fddec5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



