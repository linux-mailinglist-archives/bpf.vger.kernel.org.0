Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75604311BC7
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 07:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBFG62 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 01:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBFG61 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 01:58:27 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A8DC061786
        for <bpf@vger.kernel.org>; Fri,  5 Feb 2021 22:57:46 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o21so4734391pgn.12
        for <bpf@vger.kernel.org>; Fri, 05 Feb 2021 22:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S67ZeRVzcEN0snJDOlrqZLmTeWhE/3fYH9/pS1rwHII=;
        b=BdCohcsWu9aQ8Yq/O9WQNOuqyFUVprtNNg28QCYKafssoxWQvMEPXxAo2S7QerKOV+
         o0dSx1nJFfiFfPvsxl8pz9Bl0NNBlAm3d00Jwa7qJwmYYlgxnl/upE8Qpukvt8rjDiC9
         XIa/ZpWGzGesLrwUNzKOH2rc5+ca0ic2IBi7Mg3URlzQnNUHUBLRuNf2tNpovIVx3LpW
         t7wnWTL2ES/xOkuIE1/SGdb116n63xN0kpMXZZx6nHqK8VKb8pI44yZJpdrv/KoXRlRQ
         gl6TvOYrcuJL07x1Zz2wtMfb0CamyGTckuRyJPXivoGAXHd7A4ButOp7ytc7CH5QGTcW
         j5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S67ZeRVzcEN0snJDOlrqZLmTeWhE/3fYH9/pS1rwHII=;
        b=mADYxQp8lZ+tlzQ8YBWwoCMbaW+j9/uxFT+vSSSk9iTtly7QdCiDo+Loxp0FwUb6Hl
         eRvRUFr1swBl8rfIAa4Dk4DJ50sIsgDwnrDeDZ0JcZ/qOSaF4iBAUhegwWNHt9dfDvX8
         LNgpkOpk1yZzi3nuMEhJOwdNqqhiilnMxS+MroB9FLJtg8b2/BHRXYbL6LsXdYGrA1E9
         3JVM3FoiPWv7bZiBm5dr+YiV6hpaqeO9OiDpnKSSTrZJ5VwscrnTNRvF8sO3FiIWLbfC
         0VYqdzhi0j+/fhKb7gJAzHxnE2CsP7ViiqgqpL2gecw9XAQHjfQX5L0Q98ge5/PPDm9e
         bDIw==
X-Gm-Message-State: AOAM531KgFqOqtL1S55Dxj3Dwiik+AK46Yu4HKnhjj8oVXlktokstTmr
        UJccrHq43psmloDGDieAvvQFFNwLz2I=
X-Google-Smtp-Source: ABdhPJzNZuFqh1Q2l8HoGXamkWH+UsGL/prY7Hb1BOtEJXLvvyF4029+uC1XhQxoM8IYRDQUGGrB4Q==
X-Received: by 2002:a62:c302:0:b029:1d0:3720:328c with SMTP id v2-20020a62c3020000b02901d03720328cmr8127967pfg.48.1612594666455;
        Fri, 05 Feb 2021 22:57:46 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id r9sm12065093pfq.8.2021.02.05.22.57.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 22:57:45 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 2/5] bpf: Compute program stats for sleepable programs
Date:   Fri,  5 Feb 2021 22:57:38 -0800
Message-Id: <20210206065741.59188-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210206065741.59188-1-alexei.starovoitov@gmail.com>
References: <20210206065741.59188-1-alexei.starovoitov@gmail.com>
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
---
 arch/x86/net/bpf_jit_comp.c | 31 ++++++++++++-------------------
 include/linux/bpf.h         |  4 ++--
 kernel/bpf/trampoline.c     | 27 +++++++++++++++++++++------
 3 files changed, 35 insertions(+), 27 deletions(-)

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
index 5be3beeedd74..b1f567514b7e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -388,10 +388,11 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
  * call prog->bpf_func
  * call __bpf_prog_exit
  */
+#define NO_START_TIME 0
 u64 notrace __bpf_prog_enter(void)
 	__acquires(RCU)
 {
-	u64 start = 0;
+	u64 start = NO_START_TIME;
 
 	rcu_read_lock();
 	migrate_disable();
@@ -400,8 +401,8 @@ u64 notrace __bpf_prog_enter(void)
 	return start;
 }
 
-void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
-	__releases(RCU)
+static void notrace update_prog_stats(struct bpf_prog *prog,
+				      u64 start)
 {
 	struct bpf_prog_stats *stats;
 
@@ -411,25 +412,39 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
 	     * And vice versa.
 	     * Hence check that 'start' is not zero.
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
+	u64 start = NO_START_TIME;
+
 	rcu_read_lock_trace();
+	migrate_disable();
 	might_fault();
+	if (static_branch_unlikely(&bpf_stats_enabled_key))
+		start = sched_clock();
+	return start;
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

