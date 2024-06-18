Return-Path: <bpf+bounces-32435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BAD90DE1B
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E160F1F24AA2
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB6D17838C;
	Tue, 18 Jun 2024 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dzw3K/ge"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC3D1662EA;
	Tue, 18 Jun 2024 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745669; cv=none; b=VSvyWN6Z3VXmqLXA0rN8OYt2z2VByI4o9ZA25VNyN92zd9mw+SYgLKzhPomocVcunS3Bk37eVAwHNb5ngDdJ9QP2Fli45k2fsypGJ/TkI9Rs3nHE5c+GFea0JsutdNDlLhbNK0QhQw+5LA3I34NPFMs7emzrDAYUBgXiq0zTkzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745669; c=relaxed/simple;
	bh=YWGTkUIfIhvQtBtqaOZdGg2aRJJOP1GnahOGggsOHJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DSa6XmU9tyHTcEMenWwMzOXD9zTDHp//fLs5m0qUrKoCrxu38jdvm6+/4eoRATbw3xZ3z7aLt4k5oDabV6ouUE/glMUsVFDa+udaXiQH80esWOIaPyW39XVB248JVbet+Ajg4WGSXeI1c9b1gvDQjbjSZdYTt2VYDkL0WYTmMFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dzw3K/ge; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-704090c11easo4950311b3a.2;
        Tue, 18 Jun 2024 14:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745665; x=1719350465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WYNlC+3uSCvfx+1HZTb23Tktg3db++9rfQBUR0QJIxs=;
        b=Dzw3K/geBXMBG7BYqTQ7Eg0aWvu+z6dUa3V1gvI+E9D17RxicTOGM9YnngDJNv6Bdd
         5cNefp+PErWLdK5eTldWlFyMIe2s7kJz/LI5S02LkPIe/5u3zxaWiMR7Ep1n9ElnZLHj
         u2kMCN7w8FS48ReOo4On3eQDCkH0b0JBoWwqshREmVhBRE4PKsvABebqGtyVEs/abqGJ
         KmDv9i6HgiSDLfk5Z/ftSgkx6+EpRO6ewwIULWGwTrjdvIeBUFtPvA+gB5KhKT2VzT1u
         BJc7drakVhTQm/plbeXHpbccoQ2oWM+r0er5WG3kykRfW4MRJxGD03JcRXOFjEUkD900
         s4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745665; x=1719350465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYNlC+3uSCvfx+1HZTb23Tktg3db++9rfQBUR0QJIxs=;
        b=OhZA9emJXF8OcC3TxkcYt0lkvZ4MXmwh0jbfCgSXCGRsUwEQiATlMcesomNS4ArhKM
         WUf9RQpbJeuMnRgXdxqqKc1gU2VBN+ykFp2J47JpBA6ovwrGA18D83gUmZyl73b8+qoe
         rDILmPLzBlCENUKKSAWLq833llCBgvr8CbRtVlaO2s+q/sgPw7I5aYbXWgbfOM8d1UYM
         RvR0630sKNHRt8PM+bbiTkQxCXr90vGObAamKtXkn8uHI/rXIyBXS6pThi253KaOMgWr
         ekGvnbCPucvUE5w2oBQ61OobejtcSgkKg5YXfOlx9TCDO5J2hj+G3FfOfz3ykkw/uNGD
         GbzA==
X-Forwarded-Encrypted: i=1; AJvYcCXvG1SBQstLAkkMxdpAjVs5sWhwedUtmRB7POcaK4on1dk10oT22Xl/IsTcmmSfhOhs4fkMNfzaiNkc+RhfKDpsi7R9
X-Gm-Message-State: AOJu0YyzYKfF33UQ0/HyXmE8PvoxSMxBYlBrc0PTQozwAlVZUikx2/sR
	O0TyLKO88O7UnKYlPr9tekAqxoKzY9c7efUmJ2vYoMdAuaz8QMzl
X-Google-Smtp-Source: AGHT+IEvH4/1qEGbBw59tgJYfWqFRqMJ3WQz62uQFN7kMcaKaJTd7gyImIkLLjwEJK4USsIRO26mJg==
X-Received: by 2002:a05:6a20:1a9b:b0:1b7:cc4e:eb6 with SMTP id adf61e73a8af0-1bcbb451f65mr683598637.8.1718745664704;
        Tue, 18 Jun 2024 14:21:04 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d2b7sm9360411b3a.106.2024.06.18.14.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:04 -0700 (PDT)
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
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCHSET v7] sched: Implement BPF extensible scheduler class
Date: Tue, 18 Jun 2024 11:17:15 -1000
Message-ID: <20240618212056.2833381-1-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
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

This is v7 and the final posting of the sched_ext (SCX) patchset. sched_ext
is scheduled to be merged in the coming v6.11 merge window. Development from
this point on will take place in the below korg tree seeded with this
patchset and follow the usual kernel development protocol.

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/

