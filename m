Return-Path: <bpf+bounces-50645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB9DA2A675
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F094E3A5716
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4145822FAEA;
	Thu,  6 Feb 2025 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab9yPqLr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C405D22F16A;
	Thu,  6 Feb 2025 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839297; cv=none; b=sqzngBAnJ71ob9KM0x7/G5G2lEiuTLliijdZ2Bm3FkK+j6fdiqrcDS5iDk5dJP8BS88HmhRkJ+zuJ2L8RfxPeCxSaTFcv9Gvkp2ln/Boe/HChkPYdJTuJP/jVM8NdgJIlI5ONDJMf+3bkxXo2VpD3QMESHc2YgOZLJcIDVPLG+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839297; c=relaxed/simple;
	bh=msNcOGVmrnAfRu3MV0az2zqDUq7IHfqHVuBu+GMrk4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ka0TmfdLE18JzcSxTMHt+f8k770caXmt1uVUUznZyksbTTo03qm3I7k43WxcqpPcaL7XTdc/elWO9YrMXTpDQ2h7FSZjhWoqQQWyCBIMkek7iK3Sv2O39i69VqCpCk+C0J4EPOMaMBAyhexlMH13gknRvmhCCzfb4Nmp+OadGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab9yPqLr; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-436345cc17bso5141215e9.0;
        Thu, 06 Feb 2025 02:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839292; x=1739444092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8M3jGKVoMOaiDp/mgjTJ4k4swCXfL8TDoJbCV0k94ZM=;
        b=Ab9yPqLrvJWg8Joyz5ZMeQgk//ncJ7XjcY8OC7mq7lDmc8WX82pG5HWBxtkUyL+z8U
         Y2L+9kvjxR+7dlGAeMdY1VvmVpTmBc5j4QKzwIBNHnQUABGMS3szQMfw7XmBgOXCn1s+
         h/kwRK+CgDs8g2zFOxWciauwdtKmM7ODonL4SiuvzifuYs/PAH8N7klkcCGZv8070peK
         n/fIKNNJsHLNKStVFi1C57aCbXdz25QMXhGCFIQieVK9KPO6Z4IupThYLHM9SBeACIKu
         UrdKPvUqCvMx/qv6L9ts9Q6UhoQ9+o7A8ovkldEKvhLnPfMJvcYj7Gd8pVDwCrvUnBcg
         GxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839292; x=1739444092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8M3jGKVoMOaiDp/mgjTJ4k4swCXfL8TDoJbCV0k94ZM=;
        b=r6kRqViWBgf5aGv4xXxjF0hEVNtWeCrxgKs1/87AA1Q7cS3gQkGNjJ/srhD6cmfI5E
         stXedqJj4B7uigNWJC9FUvlOQfhmKf6A+djESosWK78G9BlHsm/1qdq0UMrtE5nkYXkt
         bxcCGo6a8vJAeifsIcmT/iRB2ndqFev4GEdNOnFnznowD9o5eSpqInkPwOMwnLt99UgT
         kOwvQaxT5QdNaEoMnZ/YjpTK79MO3I+6AZFXM3d2t69p2TMrTVsPmn0BIvHZ6ExjXEn/
         3fBOyYBxNufr0CtQLQNoRi7nU//SZCzC5VNQ2SsRDJvQFJKl2uRE+MBRQrHvtj+Ci2/7
         urwA==
X-Forwarded-Encrypted: i=1; AJvYcCXSXYm1dj+WSZWemoNPsqloo8zV72gv7x7jEkIbF4klr/cNyZO+bwxV+n9O29FYkVbXS+Dgx4/MT3/UrMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWM2VL3L1I8YzykgV9qxKsZJG2DDon2Dw4ifKgaER6vIKcN8Ta
	gJSvuZr7SuV5qmH5Sna3Yb3HtzGuL5XSenkLzJselySfKGefrGjb75lV+4VUaAU=
X-Gm-Gg: ASbGnctaEUdoH5CHC23NoPv9+1sRlxXugwRL77zerv/NP+GNzPdqpwpt9Gnt4e2Oaar
	V5SzPLFPytjXUBSjD/NPmZn42nFWyWllStNhDJrVPP7DLN50kNXLfU/33fyRp8zwP1hjQhRP1C+
	QpphsYM3hZy2PmnVT3Ha1ouShiPCbD86/lHiU8wJAOiwYmqEugGM2PEzxqtuA5QjboALHe2a9Be
	o2CfA/alvMEih3/JTBDGJFcMw5wo4a4pAGH2ZcnRVbhrktSxqRNo6fb9rbJPLJlDN/ZFijVybwX
	8xu83w==
