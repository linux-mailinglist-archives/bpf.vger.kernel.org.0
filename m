Return-Path: <bpf+bounces-75750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3506DC934B3
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107953A942B
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208DE2EB860;
	Fri, 28 Nov 2025 23:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzdKzHEa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2107286D7E
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764372488; cv=none; b=kugKnOSbZRScjT2hsuXgxtKi7DjvmCXtfM5U2sKPaUD+4NnIAKvQu5AicZh1IycYY62emjJXtDNSCp9nM9P4Z1C/rWv68nHmtsE3hxHC4MnpeOzito7vAvDV7GMraGQRNRujTKWzHzAVv276H6TswgMSocrgHkd2OKcVysCkQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764372488; c=relaxed/simple;
	bh=Ibpko85BVIRzc4PjrfAyl1unRL0Edcd1ilY4dG4L1QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDH6tBAOGJNWv1xEx4NKDQrUYMjbZxeV5bMin6+RbnbIVORN5JeAnkH8SgLp23k+RQs+6DHLviu+nJpVaweOLAs6EzZhF+E6ImA/i0NV4q3dnT3+FORjgtSRu+nykDJ9ecJkjVIl574yaCa8swUYEkm6+DpXbx7fJbZ7k5RY9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzdKzHEa; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42b31507ed8so2120587f8f.1
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764372485; x=1764977285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Dc4P6IeHg5pmzZnpLJijme1vwm7plGkCX0k/qgIcqc=;
        b=PzdKzHEaEcaMXHsuaXf4anhj7NzRuhXSVrRRG8q9Dgf2v0idtxW6wMCE0PEt3hYQY+
         +NvaFE9hEC2+3RLzz40DS6p4VchZjowUqCReonW2jeNPx1aFi2xyOcgzdwz4bbTDZHr0
         Aldz6Deyh3bTTsFnQqOm4GJwE6/gpj2bcb/Q4ggRsYrltga+G4tWLn0FMjuZo93/af5P
         TIDWrHZCWD23CYIfccTIcL4QP+UI5F2F1aRqAonAQqEHECfETuXXH4PUkCnCfQLdL/HM
         qO0BVDtvW5COmgxeaEdJDqFebJJFhiEmv//vx+tMas4aDCFYk7tCjPYqV8cWXXV/MeyB
         rNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764372485; x=1764977285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Dc4P6IeHg5pmzZnpLJijme1vwm7plGkCX0k/qgIcqc=;
        b=XpAn0ptjcGZFXFet+vgnGXW94gV8FOVKToaZIIpzE2Rjc6wv36pICRJP5A/0AZGPFQ
         bBxg1X1yTvKHTmVZXMRvYe1E/ihNFaoskJVPYlcs0neAE1dEIOqHc1TWy89u0+Z8kVxY
         QsZnxlY6MPpwMd5r9t06YLBeuIewsAu4yq+QliBkexj2dJrV4zj3sR6u0Bjdd2WjNHMx
         cmrwVycrmllDYAgZO0sgxw93YAV/ki6XEkcN3aQ+1WB4dsE5uIrFLa6UTPiUo+2eZEUi
         /w/VYYV8+17FKJ5wv7cJK3OsMn8CHEdiyxR/ABKZvEqwky79v5LiMPxWtsQ5ckwFezdx
         PdIA==
X-Gm-Message-State: AOJu0YyinzzH3doY43euLNaiDZEoB+i8u8tZcT6+8rWEiHEz2Qq1qKQE
	JYCMYaIb+rrFDG/qm3Vo6Z20KqXfy+6N6a5Nv34537kXp+G/dcboYZUbw+Ygc86g
