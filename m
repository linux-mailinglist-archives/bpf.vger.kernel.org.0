Return-Path: <bpf+bounces-8821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FCC78A6DC
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 09:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201211C2085B
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 07:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89D41100;
	Mon, 28 Aug 2023 07:55:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD1710F4
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 07:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAE6C433C7;
	Mon, 28 Aug 2023 07:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693209353;
	bh=+T0pwH+APNqVzXupk7yMjNClPlB4iAfvbTISqslDLFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJXKQUF9f5zcFemOYsw0NjIFtcLP0XeSnf01Xl58fgzFk46Vi0FOneffxn/EHCDES
	 PtwBqjbx4wqpQr7Z1Yd7EhWYEcka3knyqVBL0raULgl+9dwEg3LPj9V6jL/eCyaqd3
	 xS5pqFFT5uyy5kkObm41vEln1RbsUj0Ege91tLJLQ7j7BKQZPegVhOANgatMpW5yKG
	 WZL0mucfwyH8059qKnh8NmQVXocnQtP5DqnlRQ6QVFCkqrftJ/8OmqGk6roJFx58ey
	 kBFw9EQPbhj7nE6613tQ3YN3bn9BBG5bzxL+Yc7uDv+PaHofnSsGPx1k62MAoU0gIA
	 V34CD06U3BntA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCH bpf-next 01/12] bpf: Move update_prog_stats to syscall object
Date: Mon, 28 Aug 2023 09:55:26 +0200
Message-ID: <20230828075537.194192-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828075537.194192-1-jolsa@kernel.org>
References: <20230828075537.194192-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moving update_prog_stats function to syscall object and making it
global together with NO_START_TIME macro and adding 'bpf_' prefix
for both.

It will be used by other program types in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     |  7 +++++++
 kernel/bpf/syscall.c    | 22 ++++++++++++++++++++++
 kernel/bpf/trampoline.c | 37 +++++++------------------------------
 3 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 12596af59c00..05eece17a989 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1982,6 +1982,8 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
 	return ret;
 }
 
+#define BPF_PROG_NO_START_TIME 1
+
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
 extern struct mutex bpf_stats_enabled_mutex;
@@ -2456,6 +2458,7 @@ static inline bool has_current_bpf_ctx(void)
 }
 
 void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
+void notrace bpf_prog_update_prog_stats(struct bpf_prog *prog, u64 start);
 
 void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 		     enum bpf_dynptr_type type, u32 offset, u32 size);
@@ -2695,6 +2698,10 @@ static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
 {
 }
 
+static void bpf_prog_update_prog_stats(struct bpf_prog *prog, u64 start)
+{
+}
+
 static inline void bpf_cgrp_storage_free(struct cgroup *cgroup)
 {
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ebeb0695305a..5d39d98f5eb1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2188,6 +2188,28 @@ void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog)
 	u64_stats_update_end_irqrestore(&stats->syncp, flags);
 }
 
+void notrace bpf_prog_update_prog_stats(struct bpf_prog *prog,
+					u64 start)
+{
+	struct bpf_prog_stats *stats;
+
+	if (static_branch_unlikely(&bpf_stats_enabled_key) &&
+	    /* static_key could be enabled in __bpf_prog_enter*
+	     * and disabled in __bpf_prog_exit*.
+	     * And vice versa.
+	     * Hence check that 'start' is valid.
+	     */
+	    start > BPF_PROG_NO_START_TIME) {
+		unsigned long flags;
+
+		stats = this_cpu_ptr(prog->stats);
+		flags = u64_stats_update_begin_irqsave(&stats->syncp);
+		u64_stats_inc(&stats->cnt);
+		u64_stats_add(&stats->nsecs, sched_clock() - start);
+		u64_stats_update_end_irqrestore(&stats->syncp, flags);
+	}
+}
+
 static void bpf_prog_get_stats(const struct bpf_prog *prog,
 			       struct bpf_prog_kstats *stats)
 {
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 78acf28d4873..a6528e847fae 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -819,15 +819,14 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	mutex_unlock(&trampoline_mutex);
 }
 
-#define NO_START_TIME 1
 static __always_inline u64 notrace bpf_prog_start_time(void)
 {
-	u64 start = NO_START_TIME;
+	u64 start = BPF_PROG_NO_START_TIME;
 
 	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
 		start = sched_clock();
 		if (unlikely(!start))
-			start = NO_START_TIME;
+			start = BPF_PROG_NO_START_TIME;
 	}
 	return start;
 }
@@ -860,35 +859,13 @@ static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tram
 	return bpf_prog_start_time();
 }
 
-static void notrace update_prog_stats(struct bpf_prog *prog,
-				      u64 start)
-{
-	struct bpf_prog_stats *stats;
-
-	if (static_branch_unlikely(&bpf_stats_enabled_key) &&
-	    /* static_key could be enabled in __bpf_prog_enter*
-	     * and disabled in __bpf_prog_exit*.
-	     * And vice versa.
-	     * Hence check that 'start' is valid.
-	     */
-	    start > NO_START_TIME) {
-		unsigned long flags;
-
-		stats = this_cpu_ptr(prog->stats);
-		flags = u64_stats_update_begin_irqsave(&stats->syncp);
-		u64_stats_inc(&stats->cnt);
-		u64_stats_add(&stats->nsecs, sched_clock() - start);
-		u64_stats_update_end_irqrestore(&stats->syncp, flags);
-	}
-}
-
 static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
 					  struct bpf_tramp_run_ctx *run_ctx)
 	__releases(RCU)
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
-	update_prog_stats(prog, start);
+	bpf_prog_update_prog_stats(prog, start);
 	this_cpu_dec(*(prog->active));
 	migrate_enable();
 	rcu_read_unlock();
@@ -906,7 +883,7 @@ static u64 notrace __bpf_prog_enter_lsm_cgroup(struct bpf_prog *prog,
 
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 
-	return NO_START_TIME;
+	return BPF_PROG_NO_START_TIME;
 }
 
 static void notrace __bpf_prog_exit_lsm_cgroup(struct bpf_prog *prog, u64 start,
@@ -941,7 +918,7 @@ void notrace __bpf_prog_exit_sleepable_recur(struct bpf_prog *prog, u64 start,
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
-	update_prog_stats(prog, start);
+	bpf_prog_update_prog_stats(prog, start);
 	this_cpu_dec(*(prog->active));
 	migrate_enable();
 	rcu_read_unlock_trace();
@@ -964,7 +941,7 @@ static void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
-	update_prog_stats(prog, start);
+	bpf_prog_update_prog_stats(prog, start);
 	migrate_enable();
 	rcu_read_unlock_trace();
 }
@@ -987,7 +964,7 @@ static void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start,
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
-	update_prog_stats(prog, start);
+	bpf_prog_update_prog_stats(prog, start);
 	migrate_enable();
 	rcu_read_unlock();
 }
-- 
2.41.0


