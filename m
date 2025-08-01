Return-Path: <bpf+bounces-64855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA68B17A65
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 02:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C505169B73
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 00:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775E7C148;
	Fri,  1 Aug 2025 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scqq5e+L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E4C1C27;
	Fri,  1 Aug 2025 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007159; cv=none; b=IZ56bdhmXmG5N6P109Ns2R9sHBTrUibXm4QwmfPDG4Yn8aXRrCvXbxHEZ/axhq/twM0cHzKcWUMrzfki0r1iosc+Rh/P/xcjdVXSxTMU8hm8AulOjZq3N666s1JbK4cq20Lp+SlS+xc27IQuPGxa7VhNRRqwWeb+YjJyV/ROTW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007159; c=relaxed/simple;
	bh=7M9V2tC56HNHwcS8Ht17nxHyMNl+pCEND+1MV1Qec3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DjkRUNdncR6+G2bDXSUA/w7FeGn3eg7TorayoAZTTMOzE4gEKFjPigAlzv0scB+/v/z/Da7lmQBdxRJuw3Aq2/sn3FTF6x6fFDhj+sikGmdwQWRzYLWrYeCQBmuzpxpGLRTCrmj1AHzdBSjb5fFpUdYaq1iAy0h12UGH5FsKRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scqq5e+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8D6C4CEF4;
	Fri,  1 Aug 2025 00:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754007158;
	bh=7M9V2tC56HNHwcS8Ht17nxHyMNl+pCEND+1MV1Qec3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=scqq5e+LDxhJy1UFGqRBUcUfnGYVbXU77BPa+rRJiS4vhBWOl1ha+miDwMI3kp3IY
	 9MBHYsKeHZBAAFB1e67SGKR0FaCYBoy/xcQGgiDw4mCALVVLHU1vAQpyRB6NGxcM2O
	 3I9/qXRYuSKmK86tOx/psuni64loHU6DTmOY04Nd6pZ7WNF+rNhkbopvP9zhunxwer
	 B3gpN+ILsDeI95u2PYx8cLq30u1wOHrTFRhzhv4skKOfeTkX14EiKqghlecwRXz9lX
	 XE77k4qW+WxSrjBNzOfZ04CvTcpDzhioN4qtnOJ3wpVPIh1V0MbWlK0YUOizaVeGeZ
	 PExxb9PVygc6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 28983CE0ADA; Thu, 31 Jul 2025 17:12:38 -0700 (PDT)
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
Subject: [PATCH v5 2/6] srcu: Add srcu_read_lock_fast_notrace() and srcu_read_unlock_fast_notrace()
Date: Thu, 31 Jul 2025 17:12:32 -0700
Message-Id: <20250801001236.4091760-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c8842c55-faf8-4cde-89bf-da77d91eadcb@paulmck-laptop>
References: <c8842c55-faf8-4cde-89bf-da77d91eadcb@paulmck-laptop>
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
index 478c73d067f7d..7a692bf8f99b9 100644
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


