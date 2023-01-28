Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4677967F2D8
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjA1AQ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjA1AQ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:16:57 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD74B7B40C;
        Fri, 27 Jan 2023 16:16:53 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso10221203pjg.2;
        Fri, 27 Jan 2023 16:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CTGm3zgze28ABd05hfV70FKgoh86KziqEzwzkDXuors=;
        b=MJOYAxC4jw3wp9waeguRtFYZE0Dn4LnL5wej3Z8dG/J88V/Fi3Ozlf0/AEDHeO3PLp
         HgHe9ElfIpSAm1mUrKdvfrwB8edYw10R1uVDyA5KZgB62JzaxFQvSVu+sNn4cJTOgQIZ
         Lauz/cVvB5V+6o8rMGIdMZGVDOjnUhkxcykPVtFYQk2NL1pduZrN+01teeMrd1ZJSZbZ
         SvoB/lQcmEb+w7Abug+GxqV0UYyMVkmhJkAIHpKi5GvqzH+sfxKGZZXPEtVqAj9XUI8w
         VHwR/AlTQ/Y6HlvhUwXd9bG5/QO+CaQyIt9LCpAdOoYaVK5C/1lck+CeVMC3bOSI3F9L
         t3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTGm3zgze28ABd05hfV70FKgoh86KziqEzwzkDXuors=;
        b=IODjsZ+0L+clbRFYFGkWxmM/Fe8cW+cE87fwOJc4azLtnUzFPkDvob9sVQZzbPwZpn
         Hlxij0eOk3G2am9jIaQe8wZ5OM2Rr38B/qUnTwwVZYCV2YsDzkiegaw6JWWWZ74HQtbX
         kb/HiQM9DYXQjBQ0ErdoMJMxkcV6HwgS543G6lYirRlWzF0C/GvdtSatzSiRpXgZMokv
         6p98RGIF0aZCYs+kNfrfX1Zy/2m+bdWTT/3bBTPD0xY2RhaUVdX9EFR6yScBAIziJBE9
         CP3m3h5bahWfOgU6Cnq0SyduofiwO5+fz2KS7yZ41uhvpcjkcyv5u0U6x8o8HZFHbhpZ
         n+WQ==
X-Gm-Message-State: AO0yUKX779gv74/wsqTQdwZax9DZ2AzydSjdOP/aQ99oPkJTLT7XeNsD
        Bp1g883v5+9YUNSz2XpQgz8=
X-Google-Smtp-Source: AK7set8tjzLRpWltUdMsqlVpFd/FxN/HatMvXB5yePjwiHHH6v5VFLWZMWe3zXPjMtqRqGTYbaC79Q==
X-Received: by 2002:a17:90a:1ca:b0:22c:491b:2cd7 with SMTP id 10-20020a17090a01ca00b0022c491b2cd7mr4809938pjd.34.1674865012531;
        Fri, 27 Jan 2023 16:16:52 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id mt21-20020a17090b231500b0022941908b80sm5634237pjb.47.2023.01.27.16.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:16:51 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCHSET v2] sched: Implement BPF extensible scheduler class
Date:   Fri, 27 Jan 2023 14:16:09 -1000
Message-Id: <20230128001639.3510083-1-tj@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changes
-------

