Return-Path: <bpf+bounces-49110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CC2A14315
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2694116B3BB
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D7424387D;
	Thu, 16 Jan 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKTDhrMz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED68241A1F;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058875; cv=none; b=XfCLYWhXvKtW+J+C50oDmdsd9I40ujePnznV4/lG7tp3MWB5SsDl2ESqyz+wrMvWpkWvrkxZH5rRflMVVN0l+K0AIg+YOZTLR3hDkM5hVlOGlsPQTqWxYQjnrxAJY1GXXMFkW+AYth+J2GAaTgPY4AqAcRL1nXYsCpRGpWGgP48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058875; c=relaxed/simple;
	bh=hrsr+dy0UX7JrwICmPPF02FwToFMAnvnsfZ5mUjMCj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BXG+F1OT9wczkOyDK3uJ+f/x3hfbKE3I8+/kdx236TbO9Gkv84USWxzxqnshqVxPF4xp/drCgqYmqOQHz+5SoUVO2RI6TwKA1DNXXFzVT32HryeQDKk2SVaMBmeHgvZWJbSNZRhEK+S/zER8VdJqkWSYK1OoXGh9M4pheMHVy+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKTDhrMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F37FC4AF14;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058875;
	bh=hrsr+dy0UX7JrwICmPPF02FwToFMAnvnsfZ5mUjMCj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dKTDhrMzyEhkZeJZHq5xCzxjkYR2DvIckBlL1NEOAFvXSbxHKGwdbwiCC0Lp1Y/m0
	 L9s2hrAcVsOsNc+7YZYfiAMk5K5DuYf6GPUy63K4dYXzMR6taEpa/hgO+qB+fdW1+A
	 bXgglhpSjYm56i456eJFflbPUpGmISClTxvzMbNxyr1KoanoKe/AfuBfBuNPMpUBF0
	 BAwk8qfmGDbpflKoingisk9LKZDKT3fe6QOZVk6AUSnLqy2UTNVF87GbNck4x4kL5T
	 CQYmvgXtL+RTVpJBr78eFbnX7Nxp7itT7t75z6Q0Li1gTohzu3Dw74F049FYC+ML3+
	 L4wvtd+IEnNVA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A10C3CE37DA; Thu, 16 Jan 2025 12:21:14 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu 13/17] srcu: Add SRCU-fast readers
Date: Thu, 16 Jan 2025 12:21:08 -0800
Message-Id: <20250116202112.3783327-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
References: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds srcu_read_{,un}lock_fast(), which is similar
to srcu_read_{,un}lock_lite(), but avoids the array-indexing and
pointer-following overhead.  On a microbenchmark featuring tight
loops around empty readers, this results in about a 20% speedup
compared to RCU Tasks Trace on my x86 laptop.

Please note that SRCU-fast has drawbacks compared to RCU Tasks
Trace, including:

o	Lack of CPU stall warnings.
o	SRCU-fast readers permitted only where rcu_is_watching().
o	A pointer-sized return value from srcu_read_lock_fast() must
	be passed to the corresponding srcu_read_unlock_fast().
o	In the absence of readers, a synchronize_srcu() having _fast()
	readers will incur the latency of at least two normal RCU grace
	periods.
o	RCU Tasks Trace priority boosting could be easily added.
	Boosting SRCU readers is more difficult.

SRCU-fast also has a drawback compared to SRCU-lite, namely that the
return value from srcu_read_lock_fast()-fast is a 64-bit pointer and
that from srcu_read_lock_lite() is only a 32-bit int.

[ paulmck: Apply feedback from Akira Yokosawa. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     | 47 ++++++++++++++++++++++++++++++++++++++--
 include/linux/srcutiny.h | 22 +++++++++++++++++++
 include/linux/srcutree.h | 38 ++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 2bd0e24e9b554..63bddc3014238 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -47,9 +47,10 @@ int init_srcu_struct(struct srcu_struct *ssp);
 #define SRCU_READ_FLAVOR_NORMAL	0x1		// srcu_read_lock().
 #define SRCU_READ_FLAVOR_NMI	0x2		// srcu_read_lock_nmisafe().
 #define SRCU_READ_FLAVOR_LITE	0x4		// srcu_read_lock_lite().
+#define SRCU_READ_FLAVOR_FAST	0x8		// srcu_read_lock_fast().
 #define SRCU_READ_FLAVOR_ALL   (SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
-				SRCU_READ_FLAVOR_LITE) // All of the above.
-#define SRCU_READ_FLAVOR_SLOWGP	SRCU_READ_FLAVOR_LITE
+				SRCU_READ_FLAVOR_LITE | SRCU_READ_FLAVOR_FAST) // All of the above.
+#define SRCU_READ_FLAVOR_SLOWGP	(SRCU_READ_FLAVOR_LITE | SRCU_READ_FLAVOR_FAST)
 						// Flavors requiring synchronize_rcu()
 						// instead of smp_mb().
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
@@ -253,6 +254,33 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
 	return retval;
 }
 
