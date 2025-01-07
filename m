Return-Path: <bpf+bounces-48109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258FFA04179
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A571887B75
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC06F1F2383;
	Tue,  7 Jan 2025 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeZyoicZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD551F37BD;
	Tue,  7 Jan 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258436; cv=none; b=jmoIicoDDv4/uouqGGkx48ZFso95E4RjsxIvL6FSAmn6+q03aPYWk/tpCKxvN3/W2p6+aOSLtgFHFUcye5sQTcYPQsmsZCNPOMoVS+7+Mhgrt2hiTS9Fp3d8wpamuGqoQguefgNHb8lxgZhNQ/Vzpg7yXu7VstpsJ1HXHKqbM/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258436; c=relaxed/simple;
	bh=bNf0S7LL2XvS5mVW9zMOR/LJpbrZez7d2KypRIUumaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDcWvaXQIQcG3b6L4XH+LRBH+KTFlQLGNDzVGcBAMQkigxPeCgpURgzQAp0BYxHaQQNbKw9w6GnbVHDZutHR3GPItz6pUI9KPg23o9Zrfy5seU2g+KQSViHZnjhsygPY9WAW0DkOrKcSbtGTUtvVaRYs8aRHj+1M4H4Xzk5V8SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeZyoicZ; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so10218650f8f.1;
        Tue, 07 Jan 2025 06:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258427; x=1736863227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jb4OSdpYuP2S/Nvn1Sz/n8DxUFgPznMtuFJtw7K3PyU=;
        b=EeZyoicZwd7XTmDa5ZRvy/TfyN+M5OjYPjuk7TYR+UHvaDCKckyoL5aSZ46CzXauHj
         ebQ1A5311WRXw7J5fPFWT3GkCtgEm1lW5vQojI2QsoyTzsQtc7zVjuah65r/NMnCb9JV
         rN6cmVrxapzIVg1rWLRwhReuMRvZeXTETu7S4hq35SayMO9mmFrwZ6Z6ZNjxclbJWmQn
         uKRqCqDUUZJ/YK7Yyb0D1dEGxxtnQwUiti5f4vTBHV0uiK67kulbDXBrzkajKVJgapD8
         QdTevKJNBFlqsVRMbuj4dE5U9TFZQTMEf2shvjwM5mS1MkKUYklmM/RnAJH4tCm4OwPy
         Lbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258427; x=1736863227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb4OSdpYuP2S/Nvn1Sz/n8DxUFgPznMtuFJtw7K3PyU=;
        b=IyIb19EG8L6BoU+9RsRucHJyU1Eg3I7tCL09HOhWz90rGVEsOAkljviLPIi/M+duqw
         ueoTyPTH6s+BNfs5UBi62rGwS8MCQTSOGV7JLTfQ6uRZxuHIuUhD5gCuIBW5BjTqOwPu
         dvhwA/J11l8aqsdlHCJIpq2YW678TPB8l1GMAuyJHP7OsL/tfjBr8LE3pmsuUqt/EEKd
         DlynzZO85WO/5XlhDhZU37G93ekYAs3+PgLqQtL1bsDrMSkp5PW8+vsaW9re0Ha1IkUN
         x9jUH1Uz0acykIesy05fcWgYPY9DHQE1BPmrqTNrXbjIcaVIyPNkJxI9EcEk6U65dkzF
         53XA==
X-Forwarded-Encrypted: i=1; AJvYcCUnEvxtFUBi8Whgw2V51S3SO8V/huTc9yvgmpTCPJqcAx5fTAi0tcFV+T/qJ9eyG/LABdSAB/Krb8xeBfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgpl0YAseBFw6QclTTy0RpJvDQXze8dPcsMnb+bbAGk31DmPR0
	L44UeegdVapRr2wqdP1LiG7mOa6tokipixjYu3Co16bbkvheheSZt8xjJONjQpaP0g==
X-Gm-Gg: ASbGncuXiI39UdUNwRsTJu0EExH5MzbxKSoyGqRaMJjzC4CgLCuYDf0zk9UGgxiMGtt
	8HgHuqCnYSykpMpI1GoD9KgwC3owoJBah0PmgwGPKYpXVMAuMUkXzVh+E3mogb6xqAfpMdTELhk
	LALBEN2P4YOplPwVOASYBLPuQd08cHwEtuJWVnr9/pnZXO67lIPW2GiepvAPRvTBbwIkVk6IgFV
	fiQ8T2XlyoeQd2L4dvsgRti8uwweyQI7V56M8ppvxoqWvU=
