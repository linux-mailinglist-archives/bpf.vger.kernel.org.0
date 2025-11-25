Return-Path: <bpf+bounces-75498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F15A6C87130
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 21:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CC03B4C12
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 20:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD94E19FA93;
	Tue, 25 Nov 2025 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxGDG00K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A58EED8
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102781; cv=none; b=m5u0ft81DxyHZe6tcgpzuPT7kP/JXIDHUGhpHjhSXdgAa31tTQz46up31ZaE0d+1PFN0YIC52R5pfGkne4ezYbO2WHoHh0aKCAGpGBjQx1bVC+2Af62Xy5zt4lDNZxXKEDE6uhSQDbLmuzb9hazJhG4O6P4EDnSejy57A7B7JPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102781; c=relaxed/simple;
	bh=4Yun8tnLQDGR1EzlmjMxXyjl7Ni7ijcYU88jzfvsOR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VWOdozt/yYttXwnE1ZdQGQ6mKcy94EFJsXl9BzsC/ClnC0cLmoWzsMXWeNpCf/lVW+QuGKc0LawSs5rzfZmWT6A38mJJ9CGejZokhKangJaZ5jK11oyTvNaDJTeuJlM/ep+RnzvpE5G2hRpXNUWXGqPF2VldLI75w7zpn160JKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxGDG00K; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso1224725e9.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 12:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764102777; x=1764707577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z4jnZIVZPYtoVtZahchE7WfwB0KIAwLgloX8m1Cm5lo=;
        b=QxGDG00KycdobOHHQTQE7P/kQJWowWalL9o8LUHoAqnUMp/hYTkv1yAmTYvcDb3FLC
         TAhrEgKxnPtU49mE4Ev8u7ozZK0ZhzWARoVjP7PDCbUPtwwb3Vua8mz/nv3Y95hpM8sz
         8vrQlgP+CnnyOsfgam+Utgo8ks4jChE1cWQ4QxCN2BnaIWHMB/50Eadz6ZOEl0SEbVf9
         dHYDLG5En7la8ZMVjKQ0ooBpzkUqyOX1si4DsBZaUZQBxaiq0XZrzApERVHOMj9ggZ/p
         9/cRa39NWBNRglkZyOoPr10Y1ijExX1bBL7S+0lbX8NJoFwKT7rYd+ED9Spk5kJ/YxdQ
         XhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764102777; x=1764707577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4jnZIVZPYtoVtZahchE7WfwB0KIAwLgloX8m1Cm5lo=;
        b=mSdd12omErBfkO8klj/KJS6/0w5YfNTmrSC0eZM4/nqwVYJExrGgz9hj7ABiSxFt2p
         yghko86I7TnWuo6wDsiI2OAKrj1pCXdnXNnnqCwUy6OwSgpYcpn9JSe6+HwKuQcFGZnN
         kTFKMRzRipnZrb+SDN3DX5POsmh+S2JEykIUO1VqeH+lxhMdA/lVvjGHyOjPeuqklvVo
         1dvY15vxDa7nXpGdNUzE86DIKJ3S+AbbvU4QR0x2PEByxahmTCdpAtxIyIzakGwMIfoe
         xh96V1hIBpCK+Nbg7UsQcsJUovbBop6CqyVjL6F8lOGlhTl2divWBQS60xvQ4uEj+bSE
         RyUQ==
X-Gm-Message-State: AOJu0YyG/egFdLuyk9WY6sd7IhpPCVZxg/FK4oMNW2J673Mgc/L+FEuO
	Owc9Zb1VEmYzPle2V9kLn2CqYX2VJ4IBuBMIecslSxuQB+aJ7yjUAyFy7MLzTRlM
X-Gm-Gg: ASbGncuaScUNVPd9WDAclQRJK/VOK3OFZXFPP0Gyj++8HcC6L6OebL+KbTxGGXzFYFC
	w19fiBQ5l704DIhn62dRNuaCE4ZyIhSuLWmTNG+Jzvlewve9FJtw0DnaMp8iYFFdgctOg0uBPlR
	gPCennxIHdOSrE+naoemHXEoQA1o/7vB6hTCA4qVTKVxoHZk0JX9nl2Ur17Z0WlNKFg40cFIAEw
	Owyw00y585mJtXZlcWJTGx4TACTe/PYf0BkX90hg7QHAJKJTmyrwSUfMITmQTGAZhSHXiGAAzmU
	g0V9ouBL4k6uOUmZEYGbHZX2GlkEnWQHL6opiFZwuHT2zE60yV7oCme+xTI/N88MJFgGBzxKEz/
	78fWJAT3ReeGQfo1Hth18lOIsiI6y0wlimGKGCaY4SY2CAYlaILdEQIuTfrqkOjnzMqWjP2u83d
	cFwwFqwLAQEtn6i/mb75qhU/Am2GZf4XVRCSyzr6TJwW5JHODfn0PfB5eMj/nQ6C+7
