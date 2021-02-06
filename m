Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30551311F00
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 18:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBFREd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 12:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhBFREb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 12:04:31 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78815C061788
        for <bpf@vger.kernel.org>; Sat,  6 Feb 2021 09:03:51 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r38so6794696pgk.13
        for <bpf@vger.kernel.org>; Sat, 06 Feb 2021 09:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CMUWVcBFZHedOBGTuoxTZ3omlhPCC7K8wX4mPvdiLrw=;
        b=nAaCk7Qyrh3EhZxPk4tBbMhE+Ls346o7lVgyDBNFhOWnfpYnz5LSoZ6+PvVAqvkmWF
         TdHkktElqGgkdVn/ekFc+/YISj5nD54Y5oRFRnmLtmlHM9AxrHR76+gZxZVUMH61R25b
         h329hhvneQVB9n9xRMFrP+sp356jKwyz7EDygTA/qnTwKLusbyVcbpz53iyehnXDQZRf
         MFBRgv6nnGwVz7wALIna6IwqQqtSao1GX09L8BtrkZNl/mLa2bzC9k9aJ6bYx6CxFFyj
         ZP4oN8cdG4V5kZpBftu6fTXhaTX/Q7Xih7nHcSgOsh4xImevP0gTlOEBFr3XNGppStE7
         M3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CMUWVcBFZHedOBGTuoxTZ3omlhPCC7K8wX4mPvdiLrw=;
        b=XqviM2EoSaDIZ5QvXxdmx5Xc2JFHa09w6yaK5zzGhPrMPdNOTXa2vzK0t2g8kG+2Ub
         4GTL5/YGQmXNbFcRAmhF+faVXUqgohsWG7Q8hqwCXmtPrCgTiOUb3VoDYgUKcbSlw1mM
         VWHSifYqfMYEJMEoBX5WahUeOjZjkdqSq83uPP9XerD3guoBR4ldSy1zIo+A+Fm4jjfj
         2OzigPwgKew7rt/iG1QWuIhX8IikP6/AGwUfEaUSS1XBFfbj9SwVivEteojEUg1QBZkM
         zislvaQoHJgCRd/fQgzeY195ywDpJnXbfAAm6tkLW695J0sWBD5/fHS0wx/DJ6MDXyR0
         PY4A==
X-Gm-Message-State: AOAM5324bpg3a+5FbO+uXjPNKSCwIrPvk0Fvx2bkVp5EiBUSTBfjhhv9
        dA/HIM+O96kl0rnbqdm8tCU=
X-Google-Smtp-Source: ABdhPJyzDJ+H6hhlxyqIXHRM1w1m4dJg9EKU9UZXWN6RDq0+T5PGeTWthH6cvGT77OgdETOtvxNHDQ==
X-Received: by 2002:a62:d453:0:b029:1d6:587b:5d31 with SMTP id u19-20020a62d4530000b02901d6587b5d31mr10130171pfl.58.1612631031046;
        Sat, 06 Feb 2021 09:03:51 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j14sm11149964pjl.35.2021.02.06.09.03.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2021 09:03:50 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 3/7] bpf: Add per-program recursion prevention mechanism
Date:   Sat,  6 Feb 2021 09:03:40 -0800
Message-Id: <20210206170344.78399-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Since both sleepable and non-sleepable programs execute under migrate_disable
add recursion prevention mechanism to both types of programs when they're
executed via bpf trampoline.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c                   | 15 +++++++++++++
 include/linux/bpf.h                           |  6 ++---
 include/linux/filter.h                        |  1 +
 kernel/bpf/core.c                             |  8 +++++++
 kernel/bpf/trampoline.c                       | 22 ++++++++++++++-----
 .../selftests/bpf/prog_tests/fexit_stress.c   |  2 +-
 .../bpf/prog_tests/trampoline_count.c         |  4 ++--
 7 files changed, 47 insertions(+), 11 deletions(-)

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
index c6592590a0b7..d6c740eac056 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -567,6 +567,7 @@ struct bpf_prog {
 	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
 	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
 	struct bpf_prog_stats __percpu *stats;
+	int __percpu		*active;
 	unsigned int		(*bpf_func)(const void *ctx,
 					    const struct bpf_insn *insn);
 	/* Instructions for interpreter */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index fa3da4cda476..f4560dbe7f31 100644
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
@@ -250,6 +257,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
 		mutex_destroy(&fp->aux->used_maps_mutex);
 		mutex_destroy(&fp->aux->dst_mutex);
 		free_percpu(fp->stats);
+		free_percpu(fp->active);
 		kfree(fp->aux->poke_tab);
 		kfree(fp->aux);
 	}
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index b1f567514b7e..226f613ab289 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -388,16 +388,21 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
  * call prog->bpf_func
  * call __bpf_prog_exit
  */
-#define NO_START_TIME 0
-u64 notrace __bpf_prog_enter(void)
+#define NO_START_TIME 1
+u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
 	__acquires(RCU)
 {
 	u64 start = NO_START_TIME;
 
 	rcu_read_lock();
 	migrate_disable();
-	if (static_branch_unlikely(&bpf_stats_enabled_key))
+	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1))
+		return 0;
+	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
 		start = sched_clock();
+		if (unlikely(!start))
+			start = NO_START_TIME;
+	}
 	return start;
 }
 
@@ -425,25 +430,32 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
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
 	u64 start = NO_START_TIME;
 
 	rcu_read_lock_trace();
 	migrate_disable();
 	might_fault();
-	if (static_branch_unlikely(&bpf_stats_enabled_key))
+	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1))
+		return 0;
+	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
 		start = sched_clock();
+		if (unlikely(!start))
+			start = NO_START_TIME;
+	}
 	return start;
 }
 
 void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start)
 {
 	update_prog_stats(prog, start);
+	__this_cpu_dec(*(prog->active));
 	migrate_enable();
 	rcu_read_unlock_trace();
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
index 3b9dbf7433f0..4698b0d2de36 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
@@ -3,7 +3,7 @@
 #include <test_progs.h>
 
 /* x86-64 fits 55 JITed and 43 interpreted progs into half page */
-#define CNT 40
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