X-Google-Smtp-Source: AGHT+IHQu9PuFslO/cTslv03rwOEAoeYf2hfBbjnFKF/M9BtmQ/uEo66sXGtTo7qATbKLKNQ/EIB1g==
X-Received: by 2002:a05:6000:18a8:b0:385:f7d2:7e29 with SMTP id ffacd0b85a97d-38a221ea539mr51808481f8f.15.1736258426389;
        Tue, 07 Jan 2025 06:00:26 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828f5fsm51087383f8f.8.2025.01.07.06.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:25 -0800 (PST)
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
Subject: [PATCH bpf-next v1 11/22] rqspinlock: Add deadlock detection and recovery
Date: Tue,  7 Jan 2025 05:59:53 -0800
Message-ID: <20250107140004.2732830-12-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13520; h=from:subject; bh=bNf0S7LL2XvS5mVW9zMOR/LJpbrZez7d2KypRIUumaM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCdYUutWpw5wTtPT1XjjEZ4TIaA+HscecTSb1/+ heo1rcaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wnQAKCRBM4MiGSL8Ryqt+D/ 9Sx5zdp/3fFEv3erhlKTALKqzWyKk52pS0yH2p6V+XLc156S4Gza0LrKVO6BKynNXB8lGCtIlbEjt3 a6aHZJUPBPHIwiD5l8DhpW4IAVkkzINgI9bmCjVRq42gI4S0rE2rVddZrWf6RKRYo6fat6VQIGrODU eKABqaRe0BEK83I/6ZZYB1OrzRUKcDlSsw6zqyXuBxmbJocgWJ8pmfr9FxmJ0iusiJh14rVLsmcucs +CETEAMzfNfxeUZIZOJ7GccpQJuQRMCM7C23IE+pjU0hKCJU3s6AcxlYHu0dsFpikMyK91h4SpJk0B 6zm98nyftxRgYyGA7yJ1bwyDEDwve/JdE9XW8198PYvgbjvYWOaxVUSL2ZgFPL8lnTfCJ7XyK4QlFa /fXllaoCi0dvmnU7e68b7ZBarDYSdPiG14bKHrE0mk4CN36mskJZE2ep3F5sS47mXS0rS5nY5r9rz9 mzgEptIJiT2JXuG8BiOZNp3D7s1fSVBFQMDJg6T3bDpNpdrG0TOyBf/3L8PwfeWOxBE7+kEK28/KjF UMidbo/15Z2e5aqy1KzdLphE+rgqacFIDffDXi+kTe60DMWNYLDJ4GmTC+T+0cK3GOpkgEr5t/bjDO QH5H9/IaHPV1avIpmrFbsM4B5OQ6ytEXFyN6XX/Wrnz1mgZrrinmRERTLs9g==
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

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h |  56 +++++++++-
 kernel/locking/rqspinlock.c      | 178 ++++++++++++++++++++++++++++---
 2 files changed, 220 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 5c996a82e75f..c7e33ccc57a6 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -11,14 +11,68 @@
 
 #include <linux/types.h>
 #include <vdso/time64.h>
+#include <linux/percpu.h>
 
 struct qspinlock;
 
+extern int resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
+
 /*
  * Default timeout for waiting loops is 0.5 seconds
  */
 #define RES_DEF_TIMEOUT (NSEC_PER_SEC / 2)
 
-extern int resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
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
+	smp_store_release(&rqh->locks[rqh->cnt - 1], NULL);
+	/*
+	 * Overwrite of NULL should appear before our decrement of the count to
+	 * other CPUs, otherwise we have the issue of a stale non-NULL entry being
+	 * visible in the array, leading to misdetection during deadlock detection.
+	 */
+dec:
+	this_cpu_dec(rqspinlock_held_locks.cnt);
+}
 
 #endif /* __ASM_GENERIC_RQSPINLOCK_H */
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index b63f92bd43b1..b7c86127d288 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -30,6 +30,7 @@
  * Include queued spinlock definitions and statistics code
  */
 #include "qspinlock.h"
+#include "rqspinlock.h"
 #include "qspinlock_stat.h"
 
 /*
@@ -74,16 +75,141 @@
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
+static bool is_lock_released(struct qspinlock *lock, u32 mask, struct rqspinlock_timeout *ts)
+{
+	if (!(atomic_read_acquire(&lock->val) & (mask)))
+		return true;
+	return false;
+}
+
+static noinline int check_deadlock_AA(struct qspinlock *lock, u32 mask,
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
+static noinline int check_deadlock_ABBA(struct qspinlock *lock, u32 mask,
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
+static noinline int check_deadlock(struct qspinlock *lock, u32 mask,
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
+static noinline int check_timeout(struct qspinlock *lock, u32 mask,
+				  struct rqspinlock_timeout *ts)
 {
 	u64 time = ktime_get_mono_fast_ns();
+	u64 prev = ts->cur;
 
 	if (!ts->timeout_end) {
+		ts->cur = time;
 		ts->timeout_end = time + ts->duration;
 		return 0;
 	}
@@ -91,20 +217,30 @@ static noinline int check_timeout(struct rqspinlock_timeout *ts)
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
-		if (!((ts).spin++ & 0xffff))          \
-			(ret) = check_timeout(&(ts)); \
-		(ret);                                \
+#define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
+	({                                                            \
+		if (!((ts).spin++ & 0xffff))                          \
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
@@ -192,6 +328,11 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
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
@@ -205,7 +346,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts);
-		smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret));
+		smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
 	}
 
 	if (ret) {
@@ -220,7 +361,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
 		 */
 		clear_pending(lock);
 		lockevent_inc(rqspinlock_lock_timeout);
-		return ret;
+		goto err_release_entry;
 	}
 
 	/*
@@ -238,6 +379,11 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
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
@@ -257,9 +403,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
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
@@ -350,7 +496,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
 	 */
 	RES_RESET_TIMEOUT(ts);
 	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-				       RES_CHECK_TIMEOUT(ts, ret));
+				       RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
 
 waitq_timeout:
 	if (ret) {
@@ -375,7 +521,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
 			WRITE_ONCE(next->locked, RES_TIMEOUT_VAL);
 		}
 		lockevent_inc(rqspinlock_lock_timeout);
-		goto release;
+		goto err_release_node;
 	}
 
 	/*
@@ -422,5 +568,11 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
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


