Return-Path: <bpf+bounces-75738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2260C9347C
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12403A8B0F
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29FC2E973C;
	Fri, 28 Nov 2025 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pfhe8X/e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A782295516
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764371750; cv=none; b=n2YJHxO8sYoRDoQnauKeqP8FrnbkNsnLFIPSDhWdTxjpORMWQyBMTOBJ70ZkpISwerDAIrIxCTezvsaxmcaXNAGfb+mUCNMBAb74XXcFCjYRQOZCG5g9/HOn4DmZX3IrfGA5w35OjwlDERWdU5/U7Xr0zlSvM9AZgwRrZ5hPlj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764371750; c=relaxed/simple;
	bh=Ibpko85BVIRzc4PjrfAyl1unRL0Edcd1ilY4dG4L1QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWM6dExIauq9Db00hKhmPwSeNLaVco8xdO3DpF5/lNaLOvSlQh033aZP2e+X7oXNNwwliSxpBu23sCaf07rT/mqzAHYpkNU10QpnoIQskyY6eHaujAm/igW9sJmnf86pW8ccHu1d3W9SSgr2WH9Bg8cXyzsis8PkQ4DylCJFumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pfhe8X/e; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-429c4c65485so2139792f8f.0
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764371746; x=1764976546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Dc4P6IeHg5pmzZnpLJijme1vwm7plGkCX0k/qgIcqc=;
        b=Pfhe8X/eBty4l00fwfRRNiFFWmoVhMzWjyJoB7Q1ubmMklFONPnBWFkRVZKJ1h2Lqp
         PdFyoHFKwoHkmP7+1bwGs4GaIX6h2ZfDPcKGeGLNOCpbXk8364QP4n48OgRl44A51Th+
         FBHwcRAW+/QgbDMwo41gCa1eNZCVeOl2Q1E6/DwwISgKxl7ZmPkyFoHwk5cihkLt5raf
         TguAYy7lXBfdSzr6H9sG+ThIDLmebCs5Kma7yy6+eIXBGFUTJYqkYprJ17Oz92j6bRaZ
         Q+AHL0lRkpOyjJl6qZpgTstwQ7VJfjUXeAn3OE6o/tcgZflmsLIvZv5eMYP1sRK6TxdG
         A+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764371746; x=1764976546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Dc4P6IeHg5pmzZnpLJijme1vwm7plGkCX0k/qgIcqc=;
        b=Hv3Yty+nnljJrQP2gU6c7/7cCrQ3plUmK6znc9ICG23YDPWkqd/2bfJT0Sp8XhCx4i
         eWylPqfnumOhHMTXSx3UK5PmJ+duZ43W0PqVUclBWNuB5/gUZ4dyBBUqmqLDWXQIOkND
         ynBhbdaj1bgjAfX+jOMHrLoWUKDwD83fc9++ULTPm/SyTR5EX48704yzbFwCwZosHOVR
         byOtIpuBBp0s2enpYI4afWejQduqR1b1//bqK7PgJjL6VkIwEsXsa5XoGKN1jeRcHBzL
         w/wnSOAQS7+c7Z5wAnt/hRzUJxJA0q9HVPN7nSVVD4d/4hoJ8yhye1TOKSRg1ELitp5D
         MMTw==
X-Gm-Message-State: AOJu0Yw6xh56aJsJNeIT9p8m0iLZckEXAX/9JLEtmhNWnykqYxdoSTAH
	AOv5mgAaciZRyMXDlgCdCNCWMRNqQLos7qVc6D4hxk0vpjisfAmI8oGrSbhrZbM1
