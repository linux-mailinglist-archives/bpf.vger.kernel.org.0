Return-Path: <bpf+bounces-69423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF1FB963DF
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFE332233F
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F29328978;
	Tue, 23 Sep 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFgL6W0X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492BB328563;
	Tue, 23 Sep 2025 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637315; cv=none; b=mIlwIfzMj6956eXG1XA1ov9jNCv70+ezbXGVMP8jQ2CVbt2H/DGigrUqOA0IoksbL+ev7yE1ZR+EfqrU1Rd//zkTpqjLQH/4LFqaAOvsuDSV3eh0/nbZX/xrDAjLUmaJ8t2Z5glhG9o6xWipHn+lir+CNxFfFt6Vgl9pHbayq7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637315; c=relaxed/simple;
	bh=zPxFwXtYgPLDmkgZ+C7PtVRQ3LVvyGVKpWPncscteiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OF8WpTptipjvjYRRB9QldIhTFxEbfTzLOrL8462IIlhUdObV5vX8Wnu3P16sEebupmwBHn1LC+qsJXh2zQ4bGxt7dOBA7JcvlWrAt4/KxKvvaDxZoeTZcZui+l5LioBvJYgT3oWnh1Xu+4tiCP4QnbvKmeV0c/pEZEXN+mfksec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFgL6W0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AA0C19423;
	Tue, 23 Sep 2025 14:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637314;
	bh=zPxFwXtYgPLDmkgZ+C7PtVRQ3LVvyGVKpWPncscteiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFgL6W0X9TD7itXUCA79zfHAMgsDv/F5ZjscgtnZe2i+axXkbeDke8n6lkPlH2Rvb
	 J0dOPDolpyRr9ODVcAPyii5ZUSIc3NecjkdxrjpKoGK9PxkUjTga/rNCyKfXNDccwt
	 euFWwYsRXqJ1RrE0ktNztksZjKsMjQgKCnRdz5HOUc+u6iu7XRQJ/CClDr2nwFoNNJ
	 OBC7zbx4oJ/pADdOHTZd7sdREWWx+Zm3SKQF01WdNLmvvLAcffNc2cZt5aKK8UFirW
	 nFf89dNlRCTzjudGzHVB+l1kHVwWL/q/qI8++OL4Je1wo8Kg+LcSyI/a0LJqvnZrjA
	 THcqpEPX/A9aw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CF24CCE1385; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
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
Subject: [PATCH 10/34] rcu: Remove now-empty show_rcu_tasks_trace_gp_kthread() function
Date: Tue, 23 Sep 2025 07:20:12 -0700
Message-Id: <20250923142036.112290-10-paulmck@kernel.org>
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

The show_rcu_tasks_trace_gp_kthread() is used by rcutorture to diagnose
bugs involving the RCU Tasks Trace grace-period kthread, which now no
longer exists.  This commit therefore removes this function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/rcu.h        | 5 -----
 kernel/rcu/rcutorture.c | 1 -
 kernel/rcu/tasks.h      | 6 ------
 3 files changed, 12 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 9cf01832a6c3d1..b397572b4a5331 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -673,11 +673,6 @@ void show_rcu_tasks_rude_gp_kthread(void);
 #else
 static inline void show_rcu_tasks_rude_gp_kthread(void) {}
 #endif
-#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_TRACE_RCU)
-void show_rcu_tasks_trace_gp_kthread(void);
-#else
-static inline void show_rcu_tasks_trace_gp_kthread(void) {}
-#endif
 
 #ifdef CONFIG_TINY_RCU
 static inline bool rcu_cpu_beenfullyonline(int cpu) { return true; }
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 72619e5e8549dc..5120e1ce811413 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1130,7 +1130,6 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.exp_sync	= synchronize_rcu_tasks_trace,
 	.call		= call_rcu_tasks_trace,
 	.cb_barrier	= rcu_barrier_tasks_trace,
-	.gp_kthread_dbg	= show_rcu_tasks_trace_gp_kthread,
 	.get_gp_data    = rcu_tasks_trace_get_gp_data,
 	.cbflood_max	= 50000,
 	.irq_capable	= 1,
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 50f5c483e0e15a..6e2530fe23e620 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1468,11 +1468,6 @@ void __init rcu_tasks_trace_suppress_unused(void)
 }
 
 #if !defined(CONFIG_TINY_RCU)
-void show_rcu_tasks_trace_gp_kthread(void)
-{
-}
-EXPORT_SYMBOL_GPL(show_rcu_tasks_trace_gp_kthread);
-
 void rcu_tasks_trace_torture_stats_print(char *tt, char *tf)
 {
 }
@@ -1497,7 +1492,6 @@ void show_rcu_tasks_gp_kthreads(void)
 {
 	show_rcu_tasks_classic_gp_kthread();
 	show_rcu_tasks_rude_gp_kthread();
-	show_rcu_tasks_trace_gp_kthread();
 }
 #endif /* #ifndef CONFIG_TINY_RCU */
 
-- 
2.40.1


