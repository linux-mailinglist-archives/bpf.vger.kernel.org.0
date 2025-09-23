Return-Path: <bpf+bounces-69429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92037B963E7
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DDB440865
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16679329F23;
	Tue, 23 Sep 2025 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGZCLjZG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CD83294FD;
	Tue, 23 Sep 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637316; cv=none; b=XgKPSTAi7NXbaLnmTrGzie8g9MZqrexuYaEoj09Ejvyn0VVtJhWWvfS4snCzPmY38QSbbf4qoTrvDyUDoq/xKz83s2sZrECgftET0HHg2h1dqLYnGS5CrgDyqt+pU/Aiorajq/RZupN2gCnbFdc75SGqwdgxB48uawMYG9GSjsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637316; c=relaxed/simple;
	bh=IOkf+dURDETQ7kOjDcCR/fZHWRdctmeYkirYqvh5ji4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=levz+FXWX91ant2d6rhzn+v9pQ9GupuSrU+hL5zo1KXtN80Shu25LZHnHPGERBviDo6Fpq2WT/xMvpYavxXwFnzzODZ7ilTngBnnKSpVoKtb3NoqDxxk9V+ABhng58GfvmlTutYki82BCNFTFBhFGW8d8NH/iX8kEqUMHaZvxnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGZCLjZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A47C113D0;
	Tue, 23 Sep 2025 14:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637316;
	bh=IOkf+dURDETQ7kOjDcCR/fZHWRdctmeYkirYqvh5ji4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGZCLjZGPRJdy7hRXo0SkUkOrj3qXYCsSsoPE0c8CMJjLywd3xkRtQscNzjTItTAn
	 X8iGFhF5ZvoSk9g33xQiY+1ZIXcEX9tw46jezZZCiTWTTqcUVrtOrW60DGLNwzJQ3L
	 4DrKU2l2P6CZYgv/Qif18Fc7Y6rqZKG+mA3mHoUdN7ulXss/aLhhoMCZXnSvOyj7/f
	 l/Q3igSoQNK/w6hgFpIYzl12hGlkUrfKKKzitQvNHhAOrPX6hIv6PDogMH+6MJ3tU3
	 jfiZ7ldroLqvomvb1EMMbHYiXe8SaAMUXNv0vi9MxeDSAE3jxS4g0gcEE/42fyQjwa
	 B3MI5Xp7XNblQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DCC45CE1437; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH 15/34] rcu: Add noinstr-fast rcu_read_{,un}lock_tasks_trace() APIs
Date: Tue, 23 Sep 2025 07:20:17 -0700
Message-Id: <20250923142036.112290-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When expressing RCU Tasks Trace in terms of SRCU-fast, it was
necessary to keep a nesting count and per-CPU srcu_ctr structure
pointer in the task_struct structure, which is slow to access.
But an alternative is to instead make rcu_read_lock_tasks_trace() and
rcu_read_unlock_tasks_trace(), which match the underlying SRCU-fast
semantics, avoiding the task_struct accesses.

When all callers have switched to the new API, the previous
rcu_read_lock_trace() and rcu_read_unlock_trace() APIs will be removed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/rcupdate_trace.h | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 0bd47f12ecd17b..b87151e6b23881 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -34,6 +34,43 @@ static inline int rcu_read_lock_trace_held(void)
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 
+/**
+ * rcu_read_lock_tasks_trace - mark beginning of RCU-trace read-side critical section
+ *
+ * When synchronize_rcu_tasks_trace() is invoked by one task, then that
+ * task is guaranteed to block until all other tasks exit their read-side
+ * critical sections.  Similarly, if call_rcu_trace() is invoked on one
+ * task while other tasks are within RCU read-side critical sections,
+ * invocation of the corresponding RCU callback is deferred until after
+ * the all the other tasks exit their critical sections.
+ *
+ * For more details, please see the documentation for srcu_read_lock_fast().
+ */
+static inline struct srcu_ctr __percpu *rcu_read_lock_tasks_trace(void)
+{
+	struct srcu_ctr __percpu *ret = srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
+
+	if (IS_ENABLED(CONFIG_ARCH_WANTS_NO_INSTR))
+		smp_mb();
+	return ret;
+}
+
+/**
+ * rcu_read_unlock_tasks_trace - mark end of RCU-trace read-side critical section
+ * @scp: return value from corresponding rcu_read_lock_tasks_trace().
+ *
+ * Pairs with the preceding call to rcu_read_lock_tasks_trace() that
+ * returned the value passed in via scp.
+ *
+ * For more details, please see the documentation for rcu_read_unlock().
+ */
+static inline void rcu_read_unlock_tasks_trace(struct srcu_ctr __percpu *scp)
+{
+	if (!IS_ENABLED(CONFIG_ARCH_WANTS_NO_INSTR))
+		smp_mb();
+	srcu_read_unlock_fast(&rcu_tasks_trace_srcu_struct, scp);
+}
+
 /**
  * rcu_read_lock_trace - mark beginning of RCU-trace read-side critical section
  *
-- 
2.40.1


