Return-Path: <bpf+bounces-48098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21814A04162
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6171886FB2
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745A71F237A;
	Tue,  7 Jan 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MP9rpWPA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E291F191D;
	Tue,  7 Jan 2025 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258417; cv=none; b=HZd/BxqSxn5Njf4VLzvvgLoywEopv9G2bDSj0ABGd48JDoit4Szr4HPYGUciU96Qnot34Vh0qS71RDG3Q6ghm+c+3+lL/NWNlf0H51GKU9giLrnr3qkEFxLLtOr/yGYBNugsQbmlgvXjWauz0d5rSnZTGR8+t786VneYypBnM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258417; c=relaxed/simple;
	bh=ANje8pOpPWAfW/KDg7AXPxpPhh11u9iOYaZjU1MK1so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g7YNPMtu6Dy9x0Lxmj+93ufu6mMuNDDQz8EVERRCnEV1CbfnYaa7dskGouLN0FVU7YaLzOfxmLpIxx1A4nE2wfnc0xbpv8yBHrjUo8G2PeKX0NfbVO6z0GagWhoXTnZvRozD8B6Lfk+O5KPITeFdwqG/I7wPyMs/r4pijDhD7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MP9rpWPA; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-38632b8ae71so10909812f8f.0;
        Tue, 07 Jan 2025 06:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258411; x=1736863211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=werinG6Qz0Qv1eFuNUvcic0ePl2+7eJkF7v+OvjEyy0=;
        b=MP9rpWPAu6CspJ3WqpGCtTiy1Xl9hrGXOAly7gK4OJDSTKmKUsQy00rR0tC0yFBLNP
         wPcX8dNKBvMwFQBZ955dqPOx84sTZ2Yr1inV6q7SeiwEv84DR5smAXCMTw8n5SAWBNOF
         CT0J/2551pGuV5HXxiwpF43dpT9Q+jdbhQEd4SHJm1bvyCjE8rQQdc+kDXlFaxsTn7ab
         VvDHKZvGP/KAbQ9wQY1mcDaZwJtv6wJSSEumsHxKfzhsmLkeNrVYfvFLYUZw2p8TOVSf
         ne8F8B/SRe3La8MEYK6DAgN9UB/mHWPA7UNajyw3U0//LGQn55ddb7vTC/X971Y3H+nX
         w2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258411; x=1736863211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=werinG6Qz0Qv1eFuNUvcic0ePl2+7eJkF7v+OvjEyy0=;
        b=WE73JpVk3bTpaDm8Lr/YBJ22Ij3SdOOjO2kztzYRFa+eDvIFy+n8oWPmwGmmDa/0o4
         ogIJbRjEPDxdFEPGoDFaPuJdgNMxJp+vdOAACgCn/hIXYheWiSn/s/e0GflD9Y37hLYt
         N4CyJ3tocCgPDyvh7STlL7cZEbU1hkqgbb40brb6AvzK/hkU7LYv2fAbBmoe8T7KkIm4
         22/90cHU0EcTrSZ1E4v/lklic9+u40CTChGy1fzVoriOU2SsaJvVP3jqoNm10B56iuUA
         2uidII72tcEz9R8cuvaKB/+tso1urWJYJrwOzbblupMh54sXYMQZChL0eEKzAM0eW2S8
         VFTw==
X-Forwarded-Encrypted: i=1; AJvYcCXy8APgs4dnoG1SJjeGaSXSMYcZgzSYZLJZSxfaqXVWMEnOcUGceYefHk/oMbGT0QUB9jsTawnhyTw7gMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ZeUs/lSNib3xV260+KbR+upkTJsPWh1cMoZ9PLXpz02Lqqjk
	ms5fSu5yVs4PN0Qu13weqwUcBtCFDS9k2lAu5nsO85tCG6EWzNsCSpKuzP33rATE1A==
