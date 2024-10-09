Return-Path: <bpf+bounces-41464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA8B99741C
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 20:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0168B24987
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674C21E22E9;
	Wed,  9 Oct 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVxpN3Ox"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54471E1A16;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497241; cv=none; b=JbFWFJAQxbOcAsncxPnL6Z85iGhe86Vpb/pYvjOwC/CmximE+xhROF6HHPMokEhYFMRgzQ4xCt3jRaDCJ0O/J3bvfR9fgMFgsLruSJdk/xksSOOQIPsVLpbAbZ4aIqmn8DWtdhT+XXZ/fkVPmBj740McqOhodKnAjK4D57O2zBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497241; c=relaxed/simple;
	bh=Zx5VaivUvDu8VT1tnLqC/VtTV/C14Gn+/PcOHscidtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C5t7q9XTLzPMhkCf/fbhEqW5WMRPW5fG98RTYfKPGNQwC9r8bFvX2vS4nO3W2ylIw5kUBAEkDN9NeFsyMYxQXkT/yCJtRCx4jphQpgCetTmMUvMD9Gst6IynbtLp3w0f+70W5h3ciOayN1PESDVOwsi0F0QrPZm7dyYLG/4J6YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVxpN3Ox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD01C4AF0D;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497241;
	bh=Zx5VaivUvDu8VT1tnLqC/VtTV/C14Gn+/PcOHscidtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVxpN3Oxt7MZHy2pIUddMKwaIsF9KkfyYu9iV3VFdo2v46VNeIbHSBuWvTy8NJP0p
	 IzLXl5eGvNE5k8vir5aGQMdQ22HnZKCn0ASWwLV9hC5oAxm6GCfQFAEbFx0p0vkfS6
	 XjI14t3HsCia6NRnyFNZk15f0VGPhNIsHoNFgJrNJbWJsW25zqBC9xpn2sb5pdk1J3
	 YWt3uFAiLUbP785/9ZueUZNIwI8f5wMF6L1g5ONLRxpKKq6o0aXWe6B4YqkXsf5oA/
	 uZvXDmGWoyMiarxnZd7+fEXyK2Kav3hhDQE01e8Rwa1yXwI0F0Uxtu2CdibenPmmHr
	 /BkG844QD5Jtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 154CBCE0BB1; Wed,  9 Oct 2024 11:07:21 -0700 (PDT)
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
Subject: [PATCH rcu 03/12] srcu: Renaming in preparation for additional reader flavor
Date: Wed,  9 Oct 2024 11:07:10 -0700
Message-Id: <20241009180719.778285-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there are only two flavors of readers, normal and NMI-safe.
A number of fields, functions, and types reflect this restriction.
This renaming-only commit prepares for the addition of light-weight
(as in memory-barrier-free) readers.  OK, OK, there is also a drive-by
white-space fixeup!

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     | 21 ++++++++++-----------
 include/linux/srcutree.h |  2 +-
 kernel/rcu/srcutree.c    | 22 +++++++++++-----------
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 835bbb2d1f88a..06728ef6f32a4 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -181,10 +181,9 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
 #define SRCU_NMI_SAFE		0x2
 
 #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_TREE_SRCU)
-void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe);
+void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
 #else
-static inline void srcu_check_nmi_safety(struct srcu_struct *ssp,
-					 bool nmi_safe) { }
+static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor) { }
 #endif
 
 
