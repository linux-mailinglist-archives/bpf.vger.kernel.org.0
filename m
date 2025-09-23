Return-Path: <bpf+bounces-69408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCD5B96345
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 838817B5439
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D9427B4FA;
	Tue, 23 Sep 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0vt1Tl2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7729238D54;
	Tue, 23 Sep 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637302; cv=none; b=ItX1H+TFISFt6p9lz5LQLzmf/QZmMHa5bkF1R2slOho1Z2H/9fOUQGNd2oHSvhgZhZxDI2hpQ3D9fShj9kB4+WuGXt3r5h8G/GuhfqjXMatzzWuvkYJgC8ldnB9cVZXvG/odOt8k8cHLwfZXm+7qz8le973/VJKlsCXNbU5t6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637302; c=relaxed/simple;
	bh=3ftSpkUjjOHmFcE+Uq9SLwvx1RopJ6G++mEEFYkpkZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aSifj+/6KmKpa3S2VVI8P5Ql+DeWrqhFF1kBb2+ZyIao41ZmT9xi8/fFqMrVttf2BBCup4bl6L5MsFB1d1bcTnH1pNBEkNiW4sVYfOkic22R7HXDua5E3Qi1JK//vEVpJ2MkS34MWNAC6B0/CLOucfLPNWcdTmPqaqgcvK3qZkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0vt1Tl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8722EC4CEF5;
	Tue, 23 Sep 2025 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637302;
	bh=3ftSpkUjjOHmFcE+Uq9SLwvx1RopJ6G++mEEFYkpkZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t0vt1Tl2+DF2UKvcLFZ3Cps9QQb7cz+d6KFaVOugaMeZpOZDu8lApEwjdzz8fG7Sd
	 cR7eAooKdz2zexKu3vqe8kiFrs0PILqSnZhoNgYUpWtr9hO8FqYoWS1nmD4TwXVExG
	 7+YHfmW7nO24xd7WypYTmQonhxXZxssetbQYtKAsVwWOZbAPSdcY4OTM2I6jYHgBI6
	 HvkLCXRhQEERuHBb0leKu4yG0ssBVIRkENRG+fS1VNq+ngd8kGxTYMKUIZaUn6JVog
	 w/qjmNJFBBQ0vQ2NpvZrWrcwNRqdVu+mIwBuRkKvoTiJ06ePdQ4XRVszJLD+P898QN
	 sHIK36k/gzmwQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D4817CE13DF; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
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
Subject: [PATCH 12/34] rcu: Remove now-empty rcu_tasks_trace_torture_stats_print() function
Date: Tue, 23 Sep 2025 07:20:14 -0700
Message-Id: <20250923142036.112290-12-paulmck@kernel.org>
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

The rcu_tasks_trace_torture_stats_print() is used by rcuscale to diagnose
bugs involving the RCU Tasks Trace grace-period kthread, which now no
longer exists.  This commit therefore removes this function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/rcupdate.h | 4 ----
 kernel/rcu/rcuscale.c    | 6 ------
 kernel/rcu/tasks.h       | 7 -------
 3 files changed, 17 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 7611730e34bc33..f3a7478bab2e26 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -175,10 +175,6 @@ void rcu_tasks_torture_stats_print(char *tt, char *tf);
 # define synchronize_rcu_tasks synchronize_rcu
 # endif
 
-# ifdef CONFIG_TASKS_TRACE_RCU
-void rcu_tasks_trace_torture_stats_print(char *tt, char *tf);
-# endif
-
 #define rcu_tasks_qs(t, preempt) do { rcu_tasks_classic_qs((t), (preempt)); } while (0)
 
 # ifdef CONFIG_TASKS_RUDE_RCU
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index b521d04559927a..16ba9050dab66b 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -400,11 +400,6 @@ static void tasks_trace_scale_read_unlock(int idx)
 	rcu_read_unlock_trace();
 }
 
-static void rcu_tasks_trace_scale_stats(void)
-{
-	rcu_tasks_trace_torture_stats_print(scale_type, SCALE_FLAG);
-}
-
 static struct rcu_scale_ops tasks_tracing_ops = {
 	.ptype		= RCU_TASKS_FLAVOR,
 	.init		= rcu_sync_scale_init,
@@ -417,7 +412,6 @@ static struct rcu_scale_ops tasks_tracing_ops = {
 	.sync		= synchronize_rcu_tasks_trace,
 	.exp_sync	= synchronize_rcu_tasks_trace,
 	.rso_gp_kthread	= get_rcu_tasks_trace_gp_kthread,
-	.stats		= IS_ENABLED(CONFIG_TINY_RCU) ? NULL : rcu_tasks_trace_scale_stats,
 	.name		= "tasks-tracing"
 };
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 7a8c1fd9addb7a..4fb61b3c78283d 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1467,13 +1467,6 @@ void __init rcu_tasks_trace_suppress_unused(void)
 	rcu_tasks_torture_stats_print_generic(NULL, NULL, NULL, NULL);
 }
 
-#if !defined(CONFIG_TINY_RCU)
-void rcu_tasks_trace_torture_stats_print(char *tt, char *tf)
-{
-}
-EXPORT_SYMBOL_GPL(rcu_tasks_trace_torture_stats_print);
-#endif // !defined(CONFIG_TINY_RCU)
-
 struct task_struct *get_rcu_tasks_trace_gp_kthread(void)
 {
 	return NULL;
-- 
2.40.1


