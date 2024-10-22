Return-Path: <bpf+bounces-42740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 508399A975E
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 06:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4EF0B22C97
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 04:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B87F7E59A;
	Tue, 22 Oct 2024 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jj+trqXi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4642819;
	Tue, 22 Oct 2024 04:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729569667; cv=none; b=bfP6JlrA/Rfg6+u+WHHG0VvhdWstlIcG5k6t9l0jaqIf/B0usQoBSgb5h1l0Kj+gR5DvYG4WIlQBIIYydjsJnvVDZPNtEwA0y1oSSCFgzu0KTocYfTfonz0Uws+S8M0z5vmBSkqn3awwQjdFJt+oH4p3g8PJnNlA/3BrPH44hX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729569667; c=relaxed/simple;
	bh=cylGaKVJ5EYP32hqk0FO8aOWFqrcSmcvUWJ+G08AGm0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hPfYXy+GgVHNsfJwKRdU8AEUp2KpIBbW1fWablv79CW4bBCYBt2F5ji4i+CZ9XT1YI+8QFAcJyUcuszNBbidZizfx7tumyIKSlnl9lwAihX7L8xNdIYTSMZya7VT0NE6IgRNTjltLsmaye1JwqDi6C1MIY4Y6P4bMoFgl7woptI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jj+trqXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C261C4CEC3;
	Tue, 22 Oct 2024 04:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729569667;
	bh=cylGaKVJ5EYP32hqk0FO8aOWFqrcSmcvUWJ+G08AGm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jj+trqXihJ1WZmMPZBUUxNdiSqHi6C1St3+gct7Xx7HR7aiAlhNmxIMNyV84l60vF
	 W+PTagEGI6wKw2gL3mp3kPOZ24P1WvN/1Zanhp4HvsvqAaboas6mzQ5IihQcnl8Ydo
	 jCIQG9ldv1BgNKHrzu/yDqM2Cse3UmS3QwNXA0AtZ96PpOajDiURKu9+BegchkMu9Q
	 jBaHbuzYGApcxnbXa8iraloCylo6gmnDLjucPBOvlaeao31FfDa17RsFkBuEXShwzq
	 nXHL0lY7hMGVXmiGHsUHnqLUExhF5EImsCSQ9iZVsxXYSsDjvXyB9oNCBq+xT9Uw9I
	 L767bg/XxiDlw==
Date: Tue, 22 Oct 2024 13:01:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Liao Chang <liaochang1@huawei.com>
Cc: <oleg@redhat.com>, <peterz@infradead.org>, <mingo@redhat.com>,
 <acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
 <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
 <irogers@google.com>, <adrian.hunter@intel.com>,
 <kan.liang@linux.intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] uprobes: Remove the spinlock within
 handle_singlestep()
Message-Id: <20241022130103.3509201a2a26c4be5de1a852@kernel.org>
In-Reply-To: <20240815014629.2685155-3-liaochang1@huawei.com>
References: <20240815014629.2685155-1-liaochang1@huawei.com>
	<20240815014629.2685155-3-liaochang1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Liao,

On Thu, 15 Aug 2024 01:46:29 +0000
Liao Chang <liaochang1@huawei.com> wrote:

