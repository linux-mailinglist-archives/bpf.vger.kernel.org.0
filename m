Return-Path: <bpf+bounces-68768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F260B84138
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 12:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8453E18877AA
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724962F5A1A;
	Thu, 18 Sep 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTytjL4A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6E287242;
	Thu, 18 Sep 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191207; cv=none; b=r7QoC4lHtLTQ2FMmYd1JGqVyqPUpywX0U5BNlPKsdSWnrO+3+XPfLkcrMw8lygHco8FU+dxU8niQpcUxfTgCR+g4oxKUvqayMRL283MGR6hDT0QQbid98UJK74F7EfEl41NCJLF9VhEllGdV7V/e9+ORrqxwAAfHQ+BJUlgF3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191207; c=relaxed/simple;
	bh=jDxGNAMMOCyH7qVFbWf8yWfHDDI/sC4nlnOnRxPII+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=krN2GeiaXk6UG5rbrmu7jMs3kzwDLrZTkr44EtW3sW2rWwRLHcW4Y2JDf3Xf9fdRq82LOt9Fj1is7ZdFm5RnJstyLa7xb5jLRGHZ5mSXlaIBiY3oiX0JX7XX5ThfkH26KMmP6KkR1wilZ+2gLy+0qdAyPrdOrytfDWUlAmIUXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTytjL4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704C0C4CEEB;
	Thu, 18 Sep 2025 10:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191207;
	bh=jDxGNAMMOCyH7qVFbWf8yWfHDDI/sC4nlnOnRxPII+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UTytjL4A4BgUDBzqbbX7my/OQWfUASU6stKhOT01kx3j1TDlEH3jwA5Y/UsmZZSy5
	 hHAaO5iQt+mYr6KJJGMX/B7JnimnZsZG1KB4A3hnJptRQwNCkENgSsxOmKF+7fUp8E
	 1/qfsIfm5ko9e+3dBAiXB52lcsg7tIsV5ZhVgBjUv14NV+xgdzPFMpX4A8Qk5B4WHQ
	 DtyzKd+n6Yzr9yd+jCz6EyvEOojjRzsU2ue1LPSw8CwxuI38bhImvGsCImv7ONJkHr
	 mw7lDU7VA2RsodEUyPJW3tFiQUL44JvVqy0Ug0ns3b7MVxGPuyxdpy1d8jqZFd3IlZ
	 8OArLEanKS3xw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E6B9FCE0D66; Thu, 18 Sep 2025 03:26:46 -0700 (PDT)
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
Subject: [PATCH v2 2/6] srcu: Add srcu_read_lock_fast_notrace() and srcu_read_unlock_fast_notrace()
Date: Thu, 18 Sep 2025 03:26:42 -0700
Message-Id: <20250918102646.2592821-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <89b6f92e-2aa6-4869-ad4f-47bb3fbadfbb@paulmck-laptop>
References: <89b6f92e-2aa6-4869-ad4f-47bb3fbadfbb@paulmck-laptop>
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
[ paulmck: Apply excess-notrace feedback from Boqun Feng. ]

Link: https://lore.kernel.org/all/20250721162433.10454-1-paulmck@kernel.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     | 25 +++++++++++++++++++++++++
 include/linux/srcutree.h |  5 +++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 478c73d067f7d3..7a692bf8f99b96 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
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
@@ -394,6 +408,17 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
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
index 043b5a67ef71eb..4d2fee4d38289f 100644
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


