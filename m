Return-Path: <bpf+bounces-60694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0080BADA444
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 00:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3DE7188F531
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 22:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8484227F178;
	Sun, 15 Jun 2025 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="evXym/i0"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F73E19CCF5;
	Sun, 15 Jun 2025 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750025583; cv=none; b=cTX8joskWUGlWvm8iJC9twYGA5os15FbC3/98DpKwCg/FaH/hXs65KLpMTNDe2N4SinlpeHWc8TqoVSf/UjP3PshUZJw1zOEQDoX++rRMm0NcPOO9h7WOfdpEf3tbVcGTf5GiZ/AiIdsz+kGWF+q23HA+vzewM2LJGtu5BeT+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750025583; c=relaxed/simple;
	bh=i1g6wUmxC3PDWrx2qi+M3zuLAh31v68WNtk1rKaQKXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SWi6UoZO+aLeUwUeNcpKVgOcpxZgVacciLq1odvYC+3UdMGZi04CTBNdowQ8o9KuepX4tYIWNMtq0m5+hRplCCi8f23DZTqgCdQTxQ2E7YeD1xjqQtevM6i+b7/kWqGyOtll8pcRf7gB2PUav/chAryvp1rEabaRmTpBYPKf7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=evXym/i0; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750025572; x=1750630372; i=spasswolf@web.de;
	bh=/l4zW9H4dy2zaI1cidoxg5ZSUS/FwhYZtNo6B+GkSrA=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=evXym/i0n+5K5WbL7IRIo6lq3Sn59T8ea5ccJRGxlNUK14bfN20KQk36Mzp+FfL+
	 bH6sEdTlfQBjamGMjaZ0ZIpKYCHeX8ftir+OISghc31uTHUP6s+uFIlDzYMvnrMvo
	 o1A7loD8afWxsbHNvGm0DNQcEId/+HsNWM1wva7ZRHK+kjt09Jfp/kMklqsrjK0p0
	 q8nKX/By6kp8Mclq/jg4UA9zRWAENwMcJ2oYo78eyAhicILEDEhXAoBz94rd1bF1X
	 QMVMm2PhkCUMIt/knbA/D6lCKis1P30PO0p+8BQCCzDWoQFKDid46YrMenrzq8xpc
	 Of/A8s2T3jYJGTCaCw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4NDG-1upmGT3pby-00wcgz; Mon, 16
 Jun 2025 00:12:52 +0200
Message-ID: <7937d287a3ff24ce7c7e3eb2cd18788521975511.camel@web.de>
Subject: Re: BUG: scheduling while atomic with PREEMPT_RT=y and bpf selftests
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rt-users@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, spasswolf@web.de
Date: Mon, 16 Jun 2025 00:12:49 +0200
In-Reply-To: <aa28ef09763eeefd54d4c26fb01599fd5197b265.camel@web.de>
References: <20250605091904.5853-1-spasswolf@web.de>
							 <20250605084816.3e5d1af1@gandalf.local.home>
							 <20250605125133.RSTingmi@linutronix.de>
					 <0b1f48ba715a16c4d4874ae65bc01914de4d5a90.camel@web.de>
				 <727212f9d3c324787ddd9ede9e2d800a02b629b2.camel@web.de>
			 <0c0b2385452292d6b1df3066b7223b420066f0a1.camel@web.de>
		 <aa28ef09763eeefd54d4c26fb01599fd5197b265.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3324dkHWoth1rfciKkWbj+BeN/G9bQcrcA4D0biWv2LCpRierB8
 ZM5Xg38if1cV2JodWxlKogbgzXCwlm+HypXsg1cfWo+n94rmbzUZpRxQUO21K9J/nNW4FE/
 uYJAyrViL8ieHXBlS2S31yZREZppm8ucWTuvVH0i/odmK2zCu4O73s6IPKhGxqPew8pUqWR
 k6gbnvxqdwcPjk+A/xwdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U/PvzsvrdLQ=;RMnGCba7GzPaLCMBIXZIgrGSMgQ
 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

