Return-Path: <bpf+bounces-38794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7BB96A487
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C102884CE
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4104F190073;
	Tue,  3 Sep 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhyPEr/x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A5818E047;
	Tue,  3 Sep 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381200; cv=none; b=oI4rV0hOl1+EkHQRKR5CE6GkwA/a7vKlLaNjSAF0+N4s95SY0pTcXQz/07dwU9+Kh6hS6E8yKhLpXgZ1QEo1EgMaTk2ERIOVavw2hv9V7AdOmkUmdNv2nhXBSyrp4Xj1lrodixRss7s7KOQyPqpm3sNyovmpVRE17njjld0bt1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381200; c=relaxed/simple;
	bh=uZ8FSoNv6woJBQtNFGhSTh7NHvs/fzasqNHpDamjy0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WHv0xGVXe0e4b/lve0xSFEFK503utBZguxY0rblb6MzjqZ4UenjQzGJueukE9+TWufuIVa70cbTVSyUdyKLJjdQs4vLZFuDqvnskgm8P2LeaK1RNuxztyFsX4OIILPItRyCC9zWQ3FOyLSmcgSeaieVzh3KDVX6ew5eqJOjrkH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhyPEr/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2ADC4CED9;
	Tue,  3 Sep 2024 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725381199;
	bh=uZ8FSoNv6woJBQtNFGhSTh7NHvs/fzasqNHpDamjy0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MhyPEr/xtFd0wt6hfeZ17yOQZD1nOPfQerI0h0FuD5Vtdod6W39ilXwbB5wJ5fcgf
	 YK6fBBAl7bKpFlmbPcLSR7mIHOaG2W4+HKDWuHHrLHz4gijV83JnulESe7cD7ZlqYJ
	 hkINvHIL0XjUhqFXp4TwzoBAfN92Ee1X4L1JqkgFIJRSvIQx4GQNmDmWl3cxAcHS7l
	 r7iSG6pFQHJee1QQg5HcBi9nCc7OMGzl0r6DHe/zx++Z0nGaPM2YDpMKUb6X1T4Vxs
	 lT8kEM2P9kEwWTdVNckvw6l4mAHNXGNUt4wQhe99adzT/4s56f2xMY9jAWBLrqNDOZ
	 t3hxCZrtx1Upw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4A128CE25D8; Tue,  3 Sep 2024 09:33:19 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/11] srcu: Convert srcu_data ->srcu_reader_flavor to bit field
Date: Tue,  3 Sep 2024 09:33:13 -0700
Message-Id: <20240903163318.480678-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds SRCU_READ_FLAVOR_NORMAL and SRCU_READ_FLAVOR_NMI bit
definitions and uses them in preparation for adding a third SRCU reader
flavor.

While in the area, improve a few comments.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     | 35 +++++++++++++++++++----------------
 include/linux/srcutree.h |  4 ++++
 kernel/rcu/srcutree.c    | 22 +++++++++++-----------
 3 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 06728ef6f32a4..84daaa33ea0ab 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -176,10 +176,6 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
 
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
-#define SRCU_NMI_UNKNOWN	0x0
-#define SRCU_NMI_UNSAFE		0x1
-#define SRCU_NMI_SAFE		0x2
-
 #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_TREE_SRCU)
 void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
 #else
@@ -235,16 +231,19 @@ static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flav
  * a mutex that is held elsewhere while calling synchronize_srcu() or
  * synchronize_srcu_expedited().
  *
