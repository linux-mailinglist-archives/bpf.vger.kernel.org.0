Return-Path: <bpf+bounces-50635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B94FA2A65F
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEB81887FD9
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EC72288D7;
	Thu,  6 Feb 2025 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCll83Ll"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78F227B91;
	Thu,  6 Feb 2025 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839283; cv=none; b=K11dUQlpfJD15t38yEN4m5Fvl3J7Y7LzM5W6IGDl1sEXInRves/It1V5LaEZEy9brjmlnX4D0C13cWf2rHurjkncA/Wh25Pm/3rYB9fcU1cbJVNG/RdTI/kAoHmg4a8PpMVEzDgomLHy003mZf49FCGxnHcTnm2g+3AUsLu+Fm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839283; c=relaxed/simple;
	bh=4yuw23hrANDqaDtsOhFfdo+V2VuLoRn7Xt2rku6zRYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FfVJojhp8DyY1Ay4XquBhX/DVoJQx6kecY2N7RpTLAH/S/2zgVFEQrKlGkWyM4ycqp0/p8c2UwZ1NmEUzp4VGipy/ws73h6IsWn8tU/SybrFWvVF3N7U81xJZ/shxujdwMayfmPQygFKN2rCjsHJqLKvuh7S35Lwh9y+k4cYM9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCll83Ll; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-38dbaae68a2so597883f8f.3;
        Thu, 06 Feb 2025 02:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839277; x=1739444077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U2ULAKxOCHYPQshGtICbQ4efNAVqYuNGgsHTrReY3hk=;
        b=SCll83LlXFZLkaJgIZaT01qVpEnbujBSpQ9z4KIC6SQwBxkMuIDykAFuC289dvlsH4
         lBj4KHdV/0nMxsJ6iYGSMFTbx5L1OCba2icpkO6k3YCzUkqngokFx41uJUesIk3+oo2z
         k6v6/u66F/hh9P1TCOTbsFoK1x1zVXf6m9EdXSgp3GOOX4nUjmo73ABt8T4WuoevPFNi
         Odg70wuaXP/Q11XVNHhvJ3xxQdWC4j4cnfCT1GqH0D7c8GzOxg484VepqmrpVL9FhsVa
         TktLc2pF7a2zari10UKsVBiZcKRsoawU1UClzy5DX9d4wC6Tv3joJm1t3SO3sRHvjRaJ
         ZFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839277; x=1739444077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2ULAKxOCHYPQshGtICbQ4efNAVqYuNGgsHTrReY3hk=;
        b=iKRfvaVrLEHt1TuuBQZEuy3Z9py3tic3YpxGWeYw+ApGj+OVaIFC9Y+pWx+Vs+0Www
         9NycyuJkzCsR0Vi0HLw5nBqpxZ1lsgfiL2YznwjHanqg7IZWov18wUzejkz3NO7JRHW7
         ih8k9Uu4d2jXQEGnu+qGxm6ysXWRxjveBwRr4Z8wJ5ztgeHhR2eJdVYlvyXazdyXwU+h
         gbLkKfFRFq03oBbM3elPipo/hprazajmw6HhZDmKCnHEmN5vxX3K7KsJQk+pBR4Goi0d
         SChiY11TbBkeDAsGXshWRiLkA7KJTjObyfDwZ3BVQ9+OJwKz53lQTYsA2mI1dJRPfIXu
         1kZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUATPyjKymBDIoPh9HrIJjA8n4wOE64gkW/MP8OPHFDCM8Dxix5tf7GIy5LP8IpZE0ZnzVMWzehN8PPaHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH7FkUo+DXq/V+wp8oV9vP5EiL6ITAsYc1oaIGv6SN0fUO8FV+
	id7JuUfERW8yvlihgNM3IM/Z0JpcV5gkLuF59E4ovQZrR/htw8vtOHLXaWIMQks=
X-Gm-Gg: ASbGncsqrHgAN4hLtTcKkdpeTxjgoGu2GCN4+wUFYkpG5x08Pdz7sElD3Ctibc+pwsA
	MsOf4P8KygwikX4ofBoxbnqDR+/5EMQ6T8vGZ2cvqpBjiZzKaoOBmCWXfZNQq/akYlWW9Dle18U
	JXOm62Htctr7IHggiDXRZ5ktKBE3TWP0pLomrYpGJe7R3IB0Ug8bBbOEH8pSwmNuLofeRQmMmIh
	cq8Dx4YSg8OWwYx0OELT984oWCzKBz4siJbLMQVHqIp1lLWYeNfF5iw4F2zvVKpIqItWzuBhagD
	Xg==
X-Google-Smtp-Source: AGHT+IF4cejyY1br/FahZTYrBimd/VMkx7MZGCTL3feNe5RKiJjJMexn0eda4vuVUb80Az/eUhg7zw==
X-Received: by 2002:a05:6000:4029:b0:38d:bcf1:fff with SMTP id ffacd0b85a97d-38dbcf11345mr1373917f8f.28.1738839276606;
        Thu, 06 Feb 2025 02:54:36 -0800 (PST)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbf6e4a4bsm1030802f8f.92.2025.02.06.02.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:54:36 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 00/26] Resilient Queued Spin Lock