These three patches fixes all the dmesg warning (with CONFIG_LOCKDEP) issu=
es when running the
bpf test_progs and does not cause deadlocks without CONFIG_LOCKDEP.

The warning when running the cgroup examples=C2=A0

[ T2916] BUG: sleeping function called from invalid context at kernel/lock=
ing/spinlock_rt.c:48
[ T2916] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2916, name=
: test_progs
[ T2916] preempt_count: 1, expected: 0
[ T2916] RCU nest depth: 2, expected: 2
[...]
[ T2916]  __might_resched.cold+0xfa/0x135
[ T2916]  rt_spin_lock+0x5f/0x190
[ T2916]  ? task_get_cgroup1+0xe8/0x340
[ T2916]  task_get_cgroup1+0xe8/0x340
[ T2916]  bpf_task_get_cgroup1+0xe/0x20
[ T2916]  bpf_prog_8d22669ef1ee8049_on_enter+0x62/0x1d4
[ T2916]  bpf_trace_run2+0xd3/0x260

is fixed by this:

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 183fa2aa2935..49257cb90209 100644
=2D-- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -58,9 +58,9 @@ static notrace void \
 __bpf_trace_##call(void *__data, proto) \
 { \
 might_fault(); \
- preempt_disable_notrace(); \
+ migrate_disable(); \
 CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args)); =
\
- preempt_enable_notrace(); \
+ migrate_enable(); \
 }
=20
 #undef DECLARE_EVENT_SYSCALL_CLASS


The warning when running the (wq, timer, free_timer, timer_mim, timer_lock=
up) examples

[ T4696] BUG: sleeping function called from invalid context at kernel/lock=
ing/spinlock_rt.c:48
[ T4696] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 4696, name=
: test_progs
[ T4696] preempt_count: 1, expected: 0
[ T4696] RCU nest depth: 0, expected: 0
[...]
[ T4696]  __kmalloc_node_noprof+0xee/0x490
[ T4696]  bpf_map_kmalloc_node+0x72/0x220
[ T4696]  __bpf_async_init+0x107/0x310
[ T4696]  bpf_timer_init+0x33/0x40
[ T4696]  bpf_prog_7e15f1bc7d1d26d0_start_cb+0x5d/0x91
[ T4696]  bpf_prog_d85f43676fabf521_start_timer+0x65/0x8a
[ T4696]  bpf_prog_test_run_syscall+0x103/0x250

is fixed by this (this might leak
memory due to the allcoation before the lock(?))

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..94fcd8c8661c 100644
=2D-- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1263,19 +1263,16 @@ static int __bpf_async_init(struct bpf_async_kern =
*async, struct bpf_map *map, u
 return -EINVAL;
 }
=20
- __bpf_spin_lock_irqsave(&async->lock);
 t =3D async->timer;
- if (t) {
- ret =3D -EBUSY;
- goto out;
- }
+ if (t)
+ return -EBUSY;
=20
 /* allocate hrtimer via map_kmalloc to use memcg accounting */
 cb =3D bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
- if (!cb) {
- ret =3D -ENOMEM;
- goto out;
- }
+ if (!cb)
+ return -ENOMEM;
+
+ __bpf_spin_lock_irqsave(&async->lock);
=20
 switch (type) {
 case BPF_ASYNC_TYPE_TIMER:
@@ -1315,7 +1312,6 @@ static int __bpf_async_init(struct bpf_async_kern *a=
sync, struct bpf_map *map, u
 kfree(cb);
 ret =3D -EPERM;
 }
-out:
 __bpf_spin_unlock_irqrestore(&async->lock);
 return ret;
 }

In addition to these there's a deadlock warning from lockdep when running =
the
timer_lockup example

