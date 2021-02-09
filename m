Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4799B315834
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 22:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhBIU6W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 15:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbhBIUtj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 15:49:39 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C4AC061A2B
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 11:49:03 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 189so3550107pfy.6
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 11:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MNGdwGbANbqJcqGwhhUegJpSqmi9KuPKsburFwsLrqc=;
        b=Np5NxLULTz47d0ISAyxSbO3EpWTQ287YatJmqXnAomskjxFeRIJETQucSbVdHIbM3l
         /Cjkby0wKNUDqfB+yRHGYj5Q/n2TKk+/ULzaaFR3g3ns245jRTpKzABiI3u8PvCk7p0Z
         RcWbP/HkHB4vDIPJwM7T86UAG7fE0OAth8Mcii1blKdNqTK4fC7y8bbdopnXc7utqkYl
         HlxH09Lu2bC980TE9xb4u43CtkoYifSnXZq9J2P7TyJxPKWcr1T3NfcI838L62HXwIfd
         1YULjM5e7i7uAaB9ZgR+h9rb7KwKu5bflG7g4CYzilumHZH4caY2WBYlaE3YkXFjxp9k
         9+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MNGdwGbANbqJcqGwhhUegJpSqmi9KuPKsburFwsLrqc=;
        b=Sjxr9GWy2/w7Tep8Sm9NFkZcIMSiWXMiTQzIfn2K0bp8a9ytaETLugizUwLnPlG8L9
         ZNmlnTLWfQ5lDqCR/6yLE7yz3jvVXmLGLRqdnbIMw4LFd6xrKaXKD6JdH+PG5hQjGqlO
         taVDxkIzK2yMlpJW0irWt8JgASSvSllRn4UUawPSk8cc9M0QKSlN3fN1Ej6y/9wUpmVR
         Z66hya+pzoNdhFcH3Z5vPicB/lETbgMm3Vw5PxERxXIXGLSvDzikPeYZ7/4YrSs+cq8j
         lmzIysUWv+qn2925b2UnmOZQD5oWMXmToglxHwmnn6BTaYfpSJrDM9jD41cT/otasPxc
         dWbg==
X-Gm-Message-State: AOAM5327lvQypSQT/mYjqAdbUL2iYpE5tev9Q6979YdEB4iLZKigE0ST
        7wM5rU4VY3+24h90smLjXGY=
X-Google-Smtp-Source: ABdhPJzx+yEye8CkFQxNl3BELC/VONpsJntMuL/MLdy1mhqqcJy3jVpEN0VuPiOPKy5s1Kch14DBcw==
X-Received: by 2002:a63:4713:: with SMTP id u19mr23210902pga.209.1612900142907;
        Tue, 09 Feb 2021 11:49:02 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j22sm139123pff.57.2021.02.09.11.49.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:49:02 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 3/8] bpf: Add per-program recursion prevention mechanism
Date:   Tue,  9 Feb 2021 11:48:51 -0800
Message-Id: <20210209194856.24269-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Since both sleepable and non-sleepable programs execute under migrate_disable
add recursion prevention mechanism to both types of programs when they're
executed via bpf trampoline.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c                   | 15 ++++++++++++
 include/linux/bpf.h                           |  6 ++---
 include/linux/filter.h                        |  1 +
 kernel/bpf/core.c                             |  8 +++++++
 kernel/bpf/trampoline.c                       | 23 +++++++++++++++----
 .../selftests/bpf/prog_tests/fexit_stress.c   |  4 ++--
 .../bpf/prog_tests/trampoline_count.c         |  4 ++--
 7 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d11b9bcebbea..79e7a0ec1da5 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1740,8 +1740,11 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 			   struct bpf_prog *p, int stack_size, bool mod_ret)
 {
 	u8 *prog = *pprog;
+	u8 *jmp_insn;
 	int cnt = 0;
 
+	/* arg1: mov rdi, progs[i] */
+	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
 	if (emit_call(&prog,
 		      p->aux->sleepable ? __bpf_prog_enter_sleepable :
 		      __bpf_prog_enter, prog))
@@ -1749,6 +1752,14 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	/* remember prog start time returned by __bpf_prog_enter */
 	emit_mov_reg(&prog, true, BPF_REG_6, BPF_REG_0);
 
+	/* if (__bpf_prog_enter*(prog) == 0)
+	 *	goto skip_exec_of_prog;
+	 */
+	EMIT3(0x48, 0x85, 0xC0);  /* test rax,rax */
+	/* emit 2 nops that will be replaced with JE insn */
+	jmp_insn = prog;
+	emit_nops(&prog, 2);
+
 	/* arg1: lea rdi, [rbp - stack_size] */
 	EMIT4(0x48, 0x8D, 0x7D, -stack_size);
 	/* arg2: progs[i]->insnsi for interpreter */
@@ -1767,6 +1778,10 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	if (mod_ret)
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 
+	/* replace 2 nops with JE insn, since jmp target is known */
+	jmp_insn[0] = X86_JE;
+	jmp_insn[1] = prog - jmp_insn - 2;
+
 	/* arg1: mov rdi, progs[i] */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
 	/* arg2: mov rsi, rbx <- start time in nsec */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2fa48439ef31..6f019b06a2fd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -529,7 +529,7 @@ struct btf_func_model {
 /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
  * bytes on x86.  Pick a number to fit into BPF_IMAGE_SIZE / 2
  */
-#define BPF_MAX_TRAMP_PROGS 40
+#define BPF_MAX_TRAMP_PROGS 38
 
 struct bpf_tramp_progs {
 	struct bpf_prog *progs[BPF_MAX_TRAMP_PROGS];
@@ -561,9 +561,9 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 				struct bpf_tramp_progs *tprogs,
 				void *orig_call);
 /* these two functions are called from generated trampoline */
-u64 notrace __bpf_prog_enter(void);
+u64 notrace __bpf_prog_enter(struct bpf_prog *prog);
 void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start);
-u64 notrace __bpf_prog_enter_sleepable(void);
+u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog);
 void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start);
 
 struct bpf_ksym {
diff --git a/include/linux/filter.h b/include/linux/filter.h
index cecb03c9d251..6a06f3c69f4e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -565,6 +565,7 @@ struct bpf_prog {
 	u32			jited_len;	/* Size of jited insns in bytes */
 	u8			tag[BPF_TAG_SIZE];
 	struct bpf_prog_stats __percpu *stats;
+	int __percpu		*active;
 	unsigned int		(*bpf_func)(const void *ctx,
 					    const struct bpf_insn *insn);
 	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2cf71fd39c22..334070c4b8a1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -91,6 +91,12 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 		vfree(fp);
 		return NULL;
 	}
+	fp->active = alloc_percpu_gfp(int, GFP_KERNEL_ACCOUNT | gfp_extra_flags);
+	if (!fp->active) {
+		vfree(fp);
+		kfree(aux);
+		return NULL;
+	}
 
 	fp->pages = size / PAGE_SIZE;
 	fp->aux = aux;
@@ -116,6 +122,7 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
 
 	prog->stats = alloc_percpu_gfp(struct bpf_prog_stats, gfp_flags);
 	if (!prog->stats) {
+		free_percpu(prog->active);
 		kfree(prog->aux);
 		vfree(prog);
 		return NULL;
@@ -253,6 +260,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
 		kfree(fp->aux);
 	}
 	free_percpu(fp->stats);
+	free_percpu(fp->active);
 	vfree(fp);
 }
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 48eb021e1421..89ef6320d19b 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -381,13 +381,16 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	mutex_unlock(&trampoline_mutex);
 }
 