X-Gm-Gg: ASbGncvAfgLEEOi1N6elIKKFUSGPHZ/9Cssua9QT0cK4gYkct0mamsoNTf9Ilw9WTqJ
	Av9KU8nAqcs+OpqFzWlX59fQVpFPz2DBRnXQfyCsj7iatC1I4lBmG01Hlot7K3rdzFpCBhM1eoG
	UYSawFC7jlBSv9w1ZLOdtC6BjJ+YiOIovHHAmccwWd41GfJcEADzRPLWbUqOZ81Q+BBkQenYrWV
	dfO9GkcdaT5ZVJuCgCxn2UXUsoyQQtO0b9Fq/whFuPfiPeu4+ej4APACvPACFyUytkokECYKo26
	aMgYLFUq4TuWRij78oKzzGHWOYUf4P+LBI80MwBf/RQSYW+tzG9OGwgzqZLejgQvFwDmR4k0ekl
	QQxq/oUJ1cb8oOWH4u4bix+nnVD6q5Ds7a8DcifuCKoOMx2zjV/7lQUB0wt4vhUwyoxbp0kkS5l
	smsxLUhhA/p/up2qBg06feMQWQlA0pNpYNYLC82H1cWb2Oa8lv7uprJcAmjlQV5aPJdrdIF75kK
	LI=
X-Google-Smtp-Source: AGHT+IHzeW7oX5wljWjW2iLkuWJBHqXgQA+5DUSnIxXCb0jXHEZdkdYjzcX1y5LtIyJsUdaTgCZjjA==
X-Received: by 2002:a05:6000:1889:b0:42b:3155:21da with SMTP id ffacd0b85a97d-42cc1cd8f1cmr32430931f8f.2.1764371746170;
        Fri, 28 Nov 2025 15:15:46 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42e1c5c302esm11905637f8f.5.2025.11.28.15.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 15:15:45 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jelle van der Beek <jelle@superluminal.eu>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/6] rqspinlock: Enclose lock/unlock within lock entry acquisitions
Date: Fri, 28 Nov 2025 23:15:38 +0000
Message-ID: <20251128231543.890923-2-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128231543.890923-1-memxor@gmail.com>
References: <20251128231543.890923-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8491; i=memxor@gmail.com; h=from:subject; bh=Ibpko85BVIRzc4PjrfAyl1unRL0Edcd1ilY4dG4L1QY=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpKiyPkYfpg+k1DLHDHRdZCm8p27GzOMntbdG0a PSo8o+JkmyJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSosjwAKCRBM4MiGSL8R ylABD/96jex7ZklcPT0P6SPbu1kHO7h0TTIvbn0ABn3CLgA2Hob2omVUPtX1U4H7D+lQNde+BqV Nnw/f2a0V+Aq1h16tRwdOrTYA4FDsUoQASy11SiUqe/oBUfRp7Jchb50eBSDN5dJ+2C3nkbg+D3 Z3ejsDq3mfXVvfPofVFm8DPAb/kqKRtGJNJ5uvpISlDgdOwUgex5uc/CxC7Z5xm5i2hEbu6t+su s1R1bDPQZ4R6yG8UJAhF4LNXe9QclM/7ZUyFLvVxR8unWHxvQZuV6BnZVxrGwWyPAUCfXDJjm9U Ql2c2zb9k6qtUD5nDoGjuG0nDNh61CbhlBEqttyeNuUj7aQEKFdgNi+bpteURczOqgT2UN3UlhC aDiySQrKQno7Uxzo8d+d7hj9oIwZPqx4D5u3TynXrUfAU6//dDGJbhIHu3juMT5D1p5a7Bdf8jn O/Eo5/RzeyZQPZDo68US74BUjKzX49iAXTrpx5K4nvvr5r+NaHPZaWUONm2HWZiQ6kYpZZQCAyN +Vp+/7ECu0K1x8I8SZ9sl4tRgAjMo0uhmbQX3xJ3Rv3+MquATswgsxvyRfikLNrFmW/OoIUi85T U6LPfCBZi9DrfYeqkVcEdTnz1cy3CzPsSisVp8qnUUWP1bLAvg+SSEpyfzZP0B2tE9Sj+RX0miO Yv//tjVhRaMXoHA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ritesh reported that timeouts occurred frequently for rqspinlock despite
reentrancy on the same lock on the same CPU in [0]. This patch closes
one of the races leading to this behavior, and reduces the frequency of
timeouts.

