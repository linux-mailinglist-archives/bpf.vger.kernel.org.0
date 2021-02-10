Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D2C315DD4
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 04:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhBJDhW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 22:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBJDhW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 22:37:22 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7096C0613D6
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 19:36:41 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d13so470263plg.0
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 19:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5SV31HHqNCcKBFeDxG3LbKD4+UJszJ3Kjx+Y27qFo9I=;
        b=PrUx6QEdXJX0gkeE17/yvtNzXuUjILFtMF/8GlEj0WxndrZ14ibS2zZo19h1e9qKe9
         zfvFfjE9uD9To0VAN29Z3SEdAsZtXd1ffTaEsJceGyuaLRLBwOko2YZv+rtYJd/i8RaP
         GxiLABsGxcZ6+HhDlssHQ/wMQrz+ZFHfPXWrht2gXqucs419ba+yFmLycDrBVt2yVzbd
         99bBtI1AuE7LLzZd0MXyCOn6tJUeqbJM3Y0hy928JCTmYbQsi4Bz0uQqfrMwrKc4YfKH
         omsSzMEMNvQvgn+1IOz8R2JLeenCknfmfoZam+MW3cH+kWJkyoGmQh3oyYee5Sb6INsR
         bSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5SV31HHqNCcKBFeDxG3LbKD4+UJszJ3Kjx+Y27qFo9I=;
        b=F8KL7g51+gNPzRbUTNyU551+zCYzRV0+ZJ1q27TFM5jqEKdUVeU3tufk+k+GU7HoTL
         1xGHesw3JHrhLs8FbRYKJoDHtIMVZUwk8TiQnm/hIBvvnADliCWhQ38prQgPS63cQqiA
         nz7Q5///bfqJVUu8/Y514ArbOJnnSXesIU9VCC35cOZgE2j6XxzNYFGigkAmGE9EWcYP
         s03jctW9uq34YBcUHqqojy54oAOLbfToeRONxkgMEJPp1jX81269YW31dd2dl2avg4/O
         tom3Z0cYdyjcq8PGNIm35BG1lPrD3NTB4VcdHANwDluyH++9S3c7upRXUufrh8S9mViz
         OTxA==
X-Gm-Message-State: AOAM533CuO2aSl7vrrNjNdLf6FNnc/XI31N7It0cM+Dcme2/DTPNBM8i
        FfbAsrTO8zfYCftkom8f2xY=
X-Google-Smtp-Source: ABdhPJzztgj5B6QKhxOse3LV00EDRGES3ofysUoqWTAx2fPyT0q8Qaj6MZEeIN/A5Zy3zliIt4wHdA==
X-Received: by 2002:a17:90b:1297:: with SMTP id fw23mr1125154pjb.180.1612928201343;
        Tue, 09 Feb 2021 19:36:41 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id f7sm391099pjh.45.2021.02.09.19.36.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 19:36:40 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 3/9] bpf: Compute program stats for sleepable programs
Date:   Tue,  9 Feb 2021 19:36:28 -0800
Message-Id: <20210210033634.62081-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
References: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Since sleepable programs don't migrate from the cpu the excution stats can be
computed for them as well. Reuse the same infrastructure for both sleepable and
non-sleepable programs.
run_cnt     -> the number of times the program was executed.
run_time_ns -> the program execution time in nanoseconds including the
               off-cpu time when the program was sleeping.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: KP Singh <kpsingh@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 31 +++++++++++----------------
 include/linux/bpf.h         |  4 ++--
 kernel/bpf/trampoline.c     | 42 ++++++++++++++++++++++++-------------
 3 files changed, 42 insertions(+), 35 deletions(-)

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
index 89fc849ba271..48eb021e1421 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -381,56 +381,70 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
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
 	migrate_disable();
 	might_fault();
+	return bpf_prog_start_time();
 }
 
-void notrace __bpf_prog_exit_sleepable(void)
+void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start)
 {
+	update_prog_stats(prog, start);
 	migrate_enable();
 	rcu_read_unlock_trace();
 }
-- 
2.24.1

