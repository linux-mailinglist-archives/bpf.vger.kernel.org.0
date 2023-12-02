Return-Path: <bpf+bounces-16519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92657801E5A
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 20:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED2EB20B76
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 19:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A38A21114;
	Sat,  2 Dec 2023 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC5De0wv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8EC21108
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 19:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDDACC433CA;
	Sat,  2 Dec 2023 19:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701546624;
	bh=F7t3KhEQ4/3338PlP3jqGwIjQarcvYhQtV9l1QPVWEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nC5De0wvVJb2Xkr4e1sz2l+PAiMaKKb7oj920lzfPqt9JisqK0wEgAGEWgpyOG86a
	 BOW8crCirvPjdh0ceK5jPh3LNt+mSRaFkH45bZYrsrbQgUFhJMbRNrbwXnOpkFkvSH
	 n5A0YohiYzEDW2FfoqSAHT1UC0IOgFl9PKYoRip5YozXQiI75H43YJM2cfUUR6unsZ
	 kw5z2F2/Hnyh2oWNZ/25hHPuMmMvj44wGf9e5T3nHeLowlOG7UVAas2oXQalqJZ7ra
	 PNYeqfHVpLxICUXs832m3aLzieU5Vo8Bruvs13i2LnPrMY7OT/tFGgbPsDto59Twlw
	 ALwLkRfXnbyqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5059C73FE4;
	Sat,  2 Dec 2023 19:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 bpf-next 00/11] BPF verifier retval logic fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170154662480.24068.17331374520976496931.git-patchwork-notify@kernel.org>
Date: Sat, 02 Dec 2023 19:50:24 +0000
References: <20231202175705.885270-1-andrii@kernel.org>
In-Reply-To: <20231202175705.885270-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 2 Dec 2023 09:56:54 -0800 you wrote:
> This patch set fixes BPF verifier logic around validating and enforcing return
> values for BPF programs that have specific range of expected return values.
> Both sync and async callbacks have similar logic and are fixes as well.
> A few tests are added that would fail without the fixes in this patch set.
> 
> Also, while at it, we update retval checking logic to use smin/smax range
> instead of tnum, avoiding future potential issues if expected range cannot be
> represented precisely by tnum (e.g., [0, 2] is not representable by tnum and
> is treated as [0, 3]).
> 
> [...]

Here is the summary with links:
  - [v5,bpf-next,01/11] bpf: rearrange bpf_func_state fields to save a bit of memory
    https://git.kernel.org/bpf/bpf-next/c/45b5623f2d72
  - [v5,bpf-next,02/11] bpf: provide correct register name for exception callback retval check
    https://git.kernel.org/bpf/bpf-next/c/5fad52bee304
  - [v5,bpf-next,03/11] bpf: enforce precision of R0 on callback return
    https://git.kernel.org/bpf/bpf-next/c/0acd03a5bd18
  - [v5,bpf-next,04/11] bpf: enforce exact retval range on subprog/callback exit
    https://git.kernel.org/bpf/bpf-next/c/8fa4ecd49b81
  - [v5,bpf-next,05/11] selftests/bpf: add selftest validating callback result is enforced
    https://git.kernel.org/bpf/bpf-next/c/60a6b2c78c62
  - [v5,bpf-next,06/11] bpf: enforce precise retval range on program exit
    https://git.kernel.org/bpf/bpf-next/c/c871d0e00f0e
  - [v5,bpf-next,07/11] bpf: unify async callback and program retval checks
    https://git.kernel.org/bpf/bpf-next/c/0ef24c8dfae2
  - [v5,bpf-next,08/11] bpf: enforce precision of R0 on program/async callback return
    https://git.kernel.org/bpf/bpf-next/c/eabe518de533
  - [v5,bpf-next,09/11] selftests/bpf: validate async callback return value check correctness
    https://git.kernel.org/bpf/bpf-next/c/e02dea158dda
  - [v5,bpf-next,10/11] selftests/bpf: adjust global_func15 test to validate prog exit precision
    https://git.kernel.org/bpf/bpf-next/c/5c19e1d05e9e
  - [v5,bpf-next,11/11] bpf: simplify tnum output if a fully known constant
    https://git.kernel.org/bpf/bpf-next/c/81eff2e36481

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