X-Gm-Gg: ASbGnctClyqhIdtuSJCi97u4zaAPpdCERPHD9oLSrhPdOcSJWneVBpUsLE5IWmS4day
	il0NzxFlmksCyLhtDJZwXT6bNSSbgToOeO8OIlQOw0hPAr1xFw7qJxvz4o9urs6ZGYtxPMZtzS9
	T+BI1onsA/E07knU8/H5Y4B7Y6RrMriDzYhtA8Op/2zvPOpznO1ZTyMMcMialbsEOigD5M4vniD
	4lLXjYT29nVcH3P4HMuPe8v/PT75ymsI2GiIfOetcTTlDs=
X-Google-Smtp-Source: AGHT+IG45YJSrR4yV0O/MRaD6NpFTaUtjWX/wBV2KKmdMxjo1B65t3nIGzwtEMKOxEc/bYmqp4Cunw==
X-Received: by 2002:a5d:47c5:0:b0:38a:4184:1216 with SMTP id ffacd0b85a97d-38a4b9a98d4mr29187953f8f.46.1736258410791;
        Tue, 07 Jan 2025 06:00:10 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:1b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e261sm51264060f8f.76.2025.01.07.06.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:10 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 00/22] Resilient Queued Spin Lock
Date: Tue,  7 Jan 2025 05:59:42 -0800
Message-ID: <20250107140004.2732830-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=24731; h=from:subject; bh=ANje8pOpPWAfW/KDg7AXPxpPhh11u9iOYaZjU1MK1so=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCb4uWhnCbP2E1Z7gEZNWp5wQ3oef2hY60JlUFR i2uei9yJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wmwAKCRBM4MiGSL8RyqQSEA DCCZ6U7CzoYjMjr1IEFEpG70T794yu/KwP82z4RXwoulU/yjYiM/JrCewwRKOaAC3MZaldbnS35HQs 0e+VD8YFPStTTCveMA5QwsG6O32Qva7PohTmFMconjg5fGCsz0v1scELbNXCPglSZIq785ZFv+QYFj 1cTQB/2qclCLaAs/1tnuuaLWcRMpYHxVy6rJ1GyeeRhsRYNmNjPqtLIL7nDX36M4sye5RKo7xzeSfk 7WBwem51cUWRAahNN1xgkavwflfnyklHMDex2ZORPwVHqx4s8+47gpcED4L1gJUI83A3Kfp3tLzyCs t7XPIk7yPy88uQqmK5IDVI33eQg0FA8j+DG5QuM19rpvhBDlSD2ROnjkdJ9tAEY2eJtZxrGf/DeiaH mWAhr4ozKyf7lrAWlDxrmtlSi2LyDinRLQeCPRuMdP8RRkU35j+u7CCY05b1b3bniR2egnlpZx0Cv9 XTky2qnU2l+bEAqITJvo447tYqM17m0uQZ2BIqlzcT0dqD+7bMoADVYpnvCtGMktn9NfM9w2gIWeB3 0X79NQPj7gpzq7Kl8KtOmAJIMvAUIsxOwz6xGwAKSh2YlM5LYHT2bKDNO2fwocTK0CC67A+XqiLxFr XjXeV/rI09L5PeC/IwxsNmi8znCK6J1nAj911tK6tvvnRQOGOpnHogS2vxHg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

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

We have a WIP TLA+ proof for liveness and mutual exlcusion of rqspinlock
built on top of the qspinlock TLA+ proof from Catalin Marinas [3]. We
will share more details and the links in the near future.

Motivation
—---------

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
—-----

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
—-----------

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
—---------

We run benchmarks that stress locking scalability and perform comparison
against the baseline (qspinlock). For the rqspinlock case, we replace
the default qspinlock with it in the kernel, such that all spin locks in
the kernel use the rqspinlock slow path. As such, benchmarks that stress
kernel spin locks end up exercising rqspinlock.

Evaluation setup
~~~~~~~~~~~~~~~~

