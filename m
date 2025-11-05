Return-Path: <bpf+bounces-73723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AC7C37BE0
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1A518C6F37
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE5234DB53;
	Wed,  5 Nov 2025 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnbpbU9z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D6934B192;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374740; cv=none; b=BL1heNAumVis6F3dGqFcA+9GQjNgYMX+SJFMiJifJZIulkU3diAhD/Tfqwh1KdXkoeT7LQJo817ELPJKc4P4DdLlLyPMWkfQLaeSjDXGc2oh7vvaYqZ5w+9RcNciW/dRdLZyMxmj5BpIk+HT6xcrhGyf+KXvjJtbWC5IVvaX4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374740; c=relaxed/simple;
	bh=Iq5yf1ytJm34oKtGaJvxP71I3WkFsasL56D7JZi7uYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Prt5z5+9Nv91+hv9BlPlOqSDGoMrayRoifO355VuQ3WFuoRFwZfO97FDl43hFtARq8WTEn7q9up07dw9hriBfudzcC9dCY5bDZncaFvswBw5MuEws0PFsbKqyXTOVihNPZ8SsMbPmDiUmeR+fZskolKbuWahvwqKBcSLt45bdNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnbpbU9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1D2C19422;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374740;
	bh=Iq5yf1ytJm34oKtGaJvxP71I3WkFsasL56D7JZi7uYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NnbpbU9zgonUCD+g1k8V6B3Vb7Tnq9+ZT5Z9D35pM0/ezUfJDQNR1RCLMoLhGfvfP
	 NLbdPna1nhaTon32nFH8XHdIJgd3vYMJno1JUHJN40jmrmwWN+uC0Gd80f5hL8WoCf
	 9HjTfd675e55lSK+DztPZcGieXgA87N5FrZBmh+qc82Bq/WZjYiqF6hdZqu0Sva16j
	 IASuuDBwu5ogPk9DMBYXXR0WRxs5HkbwB/Mm/Fgo2pG6Tx/dL5bcR5W3Ymv3n92aEf
	 o3EfFzdYy0R6iRzLQ02LYWeb/oYbOlS6kKMMrFqqzZ0DPsxEU7GWWhRXU4T0nhP+jG
	 NQIhCJ1TjNH+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9676FCE0F56; Wed,  5 Nov 2025 12:32:18 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v2 07/16] srcu: Require special srcu_struct define/init for SRCU-fast readers
Date: Wed,  5 Nov 2025 12:32:07 -0800
Message-Id: <20251105203216.2701005-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds CONFIG_PROVE_RCU=y checking to enforce the new rule that
srcu_struct structures passed to srcu_read_lock_fast() and other SRCU-fast
read-side markers be either initialized with init_srcu_struct_fast()
on the one hand or defined using either DEFINE_SRCU_FAST() or
DEFINE_STATIC_SRCU_FAST().  This will enable removal of the non-debug
read-side checks from srcu_read_lock_fast() and friends, which on my
laptop provides a 25% speedup (which admittedly amounts to about half
a nanosecond, but when tracing fastpaths...)

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h  | 34 ++++++++++++++++++++++------------
 kernel/rcu/srcutree.c |  1 +
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 26de47820c58..2982b5a6930f 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -271,17 +271,26 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
  * @ssp: srcu_struct in which to register the new reader.
  *
  * Enter an SRCU read-side critical section, but for a light-weight
- * smp_mb()-free reader.  See srcu_read_lock() for more information.
- *
- * If srcu_read_lock_fast() is ever used on an srcu_struct structure,
- * then none of the other flavors may be used, whether before, during,
- * or after.  Note that grace-period auto-expediting is disabled for _fast
- * srcu_struct structures because auto-expedited grace periods invoke
- * synchronize_rcu_expedited(), IPIs and all.
- *
- * Note that srcu_read_lock_fast() can be invoked only from those contexts
- * where RCU is watching, that is, from contexts where it would be legal
- * to invoke rcu_read_lock().  Otherwise, lockdep will complain.
+ * smp_mb()-free reader.  See srcu_read_lock() for more information.  This
+ * function is NMI-safe, in a manner similar to srcu_read_lock_nmisafe().
+ *
+ * For srcu_read_lock_fast() to be used on an srcu_struct structure,
+ * that structure must have been defined using either DEFINE_SRCU_FAST()
+ * or DEFINE_STATIC_SRCU_FAST() on the one hand or initialized with
+ * init_srcu_struct_fast() on the other.  Such an srcu_struct structure
+ * cannot be passed to any non-fast variant of srcu_read_{,un}lock() or
+ * srcu_{down,up}_read().  In kernels built with CONFIG_PROVE_RCU=y,
+ * __srcu_check_read_flavor() will complain bitterly if you ignore this
+ * restriction.
+ *
+ * Grace-period auto-expediting is disabled for SRCU-fast srcu_struct
+ * structures because SRCU-fast expedited grace periods invoke
+ * synchronize_rcu_expedited(), IPIs and all.  If you need expedited
+ * SRCU-fast grace periods, use synchronize_srcu_expedited().
+ *
+ * The srcu_read_lock_fast() function can be invoked only from those
+ * contexts where RCU is watching, that is, from contexts where it would
+ * be legal to invoke rcu_read_lock().  Otherwise, lockdep will complain.
  */
 static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *ssp) __acquires(ssp)
 {
@@ -317,7 +326,8 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_
  * srcu_down_read() for more information.
  *
  * The same srcu_struct may be used concurrently by srcu_down_read_fast()
- * and srcu_read_lock_fast().
+ * and srcu_read_lock_fast().  However, the same definition/initialization
+ * requirements called out for srcu_read_lock_safe() apply.
  */
 static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_struct *ssp) __acquires(ssp)
 {
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c29203b23d1a..2f8aa280911e 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -766,6 +766,7 @@ void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 	WARN_ON_ONCE(ssp->srcu_reader_flavor && read_flavor != ssp->srcu_reader_flavor);
 	WARN_ON_ONCE(old_read_flavor && ssp->srcu_reader_flavor &&
 		     old_read_flavor != ssp->srcu_reader_flavor);
+	WARN_ON_ONCE(read_flavor == SRCU_READ_FLAVOR_FAST && !ssp->srcu_reader_flavor);
 	if (!old_read_flavor) {
 		old_read_flavor = cmpxchg(&sdp->srcu_reader_flavor, 0, read_flavor);
 		if (!old_read_flavor)
-- 
2.40.1


