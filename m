Return-Path: <bpf+bounces-54127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD61A63395
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5475E1892B50
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D37192D84;
	Sun, 16 Mar 2025 04:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyCJ34Al"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14618FDC6;
	Sun, 16 Mar 2025 04:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097963; cv=none; b=E4kXIcLQsFZWwEprvZETuDa4/MfMlQoCdcWgNnwnsW5xralsuvAyfm9N0HD0yg870t575f7Sr0KexOyo/fQUpZjd7jcvqznZhM+uSM9rXz6W7Lu6T7MH1DQFJz+UByAw+8KrYszqo9XvIf0jnUqp+snUI4rhg0B9fkPyQj13nCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097963; c=relaxed/simple;
	bh=R8rK3hAtLu0/qV+H7D4vZfaR/OW4OI0d017EzOpkC74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcDmIBhtnRvRno2wC7G613kA2S94TlY4zQv2cvnBZpicI5mMZbHlCGGyM1LUBgIFC/WBzvLl8bZS3IijQ4iuPmgZvYG4ASVoeYy634wiv6dLqZL+uu1H7GQafKGGhZuYQ7YPGVnJo0t4ytmf/rztcULJtUT3SKhNSYbLsh6nDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyCJ34Al; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso3923265e9.3;
        Sat, 15 Mar 2025 21:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097959; x=1742702759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Trt2PZaoDvW1qF5TKGphGKbeL9d09FYulI4YnHalG2E=;
        b=PyCJ34AlW5TiK4gBQL1GWBt1zi60xEniOCiepyskACjan6ePRoBoTYsSxn6bOkOvhN
         8SrSdTSKg5gQZATLCuAf4pMs8E4dQ+evFPUx1DZmYNAbi0a5GvHn+mRhFo4oeKJ8eoXr
         PJdOL8zFcAjpW64vRbcya9EL4S3/eDGXzDKp3Jc6QShvdolsUsPnqL3rkAvB3OzLT2/J
         V55J+4VRVQ1tVAqx1s7txAdTKugxuBJO/S1GOdrT68Rv8SUKayV22SH/jeGfwxEvUqGI
         AdCrvOFaFQxsCzHRZUn/OicOuNHiyzfhqMralm6XYgLhIwSIHg22QZVvmiE+dH0cdutI
         OGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097959; x=1742702759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Trt2PZaoDvW1qF5TKGphGKbeL9d09FYulI4YnHalG2E=;
        b=TpReH+yKpCj2i8A+5idXXQClbUyBvxPtfV9oy9sGfkretvBGktKoQgupH33BAa20tB
         c/RClu+0QDRlOWH/TIWVJUadZd+s/QvNyvGZb9uWbPbZUJqAY0fnzm8LjSkSfWR9XhCL
         qiMKZgwrhws9RcjlqRpSaHwcjMEp1yGSaCpHA7A/UzJRP478H4Xr9RA7PGOb5mk5Cuyh
         TEOKe+yb4lOgU8z3N2X9czgm4BWJ/7cmQbzg2WVN2rLNlUxxFwPgNLFzWLhgnW86fsDH
         sgz10h5al/zQ9co6HYs2jkUN4iMGma0YzHihpwviOgnwzLxQ+7rDDWnuklNmjfU1VhQO
         h2HQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9oZSR6Qfyx/+MvtCCYLXl1GUwG744ASs5bBtrRSa92LPqx9BV5C70nY//N89IwGJ9B7u1DWyTAzQCl4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP91T1FI8Md+eGFXBCSX8pAAGMhM5mouNu2XnSAf98GNTwwUAj
	Y5WNHDsqnTkkBNNZomfWrWP4QvMGCh6HXuHV2XtsLcxd5bJiXWa6DpkFVSgAY6A=