Date: Thu,  6 Feb 2025 02:54:08 -0800
Message-ID: <20250206105435.2159977-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=36679; h=from:subject; bh=4yuw23hrANDqaDtsOhFfdo+V2VuLoRn7Xt2rku6zRYY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRjiQVKcHxocjPZgr4kbU7HMst9s4XF9sF6LBR8 IkFtBcGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUYwAKCRBM4MiGSL8Ryq0qD/ 4n6MTTZChdWQwCpwPIX9Ms7Wus7VzKu8/MHotfYFH7YXzrzgyFMdAb9DdAMWjImoduI5tFYejUbqrI JWHmd/HrMNBY4PzaIIlg0QujCbG/Qx6WXIfJV+2ebe69yMobDlZRX7uTQg6cmlhH9MD0K6vMFi0dxc eJxn6KVdoriUv4GV85vv9VWuxZPCcqvMFE6XRrceJ8PebL4CBW/CWgFv8S3C1BEogjTUxnzyl8yLC4 9MHgAYcFxlps4Apv63q/eM+lBqicownh81eC9I7SsqlPTYimZ/IOrq+HgDTK2kQApug+Ui7Ofw1+6X LkHWB2nViAkAppr5+/kvhIstf0jkHqw/s8SqUpluXmINO/b0VekjemgesTVHNN9qBs+a7OO01ANx8r m0wDHQKERyGdAVKKsA72zJSYz0apDQO6EhhPvch+rbCreVWJs5gDt6xMe12z+HTd58OBVMR0TxbyCk hlNNJC2qRIMI+1Itl5cAsCPsVfYChuAYIOHOLgRHuHuzkH2TZBt3UIaGWqwrzbXIiM4iEl5MEslBgQ 7ILBIz1OHEXH4i922zrEhXvwwq/7RFOCjP3HE1q1j6QsPDSghdX6F+16x+oiIv7KwbwPzfa7loiyGz mmiupu312RTYXrSXlKsGOiTKJtl6Mjcj4sdPRFEIKwlIQrqjoYIbYCR3SD5Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20250107140004.2732830-1-memxor@gmail.com

 * Address nits from Waiman and Peter
 * Fix arm64 WFE bug pointed out by Peter.
 * Fix incorrect memory ordering in release_held_lock_entry, and
   document subtleties. Explain why release is sufficient in unlock
   but not in release_held_lock_entry.
 * Remove dependence on CONFIG_QUEUED_SPINLOCKS and introduce a
   test-and-set fallback when queued spinlock support is missing on an
   architecture.
 * Enforce FIFO ordering for BPF program spin unlocks.
 * Address comments from Eduard on verifier plumbing.
 * Add comments as suggested by Waiman.
 * Refactor paravirt TAS lock to use the implemented TAS fallback.
 * Use rqspinlock_t as the type throughout so that it can be replaced
   with a non-qspinlock type in case of fallback.
 * Testing and benchmarking on arm64, added numbers to the cover letter.
 * Fix kernel test robot errors.
 * Fix a BPF selftest bug leading to spurious failures on arm64.

Introduction
------------

This patch set introduces Resilient Queued Spin Lock (or rqspinlock with
res_spin_lock() and res_spin_unlock() APIs).

This is a qspinlock variant which recovers the kernel from a stalled
state when the lock acquisition path cannot make forward progress. This
can occur when a lock acquisition attempt enters a deadlock situation
(e.g. AA, or ABBA), or more generally, when the owner of the lock (which
we’re trying to acquire) isn’t making forward progress.

The cover letter provides an overview of the motivation, design, and
alternative approaches. We then provide evaluation numbers showcasing
that while rqspinlock incurs overhead, the performance of rqspinlock
approaches that of the normal qspinlock used by the kernel.

The evaluations for rqspinlock were performed by replacing the default
qspinlock implementation with it and booting the kernel to run the
experiments. Support for locktorture is also included with numbers in
this series.

The cover letter's design section provides an overview of the
algorithmic approach. A technical document describing the implementation
in more detail is available here:
https://github.com/kkdwivedi/rqspinlock/blob/main/rqspinlock.pdf

We have a WIP TLA+ proof for liveness and mutual exclusion of rqspinlock
built on top of the qspinlock TLA+ proof from Catalin Marinas [3]. We
will share more details and the links in the near future.

Motivation
----------

In regular kernel code, usage of locks is assumed to be correct, so as
to avoid deadlocks and stalls by construction, however, the same is not
true for BPF programs. Users write normal C code and the in-kernel eBPF
runtime ensures the safety of the kernel by rejecting unsafe programs.
Users can upload programs that use locks in an improper fashion, and may
cause deadlocks when these programs run inside the kernel. The verifier
is responsible for rejecting such programs from being loaded into the
kernel.

Until now, the eBPF verifier ensured deadlock safety by only permitting
one lock acquisition at a time, and by preventing any functions to be
called from within the critical section. Additionally, only a few
restricted program types are allowed to call spin locks. As the usage of
eBPF grows (e.g. with sched_ext) beyond its conventional application in
networking, tracing, and security, the limitations on locking are
becoming a bottleneck for users.

The rqspinlock implementation allows us to permit more flexible locking
patterns in BPF programs, without limiting them to the subset that can
be proven safe statically (which is fairly small, and requires complex
static analysis), while ensuring that the kernel will recover in case we
encounter a locking violation at runtime. We make a tradeoff here by
accepting programs that may potentially have deadlocks, and recover the
kernel quickly at runtime to ensure availability.

Additionally, eBPF programs attached to different parts of the kernel
can introduce new control flow into the kernel, which increases the
likelihood of deadlocks in code not written to handle reentrancy. There
have been multiple syzbot reports surfacing deadlocks in internal kernel
code due to the diverse ways in which eBPF programs can be attached to
different parts of the kernel.  By switching the BPF subsystem’s lock
usage to rqspinlock, all of these issues can be mitigated at runtime.

This spin lock implementation allows BPF maps to become safer and remove
mechanisms that have fallen short in assuring safety when nesting
programs in arbitrary ways in the same context or across different
contexts. The red diffs due to patches 16-18 demonstrate this
simplification.

>  kernel/bpf/hashtab.c         | 102 ++++++++++++++++++++++++++++++++--------------------------...
>  kernel/bpf/lpm_trie.c        |  25 ++++++++++++++-----------
>  kernel/bpf/percpu_freelist.c | 113 +++++++++++++++++++++++++---------------------------------...
>  kernel/bpf/percpu_freelist.h |   4 ++--
>  4 files changed, 73 insertions(+), 171 deletions(-)

Design
------

Deadlocks mostly manifest as stalls in the waiting loops of the
qspinlock slow path. Thus, using stalls as a signal for deadlocks avoids
introducing cost to the normal fast path, and ensures bounded
termination of the waiting loop. Our recovery algorithm is focused on
terminating the waiting loops of the qspinlock algorithm when it gets
stuck, and implementing bespoke recovery procedures for each class of
waiter to restore the lock to a usable state. Deadlock detection is the
main mechanism used to provide faster recovery, with the timeout
mechanism acting as a final line of defense.

