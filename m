Return-Path: <bpf+bounces-15497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7777F2480
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 04:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B048B1C2187D
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 03:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA196154AE;
	Tue, 21 Nov 2023 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nwio0uFc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590614ABA
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 03:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3185C433C9;
	Tue, 21 Nov 2023 03:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700536225;
	bh=ETNTRngyLczj0NJqTWDSdlcaPzWPnzte11JQufL48ec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nwio0uFcR97mAYVT/Xf9eCufiDOf7veO0IBzC33VowaFTDQwQjwbMsChormCQG+wa
	 E3x2gT3c68wPBEGsS8uZDAhhHW5Jxr+C8L25b08qqctsy0HhBrx9RW/YEg7IuS8tCq
	 LybHT3Bty41xe/FR46h3r40EQ1KA4etIwVKY7dkuvF6+j6XI/L/hTVhbGtRJL0Jpp/
	 HM7WqqcyVprX3DIGLrysnpArcT/rBMYevFXfuEOtI4kA+ghk8G/t+cTDok23M6z57v
	 4QlPqpUqwM6WftRhwggDo4NkSwog3mbAJbzcjF8fqBhe6nPGQArcCrwPYlp+YcaKuf
	 I6eVab87DDIRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8EC3EAA959;
	Tue, 21 Nov 2023 03:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 00/11] verify callbacks as if they are called unknown
 number of times
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170053622568.18568.10821625949332133695.git-patchwork-notify@kernel.org>
Date: Tue, 21 Nov 2023 03:10:25 +0000
References: <20231121020701.26440-1-eddyz87@gmail.com>
In-Reply-To: <20231121020701.26440-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 21 Nov 2023 04:06:50 +0200 you wrote:
> This series updates verifier logic for callback functions handling.
> Current master simulates callback body execution exactly once,
> which leads to verifier not detecting unsafe programs like below:
> 
>     static int unsafe_on_zero_iter_cb(__u32 idx, struct num_context *ctx)
>     {
>         ctx->i = 0;
>         return 0;
>     }
> 
> [...]

Here is the summary with links:
  - [bpf,v4,01/11] selftests/bpf: track tcp payload offset as scalar in xdp_synproxy
    https://git.kernel.org/bpf/bpf/c/977bc146d4eb
  - [bpf,v4,02/11] selftests/bpf: track string payload offset as scalar in strobemeta
    https://git.kernel.org/bpf/bpf/c/87eb0152bcc1
  - [bpf,v4,03/11] selftests/bpf: fix bpf_loop_bench for new callback verification scheme
    https://git.kernel.org/bpf/bpf/c/f40bfd167944
  - [bpf,v4,04/11] bpf: extract __check_reg_arg() utility function
    https://git.kernel.org/bpf/bpf/c/683b96f9606a
  - [bpf,v4,05/11] bpf: extract setup_func_entry() utility function
    https://git.kernel.org/bpf/bpf/c/58124a98cb8e
  - [bpf,v4,06/11] bpf: verify callbacks as if they are called unknown number of times
    https://git.kernel.org/bpf/bpf/c/ab5cfac139ab
  - [bpf,v4,07/11] selftests/bpf: tests for iterating callbacks
    https://git.kernel.org/bpf/bpf/c/958465e217db
  - [bpf,v4,08/11] bpf: widening for callback iterators
    https://git.kernel.org/bpf/bpf/c/cafe2c21508a
  - [bpf,v4,09/11] selftests/bpf: test widening for iterating callbacks
    https://git.kernel.org/bpf/bpf/c/9f3330aa644d
  - [bpf,v4,10/11] bpf: keep track of max number of bpf_loop callback iterations
    https://git.kernel.org/bpf/bpf/c/bb124da69c47
  - [bpf,v4,11/11] selftests/bpf: check if max number of bpf_loop iterations is tracked
    https://git.kernel.org/bpf/bpf/c/57e2a52deeb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