Dual-socket Intel Xeon Platinum 8468 (Sapphire Rapids) machine.
48 cores per socket, 2 threads per core.
Hyperthreading enabled, CPU governor set to performance. NUMA boundary
crossed after 48 cores.  SMT siblings from 96-191 threads (first 48
assigned paired with NUMA node 0 cores, etc.).

The locktorture experiment is run for 30 seconds.
Average of 25 runs is used for will-it-scale.

Legend:
 QL - qspinlock (avg. throughput)
 RQL - rqspinlock (avg. throughput)

Results
~~~~~~~

locktorture

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

will-it-scale open1_threads

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

will-it-scale open2_threads

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

will-it-scale lock1_threads

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

will-it-scale lock2_threads

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

Written By
—---------
Alexei Starovoitov <ast@kernel.org>
Kumar Kartikeya Dwivedi <memxor@gmail.com>

  [0]: https://www.cs.rochester.edu/research/synchronization/pseudocode/timeout.html
  [1]: https://dl.acm.org/doi/10.1145/571825.571830
  [2]: https://github.com/kkdwivedi/rqspinlock/blob/main/rqspinlock.pdf
  [3]: https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/plain/qspinlock.tla

Kumar Kartikeya Dwivedi (22):
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
  rqspinlock: Add basic support for CONFIG_PARAVIRT
  rqspinlock: Add helper to print a splat on timeout or deadlock
  rqspinlock: Add macros for rqspinlock usage
  rqspinlock: Add locktorture support
  rqspinlock: Add entry to Makefile, MAINTAINERS
  bpf: Convert hashtab.c to rqspinlock
  bpf: Convert percpu_freelist.c to rqspinlock
  bpf: Convert lpm_trie.c to rqspinlock
  bpf: Introduce rqspinlock kfuncs
  bpf: Implement verifier support for rqspinlock
  selftests/bpf: Add tests for rqspinlock

 MAINTAINERS                                   |   3 +
 arch/x86/include/asm/rqspinlock.h             |  20 +
 include/asm-generic/Kbuild                    |   1 +
 include/asm-generic/mcs_spinlock.h            |   6 +
 include/asm-generic/rqspinlock.h              | 147 ++++
 include/linux/bpf.h                           |  10 +
 include/linux/bpf_verifier.h                  |  17 +-
 kernel/bpf/btf.c                              |  26 +-
 kernel/bpf/hashtab.c                          | 102 +--
 kernel/bpf/lpm_trie.c                         |  25 +-
 kernel/bpf/percpu_freelist.c                  | 113 +--
 kernel/bpf/percpu_freelist.h                  |   4 +-
 kernel/bpf/syscall.c                          |   6 +-
 kernel/bpf/verifier.c                         | 233 ++++--
 kernel/locking/Makefile                       |   3 +
 kernel/locking/lock_events_list.h             |   5 +
 kernel/locking/locktorture.c                  |  51 ++
 kernel/locking/mcs_spinlock.h                 |  10 +-
 kernel/locking/qspinlock.c                    | 193 +----
 kernel/locking/qspinlock.h                    | 200 +++++
 kernel/locking/rqspinlock.c                   | 724 ++++++++++++++++++
 kernel/locking/rqspinlock.h                   |  48 ++
 .../selftests/bpf/prog_tests/res_spin_lock.c  | 103 +++
 tools/testing/selftests/bpf/progs/irq.c       |  53 ++
 .../selftests/bpf/progs/res_spin_lock.c       | 189 +++++
 .../selftests/bpf/progs/res_spin_lock_fail.c  | 226 ++++++
 26 files changed, 2097 insertions(+), 421 deletions(-)
 create mode 100644 arch/x86/include/asm/rqspinlock.h
 create mode 100644 include/asm-generic/rqspinlock.h
 create mode 100644 kernel/locking/qspinlock.h
 create mode 100644 kernel/locking/rqspinlock.c
 create mode 100644 kernel/locking/rqspinlock.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/res_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/res_spin_lock_fail.c


base-commit: f44275e7155dc310d36516fc25be503da099781c
-- 
2.43.5


