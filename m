Return-Path: <bpf+bounces-43328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 701E69B3A57
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D9F1F22B01
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 19:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5621DE3B7;
	Mon, 28 Oct 2024 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NxHaSRSm"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC8155A52;
	Mon, 28 Oct 2024 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730143301; cv=none; b=RT2Z7uHnEePCiUGYOWQ6S5cST2KuxLKVNSs5E9YLLeD7edlojoEQBCVRImp+Y6RBDclA/t9BlbzuAgbj9+l74HZxrPl5U/V2VcbM5K5KihFPjwCzmJqpHk3ZNmpqjKRNim/RxQct/lEZueSpL9DL+COel4YQySxN2s1PtgxByDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730143301; c=relaxed/simple;
	bh=kXzY6L3SAN9Fk+i9GMyzI23iyi05GrzWiz5zFLNj0O4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdFA8qOe8ouecg5KzORVLuvOxUTDvU40sWt0bMIyBIqT0ukY0qLfi5yK3ZIUmaOj0J44f7LQi6y1nKfLVxtSv39lfg8VdTb370sBvjAq6N4LYRyLpDgT2vt65UPa8sIBY1sAPRBhd6YSR/+xdDbzFnG/YiCAXY8U+Yv6PoUHThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=NxHaSRSm; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730143298;
	bh=kXzY6L3SAN9Fk+i9GMyzI23iyi05GrzWiz5zFLNj0O4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NxHaSRSm9qxVb2mB90AtfmzPy5GjhRJHDJvmELP2qE09OOV1HWbLVnFx6/LpXbVeg
	 k0VxfnRCgYdIevCqn6YjLLR8pbvqZaNbKudJGWyqmwm9czRfldFUZ+8Vrh7JSmpi8v
	 5VRFDV9UCpi5Tz7tAe7wZ9LG6GHPUoMsaCh5SPgGjmsQIP1q5Ml8TI2NtRXQs/odbS
	 VzCU/U0U1yBXPGp52EH8QXd+qb2r+0P9Yl2PxMlkRXXksgv87bOoQkHh4PKoTGLAXU
	 bnxzCQTH+UzC7Lv6iGnTflTFhn2oEqLmWD43U3u1tPfVWagywBpVkvac87w8gchL5Q
	 9qnlMuCnJjrEA==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XcjtT6McyzscJ;
	Mon, 28 Oct 2024 15:21:37 -0400 (EDT)
Message-ID: <7ef1d403-e6ca-4dee-85c6-e32446e52aa7@efficios.com>
Date: Mon, 28 Oct 2024 15:19:58 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/3] tracing: Fix syscall tracepoint use-after-free
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>,
 syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com
References: <20241026154629.593041-1-mathieu.desnoyers@efficios.com>
 <20241026154629.593041-3-mathieu.desnoyers@efficios.com>
 <CAEf4BzaD24V=Z6T3wNh27pv9OV_WaLNQeAPbUANQJYN0h5zHKw@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzaD24V=Z6T3wNh27pv9OV_WaLNQeAPbUANQJYN0h5zHKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-27 21:22, Andrii Nakryiko wrote:
> On Sat, Oct 26, 2024 at 8:48 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> The grace period used internally within tracepoint.c:release_probes()
>> uses call_rcu() to batch waiting for quiescence of old probe arrays,
>> rather than using the tracepoint_synchronize_unregister() which blocks
>> while waiting for quiescence.
>>
>> With the introduction of faultable syscall tracepoints, this causes
>> use-after-free issues reproduced with syzkaller.
>>
>> Fix this by using the appropriate call_rcu() or call_rcu_tasks_trace()
>> before invoking the rcu_free_old_probes callback. This can be chosen
>> using the tracepoint_is_syscall() API.
>>
>> A similar issue exists in bpf use of call_rcu(). Fixing this is left to
>> a separate change.
>>
>> Reported-by: syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com
>> Fixes: a363d27cdbc2 ("tracing: Allow system call tracepoints to handle page faults")
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Michael Jeanson <mjeanson@efficios.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: Yonghong Song <yhs@fb.com>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>> Cc: bpf@vger.kernel.org
>> Cc: Joel Fernandes <joel@joelfernandes.org>
>> Cc: Jordan Rife <jrife@google.com>
>> ---
>> Changes since v0:
>> - Introduce tracepoint_call_rcu(),
>> - Fix bpf_link_free() use of call_rcu as well.
>>
>> Changes since v1:
>> - Use tracepoint_call_rcu() for bpf_prog_put as well.
>>
>> Changes since v2:
>> - Do not cover bpf changes in the same commit, let bpf developers
>>    implement it.
>> ---
>>   kernel/tracepoint.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
>> index 5658dc92f5b5..47569fb06596 100644
>> --- a/kernel/tracepoint.c
>> +++ b/kernel/tracepoint.c
>> @@ -106,13 +106,16 @@ static void rcu_free_old_probes(struct rcu_head *head)
>>          kfree(container_of(head, struct tp_probes, rcu));
>>   }
>>
>> -static inline void release_probes(struct tracepoint_func *old)
>> +static inline void release_probes(struct tracepoint *tp, struct tracepoint_func *old)
>>   {
>>          if (old) {
>>                  struct tp_probes *tp_probes = container_of(old,
>>                          struct tp_probes, probes[0]);
>>
>> -               call_rcu(&tp_probes->rcu, rcu_free_old_probes);
>> +               if (tracepoint_is_syscall(tp))
>> +                       call_rcu_tasks_trace(&tp_probes->rcu, rcu_free_old_probes);
> 
> should this be call_rcu_tasks_trace() -> call_rcu() chain instead of
> just call_rcu_tasks_trace()? While currently call_rcu_tasks_trace()
> implies RCU GP (as evidenced by rcu_trace_implies_rcu_gp() being
> hardcoded right now to returning true), this might not always be the
> case in the future, so it's best to have a guarantee that regardless
> of sleepable or not, we'll always have have RCU GP, and for sleepable
> tracepoint *also* RCU Tasks Trace GP.

Given that faultable tracepoints only use RCU tasks trace for the
read-side and do not rely on preempt disable, I don't see why we would
need to chain both grace periods there ?

Thanks,

Mathieu

> 
>> +               else
>> +                       call_rcu(&tp_probes->rcu, rcu_free_old_probes);
>>          }
>>   }
>>
>> @@ -334,7 +337,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
>>                  break;
>>          }
>>
>> -       release_probes(old);
>> +       release_probes(tp, old);
>>          return 0;
>>   }
>>
>> @@ -405,7 +408,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
>>                  WARN_ON_ONCE(1);
>>                  break;
>>          }
>> -       release_probes(old);
>> +       release_probes(tp, old);
>>          return 0;
>>   }
>>
>> --
>> 2.39.5
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