[  127.373597] [      C1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[  127.373598] [      C1] WARNING: possible recursive locking detected
[  127.373601] [      C1] 6.15.0-bpf-00006-g31cf22212ed9 #41 Tainted: G   =
        O     =20
[  127.373602] [      C1] --------------------------------------------
[  127.373603] [      C1] ktimers/1/85 is trying to acquire lock:
[  127.373605] [      C1] ffff98f62e61c1b8 (&base->softirq_expiry_lock){+.=
..}-{3:3}, at: hrtimer_cancel_wait_running+0x4d/0x80
[  127.373614] [      C1]
                          but task is already holding lock:
[  127.373615] [      C1] ffff98f62e65c1b8 (&base->softirq_expiry_lock){+.=
..}-{3:3}, at: hrtimer_run_softirq+0x37/0x100
[  127.373621] [      C1]
                          other info that might help us debug this:
[  127.373621] [      C1]  Possible unsafe locking scenario:

[  127.373622] [      C1]        CPU0
[  127.373623] [      C1]        ----
[  127.373624] [      C1]   lock(&base->softirq_expiry_lock);
[  127.373626] [      C1]   lock(&base->softirq_expiry_lock);
[  127.373627] [      C1]
                           *** DEADLOCK ***

[  127.373628] [      C1]  May be due to missing lock nesting notation

which can by fixed (?) by reintroducing spin_lock_bh_nested()
(which was introduced in v4.0 and removed in v4.11 ...)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index d3561c4a080e..b6635466b35f 100644
=2D-- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -219,6 +219,8 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *=
lock) __releases(lock)
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define raw_spin_lock_nested(lock, subclass) \
 _raw_spin_lock_nested(lock, subclass)
+# define raw_spin_lock_bh_nested(lock, subclass) \
+ _raw_spin_lock_bh_nested(lock, subclass)
=20
 # define raw_spin_lock_nest_lock(lock, nest_lock) \
 do { \
@@ -233,6 +235,8 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *=
lock) __releases(lock)
  */
 # define raw_spin_lock_nested(lock, subclass) \
 _raw_spin_lock(((void)(subclass), (lock)))
+# define raw_spin_lock_bh_nested(lock, subclass) \
+ _raw_spin_lock_bh(((void)(subclass), (lock)))
 # define raw_spin_lock_nest_lock(lock, nest_lock) _raw_spin_lock(lock)
 #endif
=20
@@ -366,6 +370,11 @@ do { \
 raw_spin_lock_nested(spinlock_check(lock), subclass); \
 } while (0)
=20
+#define spin_lock_bh_nested(lock, subclass) \
+do { \
+ raw_spin_lock_bh_nested(spinlock_check(lock), subclass); \
+} while (0)
+
 #define spin_lock_nest_lock(lock, nest_lock) \
 do { \
 raw_spin_lock_nest_lock(spinlock_check(lock), nest_lock); \
@@ -552,6 +561,10 @@ DEFINE_LOCK_GUARD_1(raw_spinlock_bh, raw_spinlock_t,
 raw_spin_lock_bh(_T->lock),
 raw_spin_unlock_bh(_T->lock))
=20
+DEFINE_LOCK_GUARD_1(raw_spinlock_bh_nested, raw_spinlock_t,
+ raw_spin_lock_bh_nested(_T->lock, SINGLE_DEPTH_NESTING),
+ raw_spin_unlock_bh(_T->lock))
+
 DEFINE_LOCK_GUARD_1_COND(raw_spinlock_bh, _try, raw_spin_trylock_bh(_T->l=
ock))
=20
 DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api=
_smp.h
index 9ecb0ab504e3..791867efad04 100644
=2D-- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -22,6 +22,8 @@ int in_lock_functions(unsigned long addr);
 void __lockfunc _raw_spin_lock(raw_spinlock_t *lock) __acquires(lock);
 void __lockfunc _raw_spin_lock_nested(raw_spinlock_t *lock, int subclass)
 __acquires(lock);
+void __lockfunc _raw_spin_lock_bh_nested(raw_spinlock_t *lock, int subcla=
ss)
+ __acquires(lock);
 void __lockfunc
 _raw_spin_lock_nest_lock(raw_spinlock_t *lock, struct lockdep_map *map)
 __acquires(lock);
diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_=
up.h
index 819aeba1c87e..a42887a0c846 100644
=2D-- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -57,6 +57,7 @@
=20
 #define _raw_spin_lock(lock) __LOCK(lock)
 #define _raw_spin_lock_nested(lock, subclass) __LOCK(lock)
+#define _raw_spin_lock_bh_nested(lock, subclass) __LOCK(lock)
 #define _raw_read_lock(lock) __LOCK(lock)
 #define _raw_write_lock(lock) __LOCK(lock)
 #define _raw_write_lock_nested(lock, subclass) __LOCK(lock)
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index f6499c37157d..b89dc9e272cc 100644
=2D-- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -88,6 +88,13 @@ static __always_inline void spin_lock_bh(spinlock_t *lo=
ck)
 rt_spin_lock(lock);
 }
