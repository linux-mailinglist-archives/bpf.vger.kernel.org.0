Return-Path: <bpf+bounces-30448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3528CDDC6
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 01:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F6D283F4C
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 23:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC5512839E;
	Thu, 23 May 2024 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgurloOU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E38061F;
	Thu, 23 May 2024 23:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716507917; cv=none; b=FDFn6ZgbHOnpn37mJWEXMhKnlCJzU8qD1RxBje9Ue6uYCi044/yoQHM6Ue0gabgzuyX/73d0V/dnE9hm5VO5knlwTQu2iFIrmpVnWhqifr3q6CyyXX5tW4dErzb6MPKYleWITDovv0u2iMNhq2bbvoCHFhjaslGF5gdrhJiL/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716507917; c=relaxed/simple;
	bh=XR12DPgjVZ5EFDU5mNXbbJTXKwdp+w1D/FcRUFNhSeI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JGDFB/AQqyT+eIyFODkj0vNDK0t84oY21BcuAGU2yTB/9XSv22HMFmq1ikCsX493Tr/z2kuRiPxzYqBZcdHu+SgWssMyWqaTrVJeh9IVSKSdfXxs9XxWAsJNgUENQFWXnGj8mvuroao7b/QKzTyh4KpZxNrcg/RgoMgxeci0Xj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgurloOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F930C2BD10;
	Thu, 23 May 2024 23:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716507917;
	bh=XR12DPgjVZ5EFDU5mNXbbJTXKwdp+w1D/FcRUFNhSeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hgurloOUKqDYXAquok803HRUIf3lan5WoOpD3c0qiDWtubXjBXnSxm1x4T3Tza/nD
	 Gg0ptNvtQ0Ob3peJsku4lFANEQBGffeJGu/Hzbc9bqxBr3rjnz1Bw5u+hxZvb16Ich
	 cDGCnTnXRmM5qW2ADZLyBO64uw2cDKgfWCyQEU2EZaSFPkOz4OZ9Itcto+h5OsFL96
	 E9z0VOieD4bLyjY7OdyepwCHQbL84ex/LbwDZEgMMfWfOCLG3RdB9e6NYjuI23lP/U
	 OokmeAl2tbzcBUgbwn+fBI0wBPq7eNfsUiPabqsmyK9nTEP4eOekdj9IJFU1ckO6CE
	 gXUkRYyj0TeVw==
Date: Fri, 24 May 2024 08:45:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 bpf@vger.kernel.org, oleg@redhat.com, jolsa@kernel.org, Breno Leitao
 <leitao@debian.org>
Subject: Re: [PATCH] uprobes: prevent mutex_lock() under rcu_read_lock()
Message-Id: <20240524084512.ed21169228c0e6c39b114d69@kernel.org>
In-Reply-To: <20240521053017.3708530-1-andrii@kernel.org>
References: <20240521053017.3708530-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 May 2024 22:30:17 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> Recent changes made uprobe_cpu_buffer preparation lazy, and moved it
> deeper into __uprobe_trace_func(). This is problematic because
> __uprobe_trace_func() is called inside rcu_read_lock()/rcu_read_unlock()
> block, which then calls prepare_uprobe_buffer() -> uprobe_buffer_get() ->
> mutex_lock(&ucb->mutex), leading to a splat about using mutex under
> non-sleepable RCU:
> 
>   BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585
>    in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 98231, name: stress-ng-sigq
>    preempt_count: 0, expected: 0
>    RCU nest depth: 1, expected: 0
>    ...
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x3d/0xe0
>     __might_resched+0x24c/0x270
>     ? prepare_uprobe_buffer+0xd5/0x1d0
>     __mutex_lock+0x41/0x820
>     ? ___perf_sw_event+0x206/0x290
>     ? __perf_event_task_sched_in+0x54/0x660
>     ? __perf_event_task_sched_in+0x54/0x660
>     prepare_uprobe_buffer+0xd5/0x1d0
>     __uprobe_trace_func+0x4a/0x140
>     uprobe_dispatcher+0x135/0x280
>     ? uprobe_dispatcher+0x94/0x280
>     uprobe_notify_resume+0x650/0xec0
>     ? atomic_notifier_call_chain+0x21/0x110
>     ? atomic_notifier_call_chain+0xf8/0x110
>     irqentry_exit_to_user_mode+0xe2/0x1e0
>     asm_exc_int3+0x35/0x40
>    RIP: 0033:0x7f7e1d4da390
>    Code: 33 04 00 0f 1f 80 00 00 00 00 f3 0f 1e fa b9 01 00 00 00 e9 b2 fc ff ff 66 90 f3 0f 1e fa 31 c9 e9 a5 fc ff ff 0f 1f 44 00 00 <cc> 0f 1e fa b8 27 00 00 00 0f 05 c3 0f 1f 40 00 f3 0f 1e fa b8 6e
>    RSP: 002b:00007ffd2abc3608 EFLAGS: 00000246
>    RAX: 0000000000000000 RBX: 0000000076d325f1 RCX: 0000000000000000
>    RDX: 0000000076d325f1 RSI: 000000000000000a RDI: 00007ffd2abc3690
>    RBP: 000000000000000a R08: 00017fb700000000 R09: 00017fb700000000
>    R10: 00017fb700000000 R11: 0000000000000246 R12: 0000000000017ff2
>    R13: 00007ffd2abc3610 R14: 0000000000000000 R15: 00007ffd2abc3780
>     </TASK>
> 
> Luckily, it's easy to fix by moving prepare_uprobe_buffer() to be called
> slightly earlier: into uprobe_trace_func() and uretprobe_trace_func(), outside
> of RCU locked section. This still keeps this buffer preparation lazy and helps
> avoid the overhead when it's not needed. E.g., if there is only BPF uprobe
> handler installed on a given uprobe, buffer won't be initialized.
> 
> Note, the other user of prepare_uprobe_buffer(), __uprobe_perf_func(), is not
> affected, as it doesn't prepare buffer under RCU read lock.
> 

