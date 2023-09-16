Return-Path: <bpf+bounces-10207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 763857A317C
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 18:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07F3281598
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA041B291;
	Sat, 16 Sep 2023 16:50:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2714A82
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 16:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CD88C433C9;
	Sat, 16 Sep 2023 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694883028;
	bh=LOYfnDwpHjX2JU/B9zOnPjqDvtu8VFNEV6CXvGTqUmA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N32mg4Aed6BaSOYI0NXDV3CAqxyNg/IJVhLsowc32dXRYrA7TgNfPH8SA6yiWLsok
	 VsLGrdmWZgRhdMKCkBDVNPuqr9IjrLnK8AkD5fIIDaRb07Hy+fDCVYkhYD/FUzmP26
	 7NS7q3T7eBvlu3DFxSXt0vGj8PKHKlU898bJFRGhAs+GGlLjsazUZC1n1+aRtzX8NF
	 TgryCt/C0jBjTrrBW4kaIfZAWtWcetb0X8C4eJmxATrILaC6AaVbKUjVRCHFEXOgFW
	 vyEcHV4wYvoumHHHGA4NTmYohb0FyfNTni19IXwVX5OgxLaUzr/zzhlHWLu0346FbT
	 AfRUc0+QM/8lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23050E26881;
	Sat, 16 Sep 2023 16:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/17] Exceptions - 1/2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169488302813.9993.1749281452983981290.git-patchwork-notify@kernel.org>
Date: Sat, 16 Sep 2023 16:50:28 +0000
References: <20230912233214.1518551-1-memxor@gmail.com>
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
 void@manifault.com, puranjay12@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 13 Sep 2023 01:31:57 +0200 you wrote:
> This series implements the _first_ part of the runtime and verifier
> support needed to enable BPF exceptions. Exceptions thrown from programs
> are processed as an immediate exit from the program, which unwinds all
> the active stack frames until the main stack frame, and returns to the
> BPF program's caller. The ability to perform this unwinding safely
> allows the program to test conditions that are always true at runtime
> but which the verifier has no visibility into.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/17] bpf: Use bpf_is_subprog to check for subprogs
    https://git.kernel.org/bpf/bpf-next/c/9af27da6313c
  - [bpf-next,v3,02/17] arch/x86: Implement arch_bpf_stack_walk
    https://git.kernel.org/bpf/bpf-next/c/fd5d27b70188
  - [bpf-next,v3,03/17] bpf: Implement support for adding hidden subprogs
    https://git.kernel.org/bpf/bpf-next/c/335d1c5b5452
  - [bpf-next,v3,04/17] bpf: Implement BPF exceptions
    https://git.kernel.org/bpf/bpf-next/c/f18b03fabaa9
  - [bpf-next,v3,05/17] bpf: Refactor check_btf_func and split into two phases
    https://git.kernel.org/bpf/bpf-next/c/aaa619ebccb2
  - [bpf-next,v3,06/17] bpf: Add support for custom exception callbacks
    https://git.kernel.org/bpf/bpf-next/c/b9ae0c9dd0ac
  - [bpf-next,v3,07/17] bpf: Perform CFG walk for exception callback
    https://git.kernel.org/bpf/bpf-next/c/b62bf8a5e911
  - [bpf-next,v3,08/17] bpf: Treat first argument as return value for bpf_throw
    https://git.kernel.org/bpf/bpf-next/c/a923819fb2c5
  - [bpf-next,v3,09/17] mm: kasan: Declare kasan_unpoison_task_stack_below in kasan.h
    https://git.kernel.org/bpf/bpf-next/c/7ccb84f04cda
  - [bpf-next,v3,10/17] bpf: Prevent KASAN false positive with bpf_throw
    https://git.kernel.org/bpf/bpf-next/c/ec5290a178b7
  - [bpf-next,v3,11/17] bpf: Detect IP == ksym.end as part of BPF program
    https://git.kernel.org/bpf/bpf-next/c/66d9111f3517
  - [bpf-next,v3,12/17] bpf: Disallow fentry/fexit/freplace for exception callbacks
    https://git.kernel.org/bpf/bpf-next/c/fd548e1a4618
  - [bpf-next,v3,13/17] bpf: Fix kfunc callback register type handling
    https://git.kernel.org/bpf/bpf-next/c/06d686f771dd
  - [bpf-next,v3,14/17] libbpf: Refactor bpf_object__reloc_code
    https://git.kernel.org/bpf/bpf-next/c/6c918709bd30
  - [bpf-next,v3,15/17] libbpf: Add support for custom exception callbacks
    https://git.kernel.org/bpf/bpf-next/c/7e2925f67237
  - [bpf-next,v3,16/17] selftests/bpf: Add BPF assertion macros
    https://git.kernel.org/bpf/bpf-next/c/d6ea06803212
  - [bpf-next,v3,17/17] selftests/bpf: Add tests for BPF exceptions
    https://git.kernel.org/bpf/bpf-next/c/d2a93715bfb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