X-Gm-Gg: ASbGncssYmDGMUzhL98nHABpJDkaRM8YGn+6yZ5ST7n5UJjjWramMCJoFMDkg/vzcM7
	p+dZlt3qX5fqAgD48AoF1L93jVC0B4xABS79/B63snFvmV5po0KDoWM4dlseTC3jZznDwaSbC5A
	uDEaaytavz4pX+/ZEk/T6usAcKkmnJugCcLDsCY55TBehQED+8L5BkfJU6L4BegqB4bMIA67JKn
	MCV+/lqCvPvkG6HsgpCirEbjP73cNXFZnrDIkuw4ZpC5pfb04VxrFldEAtBIplyNhqKhzoNufH6
	kd9QI9A/yzUGl+KgTYBn0AY2QUq7FQP+j5U=
X-Google-Smtp-Source: AGHT+IELCRC7Npj53fsWLLPGTTMW2S8mtuRNJw4+tQrj7Ej7EcmIuAdgGibINSTvjMReh3aiCtM8KA==
X-Received: by 2002:a5d:6da1:0:b0:391:4389:f363 with SMTP id ffacd0b85a97d-3971ee44e17mr9518660f8f.21.1742097958853;
        Sat, 15 Mar 2025 21:05:58 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975b90sm11082741f8f.53.2025.03.15.21.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:05:57 -0700 (PDT)
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
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 12/25] rqspinlock: Add deadlock detection and recovery
Date: Sat, 15 Mar 2025 21:05:28 -0700
Message-ID: <20250316040541.108729-13-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16807; h=from:subject; bh=R8rK3hAtLu0/qV+H7D4vZfaR/OW4OI0d017EzOpkC74=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3d3cpOPE+JD/6A6QOyXue338yygczvobcBs9p0 t9lKfEyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3QAKCRBM4MiGSL8RyulYD/ oCAFAcDJwUGqxq0HokrhAu3NOXVZPUQzrD1Fd/bAV3pkN73meLLVeovkYVI0ve7Kjx2/hcMJyYvJbr jkpwrffoXO8Xr768OKNR4mBc6jrytY5czg/+e0BKRXct/n5IFosZ8+tHgjaY9j5RcQcq7eRwUQnxnn Q7S84XghkBroVcQtWuJM98v/KONhHgJCpGMQAAUU32SNWJkc28V4HIWt9hoQsoIi6CJTX8Uc88a/Qf FVOQlNaBXGiYKMb9K3kOjA41VLmhe565kuFeGvXUnJi+Cn9xac01lMqZRoHRIVKeHgz/mo0i+F7abp eofFVG0gbpmw0Gb+GlDHtD6UztvzXQW6TUTZqpfs9TXc5ti4+Nv12bATZP9jhNTd3dmKxw+z7JScl4 BMgrqxtE/WrA7jZVALBqwJ2kPbQolbz8sbNHH5z0796JP71TrPx7mfKFi2Us1I0Nv+hUkuwarjUzIt VJhlvGVJXd9BRHbCHCSIq+sh7i5y3bcjHmfFhim9zewk0L8xWupkFUohlI78gsDmgMlQl7f9w8VVza 8hOQDu9DZMx4wjyXZL5LKr4XOZiXlowtWpcR++9jgQoihCpQXlPZJouhUpu2Gt9rOQdgIMp/8Ws4U2 ep59HLE49pV/ul4ULzQIO5O665ynyxzgE/f/3H6pSPpftXxAxajnOTA5uYRw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

While the timeout logic provides guarantees for the waiter's forward
progress, the time until a stalling waiter unblocks can still be long.
The default timeout of 1/4 sec can be excessively long for some use
cases.  Additionally, custom timeouts may exacerbate recovery time.

Introduce logic to detect common cases of deadlocks and perform quicker
recovery. This is done by dividing the time from entry into the locking
slow path until the timeout into intervals of 1 ms. Then, after each
interval elapses, deadlock detection is performed, while also polling
the lock word to ensure we can quickly break out of the detection logic
and proceed with lock acquisition.

