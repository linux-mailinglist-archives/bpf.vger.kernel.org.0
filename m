Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CE251EB43
	for <lists+bpf@lfdr.de>; Sun,  8 May 2022 05:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiEHDZj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 7 May 2022 23:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiEHDZi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 7 May 2022 23:25:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE21DE0F7
        for <bpf@vger.kernel.org>; Sat,  7 May 2022 20:21:49 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2482ARjD015021
        for <bpf@vger.kernel.org>; Sat, 7 May 2022 20:21:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ltaLDHt02iJ6qccpiZ4LYwDxdyEhUEOyNx3sblCjcVI=;
 b=UmoD+U7Iw+LlF2RASYnUcuZ3t/DEsYGCTcvheC2O3G+cFHjx2sMuc2PDDJFHkvo0PkDh
 /BukpR4Gi5AQdmPkmfm2ycUSSzx4AE32HthmzWDaFLBZq9WHB9Liici4tr3TrzYz9ixj
 kOtkrUD/pr8OsxXaYtmXW16DwoSvuFckPo0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fx4u0g4cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 07 May 2022 20:21:48 -0700
Received: from twshared8307.18.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 7 May 2022 20:21:47 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id C69273170386; Sat,  7 May 2022 20:21:34 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v7 2/5] bpf, x86: Create bpf_tramp_run_ctx on the caller thread's stack
Date:   Sat, 7 May 2022 20:21:14 -0700
Message-ID: <20220508032117.2783209-3-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220508032117.2783209-1-kuifeng@fb.com>
References: <20220508032117.2783209-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lAXr7zHHu-qCPmzyLSB7Sqyt6DEpzFJ4
X-Proofpoint-GUID: lAXr7zHHu-qCPmzyLSB7Sqyt6DEpzFJ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_01,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF trampolines will create a bpf_tramp_run_ctx, a bpf_run_ctx, on
stacks and set/reset the current bpf_run_ctx before/after calling a
bpf_prog.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 38 +++++++++++++++++++++++++++++++++++++
 include/linux/bpf.h         | 17 +++++++++++++----
 kernel/bpf/syscall.c        |  7 +++++--
 kernel/bpf/trampoline.c     | 20 +++++++++++++++----
 4 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 4dcc0b1ac770..bf4576a6938c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1766,10 +1766,26 @@ static int invoke_bpf_prog(const struct btf_func_=
model *m, u8 **pprog,
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
+	 * mov QWORD PTR [rsp + ctx_cookie_off], rdi
+	 */
+	EMIT4(0x48, 0x89, 0x7C, 0x24); EMIT1(ctx_cookie_off);
+
 	/* arg1: mov rdi, progs[i] */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
+	/* arg2: mov rsi, rsp (struct bpf_run_ctx *) */
+	EMIT3(0x48, 0x89, 0xE6);
+
 	if (emit_call(&prog,
 		      p->aux->sleepable ? __bpf_prog_enter_sleepable :
 		      __bpf_prog_enter, prog))
@@ -1815,6 +1831,8 @@ static int invoke_bpf_prog(const struct btf_func_mo=
del *m, u8 **pprog,
 	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
 	/* arg2: mov rsi, rbx <- start time in nsec */
 	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
+	/* arg3: mov rdx, rsp (struct bpf_run_ctx *) */
+	EMIT3(0x48, 0x89, 0xE2);
 	if (emit_call(&prog,
 		      p->aux->sleepable ? __bpf_prog_exit_sleepable :
 		      __bpf_prog_exit, prog))
@@ -2079,6 +2097,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 		}
 	}
=20
+	/* Prepare struct bpf_tramp_run_ctx.
+	 * sub rsp, sizeof(struct bpf_tramp_run_ctx)
+	 */
+	EMIT4(0x48, 0x83, 0xEC, sizeof(struct bpf_tramp_run_ctx));
+
 	if (fentry->nr_links)
 		if (invoke_bpf(m, &prog, fentry, regs_off,
 			       flags & BPF_TRAMP_F_RET_FENTRY_RET))
@@ -2098,6 +2121,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 	}
=20
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
+		/* pop struct bpf_tramp_run_ctx
+		 * add rsp, sizeof(struct bpf_tramp_run_ctx)
+		 */
+		EMIT4(0x48, 0x83, 0xC4, sizeof(struct bpf_tramp_run_ctx));
+
 		restore_regs(m, &prog, nr_args, regs_off);
=20
 		/* call original function */
@@ -2110,6 +2138,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 		im->ip_after_call =3D prog;
 		memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
 		prog +=3D X86_PATCH_SIZE;
+
+		/* Prepare struct bpf_tramp_run_ctx.
+		 * sub rsp, sizeof(struct bpf_tramp_run_ctx)
+		 */
+		EMIT4(0x48, 0x83, 0xEC, sizeof(struct bpf_tramp_run_ctx));
 	}
=20
 	if (fmod_ret->nr_links) {
@@ -2133,6 +2166,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 			goto cleanup;
 		}
=20
+	/* pop struct bpf_tramp_run_ctx
+	 * add rsp, sizeof(struct bpf_tramp_run_ctx)
+	 */
+	EMIT4(0x48, 0x83, 0xC4, sizeof(struct bpf_tramp_run_ctx));
+
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
 		restore_regs(m, &prog, nr_args, regs_off);
=20
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 77258a34ec20..29c3188195a6 100644
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
index 3c1853e1c715..5ed9a15daaee 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5001,6 +5001,7 @@ static bool syscall_prog_is_valid_access(int off, i=
nt size,
 BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr *, attr, u32, attr_size=
)
 {
 	struct bpf_prog * __maybe_unused prog;
+	struct bpf_tramp_run_ctx __maybe_unused run_ctx;
=20
 	switch (cmd) {
 	case BPF_MAP_CREATE:
@@ -5028,13 +5029,15 @@ BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr =
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