Deadlock Detection
~~~~~~~~~~~~~~~~~~
We handle two cases of deadlocks: AA deadlocks (attempts to acquire the
same lock again), and ABBA deadlocks (attempts to acquire two locks in
the opposite order from two distinct threads). Variants of ABBA
deadlocks may be encountered with more than two locks being held in the
incorrect order. These are not diagnosed explicitly, as they reduce to
ABBA deadlocks.

Deadlock detection is triggered immediately when beginning the waiting
loop of a lock slow path.

While timeouts ensure that any waiting loops in the locking slow path
terminate and return to the caller, it can be excessively long in some
situations. While the default timeout is short (0.5s), a stall for this
duration inside the kernel can set off alerts for latency-critical
services with strict SLOs.  Ideally, the kernel should recover from an
undesired state of the lock as soon as possible.

A multi-step strategy is used to recover the kernel from waiting loops
in the locking algorithm which may fail to terminate in a bounded amount
of time.

 * Each CPU maintains a table of held locks. Entries are inserted and
   removed upon entry into lock, and exit from unlock, respectively.
 * Deadlock detection for AA locks is thus simple: we have an AA
   deadlock if we find a held lock entry for the lock we’re attempting
   to acquire on the same CPU.
 * During deadlock detection for ABBA, we search through the tables of
   all other CPUs to find situations where we are holding a lock the
   remote CPU is attempting to acquire, and they are holding a lock we
   are attempting to acquire. Upon encountering such a condition, we
   report an ABBA deadlock.
 * We divide the duration between entry time point into the waiting loop
   and the timeout time point into intervals of 1 ms, and perform
   deadlock detection until timeout happens. Upon entry into the slow
   path, and then completion of each 1 ms interval, we perform detection
   of both AA and ABBA deadlocks. In the event that deadlock detection
   yields a positive result, the recovery happens sooner than the
   timeout.  Otherwise, it happens as a last resort upon completion of
   the timeout.

Timeouts
~~~~~~~~
Timeouts act as final line of defense against stalls for waiting loops.
The ‘ktime_get_mono_fast_ns’ function is used to poll for the current
time, and it is compared to the timestamp indicating the end time in the
waiter loop. Each waiting loop is instrumented to check an extra
condition using a macro. Internally, the macro implementation amortizes
the checking of the timeout to avoid sampling the clock in every
iteration.  Precisely, the timeout checks are invoked every 64k
iterations.

Recovery
~~~~~~~~
There is extensive literature in academia on designing locks that
support timeouts [0][1], as timeouts can be used as a proxy for
detecting the presence of deadlocks and recovering from them, without
maintaining explicit metadata to construct a waits-for relationship
between two threads at runtime.

In case of rqspinlock, the key simplification in our algorithm comes
from the fact that upon a timeout, waiters always leave the queue in
FIFO order.  As such, the timeout is only enforced by the head of the
wait queue, while other waiters rely on the head to signal them when a
timeout has occurred and when they need to exit. We don’t have to
implement complex algorithms and do not need extra synchronization for
waiters in the middle of the queue timing out before their predecessor
or successor, unlike previous approaches [0][1].

There are three forms of waiters in the original queued spin lock
algorithm.  The first is the waiter which acquires the pending bit and
spins on the lock word without forming a wait queue. The second is the
head waiter that is the first waiter heading the wait queue. The third
form is of all the non-head waiters queued behind the head, waiting to
be signalled through their MCS node to overtake the responsibility of
the head.

In rqspinlock's recovery algorithm, we are concerned with the second and
third kind. First, we augment the waiting loop of the head of the wait
queue with a timeout. When this timeout happens, all waiters part of the
wait queue will abort their lock acquisition attempts. This happens in
three steps.

 * First, the head breaks out of its loop waiting for pending and locked
   bits to turn to 0, and non-head waiters break out of their MCS node
   spin (more on that later).
 * Next, every waiter (head or non-head) attempts to check whether they
   are also the tail waiter, in such a case they attempt to zero out the
   tail word and allow a new queue to be built up for this lock. If they
   succeed, they have no one to signal next in the queue to stop
   spinning.
 * Otherwise, they signal the MCS node of the next waiter to break out
   of its spin and try resetting the tail word back to 0. This goes on
   until the tail waiter is found. In case of races, the new tail will
   be responsible for performing the same task, as the old tail will
   then fail to reset the tail word and wait for its next pointer to be
   updated before it signals the new tail to do the same.

Timeout Bound
~~~~~~~~~~~~~
The timeout is applied by two types of waiters: the pending bit waiter
and the wait queue head waiter. As such, for the pending waiter, only
the lock owner is ahead of it, and for the wait queue head waiter, only
the lock owner and the pending waiter take precedence in executing their
critical sections.

Therefore, the timeout value must span at most 2 critical section
lengths, and thus, it is unaffected by the amount of contention or the
number of CPUs on the host. Non-head waiters simply wait for the wait
queue head to signal them on a timeout.

In Meta's production, we have noticed uncore PMU reads and SMIs
consuming tens of msecs. While these events are rare, a 0.5 second
timeout should absorb such tail events and not raise false alarms for
timeouts. We will continue monitoring this in production and adjust the
timeout if necessary in the future.

More details of the recovery algorithm is described in patch 9 and a
detailed description is available at [2].

Alternatives
------------

Lockdep: We do not rely on the lockdep facility for reporting violations
for primarily two reasons:

* Overhead: The lockdep infrastructure can add significant overhead to
  the lock acquisition path, and is not recommended for use in
  production due to this reason. While the report is more useful and
  exhaustive, the overhead can be prohibitive, especially as BPF
  programs run in hot paths of the kernel.  Moreover, it also increases
  the size of the lock word to store extra metadata, which is not
  feasible for BPF spin locks that are 4-bytes in size today (similar to
  qspinlock).

* Debug Tool: Lockdep is intended to be used as a debugging facility,
  providing extra context to the user about the locking violations
  occurring during runtime. It is always turned off on all production
  kernels, therefore isn’t available most of the time.

We require a mechanism for detecting common variants of deadlocks that
is always available in production kernels and never turned off. At the
same time, it must not introduce overhead in terms of time (for the slow
path) and memory (for the lock word size).

Evaluation
----------

We run benchmarks that stress locking scalability and perform comparison
against the baseline (qspinlock). For the rqspinlock case, we replace
the default qspinlock with it in the kernel, such that all spin locks in
the kernel use the rqspinlock slow path. As such, benchmarks that stress
kernel spin locks end up exercising rqspinlock.