A 'held_locks' table is maintained per-CPU where the entry at the bottom
denotes a lock being waited for or already taken. Entries coming before
it denote locks that are already held. The current CPU's table can thus
be looked at to detect AA deadlocks. The tables from other CPUs can be
looked at to discover ABBA situations. Finally, when a matching entry
for the lock being taken on the current CPU is found on some other CPU,
a deadlock situation is detected. This function can take a long time,
therefore the lock word is constantly polled in each loop iteration to
ensure we can preempt detection and proceed with lock acquisition, using
the is_lock_released check.

We set 'spin' member of rqspinlock_timeout struct to 0 to trigger
deadlock checks immediately to perform faster recovery.

Note: Extending lock word size by 4 bytes to record owner CPU can allow
faster detection for ABBA. It is typically the owner which participates
in a ABBA situation. However, to keep compatibility with existing lock
words in the kernel (struct qspinlock), and given deadlocks are a rare
event triggered by bugs, we choose to favor compatibility over faster
detection.

The release_held_lock_entry function requires an smp_wmb, while the
release store on unlock will provide the necessary ordering for us. Add
comments to document the subtleties of why this is correct. It is
possible for stores to be reordered still, but in the context of the
deadlock detection algorithm, a release barrier is sufficient and
needn't be stronger for unlock's case.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h | 100 +++++++++++++++++
 kernel/bpf/rqspinlock.c          | 187 ++++++++++++++++++++++++++++---
 2 files changed, 273 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 9bd11cb7acd6..34c3dcb4299e 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -11,6 +11,7 @@
 
 #include <linux/types.h>
 #include <vdso/time64.h>
+#include <linux/percpu.h>
 
 struct qspinlock;
 typedef struct qspinlock rqspinlock_t;
@@ -22,4 +23,103 @@ extern int resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val);
  */
 #define RES_DEF_TIMEOUT (NSEC_PER_SEC / 4)
 
