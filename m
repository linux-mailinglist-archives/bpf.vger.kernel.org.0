Return-Path: <bpf+bounces-69406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC33B96366
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AD93AFD6F
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2070A26A1CC;
	Tue, 23 Sep 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXkTPm51"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2B921B9CD;
	Tue, 23 Sep 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637302; cv=none; b=c53iYkyfVQIB9swAlS9UnDL8wZOV3o7TjKeMSCstUCy+0hHDcWcG6+5h85zPKao2aezm9/upktXVufo5bFtw973Lv8GZRhb9qz+0qfHuvrsjWD+MaGU7lQlm0cDYR++vZzgajbH5YXpO1AH2MPaywKe5Njwd93XBJtvu8ZSBwvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637302; c=relaxed/simple;
	bh=XNmsZMoAIYYD/q9UvCMskFAVtHocTahtlj2a9AJbvFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ByV1J3V3u3zqJFZnqCQ+UPNYJ9G8nmNUwlO2rhh/9yzxT2R/6p29RWO5RjI6EcsDcI1uQDfV+SgzYnYX59F0wxLRsxQVGKR6+HFa5cGyL75MH3WPPb2PADk5rTZH2WErGX0vWOufjU/ohLF9JaAT7W3blMF8r/z/9BfFyQLC9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXkTPm51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC177C113D0;
	Tue, 23 Sep 2025 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637302;
	bh=XNmsZMoAIYYD/q9UvCMskFAVtHocTahtlj2a9AJbvFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXkTPm51Q0u1KO26bxn9O6W+5DJZubvIwqRQ81/rkxtkRS+yDPKVm6MNJOZMRSjkQ
	 DJ1yUtBNMjAMADSTaeqC4uLQGfvUrI4N+dxKSODKGAP/1bwn1hlVhBbVohMfZxb4Cs
	 6dSfaZeVhZCLC3ByJiGz7AmwyhNtAkWfalQiV4Dl7tD6sDLh8sVUJjQw/eBD9wylOJ
	 kuP+hkoXPkgSltxQo0SqGziXOs2NEUwXmduLuzM6TxLr4znjf9SdeuqT2y5sNsVGv2
	 lj2aAQFWHuqBjovwJpajFzWG7ZX1vZNO0qaOS1iXt01AFGcxQRzN0MOGbzvchEnrdo
	 CJNevCpDCrOZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D1F50CE1389; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
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
Subject: [PATCH 11/34] rcu: Remove now-empty rcu_tasks_trace_get_gp_data() function
Date: Tue, 23 Sep 2025 07:20:13 -0700
Message-Id: <20250923142036.112290-11-paulmck@kernel.org>
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

The rcu_tasks_trace_get_gp_data() is used by rcutorture to diagnose
bugs involving the RCU Tasks Trace grace-period kthread, which now no
longer exists.  This commit therefore removes this function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/rcupdate_trace.h | 1 -
 kernel/rcu/rcu.h               | 4 ----
 kernel/rcu/rcutorture.c        | 1 -
 kernel/rcu/tasks.h             | 5 -----
 4 files changed, 11 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 3f46cbe6700038..ffd4dcd6339ae4 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -136,7 +136,6 @@ static inline void rcu_barrier_tasks_trace(void)
 }
 
 // Placeholders to enable stepwise transition.
-void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq);
 void __init rcu_tasks_trace_suppress_unused(void);
 struct task_struct *get_rcu_tasks_trace_gp_kthread(void);
 
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index b397572b4a5331..dc5d614b372c1e 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -544,10 +544,6 @@ struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
 void rcu_tasks_rude_get_gp_data(int *flags, unsigned long *gp_seq);
 #endif // # ifdef CONFIG_TASKS_RUDE_RCU
 
-#ifdef CONFIG_TASKS_TRACE_RCU
-void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq);
-#endif
-
 #ifdef CONFIG_TASKS_RCU_GENERIC
 void tasks_cblist_init_generic(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5120e1ce811413..485fa822b6a753 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1130,7 +1130,6 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.exp_sync	= synchronize_rcu_tasks_trace,
 	.call		= call_rcu_tasks_trace,
 	.cb_barrier	= rcu_barrier_tasks_trace,
-	.get_gp_data    = rcu_tasks_trace_get_gp_data,
 	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.slow_gps	= 1,
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6e2530fe23e620..7a8c1fd9addb7a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1480,11 +1480,6 @@ struct task_struct *get_rcu_tasks_trace_gp_kthread(void)
 }
 EXPORT_SYMBOL_GPL(get_rcu_tasks_trace_gp_kthread);
 
-void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq)
-{
-}
-EXPORT_SYMBOL_GPL(rcu_tasks_trace_get_gp_data);
-
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
 
 #ifndef CONFIG_TINY_RCU
-- 
2.40.1


