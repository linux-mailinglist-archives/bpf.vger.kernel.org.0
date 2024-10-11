Return-Path: <bpf+bounces-41764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF15A99AA86
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29BE1C2157B
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 17:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3485B1CF5C6;
	Fri, 11 Oct 2024 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdlZy6mA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE771C57A3;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668373; cv=none; b=OAUpBWoAumTrsArgjfTPP1QkidesVjQ+tys4H7QqraFNctc17YJmw9oYSKoX0kjb3gcSNQjuAbA1IF27Ar+UX01r/Z2eOYqM4y35ByvwpuBDToecrRSpCxGB4gDCoiuUG1gYmqt6YIDDkgSf4VmyD9r8/hWWSMJ8CwiswH12auA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668373; c=relaxed/simple;
	bh=6e6nFQakYcsfA7al8QMxHMj/HwDI3C+Crb6uuY7zJh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZjY3P3y6/HNzu2mht73gGJld9RMexYdCYgdxaUFZKvmC73S5mMyurYuy9BeNK9avGSuYBBtrDxbCj6IxZfjCt9Q8lfIca9O6CtLgz5gsE02/oEa2eHt8BM432cWchdXwaK/marzOvqoZawx86KFtz9hq0tSM88WbJ4W4yU/ixXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdlZy6mA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE36C4CED3;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728668373;
	bh=6e6nFQakYcsfA7al8QMxHMj/HwDI3C+Crb6uuY7zJh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BdlZy6mALy1GU/borUcN8FIa2bdBq7bZyracfBiSN17DxNTdNPgBRlLta1OgYIid7
	 l32HcssoCmzAplwm+N3MfAhtl+oiccsITiX9G7CHsiZnyYu+nYKczaddwpAkcxVHwV
	 fnntxIzRaIfC21iPDchYIRVQwizCUxudRzA1L5FQaxdz4dhi+XS89XWn/4mj5BaMIK
	 i+MoeUGFThKx69Q7IgTdkBzJlVlZDgX0nBe7lbDFctcDNGo+rhK9e7QMxOn4OYePyy
	 x1D1/hm6CEYrF98hvr7rHPLmddpmOQi73tz8iBzQCh29UaFa/mu1YtrWVDPduGz0q2
	 2r8ML9aaFt4Eg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A490BCE0F51; Fri, 11 Oct 2024 10:39:32 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH v2 rcu 05/13] srcu: Standardize srcu_data pointers to "sdp" and similar
Date: Fri, 11 Oct 2024 10:39:23 -0700
Message-Id: <20241011173931.2050422-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
References: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit changes a few "cpuc" variables to "sdp" to align wiht usage
elsewhere.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     | 35 ++++++++++++++++++----------------
 include/linux/srcutree.h |  4 ++++
 kernel/rcu/srcutree.c    | 41 ++++++++++++++++++++--------------------
 3 files changed, 44 insertions(+), 36 deletions(-)

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
index abe55777c4335..4c51be484b48a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -438,9 +438,9 @@ static unsigned long srcu_readers_lock_idx(struct srcu_struct *ssp, int idx)
 	unsigned long sum = 0;
 
 	for_each_possible_cpu(cpu) {
-		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
+		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += atomic_long_read(&cpuc->srcu_lock_count[idx]);
+		sum += atomic_long_read(&sdp->srcu_lock_count[idx]);
 	}
 	return sum;
 }
@@ -456,14 +456,14 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
 	unsigned long sum = 0;
 
 	for_each_possible_cpu(cpu) {
-		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
+		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += atomic_long_read(&cpuc->srcu_unlock_count[idx]);
+		sum += atomic_long_read(&sdp->srcu_unlock_count[idx]);
 		if (IS_ENABLED(CONFIG_PROVE_RCU))
-			mask = mask | READ_ONCE(cpuc->srcu_reader_flavor);
+			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
 	}
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
-		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
+		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);
 	return sum;
 }
 
@@ -564,12 +564,12 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
 	unsigned long sum = 0;
 
 	for_each_possible_cpu(cpu) {
-		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
+		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += atomic_long_read(&cpuc->srcu_lock_count[0]);
-		sum += atomic_long_read(&cpuc->srcu_lock_count[1]);
-		sum -= atomic_long_read(&cpuc->srcu_unlock_count[0]);
-		sum -= atomic_long_read(&cpuc->srcu_unlock_count[1]);
+		sum += atomic_long_read(&sdp->srcu_lock_count[0]);
+		sum += atomic_long_read(&sdp->srcu_lock_count[1]);
+		sum -= atomic_long_read(&sdp->srcu_unlock_count[0]);
+		sum -= atomic_long_read(&sdp->srcu_unlock_count[1]);
 	}
 	return sum;
 }
@@ -703,20 +703,21 @@ EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
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
-		if (!old_reader_flavor_mask)
+	old_read_flavor = READ_ONCE(sdp->srcu_reader_flavor);
+	if (!old_read_flavor) {
+		old_read_flavor = cmpxchg(&sdp->srcu_reader_flavor, 0, read_flavor);
+		if (!old_read_flavor)
 			return;
 	}
-	WARN_ONCE(old_reader_flavor_mask != reader_flavor_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_reader_flavor_mask, reader_flavor_mask);
+	WARN_ONCE(old_read_flavor != read_flavor, "CPU %d old state %d new state %d\n", sdp->cpu, old_read_flavor, read_flavor);
 }
 EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
 #endif /* CONFIG_PROVE_RCU */
-- 
2.40.1