Evaluation setup
~~~~~~~~~~~~~~~~

We set the CPU governor to performance for all experiments.

Note: Numbers for arm64 have been obtained without the no-WFE fallback
in this series, to perform a fair comparison with the WFE using
qspinlock baseline.

x86_64:

Intel Xeon Platinum 8468 (Sapphire Rapids)
96 cores (48 x 2 sockets)
2 threads per core, 0-95, siblings from 96-191
2 NUMA nodes (every 48 cores), 2 LLCs (every 48 cores), 1 LLC per NUMA node
Hyperthreading enabled

arm64:

Ampere Max Neoverse-N1 256-Core Processor
256 cores (128 cores x 2 sockets)
1 thread per core
2 NUMA nodes (every 128 cores), 1 L2 per core (256 instances), no shared L3
No hyperthreading available

The locktorture experiment is run for 30 seconds.
Average of 25 runs is used for will-it-scale, after an initial warm up.

More information on the locks contended in the will-it-scale experiments
is available in the evaluation section of the CNA paper, in table 1 [4].

Legend:
 QL - qspinlock (avg. throughput)
 RQL - rqspinlock (avg. throughput)

Results
~~~~~~~

locktorture - x86_64

Threads QL		RQL		Speedup
-----------------------------------------------
1	46910437	45057327	0.96
2	29871063	25085034	0.84
4	13876024	19242776	1.39
8	14638499	13346847	0.91
16	14380506	14104716	0.98
24	17278144	15293077	0.89
32	19494283	17826675	0.91
40	27760955	21002910	0.76
48	28638897	26432549	0.92
56	29336194	26512029	0.9
64	30040731	27421403	0.91
72	29523599	27010618	0.91
80	28846738	27885141	0.97
88	29277418	25963753	0.89
96	28472339	27423865	0.96
104	28093317	26634895	0.95
112	29914000	27872339	0.93
120	29199580	26682695	0.91
128	27755880	27314662	0.98
136	30349095	27092211	0.89
144	29193933	27805445	0.95
152	28956663	26071497	0.9
160	28950009	28183864	0.97
168	29383520	28135091	0.96
176	28475883	27549601	0.97
184	31958138	28602434	0.89
192	31342633	33394385	1.07

will-it-scale open1_threads - x86_64

Threads QL      	QL stddev       stddev% RQL     	RQL stddev      stddev% Speedup
-----------------------------------------------------------------------------------------------
1	1396323.92	7373.12		0.53	1366616.8	4152.08		0.3	0.98
2	1844403.8	3165.26		0.17	1700301.96	2396.58		0.14	0.92
4	2370590.6	24545.54	1.04	1655872.32	47938.71	2.9	0.7
8	2185227.04	9537.9		0.44	1691205.16	9783.25		0.58	0.77
16	2110672.36	10972.99	0.52	1781696.24	15021.43	0.84	0.84
24	1655042.72	18037.23	1.09	2165125.4	5422.54		0.25	1.31
32	1738928.24	7166.64		0.41	1829468.24	9081.59		0.5	1.05
40	1854430.52	6148.24		0.33	1731062.28	3311.95		0.19	0.93
48	1766529.96	5063.86		0.29	1749375.28	2311.27		0.13	0.99
56	1303016.28	6168.4		0.47	1452656		7695.29		0.53	1.11
64	1169557.96	4353.67		0.37	1287370.56	8477.2		0.66	1.1
72	1036023.4	7116.53		0.69	1135513.92	9542.55		0.84	1.1
80	1097913.64	11356		1.03	1176864.8	6771.41		0.58	1.07
88	1123907.36	12843.13	1.14	1072416.48	7412.25		0.69	0.95
96	1166981.52	9402.71		0.81	1129678.76	9499.14		0.84	0.97
104	1108954.04	8171.46		0.74	1032044.44	7840.17		0.76	0.93
112	1000777.76	8445.7		0.84	1078498.8	6551.47		0.61	1.08
120	1029448.4	6992.29		0.68	1093743		8378.94		0.77	1.06
128	1106670.36	10102.15	0.91	1241438.68	23212.66	1.87	1.12
136	1183776.88	6394.79		0.54	1116799.64	18111.38	1.62	0.94
144	1201122		25917.69	2.16	1301779.96	15792.6		1.21	1.08
152	1099737.08	13567.82	1.23	1053647.2	12704.29	1.21	0.96
160	1031186.32	9048.07		0.88	1069961.4	8293.18		0.78	1.04
168	1068817		16486.06	1.54	1096495.36	14021.93	1.28	1.03
176	966633.96	9623.27		1	1081129.84	9474.81		0.88	1.12
184	1004419.04	12111.11	1.21	1037771.24	12001.66	1.16	1.03
192	1088858.08	16522.93	1.52	1027943.12	14238.57	1.39	0.94

will-it-scale open2_threads - x86_64

Threads QL      	QL stddev       stddev% RQL     	RQL stddev      stddev% Speedup
-----------------------------------------------------------------------------------------------
1	1337797.76	4649.19		0.35	1332609.4	3813.14		0.29	1
2	1598300.2	1059.93		0.07	1771891.36	5667.12		0.32	1.11
4	1736573.76	13025.33	0.75	1396901.2	2682.46		0.19	0.8
8	1794367.84	4879.6		0.27	1917478.56	3751.98		0.2	1.07
16	1990998.44	8332.78		0.42	1864165.56	9648.59		0.52	0.94
24	1868148.56	4248.23		0.23	1710136.68	2760.58		0.16	0.92
32	1955180		6719		0.34	1936149.88	1980.87		0.1	0.99
40	1769646.4	4686.54		0.26	1729653.68	4551.22		0.26	0.98
48	1724861.16	4056.66		0.24	1764900		971.11		0.06	1.02
56	1318568		7758.86		0.59	1385660.84	7039.8		0.51	1.05
64	1143290.28	5351.43		0.47	1316686.6	5597.69		0.43	1.15
72	1196762.68	10655.67	0.89	1230173.24	9858.2		0.8	1.03
80	1126308.24	6901.55		0.61	1085391.16	7444.34		0.69	0.96
88	1035672.96	5452.95		0.53	1035541.52	8095.33		0.78	1
96	1030203.36	6735.71		0.65	1020113.48	8683.13		0.85	0.99
104	1039432.88	6583.59		0.63	1083902.48	5775.72		0.53	1.04
112	1113609.04	4380.62		0.39	1072010.36	8983.14		0.84	0.96
120	1109420.96	7183.5		0.65	1079424.12	10929.97	1.01	0.97
128	1095400.04	4274.6		0.39	1095475.2	12042.02	1.1	1
136	1071605.4	11103.73	1.04	1114757.2	10516.55	0.94	1.04
144	1104147.2	9714.75		0.88	1044954.16	7544.2		0.72	0.95
152	1164280.24	13386.15	1.15	1101213.92	11568.49	1.05	0.95
160	1084892.04	7941.25		0.73	1152273.76	9593.38		0.83	1.06
168	983654.76	11772.85	1.2	1111772.28	9806.83		0.88	1.13
176	1087544.24	11262.35	1.04	1077507.76	9442.02		0.88	0.99
184	1101682.4	24701.68	2.24	1095223.2	16707.29	1.53	0.99
192	983712.08	13453.59	1.37	1051244.2	15662.05	1.49	1.07

