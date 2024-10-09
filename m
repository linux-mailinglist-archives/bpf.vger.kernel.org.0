Return-Path: <bpf+bounces-41468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C76997426
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 20:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48E2B26D37
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8A71E2838;
	Wed,  9 Oct 2024 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0PHNFAD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072771E1C02;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497242; cv=none; b=L1DG9dR3YqW3blgB1XsaBe+mUmCLyNgWXdH1/QqE+pOoog7sYselOlHyBvNp28XnqpeHXe2ArhrdAKJV+sVe14B0PqI1hiiWq3Is+F/1gXQCXLvjyiZU5/8BJ54pHPkvXpPu8abowtlYglrdChLLjvQ16W4mpJ+uO8+8fwFR8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497242; c=relaxed/simple;
	bh=ZPs4GAsD/9UDFSL0kqRU9kqwjKToL5QXnB6ewDSvNoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jpzn8IFRK3pMlndKhUxx6l6zGSwLiBA4/IBLxNmER4FVcWviOpxAnDN4S/XhpmtgOPYhIMw4FKnDqTlTy/AgT+e5EHnIQUl4XokrDb099/fGgrINLcuma1O/ncd/tAI0J28s9oThEcFO0DKuHcuXLKOJp6PrB39IO2oTjIJFzJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0PHNFAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B268AC4CEDE;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497241;
	bh=ZPs4GAsD/9UDFSL0kqRU9kqwjKToL5QXnB6ewDSvNoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0PHNFAD30Vf0GtpziQkbT9V9kbWCV/Pm6iDB8LyJUhk5yug8KqhOwfUJpYfU0mFG
	 3u4Mr1yfMxbsM10ICDiYWz0oVUdMjrzEHtr7R0d2AfapucNLGuyqVrbjrGVnisbd7/
	 gWiga5taEVwu+xKk9QOOd5njsfnVrF7TD69fE6jYMzaW+O7KlFVKG63tUfVv7tQGqU
	 oFwrsjJ9kfduCXuKN0J7RUXIsFUaACuXhEjkYdd+e7h/Vm+arYByvhST6B9qiQRked
	 uP3H4Bu9BUMvn4hKKG/EnelrSZoczEUPX2/eUanCVKVcnkCp9UbtFDGPv3fUQQaTXp
	 f+7G2+qEVf2Tw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 22B5DCE1290; Wed,  9 Oct 2024 11:07:21 -0700 (PDT)
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
Subject: [PATCH rcu 07/12] srcu: Allow inlining of __srcu_read_{,un}lock_lite()
Date: Wed,  9 Oct 2024 11:07:14 -0700
Message-Id: <20241009180719.778285-7-paulmck@kernel.org>
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

This commit moves __srcu_read_lock_lite() and __srcu_read_unlock_lite()
into include/linux/srcu.h and marks them "static inline" so that they
can be inlined into srcu_read_lock_lite() and srcu_read_unlock_lite(),
respectively.  They are not hand-inlined due to Tree SRCU and Tiny SRCU
having different implementations.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcutree.h | 39 ++++++++++++++++++++++++++++++++++++++
 kernel/rcu/srcutree.c    | 41 ----------------------------------------
 2 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 8074138cbd624..778eb61542e18 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -209,4 +209,43 @@ void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
 void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
 
+/*
+ * Counts the new reader in the appropriate per-CPU element of the
+ * srcu_struct.  Returns an index that must be passed to the matching
+ * srcu_read_unlock_lite().
+ *
+ * Note that this_cpu_inc() is an RCU read-side critical section either
+ * because it disables interrupts, because it is a single instruction,
+ * or because it is a read-modify-write atomic operation, depending on
+ * the whims of the architecture.
+ */
+static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
+{
+	int idx;
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
+	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
+	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter); /* Y */
+	barrier(); /* Avoid leaking the critical section. */
+	return idx;
+}
+
+/*
+ * Removes the count for the old reader from the appropriate
+ * per-CPU element of the srcu_struct.  Note that this may well be a
+ * different CPU than that which was incremented by the corresponding
+ * srcu_read_lock_lite(), but it must be within the same task.
+ *
+ * Note that this_cpu_inc() is an RCU read-side critical section either
+ * because it disables interrupts, because it is a single instruction,
+ * or because it is a read-modify-write atomic operation, depending on
+ * the whims of the architecture.
+ */
+static inline void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
+{
+	barrier();  /* Avoid leaking the critical section. */
+	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);  /* Z */
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_lite().");
+}
+
 #endif
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index bf51758cf4a64..07147efcb64d3 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -763,47 +763,6 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
-/*
- * Counts the new reader in the appropriate per-CPU element of the
- * srcu_struct.  Returns an index that must be passed to the matching
- * srcu_read_unlock_lite().
- *
- * Note that this_cpu_inc() is an RCU read-side critical section either
- * because it disables interrupts, because it is a single instruction,
- * or because it is a read-modify-write atomic operation, depending on
- * the whims of the architecture.
- */
-int __srcu_read_lock_lite(struct srcu_struct *ssp)
-{
-	int idx;
-
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
-	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter); /* Y */
-	barrier(); /* Avoid leaking the critical section. */
-	return idx;
-}
-EXPORT_SYMBOL_GPL(__srcu_read_lock_lite);
-
-/*
- * Removes the count for the old reader from the appropriate
- * per-CPU element of the srcu_struct.  Note that this may well be a
- * different CPU than that which was incremented by the corresponding
- * srcu_read_lock_lite(), but it must be within the same task.
- *
- * Note that this_cpu_inc() is an RCU read-side critical section either
- * because it disables interrupts, because it is a single instruction,
- * or because it is a read-modify-write atomic operation, depending on
- * the whims of the architecture.
- */
-void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
-{
-	barrier();  /* Avoid leaking the critical section. */
-	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);  /* Z */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_lite().");
-}
-EXPORT_SYMBOL_GPL(__srcu_read_unlock_lite);
-
 #ifdef CONFIG_NEED_SRCU_NMI_SAFE
 
 /*
-- 
2.40.1


