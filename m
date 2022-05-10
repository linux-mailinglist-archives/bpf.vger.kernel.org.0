Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB675225FA
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 23:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiEJVAF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 17:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiEJU77 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 16:59:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962C3267083
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 13:59:57 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFLTiW025143
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 13:59:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=O1sxVl5cdYbIzk7ZOofNri5htLyOoFbYcK47nwyIU/E=;
 b=Px5aC/zBovQRg6kObNdCTQRNYatNNh1U83mihQSD5bpeaQEvfC28YewW+bt8sDviIApU
 HCttE4uTb48r0uBymyjzl7iDT//2qf9n41Mbkm6b6yX8lIJFnjmEhkh6sZgSWaqJ18DO
 3mf4tliusl3nOp+PhWYDSoTYidjJ0lLoTJw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fyn47vt1t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 13:59:56 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 13:59:55 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 0EAFC32F2031; Tue, 10 May 2022 13:59:43 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v8 2/5] bpf, x86: Create bpf_tramp_run_ctx on the caller thread's stack
Date:   Tue, 10 May 2022 13:59:20 -0700
Message-ID: <20220510205923.3206889-3-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220510205923.3206889-1-kuifeng@fb.com>
References: <20220510205923.3206889-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bYZmKxTUbTR2mi8IysdFCyg5th-Ei-tI
X-Proofpoint-GUID: bYZmKxTUbTR2mi8IysdFCyg5th-Ei-tI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF trampolines will create a bpf_tramp_run_ctx, a bpf_run_ctx, on
stacks and set/reset the current bpf_run_ctx before/after calling a
bpf_prog.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 41 +++++++++++++++++++++++++++++--------
 include/linux/bpf.h         | 17 +++++++++++----
 kernel/bpf/syscall.c        |  7 +++++--
 kernel/bpf/trampoline.c     | 20 ++++++++++++++----
 4 files changed, 66 insertions(+), 19 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 38eb43159230..1fbc5cf1c7a7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1763,14 +1763,30 @@ static void restore_regs(const struct btf_func_mo=
del *m, u8 **prog, int nr_args,
=20
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 			   struct bpf_tramp_link *l, int stack_size,
-			   bool save_ret)
+			   int run_ctx_off, bool save_ret)
 {
 	u8 *prog =3D *pprog;
 	u8 *jmp_insn;
+	int ctx_cookie_off =3D offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 	struct bpf_prog *p =3D l->link.prog;
=20
+	/* mov rdi, 0 */
+	emit_mov_imm64(&prog, BPF_REG_1, 0, 0);
+
+	/* Prepare struct bpf_tramp_run_ctx.
+	 *
+	 * bpf_tramp_run_ctx is already preserved by
+	 * arch_prepare_bpf_trampoline().
+	 *
+	 * mov QWORD PTR [rbp - run_ctx_off + ctx_cookie_off], rdi
+	 */
+	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_1, -run_ctx_off + ctx_cooki=
e_off);
+
 	/* arg1: mov rdi, progs[i] */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
+	/* arg2: lea rsi, [rbp - ctx_cookie_off] */
+	EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
+
 	if (emit_call(&prog,
 		      p->aux->sleepable ? __bpf_prog_enter_sleepable :
 		      __bpf_prog_enter, prog))
@@ -1816,6 +1832,8 @@ static int invoke_bpf_prog(const struct btf_func_mo=
del *m, u8 **pprog,
 	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
 	/* arg2: mov rsi, rbx <- start time in nsec */
 	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
+	/* arg3: lea rdx, [rbp - run_ctx_off] */
+	EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
 	if (emit_call(&prog,
 		      p->aux->sleepable ? __bpf_prog_exit_sleepable :
 		      __bpf_prog_exit, prog))
@@ -1853,14 +1871,14 @@ static int emit_cond_near_jump(u8 **pprog, void *=
func, void *ip, u8 jmp_cond)
=20
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		      struct bpf_tramp_links *tl, int stack_size,
-		      bool save_ret)
+		      int run_ctx_off, bool save_ret)
 {
 	int i;
 	u8 *prog =3D *pprog;
=20
 	for (i =3D 0; i < tl->nr_links; i++) {
 		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
-				    save_ret))
+				    run_ctx_off, save_ret))
 			return -EINVAL;
 	}
 	*pprog =3D prog;
@@ -1869,7 +1887,7 @@ static int invoke_bpf(const struct btf_func_model *=
m, u8 **pprog,
=20
 static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog=
,
 			      struct bpf_tramp_links *tl, int stack_size,
-			      u8 **branches)
+			      int run_ctx_off, u8 **branches)
 {
 	u8 *prog =3D *pprog;
 	int i;
@@ -1880,7 +1898,7 @@ static int invoke_bpf_mod_ret(const struct btf_func=
_model *m, u8 **pprog,
 	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 	for (i =3D 0; i < tl->nr_links; i++) {
-		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, true))
+		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, t=
rue))
 			return -EINVAL;
=20
 		/* mod_ret prog stored return value into [rbp - 8]. Emit:
@@ -1986,7 +2004,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 				void *orig_call)
 {
 	int ret, i, nr_args =3D m->nr_args;
-	int regs_off, ip_off, args_off, stack_size =3D nr_args * 8;
+	int regs_off, ip_off, args_off, stack_size =3D nr_args * 8, run_ctx_off=
;
 	struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -2016,6 +2034,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 	 * RBP - args_off  [ args count      ]  always
 	 *
 	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
+	 *
+	 * RBP - run_ctx_off [ bpf_tramp_run_ctx ]
 	 */
=20
 	/* room for return value of orig_call or fentry prog */
@@ -2034,6 +2054,9 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
=20
 	ip_off =3D stack_size;