will-it-scale lock1_threads - x86_64

Threads QL      	QL stddev       stddev% RQL     	RQL stddev      stddev% Speedup
-----------------------------------------------------------------------------------------------
1	4307484.96	3959.31		0.09	4252908.56	10375.78	0.24	0.99
2	7701844.32	4169.88		0.05	7219233.52	6437.11		0.09	0.94
4	14781878.72	22854.85	0.15	15260565.12	37305.71	0.24	1.03
8	12949698.64	99270.42	0.77	9954660.4	142805.68	1.43	0.77
16	12947690.64	72977.27	0.56	10865245.12	49520.31	0.46	0.84
24	11142990.64	33200.39	0.3	11444391.68	37884.46	0.33	1.03
32	9652335.84	22369.48	0.23	9344086.72	21639.22	0.23	0.97
40	9185931.12	5508.96		0.06	8881506.32	5072.33		0.06	0.97
48	9084385.36	10871.05	0.12	8863579.12	4583.37		0.05	0.98
56	6595540.96	33100.59	0.5	6640389.76	46619.96	0.7	1.01
64	5946726.24	47160.5		0.79	6572155.84	91973.73	1.4	1.11
72	6744894.72	43166.65	0.64	5991363.36	80637.56	1.35	0.89
80	6234502.16	118983.16	1.91	5157894.32	73592.72	1.43	0.83
88	5053879.6	199713.75	3.95	4479758.08	36202.27	0.81	0.89
96	5184302.64	99199.89	1.91	5249210.16	122348.69	2.33	1.01
104	4612391.92	40803.05	0.88	4850209.6	26813.28	0.55	1.05
112	4809209.68	24070.68	0.5	4869477.84	27489.04	0.56	1.01
120	5130746.4	34265.5		0.67	4620047.12	44229.54	0.96	0.9
128	5376465.28	95028.05	1.77	4781179.6	43700.93	0.91	0.89
136	5453742.4	86718.87	1.59	5412457.12	40339.68	0.75	0.99
144	5805040.72	84669.31	1.46	5595382.48	68701.65	1.23	0.96
152	5842897.36	31120.33	0.53	5787587.12	43521.68	0.75	0.99
160	5837665.12	14179.44	0.24	5118808.72	45193.23	0.88	0.88
168	5660332.72	27467.09	0.49	5104959.04	40891.75	0.8	0.9
176	5180312.24	28656.39	0.55	4718407.6	58734.13	1.24	0.91
184	4706824.16	50469.31	1.07	4692962.64	92266.85	1.97	1
192	5126054.56	51082.02	1	4680866.8	58743.51	1.25	0.91

will-it-scale lock2_threads - x86_64

Threads QL      	QL stddev       stddev% RQL     	RQL stddev      stddev% Speedup
-----------------------------------------------------------------------------------------------
1	4316091.2	4933.28		0.11	4293104		30369.71	0.71	0.99
2	3500046.4	19852.62	0.57	4507627.76	23667.66	0.53	1.29
4	3639098.96	26370.65	0.72	3673166.32	30822.71	0.84	1.01
8	3714548.56	49953.44	1.34	4055818.56	71630.41	1.77	1.09
16	4188724.64	105414.49	2.52	4316077.12	68956.15	1.6	1.03
24	3737908.32	47391.46	1.27	3762254.56	55345.7		1.47	1.01
32	3820952.8	45207.66	1.18	3710368.96	52651.92	1.42	0.97
40	3791280.8	28630.55	0.76	3661933.52	37671.27	1.03	0.97
48	3765721.84	59553.83	1.58	3604738.64	50861.36	1.41	0.96
56	3175505.76	64336.17	2.03	2771022.48	66586.99	2.4	0.87
64	2620294.48	71651.34	2.73	2650171.68	44810.83	1.69	1.01
72	2861893.6	86542.61	3.02	2537437.2	84571.75	3.33	0.89
80	2976297.2	83566.43	2.81	2645132.8	85992.34	3.25	0.89
88	2547724.8	102014.36	4	2336852.16	80570.25	3.45	0.92
96	2945310.32	82673.25	2.81	2513316.96	45741.81	1.82	0.85
104	3028818.64	90643.36	2.99	2581787.52	52967.48	2.05	0.85
112	2546264.16	102605.82	4.03	2118812.64	62043.19	2.93	0.83
120	2917334.64	112220.01	3.85	2720418.64	64035.96	2.35	0.93
128	2906621.84	69428.1		2.39	2795310.32	56736.87	2.03	0.96
136	2841833.76	105541.11	3.71	3063404.48	62288.94	2.03	1.08
144	3032822.32	134796.56	4.44	3169985.6	149707.83	4.72	1.05
152	2557694.96	62218.15	2.43	2469887.6	68343.78	2.77	0.97
160	2810214.72	61468.79	2.19	2323768.48	54226.71	2.33	0.83
168	2651146.48	76573.27	2.89	2385936.64	52433.98	2.2	0.9
176	2720616.32	89026.19	3.27	2941400.08	59296.64	2.02	1.08
184	2696086		88541.24	3.28	2598225.2	76365.7		2.94	0.96
192	2908194.48	87023.91	2.99	2377677.68	53299.82	2.24	0.82

