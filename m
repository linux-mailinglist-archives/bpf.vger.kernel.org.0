Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF7E3258F1
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 22:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhBYVrM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 16:47:12 -0500
Received: from mail.efficios.com ([167.114.26.124]:40640 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhBYVrM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 16:47:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CD650308F50;
        Thu, 25 Feb 2021 16:46:30 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Kl9dAKxEcf28; Thu, 25 Feb 2021 16:46:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4FBA4308CE5;
        Thu, 25 Feb 2021 16:46:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4FBA4308CE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1614289590;
        bh=o0aCFhK6hbOYxsIx7d6kKmaUc/JroV5nWAPRFyt2WAo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=e1yFIxBsDQ7Nu4LsQM2dVNLiYYrL++s9uYuCRAl+zegkLDJW3JsQJwlWMcTvmop8a
         EEWjF69tjE+HdbdvpPmXNjr3W0+FkxMY95TbNzwdNPjkgqLhOaRHPBxKUC5yP5hpTN
         U9th3mRpfnRNKM5jlADeQjyg6qCyWXJ1znf1SKUWMZQt86TF39TEGU0CFYNtIkzlmB
         nHG+aD+F3ol3tHxWw7SLCm5EWr37j4IiCKIJMcA2b+Bynsa2Ed5usDjTsijcjVkxsN
         QJIG99ujgD5J6Xk9gQTD6xo17FES73Il8tlSbIb7oL8cvqCuMkmPZIn+S+L6Hqblvl
         P+Y/JiYTJofiw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XLjMK8LN6nAu; Thu, 25 Feb 2021 16:46:30 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 3662A308CE4;
        Thu, 25 Feb 2021 16:46:30 -0500 (EST)
Date:   Thu, 25 Feb 2021 16:46:30 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Michael Jeanson <mjeanson@efficios.com>,
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
Message-ID: <1130245502.6977.1614289590089.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210224131405.20d64b49@gandalf.local.home>
References: <20210218222125.46565-1-mjeanson@efficios.com> <20210223211639.670db85c@gandalf.local.home> <083bce0f-bd66-ab83-1211-be9838499b45@efficios.com> <915297635.2997.1614185975415.JavaMail.zimbra@efficios.com> <20210224131405.20d64b49@gandalf.local.home>
Subject: Re: [RFC PATCH 0/6] [RFC] Faultable tracepoints (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF86 (Linux)/8.8.15_GA_4007)
Thread-Topic: Faultable tracepoints (v2)
Thread-Index: dAUCUbioVIglboY1pCOYm7WxMYc8kQ==
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



----- On Feb 24, 2021, at 1:14 PM, rostedt rostedt@goodmis.org wrote:

> On Wed, 24 Feb 2021 11:59:35 -0500 (EST)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> 
>> As a prototype solution, what I've done currently is to copy the user-space
>> data into a kmalloc'd buffer in a preparation step before disabling preemption
>> and copying data over into the per-cpu buffers. It works, but I think we should
>> be able to do it without the needless copy.
>> 
>> What I have in mind as an efficient solution (not implemented yet) for the LTTng
>> kernel tracer goes as follows:
>> 
>> #define COMMIT_LOCAL 0
>> #define COMMIT_REMOTE 1
>> 
>> - faultable probe is called from system call tracepoint [
>> preemption/blocking/migration is allowed ]
>>   - probe code calculate the length which needs to be reserved to store the event
>>     (e.g. user strlen),
>> 
>>   - preempt disable -> [ preemption/blocking/migration is not allowed from here ]
>>     - reserve_cpu = smp_processor_id()
>>     - reserve space in the ring buffer for reserve_cpu
>>       [ from that point on, we have _exclusive_ access to write into the ring buffer
>>       "slot"
>>         from any cpu until we commit. ]
>>   - preempt enable -> [ preemption/blocking/migration is allowed from here ]
>> 
> 
> So basically the commit position here doesn't move until this task is
> scheduled back in and the commit (remote or local) is updated.

Indeed.

> To put it in terms of the ftrace ring buffer, where we have both a commit
> page and a commit index, and it only gets moved by the first one to start a
> commit stack (that is, interrupts that interrupted a write will not
> increment the commit).

The tricky part for ftrace is its reliance on the fact that the concurrent
users of the per-cpu ring buffer are all nested contexts. LTTng does not
assume that and has been designed to be used both in kernel and user-space:
lttng-modules and lttng-ust share a lot of ring buffer code. Therefore,
LTTng's ring buffer supports preemption/migration of concurrent contexts.

The fact that LTTng uses local-atomic-ops on its kernel ring buffers is just
an optimization on an overall ring buffer design meant to allow preemption.

> Now, I'm not sure how LTTng does it, but I could see issues for ftrace to
> try to move the commit pointer (the pointer to the new commit page), as the
> design is currently dependent on the fact that it can't happen while
> commits are taken place.

Indeed, what makes it easy for LTTng is because the ring buffer has been
designed to support preemption/migration from the ground up.

> Are the pages of the LTTng indexed by an array of pages?

Yes, they are. Handling the initial page allocation and then the tracer copy of data
to/from the ring buffer pages is the responsibility of the LTTng lib ring buffer "backend".
The LTTng lib ring buffer backend is somewhat similar to a page table done in software, where
the top level of the page table can be dynamically updated when doing flight recorder tracing.

It is however completely separate from the space reservation/commit scheme which is handled
by the lib ring buffer "frontend".

The algorithm I described in my prior email is specifically targeted at the frontend layer,
leaving the "backend" unchanged.

For some reasons I suspect Ftrace ring buffer combined those two layers into a single
algorithm, which may have its advantages, but seems to strengthen its dependency on
only having nested contexts sharing a given per-cpu ring buffer.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
