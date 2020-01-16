Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA17313DDC2
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 15:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgAPOoQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 09:44:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgAPOoQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 09:44:16 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A822320684;
        Thu, 16 Jan 2020 14:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579185854;
        bh=qZUr0xpTcJ72gNB8qTMxNPOVMbwNrtWD/3Nrfdb2S2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=nWIesW0bf6cVnxVXm005X/ydqbfdIphWLvsWBP7cWSI3GiR+90zSWuAKdkgTEgYYp
         gPfm/g7PhuYidWMvcImJ/Uw/A2llKJNsUIZ56OEqlXg85KqN7Y5NEIyvLBZpxPYzrr
         tOzZKg/IepE53tsptdtj9EejdFREju1ulg7WZeqc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Brendan Gregg <brendan.d.gregg@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     mhiramat@kernel.org, Ingo Molnar <mingo@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [RFT PATCH 00/13] tracing: kprobes: Introduce async unregistration
Date:   Thu, 16 Jan 2020 23:44:09 +0900
Message-Id: <157918584866.29301.6941815715391411338.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

Here is an experimental series of patches for asynchronous kprobe
event disabling and unregistration. This fixes the performance
issue (from operator's viewpoint) of disabling/removing kprobe
events.
This still under testing phase, so please try to test it,
especially with eBPF. You can download this series from here;

  https://github.com/mhiramat/linux.git ftrace-nowait


Background
==========

In last Plumbers, Brendan showed me a demo that BPF tracer took
too long time (more than 30 seconds?) to exit from tracing.
I had seen similar issue on systemtap 10 years ago and had fixed
it by array-based batch API (see commit 9861668f7478 ("kprobes:
add (un)register_kprobes for batch registration").)
I suspected there was similar issue.


Investigation
=============

While I'm checking the current ftrace-side performance with 256
kprobes (without ftrace-based kprobes)[1] , I found there were
another issue.

----
Probes: 256 kprobe_events
Enable events
real	0m 0.00s
user	0m 0.00s
sys	0m 0.00s
Disable events
real	0m 21.40s
user	0m 0.00s
sys	0m 0.02s
Remove events
real	0m 2.24s
user	0m 0.00s
sys	0m 0.01s
----

OK, removing events took more than 2 seconds for 256 probe events.
But disabling events took 21 seconds, 10 times longer than
removing.
Actually, since perf-events (base of BPF tracer) does disable and
remove at once, it will take more than that.

I also measured it without kprobe jump optimization
(echo 0 > /proc/sys/debug/kprobe-optimization) and it changed
the results as below.

----
Probes: 256 kprobe_events
Enable events
real	0m 0.00s
user	0m 0.00s
sys	0m 0.00s
Disable events
real	0m 2.07s
user	0m 0.00s
sys	0m 0.04s
Remove events
real	0m 2.13s
user	0m 0.00s
sys	0m 0.01s
----

I checked the kprobes and tracing code and what happened, and
found that there might be mutex waiting for unoptimization.

Disabling an optimized kprobe will be done without any RCU
grace period at kprobes API level, but it kicks unoptimizer
which will be done afterwards by delayed workqueue.
On the other hand, since the ftrace needs to remove disabled
probe from an event (which is on RCU list), it waits RCU
grace period to free the event.
Thus, if we disable multiple probes at once, it repeats
(1) disable kprobes (2) kick (un)optimizer (3) remove event
from rcu list and (4) waits RCU grace period. And while (4),
if the (un)optimizer starts, then the 2nd (1) will stopped
because kprobe_mutex is already held by the (un)optimizer.

For kprobe unoptimization, the (un)optimizer locks global
kprobe_mutex and waits for some task to be scheduled on
all CPUs for safety, which takes a while.

So if we repeating the above process, the disabling will
take a long time. (and actually, it took 21 seconds)

This actually came from the delaying period is not enough
for kprobes, at this moment it just wait for 5 jiffies, but
it should be enough longer than the batch disabling process.

Also since such the batch disabling process involves many
rcu grace period wait, from operator's viewpoint, it takes
a long time. For example, from above experiment, disabling
256 probes took around 2 seconds. These waits can be replaced
by call_rcu() and workqueues.


Improvements
============

This series is a trial to solve these issues by introducing
many asynchronous improvements.

Here is the result. I have tried to remove redundant
RCU synchronizations from kprobes and kprobe events with
asynchronous APIs.

-----
Probes: 256 kprobe_events
Enable events
real	0m 0.03s
user	0m 0.00s
sys	0m 0.02s
Disable events
real	0m 0.05s
user	0m 0.00s
sys	0m 0.01s
Remove events
real	0m 0.03s
user	0m 0.00s
sys	0m 0.01s
-----

Note that this results is on the ftrace side, bpf will still
have some time to stop the tracing, because perf_event doesn't
have independent event disabling code.
The ftrace has 2 operations to stop the tracing, disable events
and remove events. Thus it is easy to wait an RCU grace period
between them. On the other hand, perf event has only "destroy"
operation which disables event and remove event at once.
To do it safely, in the destroy operation, the
perf_trace_event_unreg() calls tracepoint_synchronize_unregister(),
which is an alias of synchronize_rcu(), for each event.

Thus I guess eBPF still take O(n) to stop tracing, but it
might be 1/10 shorter than before with this series.


Patches
=======

First 2 patches are minor fix and cleanup. I will send those
as a separated series.

The [3/13] and [4/13] are postpone (and give more delay) the
kprobe unoptimizing process. This will minimize kprobe_mutex
collision with disabling/unregistering process.

[5/13] is modifying ftrace side to remove unused event_file_link
to free in call_rcu().

[6/13] is enabling kprobe-booster on preemptive kernel for
preparation. The purpose of this is replacing synchronize_rcu()
with synchronize_rcu_tasks().

[7/13]-[10/13] are refining instruction cache reclaiming process
to be asynchronous.

[11/13] adds asynchronous unregister API for kprobes and [12/13]
and [13/13] uses that API from ftrace side.


Thank you,


[1] Here is the test script

------------------
#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# description: Register/unregister many kprobe events

cd /sys/kernel/debug/tracing

# ftrace fentry skip size depends on the machine architecture.
# Currently HAVE_KPROBES_ON_FTRACE defined on x86 and powerpc64le
case `uname -m` in
  x86_64|i[3456]86) OFFS=5;;
  ppc64le) OFFS=8;;
  *) OFFS=0;;
