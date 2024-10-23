Return-Path: <bpf+bounces-42906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1B29ACE80
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4EE1C21CCA
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 15:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB8A1C2337;
	Wed, 23 Oct 2024 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NbO9Gyzb"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129A13A1DA;
	Wed, 23 Oct 2024 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696893; cv=none; b=Gm5pinxzkGVZN4RE1lzzOlvGP6FlnudPf7owjceExllaDEABHkmToN1uqgqIGTQ33/GUXbZH7yInxB/x1HO0/WYsFUmQWwWX2bFw4R0ovhtpzSUbKrHpJswg0plpfca7DCENOXZs+PEmpEpLdpEMvo2BSC6GU52A9WCCNZFEa98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696893; c=relaxed/simple;
	bh=cT5DmktNcyvnOCSZACoH2v4c7ctCOcCms7cjVFMft04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guKm2eVxDPi0rzmP/P2Ek1tz5Wvp71zM8/PGI8X/NPDKLpJDLiAad1qXIOAmd+z9qTf4keLsOpJxHRjAyb67sVpoHweKG/j7mSCjQoNjFgRuqxvQS+J2I58WIxA45pOtsYuzF3lMfqdybyXQKC6KAJMiXU9qv9HLkEsoMt1qGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=NbO9Gyzb; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1729696884;
	bh=cT5DmktNcyvnOCSZACoH2v4c7ctCOcCms7cjVFMft04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NbO9GyzbjZwIIe/74ZvZ5PHSgt5zK475ih/CKC1B+D837DiaGzDV1iy2IBykP194s
	 yxLlV1GeTa8bdFvPbDQwOrCwBiKysJLnEoDXjOddFH7jrBJCIQ79emp+su9ExIr4Uh
	 KnE78EDx7hRdNFs9OV0MwhX/xUVMs4Omifd1y9lkNYDgj7zD+pY2d8+/ubGRLG/of6
	 xVhrqZZRZ24dmGQ0iEB5E1eLDSUL+BafhPCNLwUOUwp0u3pZuxs1fI05eWa48mRRTb
	 zhUqDBoGf88uPMZ5IPbTxTDr/gy5vWBAauoAfm3c7S1xK8oSru6mw5ufzZjfR/oS+F
	 cqGoTwRpoW5gw==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XYXnc0S6gzfDf;
	Wed, 23 Oct 2024 11:21:24 -0400 (EDT)
Message-ID: <7bcea009-b58c-4a00-b7cd-f2fc06b90a02@efficios.com>
Date: Wed, 23 Oct 2024 11:19:40 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jordan Rife <jrife@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>, LKML
 <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Michael Jeanson <mjeanson@efficios.com>, Namhyung Kim <namhyung@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com,
 Yonghong Song <yhs@fb.com>
References: <CADKFtnTdWX9prHYMe62oNraaNm=Q3WC9wTfdDD35a=CYxaX2Gw@mail.gmail.com>
 <20241023145640.1499722-1-jrife@google.com>
 <CAADnVQJupBceq2DAeChBvdjSG4zOpYsMP7_o7gREVmVCA0PUYQ@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAADnVQJupBceq2DAeChBvdjSG4zOpYsMP7_o7gREVmVCA0PUYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-23 11:14, Alexei Starovoitov wrote:
> On Wed, Oct 23, 2024 at 7:56 AM Jordan Rife <jrife@google.com> wrote:
>>
>> Mathieu's patch alone does not seem to be enough to prevent the
>> use-after-free issue reported by syzbot.
>>
>> Link: https://lore.kernel.org/bpf/67121037.050a0220.10f4f4.000f.GAE@google.com/T/#u
>>
>> I reran the repro script with his patch applied to my tree and was
>> still able to get the same KASAN crash to occur.
>>
>> In this case, when bpf_link_free is invoked it kicks off three instances
>> of call_rcu*.
>>
>> bpf_link_free()
>>    ops->release()
>>       bpf_raw_tp_link_release()
>>         bpf_probe_unregister()
>>           tracepoint_probe_unregister()
>>             tracepoint_remove_func()
>>               release_probes()
>>                 call_rcu()               [1]
>>    bpf_prog_put()
>>      __bpf_prog_put()
>>        bpf_prog_put_deferred()
>>          __bpf_prog_put_noref()
>>             call_rcu()                   [2]
>>    call_rcu()                            [3]
>>
>> With Mathieu's patch, [1] is chained with call_rcu_tasks_trace()
>> making the grace period suffiently long to safely free the probe itself.
>> The callback for [2] and [3] may be invoked before the
>> call_rcu_tasks_trace() grace period has elapsed leading to the link or
>> program itself being freed while still in use. I was able to prevent
>> any crashes with the patch below which also chains
>> call_rcu_tasks_trace() and call_rcu() at [2] and [3].
>>
>> ---
>>   kernel/bpf/syscall.c | 24 ++++++++++--------------
>>   1 file changed, 10 insertions(+), 14 deletions(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 59de664e580d..5290eccb465e 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -2200,6 +2200,14 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
>>          bpf_prog_free(aux->prog);
>>   }
>>
>> +static void __bpf_prog_put_tasks_trace_rcu(struct rcu_head *rcu)
>> +{
>> +       if (rcu_trace_implies_rcu_gp())
>> +               __bpf_prog_put_rcu(rcu);
>> +       else
>> +               call_rcu(rcu, __bpf_prog_put_rcu);
>> +}
>> +
>>   static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
>>   {
>>          bpf_prog_kallsyms_del_all(prog);
>> @@ -2212,10 +2220,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
>>                  btf_put(prog->aux->attach_btf);
>>
>>          if (deferred) {
>> -               if (prog->sleepable)
>> -                       call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_rcu);
>> -               else
>> -                       call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
>> +               call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_tasks_trace_rcu);
>>          } else {
>>                  __bpf_prog_put_rcu(&prog->aux->rcu);
>>          }
>> @@ -2996,24 +3001,15 @@ static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
>>   static void bpf_link_free(struct bpf_link *link)
>>   {
>>          const struct bpf_link_ops *ops = link->ops;
>> -       bool sleepable = false;
>>
>>          bpf_link_free_id(link->id);
>>          if (link->prog) {
>> -               sleepable = link->prog->sleepable;
>>                  /* detach BPF program, clean up used resources */
>>                  ops->release(link);
>>                  bpf_prog_put(link->prog);
>>          }
>>          if (ops->dealloc_deferred) {
>> -               /* schedule BPF link deallocation; if underlying BPF program
>> -                * is sleepable, we need to first wait for RCU tasks trace
>> -                * sync, then go through "classic" RCU grace period
>> -                */
>> -               if (sleepable)
>> -                       call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
>> -               else
>> -                       call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
>> +               call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
> 
> This patch is completely wrong.

Actually I suspect Jordan's patch works.

> Looks like Mathieu patch broke bpf program contract somewhere.

My patch series introduced this in the probe:

#define __BPF_DECLARE_TRACE_SYSCALL(call, proto, args)                  \
static notrace void                                                     \
__bpf_trace_##call(void *__data, proto)                                 \
{                                                                       \
         might_fault();                                                  \
         preempt_disable_notrace();                                      \
         CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));        \
         preempt_enable_notrace();                                       \
}

To ensure we'd call the bpf program from preempt-off context.

> The tracepoint type bpf programs must be called with rcu_read_lock held.

Calling the bpf program with preempt off is equivalent. __DO_TRACE() calls
the probes with preempt_disable_notrace() in the normal case.

> Looks like it's not happening anymore.

The issue here is not about the context in which the bpf program runs, that's
still preempt off. The problem is about expectations that a call_rcu grace period
is enough to delay reclaim after unregistration of the tracepoint. Now that
__DO_TRACE() uses rcu_read_lock_trace() to protect RCU dereference, it's not
sufficient anymore, at least for syscall tracepoints.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


