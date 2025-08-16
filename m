Return-Path: <bpf+bounces-65799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182A3B2890C
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 02:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1F516D80B
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 00:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D3E1BC3F;
	Sat, 16 Aug 2025 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/iPnTid"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC2F9463;
	Sat, 16 Aug 2025 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302761; cv=none; b=LzLj3Bq/nuXtDfpzWylGiPJMqMe2Uf4mprvRCZ+Bj1RvgcPdx0UL5E+uf1s8kPvzYGwu8OfrkRl4NOhYoCj1vRclknrBxA9iv0Uqjpiadgq0Gb21yqVYbu9QXRQ6U9ZggchOBxDEhXuhnyayB/89Kp4iUu7K3gtEeVtHtcruq/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302761; c=relaxed/simple;
	bh=jDxGNAMMOCyH7qVFbWf8yWfHDDI/sC4nlnOnRxPII+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OISDeGLMNJegO8Tu5R3AISD2h3BV7BABCkU8LScWzVcrHsfq2mEaaaAy2xXZ7t/n21ZUNY7yoChxcPhTP58yPg7uAYMRFrv4JWvVN8Vm9hRFPhSu3rpPDJkiy4qp6O1dAdu5ABG/OdyTyLHffBN5kXl3qmYSafnX/6eukfYwALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/iPnTid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421DDC4CEEB;
	Sat, 16 Aug 2025 00:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302761;
	bh=jDxGNAMMOCyH7qVFbWf8yWfHDDI/sC4nlnOnRxPII+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/iPnTide+3z6ikOSLFc3JJCE58bRR5yyK0/DMdOySITFv0bIy+YUG1u6S9B/yIrw
	 nERIyqchad7TboqwWypPYlDaFafIkG46Txbv3QRD363z0LTAIRwGeI558zX01jlMsM
	 jx3omBm1pAOzmaRdX9Ms6bDhyERbo3hS1vi3bgzFlJnJE1NxPuPeoCyfH4p0yaegI/
	 D0rOGmllMnDwBZVEd427ie0SR3X5NQBalmcqddjS8ihiABnHqRIauz6HEK+zpa0f4P
	 IZOwCIBvBonsez3ksL0he6SHBNjm+2oQxAYz9XCC1ckCsC1TGjtoslroLQW2aCxq44
	 jH4Eg4QUI9UuQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 86331CE0B30; Fri, 15 Aug 2025 17:06:00 -0700 (PDT)
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
Subject: [PATCH v6 2/6] srcu: Add srcu_read_lock_fast_notrace() and srcu_read_unlock_fast_notrace()
Date: Fri, 15 Aug 2025 17:05:55 -0700
Message-Id: <20250816000559.2622626-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b592a936-fd9e-4aef-a2af-9d40ae19511d@paulmck-laptop>
References: <b592a936-fd9e-4aef-a2af-9d40ae19511d@paulmck-laptop>
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