Please refer to the v6 patchset thread for the discussions and conclusion:

 https://lore.kernel.org/all/20240501151312.635565-1-tj@kernel.org/#r

If you're interested in getting your hands dirty, the following repository
contains example and practical schedulers along with documentation on how to
get started:

  https://github.com/sched-ext/scx

The kernel and scheduler packages are available for Ubuntu, CachyOS and Arch
(through CachyOS repo). Fedora packaging is in the works.

There are also a slack and weekly office hour:

  https://bit.ly/scx_slack

  Office Hour: Mondays at 16:00 UTC (8:00 AM PST, 16:00 UTC, 17:00 CEST,
               1:00 AM KST). Please see the #office-hours channel for the
               zoom invite.


Changes from v6
(https://lkml.kernel.org/r/20240501151312.635565-1-tj@kernel.org):

- Rebased on top of tip/sched/core + bpf/for-next as of 2024-06-24. 

- A bug in CPU hotplug support is fixed. This made
  0009-sched-Add-reason-to-sched_class-rq_-on-off-line.patch unnecessary.
  Dropped.

- Features that interact with other subsystems or have other dependencies
  are separated out and will be posted as separate patchsets.

  - cgroup support:

    0001-cgroup-Implement-cgroup_show_cftypes.patch
    0007-sched-Expose-css_tg-and-__setscheduler_prio.patch
    0008-sched-Enumerate-CPU-cgroup-file-types.patch
    0028-sched_ext-Add-cgroup-support.patch
    0029-sched_ext-Add-a-cgroup-scheduler-which-uses-flattene.patch

  - cpufreq support:

    0011-cpufreq_schedutil-Refactor-sugov_cpu_is_busy.patch
    0037-sched_ext-Add-cpuperf-support.patch

  - DSQ iterator:

    0036-sched_ext-Implement-DSQ-iterator.patch

  Combined with the dropping of 0009, this reduces the total number of
  patches in this series to 30.

- sched_ext_ops.dump*() operations are added so that the BPF scheduler can
  dump information specific to the scheduler implementation. Dump can now
  also be initiated using SysRq-D and read through a tracepoint.

- Fixes for bugs including a race condition around TASK_DEAD handling in the
  enable path and possible deadlock in the disable path.

- Cleanups including dropping backward compat helpers as this patchset will
  be the new baseline.


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

This patchset is on top of tip/sched/core + bpf/for-next as of 2024-06-24:

  c793a62823d1 ("sched/core: Drop spinlocks on contention iff kernel is preemptible")
  f6afdaf72af7 ("Merge branch 'bpf-support-resilient-split-btf'")

and contains the following patches:

NOTE: The doc added by 0029 contains a high-level overview and might be good
      place to start.

0001-sched-Restructure-sched_class-order-sanity-checks-in.patch
0002-sched-Allow-sched_cgroup_fork-to-fail-and-introduce-.patch
0003-sched-Add-sched_class-reweight_task.patch
0004-sched-Add-sched_class-switching_to-and-expose-check_.patch
0005-sched-Factor-out-cgroup-weight-conversion-functions.patch
0006-sched-Factor-out-update_other_load_avgs-from-__updat.patch
0007-sched-Add-normal_policy.patch
0008-sched_ext-Add-boilerplate-for-extensible-scheduler-c.patch
0009-sched_ext-Implement-BPF-extensible-scheduler-class.patch
0010-sched_ext-Add-scx_simple-and-scx_example_qmap-exampl.patch
0011-sched_ext-Add-sysrq-S-which-disables-the-BPF-schedul.patch
0012-sched_ext-Implement-runnable-task-stall-watchdog.patch
0013-sched_ext-Allow-BPF-schedulers-to-disallow-specific-.patch
0014-sched_ext-Print-sched_ext-info-when-dumping-stack.patch
0015-sched_ext-Print-debug-dump-after-an-error-exit.patch
0016-tools-sched_ext-Add-scx_show_state.py.patch
0017-sched_ext-Implement-scx_bpf_kick_cpu-and-task-preemp.patch
0018-sched_ext-Add-a-central-scheduler-which-makes-all-sc.patch
0019-sched_ext-Make-watchdog-handle-ops.dispatch-looping-.patch
0020-sched_ext-Add-task-state-tracking-operations.patch
0021-sched_ext-Implement-tickless-support.patch
0022-sched_ext-Track-tasks-that-are-subjects-of-the-in-fl.patch
0023-sched_ext-Implement-SCX_KICK_WAIT.patch
0024-sched_ext-Implement-sched_ext_ops.cpu_acquire-releas.patch
0025-sched_ext-Implement-sched_ext_ops.cpu_online-offline.patch
0026-sched_ext-Bypass-BPF-scheduler-while-PM-events-are-i.patch
0027-sched_ext-Implement-core-sched-support.patch
0028-sched_ext-Add-vtime-ordered-priority-queue-to-dispat.patch
0029-sched_ext-Documentation-scheduler-Document-extensibl.patch
0030-sched_ext-Add-selftests.patch

0001-0007: Scheduler prep.

0008-0010: sched_ext core implementation and a couple example BPF scheduler.

0011-0016: Utility features including safety mechanisms, switch-all and
           printing sched_ext state when dumping backtraces.

0017-0023: Kicking and preempting other CPUs, task state transition tracking
           and tickless support. Demonstrated with an example central
           scheduler which makes all scheduling decisions on one CPU.

0024-0026: Add CPU preemption and hotplug and power-management support.

0027     : Add core-sched support.

0028     : Add DSQ rbtree support.

0029-0030: Add documentation and selftests.

This patchset is applied to the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git for-6.11

diffstat follows.

 Documentation/scheduler/index.rst                                   |    1
 Documentation/scheduler/sched-ext.rst                               |  314 +
 MAINTAINERS                                                         |   13
 Makefile                                                            |    8
 drivers/tty/sysrq.c                                                 |    1
 include/asm-generic/vmlinux.lds.h                                   |    1
 include/linux/cgroup.h                                              |    4
 include/linux/sched.h                                               |    5
 include/linux/sched/ext.h                                           |  203 +
 include/linux/sched/task.h                                          |    3
 include/trace/events/sched_ext.h                                    |   32
 include/uapi/linux/sched.h                                          |    1
 init/init_task.c                                                    |   12
 kernel/Kconfig.preempt                                              |   26
 kernel/fork.c                                                       |   17
 kernel/sched/build_policy.c                                         |   10
 kernel/sched/core.c                                                 |  187
 kernel/sched/debug.c                                                |    3
 kernel/sched/ext.c                                                  | 6128 +++++++++++++++++++++++++++++++
 kernel/sched/ext.h                                                  |  114
 kernel/sched/fair.c                                                 |   21
 kernel/sched/idle.c                                                 |    2
 kernel/sched/sched.h                                                |   75
 kernel/sched/syscalls.c                                             |   26
 lib/dump_stack.c                                                    |    1
 tools/Makefile                                                      |   10
 tools/sched_ext/.gitignore                                          |    2
 tools/sched_ext/Makefile                                            |  246 +
 tools/sched_ext/README.md                                           |  258 +
 tools/sched_ext/include/bpf-compat/gnu/stubs.h                      |   11
 tools/sched_ext/include/scx/common.bpf.h                            |  394 +
 tools/sched_ext/include/scx/common.h                                |   75
 tools/sched_ext/include/scx/compat.bpf.h                            |   28
 tools/sched_ext/include/scx/compat.h                                |  186
 tools/sched_ext/include/scx/user_exit_info.h                        |  111
 tools/sched_ext/scx_central.bpf.c                                   |  361 +
 tools/sched_ext/scx_central.c                                       |  135
 tools/sched_ext/scx_qmap.bpf.c                                      |  524 ++
 tools/sched_ext/scx_qmap.c                                          |  131
 tools/sched_ext/scx_show_state.py                                   |   39
 tools/sched_ext/scx_simple.bpf.c                                    |  156
 tools/sched_ext/scx_simple.c                                        |  107
 tools/testing/selftests/sched_ext/.gitignore                        |    6
 tools/testing/selftests/sched_ext/Makefile                          |  218 +
 tools/testing/selftests/sched_ext/config                            |    9
 tools/testing/selftests/sched_ext/create_dsq.bpf.c                  |   58
 tools/testing/selftests/sched_ext/create_dsq.c                      |   57
 tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c         |   42
 tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.c             |   57
 tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c        |   39
 tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.c            |   56
 tools/testing/selftests/sched_ext/dsp_local_on.bpf.c                |   65
 tools/testing/selftests/sched_ext/dsp_local_on.c                    |   58
 tools/testing/selftests/sched_ext/enq_last_no_enq_fails.bpf.c       |   21
 tools/testing/selftests/sched_ext/enq_last_no_enq_fails.c           |   60
 tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c        |   43
 tools/testing/selftests/sched_ext/enq_select_cpu_fails.c            |   61
 tools/testing/selftests/sched_ext/exit.bpf.c                        |   84
 tools/testing/selftests/sched_ext/exit.c                            |   55
 tools/testing/selftests/sched_ext/exit_test.h                       |   20
 tools/testing/selftests/sched_ext/hotplug.bpf.c                     |   61
 tools/testing/selftests/sched_ext/hotplug.c                         |  168
 tools/testing/selftests/sched_ext/hotplug_test.h                    |   15
 tools/testing/selftests/sched_ext/init_enable_count.bpf.c           |   53
 tools/testing/selftests/sched_ext/init_enable_count.c               |  166
 tools/testing/selftests/sched_ext/maximal.bpf.c                     |  132
 tools/testing/selftests/sched_ext/maximal.c                         |   51
 tools/testing/selftests/sched_ext/maybe_null.bpf.c                  |   36
 tools/testing/selftests/sched_ext/maybe_null.c                      |   49
 tools/testing/selftests/sched_ext/maybe_null_fail_dsp.bpf.c         |   25
 tools/testing/selftests/sched_ext/maybe_null_fail_yld.bpf.c         |   28
 tools/testing/selftests/sched_ext/minimal.bpf.c                     |   21
 tools/testing/selftests/sched_ext/minimal.c                         |   58
 tools/testing/selftests/sched_ext/prog_run.bpf.c                    |   32
 tools/testing/selftests/sched_ext/prog_run.c                        |   78
 tools/testing/selftests/sched_ext/reload_loop.c                     |   75
 tools/testing/selftests/sched_ext/runner.c                          |  201 +
 tools/testing/selftests/sched_ext/scx_test.h                        |  131
 tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c              |   40
 tools/testing/selftests/sched_ext/select_cpu_dfl.c                  |   72
 tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c   |   89
 tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c       |   72
 tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c         |   41
 tools/testing/selftests/sched_ext/select_cpu_dispatch.c             |   70
 tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c |   37
 tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.c     |   56
 tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c |   38
 tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.c     |   56
 tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c            |   92
 tools/testing/selftests/sched_ext/select_cpu_vtime.c                |   59
 tools/testing/selftests/sched_ext/test_example.c                    |   49
 tools/testing/selftests/sched_ext/util.c                            |   71
 tools/testing/selftests/sched_ext/util.h                            |   13
 93 files changed, 13160 insertions(+), 66 deletions(-)


Patchset History
----------------

v5 (http://lkml.kernel.org/r/20231111024835.2164816-1-tj@kernel.org) -> v6:

- scx_pair, scx_userland, scx_next and the rust schedulers are removed from
  kernel tree and now hosted in https://github.com/sched-ext/scx along with
  all other schedulers.

- SCX_OPS_DISABLING state is replaced with the new bypass mechanism which
  allows temporarily putting the system into simple FIFO scheduling mode. In
  addition to the shut down path, this is used to isolate the BPF scheduler
  across power management events.

- ops.prep_enable() is replaced with ops.init_task() and
  ops.enable/disable() are now called whenever the task enters and leaves
  sched_ext instead of when the task becomes schedulable on sched_ext and
  stops being so. A new operation - ops.exit_task() - is called when the
  task stops being schedulable on sched_ext.

- scx_bpf_dispatch() can now be called from ops.select_cpu() too. This
  removes the need for communicating local dispatch decision made by
  ops.select_cpu() to ops.enqueue() via per-task storage.

- SCX_TASK_ENQ_LOCAL which told the BPF scheduler that scx_select_cpu_dfl()
  wants the task to be dispatched to the local DSQ was removed. Instead,
  scx_bpf_select_cpu_dfl() now dispatches directly if it finds a suitable
  idle CPU. If such behavior is not desired, users can use
  scx_bpf_select_cpu_dfl() which returns the verdict in a bool out param.

- Dispatch decisions made in ops.dispatch() may now be cancelled with a new
  scx_bpf_dispatch_cancel() kfunc.

- A new SCX_KICK_IDLE flag is available for use with scx_bpf_kick_cpu() to
  only send a resched IPI if the target CPU is idle.

- exit_code added to scx_exit_info. This is used to indicate different exit
  conditions on non-error exits and enables e.g. handling CPU hotplugs by
  restarting the scheduler.

- Debug dump added. When the BPF scheduler gets aborted, the states of all
  runqueues and runnable tasks are captured and sent to the scheduler binary
  to aid debugging. See https://github.com/sched-ext/scx/issues/234 for an
  example of the debug dump being used to root cause a bug in scx_lavd.

- The BPF scheduler can now iterate DSQs and consume specific tasks.

- CPU frequency scaling support added through cpuperf kfunc interface.

- The current state of sched_ext can now be monitored through files under
  /sys/sched_ext instead of /sys/kernel/debug/sched/ext. This is to enable
  monitoring on kernels which don't enable debugfs. A drgn script
  tools/sched_ext/scx_show_state.py is added for additional visibility.

- tools/sched_ext/include/scx/compat[.bpf].h and other facilities to allow
  schedulers to be loaded on older kernels are added. The current tentative
  target is maintaining backward compatibility for at least one major kernel
  release where reasonable.

- Code reorganized so that only the parts necessary to integrate with the
  rest of the kernel are in the header files.

v4 (http://lkml.kernel.org/r/20230711011412.100319-1-tj@kernel.org) -> v5:

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

