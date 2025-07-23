Return-Path: <bpf+bounces-64211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCDFB0FB6B
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 22:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43EA34E7F9E
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 20:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395582376F2;
	Wed, 23 Jul 2025 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpiNV+af"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2F2230270;
	Wed, 23 Jul 2025 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302484; cv=none; b=Hs1HilbWcEjDA0ADOT0tDHE0YdSQQrPD0piuf0glCT+Uqdume09oMRfVTnNaPHj7EJawBLOMq0mz7tOJ/1xca/eJQRYNzsnnwP9EDXQNDvuQk9T5dvRYTu02C9Sxrnp6f9XJEBh8G6fLw5j2Dyhdkca+4yHL4NyKpgXIm6pOJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302484; c=relaxed/simple;
	bh=lzk8+M42krZ085WSr7goKl4MCdBBd1jt58dCcDBT3cQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c1UXzYtmmz4EqEJnO9CiPEGiykbw8mWGf0SeFP4w6K9XWJW7qh3hKKGHWKP9ac/Y7lNuYe1/MmZ3aKIcUlN+iQeMAhydWVETAKX82TB3HPSy0eSna63/sKEWvV2adNuZkutiQEa58rEUiA/s0rhuZaw5Tq+7XtDhNIXrNbvha54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpiNV+af; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6450FC4CEF5;
	Wed, 23 Jul 2025 20:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753302484;
	bh=lzk8+M42krZ085WSr7goKl4MCdBBd1jt58dCcDBT3cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JpiNV+afh1sv0cYlij3GUzzM9e7igMaXxFL73qtxfaAmQjt5lJMSUcJj25FhmzQSN
	 vXJL9JgAMeojE4CgTSOi/DPfAEk79MeB7X1/zvV/NYbdgmEd0yBHguQ6b+MnZuI03H
	 dpg1UM8QTYjMeWle+bHxHv74Ug8zx023cOOSTF808PRBTDcZW+ROwTISTXGGesDPd9
	 TpwF9mGCpRz9+zOk6sEDLE11TZIWmM+9h392R+Snll9PO63Y75gGHRIhhSkudlbC5C
	 GB+n2O7AR8GEMMhN2spWvXd5xcvS4CDJON3+zhQclrVlchRDYg8O1N4uxlLE5jlC0W
	 kWn+atHdK4k/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 084F6CE0928; Wed, 23 Jul 2025 13:28:04 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v4 2/6] srcu: Add srcu_read_lock_fast_notrace() and srcu_read_unlock_fast_notrace()
Date: Wed, 23 Jul 2025 13:27:56 -0700
Message-Id: <20250723202800.2094614-2-paulmck@kernel.org>
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

This commit adds no-trace variants of the srcu_read_lock_fast() and
srcu_read_unlock_fast() functions for tracing use.

[ paulmck: Apply notrace feedback from Joel Fernandes, Steven Rostedt, and Mathieu Desnoyers. ]

Link: https://lore.kernel.org/all/20250721162433.10454-1-paulmck@kernel.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     | 30 ++++++++++++++++++++++++++++--
 include/linux/srcutree.h |  5 +++--
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 478c73d067f7d..ec3b8e27d6c5a 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -271,7 +271,7 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
  * where RCU is watching, that is, from contexts where it would be legal
  * to invoke rcu_read_lock().  Otherwise, lockdep will complain.
  */
-static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *ssp) __acquires(ssp)
+static inline struct srcu_ctr __percpu notrace *srcu_read_lock_fast(struct srcu_struct *ssp) __acquires(ssp)
 {
 	struct srcu_ctr __percpu *retval;
 
@@ -282,6 +282,20 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
 	return retval;
 }
 
+/*
+ * Used by tracing, cannot be traced and cannot call lockdep.
+ * See srcu_read_lock_fast() for more information.
+ */
+static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_struct *ssp)
+	__acquires(ssp)
+{
+	struct srcu_ctr __percpu *retval;
+
+	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
+	retval = __srcu_read_lock_fast(ssp);
+	return retval;
+}
+
 /**
  * srcu_down_read_fast - register a new reader for an SRCU-protected structure.
  * @ssp: srcu_struct in which to register the new reader.
@@ -385,7 +399,8 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
  *
  * Exit a light-weight SRCU read-side critical section.
  */
-static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
+static inline void notrace
+srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
 	__releases(ssp)
 {
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
@@ -394,6 +409,17 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
 }
 
+/*
+ * Used by tracing, cannot be traced and cannot call lockdep.
+ * See srcu_read_unlock_fast() for more information.
+ */
+static inline void srcu_read_unlock_fast_notrace(struct srcu_struct *ssp,
+						 struct srcu_ctr __percpu *scp) __releases(ssp)
+{
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
+	__srcu_read_unlock_fast(ssp, scp);
+}
+
 /**
  * srcu_up_read_fast - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 043b5a67ef71e..4d2fee4d38289 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -240,7 +240,7 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
  * on architectures that support NMIs but do not supply NMI-safe
  * implementations of this_cpu_inc().
  */
-static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct *ssp)
+static inline struct srcu_ctr __percpu notrace *__srcu_read_lock_fast(struct srcu_struct *ssp)
 {
 	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
@@ -267,7 +267,8 @@ static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct
  * on architectures that support NMIs but do not supply NMI-safe
  * implementations of this_cpu_inc().
  */
-static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
+static inline void notrace
+__srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
 {
 	barrier();  /* Avoid leaking the critical section. */
 	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
-- 
2.40.1


