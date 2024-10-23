Return-Path: <bpf+bounces-42905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 920289ACE66
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1A01F22A01
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E811BFE0D;
	Wed, 23 Oct 2024 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="C7YnjKBd"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179349659;
	Wed, 23 Oct 2024 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696542; cv=none; b=mIM76sjpmGod2JCkUapUjllNycAzbkLpJ1rCeZSCUiYEmjANN/jcNtNjK8mhK4XTgdcIg98QU5wn/yQFIxCSbYQOzFC/PaX7AQuvEMAJrY8/hDcdc3DTWvsrifCSIkDt0GaOemfWXC/K6PmP1olBwKsngtOFUQPsBMprtFJDSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696542; c=relaxed/simple;
	bh=91WqjZhGGL9eZj1PfM2R3xoEtckIHk5FRBu48g+lScs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gqx7jnE8Bh2wfELoFZVLdMFN/ca9A1UsaF/+C+23qMvkKFrn2qGwZha2HFcTxe1mggTCspO0V119rfSfuDtH5TTdpwC8YK6+xG3YMKRIZ+PNHetQ1gJeixFlsMZnQ+9AzBrhW3MbzHzOqCwkUXagxa9nXwY77kzgmSrP01IdoPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=C7YnjKBd; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1729696538;
	bh=91WqjZhGGL9eZj1PfM2R3xoEtckIHk5FRBu48g+lScs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C7YnjKBdWFDORLMcH3+3gHyGOXnZUDjGzEhSwq2+GomkYrV2dfgCJ5n4sMgpoMRm2
	 +2ZMUsqDt9rvYSd59IToucXzhups6JOH2zQqAEQ2tmvyLJExeBuB9MUOYr6Sx4pk1r
	 5DX2L5qDeXLDCJP9yECNZ+XicfbWE14jBe7YjO5DNOZpVgd5eUey5kBMKcWHCFa+Q2
	 HGWTA/HyPok46wnBNxRSzH5rYKBhes3FFn7ZUtKkFAK3vk35ZrnBN/WFHtNUEsL0y2
	 7AY61A2N0729LWhPu6XHbbjQLN9OZuizVtI8w6HKOmXJn13T7Y62PWlgHCesTFAAGZ
	 7g6I0ycUrwLNg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XYXfx5CWvzfQM;
	Wed, 23 Oct 2024 11:15:37 -0400 (EDT)
Message-ID: <f63cc172-72a7-4666-a15f-c53d8562d7d7@efficios.com>
Date: Wed, 23 Oct 2024 11:13:53 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Jordan Rife <jrife@google.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com,
 andrii.nakryiko@gmail.com, ast@kernel.org, bpf@vger.kernel.org,
 joel@joelfernandes.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
 mhiramat@kernel.org, mingo@redhat.com, mjeanson@efficios.com,
 namhyung@kernel.org, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com,
 yhs@fb.com
References: <CADKFtnTdWX9prHYMe62oNraaNm=Q3WC9wTfdDD35a=CYxaX2Gw@mail.gmail.com>
 <20241023145640.1499722-1-jrife@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241023145640.1499722-1-jrife@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-23 10:56, Jordan Rife wrote:
> Mathieu's patch alone does not seem to be enough to prevent the
> use-after-free issue reported by syzbot.
> 
> Link: https://lore.kernel.org/bpf/67121037.050a0220.10f4f4.000f.GAE@google.com/T/#u
> 
> I reran the repro script with his patch applied to my tree and was
> still able to get the same KASAN crash to occur.
> 
> In this case, when bpf_link_free is invoked it kicks off three instances
> of call_rcu*.
> 
> bpf_link_free()
>    ops->release()
>       bpf_raw_tp_link_release()
>         bpf_probe_unregister()
>           tracepoint_probe_unregister()
>             tracepoint_remove_func()
>               release_probes()
>                 call_rcu()               [1]
>    bpf_prog_put()
>      __bpf_prog_put()
>        bpf_prog_put_deferred()
>          __bpf_prog_put_noref()
>             call_rcu()                   [2]
>    call_rcu()                            [3]
> 
> With Mathieu's patch, [1] is chained with call_rcu_tasks_trace()
> making the grace period suffiently long to safely free the probe itself.
> The callback for [2] and [3] may be invoked before the
> call_rcu_tasks_trace() grace period has elapsed leading to the link or
> program itself being freed while still in use. I was able to prevent
> any crashes with the patch below which also chains
> call_rcu_tasks_trace() and call_rcu() at [2] and [3].

Right, so removal of the tracepoint probe is done by
tracepoint_probe_unregister by effectively removing the
probe function from the array. The read-side counterpart
of that is in __DO_TRACE(), where the rcu dereference is
protected by rcu_read_lock_trace for syscall tracepoints
now.

We cannot expect that surrounding the ebpf probe execution
with preempt disable like so:

#define __BPF_DECLARE_TRACE_SYSCALL(call, proto, args)                  \
static notrace void                                                     \
__bpf_trace_##call(void *__data, proto)                                 \
{                                                                       \
         might_fault();                                                  \
         preempt_disable_notrace();                                      \
         CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));        \
         preempt_enable_notrace();                                       \
}

Is sufficient to delay reclaim with call_rcu() after a tracepoint
unregister, because the preempt disable does not include the rcu
dereference done by the tracepoint in its critical section.

So relying on a call_rcu() to delay reclaim of the bpf objects
after unregistering their associated tracepoint is indeed not
enough. Chaining call_rcu with call_rcu_tasks_trace works though.

That question is relevant for ftrace and perf too: are there data
structures that are reclaimed with call_rcu() after being unregistered
from syscall tracepoints ?

Thanks Jordan for your thorough analysis,

Mathieu

> 
> ---
>   kernel/bpf/syscall.c | 24 ++++++++++--------------
>   1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 59de664e580d..5290eccb465e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2200,6 +2200,14 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
>   	bpf_prog_free(aux->prog);
>   }
>   
> +static void __bpf_prog_put_tasks_trace_rcu(struct rcu_head *rcu)
> +{
> +	if (rcu_trace_implies_rcu_gp())
> +		__bpf_prog_put_rcu(rcu);
> +	else
> +		call_rcu(rcu, __bpf_prog_put_rcu);
> +}
> +
>   static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
>   {
>   	bpf_prog_kallsyms_del_all(prog);
> @@ -2212,10 +2220,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
>   		btf_put(prog->aux->attach_btf);
>   
>   	if (deferred) {
> -		if (prog->sleepable)
> -			call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_rcu);
> -		else
> -			call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
> +		call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_tasks_trace_rcu);
>   	} else {
>   		__bpf_prog_put_rcu(&prog->aux->rcu);
>   	}
> @@ -2996,24 +3001,15 @@ static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
>   static void bpf_link_free(struct bpf_link *link)
>   {
>   	const struct bpf_link_ops *ops = link->ops;
> -	bool sleepable = false;
>   
>   	bpf_link_free_id(link->id);
>   	if (link->prog) {
> -		sleepable = link->prog->sleepable;
>   		/* detach BPF program, clean up used resources */
>   		ops->release(link);
>   		bpf_prog_put(link->prog);
>   	}
>   	if (ops->dealloc_deferred) {
> -		/* schedule BPF link deallocation; if underlying BPF program
> -		 * is sleepable, we need to first wait for RCU tasks trace
> -		 * sync, then go through "classic" RCU grace period
> -		 */
> -		if (sleepable)
> -			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
> -		else
> -			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
> +		call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
>   	} else if (ops->dealloc)
>   		ops->dealloc(link);
>   }

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