We currently have a tiny window between the fast-path cmpxchg and the
grabbing of the lock entry where an NMI could land, attempt the same
lock that was just acquired, and end up timing out. This is not ideal.
Instead, move the lock entry acquisition from the fast path to before
the cmpxchg, and remove the grabbing of the lock entry in the slow path,
assuming it was already taken by the fast path. The TAS fallback is
invoked directly without being preceded by the typical fast path,
therefore we must continue to grab the deadlock detection entry in that
case.

Case on lock leading to missed AA:

cmpxchg lock A
<NMI>
... rqspinlock acquisition of A
... timeout
</NMI>
grab_held_lock_entry(A)

There is a similar case when unlocking the lock. If the NMI lands
between the WRITE_ONCE and smp_store_release, it is possible that we end
up in a situation where the NMI fails to diagnose the AA condition,
leading to a timeout.

Case on unlock leading to missed AA:

WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL)
<NMI>
... rqspinlock acquisition of A
... timeout
</NMI>
smp_store_release(A->locked, 0)

The patch changes the order on unlock to smp_store_release() succeeded
by WRITE_ONCE() of NULL. This avoids the missed AA detection described
above, but may lead to a false positive if the NMI lands between these
two statements, which is acceptable (and preferred over a timeout).

The original intention of the reverse order on unlock was to prevent the
following possible misdiagnosis of an ABBA scenario:

grab entry A
lock A
grab entry B
lock B
unlock B
   smp_store_release(B->locked, 0)
							grab entry B
							lock B
							grab entry A
							lock A
							! <detect ABBA>
   WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL)

If the store release were is after the WRITE_ONCE, the other CPU would
not observe B in the table of the CPU unlocking the lock B.  However,
since the threads are obviously participating in an ABBA deadlock, it
is no longer appealing to use the order above since it may lead to a
250 ms timeout due to missed AA detection.

  [0]: https://lore.kernel.org/bpf/CAH6OuBTjG+N=+GGwcpOUbeDN563oz4iVcU3rbse68egp9wj9_A@mail.gmail.com

Fixes: 0d80e7f951be ("rqspinlock: Choose trylock fallback for NMI waiters")
Reported-by: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h | 60 +++++++++++++++++---------------
 kernel/bpf/rqspinlock.c          | 15 ++++----
 2 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 6d4244d643df..0f2dcbbfee2f 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -129,8 +129,8 @@ static __always_inline void release_held_lock_entry(void)
 	 * <error> for lock B
 	 * release_held_lock_entry
 	 *
-	 * try_cmpxchg_acquire for lock A
 	 * grab_held_lock_entry
+	 * try_cmpxchg_acquire for lock A
 	 *
 	 * Lack of any ordering means reordering may occur such that dec, inc
 	 * are done before entry is overwritten. This permits a remote lock
@@ -139,13 +139,8 @@ static __always_inline void release_held_lock_entry(void)
 	 * CPU holds a lock it is attempting to acquire, leading to false ABBA
 	 * diagnosis).
 	 *
-	 * In case of unlock, we will always do a release on the lock word after
-	 * releasing the entry, ensuring that other CPUs cannot hold the lock
-	 * (and make conclusions about deadlocks) until the entry has been
-	 * cleared on the local CPU, preventing any anomalies. Reordering is
-	 * still possible there, but a remote CPU cannot observe a lock in our
-	 * table which it is already holding, since visibility entails our
-	 * release store for the said lock has not retired.
+	 * The case of unlock is treated differently due to NMI reentrancy, see
+	 * comments in res_spin_unlock.
 	 *
 	 * In theory we don't have a problem if the dec and WRITE_ONCE above get
 	 * reordered with each other, we either notice an empty NULL entry on
