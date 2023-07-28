Return-Path: <bpf+bounces-6149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701717661B8
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 04:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335032824FD
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF081C2B;
	Fri, 28 Jul 2023 02:20:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021157C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 02:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54AE4C433C9;
	Fri, 28 Jul 2023 02:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690510825;
	bh=QkMumUC3603YHuRiC2XRsYM3qk5vvMEVbXrevYBNH+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VosvN/FhLXDlFFM1B3rouXC9EsoBsIUQN9zPvS2flc/n562/7sE8dzMKxfl3+ZgmB
	 Zp9dZe2yUnXpYfDb0/k84glhcwvtehU2XUAFKoL6iENckvpoX+5LkkLTBj+zk2SYmc
	 c6IjPLlXCog5LEJvS/uEo3TFKL4KfYn+4IO+Va3M+IwrZfwZn81nWNvGvG9JUrgWGV
	 6isnZDgqWHG9KThUPjijIoGbHnJp9kSOyQeuSUDn+lj496jnlUF/ShH6u1eLYAt+B8
	 /Souhd+PJVT1AgqWkP5ioEnS4g3DFLgEocchgVQrEk4q4l3eNpGKRfjHqB1ibyoTv7
	 hiCBwNpY+D9OQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30F56C64459;
	Fri, 28 Jul 2023 02:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 00/17] bpf: Support new insns from cpu v4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169051082519.17308.14414996510040234538.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 02:20:25 +0000
References: <20230728011143.3710005-1-yonghong.song@linux.dev>
In-Reply-To: <20230728011143.3710005-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, david.faust@oracle.com,
 maskray@google.com, jose.marchesi@oracle.com, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 27 Jul 2023 18:11:43 -0700 you wrote:
> In previous discussion ([1]), it is agreed that we should introduce
> cpu version 4 (llvm flag -mcpu=v4) which contains some instructions
> which can simplify code, make code easier to understand, fix the
> existing problem, or simply for feature completeness. More specifically,
> the following new insns are proposed:
>   . sign extended load
>   . sign extended mov
>   . bswap
>   . signed div/mod
>   . ja with 32-bit offset
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,01/17] bpf: Support new sign-extension load insns
    https://git.kernel.org/bpf/bpf-next/c/1f9a1ea821ff
  - [bpf-next,v5,02/17] bpf: Support new sign-extension mov insns
    https://git.kernel.org/bpf/bpf-next/c/8100928c8814
  - [bpf-next,v5,03/17] bpf: Handle sign-extenstin ctx member accesses
    https://git.kernel.org/bpf/bpf-next/c/1f1e864b6555
  - [bpf-next,v5,04/17] bpf: Support new unconditional bswap instruction
    https://git.kernel.org/bpf/bpf-next/c/0845c3db7bf5
  - [bpf-next,v5,05/17] bpf: Support new signed div/mod instructions.
    https://git.kernel.org/bpf/bpf-next/c/ec0e2da95f72
  - [bpf-next,v5,06/17] bpf: Fix jit blinding with new sdiv/smov insns
    https://git.kernel.org/bpf/bpf-next/c/7058e3a31ee4
  - [bpf-next,v5,07/17] bpf: Support new 32bit offset jmp instruction
    https://git.kernel.org/bpf/bpf-next/c/4cd58e9af8b9
  - [bpf-next,v5,09/17] selftests/bpf: Fix a test_verifier failure
    https://git.kernel.org/bpf/bpf-next/c/86180493a2ef
  - [bpf-next,v5,10/17] selftests/bpf: Add a cpuv4 test runner for cpu=v4 testing
    https://git.kernel.org/bpf/bpf-next/c/a5d0c26a2784
  - [bpf-next,v5,11/17] selftests/bpf: Add unit tests for new sign-extension load insns
    https://git.kernel.org/bpf/bpf-next/c/147c8f4470ee
  - [bpf-next,v5,12/17] selftests/bpf: Add unit tests for new sign-extension mov insns
    https://git.kernel.org/bpf/bpf-next/c/f02ec3ff3f09
  - [bpf-next,v5,13/17] selftests/bpf: Add unit tests for new bswap insns
    https://git.kernel.org/bpf/bpf-next/c/79dbabc17540
  - [bpf-next,v5,14/17] selftests/bpf: Add unit tests for new sdiv/smod insns
    https://git.kernel.org/bpf/bpf-next/c/de1c26809ec3
  - [bpf-next,v5,15/17] selftests/bpf: Add unit tests for new gotol insn
    https://git.kernel.org/bpf/bpf-next/c/613dad498072
  - [bpf-next,v5,16/17] selftests/bpf: Test ldsx with more complex cases
    https://git.kernel.org/bpf/bpf-next/c/0c606571ae07
  - [bpf-next,v5,17/17] docs/bpf: Add documentation for new instructions
    https://git.kernel.org/bpf/bpf-next/c/245d4c40c09b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