-#define NO_START_TIME 0
+#define NO_START_TIME 1
 static u64 notrace bpf_prog_start_time(void)
 {
 	u64 start = NO_START_TIME;
 
-	if (static_branch_unlikely(&bpf_stats_enabled_key))
+	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
 		start = sched_clock();
+		if (unlikely(!start))
+			start = NO_START_TIME;
+	}
 	return start;
 }
 
@@ -397,12 +400,20 @@ static u64 notrace bpf_prog_start_time(void)
  * call __bpf_prog_enter
  * call prog->bpf_func
  * call __bpf_prog_exit
+ *
+ * __bpf_prog_enter returns:
+ * 0 - skip execution of the bpf prog
+ * 1 - execute bpf prog
+ * [2..MAX_U64] - excute bpf prog and record execution time.
+ *     This is start time.
  */
-u64 notrace __bpf_prog_enter(void)
+u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
 	__acquires(RCU)
 {
 	rcu_read_lock();
 	migrate_disable();
+	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1))
+		return 0;
 	return bpf_prog_start_time();
 }
 
@@ -430,21 +441,25 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
 	__releases(RCU)
 {
 	update_prog_stats(prog, start);
+	__this_cpu_dec(*(prog->active));
 	migrate_enable();
 	rcu_read_unlock();
 }
 
-u64 notrace __bpf_prog_enter_sleepable(void)
+u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog)
 {
 	rcu_read_lock_trace();
 	migrate_disable();
 	might_fault();
+	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1))
+		return 0;
 	return bpf_prog_start_time();
 }
 
 void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start)
 {
 	update_prog_stats(prog, start);
+	__this_cpu_dec(*(prog->active));
 	migrate_enable();
 	rcu_read_unlock_trace();
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
index 3b9dbf7433f0..7c9b62e971f1 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
@@ -2,8 +2,8 @@
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
 
-/* x86-64 fits 55 JITed and 43 interpreted progs into half page */
-#define CNT 40
+/* that's kernel internal BPF_MAX_TRAMP_PROGS define */
+#define CNT 38
 
 void test_fexit_stress(void)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
index 781c8d11604b..f3022d934e2d 100644
--- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
+++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
@@ -4,7 +4,7 @@
 #include <sys/prctl.h>
 #include <test_progs.h>
 
-#define MAX_TRAMP_PROGS 40
+#define MAX_TRAMP_PROGS 38
 
 struct inst {
 	struct bpf_object *obj;
@@ -52,7 +52,7 @@ void test_trampoline_count(void)
 	struct bpf_link *link;
 	char comm[16] = {};
 
-	/* attach 'allowed' 40 trampoline programs */
+	/* attach 'allowed' trampoline programs */
 	for (i = 0; i < MAX_TRAMP_PROGS; i++) {
 		obj = bpf_object__open_file(object, NULL);
 		if (CHECK(IS_ERR(obj), "obj_open_file", "err %ld\n", PTR_ERR(obj))) {
-- 
2.24.1

