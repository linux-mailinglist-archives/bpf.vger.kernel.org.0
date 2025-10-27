Return-Path: <bpf+bounces-72324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF8BC0E365
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 15:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B8F14F7CB4
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 13:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C6530506D;
	Mon, 27 Oct 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgZBf7Gj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCA9302153;
	Mon, 27 Oct 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573140; cv=none; b=evz0ATt1CAJVkVzhwKwBbY2akzIR+ZChqawKcuRAuACGyrPngA3s3whpEb2WsQmvaouuhkgl/Ss0VFT8+Z8Q+w5qxBL1Ul11L+qsmMjU834k9OT9C8/L0HJju7rsgNVXIXyQLn7Yd2eJ6PSEMJVG/N0XDe/9wrO43in25CskqYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573140; c=relaxed/simple;
	bh=964A0S031oKo8PopELqRZPy7vrdlLfuZvsDRB1F8/tY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=alLbiU2WeZbAsfazUrAMmZgDpk7mPfRyzcYy7NhebYUE4oDgcTsFVBlAYb1O6uo8y1j4O7N0zxK3DLaIefQYAgX/bEeYXPSTs/LjBwjjFi5/7p5uNw0x4Tg6fBCLhXQ8XVXfdgLtODeaXtITf1VW+XSQrH+e4HkWcoO8OvYuUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgZBf7Gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA2EC4CEF1;
	Mon, 27 Oct 2025 13:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761573140;
	bh=964A0S031oKo8PopELqRZPy7vrdlLfuZvsDRB1F8/tY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=GgZBf7GjZRfMQCWgbuFwyGZ7NBwGk1KjXKeMykH/D6GTmHNSqMXGauVjO3ogSBzAZ
	 GJ2M94hVj720cVqii5lwceg2YIsLGKpcztk1Bawsa0Yt9q4GqOtXMxfCcJ6vrlUBmZ
	 50jFqnT7XX+vn6U38dtBWEZr7DYkA1f4u9JikQNNyqUA+o0V8TPCqIJB8kc4CJCB8s
	 meVYedAamN1AmB0CbdJJ64o7hgYZ+kvgAXQIoj2ocsrboCS9Ev4w7bT32DTl0GEYZa
	 Mqwr63+lPFpsL5ad/kaOWLpf9fv81qIB9r55zzSHFJDcgPl6acseG706VOmi6eYiKF
	 Jf4igkYNbwUyA==
Content-Type: multipart/mixed; boundary="===============5490698179867115379=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8227ad3af501bb982231ef00ac5e970a0a12c9d64e07ea3f3d37100ec7e3f1cc@mail.kernel.org>
In-Reply-To: <20251027131354.1984006-2-jolsa@kernel.org>
References: <20251027131354.1984006-2-jolsa@kernel.org>
Subject: Re: [PATCH 1/3] Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,mhiramat@kernel.org,rostedt@goodmis.org,jpoimboe@kernel.org
Cc: song@kernel.org,peterz@infradead.org,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,x86@kernel.org,yhs@fb.com,songliubraving@fb.com,andrii@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Oct 2025 13:52:18 +0000 (UTC)

--===============5490698179867115379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 26b06def1956497a15eecf22787d5430fad2fed6
Author: Jiri Olsa <jolsa@kernel.org>

Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"

This commit reverts a 2019 fix that ensured regs->ip is stored when
using non-HW regs (regs populated by perf_arch_fetch_caller_regs). The
revert claims the IP is captured during unwinding, but analysis suggests
otherwise.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 745caa6c1..fa6c47b50 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2789,13 +2789,13 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
>  		return;
>  	}
>
> -	if (perf_callchain_store(entry, regs->ip))
> -		return;
> -
> -	if (perf_hw_regs(regs))
> +	if (perf_hw_regs(regs)) {
> +		if (perf_callchain_store(entry, regs->ip))
> +			return;
>  		unwind_start(&state, current, regs, NULL);
> -	else
> +	} else {
>  		unwind_start(&state, current, NULL, (void *)regs->sp);
> +	}

When perf_hw_regs(regs) returns false (which happens when regs comes from
perf_arch_fetch_caller_regs since it sets regs->flags=0), the else branch
calls unwind_start with regs=NULL. Can this lose the regs->ip value?

Looking at the code flow:

perf_arch_fetch_caller_regs() sets:
  - regs->ip = CALLER_ADDR0 (the caller's instruction pointer)
  - regs->flags = 0 (no X86_EFLAGS_FIXED)

perf_hw_regs() checks:
  - returns (regs->flags & X86_EFLAGS_FIXED), which is false

The else branch executes:
  - unwind_start(&state, current, NULL, (void *)regs->sp)

In __unwind_start() at arch/x86/kernel/unwind_orc.c, when regs=NULL:
  - Takes the "else if (task == current)" path (line 711)
  - Initializes state->ip via inline asm from current location
  - This is __unwind_start's IP, not the original regs->ip
  - Then advances to first_frame at regs->sp (lines 755-758)

The original regs->ip value (captured by perf_arch_fetch_caller_regs) is
never stored in the callchain. This was the exact issue fixed by commit
83f44ae0f8af in 2019, which stated:

  "The stacktrace_map_raw_tp BPF selftest is failing because the RIP
   saved by perf_arch_fetch_caller_regs() isn't getting saved by
   perf_callchain_kernel()."

Does this revert re-introduce the BPF selftest failure that was fixed in
2019? The test tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
still exists in the kernel tree.

>
>  	for (; !unwind_done(&state); unwind_next_frame(&state)) {
>  		addr = unwind_get_return_address(&state);


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18842579839

--===============5490698179867115379==--

