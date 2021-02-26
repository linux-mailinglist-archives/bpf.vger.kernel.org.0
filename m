Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8F5325D2F
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 06:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBZF3X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 00:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhBZF3W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 00:29:22 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A503AC061574;
        Thu, 25 Feb 2021 21:28:42 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i18so7029889ilq.13;
        Thu, 25 Feb 2021 21:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EqDkuKsSWvX/q3kNJAK9RVd+ZVKW2vi+5spcJMq/Sc4=;
        b=s/SewRrgpzD0TY3LBiVs61IojGLUIU9foxEGpKhool5VTcla7VgFFdaEkJB4YLP9Rm
         XDElSuG8L9i/zJsajzOfHq65jEqjbW6pdNylhhkK28cd2L0bCPe7In9UYOihYfHk59zQ
         j+fy4D4SEbh/m8NyJ6LfNNHONa0Zgk8n8jitgEVW3VHN3w97tXAxxz5chmGCrJ8buX4s
         ONUjrDHezM0v1/Et0D+UJ7OnD217K4g/FqIAr7PfOnn1a+H0El2Ne7CdRIz+V+MHhyod
         WRkYJe6fB1ccrmG+z6hKMdiXglejf66zyRmwbveR7DVnZ17v4H5MBBdS/L/qwVHrWXhR
         Uf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EqDkuKsSWvX/q3kNJAK9RVd+ZVKW2vi+5spcJMq/Sc4=;
        b=RZiGq3efrBIl7Jgu6T5DGsfwM40kgNWSD3ubfkxSdzs2ayud5VxQqvLg/P+HDr1Yp2
         TJqKMgpSwrCKzbBIjpF0LUlMkHvmHcA2nAh0bAT8/ODehckTRmiMUPaOR4m6wYuCzbho
         7CoLiiocfzWbRmUpcW79n6ZeRlygQoN85Mwb7B5S/7arcUG82rSpN3nh5FE6wGKBnq2c
         JoXRAtEeozZRRD6B4EvnP9mV8IU0Wig926VLFUrvlYvpNtqCrg0qkbSOjcL793ekt4GG
         70TB/rxGpv1q0xzfr8olAlg3/2dgLXHz1FKUG9U1M02AlBy5WACI/buQsm2KAhfV89TN
         mTew==
X-Gm-Message-State: AOAM530IctHPJthvEulHfrdwD4vtNZVR7iKnp/lUFklvE7icq1cYxEVm
        Mwc4CEYCGOyaHQMLpmmnsxBreD3SDFRgP1QVGjA=
X-Google-Smtp-Source: ABdhPJwfHCK6GlloWH0sOyFYOU3LeDbo+badKWvs88UrTGzOqS9L4CInm4CWwHBQdmjqtWc3xJGWcxgwEVcZjXKGBrQ=
X-Received: by 2002:a92:4105:: with SMTP id o5mr1052617ila.47.1614317321997;
 Thu, 25 Feb 2021 21:28:41 -0800 (PST)
MIME-Version: 1.0
References: <20210218222125.46565-1-mjeanson@efficios.com> <20210223211639.670db85c@gandalf.local.home>
 <083bce0f-bd66-ab83-1211-be9838499b45@efficios.com> <915297635.2997.1614185975415.JavaMail.zimbra@efficios.com>
In-Reply-To: <915297635.2997.1614185975415.JavaMail.zimbra@efficios.com>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Fri, 26 Feb 2021 13:28:30 +0800
Message-ID: <CAJhGHyBb8FOwAqD4Y=k2aVL_t-n0ks1grWcsyRT+W+5pqWNnaQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] [RFC] Faultable tracepoints (v2)
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 9:15 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
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

label:
restart:

>   - probe code calculate the length which needs to be reserved to store the event
>     (e.g. user strlen),

Does "user strlen" makes the content fault in?

Is it possible to make the sleepable faulting only happen here between
"restart" and the following "preempt disable"?  The code here should
do a prefetch operation like "user strlen".

And we can keep preemption disabled when copying the data.  If there
is a fault while copying, then we can restart from the label "restart".

Very immature thought.

Thanks
Lai

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