+/**
+ * srcu_read_lock_fast - register a new reader for an SRCU-protected structure.
+ * @ssp: srcu_struct in which to register the new reader.
+ *
+ * Enter an SRCU read-side critical section, but for a light-weight
+ * smp_mb()-free reader.  See srcu_read_lock() for more information.
+ *
+ * If srcu_read_lock_fast() is ever used on an srcu_struct structure,
+ * then none of the other flavors may be used, whether before, during,
+ * or after.  Note that grace-period auto-expediting is disabled for _fast
+ * srcu_struct structures because auto-expedited grace periods invoke
+ * synchronize_rcu_expedited(), IPIs and all.
+ *
+ * Note that srcu_read_lock_fast() can be invoked only from those contexts
+ * where RCU is watching, that is, from contexts where it would be legal
+ * to invoke rcu_read_lock().  Otherwise, lockdep will complain.
+ */
+static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *ssp) __acquires(ssp)
+{
+	struct srcu_ctr __percpu *retval;
+
+	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
+	retval = __srcu_read_lock_fast(ssp);
+	rcu_try_lock_acquire(&ssp->dep_map);
+	return retval;
+}
+
 /**
  * srcu_read_lock_lite - register a new reader for an SRCU-protected structure.
  * @ssp: srcu_struct in which to register the new reader.
@@ -356,6 +384,21 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
 	__srcu_read_unlock(ssp, idx);
 }
 
+/**
+ * srcu_read_unlock_fast - unregister a old reader from an SRCU-protected structure.
+ * @ssp: srcu_struct in which to unregister the old reader.
+ * @scp: return value from corresponding srcu_read_lock_fast().
+ *
+ * Exit a light-weight SRCU read-side critical section.
+ */
+static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
+	__releases(ssp)
+{
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
+	srcu_lock_release(&ssp->dep_map);
+	__srcu_read_unlock_fast(ssp, scp);
+}
+
 /**
  * srcu_read_unlock_lite - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 07a0c4489ea2f..380260317d98b 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -71,6 +71,28 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
 	return idx;
 }
 
+struct srcu_ctr;
+
+static inline bool __srcu_ptr_to_ctr(struct srcu_struct *ssp, struct srcu_ctr __percpu *scpp)
+{
+	return (int)(intptr_t)(struct srcu_ctr __force __kernel *)scpp;
+}
+
+static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ssp, int idx)
+{
+	return (struct srcu_ctr __percpu *)(intptr_t)idx;
+}
+
+static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct *ssp)
+{
+	return __srcu_ctr_to_ptr(ssp, __srcu_read_lock(ssp));
+}
+
+static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
+{
+	__srcu_read_unlock(ssp, __srcu_ptr_to_ctr(ssp, scp));
+}
+
 #define __srcu_read_lock_lite __srcu_read_lock
 #define __srcu_read_unlock_lite __srcu_read_unlock
 
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index ef3065c0cadcd..bdc467efce3a2 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -226,6 +226,44 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
 	return &ssp->sda->srcu_ctrs[idx];
 }
 
+/*
+ * Counts the new reader in the appropriate per-CPU element of the
+ * srcu_struct.  Returns a pointer that must be passed to the matching
+ * srcu_read_unlock_fast().
+ *
+ * Note that this_cpu_inc() is an RCU read-side critical section either
+ * because it disables interrupts, because it is a single instruction,
+ * or because it is a read-modify-write atomic operation, depending on
+ * the whims of the architecture.
+ */
+static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct *ssp)
+{
+	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
+	this_cpu_inc(scp->srcu_locks.counter); /* Y */
+	barrier(); /* Avoid leaking the critical section. */
+	return scp;
+}
+
+/*
+ * Removes the count for the old reader from the appropriate
+ * per-CPU element of the srcu_struct.  Note that this may well be a
+ * different CPU than that which was incremented by the corresponding
+ * srcu_read_lock_fast(), but it must be within the same task.
+ *
+ * Note that this_cpu_inc() is an RCU read-side critical section either
+ * because it disables interrupts, because it is a single instruction,
+ * or because it is a read-modify-write atomic operation, depending on
+ * the whims of the architecture.
+ */
+static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
+{
+	barrier();  /* Avoid leaking the critical section. */
+	this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
+}
+
 /*
  * Counts the new reader in the appropriate per-CPU element of the
  * srcu_struct.  Returns an index that must be passed to the matching
-- 
2.40.1