X-Google-Smtp-Source: AGHT+IE6Ytf9lAGZg/32w5jdCCc5bYoMNRLBU5aCkHim0FkVJBaC7h0Wj/nvgFrS1eA2CBln15W8Xg==
X-Received: by 2002:a7b:cbce:0:b0:434:9499:9e87 with SMTP id 5b1f17b1804b1-43912d37614mr17657335e9.25.1738839292380;
        Thu, 06 Feb 2025 02:54:52 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:73::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d964c7csm50548735e9.17.2025.02.06.02.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:54:51 -0800 (PST)
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
Subject: [PATCH bpf-next v2 11/26] rqspinlock: Add deadlock detection and recovery
Date: Thu,  6 Feb 2025 02:54:19 -0800
Message-ID: <20250206105435.2159977-12-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15389; h=from:subject; bh=msNcOGVmrnAfRu3MV0az2zqDUq7IHfqHVuBu+GMrk4A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRlbGObmmTmVt1u04gEed3cMy7FmALO/uAVks+a TeeoBgaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZQAKCRBM4MiGSL8RyiK0EA CnsJbt64sQX0kL016RYhlMZNffg/GcHvfv3Z9oFIBHQcHLm5bLwHfs4H4NTMyGbVhYbcOgTPdLdE2D DthUBlKJzI3++9fzS21vMoTArLRc+cWJMJlPcldmQQN9GEWs+b/JWYeCkyYbCSaTMqfXWCi/2rknpd IiM1cB9cu/wfEfje5N5LFnbXnCHoMreNOieQzxB0QIh/i86hmD+ykd3UqiUv760Z68PHozD3TfRpuT a7PXTCg4c8cYvwNs7CUHE2MF8SKHu2yYK7VA64+d6gkAsPGSctiNYcK9x0UYRHp/PZlfIbUrKsJWYW tTrmTMXAB0cNc3BBtMolkvMRTrXuMvMxootdKJZ810qc6RYfElFL7pzLsXWo8oB4OGyn3Gau3po3VG AJYUxKpTKF4k2WW+F+TbGolt6W/7v1jo2OXUzoMs/LFeFEB5XB16UoTp4po/kxAuX3GqLvlMtWsZcQ SG7GVcmsGx9lvto9F6yVjMvevUytjuT4u6A0cwgTSC4pDTlJXyDoN7VwX0iuTqnKddyh943RII4MuK d+rkjWBQWNMkwlqTLUJ4UxOusNS50rJNbWBpHmlApS0Stlf0zCOKqKcIVM+XepT1nadbnyrUe/Bhy8 FhajBZBdwockQWCjCt2Z1Mi6wiwkcY6rTQvd6J62f7BWXOkVhH+60sQr9qyQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

While the timeout logic provides guarantees for the waiter's forward
progress, the time until a stalling waiter unblocks can still be long.
The default timeout of 1/2 sec can be excessively long for some use
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
 include/asm-generic/rqspinlock.h |  83 +++++++++++++-
 kernel/locking/rqspinlock.c      | 183 ++++++++++++++++++++++++++++---
 2 files changed, 252 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 0981162c8ac7..c1dbd25287a1 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -11,15 +11,96 @@
 
 #include <linux/types.h>
 #include <vdso/time64.h>
+#include <linux/percpu.h>
 
 struct qspinlock;
 typedef struct qspinlock rqspinlock_t;
 
+extern int resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val, u64 timeout);
+
 /*
  * Default timeout for waiting loops is 0.5 seconds
  */
 #define RES_DEF_TIMEOUT (NSEC_PER_SEC / 2)
 