+/*
+ * Choose 31 as it makes rqspinlock_held cacheline-aligned.
+ */
+#define RES_NR_HELD 31
+
+struct rqspinlock_held {
+	int cnt;
+	void *locks[RES_NR_HELD];
+};
+
+DECLARE_PER_CPU_ALIGNED(struct rqspinlock_held, rqspinlock_held_locks);
+
+static __always_inline void grab_held_lock_entry(void *lock)
+{
+	int cnt = this_cpu_inc_return(rqspinlock_held_locks.cnt);
+
+	if (unlikely(cnt > RES_NR_HELD)) {
+		/* Still keep the inc so we decrement later. */
+		return;
+	}
+
+	/*
+	 * Implied compiler barrier in per-CPU operations; otherwise we can have
+	 * the compiler reorder inc with write to table, allowing interrupts to
+	 * overwrite and erase our write to the table (as on interrupt exit it
+	 * will be reset to NULL).
+	 *
+	 * It is fine for cnt inc to be reordered wrt remote readers though,
+	 * they won't observe our entry until the cnt update is visible, that's
+	 * all.
+	 */
+	this_cpu_write(rqspinlock_held_locks.locks[cnt - 1], lock);
+}
+
+/*
+ * We simply don't support out-of-order unlocks, and keep the logic simple here.
+ * The verifier prevents BPF programs from unlocking out-of-order, and the same
+ * holds for in-kernel users.
+ *
+ * It is possible to run into misdetection scenarios of AA deadlocks on the same
+ * CPU, and missed ABBA deadlocks on remote CPUs if this function pops entries
+ * out of order (due to lock A, lock B, unlock A, unlock B) pattern. The correct
+ * logic to preserve right entries in the table would be to walk the array of
+ * held locks and swap and clear out-of-order entries, but that's too
+ * complicated and we don't have a compelling use case for out of order unlocking.
+ */
+static __always_inline void release_held_lock_entry(void)
+{
+	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
+
+	if (unlikely(rqh->cnt > RES_NR_HELD))
+		goto dec;
+	WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL);
+dec:
+	/*
+	 * Reordering of clearing above with inc and its write in
+	 * grab_held_lock_entry that came before us (in same acquisition
+	 * attempt) is ok, we either see a valid entry or NULL when it's
+	 * visible.
+	 *
+	 * But this helper is invoked when we unwind upon failing to acquire the
+	 * lock. Unlike the unlock path which constitutes a release store after
+	 * we clear the entry, we need to emit a write barrier here. Otherwise,
+	 * we may have a situation as follows:
+	 *
+	 * <error> for lock B
+	 * release_held_lock_entry
+	 *
+	 * try_cmpxchg_acquire for lock A
+	 * grab_held_lock_entry
+	 *
+	 * Lack of any ordering means reordering may occur such that dec, inc
+	 * are done before entry is overwritten. This permits a remote lock
+	 * holder of lock B (which this CPU failed to acquire) to now observe it
+	 * as being attempted on this CPU, and may lead to misdetection (if this
+	 * CPU holds a lock it is attempting to acquire, leading to false ABBA
+	 * diagnosis).
+	 *
+	 * In case of unlock, we will always do a release on the lock word after
+	 * releasing the entry, ensuring that other CPUs cannot hold the lock
+	 * (and make conclusions about deadlocks) until the entry has been
+	 * cleared on the local CPU, preventing any anomalies. Reordering is
+	 * still possible there, but a remote CPU cannot observe a lock in our
+	 * table which it is already holding, since visibility entails our
+	 * release store for the said lock has not retired.
+	 *
+	 * In theory we don't have a problem if the dec and WRITE_ONCE above get
+	 * reordered with each other, we either notice an empty NULL entry on
+	 * top (if dec succeeds WRITE_ONCE), or a potentially stale entry which
+	 * cannot be observed (if dec precedes WRITE_ONCE).
+	 *
+	 * Emit the write barrier _before_ the dec, this permits dec-inc
+	 * reordering but that is harmless as we'd have new entry set to NULL
+	 * already, i.e. they cannot precede the NULL store above.
+	 */
+	smp_wmb();
+	this_cpu_dec(rqspinlock_held_locks.cnt);
+}
+
 #endif /* __ASM_GENERIC_RQSPINLOCK_H */
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 361d452f027c..bddbcc47d38f 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -31,6 +31,7 @@
  */
 #include "../locking/qspinlock.h"
 #include "../locking/lock_events.h"