This is v2 of sched_ext (SCX) patchset. The followings are changes from v1
(http://lkml.kernel.org/r/20221130082313.3241517-1-tj@kernel.org).

- Rebased on top of bpf/for-next - a5f6b9d577eb ("Merge branch 'Enable
  struct_ops programs to be sleepable'"). There were several missing
  features including generic cpumask helpers and sleepable struct_ops
  operation support that v1 was working around. The rebase gets rid of all
  SCX specific temporary helpers.

- Some kfunc helpers are context-sensitive and can only be called from
  specific operations. v1 didn't restrict kfunc accesses allowing them to be
  misused which can lead to crashes and other malfunctions. v2 makes more
  kfuncs safe to be called from anywhere and implements per-task mask based
  runtime access control for the rest. The longer-term plan is to make the
  BPF verifier enforce these restrictions. Combined with the above, sans
  mistakes and bugs, it shouldn't be possible to crash the machine through
  SCX and its helpers.

- Core-sched support. While v1 implemented the pick_task operation, there
  were multiple missing pieces for working core-sched support. v2 adds
  0027-sched_ext-Implement-core-sched-support.patch. SCX by default
  implements global FIFO ordering and allows the BPF schedulers to implement
  custom ordering via scx_ops.core_sched_before(). scx_example_qmap is
  updated so that the five queues' relative priorities are correctly
  reflected when core-sched is enabled.

- Dropped balance_scx_on_up() which was called from put_prev_task_balance().
  UP support is now contained in SCX proper.

- 0002-sched-Encapsulate-task-attribute-change-sequence-int.patch adds
  SCHED_CHANGE_BLOCK() which encapsulates the preparation and restoration
  sequences used for task attribute changes. For SCX, this replaces
  sched_deq_and_put_task() and sched_enq_and_set_task() from v1.

- 0011-sched-Add-reason-to-sched_move_task.patch dropped from v1. SCX now
  distinguishes cgroup and autogroup tg's using task_group_is_autogroup().

- Other misc changes including fixes for bugs that Julia Lawall noticed and
  patch descriptions updates with more details on how the introduced changes
  are going to be used.

- MAINTAINERS entries added.

The followings are discussion points which were raised but didn't result in
code changes in this iteration.

- There were discussions around exposing __setscheduler_prio() and, in v2,
  SCHED_CHANGE_BLOCK() in kernel/sched/sched.h. Switching scheduler
  implementations is innate for SCX. At the very least, it needs to be able
  to turn on and off the BPF scheduler which requires something equivalent
  to SCHED_CHANGE_BLOCK(). The use of __setscheduler_prio() depends on the
  behavior we want to present to userspace. The current one of using CFS as
  the fallback when BPF scheduler is not available seems more friendly and
  less error-prone to other options.

- Another discussion point was around for_each_active_class() and friends
  which skip over CFS or SCX when it's known that the sched_class must be
  empty. I left it as-is for now as it seems to be cleaner and more robust
  than trying to plug each operation which may added unnecessary overheads.

Overview
--------

This patch set proposes a new scheduler class called ‘ext_sched_class’, or
sched_ext, which allows scheduling policies to be implemented as BPF programs.

More details will be provided on the overall architecture of sched_ext
throughout the various patches in this set, as well as in the “How” section
below. We realize that this patch set is a significant proposal, so we will be
going into depth in the following “Motivation” section to explain why we think
it’s justified. That section is laid out as follows, touching on three main
axes where we believe that sched_ext provides significant value:

1. Ease of experimentation and exploration: Enabling rapid iteration of new
   scheduling policies.

2. Customization: Building application-specific schedulers which implement
   policies that are not applicable to general-purpose schedulers.

3. Rapid scheduler deployments: Non-disruptive swap outs of scheduling
   policies in production environments.

After the motivation section, we’ll provide a more detailed (but still
high-level) overview of how sched_ext works.

Motivation
----------

1. Ease of experimentation and exploration

*Why is exploration important?*

Scheduling is a challenging problem space. Small changes in scheduling
behavior can have a significant impact on various components of a system, with
the corresponding effects varying widely across different platforms,
architectures, and workloads.

While complexities have always existed in scheduling, they have increased
dramatically over the past 10-15 years. In the mid-late 2000s, cores were
typically homogeneous and further apart from each other, with the criteria for
scheduling being roughly the same across the entire die.

Systems in the modern age are by comparison much more complex. Modern CPU
designs, where the total power budget of all CPU cores often far exceeds the
power budget of the socket, with dynamic frequency scaling, and with or
without chiplets, have significantly expanded the scheduling problem space.
Cache hierarchies have become less uniform, with Core Complex (CCX) designs
such as recent AMD processors having multiple shared L3 caches within a single
socket. Such topologies resemble NUMA sans persistent NUMA node stickiness.

Use-cases have become increasingly complex and diverse as well. Applications
such as mobile and VR have strict latency requirements to avoid missing
deadlines that impact user experience. Stacking workloads in servers is
constantly pushing the demands on the scheduler in terms of workload isolation
and resource distribution.

Experimentation and exploration are important for any non-trivial problem
space. However, given the recent hardware and software developments, we
believe that experimentation and exploration are not just important, but
_critical_ in the scheduling problem space.

Indeed, other approaches in industry are already being explored. AMD has
proposed an experimental patch set [0] which enables userspace to provide
hints to the scheduler via “Userspace Hinting”. The approach adds a prctl()
API which allows callers to set a numerical “hint” value on a struct
task_struct. This hint is then optionally read by the scheduler to adjust the
cost calculus for various scheduling decisions.

[0]: https://lore.kernel.org/lkml/20220910105326.1797-1-kprateek.nayak@amd.com/

Huawei have also expressed interest [1] in enabling some form of programmable
scheduling. While we’re unaware of any patch sets which have been sent to the
upstream list for this proposal, it similarly illustrates the need for more
flexibility in the scheduler.

[1]: https://lore.kernel.org/bpf/dedc7b72-9da4-91d0-d81d-75360c177188@huawei.com/

Additionally, Google has developed ghOSt [2] with the goal of enabling custom,
userspace driven scheduling policies. Prior presentations at LPC [3] have
discussed ghOSt and how BPF can be used to accelerate scheduling.

[2]: https://dl.acm.org/doi/pdf/10.1145/3477132.3483542
[3]: https://lpc.events/event/16/contributions/1365/

*Why can’t we just explore directly with CFS?*

Experimenting with CFS directly or implementing a new sched_class from scratch
is of course possible, but is often difficult and time consuming. Newcomers to
the scheduler often require years to understand the codebase and become
productive contributors. Even for seasoned kernel engineers, experimenting
with and upstreaming features can take a very long time. The iteration process
itself is also time consuming, as testing scheduler changes on real hardware
requires reinstalling the kernel and rebooting the host.
 
Core scheduling is an example of a feature that took a significant amount of
time and effort to integrate into the kernel. Part of the difficulty with core
scheduling was the inherent mismatch in abstraction between the desire to
perform core-wide scheduling, and the per-cpu design of the kernel scheduler.
This caused issues, for example ensuring proper fairness between the
independent runqueues of SMT siblings.

The high barrier to entry for working on the scheduler is an impediment to
academia as well. Master’s/PhD candidates who are interested in improving the
scheduler will spend years ramping-up, only to complete their degrees just as
they’re finally ready to make significant changes. A lower entrance barrier
would allow researchers to more quickly ramp up, test out hypotheses, and
iterate on novel ideas. Research methodology is also severely hampered by the
high barrier of entry to make modifications; for example, the Shenango [4] and
Shinjuku scheduling policies used sched affinity to replicate the desired
policy semantics, due to the difficulty of incorporating these policies into
the kernel directly.

[4]: https://www.usenix.org/system/files/nsdi19-ousterhout.pdf

The iterative process itself also imposes a significant cost to working on the
scheduler. Testing changes requires developers to recompile and reinstall the
kernel, reboot their machines, rewarm their workloads, and then finally rerun
their benchmarks. Though some of this overhead could potentially be mitigated
by enabling schedulers to be implemented as kernel modules, a machine crash or
subtle system state corruption is always only one innocuous mistake away.
These problems are exacerbated when testing production workloads in a
datacenter environment as well, where multiple hosts may be involved in an
experiment; requiring a significantly longer ramp up time. Warming up memcache
instances in the Meta production environment takes hours, for example.

*How does sched_ext help with exploration?*

sched_ext attempts to address all of the problems described above. In this
section, we’ll describe the benefits to experimentation and exploration that
are afforded by sched_ext, provide real-world examples of those benefits, and
discuss some of the trade-offs and considerations in our design choices.

One of our main goals was to lower the barrier to entry for experimenting with
the scheduler. sched_ext provides ergonomic callbacks and helpers to ease
common operations such as managing idle CPUs, scheduling tasks on arbitrary
CPUs, handling preemptions from other scheduling classes, and more. While
sched_ext does require some ramp-up, the complexity is self-contained, and the
learning curve gradual. Developers can ramp up by first implementing simple
policies such as global FIFO in only tens of lines of code, and then continue
to learn the APIs and building blocks available with sched_ext as they build
more featureful and complex schedulers.

Another critical advantage provided by sched_ext is the use of BPF. BPF
provides strong safety guarantees by statically analyzing programs at load
time to ensure that they cannot corrupt or crash the system. sched_ext
guarantees system integrity no matter what BPF scheduler is loaded, and
provides mechanisms to safely disable the current BPF scheduler and migrate
tasks back to a trusted scheduler. For example, we also implement in-kernel
safety mechanisms to guarantee that a misbehaving scheduler cannot
indefinitely starve tasks. BPF also enables sched_ext to significantly improve
iteration speed for running experiments. Loading and unloading a BPF scheduler
is simply a matter of running and terminating a sched_ext binary.

BPF also provides programs with a rich set of APIs, such as maps, kfuncs, and
BPF helpers. In addition to providing useful building blocks to programs that
run entirely in kernel space (such as many of our example schedulers), these
APIs also allow programs to leverage user space in making scheduling
decisions. Specifically, the Atropos sample scheduler has a relatively simple
FIFO scheduling layer in BPF, paired with a load balancing component in
userspace written in Rust. As described in more detail below, we also built a
more general user-space scheduling framework called “rhone” by leveraging
various BPF features.

On the other hand, BPF does have shortcomings, as can be plainly seen from the
complexity in some of the example schedulers. scx_example_pair.bpf.c
illustrates this point well. To start, it requires a good amount of code to
emulate cgroup-local-storage. In the kernel proper, this would simply be a
matter of adding another pointer to the struct cgroup, but in BPF, it requires
a complex juggling of data amongst multiple different maps, a good amount of
boilerplate code, and some unwieldy bpf_loop()‘s and atomics. The code is also
littered with explicit and often unnecessary sanity checks to appease the
verifier.

That being said, BPF is being rapidly improved. For example, Yonghong Song
recently upstreamed a patch set [5] to add a cgroup local storage map type,
allowing scx_example_pair.bpf.c to be simplified. There are plans to address
other issues as well, such as providing statically-verified locking, and
avoiding the need for unnecessary sanity checks. Addressing these shortcomings
is a high priority for BPF, and as progress continues to be made, we expect
most deficiencies to be addressed in the not-too-distant future.

[5]: https://lore.kernel.org/bpf/20221026042835.672317-1-yhs@fb.com/

Yet another exploration advantage of sched_ext is helping widening the scope
of experiments. For example, sched_ext makes it easy to defer CPU assignment
until a task starts executing, allowing schedulers to share scheduling queues
at any granularity (hyper-twin, CCX and so on). Additionally, higher level
frameworks can be built on top to further widen the scope. For example, the
aforementioned “rhone” [6] library allows implementing scheduling policies in
user-space by encapsulating the complexity around communicating scheduling
decisions with the kernel. This allows taking advantage of a richer
programming environment in user-space, enabling experimenting with, for
instance, more complex mathematical models.

[6]: https://github.com/Decave/rhone

sched_ext also allows developers to leverage machine learning. At Meta, we
experimented with using machine learning to predict whether a running task
would soon yield its CPU. These predictions can be used to aid the scheduler
in deciding whether to keep a runnable task on its current CPU rather than
migrating it to an idle CPU, with the hope of avoiding unnecessary cache
misses. Using a tiny neural net model with only one hidden layer of size 16,
and a decaying count of 64 syscalls as a feature, we were able to achieve a
15% throughput improvement on an Nginx benchmark, with an 87% inference
accuracy.

2. Customization

This section discusses how sched_ext can enable users to run workloads on
application-specific schedulers.

*Why deploy custom schedulers rather than improving CFS?*

Implementing application-specific schedulers and improving CFS are not
conflicting goals. Scheduling features explored with sched_ext which yield
beneficial results, and which are sufficiently generalizable, can and should
be integrated into CFS. However, CFS is fundamentally designed to be a general
purpose scheduler, and thus is not conducive to being extended with some
highly targeted application or hardware specific changes.

Targeted, bespoke scheduling has many potential use cases. For example, VM
scheduling can make certain optimizations that are infeasible in CFS due to
the constrained problem space (scheduling a static number of long-running
VCPUs versus an arbitrary number of threads). Additionally, certain
applications might want to make targeted policy decisions based on hints
directly from the application (for example, a service that knows the different
deadlines of incoming RPCs).

Google has also experimented with some promising, novel scheduling policies.
One example is “central” scheduling, wherein a single CPU makes all scheduling
decisions for the entire system. This allows most cores on the system to be
fully dedicated to running workloads, and can have significant performance
improvements for certain use cases. For example, central scheduling with VCPUs
can avoid expensive vmexits and cache flushes, by instead delegating the
responsibility of preemption checks from the tick to a single CPU. See
scx_example_central.bpf.c for a simple example of a central scheduling policy
built in sched_ext.

Some workloads also have non-generalizable constraints which enable
optimizations in a scheduling policy which would otherwise not be feasible.
For example,VM workloads at Google typically have a low overcommit ratio
compared to the number of physical CPUs. This allows the scheduler to support
bounded tail latencies, as well as longer blocks of uninterrupted time.

Yet another interesting use case is the scx_example_cgfifo[7] scheduler,
which provides FIFO policies for individual workloads, and a flattened
hierarchical vtree for cgroups. This scheduler does not account for
thundering herd problems among cgroups, and therefore may not be suitable
for inclusion in CFS. However, in a simple benchmark using wrk[8] on apache
serving a CGI script calculating sha1sum of a small file, it outperformed
CFS by ~3% with CPU controller disabled and by ~10% with two apache
instances competing with 2:1 weight ratio nested four level deep.

Note that the scx_example_cgfifo[7] scheduler isn't included in this
patchset because it depends on the BPF rbtree which is still being
developed. The linked version is an earlier draft. We will forward-port and
include it in the series once the BPF rbtree support is in place.

[7] https://github.com/htejun/sched_ext/commit/f2fcd3147fb6286e0a35fcbed33c3bac69546a96
[8] https://github.com/wg/wrk

Certain industries require specific scheduling behaviors that do not apply
broadly. For example, ARINC 653 defines scheduling behavior that is widely
used by avionic software, and some out-of-tree implementations
(https://ieeexplore.ieee.org/document/7005306) have been built. While the
upstream community may decide to merge one such implementation in the future,
it would also be entirely reasonable to not do so given the narrowness of
use-case, and non-generalizable, strict requirements. Such cases can be well
served by sched_ext in all stages of the software development lifecycle --
development, testing, deployment and maintenance.

There are also classes of policy exploration, such as machine learning, or
responding in real-time to application hints, that are significantly harder
(and not necessarily appropriate) to integrate within the kernel itself.

*Won’t this increase fragmentation?*

We acknowledge that to some degree, sched_ext does run the risk of increasing
the fragmentation of scheduler implementations. As a result of exploration,
however, we believe that enabling the larger ecosystem to innovate will
ultimately accelerate the overall development and performance of Linux.
Additionally, our licensing and API stability policies should incentivize
users to upstream their schedulers.

BPF programs are required to be GPLv2, which is enforced by the verifier on
program loads. With regards to API stability, just as with other semi-internal
interfaces such as BPF kfuncs, we won’t be providing any API stability
guarantees to BPF schedulers. While we intend to make an effort to provide
compatibility when possible, we will not provide any explicit, strong
guarantees as the kernel typically does with e.g. UAPI headers. For users who
decide to keep their schedulers out-of-tree,the licensing and maintenance
overheads will be fundamentally the same as for carrying out-of-tree patches.

With regards to the schedulers included in this patch set, and any other
schedulers we implement in the future, both Meta and Google will open-source
all of the schedulers we implement which have any relevance to the broader
upstream community. We expect that some of these, such as the example
schedulers and scx_example_cgfifo scheduler, will be upstreamed as part of
the kernel tree. Distros will be able to package and release these
schedulers with the kernel, allowing users to utilize these schedulers
out-of-the-box without requiring any additional work or dependencies such as
clang or building the scheduler programs themselves. Other schedulers and
scheduling frameworks such as rhone may be open-sourced through separate
per-project repos.

3. Rapid scheduler deployments

Rolling out kernel upgrades is a slow and iterative process. At a large scale
it can take months to roll a new kernel out to a fleet of servers. While this
latency is expected and inevitable for normal kernel upgrades, it can become
highly problematic when kernel changes are required to fix bugs. Livepatch [9]
is available to quickly roll out critical security fixes to large fleets, but
the scope of changes that can be applied with livepatching is fairly limited,
and would likely not be usable for patching scheduling policies. With
sched_ext, new scheduling policies can be rapidly rolled out to production
environments.

[9]: https://www.kernel.org/doc/html/latest/livepatch/livepatch.html

As an example, one of the variants of the L1 Terminal Fault (L1TF) [10]
vulnerability allows a VCPU running a VM to read arbitrary host kernel
memory for pages in L1 data cache. The solution was to implement core
scheduling, which ensures that tasks running as hypertwins have the same
“cookie”.

[10]: https://www.intel.com/content/www/us/en/architecture-and-technology/l1tf.html

While core scheduling works well, it took a long time to finalize and land
upstream. This long rollout period was painful, and required organizations to
make difficult choices amongst a bad set of options. Some companies such as
Google chose to implement and use their own custom L1TF-safe scheduler, others
chose to run without hyper-threading enabled, and yet others left
hyper-threading enabled and crossed their fingers.

Once core scheduling was upstream, organizations had to upgrade the kernels on
their entire fleets. As downtime is not an option for many, these upgrades had
to be gradually rolled out, which can take a very long time for large fleets.

An example of an sched_ext scheduler that illustrates core scheduling
semantics is scx_example_pair.bpf.c, which co-schedules pairs of tasks from
the same cgroup, and is resilient to L1TF vulnerabilities. While this example
scheduler is certainly not suitable for production in its current form, a
similar scheduler that is more performant and featureful could be written and
deployed if necessary.

Rapid scheduling deployments can similarly be useful to quickly roll-out new
scheduling features without requiring kernel upgrades. At Google, for example,
it was observed that some low-priority workloads were causing degraded
performance for higher-priority workloads due to consuming a disproportionate
share of memory bandwidth. While a temporary mitigation was to use sched
affinity to limit the footprint of this low-priority workload to a small
subset of CPUs, a preferable solution would be to implement a more featureful
task-priority mechanism which automatically throttles lower-priority tasks
which are causing memory contention for the rest of the system. Implementing
this in CFS and rolling it out to the fleet could take a very long time.

sched_ext would directly address these gaps. If another hardware bug or
resource contention issue comes in that requires scheduler support to
mitigate, sched_ext can be used to experiment with and test different
policies. Once a scheduler is available, it can quickly be rolled out to as
many hosts as necessary, and function as a stop-gap solution until a
longer-term mitigation is upstreamed.

How
---

sched_ext is a new sched_class which allows scheduling policies to be
implemented in BPF programs.

sched_ext leverages BPF’s struct_ops feature to define a structure which
exports function callbacks and flags to BPF programs that wish to implement
scheduling policies. The struct_ops structure exported by sched_ext is struct
sched_ext_ops, and is conceptually similar to struct sched_class. The role of
sched_ext is to map the complex sched_class callbacks to the more simple and
ergonomic struct sched_ext_ops callbacks.

Unlike some other BPF program types which have ABI requirements due to
exporting UAPIs, struct_ops has no ABI requirements whatsoever. This provides
us with the flexibility to change the APIs provided to schedulers as
necessary. BPF struct_ops is also already being used successfully in other
subsystems, such as in support of TCP congestion control.

The only struct_ops field that is required to be specified by a scheduler is
the ‘name’ field. Otherwise, sched_ext will provide sane default behavior,
such as automatically choosing an idle CPU on the task wakeup path if
.select_cpu() is missing.

*Dispatch queues*

To bridge the workflow imbalance between the scheduler core and sched_ext_ops
callbacks, sched_ext uses simple FIFOs called dispatch queues (dsq's). By
default, there is one global dsq (SCX_DSQ_GLOBAL), and one local per-CPU dsq
(SCX_DSQ_LOCAL). SCX_DSQ_GLOBAL is provided for convenience and need not be
used by a scheduler that doesn't require it. As described in more detail
below, SCX_DSQ_LOCAL is the per-CPU FIFO that sched_ext pulls from when
putting the next task on the CPU. The BPF scheduler can manage an arbitrary
number of dsq's using scx_bpf_create_dsq() and scx_bpf_destroy_dsq().

*Scheduling cycle*

The following briefly shows a typical workflow for how a waking task is
scheduled and executed.

1. When a task is waking up, .select_cpu() is the first operation invoked.
   This serves two purposes. It both allows a scheduler to optimize task
   placement by specifying a CPU where it expects the task to eventually be
   scheduled, and the latter is that the selected CPU will be woken if it’s
   idle.

2. Once the target CPU is selected, .enqueue() is invoked. It can make one of
   the following decisions:

   - Immediately dispatch the task to either the global dsq (SCX_DSQ_GLOBAL)
     or the current CPU’s local dsq (SCX_DSQ_LOCAL).

   - Immediately dispatch the task to a user-created dispatch queue.

   - Queue the task on the BPF side, e.g. in an rbtree map for a vruntime
     scheduler, with the intention of dispatching it at a later time from
     .dispatch().

3. When a CPU is ready to schedule, it first looks at its local dsq. If empty,
   it invokes .consume() which should make one or more scx_bpf_consume() calls
   to consume tasks from dsq's. If a scx_bpf_consume() call succeeds, the CPU
   has the next task to run and .consume() can return. If .consume() is not
   defined, sched_ext will by-default consume from only the built-in
   SCX_DSQ_GLOBAL dsq.

4. If there's still no task to run, .dispatch() is invoked which should make
   one or more scx_bpf_dispatch() calls to dispatch tasks from the BPF
   scheduler to one of the dsq's. If more than one task has been dispatched,
   go back to the previous consumption step.

*Verifying callback behavior*

sched_ext always verifies that any value returned from a callback is valid,
and will issue an error and unload the scheduler if it is not. For example, if
.select_cpu() returns an invalid CPU, or if an attempt is made to invoke the
scx_bpf_dispatch() with invalid enqueue flags. Furthermore, if a task remains
runnable for too long without being scheduled, sched_ext will detect it and
error-out the scheduler.

Closing Thoughts
----------------

Both Meta and Google have experimented quite a lot with schedulers in the last
several years. Google has benchmarked various workloads using user space
scheduling, and have achieved performance wins by trading off generality for
application specific needs. At Meta, we have not yet deployed sched_ext on any
production workloads, though our preliminary experiments indicate that
sched_ext would provide significant performance wins when deployed at scale.
If successfully upstreamed, we expect to leverage it extensively to run
various experiments and develop customized schedulers for a number of critical
workloads.

In closing, both Meta and Google believe that sched_ext will significantly
evolve how the broader community explores the scheduling problem space,
empowering continued improvement to the in-kernel scheduler, while also
enabling targeted policies for custom applications. We’ll be able to
experiment easier and faster, explore uncharted areas, and deploy emergency
scheduler changes when necessary. The same applies to anyone who wants to work
on the scheduler, including academia and specialized industries. sched_ext
will push forward the state of the art when it comes to scheduling and
performance in Linux.

Written By
----------

David Vernet <dvernet@meta.com>
Josh Don <joshdon@google.com>
Tejun Heo <tj@kernel.org>
Barret Rhoden <brho@google.com>

Supported By
------------

Paul Turner <pjt@google.com>
Neel Natu <neelnatu@google.com>
Patrick Bellasi <derkling@google.com>
Hao Luo <haoluo@google.com>
Dimitrios Skarlatos <dskarlat@cs.cmu.edu>

Patchset
--------

This patchset is on top of bpf/for-next as of 2023-01-26:

 a5f6b9d577eb ("Merge branch 'Enable struct_ops programs to be sleepable'")

and contains the following patches:

NOTE: The doc added by 0028 contains a high-level overview and might be good
      place to start.

 0001-cgroup-Implement-cgroup_show_cftypes.patch
 0002-sched-Encapsulate-task-attribute-change-sequence-int.patch
 0003-sched-Restructure-sched_class-order-sanity-checks-in.patch
 0004-sched-Allow-sched_cgroup_fork-to-fail-and-introduce-.patch
 0005-sched-Add-sched_class-reweight_task.patch
 0006-sched-Add-sched_class-switching_to-and-expose-check_.patch
 0007-sched-Factor-out-cgroup-weight-conversion-functions.patch
 0008-sched-Expose-css_tg-__setscheduler_prio-and-SCHED_CH.patch
 0009-sched-Enumerate-CPU-cgroup-file-types.patch
 0010-sched-Add-reason-to-sched_class-rq_-on-off-line.patch
 0011-sched-Add-normal_policy.patch
 0012-sched_ext-Add-boilerplate-for-extensible-scheduler-c.patch
 0013-sched_ext-Implement-BPF-extensible-scheduler-class.patch
 0014-sched_ext-Add-scx_example_dummy-and-scx_example_qmap.patch
 0015-sched_ext-Add-sysrq-S-which-disables-the-BPF-schedul.patch
 0016-sched_ext-Implement-runnable-task-stall-watchdog.patch
 0017-sched_ext-Allow-BPF-schedulers-to-disallow-specific-.patch
 0018-sched_ext-Allow-BPF-schedulers-to-switch-all-eligibl.patch
 0019-sched_ext-Implement-scx_bpf_kick_cpu-and-task-preemp.patch
 0020-sched_ext-Make-watchdog-handle-ops.dispatch-looping-.patch
 0021-sched_ext-Add-task-state-tracking-operations.patch
 0022-sched_ext-Implement-tickless-support.patch
 0023-sched_ext-Add-cgroup-support.patch
 0024-sched_ext-Implement-SCX_KICK_WAIT.patch
 0025-sched_ext-Implement-sched_ext_ops.cpu_acquire-releas.patch
 0026-sched_ext-Implement-sched_ext_ops.cpu_online-offline.patch
 0027-sched_ext-Implement-core-sched-support.patch
 0028-sched_ext-Documentation-scheduler-Document-extensibl.patch
 0029-sched_ext-Add-a-basic-userland-vruntime-scheduler.patch
 0030-sched_ext-Add-a-rust-userspace-hybrid-example-schedu.patch

0001     : Cgroup prep.

0002-0011: Scheduler prep.

0012-0014: sched_ext core implementation and a couple example BPF scheduler.

0015-0018: Utility features including safety mechanisms and switch-all.

0020-0022: Kicking and preempting other CPUs, task state transition tracking
           and tickless support. Demonstrated with an example central
           scheduler which makes all scheduling decisions on one CPU.

0023-0025: cgroup support and the ability to wait for other CPUs after
           kicking them. Demonstrated with an example pair scheduler which
           guarantees that a hyperthread pair always executes tasks from the
           same cgroup at any given time.

0026     : Add CPU hotplug callbacks.

0027     : Add core-sched support.

0028     : Add documentation.

0029-0030: Add two example schedulers. One demonstrating deferring most
           scheduling decisions to userland. The other demonstrating a
           hybrid approach where load balancing decisions are made by
           userspace written in rust.

The patchset is also available in the following git branch:

 https://github.com/htejun/sched_ext sched_ext-v2

diffstat follows.

 Documentation/scheduler/index.rst              |    1
 Documentation/scheduler/sched-ext.rst          |  224 ++
 MAINTAINERS                                    |    3
 drivers/tty/sysrq.c                            |    1
 include/asm-generic/vmlinux.lds.h              |    1
 include/linux/cgroup-defs.h                    |    8
 include/linux/cgroup.h                         |    1
 include/linux/sched.h                          |    5
 include/linux/sched/ext.h                      |  678 ++++++++
 include/linux/sched/task.h                     |    3
 include/uapi/linux/sched.h                     |    1
 init/Kconfig                                   |    5
 init/init_task.c                               |   12
 kernel/Kconfig.preempt                         |   24
 kernel/bpf/bpf_struct_ops_types.h              |    4
 kernel/cgroup/cgroup.c                         |   97 +
 kernel/fork.c                                  |   17
 kernel/sched/build_policy.c                    |    5
 kernel/sched/core.c                            |  493 +++---
 kernel/sched/deadline.c                        |    4
 kernel/sched/debug.c                           |    6
 kernel/sched/ext.c                             | 4037 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/ext.h                             |  241 +++
 kernel/sched/fair.c                            |    9
 kernel/sched/idle.c                            |    2
 kernel/sched/rt.c                              |    4
 kernel/sched/sched.h                           |  159 +-
 kernel/sched/topology.c                        |    4
 tools/sched_ext/.gitignore                     |    8
 tools/sched_ext/Makefile                       |  212 ++
 tools/sched_ext/atropos/.gitignore             |    3
 tools/sched_ext/atropos/Cargo.toml             |   28
 tools/sched_ext/atropos/build.rs               |   70
 tools/sched_ext/atropos/rustfmt.toml           |    8
 tools/sched_ext/atropos/src/bpf/atropos.bpf.c  |  632 +++++++
 tools/sched_ext/atropos/src/bpf/atropos.h      |   44
 tools/sched_ext/atropos/src/main.rs            |  648 ++++++++
 tools/sched_ext/atropos/src/oss/atropos_sys.rs |   10
 tools/sched_ext/atropos/src/oss/mod.rs         |   29
 tools/sched_ext/atropos/src/util.rs            |   24
 tools/sched_ext/gnu/stubs.h                    |    1
 tools/sched_ext/scx_common.bpf.h               |  134 +
 tools/sched_ext/scx_example_central.bpf.c      |  337 ++++
 tools/sched_ext/scx_example_central.c          |   94 +
 tools/sched_ext/scx_example_dummy.bpf.c        |   67
 tools/sched_ext/scx_example_dummy.c            |   97 +
 tools/sched_ext/scx_example_pair.bpf.c         |  646 ++++++++
 tools/sched_ext/scx_example_pair.c             |  143 +
 tools/sched_ext/scx_example_pair.h             |   10
 tools/sched_ext/scx_example_qmap.bpf.c         |  398 +++++
 tools/sched_ext/scx_example_qmap.c             |  106 +
 tools/sched_ext/scx_example_userland.bpf.c     |  275 +++
 tools/sched_ext/scx_example_userland.c         |  403 +++++
 tools/sched_ext/scx_example_userland_common.h  |   19
 tools/sched_ext/user_exit_info.h               |   50
 55 files changed, 10314 insertions(+), 231 deletions(-)

Thanks.

--
tejun