locktorture - arm64

Threads QL		RQL		Speedup
-----------------------------------------------
1	43320464	44718174	1.03
2	21056971	29255448	1.39
4	16040120	11563981	0.72
8	12786398	12838909	1
16	13646408	13436730	0.98
24	13597928	13669457	1.01
32	16456220	14600324	0.89
40	16667726	13883101	0.83
48	14347691	14608641	1.02
56	15624580	15180758	0.97
64	18105114	16009137	0.88
72	16606438	14772256	0.89
80	16550202	14124056	0.85
88	16716082	15930618	0.95
96	16489242	16817657	1.02
104	17915808	17165324	0.96
112	17217482	21343282	1.24
120	20449845	20576123	1.01
128	18700902	20286275	1.08
136	17913378	21142921	1.18
144	18225673	18971921	1.04
152	18374206	19229854	1.05
160	23136514	20129504	0.87
168	21096269	17167777	0.81
176	21376794	21594914	1.01
184	23542989	20638298	0.88
192	22793754	20655980	0.91
200	20933027	19628316	0.94
208	23105684	25572720	1.11
216	24158081	23173848	0.96
224	23388984	22485353	0.96
232	21916401	23899343	1.09
240	22292129	22831784	1.02
248	25812762	22636787	0.88
256	24294738	26127113	1.08

will-it-scale open1_threads - arm64

Threads QL      	QL stddev       stddev% RQL     	RQL stddev      stddev% Speedup
-----------------------------------------------------------------------------------------------
1	844452.32	801		0.09	804936.92	900.25		0.11	0.95
2	1309419.08	9495.78		0.73	1265080.24	3171.13		0.25	0.97
4	2113074.24	5363.19		0.25	2041158.28	7883.65		0.39	0.97
8	1916650.96	15749.86	0.82	2039850.04	7562.87		0.37	1.06
16	1835540.72	12940.45	0.7	1937398.56	11461.15	0.59	1.06
24	1876760.48	12581.67	0.67	1966659.16	10012.69	0.51	1.05
32	1834525.6	5571.08		0.3	1929180.4	6221.96		0.32	1.05
40	1851592.76	7848.18		0.42	1937504.44	5991.55		0.31	1.05
48	1845067		4118.68		0.22	1773331.56	6068.23		0.34	0.96
56	1742709.36	6874.03		0.39	1716184.92	6713.16		0.39	0.98
64	1685339.72	6688.91		0.4	1676046.16	5844.06		0.35	0.99
72	1694838.84	2433.41		0.14	1821189.6	2906.89		0.16	1.07
80	1738778.68	2916.74		0.17	1729212.6	3714.41		0.21	0.99
88	1753131.76	2734.34		0.16	1713294.32	4652.82		0.27	0.98
96	1694112.52	4449.69		0.26	1714438.36	5621.66		0.33	1.01
104	1780279.76	2420.52		0.14	1767679.12	3067.66		0.17	0.99
112	1700284.72	9796.23		0.58	1796674.6	4066.06		0.23	1.06
120	1760466.72	3978.65		0.23	1704706.08	4080.04		0.24	0.97
128	1634067.96	5187.94		0.32	1764115.48	3545.02		0.2	1.08
136	1170303.84	7602.29		0.65	1227188.04	8090.84		0.66	1.05
144	953186.16	7859.02		0.82	964822.08	10536.61	1.09	1.01
152	818893.96	7238.86		0.88	853412.44	5932.25		0.7	1.04
160	707460.48	3868.26		0.55	746985.68	10363.03	1.39	1.06
168	658380.56	4938.77		0.75	672101.12	5442.95		0.81	1.02
176	614692.04	3137.74		0.51	615143.36	6197.19		1.01	1
184	574808.88	4741.61		0.82	592395.08	8840.92		1.49	1.03
192	548142.92	6116.31		1.12	571299.68	8388.56		1.47	1.04
200	511621.96	2182.33		0.43	532144.88	5467.04		1.03	1.04
208	506583.32	6834.39		1.35	521427.08	10318.65	1.98	1.03
216	480438.04	3608.96		0.75	510697.76	8086.47		1.58	1.06
224	470644.96	3451.35		0.73	467433.92	5008.59		1.07	0.99
232	466973.72	6599.97		1.41	444345.92	2144.96		0.48	0.95
240	442927.68	2351.56		0.53	440503.56	4289.01		0.97	0.99
248	432991.16	5829.92		1.35	445462.6	5944.03		1.33	1.03
256	409455.44	1430.5		0.35	422219.4	4007.04		0.95	1.03

will-it-scale open2_threads - arm64