+#include "rqspinlock.h"
 
 /*
  * The basic principle of a queue-based spinlock can best be understood
@@ -74,16 +75,147 @@
 struct rqspinlock_timeout {
 	u64 timeout_end;
 	u64 duration;
+	u64 cur;
 	u16 spin;
 };
 
 #define RES_TIMEOUT_VAL	2
 
-static noinline int check_timeout(struct rqspinlock_timeout *ts)
+DEFINE_PER_CPU_ALIGNED(struct rqspinlock_held, rqspinlock_held_locks);
+EXPORT_SYMBOL_GPL(rqspinlock_held_locks);
+
+static bool is_lock_released(rqspinlock_t *lock, u32 mask, struct rqspinlock_timeout *ts)
+{
+	if (!(atomic_read_acquire(&lock->val) & (mask)))
+		return true;
+	return false;
+}
+
+static noinline int check_deadlock_AA(rqspinlock_t *lock, u32 mask,
+				      struct rqspinlock_timeout *ts)
+{
+	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
+	int cnt = min(RES_NR_HELD, rqh->cnt);
+
+	/*
+	 * Return an error if we hold the lock we are attempting to acquire.
+	 * We'll iterate over max 32 locks; no need to do is_lock_released.
+	 */
+	for (int i = 0; i < cnt - 1; i++) {
+		if (rqh->locks[i] == lock)
+			return -EDEADLK;
+	}
+	return 0;
+}
+
+/*
+ * This focuses on the most common case of ABBA deadlocks (or ABBA involving
+ * more locks, which reduce to ABBA). This is not exhaustive, and we rely on
+ * timeouts as the final line of defense.
+ */
+static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
+					struct rqspinlock_timeout *ts)
+{
+	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
+	int rqh_cnt = min(RES_NR_HELD, rqh->cnt);
+	void *remote_lock;
+	int cpu;
+
+	/*
+	 * Find the CPU holding the lock that we want to acquire. If there is a
+	 * deadlock scenario, we will read a stable set on the remote CPU and
+	 * find the target. This would be a constant time operation instead of
+	 * O(NR_CPUS) if we could determine the owning CPU from a lock value, but
+	 * that requires increasing the size of the lock word.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct rqspinlock_held *rqh_cpu = per_cpu_ptr(&rqspinlock_held_locks, cpu);
+		int real_cnt = READ_ONCE(rqh_cpu->cnt);
+		int cnt = min(RES_NR_HELD, real_cnt);
+
+		/*
+		 * Let's ensure to break out of this loop if the lock is available for
+		 * us to potentially acquire.
+		 */
+		if (is_lock_released(lock, mask, ts))
+			return 0;
+
+		/*
+		 * Skip ourselves, and CPUs whose count is less than 2, as they need at
+		 * least one held lock and one acquisition attempt (reflected as top
+		 * most entry) to participate in an ABBA deadlock.
+		 *
+		 * If cnt is more than RES_NR_HELD, it means the current lock being
+		 * acquired won't appear in the table, and other locks in the table are
+		 * already held, so we can't determine ABBA.
+		 */
+		if (cpu == smp_processor_id() || real_cnt < 2 || real_cnt > RES_NR_HELD)
+			continue;
+
+		/*
+		 * Obtain the entry at the top, this corresponds to the lock the
+		 * remote CPU is attempting to acquire in a deadlock situation,
+		 * and would be one of the locks we hold on the current CPU.
+		 */
+		remote_lock = READ_ONCE(rqh_cpu->locks[cnt - 1]);
+		/*
+		 * If it is NULL, we've raced and cannot determine a deadlock
+		 * conclusively, skip this CPU.
+		 */
+		if (!remote_lock)
+			continue;
+		/*
+		 * Find if the lock we're attempting to acquire is held by this CPU.
+		 * Don't consider the topmost entry, as that must be the latest lock
+		 * being held or acquired.  For a deadlock, the target CPU must also
+		 * attempt to acquire a lock we hold, so for this search only 'cnt - 1'
+		 * entries are important.
+		 */
+		for (int i = 0; i < cnt - 1; i++) {
+			if (READ_ONCE(rqh_cpu->locks[i]) != lock)
+				continue;
+			/*
+			 * We found our lock as held on the remote CPU.  Is the
+			 * acquisition attempt on the remote CPU for a lock held
+			 * by us?  If so, we have a deadlock situation, and need
+			 * to recover.
+			 */
+			for (int i = 0; i < rqh_cnt - 1; i++) {
+				if (rqh->locks[i] == remote_lock)
+					return -EDEADLK;
+			}
+			/*
+			 * Inconclusive; retry again later.
+			 */
+			return 0;
+		}
+	}
+	return 0;
+}
+
+static noinline int check_deadlock(rqspinlock_t *lock, u32 mask,
+				   struct rqspinlock_timeout *ts)
+{
+	int ret;
+
+	ret = check_deadlock_AA(lock, mask, ts);
+	if (ret)
+		return ret;
+	ret = check_deadlock_ABBA(lock, mask, ts);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
+				  struct rqspinlock_timeout *ts)
 {
 	u64 time = ktime_get_mono_fast_ns();
+	u64 prev = ts->cur;
 
 	if (!ts->timeout_end) {
+		ts->cur = time;
 		ts->timeout_end = time + ts->duration;
 		return 0;
 	}
@@ -91,6 +223,15 @@ static noinline int check_timeout(struct rqspinlock_timeout *ts)
 	if (time > ts->timeout_end)
 		return -ETIMEDOUT;
 
+	/*
+	 * A millisecond interval passed from last time? Trigger deadlock
+	 * checks.
+	 */
+	if (prev + NSEC_PER_MSEC < time) {
+		ts->cur = time;
+		return check_deadlock(lock, mask, ts);
+	}
+
 	return 0;
 }
 
