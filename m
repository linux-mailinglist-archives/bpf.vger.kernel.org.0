Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA534242E2
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 18:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbhJFQlp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 12:41:45 -0400
Received: from foss.arm.com ([217.140.110.172]:49574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231779AbhJFQlp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 12:41:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A4646D;
        Wed,  6 Oct 2021 09:39:52 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83C5A3F70D;
        Wed,  6 Oct 2021 09:39:51 -0700 (PDT)
Date:   Wed, 6 Oct 2021 17:39:49 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc 0/6] Scheduler BPF
Message-ID: <20211006163949.zwze5du6szdabxos@e107158-lin.cambridge.arm.com>
References: <20210915213550.3696532-1-guro@fb.com>
 <20210916162451.709260-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210916162451.709260-1-guro@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Roman

On 09/16/21 09:24, Roman Gushchin wrote:
> There is a long history of distro people, system administrators, and
> application owners tuning the CFS settings in /proc/sys, which are now
> in debugfs. Looking at what these settings actually did, it ended up
> boiling down to changing the likelihood of task preemption, or
> disabling it by setting the wakeup_granularity_ns to more than half of
> the latency_ns. The other settings didn't really do much for
> performance.
> 
> In other words, some our workloads benefit by having long running tasks
> preempted by tasks handling short running requests, and some workloads
> that run only short term requests which benefit from never being preempted.

We had discussion about introducing latency-nice hint; but that discussion
didn't end up producing any new API. Your use case seem similar to Android's;
we want some tasks to run ASAP. There's an out of tree patch that puts these
tasks on an idle CPU (keep in mind energy aware scheduling in the context here)
which seem okay for its purpose. Having a more generic solution in mainline
would be nice.

https://lwn.net/Articles/820659/

> 
> This leads to a few observations and ideas:
> - Different workloads want different policies. Being able to configure
>   the policy per workload could be useful.
> - A workload that benefits from not being preempted itself could still
>   benefit from preempting (low priority) background system tasks.

You can put these tasks as SCHED_IDLE. There's a potential danger of starving
these tasks; but assuming they're background and there's idle time in the
system that should be fine.

https://lwn.net/Articles/805317/

That of course assuming you can classify these background tasks..

If you can do the classification, you can also use cpu.shares to reduce how
much cpu time they get. Or CFS bandwidth controller

https://lwn.net/Articles/844976/

I like Androd's model of classifying tasks. I think we need this classification
done by other non-android systems too.

> - It would be useful to quickly (and safely) experiment with different
>   policies in production, without having to shut down applications or reboot
>   systems, to determine what the policies for different workloads should be.

Userspace should have the knobs that allows them to tune that without reboot.
If you're doing kernel development; then it's part of the job spec I'd say :-)

I think one can still go with the workflow you suggest for development without
the hooks. You'd need to un-inline the function you're interested in; then you
can use kprobes to hook into it and force an early return. That should produce
the same effect, no?

> - Only a few workloads are large and sensitive enough to merit their own
>   policy tweaks. CFS by itself should be good enough for everything else,
>   and we probably do not want policy tweaks to be a replacement for anything
>   CFS does.
> 
> This leads to BPF hooks, which have been successfully used in various
> kernel subsystems to provide a way for external code to (safely)
> change a few kernel decisions. BPF tooling makes this pretty easy to do,
> and the people deploying BPF scripts are already quite used to updating them
> for new kernel versions.

I am (very) wary of these hooks. Scheduler (in mobile at least) is an area that
gets heavily modified by vendors and OEMs. We try very hard to understand the
problems they face and get the right set of solutions in mainline. Which would
ultimately help towards the goal of having a single Generic kernel Image [1]
that gives you what you'd expect out of the platform without any need for
additional cherries on top.

So my worry is that this will open the gate for these hooks to get more than
just micro-optimization done in a platform specific way. And that it will
discourage having the right discussion to fix real problems in the scheduler
because the easy path is to do whatever you want in userspace. I am not sure we
can control how these hooks are used.

The question is: why can't we fix any issues in the scheduler/make it better
and must have these hooks instead?

[1] https://arstechnica.com/gadgets/2021/09/android-to-take-an-upstream-first-development-model-for-the-linux-kernel/

Thanks

--
Qais Yousef

> 
> This patchset aims to start a discussion about potential applications of BPF
> to the scheduler. It also aims to land some very basic BPF infrastructure
> necessary to add new BPF hooks to the scheduler, a minimal set of useful
> helpers, corresponding libbpf changes, etc.
> 
> Our very first experiments with using BPF in CFS look very promising. We're
> at a very early stage, however already have seen a nice latency and ~1% RPS
> wins for our (Facebook's) main web workload.
> 
> As I know, Google is working on a more radical approach [2]: they aim to move
> the scheduling code into userspace. It seems that their core motivation is
> somewhat similar: to make the scheduler changes easier to develop, validate
> and deploy. Even though their approach is different, they also use BPF for
> speeding up some hot paths. I think the suggested infrastructure can serve
> their purpose too.
> 
> An example of an userspace part, which loads some simple hooks is available
> here [3]. It's very simple, provided only to simplify playing with the provided
> kernel patches.
> 
> 
> [1] c722f35b513f ("sched/fair: Bring back select_idle_smt(), but differently")
> [2] Google's ghOSt: https://linuxplumbersconf.org/event/11/contributions/954/
> [3] https://github.com/rgushchin/atc
> 
> 
> Roman Gushchin (6):
>   bpf: sched: basic infrastructure for scheduler bpf
>   bpf: sched: add convenient helpers to identify sched entities
>   bpf: sched: introduce bpf_sched_enable()
>   sched: cfs: add bpf hooks to control wakeup and tick preemption
>   libbpf: add support for scheduler bpf programs
>   bpftool: recognize scheduler programs
> 
>  include/linux/bpf_sched.h       |  53 ++++++++++++
>  include/linux/bpf_types.h       |   3 +
>  include/linux/sched_hook_defs.h |   4 +
>  include/uapi/linux/bpf.h        |  25 ++++++
>  kernel/bpf/btf.c                |   1 +
>  kernel/bpf/syscall.c            |  21 ++++-
>  kernel/bpf/trampoline.c         |   1 +
>  kernel/bpf/verifier.c           |   9 ++-
>  kernel/sched/Makefile           |   1 +
>  kernel/sched/bpf_sched.c        | 138 ++++++++++++++++++++++++++++++++
>  kernel/sched/fair.c             |  27 +++++++
>  scripts/bpf_doc.py              |   2 +
>  tools/bpf/bpftool/common.c      |   1 +
>  tools/bpf/bpftool/prog.c        |   1 +
>  tools/include/uapi/linux/bpf.h  |  25 ++++++
>  tools/lib/bpf/libbpf.c          |  27 ++++++-
>  tools/lib/bpf/libbpf.h          |   4 +
>  tools/lib/bpf/libbpf.map        |   3 +
>  18 files changed, 341 insertions(+), 5 deletions(-)
>  create mode 100644 include/linux/bpf_sched.h
>  create mode 100644 include/linux/sched_hook_defs.h
>  create mode 100644 kernel/sched/bpf_sched.c
> 
> -- 
> 2.31.1
> 
