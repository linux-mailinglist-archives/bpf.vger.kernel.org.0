Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F137F31582F
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 22:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhBIU5Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 15:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbhBIUq7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 15:46:59 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04452C061222
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 11:49:02 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w18so12558025pfu.9
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 11:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3vjas0dSr/sNMy1vQsn1WdxL7zCTOwfv4OuxZNhqW2E=;
        b=iF8kk/Z4s0kCGFL1ArqgQ7TX4ThIzasMdbBhfqX9tlGJOGpDNZlSAJj+wqvwZlppPM
         JKP7P9sUaPV7JzB4tkI+c86a7df/k0xE7PmR996AtM/oeLRyGWDSR4UqCC/TTrcgyCUq
         7rhEsInhuIihr137WYeEFtCbNBNZ3lhBnyCLljZJufRnDMo7OkghTDIiz0wJJALCEhaO
         MXrhE6i9V9ZesWPpVTCNNnqpZlif+I3jKiEXZIgQrkYb7wwF3lRKwvrBwBN3cqz9Q5Mk
         5C49ijCHALJBlrbbDgr8Sz6u0UaxRXmQulb3R7eXkUtuvTg8qTHPLYDt8TphAohD7gYT
         K9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3vjas0dSr/sNMy1vQsn1WdxL7zCTOwfv4OuxZNhqW2E=;
        b=rDcJclJCPNez8JJnyFSd8qwH0uudn8XkUISqpZLtVykCVOk0TKX0x3jpqj927dm4o0
         x6p7/I4UiiFlHj1fbI+27ldeR/lhItZOnUEnZKHSZKA/nZSAH7R61PZIDFnA8L2Tfz6m
         43gFcB412jnjNlkvwFPAK7TFdrmudykE5ydIfR0RF5Zn9nlLLlNysIpsQkpCpIdzOcMw
         rnGwJ7n7UL2hXLu9biyg8m2fBq/mrPnSGj7qgOdkMLyxyM01eSI29erwavJSrKb9uPcq
         lbUQbH5D/IYxUSlFG+xGY+KuL7c8wVVWaZw3sH+AAkBkqtGbYeYVmmKFv40GTip+cNRQ
         SPPA==
X-Gm-Message-State: AOAM532jpPjky3GKxJABibzhvcDLkY9AdotsxUeT/HW53gHuNIu5IZ5V
        UfCZv4Ga4e/blxurQ4VtNXE=
X-Google-Smtp-Source: ABdhPJxTwrmXFkDnnMVc135v2RqvIDF/S5++zowtBA1LTK2VUVJqcajleipZVBamL+p9AiW5sXOS8w==
X-Received: by 2002:a63:2903:: with SMTP id p3mr22788435pgp.11.1612900141578;
        Tue, 09 Feb 2021 11:49:01 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j22sm139123pff.57.2021.02.09.11.49.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:49:01 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 2/8] bpf: Compute program stats for sleepable programs
Date:   Tue,  9 Feb 2021 11:48:50 -0800
Message-Id: <20210209194856.24269-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

In older non-RT kernels migrate_disable() was the same as preempt_disable().
Since commit 74d862b682f5 ("sched: Make migrate_disable/enable() independent of RT")
migrate_disable() is real and doesn't prevent sleeping.
Use it to efficiently compute execution stats for sleepable bpf programs.
migrate_disable() will also be used to enable per-cpu maps in sleepable programs
in the future patches.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 31 ++++++++++----------------
 include/linux/bpf.h         |  4 ++--
 kernel/bpf/trampoline.c     | 44 +++++++++++++++++++++++++------------
 3 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a3dc3bd154ac..d11b9bcebbea 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1742,15 +1742,12 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	u8 *prog = *pprog;
 	int cnt = 0;
 
-	if (p->aux->sleepable) {
-		if (emit_call(&prog, __bpf_prog_enter_sleepable, prog))
+	if (emit_call(&prog,
+		      p->aux->sleepable ? __bpf_prog_enter_sleepable :
+		      __bpf_prog_enter, prog))
 			return -EINVAL;
-	} else {
-		if (emit_call(&prog, __bpf_prog_enter, prog))
-			return -EINVAL;
-		/* remember prog start time returned by __bpf_prog_enter */
-		emit_mov_reg(&prog, true, BPF_REG_6, BPF_REG_0);
-	}
+	/* remember prog start time returned by __bpf_prog_enter */
+	emit_mov_reg(&prog, true, BPF_REG_6, BPF_REG_0);
 
 	/* arg1: lea rdi, [rbp - stack_size] */
 	EMIT4(0x48, 0x8D, 0x7D, -stack_size);