@@ -99,21 +240,22 @@ static noinline int check_timeout(struct rqspinlock_timeout *ts)
  * as the macro does internal amortization for us.
  */
 #ifndef res_smp_cond_load_acquire
-#define RES_CHECK_TIMEOUT(ts, ret)                    \
-	({                                            \
-		if (!(ts).spin++)                     \
-			(ret) = check_timeout(&(ts)); \
-		(ret);                                \
+#define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
+	({                                                            \
+		if (!(ts).spin++)                                     \
+			(ret) = check_timeout((lock), (mask), &(ts)); \
+		(ret);                                                \
 	})
 #else
-#define RES_CHECK_TIMEOUT(ts, ret, mask)	      \
+#define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
 	({ (ret) = check_timeout(&(ts)); })
 #endif
 
 /*
  * Initialize the 'spin' member.
+ * Set spin member to 0 to trigger AA/ABBA checks immediately.
  */
-#define RES_INIT_TIMEOUT(ts) ({ (ts).spin = 1; })
+#define RES_INIT_TIMEOUT(ts) ({ (ts).spin = 0; })
 
 /*
  * We only need to reset 'timeout_end', 'spin' will just wrap around as necessary.
@@ -142,6 +284,7 @@ static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
  *
  * Return:
  * * 0		- Lock was acquired successfully.
+ * * -EDEADLK	- Lock acquisition failed because of AA/ABBA deadlock.
  * * -ETIMEDOUT - Lock acquisition failed because of timeout.
  *
  * (queue tail, pending bit, lock value)
@@ -212,6 +355,11 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 		goto queue;
 	}
 
+	/*
+	 * Grab an entry in the held locks array, to enable deadlock detection.
+	 */
+	grab_held_lock_entry(lock);
+
 	/*
 	 * We're pending, wait for the owner to go away.
 	 *
@@ -225,7 +373,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret));
+		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
 	}
 
 	if (ret) {
@@ -240,7 +388,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 		 */
 		clear_pending(lock);
 		lockevent_inc(rqspinlock_lock_timeout);
-		return ret;
+		goto err_release_entry;
 	}
 
 	/*
@@ -258,6 +406,11 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 queue:
 	lockevent_inc(lock_slowpath);
+	/*
+	 * Grab deadlock detection entry for the queue path.
+	 */
+	grab_held_lock_entry(lock);
+
 	node = this_cpu_ptr(&rqnodes[0].mcs);
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
@@ -277,9 +430,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 		lockevent_inc(lock_no_node);
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
 		while (!queued_spin_trylock(lock)) {
-			if (RES_CHECK_TIMEOUT(ts, ret)) {
+			if (RES_CHECK_TIMEOUT(ts, ret, ~0u)) {
 				lockevent_inc(rqspinlock_lock_timeout);
-				break;
+				goto err_release_node;
 			}
 			cpu_relax();
 		}
@@ -375,7 +528,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
 	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret));
+					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
 
 waitq_timeout:
 	if (ret) {
@@ -408,7 +561,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 			WRITE_ONCE(next->locked, RES_TIMEOUT_VAL);
 		}
 		lockevent_inc(rqspinlock_lock_timeout);
-		goto release;
+		goto err_release_node;
 	}
 
 	/*
@@ -455,5 +608,11 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	__this_cpu_dec(rqnodes[0].mcs.count);
 	return ret;
+err_release_node:
+	trace_contention_end(lock, ret);
+	__this_cpu_dec(rqnodes[0].mcs.count);
+err_release_entry:
+	release_held_lock_entry();
+	return ret;
 }
 EXPORT_SYMBOL_GPL(resilient_queued_spin_lock_slowpath);
-- 
2.47.1


