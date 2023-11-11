Return-Path: <bpf+bounces-14820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BA67E8866
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5307E1C20AB0
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3535258;
	Sat, 11 Nov 2023 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jyv5xsk7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F53915B8
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:48:53 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747683C15;
	Fri, 10 Nov 2023 18:48:47 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so2746091b3a.2;
        Fri, 10 Nov 2023 18:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670927; x=1700275727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=O6bQ7NtVMz9GqV2Zpjj7+q83ZWpVa2AoK99D3a3sy1Y=;
        b=Jyv5xsk7TvO46TdyyTWbFgnSmTkyHQRxrirxKM5WlI/m2abOPuBRcpLfF4pSNYaNck
         R9xL5DYz9ncfLQQRmJdlAztfLNEASJCqjCy7DDxoUn3E9bTbvhavGkdAQIQ06RdPiOZb
         DEGza4hY2l/VezXH9rnXPbaM60giYNrbu5PrNQrB163ObmVB5WvnXF9u1j+/PPe17Nlp
         evcIqWAMyB7nugRAcKSvXbTCCvLd91PV1f7XVEOaMDEvaRG76BR5/np7eZ9+n8vY9bzI
         lM7v4kqiPZz1WR4eJAB0zrtNM1lC5SDZG3XVxgdy3IJsb8s7Z2JI4cIRccyTHejkITZx
         i2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670927; x=1700275727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6bQ7NtVMz9GqV2Zpjj7+q83ZWpVa2AoK99D3a3sy1Y=;
        b=RD59iIIuDrmGaRkj2qCuA+k83nb3ZZoeFjdY5g6Ls6kDCm/l8i4igV5edYfSnHh1SU
         R0Tu+bZorQpWMGkyR4fjMxhjE3cLOsGGP2Pvuzq6GM4eF6VW0nDqWsIzusNx8Ov87dx7
         ugqivrXxfsif1LAsjT9ph+LP8fV035HQA1pV4h6EMDO7DHrLrjmL0uX/rKgPk1axebhY
         ROqA25oexR9cIrvdUQ6F0d7dmisGVVtTDLh8xS72lo+PfOgJkMa/WCZDm3J3QaZcAeuu
         Cva/7jk3sPCNYJGYDkoOr3f7Ma+IULJvEvxg8ewhqdYQ4/JMe5fSiRZfPCIloZobYt5n
         84NA==
X-Gm-Message-State: AOJu0YwVEBA9uT7Y5pNoVD6rB0Zg9U8EpMziZP6Sd7uTEwdb+t4ec3VW
	0WHxhsWNlbg7HJ8Zqw5iP15AGaFl2Mw=
X-Google-Smtp-Source: AGHT+IE5mjaKzlyFKI2RKAGX7OyvR2Se0WArHy4+pKI6o0orEfleR+AzFv8fImSI68YWQh5UQRjBgg==
X-Received: by 2002:a05:6a21:9183:b0:184:d9f4:c2b3 with SMTP id tp3-20020a056a21918300b00184d9f4c2b3mr1279673pzb.29.1699670926224;
        Fri, 10 Nov 2023 18:48:46 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id i2-20020aa787c2000000b0068ff6d21563sm413981pfo.148.2023.11.10.18.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:48:45 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCHSET v5] sched: Implement BPF extensible scheduler class
Date: Fri, 10 Nov 2023 16:47:26 -1000
Message-ID: <20231111024835.2164816-1-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Updates and Changes
-------------------

This is v5 of sched_ext (SCX) patchset. There was a good high-level
discussion in the last posting:

 http://lkml.kernel.org/r/20230711011412.100319-1-tj@kernel.org

As the discussion there wasn't very sprawling, I won't summarize it here. If
you're interested in the high-level arguments for and against this patchset,
the thread is worthwhile to read.

If you're interested in getting your hands dirty with sched_ext, there is
now a slack and weekly office hour:

  https://join.slack.com/t/schedextworkspace/shared_invite/zt-24c4on3sk-sHlozdLfCZBODfwU6t6dbw

  Office Hour: Mondays at 16:00 UTC (8:00 AM PST, 16:00 UTC, 17:00 CEST,
               1:00 AM KST). Please see the #office-hours channel for the
               zoom invite.