=20
+static __always_inline void spin_lock_bh_nested(spinlock_t *lock, int sub=
class)
+{
+ /* Investigate: Drop bh when blocking ? */
+ local_bh_disable();
+ rt_spin_lock_nested(lock, subclass);
+}
+
 static __always_inline void spin_lock_irq(spinlock_t *lock)
 {
 rt_spin_lock(lock);
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 7685defd7c52..c4aa80441a1d 100644
=2D-- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -380,6 +380,14 @@ void __lockfunc _raw_spin_lock_nested(raw_spinlock_t =
*lock, int subclass)
 }
 EXPORT_SYMBOL(_raw_spin_lock_nested);
=20
+void __lockfunc _raw_spin_lock_bh_nested(raw_spinlock_t *lock, int subcla=
ss)
+{
+ __local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
+ spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+ LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
+}
+EXPORT_SYMBOL(_raw_spin_lock_bh_nested);
+
 unsigned long __lockfunc _raw_spin_lock_irqsave_nested(raw_spinlock_t *lo=
ck,
 int subclass)
 {
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index db1e11b45de6..5b76072c4838 100644
=2D-- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -58,7 +58,6 @@ void __sched rt_spin_lock(spinlock_t *lock) __acquires(R=
CU)
 }
 EXPORT_SYMBOL(rt_spin_lock);
=20
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __sched rt_spin_lock_nested(spinlock_t *lock, int subclass)
 {
 spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
@@ -66,6 +65,7 @@ void __sched rt_spin_lock_nested(spinlock_t *lock, int s=
ubclass)
 }
 EXPORT_SYMBOL(rt_spin_lock_nested);
=20
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __sched rt_spin_lock_nest_lock(spinlock_t *lock,
 struct lockdep_map *nest_lock)
 {
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 30899a8cc52c..d62455f62fc4 100644
=2D-- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1457,7 +1457,7 @@ void hrtimer_cancel_wait_running(const struct hrtime=
r *timer)
 * unlikely and just causes another wait loop.
 */
 atomic_inc(&base->cpu_base->timer_waiters);
- spin_lock_bh(&base->cpu_base->softirq_expiry_lock);
+ spin_lock_bh_nested(&base->cpu_base->softirq_expiry_lock, SINGLE_DEPTH_N=
ESTING);
 atomic_dec(&base->cpu_base->timer_waiters);
 spin_unlock_bh(&base->cpu_base->softirq_expiry_lock);
 }
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/te=
sting/selftests/bpf/progs/dynptr_success.c
index e1fba28e4a86..7cfb9473a526 100644
=2D-- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -7,6 +7,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
+#include "bpf_kfuncs.h"
 #include "errno.h"
=20
 char _license[] SEC("license") =3D "GPL";


Bert Karwatzki