esac

N=0
echo "Setup up kprobes on first available 256 text symbols"
grep -i " t " /proc/kallsyms | cut -f3 -d" " | grep -v .*\\..* | \
while read i; do
  echo p ${i}+${OFFS} >> kprobe_events && N=$((N+1)) &> /dev/null ||:
  test $N -eq 256 && break
done


echo -n "Probes: " ; wc -l kprobe_events
echo "Enable events"
echo 1 | time tee events/kprobes/enable > /dev/null
sleep 2
echo "Disable events"
echo 0 | time tee events/kprobes/enable > /dev/null
sleep 2
echo "Remove events"
echo | time tee kprobe_events > /dev/null
------------------

---

Masami Hiramatsu (13):
      kprobes: Fix to protect kick_kprobe_optimizer() by kprobe_mutex
      kprobes: Remove redundant arch_disarm_kprobe() call
      kprobes: Postpone optimizer until a bunch of probes (un)registered
      kprobes: Make optimizer delay to 1 second
      tracing/kprobe: Use call_rcu to defer freeing event_file_link
      kprobes: Enable kprobe-booster with CONFIG_PREEMPT=y
      kprobes: Use normal list traversal API if a mutex is held
      kprobes: Use workqueue for reclaiming kprobe insn cache pages
      kprobes: Free kprobe_insn_page asynchronously
      kprobes: Make free_*insn_slot() mutex-less
      kprobes: Add asynchronous unregistration APIs
      tracing/kprobe: Free probe event asynchronously
      tracing/kprobe: perf_event: Remove local kprobe event asynchronously


 arch/Kconfig                    |    4 +
 arch/ia64/Kconfig               |    1 
 arch/ia64/kernel/kprobes.c      |    3 
 arch/powerpc/kernel/optprobes.c |    1 
 arch/x86/Kconfig                |    1 
 arch/x86/kernel/kprobes/core.c  |    2 
 include/linux/kprobes.h         |   13 ++
 kernel/kprobes.c                |  286 ++++++++++++++++++++++++++-------------
 kernel/trace/trace_dynevent.c   |    5 +
 kernel/trace/trace_kprobe.c     |   85 +++++++++---
 kernel/trace/trace_probe.c      |   10 +
 kernel/trace/trace_probe.h      |    1 
 12 files changed, 293 insertions(+), 119 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
