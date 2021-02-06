Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A57311EFF
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 18:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhBFREb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 12:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhBFREa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 12:04:30 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28187C061786
        for <bpf@vger.kernel.org>; Sat,  6 Feb 2021 09:03:50 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 18so4375992pfz.3
        for <bpf@vger.kernel.org>; Sat, 06 Feb 2021 09:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S67ZeRVzcEN0snJDOlrqZLmTeWhE/3fYH9/pS1rwHII=;
        b=Q+elz5XZE5U+FIO1wnGagxvFc1jl3wkey8xzxc2+Ur6JQuRSuH6RydFl+3F62dUK5a
         HX3z9KGMf0bmEQgLiFF13pGrwggxwzdXhbdhcz+sd5sL7XmwpklIg8EduBC/ybLuYKtT
         OylAOrc+sLg4CvShloRVF7qQh5PlgIGNjsfkEizwt9GK/E0tlYxKqUqhZAigCGyOLwRM
         QH/xMuSkdnQymNpc1nDGu4wqazwk1XL68gtXTWvI5q3CQJFvTENadYJnCHOSIeUHxOql
         1gRtlmcD7w/ysjPh5jJisyEdOf6adjErzm150/KmTvWwMSUPKoTqjmZgVl8cxxPHEmHA
         sAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S67ZeRVzcEN0snJDOlrqZLmTeWhE/3fYH9/pS1rwHII=;
        b=bFAbzQMJfXzGbIBv4vHjIsi4UaSyAYaT+o2/q+OfH4eqDNTO/CJY5L1hIIBtveKECW
         nwgpMzduP/eeAT5zm5t6+l+lpNAD9VDMCbl3xuCQbacY5JYnTc5RmlMFKBJ7JroKyVu0
         wipeFv2ltoQNHiNvRE5o0AGTAJOu2FYG40/S1AfToyrxSgD5OaovSkpdw+W5I1QlOpgk
         iSjwxnFOOzSopDsAQgtfvT7yUGg8PjZszt+WErJvGfEg1EcyFRPvMmuTri8AA7S/BrfC
         mjyjAfPANnfxCIaSi2aHW2xOqSF4DYViE8vYhAUEIgHq8n3EEJhS/N/ei3LN1ekFNftz
         O9Yw==
X-Gm-Message-State: AOAM530TWdxmQUjWzG12W5abu0R24eQ2tQtJSVKd9qsfJnaH6oqoDu7C
        fiehEw67Avrc6pZs5qdSNEo5/JFZznI=
X-Google-Smtp-Source: ABdhPJxcM7tbEVt1bymZn5/4LeNd8WpDD88hcYcfXUEi9f4Mn0uL7sR1oXjrtvIKH1+pCA89+6gPXA==
X-Received: by 2002:a62:fc83:0:b029:1d6:1767:dd1c with SMTP id e125-20020a62fc830000b02901d61767dd1cmr10115526pfh.70.1612631029692;
        Sat, 06 Feb 2021 09:03:49 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j14sm11149964pjl.35.2021.02.06.09.03.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2021 09:03:49 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 2/7] bpf: Compute program stats for sleepable programs
Date:   Sat,  6 Feb 2021 09:03:39 -0800
Message-Id: <20210206170344.78399-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
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