Threads QL      	QL stddev       stddev% RQL     	RQL stddev      stddev% Speedup
-----------------------------------------------------------------------------------------------
1	818645.4	1097.02		0.13	774110.24	1562.45		0.2	0.95
2	1281013.04	2188.78		0.17	1238346.24	2149.97		0.17	0.97
4	2058514.16	13105.36	0.64	1985375		3204.48		0.16	0.96
8	1920414.8	16154.63	0.84	1911667.92	8882.98		0.46	1
16	1943729.68	8714.38		0.45	1978946.72	7465.65		0.38	1.02
24	1915846.88	7749.9		0.4	1914442.72	9841.71		0.51	1
32	1964695.92	8854.83		0.45	1914650.28	9357.82		0.49	0.97
40	1845071.12	5103.26		0.28	1891685.44	4278.34		0.23	1.03
48	1838897.6	5123.61		0.28	1843498.2	5391.94		0.29	1
56	1823768.32	3214.14		0.18	1736477.48	5675.49		0.33	0.95
64	1627162.36	3528.1		0.22	1685727.16	6102.63		0.36	1.04
72	1725320.16	4709.83		0.27	1710174.4	6707.54		0.39	0.99
80	1692288.44	9110.89		0.54	1773676.24	4327.94		0.24	1.05
88	1725496.64	4249.71		0.25	1695173.84	5097.14		0.3	0.98
96	1766093.08	2280.09		0.13	1732782.64	3606.1		0.21	0.98
104	1647753		2926.83		0.18	1710876.4	4416.04		0.26	1.04
112	1763785.52	3838.26		0.22	1803813.76	1859.2		0.1	1.02
120	1684095.16	2385.31		0.14	1766903.08	3258.34		0.18	1.05
128	1733528.56	2800.62		0.16	1677446.32	3201.14		0.19	0.97
136	1179187.84	6804.86		0.58	1241839.52	10698.51	0.86	1.05
144	969456.36	6421.85		0.66	1018441.96	8732.19		0.86	1.05
152	839295.64	10422.66	1.24	817531.92	6778.37		0.83	0.97
160	743010.72	6957.98		0.94	749291.16	9388.47		1.25	1.01
168	666049.88	13159.73	1.98	689408.08	10192.66	1.48	1.04
176	609185.56	5685.18		0.93	653744.24	10847.35	1.66	1.07
184	602232.08	12089.72	2.01	597718.6	13856.45	2.32	0.99
192	563919.32	9870.46		1.75	560080.4	8388.47		1.5	0.99
200	522396.28	4155.61		0.8	539168.64	10456.64	1.94	1.03
208	520328.28	9353.14		1.8	510011.4	6061.19		1.19	0.98
216	479797.72	5824.58		1.21	486955.32	4547.05		0.93	1.01
224	467943.8	4484.86		0.96	473252.76	5608.58		1.19	1.01
232	456914.24	3129.5		0.68	457463.2	7474.83		1.63	1
240	450535		5149.78		1.14	437653.56	4604.92		1.05	0.97
248	435475.2	2350.87		0.54	435589.24	6176.01		1.42	1
256	416737.88	2592.76		0.62	424178.28	3932.2		0.93	1.02

will-it-scale lock1_threads - arm64

Threads QL      	QL stddev       stddev% RQL     	RQL stddev      stddev% Speedup
-----------------------------------------------------------------------------------------------
1	2512077.52	3026.1		0.12	2085365.92	1612.44		0.08	0.83
2	4840180.4	3646.31		0.08	4326922.24	3802.17		0.09	0.89
4	9358779.44	6673.07		0.07	8467588.56	5577.05		0.07	0.9
8	9374436.88	18826.26	0.2	8635110.16	4217.66		0.05	0.92
16	9527184.08	14111.94	0.15	8561174.16	3258.6		0.04	0.9
24	8873099.76	17242.32	0.19	9286778.72	4124.51		0.04	1.05
32	8457640.4	10790.92	0.13	8700401.52	5110		0.06	1.03
40	8478771.76	13250.8		0.16	8746198.16	7606.42		0.09	1.03
48	8329097.76	7958.92		0.1	8774265.36	6082.08		0.07	1.05
56	8330143.04	11586.93	0.14	8472426.48	7402.13		0.09	1.02
64	8334684.08	10478.03	0.13	7979193.52	8436.63		0.11	0.96
72	7941815.52	16031.38	0.2	8016885.52	12640.56	0.16	1.01
80	8042221.68	10219.93	0.13	8072222.88	12479.54	0.15	1
88	8190336.8	10751.38	0.13	8432977.6	11865.67	0.14	1.03
96	8235010.08	7267.8		0.09	8022101.28	11910.63	0.15	0.97
104	8154434.08	7770.8		0.1	7987812		7647.42		0.1	0.98
112	7738464.56	11067.72	0.14	7968483.92	20632.93	0.26	1.03
120	8228919.36	10395.79	0.13	8304329.28	11913.76	0.14	1.01
128	7798646.64	8877.8		0.11	8197938.4	7527.81		0.09	1.05
136	5567293.68	66259.82	1.19	5642017.12	126584.59	2.24	1.01
144	4425655.52	55729.96	1.26	4519874.64	82996.01	1.84	1.02
152	3871300.8	77793.78	2.01	3850025.04	80167.3		2.08	0.99
160	3558041.68	55108.3		1.55	3495924.96	83626.42	2.39	0.98
168	3302042.72	45011.89	1.36	3298002.8	59393.64	1.8	1
176	3066165.2	34896.54	1.14	3063027.44	58219.26	1.9	1
184	2817899.6	43585.27	1.55	2859393.84	45258.03	1.58	1.01
192	2690403.76	42236.77	1.57	2630652.24	35953.13	1.37	0.98
200	2563141.44	28145.43	1.1	2539964.32	38556.52	1.52	0.99
208	2502968.8	27687.81	1.11	2477757.28	28240.81	1.14	0.99
216	2474917.76	24128.71	0.97	2483161.44	32198.37	1.3	1
224	2386874.72	32954.66	1.38	2398068.48	37667.29	1.57	1
232	2379248.24	27413.4		1.15	2327601.68	24565.28	1.06	0.98
240	2302146.64	19914.19	0.87	2236074.64	20968.17	0.94	0.97
248	2241798.32	21542.52	0.96	2173312.24	26498.36	1.22	0.97
256	2198765.12	20832.66	0.95	2136159.52	25027.96	1.17	0.97

will-it-scale lock2_threads - arm64

