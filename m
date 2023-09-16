Return-Path: <bpf+bounces-10190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA4D7A2BEE
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 02:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BCD1C22B59
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 00:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACDC1104;
	Sat, 16 Sep 2023 00:20:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04304805
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 00:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A1BFC433C7;
	Sat, 16 Sep 2023 00:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694823627;
	bh=aH5tyAYEL3kLg9vBZZjNzL4RqVPEsfcrCBY/KRYWC7c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GjDTzI+9Me7Z6PEdcjYd1F6UXU/TjOYvayeSUwetO5Bkzf1DC9g5NSZtTk18O81zC
	 h1s8JikjN7tKd2IYAaDQXc6kIRfJ9b8Y2Z/KLWv0TahqJhbByS/q9p4nR4uHcE8NTh
	 AX3DOKEerB1IQy+QBE1EUuA4NWG30dHTXjvt5YskxgMmEsBwaXgSP/Ww6i/GtSXcGO
	 1vX6ZURGzlpEVLH763nTS5LlwsP+FyyMc0zMvDAfW9nCUKyKJHb0FMklFzb4+35WLV
	 MO+Ye5ZusY3ePLRDWKGjUSVsjX6BRhcK59IM48YRAaYRAix4r1NK0HRLw5EoA0pTMA
	 jfinHokmLGP6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C807E26880;
	Sat, 16 Sep 2023 00:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/9] arm32, bpf: add support for cpuv4 insns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169482362737.9889.296708577969456083.git-patchwork-notify@kernel.org>
Date: Sat, 16 Sep 2023 00:20:27 +0000
References: <20230907230550.1417590-1-puranjay12@gmail.com>
In-Reply-To: <20230907230550.1417590-1-puranjay12@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, illusionist.neo@gmail.com,
 linux@armlinux.org.uk, mykolal@fb.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  7 Sep 2023 23:05:41 +0000 you wrote:
> Changes in V2 -> V3
> - Added comments at places where there could be confustion.
> - In the patch for DIV64, fix the if-else case that would never run.
> - In the same patch use a single instruction to POP caller saved regs.
> - Add a patch to change maintainership of ARM32 BPF JIT.
> 
> Changes in V1 -> V2:
> - Fix coding style issues.
> - Don't use tmp variable for src in emit_ldsx_r() as it is redundant.
> - Optimize emit_ldsx_r() when offset can fit in immediate.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/9] arm32, bpf: add support for 32-bit offset jmp instruction
    https://git.kernel.org/bpf/bpf-next/c/471f3d4ee4a6
  - [bpf-next,v3,2/9] arm32, bpf: add support for sign-extension load instruction
    https://git.kernel.org/bpf/bpf-next/c/f9e6981b1f1c
  - [bpf-next,v3,3/9] arm32, bpf: add support for sign-extension mov instruction
    https://git.kernel.org/bpf/bpf-next/c/fc832653fa0d
  - [bpf-next,v3,4/9] arm32, bpf: add support for unconditional bswap instruction
    https://git.kernel.org/bpf/bpf-next/c/1cfb7eaebeac
  - [bpf-next,v3,5/9] arm32, bpf: add support for 32-bit signed division
    https://git.kernel.org/bpf/bpf-next/c/5097faa559a6
  - [bpf-next,v3,6/9] arm32, bpf: add support for 64 bit division instruction
    https://git.kernel.org/bpf/bpf-next/c/71086041c2ba
  - [bpf-next,v3,7/9] selftest, bpf: enable cpu v4 tests for arm32
    https://git.kernel.org/bpf/bpf-next/c/59ff6d63b730
  - [bpf-next,v3,8/9] bpf/tests: add tests for cpuv4 instructions
    https://git.kernel.org/bpf/bpf-next/c/daabb2b098e0
  - [bpf-next,v3,9/9] MAINTAINERS: Add myself for ARM32 BPF JIT maintainer.
    https://git.kernel.org/bpf/bpf-next/c/9b31b4f1d4ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