Our efforts have been focused in the following areas:

- Testing and improving sched_ext. A few subtble bugs have been identified
  and fixed and we continue to build helpers and conventions to help
  building more comprehensive sched_ext schedulers (e.g. the BPF running
  average implementation).

- Building internal deployment infrastructure. We just started rolling out a
  simple soft-affinitizing scheduler on one of the large production
  workloads.

- Experimenting with production workloads to find strategies which improve
  performance. It's still in a very early stage but in a very large scale
  latency-bound workload, we could rapidly iterate the new scx_layered
  scheduler and its configuration in production environment and achieve a
  significant performance gain (>5% bandwidth) in a short time period. The
  experience clearly demonstrates the strengths of sched_ext and is worth
  sharing. The following is the write-up of the experiment:

  https://github.com/sched-ext/sched_ext/blob/case-studies/scx_layered.md

The followings are changes from v4:
(http://lkml.kernel.org/r/20230711011412.100319-1-tj@kernel.org)

- Updated to rebase on top of the current bpf/for-next (2023-11-06).
  '0002-0010: Scheduler prep' were simply rebased on top of new EEVDF
  scheduler which demonstrate clean cut API boundary between sched-ext and
  sched core.

- To accommodate 32bit configs, fields which use atomic ops and
  store_release/load_acquire are switched from 64bits to longs.

- To help triaging, if sched_ext is enabled, backtrace dumps now show the
  currently active scheduler along with some debug information.

- Fixes for bugs including p->scx.flags corruption due to unsynchronized
  SCX_TASK_DSQ_ON_PRIQ changes, and overly permissive BTF struct and scx_bpf
  kfunc access checks.

- Other misc changes including renaming "type" to "kind" in scx_exit_info to
  ease usage from rust and other languages in which "type" is a reserved
  keyword.

- scx_atropos is renamed to scx_rusty and received signficant updates to
  improve scalability. Load metrics are now tracked in BPF and accessed only
  as necessary from userspace.

- Misc example scheduler improvements including the usage of resizable BPF
  .bss array, the introduction of SCX_BUG[_ON](), and timer CPU pinning in
  scx_central.

- Improve Makefile and documentation for example schedulers.


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

One of our main goals was to lower the barrier to entry for experimenting
with the scheduler. sched_ext provides ergonomic callbacks and helpers to
ease common operations such as managing idle CPUs, scheduling tasks on
arbitrary CPUs, handling preemptions from other scheduling classes, and
more. While sched_ext does require some ramp-up, the complexity is
self-contained, and the learning curve gradual. Developers can ramp up by
first implementing simple policies such as global weighted vtime scheduling
in only tens of lines of code, and then continue to learn the APIs and
building blocks available with sched_ext as they build more featureful and
complex schedulers.

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

BPF also provides programs with a rich set of APIs, such as maps, kfuncs,
and BPF helpers. In addition to providing useful building blocks to programs
that run entirely in kernel space (such as many of our example schedulers),
these APIs also allow programs to leverage user space in making scheduling
decisions. Specifically, the Atropos sample scheduler has a relatively
simple weighted vtime or FIFO scheduling layer in BPF, paired with a load
balancing component in userspace written in Rust. As described in more
detail below, we also built a more general user-space scheduling framework
called “rhone” by leveraging various BPF features.

On the other hand, BPF does have shortcomings, as can be plainly seen from
the complexity in some of the example schedulers. scx_pair.bpf.c illustrates
this point well. To start, it requires a good amount of code to emulate
cgroup-local-storage. In the kernel proper, this would simply be a matter of
adding another pointer to the struct cgroup, but in BPF, it requires a
complex juggling of data amongst multiple different maps, a good amount of
boilerplate code, and some unwieldy bpf_loop()‘s and atomics. The code is
also littered with explicit and often unnecessary sanity checks to appease
the verifier.

That being said, BPF is being rapidly improved. For example, Yonghong Song
recently upstreamed a patch set [5] to add a cgroup local storage map type,
allowing scx_pair.bpf.c to be simplified. There are plans to address other
issues as well, such as providing statically-verified locking, and avoiding
the need for unnecessary sanity checks. Addressing these shortcomings is a
high priority for BPF, and as progress continues to be made, we expect most
deficiencies to be addressed in the not-too-distant future.

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
One example is “central” scheduling, wherein a single CPU makes all
scheduling decisions for the entire system. This allows most cores on the
system to be fully dedicated to running workloads, and can have significant
performance improvements for certain use cases. For example, central
scheduling with VCPUs can avoid expensive vmexits and cache flushes, by
instead delegating the responsibility of preemption checks from the tick to
a single CPU. See scx_central.bpf.c for a simple example of a central
scheduling policy built in sched_ext.

Some workloads also have non-generalizable constraints which enable
optimizations in a scheduling policy which would otherwise not be feasible.
For example,VM workloads at Google typically have a low overcommit ratio
compared to the number of physical CPUs. This allows the scheduler to support
bounded tail latencies, as well as longer blocks of uninterrupted time.

Yet another interesting use case is the scx_flatcg scheduler, which is in
0024-sched_ext-Add-cgroup-support.patch and provides a flattened
hierarchical vtree for cgroups. This scheduler does not account for
thundering herd problems among cgroups, and therefore may not be suitable
for inclusion in CFS. However, in a simple benchmark using wrk[8] on apache
serving a CGI script calculating sha1sum of a small file, it outperformed
CFS by ~3% with CPU controller disabled and by ~10% with two apache
instances competing with 2:1 weight ratio nested four level deep.

[7] https://github.com/wg/wrk

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

We acknowledge that to some degree, sched_ext does run the risk of
increasing the fragmentation of scheduler implementations. As a result of
exploration, however, we believe that enabling the larger ecosystem to
innovate will ultimately accelerate the overall development and performance
of Linux.

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
upstream community. We expect that some of these, such as the simple example
schedulers and scx_rusty scheduler, will be upstreamed as part of the kernel
tree. Distros will be able to package and release these schedulers with the
kernel, allowing users to utilize these schedulers out-of-the-box without
requiring any additional work or dependencies such as clang or building the
scheduler programs themselves. Other schedulers and scheduling frameworks
such as rhone may be open-sourced through separate per-project repos.

3. Rapid scheduler deployments

Rolling out kernel upgrades is a slow and iterative process. At a large scale
it can take months to roll a new kernel out to a fleet of servers. While this
latency is expected and inevitable for normal kernel upgrades, it can become
highly problematic when kernel changes are required to fix bugs. Livepatch [8]
is available to quickly roll out critical security fixes to large fleets, but
the scope of changes that can be applied with livepatching is fairly limited,
and would likely not be usable for patching scheduling policies. With
sched_ext, new scheduling policies can be rapidly rolled out to production
environments.

[8]: https://www.kernel.org/doc/html/latest/livepatch/livepatch.html

As an example, one of the variants of the L1 Terminal Fault (L1TF) [9]
vulnerability allows a VCPU running a VM to read arbitrary host kernel
memory for pages in L1 data cache. The solution was to implement core
scheduling, which ensures that tasks running as hypertwins have the same
“cookie”.

[9]: https://www.intel.com/content/www/us/en/architecture-and-technology/l1tf.html

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
semantics is scx_pair.bpf.c, which co-schedules pairs of tasks from the same
cgroup, and is resilient to L1TF vulnerabilities. While this example
scheduler is certainly not suitable for production in its current form, a
similar scheduler that is more performant and featureful could be written
and deployed if necessary.

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

Both Meta and Google have experimented quite a lot with schedulers in the
last several years. Google has benchmarked various workloads using user
space scheduling, and have achieved performance wins by trading off
generality for application specific needs. At Meta, we are actively
experimenting with multiple production workloads and seeing significant
performance gains, and are in the process of deploying sched_ext schedulers
on production workloads at scale. We expect to leverage it extensively to
run various experiments and develop customized schedulers for a number of
critical workloads.

In closing, both Meta and Google believe that sched_ext will significantly
evolve how the broader community explores the scheduling problem space,
while also enabling targeted policies for custom applications. We’ll be able
to experiment easier and faster, explore uncharted areas, and deploy
emergency scheduler changes when necessary. The same applies to anyone who
wants to work on the scheduler, including academia and specialized
industries. sched_ext will push forward the state of the art when it comes
to scheduling and performance in Linux.


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

This patchset is on top of bpf/for-next as of 2023-11-06:

 856624f12b04 ("bpf, lpm: Fix check prefixlen before walking trie")

and contains the following patches:

NOTE: The doc added by 0033 contains a high-level overview and might be good
      place to start.

0001-cgroup-Implement-cgroup_show_cftypes.patch
0002-sched-Restructure-sched_class-order-sanity-checks-in.patch
0003-sched-Allow-sched_cgroup_fork-to-fail-and-introduce-.patch
0004-sched-Add-sched_class-reweight_task.patch
0005-sched-Add-sched_class-switching_to-and-expose-check_.patch
0006-sched-Factor-out-cgroup-weight-conversion-functions.patch
0007-sched-Expose-css_tg-and-__setscheduler_prio.patch
0008-sched-Enumerate-CPU-cgroup-file-types.patch
0009-sched-Add-reason-to-sched_class-rq_-on-off-line.patch
0010-sched-Add-normal_policy.patch
0011-sched_ext-Add-boilerplate-for-extensible-scheduler-c.patch
0012-sched_ext-Implement-BPF-extensible-scheduler-class.patch
0013-sched_ext-Add-scx_simple-and-scx_example_qmap-exampl.patch
0014-sched_ext-Add-sysrq-S-which-disables-the-BPF-schedul.patch
0015-sched_ext-Implement-runnable-task-stall-watchdog.patch
0016-sched_ext-Allow-BPF-schedulers-to-disallow-specific-.patch
0017-sched_ext-Allow-BPF-schedulers-to-switch-all-eligibl.patch
0018-sched_ext-Print-sched_ext-info-when-dumping-stack.patch
0019-sched_ext-Implement-scx_bpf_kick_cpu-and-task-preemp.patch
0020-sched_ext-Add-a-central-scheduler-which-makes-all-sc.patch
0021-sched_ext-Make-watchdog-handle-ops.dispatch-looping-.patch
0022-sched_ext-Add-task-state-tracking-operations.patch
0023-sched_ext-Implement-tickless-support.patch
0024-sched_ext-Track-tasks-that-are-subjects-of-the-in-fl.patch
0025-sched_ext-Add-cgroup-support.patch
0026-sched_ext-Add-a-cgroup-based-core-scheduling-schedul.patch
0027-sched_ext-Add-a-cgroup-scheduler-which-uses-flattene.patch
0028-sched_ext-Implement-SCX_KICK_WAIT.patch
0029-sched_ext-Implement-sched_ext_ops.cpu_acquire-releas.patch
0030-sched_ext-Implement-sched_ext_ops.cpu_online-offline.patch
0031-sched_ext-Implement-core-sched-support.patch
0032-sched_ext-Add-vtime-ordered-priority-queue-to-dispat.patch
0033-sched_ext-Documentation-scheduler-Document-extensibl.patch
0034-sched_ext-Add-a-basic-userland-vruntime-scheduler.patch
0035-sched_ext-Add-scx_rusty-a-rust-userspace-hybrid-sche.patch
0036-sched_ext-Add-scx_layered-a-highly-configurable-mult.patch

0001     : Cgroup prep.

0002-0010: Scheduler prep.

0011-0013: sched_ext core implementation and a couple example BPF scheduler.

0014-0018: Utility features including safety mechanisms, switch-all and
           printing sched_ext state when dumping backtraces.

0019-0024: Kicking and preempting other CPUs, task state transition tracking
           and tickless support. Demonstrated with an example central
           scheduler which makes all scheduling decisions on one CPU.

0025-0029: cgroup support and the ability to wait for other CPUs after
           kicking them. Demonstrated with an example pair scheduler which
           guarantees that a hyperthread pair always executes tasks from the
           same cgroup at any given time.

0030     : Add CPU hotplug callbacks.

0031     : Add core-sched support.

0032     : Add DSQ rbtree support.

0033     : Add documentation.

0034-0035: Add two example schedulers. One demonstrating deferring most
           scheduling decisions to userland. The other demonstrating a
           hybrid approach where load balancing decisions are made by
           userspace written in rust.

0036     : A rust hybrid scheduler which is highly configurable and allows
           grouping tasks into layers and applying different scheduling
           strategies to them. This isn't intended for upstream inclusion.
           Will be hosted in a separate sched_ext scheduler repo.

The patchset is also available in the following git branch:

 https://github.com/htejun/sched_ext sched_ext-v5

diffstat follows.

 Documentation/scheduler/index.rst                 |    1 
 Documentation/scheduler/sched-ext.rst             |  229 +
 MAINTAINERS                                       |    3 
 Makefile                                          |    8 
 drivers/tty/sysrq.c                               |    1 
 include/asm-generic/vmlinux.lds.h                 |    1 
 include/linux/cgroup-defs.h                       |    8 
 include/linux/cgroup.h                            |    5 
 include/linux/sched.h                             |    5 
 include/linux/sched/ext.h                         |  716 +++
 include/linux/sched/task.h                        |    3 
 include/uapi/linux/sched.h                        |    1 
 init/Kconfig                                      |    5 
 init/init_task.c                                  |   12 
 kernel/Kconfig.preempt                            |   24 
 kernel/bpf/bpf_struct_ops_types.h                 |    4 
 kernel/cgroup/cgroup.c                            |   97 
 kernel/fork.c                                     |   17 
 kernel/sched/build_policy.c                       |    5 
 kernel/sched/core.c                               |  316 +
 kernel/sched/deadline.c                           |    4 
 kernel/sched/debug.c                              |    6 
 kernel/sched/ext.c                                | 4496 ++++++++++++++++++++++
 kernel/sched/ext.h                                |  266 +
 kernel/sched/fair.c                               |    9 
 kernel/sched/idle.c                               |    2 
 kernel/sched/rt.c                                 |    4 
 kernel/sched/sched.h                              |  117 
 kernel/sched/topology.c                           |    4 
 lib/dump_stack.c                                  |    1 
 tools/Makefile                                    |   10 
 tools/sched_ext/.gitignore                        |   10 
 tools/sched_ext/Kconfig                           |    9 
 tools/sched_ext/Makefile                          |  301 +
 tools/sched_ext/README.md                         |  403 +
 tools/sched_ext/gnu/stubs.h                       |    1 
 tools/sched_ext/ravg.bpf.h                        |   42 
 tools/sched_ext/ravg_impl.bpf.h                   |  358 +
 tools/sched_ext/ravg_read.rs.h                    |   82 
 tools/sched_ext/scx_central.bpf.c                 |  342 +
 tools/sched_ext/scx_central.c                     |  123 
 tools/sched_ext/scx_common.bpf.h                  |  244 +
 tools/sched_ext/scx_common.h                      |   59 
 tools/sched_ext/scx_flatcg.bpf.c                  |  912 ++++
 tools/sched_ext/scx_flatcg.c                      |  221 +
 tools/sched_ext/scx_flatcg.h                      |   49 
 tools/sched_ext/scx_layered/.gitignore            |    3 
 tools/sched_ext/scx_layered/Cargo.toml            |   30 
 tools/sched_ext/scx_layered/build.rs              |   77 
 tools/sched_ext/scx_layered/rustfmt.toml          |    8 
 tools/sched_ext/scx_layered/src/bpf/layered.bpf.c |  974 ++++
 tools/sched_ext/scx_layered/src/bpf/layered.h     |  100 
 tools/sched_ext/scx_layered/src/bpf/util.bpf.c    |   68 
 tools/sched_ext/scx_layered/src/layered_sys.rs    |   10 
 tools/sched_ext/scx_layered/src/main.rs           | 1641 ++++++++
 tools/sched_ext/scx_pair.bpf.c                    |  626 +++
 tools/sched_ext/scx_pair.c                        |  168 
 tools/sched_ext/scx_pair.h                        |    9 
 tools/sched_ext/scx_qmap.bpf.c                    |  401 +
 tools/sched_ext/scx_qmap.c                        |  105 
 tools/sched_ext/scx_rusty/.gitignore              |    3 
 tools/sched_ext/scx_rusty/Cargo.toml              |   28 
 tools/sched_ext/scx_rusty/build.rs                |   72 
 tools/sched_ext/scx_rusty/rustfmt.toml            |    8 
 tools/sched_ext/scx_rusty/src/bpf/rusty.bpf.c     | 1153 +++++
 tools/sched_ext/scx_rusty/src/bpf/rusty.h         |   97 
 tools/sched_ext/scx_rusty/src/main.rs             | 1246 ++++++
 tools/sched_ext/scx_rusty/src/rusty_sys.rs        |   10 
 tools/sched_ext/scx_simple.bpf.c                  |  143 
 tools/sched_ext/scx_simple.c                      |   99 
 tools/sched_ext/scx_userland.bpf.c                |  262 +
 tools/sched_ext/scx_userland.c                    |  366 +
 tools/sched_ext/scx_userland.h                    |   19 
 tools/sched_ext/user_exit_info.h                  |   50 
 74 files changed, 17207 insertions(+), 105 deletions(-)


Patchset History
----------------

v3 (https://lkml.kernel.org/r/20230317213333.2174969-1-tj@kernel.org) -> v4:

- There aren't any significant changes to the sched_ext API even though we
  kept experimenting heavily with a couple BPF scheduler implementations
  indicating that the core API reached a level of maturity.

- 0002-sched-Encapsulate-task-attribute-change-sequence-int.patch which
  implemented custom guard scope for scheduler attribute changes dropped as
  upstream is moving towards a more generic implementation.

- Build fixes with different CONFIG combinations.

- Core code cleanups and improvements including how idle CPU is selected and
  disabling ttwu_queue for tasks on SCX to avoid confusing BPF schedulers
  expecting ->select_cpu() call. See
  0012-sched_ext-Implement-BPF-extensible-scheduler-class.patch for more
  details.

- "_example" dropped from the example schedulers as the distinction between
  the example-only and practically-useful isn't black-and-white. Instead,
  each scheduler has detailed comments and there's also a README file.

- scx_central, scx_pair and scx_flatcg are moved into their own patches as
  suggested by Josh Don.

- scx_atropos received sustantial updates including fixes for bugs that
  could cause temporary stalls and improvements in load balancing and wakeup
  target CPU selection. For details, See
  0034-sched_ext-Add-a-rust-userspace-hybrid-example-schedu.patch.

v2 (http://lkml.kernel.org/r/20230128001639.3510083-1-tj@kernel.org) -> v3:

- ops.set_weight() added to allow BPF schedulers to track weight changes
  without polling p->scx.weight.

- scx_bpf_task_cgroup() kfunc added to allow BPF scheduler to reliably
  determine the current cpu cgroup under rq lock protection. This required
  improving the kf_mask SCX operation verification mechanism and adding
  0023-sched_ext-Track-tasks-that-are-subjects-of-the-in-fl.patch.

- Updated to use the latest BPF improvements including KF_RCU and the inline
  iterator.

- scx_example_flatcg added to 0024-sched_ext-Add-cgroup-support.patch. It
  uses the new BPF RB tree support to implement flattened cgroup hierarchy.

- A DSQ now also contains an rbtree so that it can be used to implement
  vtime based scheduling among tasks sharing a DSQ conveniently and
  efficiently. For more details, see
  0029-sched_ext-Add-vtime-ordered-priority-queue-to-dispat.patch. All
  eligible example schedulers are updated to default to weighted vtime
  scheduilng.

- atropos scheduler's userspace code is substantially restructred and
  rewritten. The binary is renamed to scx_atropos and can auto-config the
  domains according to the cache topology.

- Various other example scheduler updates including scx_example_dummy being
  renamed to scx_example_simple, the example schedulers defaulting to
  enabling switch_all and clarifying performance expectation of each example
  scheduler.

- A bunch of fixes and improvements. Please refer to each patch for details.

v1 (http://lkml.kernel.org/r/20221130082313.3241517-1-tj@kernel.org) -> v2:

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

Thanks.

--
tejun


