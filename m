Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAB83247AA
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 00:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhBXXzG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 18:55:06 -0500
Received: from mail.efficios.com ([167.114.26.124]:57574 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhBXXzG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 18:55:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 96EB13180FB;
        Wed, 24 Feb 2021 18:54:24 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AHULjKWpfXbl; Wed, 24 Feb 2021 18:54:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 370723180FA;
        Wed, 24 Feb 2021 18:54:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 370723180FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1614210864;
        bh=z9NK3k66zAxg617L8ZnboynlZtEiO6YivZtcM5eSd6w=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jdw2MlvcuxOJb4tpT/iTyUgFd/3pE4P0zc7BZZ2GAO139MjAdyzcupeFMkfRKvRwn
         R5260vsBqJVfBhwNjHUT7WnjWcCZTP6WIcbmAdd5JdhW8vwO1cQnq04UZ0V1RKPdUF
         nQuFsJTU8WRmQF7ngrT7ZlrFnmt3wvh97pYLI8NEfTCBfGwFaB1XcudHnx5h26wReR
         1Mlm1EVo9JzRArb4EHC2A7g/91x4cKqvkpuEO0NPQ60HFYst++bTBbQMZtA17h5hV7
         Qu+eHYZsYdxaheqJ9hsx14G6g1QUWDmExM9LFAUt1NqixmL/oNVA3HZzD9OVX8VefO
         Yte4gXpyNsuVA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vVNDhxZgyVMN; Wed, 24 Feb 2021 18:54:24 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 238D03180F1;
        Wed, 24 Feb 2021 18:54:24 -0500 (EST)
Date:   Wed, 24 Feb 2021 18:54:24 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Michael Jeanson <mjeanson@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, paulmck <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, acme <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        bpf <bpf@vger.kernel.org>
Message-ID: <1593236413.4171.1614210864063.JavaMail.zimbra@efficios.com>
In-Reply-To: <915297635.2997.1614185975415.JavaMail.zimbra@efficios.com>
References: <20210218222125.46565-1-mjeanson@efficios.com> <20210223211639.670db85c@gandalf.local.home> <083bce0f-bd66-ab83-1211-be9838499b45@efficios.com> <915297635.2997.1614185975415.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH 0/6] [RFC] Faultable tracepoints (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (zclient/8.8.15_GA_3996)
Thread-Topic: Faultable tracepoints (v2)
Thread-Index: urvfoX6HX+i7c2KJtiaEM9MhS7PYp0IBUf+l
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


----- Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> ----- On Feb 24, 2021, at 11:22 AM, Michael Jeanson mjeanson@efficios.com wrote:
> 
> > [ Adding Mathieu Desnoyers in CC ]
> > 
> > On 2021-02-23 21 h 16, Steven Rostedt wrote:
> >> On Thu, 18 Feb 2021 17:21:19 -0500
> >> Michael Jeanson <mjeanson@efficios.com> wrote:
> >> 
> >>> This series only implements the tracepoint infrastructure required to
> >>> allow tracers to handle page faults. Modifying each tracer to handle
> >>> those page faults would be a next step after we all agree on this piece
> >>> of instrumentation infrastructure.
> >> 
> >> I started taking a quick look at this, and came up with the question: how
> >> do you allow preemption when dealing with per-cpu buffers or storage to
> >> record the data?
> >> 
> >> That is, perf, bpf and ftrace are all using some kind of per-cpu data, and
> >> this is the reason for the need to disable preemption. What's the solution
> >> that LTTng is using for this? I know it has a per cpu buffers too, but does
> >> it have some kind of "per task" buffer that is being used to extract the
> >> data that can fault?
> 
> As a prototype solution, what I've done currently is to copy the user-space
> data into a kmalloc'd buffer in a preparation step before disabling preemption
> and copying data over into the per-cpu buffers. It works, but I think we should
> be able to do it without the needless copy.
> 
> What I have in mind as an efficient solution (not implemented yet) for the LTTng
> kernel tracer goes as follows:
> 
> #define COMMIT_LOCAL 0
> #define COMMIT_REMOTE 1
> 
> - faultable probe is called from system call tracepoint [ preemption/blocking/migration is allowed ]
>   - probe code calculate the length which needs to be reserved to store the event
>     (e.g. user strlen),
> 
>   - preempt disable -> [ preemption/blocking/migration is not allowed from here ]
>     - reserve_cpu = smp_processor_id()
>     - reserve space in the ring buffer for reserve_cpu
>       [ from that point on, we have _exclusive_ access to write into the ring buffer "slot"
>         from any cpu until we commit. ]
>   - preempt enable -> [ preemption/blocking/migration is allowed from here ]
> 
>   - copy data from user-space to the ring buffer "slot",
> 
>   - preempt disable -> [ preemption/blocking/migration is not allowed from here ]
>     commit_cpu = smp_processor_id()
>     if (commit_cpu == reserve_cpu)
>        use local_add to increment the buf[commit_cpu].subbuffer[current].commit_count[COMMIT_LOCAL]
>     else
>        use atomic_add to increment the buf[commit_cpu].subbuffer[current].commit_count[COMMIT_REMOTE]

The line above should increment reserve_cpu's buffer commit count, of course.

Thanks,

Mathieu

>   - preempt enable -> [ preemption/blocking/migration is allowed from here ]
> 
> Given that lttng uses per-buffer/per-sub-buffer commit counters as simple free-running
> accumulators, the trick here is to use two commit counters rather than single one for each
> sub-buffer. Whenever we need to read a commit count value, we always sum the total of the
> LOCAL and REMOTE counter.
> 
> This allows dealing with migration between reserve and commit without requiring the overhead
> of an atomic operation on the fast-path (LOCAL case).
> 
> I had to design this kind of dual-counter trick in the context of user-space use of restartable
> sequences. It looks like it may have a role to play in the kernel as well. :)
> 
> Or am I missing something important that would not survive real-life ?
> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