-extern int resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val, u64 timeout);
+#define RES_NR_HELD 32
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
+	 */
+	this_cpu_write(rqspinlock_held_locks.locks[cnt - 1], lock);
+}
+
+/*
+ * It is possible to run into misdetection scenarios of AA deadlocks on the same
+ * CPU, and missed ABBA deadlocks on remote CPUs when this function pops entries
+ * out of order (due to lock A, lock B, unlock A, unlock B) pattern. The correct
+ * logic to preserve right entries in the table would be to walk the array of
+ * held locks and swap and clear out-of-order entries, but that's too
+ * complicated and we don't have a compelling use case for out of order unlocking.
+ *
+ * Therefore, we simply don't support such cases and keep the logic simple here.
+ */
+static __always_inline void release_held_lock_entry(void)
+{
+	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
+
+	if (unlikely(rqh->cnt > RES_NR_HELD))
+		goto dec;
+	WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL);
+dec:
+	this_cpu_dec(rqspinlock_held_locks.cnt);
+	/*
+	 * This helper is invoked when we unwind upon failing to acquire the
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
+	 * Since these are attempts for different locks, no sequentiality is
+	 * guaranteed and reordering may occur such that dec, inc are done
+	 * before entry is overwritten. This permits a remote lock holder of
+	 * lock B to now observe it as being attempted on this CPU, and may lead
+	 * to misdetection.
+	 *
+	 * In case of unlock, we will always do a release on the lock word after
+	 * releasing the entry, ensuring that other CPUs cannot hold the lock
+	 * (and make conclusions about deadlocks) until the entry has been
+	 * cleared on the local CPU, preventing any anomalies. Reordering is
+	 * still possible there, but a remote CPU cannot observe a lock in our
+	 * table which it is already holding, since visibility entails our
+	 * release store for the said lock has not retired.
+	 *
+	 * We don't have a problem if the dec and WRITE_ONCE above get reordered
+	 * with each other, we either notice an empty NULL entry on top (if dec
+	 * succeeds WRITE_ONCE), or a potentially stale entry which cannot be
+	 * observed (if dec precedes WRITE_ONCE).
+	 */
+	smp_wmb();
+}
 
 #endif /* __ASM_GENERIC_RQSPINLOCK_H */
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index df7adec59cec..42e8a56534b6 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -30,6 +30,7 @@
  * Include queued spinlock definitions and statistics code
  */
 #include "qspinlock.h"
+#include "rqspinlock.h"
 #include "qspinlock_stat.h"
 
 /*
@@ -74,16 +75,146 @@
 struct rqspinlock_timeout {
 	u64 timeout_end;
 	u64 duration;
+	u64 cur;
 	u16 spin;
 };
 
 #define RES_TIMEOUT_VAL	2
 
-static noinline int check_timeout(struct rqspinlock_timeout *ts)
+DEFINE_PER_CPU_ALIGNED(struct rqspinlock_held, rqspinlock_held_locks);
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
@@ -91,20 +222,30 @@ static noinline int check_timeout(struct rqspinlock_timeout *ts)
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
 
 /*
  * Initialize the 'duration' member with the chosen timeout.
+ * Set spin member to 0 to trigger AA/ABBA checks immediately.
  */
-#define RES_INIT_TIMEOUT(ts, _timeout) ({ (ts).spin = 1; (ts).duration = _timeout; })
+#define RES_INIT_TIMEOUT(ts, _timeout) ({ (ts).spin = 0; (ts).duration = _timeout; })
 
 /*
  * We only need to reset 'timeout_end', 'spin' will just wrap around as necessary.
@@ -192,6 +333,11 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
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
@@ -205,7 +351,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts);
-		smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret));
+		smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
 	}
 
 	if (ret) {
@@ -220,7 +366,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
 		 */
 		clear_pending(lock);
 		lockevent_inc(rqspinlock_lock_timeout);
-		return ret;
+		goto err_release_entry;
 	}
 
 	/*
@@ -238,6 +384,11 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
 	 */
 queue:
 	lockevent_inc(lock_slowpath);
+	/*
+	 * Grab deadlock detection entry for the queue path.
+	 */
+	grab_held_lock_entry(lock);
+
 	node = this_cpu_ptr(&qnodes[0].mcs);
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
@@ -257,9 +408,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
 		lockevent_inc(lock_no_node);
 		RES_RESET_TIMEOUT(ts);
 		while (!queued_spin_trylock(lock)) {
-			if (RES_CHECK_TIMEOUT(ts, ret)) {
+			if (RES_CHECK_TIMEOUT(ts, ret, ~0u)) {
 				lockevent_inc(rqspinlock_lock_timeout);
-				break;
+				goto err_release_node;
 			}
 			cpu_relax();
 		}
@@ -350,7 +501,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
 	 */
 	RES_RESET_TIMEOUT(ts);
 	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-				       RES_CHECK_TIMEOUT(ts, ret));
+				       RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
 
 waitq_timeout:
 	if (ret) {
@@ -375,7 +526,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
 			WRITE_ONCE(next->locked, RES_TIMEOUT_VAL);
 		}
 		lockevent_inc(rqspinlock_lock_timeout);
-		goto release;
+		goto err_release_node;
 	}
 
 	/*
@@ -422,5 +573,11 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
 	 */
 	__this_cpu_dec(qnodes[0].mcs.count);
 	return ret;
+err_release_node:
+	trace_contention_end(lock, ret);
+	__this_cpu_dec(qnodes[0].mcs.count);
+err_release_entry:
+	release_held_lock_entry();
+	return ret;
 }
 EXPORT_SYMBOL(resilient_queued_spin_lock_slowpath);
-- 
2.43.5


