Return-Path: <bpf+bounces-64215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59ECB0FB6E
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 22:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EB016802D
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 20:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE9B238C0C;
	Wed, 23 Jul 2025 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwWC9rrb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8969235364;
	Wed, 23 Jul 2025 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302485; cv=none; b=PgeQ5IU9Y07kq6siSf2yPsSaWWMH8CIHOLN0DossCXzH6LvUE845FKwcoIb2J4lhG6tRQaSjI3moSo/N9qbaZNOI1xvRUs3B+DW9JzDo7BPWF70E3YO9scMk3plZi2QDCiyb/EoQ/3rWJ4QGVTby/GpRcoGg0COPy/O3gnN7HAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302485; c=relaxed/simple;
	bh=k8g0jWBk9ohluDjiSN174RWil2KT7b5UhHLGA4f02YM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cgNB0Eef0pai4jjPteiIrg4bYXkN95cDk2405NmsEjvFLot59RwUdohsn0DrgGtzx11pkM9a3AX/uwz9hdFWA1+YsAT+QGWzE8bpyjbyb1k+NGG7OSIXyWM1NVPj8qpPP4dN8vzaTMSH9qdWXQjrDuaR8tA4m6RP/D/k45G9hO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwWC9rrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C41EC4CEF7;
	Wed, 23 Jul 2025 20:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753302484;
	bh=k8g0jWBk9ohluDjiSN174RWil2KT7b5UhHLGA4f02YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwWC9rrb8U72UlBt9C4A/3Iy3aRM3G8rMuTvFchM3/mrj1qG8F2JgpQF5Ve5Gr0E5
	 +AVUan7jwZ58RXZA2nCbCHWcc6e3QD36WKWzA8/hrKGYuVBw/04Zo7bdeuBUhbsyXD
	 cnz0JjOIWptLRrfhDi2FVFQx158tw4FIbN4+ui5MpKBblt3U4N3MN2HwA9yhMCCMyB
	 7cUB9Om/EY9HTe1sb6W4fKsIDREcyG0ynALaxMNeITbItJy1bh+6Mv4Wu0PfPcPpkP
	 g1+hIfvHJqIgDH9XNgUmZax47Up71yTZI5Vvq5dIRIN8g36eYa8L6xAFvYFqhRNY38
	 wkbv7bvuOz1pg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 10DDBCE0CCE; Wed, 23 Jul 2025 13:28:04 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v4 5/6] srcu: Document __srcu_read_{,un}lock_fast() implicit RCU readers
Date: Wed, 23 Jul 2025 13:27:59 -0700
Message-Id: <20250723202800.2094614-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
References: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit documents the implicit RCU readers that are implied by the
this_cpu_inc() and atomic_long_inc() operations in __srcu_read_lock_fast()
and __srcu_read_unlock_fast().  While in the area, fix the documentation
of the memory pairing of atomic_long_inc() in __srcu_read_lock_fast().

[ paulmck: Apply Joel Fernandes feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcutree.h | 42 ++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 4d2fee4d38289..42098e0fa0b7d 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -232,9 +232,27 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
  * srcu_read_unlock_fast().
  *
  * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
- * critical sections either because they disables interrupts, because they
- * are a single instruction, or because they are a read-modify-write atomic
- * operation, depending on the whims of the architecture.
+ * critical sections either because they disables interrupts, because
+ * they are a single instruction, or because they are read-modify-write
+ * atomic operations, depending on the whims of the architecture.
+ * This matters because the SRCU-fast grace-period mechanism uses either
+ * synchronize_rcu() or synchronize_rcu_expedited(), that is, RCU,
+ * *not* SRCU, in order to eliminate the need for the read-side smp_mb()
+ * invocations that are used by srcu_read_lock() and srcu_read_unlock().
+ * The __srcu_read_unlock_fast() function also relies on this same RCU
+ * (again, *not* SRCU) trick to eliminate the need for smp_mb().
+ *
+ * The key point behind this RCU trick is that if any part of a given
+ * RCU reader precedes the beginning of a given RCU grace period, then
+ * the entirety of that RCU reader and everything preceding it happens
+ * before the end of that same RCU grace period.  Similarly, if any part
+ * of a given RCU reader follows the end of a given RCU grace period,
+ * then the entirety of that RCU reader and everything following it
+ * happens after the beginning of that same RCU grace period.  Therefore,
+ * the operations labeled Y in __srcu_read_lock_fast() and those labeled Z
+ * in __srcu_read_unlock_fast() are ordered against the corresponding SRCU
+ * read-side critical section from the viewpoint of the SRCU grace period.
+ * This is all the ordering that is required, hence no calls to smp_mb().
  *
  * This means that __srcu_read_lock_fast() is not all that fast
  * on architectures that support NMIs but do not supply NMI-safe
@@ -245,9 +263,9 @@ static inline struct srcu_ctr __percpu notrace *__srcu_read_lock_fast(struct src
 	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
 	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
-		this_cpu_inc(scp->srcu_locks.counter); /* Y */
+		this_cpu_inc(scp->srcu_locks.counter); // Y, and implicit RCU reader.
 	else
-		atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  /* Z */
+		atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  // Y, and implicit RCU reader.
 	barrier(); /* Avoid leaking the critical section. */
 	return scp;
 }
@@ -258,23 +276,17 @@ static inline struct srcu_ctr __percpu notrace *__srcu_read_lock_fast(struct src
  * different CPU than that which was incremented by the corresponding
  * srcu_read_lock_fast(), but it must be within the same task.
  *
- * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
- * critical sections either because they disables interrupts, because they
- * are a single instruction, or because they are a read-modify-write atomic
- * operation, depending on the whims of the architecture.
- *
- * This means that __srcu_read_unlock_fast() is not all that fast
- * on architectures that support NMIs but do not supply NMI-safe
- * implementations of this_cpu_inc().
+ * Please see the __srcu_read_lock_fast() function's header comment for
+ * information on implicit RCU readers and NMI safety.
  */
 static inline void notrace
 __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
 {
 	barrier();  /* Avoid leaking the critical section. */
 	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
-		this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
+		this_cpu_inc(scp->srcu_unlocks.counter);  // Z, and implicit RCU reader.
 	else
-		atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  /* Z */
+		atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  // Z, and implicit RCU reader.
 }
 
 void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
-- 
2.40.1