Oops, good catch! This looks good to me. Let me pick it.
Let me add a simple uprobe test in ftracetest so that this error can
detect in selftests. (I could reproduced it.)

Thank you,

> Fixes: 1b8f85defbc8 ("uprobes: prepare uprobe args buffer lazily")
> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/trace/trace_uprobe.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 8541fa1494ae..c98e3b3386ba 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -970,19 +970,17 @@ static struct uprobe_cpu_buffer *prepare_uprobe_buffer(struct trace_uprobe *tu,
>  
>  static void __uprobe_trace_func(struct trace_uprobe *tu,
>  				unsigned long func, struct pt_regs *regs,
> -				struct uprobe_cpu_buffer **ucbp,
> +				struct uprobe_cpu_buffer *ucb,
>  				struct trace_event_file *trace_file)
>  {
>  	struct uprobe_trace_entry_head *entry;
>  	struct trace_event_buffer fbuffer;
> -	struct uprobe_cpu_buffer *ucb;
>  	void *data;
>  	int size, esize;
>  	struct trace_event_call *call = trace_probe_event_call(&tu->tp);
>  
>  	WARN_ON(call != trace_file->event_call);
>  
> -	ucb = prepare_uprobe_buffer(tu, regs, ucbp);
>  	if (WARN_ON_ONCE(ucb->dsize > PAGE_SIZE))
>  		return;
>  
> @@ -1014,13 +1012,16 @@ static int uprobe_trace_func(struct trace_uprobe *tu, struct pt_regs *regs,
>  			     struct uprobe_cpu_buffer **ucbp)
>  {
>  	struct event_file_link *link;
> +	struct uprobe_cpu_buffer *ucb;
>  
>  	if (is_ret_probe(tu))
>  		return 0;
>  
> +	ucb = prepare_uprobe_buffer(tu, regs, ucbp);
> +
>  	rcu_read_lock();
>  	trace_probe_for_each_link_rcu(link, &tu->tp)
> -		__uprobe_trace_func(tu, 0, regs, ucbp, link->file);
> +		__uprobe_trace_func(tu, 0, regs, ucb, link->file);
>  	rcu_read_unlock();
>  
>  	return 0;
> @@ -1031,10 +1032,13 @@ static void uretprobe_trace_func(struct trace_uprobe *tu, unsigned long func,
>  				 struct uprobe_cpu_buffer **ucbp)
>  {
>  	struct event_file_link *link;
> +	struct uprobe_cpu_buffer *ucb;
> +
> +	ucb = prepare_uprobe_buffer(tu, regs, ucbp);
>  
>  	rcu_read_lock();
>  	trace_probe_for_each_link_rcu(link, &tu->tp)
> -		__uprobe_trace_func(tu, func, regs, ucbp, link->file);
> +		__uprobe_trace_func(tu, func, regs, ucb, link->file);
>  	rcu_read_unlock();
>  }
>  
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