X-Gm-Gg: ASbGncs7jbe3qVn3Mr/e7y2pSOPzCv577i02KCPIQL9ANp0WJD7CdYLh6m6MpIc9eTc
	XJuSLMAjJQ50TkRJGX/ikgWLlmP2RFRXIFvp6gsqIquOndi65yVEwWNaHQXskZD7zFw0O1TFstu
	hTMQq5RWMXnmOWuQipl+6HGW8KvzpvqwghzZX3C4qEbP9wKVXvgdwXjMVNfvoVPYrBgoMyWkOW0
	XQXfqP6qbIRGAXkm03ZnGfmHdvnNm6Zy8imgIMoJ63MmiwznoeRNdIxGXu+1BFK2w5QvLYSa9Ef
	6vhG/xgsr7usn4b38jfLm4RRM4Z2R59STv3LQ4KJflyaBVku9dOY/qM6LZ4oOzn9ssqVtKWUUVL
	R4Hp17a7+QzdiKF48e/heX6ER49Maqc/QI6ymjjeb+7czPYY8IosCcHBkLqGze/ngJX1QRWcvoq
	KNNzM5UDHCsHjBeJX+3l74VBOOhqqMvxE1pG6rhLVtELdiay/iXYYUeQ+JLOGEy5iF
X-Google-Smtp-Source: AGHT+IF6G1EXhdLJi+w81Ws+wGzKqLvdjqEN9UOGRcbn4Qx1La5WSAhcXzaVIXSlItkN++adWlV8Hg==
X-Received: by 2002:a05:6000:26cf:b0:42b:3455:e4a4 with SMTP id ffacd0b85a97d-42e0f349251mr19481689f8f.31.1764372484767;
        Fri, 28 Nov 2025 15:28:04 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42e1c5c3c8csm14913812f8f.2.2025.11.28.15.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 15:28:04 -0800 (PST)
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
Subject: [PATCH bpf-next v2 1/6] rqspinlock: Enclose lock/unlock within lock entry acquisitions
Date: Fri, 28 Nov 2025 23:27:57 +0000
Message-ID: <20251128232802.1031906-2-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128232802.1031906-1-memxor@gmail.com>
References: <20251128232802.1031906-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8491; i=memxor@gmail.com; h=from:subject; bh=Ibpko85BVIRzc4PjrfAyl1unRL0Edcd1ilY4dG4L1QY=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpKi/wkYfpg+k1DLHDHRdZCm8p27GzOMntbdG0a PSo8o+JkmyJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSov8AAKCRBM4MiGSL8R yiS0D/9GevxOb7wqisubNhRDZ8D+0vlHqx3L9CjVAzJjrLvfn7u8Uk4DKwgK24TXY9LHlyGVxVz /HpUO+l+Xz+VEeGll9xV5Dl5DJknV5cT3yPZKrh+3+32r7obPW9cV1YkOuAdy5V+RPx9CIZ8DEN RAGILAMTl2lzUWzj7FW26s1W/mDA5TxsVQYpZJg1v2qKL2AwlBvz/Z4ugjLxuhurHU6srU2kSZ5 +IBeob98o1UHuf5UxjMXX7RqoHqjhkvm6jtVKvafMG87XBp3h55qaOkWnHcRMSL8fQKaiYw7TDn dVYZv9RJaegdXke7sX5SU5msV4U7Ab8ATrI99DF8jYmRQ39/VJsNShF3IfMacqMv8uRl8RoH1mF jRXs8Wl/o/dPzc66QFaOEOd4afwsSiDe24x6VkZfa1WtZHS5oU69KEkxAb0GSiYHpuwiE8SeJA0 c+1TtC+zjs6n12DcP5+sBKXq66S0ZJ7ZfzecUtBJppecQ+0Ax+frl0CCJjmQc/egQrKyZAtpWUe OAV0PIXVyMDFJE0GMwen31UEEef8F+xQJDuzjOX37b3ty/fvyJKMgK+bYNwFEIUAE8x14FrnOp4 AO4VrcoUo5hOdGZcEK79VnZn6547PyNTw6F2UBiMN6+BCB3LEC8JEXq5km3H8bEPeJR1B0S4+fe fhNtlNF8T/BIYqA==
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


