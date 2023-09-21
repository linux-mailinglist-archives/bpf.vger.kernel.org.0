Return-Path: <bpf+bounces-10595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC8B7AA2E2
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 23:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A264D1C2097A
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB98D199C3;
	Thu, 21 Sep 2023 21:40:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392CC19466
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 21:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AA5CC433CB;
	Thu, 21 Sep 2023 21:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695332424;
	bh=Qc8rx3F+0rN7S4qDCSM0ZCtXG6WvxlY3+WfenY00q6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YiJTRqO6wQA8OlsF5ziV0gzcOCHx0sRexXFIkD4bsW0LdUU8Z27oCtMFMnYgJnuy9
	 JNUbBdO5HmNHA7GcwbBQhFKnjMDEailM54t8/1RMIvaaWW94421zrxE9QwnUe6hJ+V
	 WcE1a+WRCFjstHgIKcJNtMIrEtWwC8lN0BH7Wxj7VvnyKdG+WiLHwszREPStOw7fhb
	 perCudGLFd2bhdqxHo9Qd/cFdmdTDQyZT+DlvYOyUHnb4OnE6D0Np0dGztei5VgozL
	 PlM6oUGpA8lLDIjhrFNi/k0qKtIQN/6jRSG/LAOze/GPu+FQ1G4cdLwpFKjADNn4yI
	 ihDc6Z3Ypgu+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D6E6E11F40;
	Thu, 21 Sep 2023 21:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/3] samples/bpf: syscall_tp_user: Refactor and fix
 array index out-of-bounds bug
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169533242450.16047.2107207715402513013.git-patchwork-notify@kernel.org>
Date: Thu, 21 Sep 2023 21:40:24 +0000
References: <20230917214220.637721-1-jinghao7@illinois.edu>
In-Reply-To: <20230917214220.637721-1-jinghao7@illinois.edu>
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, jinghao@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 17 Sep 2023 16:42:17 -0500 you wrote:
> There are currently 6 BPF programs in syscall_tp_kern but the array to
> hold the corresponding bpf_links in syscall_tp_user only has space for 4
> programs, given the array size is hardcoded. This causes the sample
> program to fail due to an out-of-bound access that corrupts other stack
> variables:
> 
>   # ./syscall_tp
>   prog #0: map ids 4 5
>   verify map:4 val: 5
>   map_lookup failed: Bad file descriptor
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/3] samples/bpf: Add -fsanitize=bounds to userspace programs
    (no matching commit)
  - [bpf,v2,2/3] samples/bpf: syscall_tp_user: Rename num_progs into nr_tests
    https://git.kernel.org/bpf/bpf-next/c/0ee352fe0d28
  - [bpf,v2,3/3] samples/bpf: syscall_tp_user: Fix array out-of-bound access
    https://git.kernel.org/bpf/bpf-next/c/9220c3ef6fef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



