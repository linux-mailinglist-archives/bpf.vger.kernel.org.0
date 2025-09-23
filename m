Return-Path: <bpf+bounces-69426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C37B963F9
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAB13226B1
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ED5329F13;
	Tue, 23 Sep 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWV3n/IF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A1328996;
	Tue, 23 Sep 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637316; cv=none; b=qG2Stg0fj1PNNguqlVB+s3zfj3X+lWvDzqy5PNGfKTJyGy/Q8LM/KahSrhEJbrK4/MfDaXBEP+y6QY6fm0Kpw+pi4hBhxaMPHvESPncfkL/p5d3KbwT0UKC5PiYNdNgN9ng50WzvJ0NMXNNOHStK/IJnoHt2UsMyWpTWcGE8WBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637316; c=relaxed/simple;
	bh=UWhSG3+L9kGDuQv4d75Qlf1/uqGMYN1a+rwGs+aTo7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q8PBK816CZiM6fA3ban7Dq9NO52S7rr1xUB5rk2LPTjo4FaCKdYsVVG4mQBeMbNHMcN+xos6r6gchMJZjEuuFDMJglzq+ZDwoxD7uGT+4DxReSIRih2Aas9QCKvzGaGVBqyspMGmEG5yyOXteedplpTSu3khJu2ujYwoz45hlQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWV3n/IF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A398EC2BCB0;
	Tue, 23 Sep 2025 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637316;
	bh=UWhSG3+L9kGDuQv4d75Qlf1/uqGMYN1a+rwGs+aTo7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWV3n/IFCRYk0ertJZgeB+IZS5IrwdockOH6qZT87qpRdq+RFjThQ47I6aTDKvG/z
	 zcc+cXvbCx9AS+UW1tZntqbYm4R8TIxQfnmChHnXESyW6ZlFlbof3a2iycgdncSh/f
	 bWTaMyT951D2nTS7HQms1VptnQV0ElehZErjpCQ+ZY+TWGjLiSBvDjHgNqKVQSDV3J
	 lOxmy7voQYa+bgWz0vBUmYF9hFLizOyHwASI7/sgfpGQMp4PV/7QJYqxVShSR9o1YN
	 LZPBnnr9M7vj91px5G48xSwdxAeNvtzokQfgt8j5VcukZNpuwOUopSM79goMuhY6YT
	 d5EiY5XJNW2dg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C93FECE12C3; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
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
Subject: [PATCH 08/34] rcu: Remove now-empty RCU Tasks Trace functions and calls to them
Date: Tue, 23 Sep 2025 07:20:10 -0700
Message-Id: <20250923142036.112290-8-paulmck@kernel.org>
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

This commit removes the now-empty functions rcu_tasks_trace_qs_blkd(),
exit_tasks_rcu_finish_trace(), and rcu_spawn_tasks_trace_kthread(),
along with all calls to them.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/rcupdate.h |  1 -
 kernel/rcu/tasks.h       | 28 +---------------------------
 2 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 879525c5764a0c..7611730e34bc33 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -176,7 +176,6 @@ void rcu_tasks_torture_stats_print(char *tt, char *tf);
 # endif
 
 # ifdef CONFIG_TASKS_TRACE_RCU
-void rcu_tasks_trace_qs_blkd(struct task_struct *t);
 void rcu_tasks_trace_torture_stats_print(char *tt, char *tf);
 # endif
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 967c43b1937bae..25dc49ebad251d 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -800,8 +800,6 @@ static void rcu_tasks_torture_stats_print_generic(struct rcu_tasks *rtp, char *t
 
 #endif // #ifndef CONFIG_TINY_RCU
 
-static void exit_tasks_rcu_finish_trace(struct task_struct *t);
-
 #if defined(CONFIG_TASKS_RCU)
 
 ////////////////////////////////////////////////////////////////////////
@@ -1321,13 +1319,11 @@ void exit_tasks_rcu_finish(void)
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 	list_del_init(&t->rcu_tasks_exit_list);
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
-
-	exit_tasks_rcu_finish_trace(t);
 }
 
 #else /* #ifdef CONFIG_TASKS_RCU */
 void exit_tasks_rcu_start(void) { }
-void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
+void exit_tasks_rcu_finish(void) { }
 #endif /* #else #ifdef CONFIG_TASKS_RCU */
 
 #ifdef CONFIG_TASKS_RUDE_RCU
@@ -1471,12 +1467,6 @@ void __init rcu_tasks_trace_suppress_unused(void)
 	rcu_tasks_torture_stats_print_generic(NULL, NULL, NULL, NULL);
 }
 
-/* Add a newly blocked reader task to its CPU's list. */
-void rcu_tasks_trace_qs_blkd(struct task_struct *t)
-{
-}
-EXPORT_SYMBOL_GPL(rcu_tasks_trace_qs_blkd);
-
 /* Communicate task state back to the RCU tasks trace stall warning request. */
 struct trc_stall_chk_rdr {
 	int nesting;
@@ -1484,19 +1474,9 @@ struct trc_stall_chk_rdr {
 	u8 needqs;
 };
 
-/* Report any needed quiescent state for this exiting task. */
-static void exit_tasks_rcu_finish_trace(struct task_struct *t)
-{
-}
-
 int rcu_tasks_trace_lazy_ms = -1;
 module_param(rcu_tasks_trace_lazy_ms, int, 0444);
 
-static int __init rcu_spawn_tasks_trace_kthread(void)
-{
-	return 0;
-}
-
 #if !defined(CONFIG_TINY_RCU)
 void show_rcu_tasks_trace_gp_kthread(void)
 {
@@ -1520,8 +1500,6 @@ void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq)
 }
 EXPORT_SYMBOL_GPL(rcu_tasks_trace_get_gp_data);
 
-#else /* #ifdef CONFIG_TASKS_TRACE_RCU */
-static void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
 
 #ifndef CONFIG_TINY_RCU
@@ -1668,10 +1646,6 @@ static int __init rcu_init_tasks_generic(void)
 	rcu_spawn_tasks_rude_kthread();
 #endif
 
-#ifdef CONFIG_TASKS_TRACE_RCU
-	rcu_spawn_tasks_trace_kthread();
-#endif
-
 	// Run the self-tests.
 	rcu_tasks_initiate_self_tests();
 
-- 
2.40.1