=20
+	stack_size +=3D (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
+	run_ctx_off =3D stack_size;
+
 	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
@@ -2081,7 +2104,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 	}
=20
 	if (fentry->nr_links)
-		if (invoke_bpf(m, &prog, fentry, regs_off,
+		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
 			       flags & BPF_TRAMP_F_RET_FENTRY_RET))
 			return -EINVAL;
=20
@@ -2092,7 +2115,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 			return -ENOMEM;
=20
 		if (invoke_bpf_mod_ret(m, &prog, fmod_ret, regs_off,
-				       branches)) {
+				       run_ctx_off, branches)) {
 			ret =3D -EINVAL;
 			goto cleanup;
 		}
@@ -2129,7 +2152,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 	}
=20
 	if (fexit->nr_links)
-		if (invoke_bpf(m, &prog, fexit, regs_off, false)) {
+		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off, false)) {
 			ret =3D -EINVAL;
 			goto cleanup;
 		}
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 75e0110a65e1..256fb802e580 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -730,6 +730,8 @@ struct bpf_tramp_links {
 	int nr_links;
 };
=20
+struct bpf_tramp_run_ctx;
+
 /* Different use cases for BPF trampoline:
  * 1. replace nop at the function entry (kprobe equivalent)
  *    flags =3D BPF_TRAMP_F_RESTORE_REGS
@@ -756,10 +758,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *tr, void *image, void *i
 				struct bpf_tramp_links *tlinks,
 				void *orig_call);
 /* these two functions are called from generated trampoline */
-u64 notrace __bpf_prog_enter(struct bpf_prog *prog);
-void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start);
-u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog);
-void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start)=
;
+u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_tramp_run=
_ctx *run_ctx);
+void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bp=
f_tramp_run_ctx *run_ctx);
+u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf=
_tramp_run_ctx *run_ctx);
+void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
+				       struct bpf_tramp_run_ctx *run_ctx);
 void notrace __bpf_tramp_enter(struct bpf_tramp_image *tr);
 void notrace __bpf_tramp_exit(struct bpf_tramp_image *tr);
=20
@@ -1351,6 +1354,12 @@ struct bpf_trace_run_ctx {
 	u64 bpf_cookie;
 };
=20
+struct bpf_tramp_run_ctx {
+	struct bpf_run_ctx run_ctx;
+	u64 bpf_cookie;
+	struct bpf_run_ctx *saved_run_ctx;
+};
+
 static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *ne=
w_ctx)
 {
 	struct bpf_run_ctx *old_ctx =3D NULL;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2dc582773344..d48165fccf49 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5020,6 +5020,7 @@ static bool syscall_prog_is_valid_access(int off, i=
nt size,
 BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr *, attr, u32, attr_size=
)
 {
 	struct bpf_prog * __maybe_unused prog;
+	struct bpf_tramp_run_ctx __maybe_unused run_ctx;
=20
 	switch (cmd) {
 	case BPF_MAP_CREATE:
@@ -5047,13 +5048,15 @@ BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr =
*, attr, u32, attr_size)
 			return -EINVAL;
 		}
=20
-		if (!__bpf_prog_enter_sleepable(prog)) {
+		run_ctx.bpf_cookie =3D 0;
+		run_ctx.saved_run_ctx =3D NULL;
+		if (!__bpf_prog_enter_sleepable(prog, &run_ctx)) {
 			/* recursion detected */
 			bpf_prog_put(prog);
 			return -EBUSY;
 		}
 		attr->test.retval =3D bpf_prog_run(prog, (void *) (long) attr->test.ct=
x_in);
-		__bpf_prog_exit_sleepable(prog, 0 /* bpf_prog_run does runtime stats *=
/);
+		__bpf_prog_exit_sleepable(prog, 0 /* bpf_prog_run does runtime stats *=
/, &run_ctx);
 		bpf_prog_put(prog);
 		return 0;
 #endif
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d5e6bc5517cb..baf1b65d523e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -568,11 +568,14 @@ static void notrace inc_misses_counter(struct bpf_p=
rog *prog)
  * [2..MAX_U64] - execute bpf prog and record execution time.
  *     This is start time.
  */
-u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
+u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_tramp_run=
_ctx *run_ctx)
 	__acquires(RCU)
 {
 	rcu_read_lock();
 	migrate_disable();
+
+	run_ctx->saved_run_ctx =3D bpf_set_run_ctx(&run_ctx->run_ctx);
+
 	if (unlikely(__this_cpu_inc_return(*(prog->active)) !=3D 1)) {
 		inc_misses_counter(prog);
 		return 0;
@@ -602,29 +605,38 @@ static void notrace update_prog_stats(struct bpf_pr=
og *prog,
 	}
 }
=20
-void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
+void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bp=
f_tramp_run_ctx *run_ctx)
 	__releases(RCU)
 {
+	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
+
 	update_prog_stats(prog, start);
 	__this_cpu_dec(*(prog->active));
 	migrate_enable();
 	rcu_read_unlock();
 }
=20
-u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog)
+u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf=
_tramp_run_ctx *run_ctx)
 {
 	rcu_read_lock_trace();
 	migrate_disable();
 	might_fault();
+
 	if (unlikely(__this_cpu_inc_return(*(prog->active)) !=3D 1)) {
 		inc_misses_counter(prog);
 		return 0;
 	}
+
+	run_ctx->saved_run_ctx =3D bpf_set_run_ctx(&run_ctx->run_ctx);
+
 	return bpf_prog_start_time();
 }
=20
-void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start)
+void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
+				       struct bpf_tramp_run_ctx *run_ctx)
 {
+	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
+
 	update_prog_stats(prog, start);
 	__this_cpu_dec(*(prog->active));
 	migrate_enable();
--=20
2.30.2

