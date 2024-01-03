Return-Path: <bpf+bounces-18900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6576823598
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E67A28756A
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4931CAB6;
	Wed,  3 Jan 2024 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5b5qGja"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C1C1CA82
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 19:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92854C433C8;
	Wed,  3 Jan 2024 19:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704310226;
	bh=Hbio5FF42dVyBjynJE/+EGGSBy7y+JqIYzqxAU9+rvQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O5b5qGjaeEBYiUcIJM+4mkN569lITfnp1AdZ8aIzM7gjzbqEIpCLTbzAydOer6cKs
	 LB8hwLQXu07+BZdM+p8zk6vOwKLwplun5cXX87OZqIzPB594+xunc+aN1+6mTSAmt4
	 RqqyhvrI1vsxROVOTaxjEj4vwVLWta3aTjATy30HvBri2q9x1+SSjC5TXCICu2aQZL
	 786ZePgr10dPqBP7VzEnZC4W3g/nRewgrCOx96gzc5lwwck5voc/+9oYu1N0rJrzoN
	 gKOddy50MuTMv1nGU8ahSPnNsiMcqm3fw2v72nMRB1oA27TBs6LVhHZs1OZbQ+870t
	 30PXJ17rxi9aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 764A6C395C5;
	Wed,  3 Jan 2024 19:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/6] bpf: volatile compare
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170431022647.26799.17371619817816962113.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jan 2024 19:30:26 +0000
References: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, dxu@dxuuu.xyz, memxor@gmail.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 26 Dec 2023 11:11:42 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> v2->v3:
> Debugged profiler.c regression. It was caused by basic block layout.
> Introduce bpf_cmp_likely() and bpf_cmp_unlikely() macros.
> Debugged redundant <<=32, >>=32 with u32 variables. Added cast workaround.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/6] selftests/bpf: Attempt to build BPF programs with -Wsign-compare
    https://git.kernel.org/bpf/bpf-next/c/495d2d8133fd
  - [v3,bpf-next,2/6] bpf: Introduce "volatile compare" macros
    https://git.kernel.org/bpf/bpf-next/c/a8b242d77bd7
  - [v3,bpf-next,3/6] selftests/bpf: Convert exceptions_assert.c to bpf_cmp
    https://git.kernel.org/bpf/bpf-next/c/624cd2a17672
  - [v3,bpf-next,4/6] selftests/bpf: Remove bpf_assert_eq-like macros.
    https://git.kernel.org/bpf/bpf-next/c/907dbd3ede5f
  - [v3,bpf-next,5/6] bpf: Add bpf_nop_mov() asm macro.
    https://git.kernel.org/bpf/bpf-next/c/0bcc62aa9813
  - [v3,bpf-next,6/6] selftests/bpf: Convert profiler.c to bpf_cmp.
    https://git.kernel.org/bpf/bpf-next/c/7e3811cb998f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