@@ -245,7 +244,7 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
 {
 	int retval;
 
-	srcu_check_nmi_safety(ssp, false);
+	srcu_check_read_flavor(ssp, false);
 	retval = __srcu_read_lock(ssp);
 	srcu_lock_acquire(&ssp->dep_map);
 	return retval;
@@ -262,7 +261,7 @@ static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp
 {
 	int retval;
 
-	srcu_check_nmi_safety(ssp, true);
+	srcu_check_read_flavor(ssp, true);
 	retval = __srcu_read_lock_nmisafe(ssp);
 	rcu_try_lock_acquire(&ssp->dep_map);
 	return retval;
@@ -274,7 +273,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
 {
 	int retval;
 
-	srcu_check_nmi_safety(ssp, false);
+	srcu_check_read_flavor(ssp, false);
 	retval = __srcu_read_lock(ssp);
 	return retval;
 }
@@ -303,7 +302,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
 static inline int srcu_down_read(struct srcu_struct *ssp) __acquires(ssp)
 {
 	WARN_ON_ONCE(in_nmi());
-	srcu_check_nmi_safety(ssp, false);
+	srcu_check_read_flavor(ssp, false);
 	return __srcu_read_lock(ssp);
 }
 
@@ -318,7 +317,7 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
 	__releases(ssp)
 {
 	WARN_ON_ONCE(idx & ~0x1);
-	srcu_check_nmi_safety(ssp, false);
+	srcu_check_read_flavor(ssp, false);
 	srcu_lock_release(&ssp->dep_map);
 	__srcu_read_unlock(ssp, idx);
 }
@@ -334,7 +333,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 	__releases(ssp)
 {
 	WARN_ON_ONCE(idx & ~0x1);
-	srcu_check_nmi_safety(ssp, true);
+	srcu_check_read_flavor(ssp, true);
 	rcu_lock_release(&ssp->dep_map);
 	__srcu_read_unlock_nmisafe(ssp, idx);
 }
@@ -343,7 +342,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 static inline notrace void
 srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx) __releases(ssp)
 {
-	srcu_check_nmi_safety(ssp, false);
+	srcu_check_read_flavor(ssp, false);
 	__srcu_read_unlock(ssp, idx);
 }
 
@@ -360,7 +359,7 @@ static inline void srcu_up_read(struct srcu_struct *ssp, int idx)
 {
 	WARN_ON_ONCE(idx & ~0x1);
 	WARN_ON_ONCE(in_nmi());
-	srcu_check_nmi_safety(ssp, false);
+	srcu_check_read_flavor(ssp, false);
 	__srcu_read_unlock(ssp, idx);
 }
 
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index ed57598394de3..ab7d8d215b84b 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -25,7 +25,7 @@ struct srcu_data {
 	/* Read-side state. */
 	atomic_long_t srcu_lock_count[2];	/* Locks per CPU. */
 	atomic_long_t srcu_unlock_count[2];	/* Unlocks per CPU. */
-	int srcu_nmi_safety;			/* NMI-safe srcu_struct structure? */
+	int srcu_reader_flavor;			/* Reader flavor for srcu_struct structure? */
 
 	/* Update-side state. */
 	spinlock_t __private lock ____cacheline_internodealigned_in_smp;
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index e29c6cbffbcb0..18f2eae5e14bd 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -460,7 +460,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
 
 		sum += atomic_long_read(&cpuc->srcu_unlock_count[idx]);
 		if (IS_ENABLED(CONFIG_PROVE_RCU))
-			mask = mask | READ_ONCE(cpuc->srcu_nmi_safety);
+			mask = mask | READ_ONCE(cpuc->srcu_reader_flavor);
 	}
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask >> 1)),
 		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
@@ -699,25 +699,25 @@ EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
 
 #ifdef CONFIG_PROVE_RCU
 /*
- * Check for consistent NMI safety.
+ * Check for consistent reader flavor.
  */
-void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
+void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 {
-	int nmi_safe_mask = 1 << nmi_safe;
-	int old_nmi_safe_mask;
+	int reader_flavor_mask = 1 << read_flavor;
+	int old_reader_flavor_mask;
 	struct srcu_data *sdp;
 
 	/* NMI-unsafe use in NMI is a bad sign */
-	WARN_ON_ONCE(!nmi_safe && in_nmi());
+	WARN_ON_ONCE(!read_flavor && in_nmi());
 	sdp = raw_cpu_ptr(ssp->sda);
-	old_nmi_safe_mask = READ_ONCE(sdp->srcu_nmi_safety);
-	if (!old_nmi_safe_mask) {
-		WRITE_ONCE(sdp->srcu_nmi_safety, nmi_safe_mask);
+	old_reader_flavor_mask = READ_ONCE(sdp->srcu_reader_flavor);
+	if (!old_reader_flavor_mask) {
+		WRITE_ONCE(sdp->srcu_reader_flavor, reader_flavor_mask);
 		return;
 	}
-	WARN_ONCE(old_nmi_safe_mask != nmi_safe_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_nmi_safe_mask, nmi_safe_mask);
+	WARN_ONCE(old_reader_flavor_mask != reader_flavor_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_reader_flavor_mask, reader_flavor_mask);
 }
-EXPORT_SYMBOL_GPL(srcu_check_nmi_safety);
+EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
 #endif /* CONFIG_PROVE_RCU */
 
 /*
-- 
2.40.1