> This patch introduces a flag to track TIF_SIGPENDING is suppress
> temporarily during the uprobe single-step. Upon uprobe singlestep is
> handled and the flag is confirmed, it could resume the TIF_SIGPENDING
> directly without acquiring the siglock in most case, then reducing
> contention and improving overall performance.
> 
> I've use the script developed by Andrii in [1] to run benchmark. The CPU
> used was Kunpeng916 (Hi1616), 4 NUMA nodes, 64 cores@2.4GHz running the
> kernel on next tree + the optimization for get_xol_insn_slot() [2].
> 
> before-opt
> ----------
> uprobe-nop      ( 1 cpus):    0.907 ± 0.003M/s  (  0.907M/s/cpu)
> uprobe-nop      ( 2 cpus):    1.676 ± 0.008M/s  (  0.838M/s/cpu)
> uprobe-nop      ( 4 cpus):    3.210 ± 0.003M/s  (  0.802M/s/cpu)
> uprobe-nop      ( 8 cpus):    4.457 ± 0.003M/s  (  0.557M/s/cpu)
> uprobe-nop      (16 cpus):    3.724 ± 0.011M/s  (  0.233M/s/cpu)
> uprobe-nop      (32 cpus):    2.761 ± 0.003M/s  (  0.086M/s/cpu)
> uprobe-nop      (64 cpus):    1.293 ± 0.015M/s  (  0.020M/s/cpu)
> 
> uprobe-push     ( 1 cpus):    0.883 ± 0.001M/s  (  0.883M/s/cpu)
> uprobe-push     ( 2 cpus):    1.642 ± 0.005M/s  (  0.821M/s/cpu)
> uprobe-push     ( 4 cpus):    3.086 ± 0.002M/s  (  0.771M/s/cpu)
> uprobe-push     ( 8 cpus):    3.390 ± 0.003M/s  (  0.424M/s/cpu)
> uprobe-push     (16 cpus):    2.652 ± 0.005M/s  (  0.166M/s/cpu)
> uprobe-push     (32 cpus):    2.713 ± 0.005M/s  (  0.085M/s/cpu)
> uprobe-push     (64 cpus):    1.313 ± 0.009M/s  (  0.021M/s/cpu)
> 
> uprobe-ret      ( 1 cpus):    1.774 ± 0.000M/s  (  1.774M/s/cpu)
> uprobe-ret      ( 2 cpus):    3.350 ± 0.001M/s  (  1.675M/s/cpu)
> uprobe-ret      ( 4 cpus):    6.604 ± 0.000M/s  (  1.651M/s/cpu)
> uprobe-ret      ( 8 cpus):    6.706 ± 0.005M/s  (  0.838M/s/cpu)
> uprobe-ret      (16 cpus):    5.231 ± 0.001M/s  (  0.327M/s/cpu)
> uprobe-ret      (32 cpus):    5.743 ± 0.003M/s  (  0.179M/s/cpu)
> uprobe-ret      (64 cpus):    4.726 ± 0.016M/s  (  0.074M/s/cpu)
> 
> after-opt
> ---------
> uprobe-nop      ( 1 cpus):    0.985 ± 0.002M/s  (  0.985M/s/cpu)
> uprobe-nop      ( 2 cpus):    1.773 ± 0.005M/s  (  0.887M/s/cpu)
> uprobe-nop      ( 4 cpus):    3.304 ± 0.001M/s  (  0.826M/s/cpu)
> uprobe-nop      ( 8 cpus):    5.328 ± 0.002M/s  (  0.666M/s/cpu)
> uprobe-nop      (16 cpus):    6.475 ± 0.002M/s  (  0.405M/s/cpu)
> uprobe-nop      (32 cpus):    4.831 ± 0.082M/s  (  0.151M/s/cpu)
> uprobe-nop      (64 cpus):    2.564 ± 0.053M/s  (  0.040M/s/cpu)
> 
> uprobe-push     ( 1 cpus):    0.964 ± 0.001M/s  (  0.964M/s/cpu)
> uprobe-push     ( 2 cpus):    1.766 ± 0.002M/s  (  0.883M/s/cpu)
> uprobe-push     ( 4 cpus):    3.290 ± 0.009M/s  (  0.823M/s/cpu)
> uprobe-push     ( 8 cpus):    4.670 ± 0.002M/s  (  0.584M/s/cpu)
> uprobe-push     (16 cpus):    5.197 ± 0.004M/s  (  0.325M/s/cpu)
> uprobe-push     (32 cpus):    5.068 ± 0.161M/s  (  0.158M/s/cpu)
> uprobe-push     (64 cpus):    2.605 ± 0.026M/s  (  0.041M/s/cpu)
> 
> uprobe-ret      ( 1 cpus):    1.833 ± 0.001M/s  (  1.833M/s/cpu)
> uprobe-ret      ( 2 cpus):    3.384 ± 0.003M/s  (  1.692M/s/cpu)
> uprobe-ret      ( 4 cpus):    6.677 ± 0.004M/s  (  1.669M/s/cpu)
> uprobe-ret      ( 8 cpus):    6.854 ± 0.005M/s  (  0.857M/s/cpu)
> uprobe-ret      (16 cpus):    6.508 ± 0.006M/s  (  0.407M/s/cpu)
> uprobe-ret      (32 cpus):    5.793 ± 0.009M/s  (  0.181M/s/cpu)
> uprobe-ret      (64 cpus):    4.743 ± 0.016M/s  (  0.074M/s/cpu)
> 
> Above benchmark results demonstrates a obivious improvement in the
> scalability of trig-uprobe-nop and trig-uprobe-push, the peak throughput
> of which are from 4.5M/s to 6.4M/s and 3.3M/s to 5.1M/s individually.
> 
> [1] https://lore.kernel.org/all/20240731214256.3588718-1-andrii@kernel.org
> [2] https://lore.kernel.org/all/20240727094405.1362496-1-liaochang1@huawei.com
> 

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  include/linux/uprobes.h | 1 +
>  kernel/events/uprobes.c | 8 +++++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index b503fafb7fb3..e4f57117d9c3 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -75,6 +75,7 @@ struct uprobe_task {
>  
>  	struct uprobe			*active_uprobe;
>  	unsigned long			xol_vaddr;
> +	bool				signal_denied;
>  
>  	struct return_instance		*return_instances;
>  	unsigned int			depth;
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 76a51a1f51e2..589aa2af1a99 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1979,6 +1979,7 @@ bool uprobe_deny_signal(void)
>  	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
>  
>  	if (task_sigpending(t)) {
> +		utask->signal_denied = true;
>  		clear_tsk_thread_flag(t, TIF_SIGPENDING);
>  
>  		if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
> @@ -2288,9 +2289,10 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
>  	utask->state = UTASK_RUNNING;
>  	xol_free_insn_slot(current);
>  
> -	spin_lock_irq(&current->sighand->siglock);
> -	recalc_sigpending(); /* see uprobe_deny_signal() */
> -	spin_unlock_irq(&current->sighand->siglock);
> +	if (utask->signal_denied) {
> +		set_thread_flag(TIF_SIGPENDING);
> +		utask->signal_denied = false;
> +	}
>  
>  	if (unlikely(err)) {
>  		uprobe_warn(current, "execute the probed insn, sending SIGILL.");
> -- 
> 2.34.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