X-Google-Smtp-Source: AGHT+IFHz2HtvTRinoojchaSLsd3uCPJTcfAFQAukD+g7Pk7BChvX35H9Hw3hoDS3Ob0+4FxoK4B2Q==
X-Received: by 2002:a05:6000:2008:b0:429:d253:8619 with SMTP id ffacd0b85a97d-42cba63b310mr24042162f8f.5.1764102777154;
        Tue, 25 Nov 2025 12:32:57 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42cb7fa3a6bsm35992961f8f.28.2025.11.25.12.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 12:32:56 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>,
	Jelle van der Beek <jelle@superluminal.eu>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1] rqspinlock: Enclose lock/unlock within lock entry acquisitions
Date: Tue, 25 Nov 2025 20:32:52 +0000
Message-ID: <20251125203253.3287019-1-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently have a tiny window between the fast-path cmpxchg and the
grabbing of the lock entry where an NMI could land, attempt the same
lock that was just acquired, and end up timing out. This is not ideal.
Instead, move the lock entry acquisition from the fast path to before
the cmpxchg, and remove the grabbing of the lock entry in the slow path,
assuming it was already taken by the fast path.

There is a similar case when unlocking the lock. If the NMI lands
between the WRITE_ONCE and smp_store_release, it is possible that we end
up in a situation where the NMI fails to diagnose the AA condition,
leading to a timeout.

The TAS fallback is invoked directly without being preceded by the
typical fast path, therefore we must continue to grab the deadlock
detection entry in that case.

Note the changes to the comments in release_held_lock_entry and
res_spin_unlock. They talk about prevention of the following scenario,
which is introduced by this commit, and was avoided by placing
smp_store_release after WRITE_ONCE (the case before this commit):

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

If the store release were placed after the WRITE_ONCE, the other CPU
would not observe B in the table of the CPU unlocking the lock B.

Avoiding this while it was convenient was a prudent choice, but since it
leads to missed diagnosis of AA deadlocks in case of NMIs, it does not
make sense to keep such ordering any further. Moreover, while this
particular schedule is a misdiagnosis, the CPUs are obviously
participating in an ABBA deadlock otherwise, and are only lucky to avoid
an error before due to the aforementioned race.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h | 66 ++++++++++++++++++--------------
 kernel/bpf/rqspinlock.c          | 15 +++-----
 2 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 6d4244d643df..2da3f1391914 100644
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
@@ -175,10 +170,16 @@ static __always_inline int res_spin_lock(rqspinlock_t *lock)
 {
 	int val = 0;

-	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL))) {
-		grab_held_lock_entry(lock);
+	/*
+	 * Grab the deadlock detection entry before doing the cmpxchg, so that
+	 * reentrancy due to NMIs between the succeeding cmpxchg and creation of
+	 * held lock entry can correctly detect an acquisition attempt in the
+	 * interrupted context.
+	 */
+	grab_held_lock_entry(lock);
+
+	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
 		return 0;
-	}
 	return resilient_queued_spin_lock_slowpath(lock, val);
 }

@@ -192,28 +193,35 @@ static __always_inline void res_spin_unlock(rqspinlock_t *lock)
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
+	 */
+	smp_store_release(&lock->locked, 0);
+	if (likely(rqh->cnt <= RES_NR_HELD))
+		WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL);
+	/*
+	 * Unlike release_held_lock_entry, we do the lock word release before
+	 * rewriting the entry back to NULL, and place no ordering between the
+	 * WRITE_ONCE and dec, and possible reordering with grabbing an entry.
+	 *
+	 * This opens up a window where another CPU could acquire this lock, and
+	 * then observe it in our table on the current CPU, leading to possible
+	 * misdiagnosis of ABBA when we get reordered with a
+	 * grab_held_lock_entry's writes (see the case described in
+	 * release_held_lock_entry comments).
 	 *
-	 * Like release_held_lock_entry, we can do the release before the dec.
-	 * We simply care about not seeing the 'lock' in our table from a remote
-	 * CPU once the lock has been released, which doesn't rely on the dec.
+	 * This could be avoided if we did the smp_store_release right before
+	 * the dec, ensuring that the remote CPU could only acquire this lock
+	 * and never observe this lock in our table.
 	 *
-	 * Unlike smp_wmb(), release is not a two way fence, hence it is
-	 * possible for a inc to move up and reorder with our clearing of the
-	 * entry. This isn't a problem however, as for a misdiagnosis of ABBA,
-	 * the remote CPU needs to hold this lock, which won't be released until
-	 * the store below is done, which would ensure the entry is overwritten
-	 * to NULL, etc.
+	 * However, that opens up a window where reentrant NMIs on this same
+	 * CPU could have their AA heuristics fail to fire if they land between
+	 * the WRITE_ONCE and unlock release store, which would result in a
+	 * timeout.
 	 */
-	smp_store_release(&lock->locked, 0);
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


