Return-Path: <bpf+bounces-11402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 333967B8E33
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 22:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id A1CF4B209A0
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 20:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A9722EEA;
	Wed,  4 Oct 2023 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf6hXVPc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645E715EAE;
	Wed,  4 Oct 2023 20:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A3EAC433C9;
	Wed,  4 Oct 2023 20:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696452028;
	bh=f2fF4KyVL+tXFaEf7vQScf7IfzEATIaUoOk5l4h8FiI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kf6hXVPcX37XY/EN5HgPArGFomT2FdPTwal6hLk6IxxAGggpsaEO0/NypURvL70z7
	 LAw1SyZ2AXVfjQvWV68tMOUgaaGUjjbFFj3VLkl92Ah6qUFEt8tZgbtOODMNUdWCQ8
	 lqw/VvKXwTdxqJITTmr6SNOxiZudX79bwpxLmzbZT+DWDUWtnxBhtf9DykUXwoDbX7
	 js8jH28g8tOwBTvx918Fm5vVZAtswEjp4iKovfxhk/E686FwWPGhmOcSTztGTfu8Rv
	 6nCMSd09Tn7jZytQz0kNUcFJDo34XIdjyFTnWmKgpwWjO8cUJLtRSM/Uh7nT2dwMZt
	 GhJWXz8buv5AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09201E632D6;
	Wed,  4 Oct 2023 20:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/3] libbpf/selftests syscall wrapper fixes for RISC-V
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169645202802.14504.10210722670650849429.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 20:40:28 +0000
References: <20231004110905.49024-1-bjorn@kernel.org>
In-Reply-To: <20231004110905.49024-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, mykolal@fb.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@rivosinc.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 samitolvanen@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  4 Oct 2023 13:09:02 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers") introduced
> some regressions in libbpf, and the kselftests BPF suite, which are
> fixed with these three patches.
> 
> Note that there's an outstanding fix [1] for ftrace syscall tracing
> which is also a fallout from the commit above.
> 
> [...]

Here is the summary with links:
  - [bpf,1/3] libbpf: Fix syscall access arguments on riscv
    https://git.kernel.org/bpf/bpf-next/c/8a412c5c1cd6
  - [bpf,2/3] selftests/bpf: Define SYS_PREFIX for riscv
    https://git.kernel.org/bpf/bpf-next/c/0f2692ee4324
  - [bpf,3/3] selftests/bpf: Define SYS_NANOSLEEP_KPROBE_NAME for riscv
    https://git.kernel.org/bpf/bpf-next/c/b55b775f0316

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