- * Note that srcu_read_lock() and the matching srcu_read_unlock() must
- * occur in the same context, for example, it is illegal to invoke
- * srcu_read_unlock() in an irq handler if the matching srcu_read_lock()
- * was invoked in process context.
+ * The return value from srcu_read_lock() must be passed unaltered
+ * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
+ * the matching srcu_read_unlock() must occur in the same context, for
+ * example, it is illegal to invoke srcu_read_unlock() in an irq handler
+ * if the matching srcu_read_lock() was invoked in process context.  Or,
+ * for that matter to invoke srcu_read_unlock() from one task and the
+ * matching srcu_read_lock() from another.
  */
 static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
 {
 	int retval;
 
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	retval = __srcu_read_lock(ssp);
 	srcu_lock_acquire(&ssp->dep_map);
 	return retval;
@@ -256,12 +255,16 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
  *
  * Enter an SRCU read-side critical section, but in an NMI-safe manner.
  * See srcu_read_lock() for more information.
+ *
+ * If srcu_read_lock_nmisafe() is ever used on an srcu_struct structure,
+ * then none of the other flavors may be used, whether before, during,
+ * or after.
  */
 static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp)
 {
 	int retval;
 
-	srcu_check_read_flavor(ssp, true);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
 	retval = __srcu_read_lock_nmisafe(ssp);
 	rcu_try_lock_acquire(&ssp->dep_map);
 	return retval;
@@ -273,7 +276,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
 {
 	int retval;
 
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	retval = __srcu_read_lock(ssp);
 	return retval;
 }
@@ -302,7 +305,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
 static inline int srcu_down_read(struct srcu_struct *ssp) __acquires(ssp)
 {
 	WARN_ON_ONCE(in_nmi());
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	return __srcu_read_lock(ssp);
 }
 
@@ -317,7 +320,7 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
 	__releases(ssp)
 {
 	WARN_ON_ONCE(idx & ~0x1);
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	srcu_lock_release(&ssp->dep_map);
 	__srcu_read_unlock(ssp, idx);
 }
@@ -333,7 +336,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 	__releases(ssp)
 {
 	WARN_ON_ONCE(idx & ~0x1);
-	srcu_check_read_flavor(ssp, true);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
 	rcu_lock_release(&ssp->dep_map);
 	__srcu_read_unlock_nmisafe(ssp, idx);
 }
@@ -342,7 +345,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 static inline notrace void
 srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx) __releases(ssp)
 {
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	__srcu_read_unlock(ssp, idx);
 }
 
@@ -359,7 +362,7 @@ static inline void srcu_up_read(struct srcu_struct *ssp, int idx)
 {
 	WARN_ON_ONCE(idx & ~0x1);
 	WARN_ON_ONCE(in_nmi());
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	__srcu_read_unlock(ssp, idx);
 }
 
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index ab7d8d215b84b..79ad809c7f035 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -43,6 +43,10 @@ struct srcu_data {
 	struct srcu_struct *ssp;
 };
 
+/* Values for ->srcu_reader_flavor. */
+#define SRCU_READ_FLAVOR_NORMAL	0x1		// srcu_read_lock().
+#define SRCU_READ_FLAVOR_NMI	0x2		// srcu_read_lock_nmisafe().
+
 /*
  * Node in SRCU combining tree, similar in function to rcu_data.
  */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 54ca2ea2b7d68..602b4b8c4b891 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -463,7 +463,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
 			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
 	}
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
-		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
+		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);
 	return sum;
 }
 
@@ -703,21 +703,21 @@ EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
  */
 void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 {
-	int reader_flavor_mask = 1 << read_flavor;
-	int old_reader_flavor_mask;
+	int old_read_flavor;
 	struct srcu_data *sdp;
 
-	/* NMI-unsafe use in NMI is a bad sign */
-	WARN_ON_ONCE(!read_flavor && in_nmi());
+	/* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flavor values. */
+	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());
+	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
+
 	sdp = raw_cpu_ptr(ssp->sda);
-	old_reader_flavor_mask = READ_ONCE(sdp->srcu_reader_flavor);
-	if (!old_reader_flavor_mask) {
-		old_reader_flavor_mask = cmpxchg(&sdp->srcu_reader_flavor, 0, reader_flavor_mask);
-		if (!old_reader_flavor_mask) {
+	old_read_flavor = READ_ONCE(sdp->srcu_reader_flavor);
+	if (!old_read_flavor) {
+		old_read_flavor = cmpxchg(&sdp->srcu_reader_flavor, 0, read_flavor);
+		if (!old_read_flavor)
 			return;
-		}
 	}
-	WARN_ONCE(old_reader_flavor_mask != reader_flavor_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_reader_flavor_mask, reader_flavor_mask);
+	WARN_ONCE(old_read_flavor != read_flavor, "CPU %d old state %d new state %d\n", sdp->cpu, old_read_flavor, read_flavor);
 }
 EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
 #endif /* CONFIG_PROVE_RCU */
-- 
2.40.1


