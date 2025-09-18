Return-Path: <bpf+bounces-68767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FD5B84135
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 12:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4601C829F4
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F39C2F5A15;
	Thu, 18 Sep 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrccNUEn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BEE2882CE;
	Thu, 18 Sep 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191207; cv=none; b=WEvUMNfjmRJU52//fXsBrKMRq+PRSSA9pVwKsQ5kBhAZX6yBKIvZTdx/LfXDYNrXIcH/mw9PC0jQHERUeLzOGu1BkbKG0IUnYOozk9vJP6WsA0Ye4U4YIkJir3RXvpDNAvBFEYIEpfrA7V6Nu3fFHkqGJjWrHILo0uKPuRta9ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191207; c=relaxed/simple;
	bh=pvHoXIq/XZZkE26WZ9PeQrCmEPRe5uY95ng191EMoZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ixZ+B6FVSmVZ8Eb2tVqjBOnhtDvGjG0Zu+iZhGSPtNbbAV1iJlRiwNsR5cxQOptLFTeEVVDMiIXi6G3+rexpzU2wdc07CeZ0MKits4xEQlEFwqx7QMm9ZI1mdLB9yT5hQruwr0DNmdG5Ns/8hgPCbjzCz5h48DAUiX4WlvGQmpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrccNUEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67114C4CEE7;
	Thu, 18 Sep 2025 10:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191207;
	bh=pvHoXIq/XZZkE26WZ9PeQrCmEPRe5uY95ng191EMoZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jrccNUEnjRHl9F8GDoKa1N7ClgGg/k52t4ZIFLCJsgVvQodJ7XqcwB1tCju/s6bBP
	 syJQj+LS13u3dJXauOPTERhSy3GtobNeAzPHwOPhrkwiaWcxW/O32zSgyRz8vqK33s
	 XGID4k2J13SxEaLCZl11tNOmhoHFOvz9jeeb046Uobepzy7K6JPaPc6UlTk+uixdd2
	 Rb5jHDozj3OhMMr1LH4G+PPEkQhT92vb1tlUr3C9un8FgwCkFNMHNqIfbek3aoWSoG
	 QdSYCJY/FQxfsCxQZTubHz4tPTIfChWF8bMXPfOtBo4tqxiVF2wgKDoQL9gBI1Aw6L
	 5mjxG66EZn0mQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E31D0CE0B32; Thu, 18 Sep 2025 03:26:46 -0700 (PDT)
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
Subject: [PATCH v2 1/6] srcu: Move rcu_is_watching() checks to srcu_read_{,un}lock_fast()
Date: Thu, 18 Sep 2025 03:26:41 -0700
Message-Id: <20250918102646.2592821-1-paulmck@kernel.org>
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

The rcu_is_watching() warnings are currently in the SRCU-tree
implementations of __srcu_read_lock_fast() and __srcu_read_unlock_fast().
However, this makes it difficult to create _notrace variants of
srcu_read_lock_fast() and srcu_read_unlock_fast().  This commit therefore
moves these checks to srcu_read_lock_fast(), srcu_read_unlock_fast(),
srcu_down_read_fast(), and srcu_up_read_fast().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     | 4 ++++
 include/linux/srcutree.h | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index f179700fecafb8..478c73d067f7d3 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -275,6 +275,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
 {
 	struct srcu_ctr __percpu *retval;
 
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
 	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
 	retval = __srcu_read_lock_fast(ssp);
 	rcu_try_lock_acquire(&ssp->dep_map);
@@ -295,6 +296,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
 static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_struct *ssp) __acquires(ssp)
 {
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_down_read_fast().");
 	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
 	return __srcu_read_lock_fast(ssp);
 }
@@ -389,6 +391,7 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
 	srcu_lock_release(&ssp->dep_map);
 	__srcu_read_unlock_fast(ssp, scp);
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
 }
 
 /**
@@ -405,6 +408,7 @@ static inline void srcu_up_read_fast(struct srcu_struct *ssp, struct srcu_ctr __
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
 	__srcu_read_unlock_fast(ssp, scp);
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_up_read_fast().");
 }
 
 /**
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index bf44d8d1e69eab..043b5a67ef71eb 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -244,7 +244,6 @@ static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct
 {
 	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
 	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
 		this_cpu_inc(scp->srcu_locks.counter); /* Y */
 	else
@@ -275,7 +274,6 @@ static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_
 		this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
 	else
 		atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  /* Z */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
 }
 
 void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
-- 
2.40.1