Threads QL      	QL stddev       stddev% RQL     	RQL stddev      stddev% Speedup
-----------------------------------------------------------------------------------------------
1	2499414.32	1932.27		0.08	2075704.8	24589.71	1.18	0.83
2	3887820		34198.36	0.88	4057432.64	11896.04	0.29	1.04
4	3445307.6	7958.3		0.23	3869960.4	3788.5		0.1	1.12
8	4310597.2	14405.9		0.33	3931319.76	5845.33		0.15	0.91
16	3995159.84	22621.85	0.57	3953339.68	15668.9		0.4	0.99
24	4048456.88	22956.51	0.57	3887812.64	30584.77	0.79	0.96
32	3974808.64	20465.87	0.51	3718778.08	27407.24	0.74	0.94
40	3941154.88	15136.68	0.38	3551464.24	33378.67	0.94	0.9
48	3725436.32	17090.67	0.46	3714356.08	19035.26	0.51	1
56	3558449.44	10123.46	0.28	3449656.08	36476.87	1.06	0.97
64	3514616.08	16470.99	0.47	3493197.04	25639.82	0.73	0.99
72	3461700.88	16780.97	0.48	3376565.04	16930.19	0.5	0.98
80	3797008.64	17599.05	0.46	3505856.16	34320.34	0.98	0.92
88	3737459.44	10774.93	0.29	3631757.68	24231.29	0.67	0.97
96	3612816.16	21865.86	0.61	3545354.56	16391.15	0.46	0.98
104	3765167.36	17763.8		0.47	3466467.12	22235.45	0.64	0.92
112	3713386		15455.21	0.42	3402210		18349.66	0.54	0.92
120	3699986.08	15153.08	0.41	3580303.92	19823.01	0.55	0.97
128	3648694.56	11891.62	0.33	3426445.28	22993.32	0.67	0.94
136	800046.88	6039.73		0.75	784412.16	9062.03		1.16	0.98
144	769483.36	5231.74		0.68	714132.8	8953.57		1.25	0.93
152	821081.52	4249.12		0.52	743694.64	8155.18		1.1	0.91
160	789040.16	9187.4		1.16	834865.44	6159.29		0.74	1.06
168	867742.4	8967.66		1.03	734905.36	15582.75	2.12	0.85
176	838650.32	7949.72		0.95	846939.68	8959.8		1.06	1.01
184	854984.48	19475.51	2.28	794549.92	11924.54	1.5	0.93
192	846262.32	13795.86	1.63	899915.12	8639.82		0.96	1.06
200	942602.16	12665.42	1.34	900385.76	8592.23		0.95	0.96
208	954183.68	12853.22	1.35	1166186.96	13045.03	1.12	1.22
216	929319.76	10157.79	1.09	926773.76	10577.01	1.14	1
224	967896.56	9819.6		1.01	951144.32	12343.83	1.3	0.98
232	990621.12	7771.97		0.78	916361.2	17878.44	1.95	0.93
240	995285.04	20104.22	2.02	972119.6	12856.42	1.32	0.98
248	1029436		20404.97	1.98	965301.28	11102.95	1.15	0.94
256	1038724.8	19201.03	1.85	1029942.08	12563.07	1.22	0.99

Written By
----------
Alexei Starovoitov <ast@kernel.org>
Kumar Kartikeya Dwivedi <memxor@gmail.com>

  [0]: https://www.cs.rochester.edu/research/synchronization/pseudocode/timeout.html
  [1]: https://dl.acm.org/doi/10.1145/571825.571830
  [2]: https://github.com/kkdwivedi/rqspinlock/blob/main/rqspinlock.pdf
  [3]: https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/plain/qspinlock.tla
  [4]: https://arxiv.org/pdf/1810.05600

Kumar Kartikeya Dwivedi (26):
  locking: Move MCS struct definition to public header
  locking: Move common qspinlock helpers to a private header
  locking: Allow obtaining result of arch_mcs_spin_lock_contended
  locking: Copy out qspinlock.c to rqspinlock.c
  rqspinlock: Add rqspinlock.h header
  rqspinlock: Drop PV and virtualization support
  rqspinlock: Add support for timeouts
  rqspinlock: Protect pending bit owners from stalls
  rqspinlock: Protect waiters in queue from stalls
  rqspinlock: Protect waiters in trylock fallback from stalls
  rqspinlock: Add deadlock detection and recovery
  rqspinlock: Add a test-and-set fallback
  rqspinlock: Add basic support for CONFIG_PARAVIRT
  rqspinlock: Add helper to print a splat on timeout or deadlock
  rqspinlock: Add macros for rqspinlock usage
  rqspinlock: Add locktorture support
  rqspinlock: Hardcode cond_acquire loops to asm-generic implementation
  rqspinlock: Add entry to Makefile, MAINTAINERS
  bpf: Convert hashtab.c to rqspinlock
  bpf: Convert percpu_freelist.c to rqspinlock
  bpf: Convert lpm_trie.c to rqspinlock
  bpf: Introduce rqspinlock kfuncs
  bpf: Handle allocation failure in acquire_lock_state
  bpf: Implement verifier support for rqspinlock
  bpf: Maintain FIFO property for rqspinlock unlock
  selftests/bpf: Add tests for rqspinlock

 MAINTAINERS                                   |   3 +
 arch/x86/include/asm/rqspinlock.h             |  29 +
 include/asm-generic/Kbuild                    |   1 +
 include/asm-generic/mcs_spinlock.h            |   6 +
 include/asm-generic/rqspinlock.h              | 215 +++++
 include/linux/bpf.h                           |  10 +
 include/linux/bpf_verifier.h                  |  20 +-
 kernel/bpf/btf.c                              |  26 +-
 kernel/bpf/hashtab.c                          | 102 +--
 kernel/bpf/lpm_trie.c                         |  25 +-
 kernel/bpf/percpu_freelist.c                  | 113 +--
 kernel/bpf/percpu_freelist.h                  |   4 +-
 kernel/bpf/syscall.c                          |   6 +-
 kernel/bpf/verifier.c                         | 250 +++++-
 kernel/locking/Makefile                       |   1 +
 kernel/locking/lock_events_list.h             |   5 +
 kernel/locking/locktorture.c                  |  51 ++
 kernel/locking/mcs_spinlock.h                 |  10 +-
 kernel/locking/qspinlock.c                    | 193 +----
 kernel/locking/qspinlock.h                    | 200 +++++
 kernel/locking/rqspinlock.c                   | 766 ++++++++++++++++++
 kernel/locking/rqspinlock.h                   |  48 ++
 .../selftests/bpf/prog_tests/res_spin_lock.c  |  99 +++
 tools/testing/selftests/bpf/progs/irq.c       |  53 ++
 .../selftests/bpf/progs/res_spin_lock.c       | 143 ++++
 .../selftests/bpf/progs/res_spin_lock_fail.c  | 244 ++++++
 26 files changed, 2207 insertions(+), 416 deletions(-)
 create mode 100644 arch/x86/include/asm/rqspinlock.h
 create mode 100644 include/asm-generic/rqspinlock.h
 create mode 100644 kernel/locking/qspinlock.h
 create mode 100644 kernel/locking/rqspinlock.c
 create mode 100644 kernel/locking/rqspinlock.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/res_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/res_spin_lock_fail.c


base-commit: 0abff462d802a352c87b7f5e71b442b09bf9cfff
-- 
2.43.5