@@ -175,10 +170,22 @@ static __always_inline int res_spin_lock(rqspinlock_t *lock)
 {
 	int val = 0;
 
-	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL))) {
-		grab_held_lock_entry(lock);
+	/*
+	 * Grab the deadlock detection entry before doing the cmpxchg, so that
+	 * reentrancy due to NMIs between the succeeding cmpxchg and creation of
+	 * held lock entry can correctly detect an acquisition attempt in the
+	 * interrupted context.
+	 *
+	 * cmpxchg lock A
+	 * <NMI>
+	 * res_spin_lock(A) --> missed AA, leads to timeout
+	 * </NMI>
+	 * grab_held_lock_entry(A)
+	 */
+	grab_held_lock_entry(lock);
+
+	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
 		return 0;
-	}
 	return resilient_queued_spin_lock_slowpath(lock, val);
 }
 
@@ -192,28 +199,25 @@ static __always_inline void res_spin_unlock(rqspinlock_t *lock)
 {
 	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
 
-	if (unlikely(rqh->cnt > RES_NR_HELD))
-		goto unlock;
-	WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL);
-unlock:
 	/*
-	 * Release barrier, ensures correct ordering. See release_held_lock_entry
-	 * for details.  Perform release store instead of queued_spin_unlock,
-	 * since we use this function for test-and-set fallback as well. When we
-	 * have CONFIG_QUEUED_SPINLOCKS=n, we clear the full 4-byte lockword.
+	 * Release barrier, ensures correct ordering. Perform release store
+	 * instead of queued_spin_unlock, since we use this function for the TAS
+	 * fallback as well. When we have CONFIG_QUEUED_SPINLOCKS=n, we clear
+	 * the full 4-byte lockword.
 	 *
-	 * Like release_held_lock_entry, we can do the release before the dec.
-	 * We simply care about not seeing the 'lock' in our table from a remote
-	 * CPU once the lock has been released, which doesn't rely on the dec.
+	 * Perform the smp_store_release before clearing the lock entry so that
+	 * NMIs landing in the unlock path can correctly detect AA issues. The
+	 * opposite order shown below may lead to missed AA checks:
 	 *
-	 * Unlike smp_wmb(), release is not a two way fence, hence it is
-	 * possible for a inc to move up and reorder with our clearing of the
-	 * entry. This isn't a problem however, as for a misdiagnosis of ABBA,
-	 * the remote CPU needs to hold this lock, which won't be released until
-	 * the store below is done, which would ensure the entry is overwritten
-	 * to NULL, etc.
+	 * WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL)
+	 * <NMI>
+	 * res_spin_lock(A) --> missed AA, leads to timeout
+	 * </NMI>
+	 * smp_store_release(A->locked, 0)
 	 */
 	smp_store_release(&lock->locked, 0);
+	if (likely(rqh->cnt <= RES_NR_HELD))
+		WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL);
 	this_cpu_dec(rqspinlock_held_locks.cnt);
 }
 
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 3cc23d79a9fc..878d641719da 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -275,6 +275,10 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	int val, ret = 0;
 
 	RES_INIT_TIMEOUT(ts);
+	/*
+	 * The fast path is not invoked for the TAS fallback, so we must grab
+	 * the deadlock detection entry here.
+	 */
 	grab_held_lock_entry(lock);
 
 	/*
@@ -397,10 +401,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 		goto queue;
 	}
 
-	/*
-	 * Grab an entry in the held locks array, to enable deadlock detection.
-	 */
-	grab_held_lock_entry(lock);
+	/* Deadlock detection entry already held after failing fast path. */
 
 	/*
 	 * We're pending, wait for the owner to go away.
@@ -448,11 +449,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 queue:
 	lockevent_inc(lock_slowpath);
-	/*
-	 * Grab deadlock detection entry for the queue path.
-	 */
-	grab_held_lock_entry(lock);
-
+	/* Deadlock detection entry already held after failing fast path. */
 	node = this_cpu_ptr(&rqnodes[0].mcs);
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
-- 
2.51.0