@@ -1770,18 +1767,14 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	if (mod_ret)
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 
-	if (p->aux->sleepable) {
-		if (emit_call(&prog, __bpf_prog_exit_sleepable, prog))
+	/* arg1: mov rdi, progs[i] */
+	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
+	/* arg2: mov rsi, rbx <- start time in nsec */
+	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
+	if (emit_call(&prog,
+		      p->aux->sleepable ? __bpf_prog_exit_sleepable :
+		      __bpf_prog_exit, prog))
 			return -EINVAL;
-	} else {
-		/* arg1: mov rdi, progs[i] */
-		emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32,
-			       (u32) (long) p);
-		/* arg2: mov rsi, rbx <- start time in nsec */
-		emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
-		if (emit_call(&prog, __bpf_prog_exit, prog))
-			return -EINVAL;
-	}
 
 	*pprog = prog;
 	return 0;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 026fa8873c5d..2fa48439ef31 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -563,8 +563,8 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 /* these two functions are called from generated trampoline */
 u64 notrace __bpf_prog_enter(void);
 void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start);
-void notrace __bpf_prog_enter_sleepable(void);
-void notrace __bpf_prog_exit_sleepable(void);
+u64 notrace __bpf_prog_enter_sleepable(void);
+void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start);
 
 struct bpf_ksym {
 	unsigned long		 start;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5be3beeedd74..48eb021e1421 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -381,55 +381,71 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	mutex_unlock(&trampoline_mutex);
 }
 
+#define NO_START_TIME 0
+static u64 notrace bpf_prog_start_time(void)
+{
+	u64 start = NO_START_TIME;
+
+	if (static_branch_unlikely(&bpf_stats_enabled_key))
+		start = sched_clock();
+	return start;
+}
+
 /* The logic is similar to BPF_PROG_RUN, but with an explicit
  * rcu_read_lock() and migrate_disable() which are required
  * for the trampoline. The macro is split into
- * call _bpf_prog_enter
+ * call __bpf_prog_enter
  * call prog->bpf_func
  * call __bpf_prog_exit
  */
 u64 notrace __bpf_prog_enter(void)
 	__acquires(RCU)
 {
-	u64 start = 0;
-
 	rcu_read_lock();
 	migrate_disable();
-	if (static_branch_unlikely(&bpf_stats_enabled_key))
-		start = sched_clock();
-	return start;
+	return bpf_prog_start_time();
 }
 
-void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
-	__releases(RCU)
+static void notrace update_prog_stats(struct bpf_prog *prog,
+				      u64 start)
 {
 	struct bpf_prog_stats *stats;
 
 	if (static_branch_unlikely(&bpf_stats_enabled_key) &&
-	    /* static_key could be enabled in __bpf_prog_enter
-	     * and disabled in __bpf_prog_exit.
+	    /* static_key could be enabled in __bpf_prog_enter*
+	     * and disabled in __bpf_prog_exit*.
 	     * And vice versa.
-	     * Hence check that 'start' is not zero.
+	     * Hence check that 'start' is valid.
 	     */
-	    start) {
+	    start > NO_START_TIME) {
 		stats = this_cpu_ptr(prog->stats);
 		u64_stats_update_begin(&stats->syncp);
 		stats->cnt++;
 		stats->nsecs += sched_clock() - start;
 		u64_stats_update_end(&stats->syncp);
 	}
+}
+
+void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
+	__releases(RCU)
+{
+	update_prog_stats(prog, start);
 	migrate_enable();
 	rcu_read_unlock();
 }
 
-void notrace __bpf_prog_enter_sleepable(void)
+u64 notrace __bpf_prog_enter_sleepable(void)
 {
 	rcu_read_lock_trace();
+	migrate_disable();
 	might_fault();
+	return bpf_prog_start_time();
 }
 
-void notrace __bpf_prog_exit_sleepable(void)
+void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start)
 {
+	update_prog_stats(prog, start);
+	migrate_enable();
 	rcu_read_unlock_trace();
 }
 
-- 
2.24.1

