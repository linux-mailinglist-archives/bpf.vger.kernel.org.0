Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB8D4F8811
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 21:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiDGT2l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 15:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiDGT2f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 15:28:35 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECA1283F72
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 12:26:26 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 237IAlGb012424
        for <bpf@vger.kernel.org>; Thu, 7 Apr 2022 12:26:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=aOMVzypwbM4melWUvSKDDONw6wyDrfXWldHE9ItHZng=;
 b=S8faRPJL+yxSKBuErv8TFqJpYv082LKtb3Aq5x/D9F2m3i0HzbD+SU52trwvXy7bD4jo
 RtnMZO+esoXDV5AAyqIRibuGYMsc+XfwGZB6Pv9gKdpVKIanSO6F675xel1phC0Z90P/
 JHn6xv8QPAgnxVw1tYHDR5S4JTfCO+ESMJo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f9gmr0yxt-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Apr 2022 12:26:26 -0700
Received: from twshared39027.37.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 12:26:24 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 28BB4200EE7F; Thu,  7 Apr 2022 12:26:17 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v3 2/5] bpf, x86: Create bpf_tramp_run_ctx on the caller thread's stack
Date:   Thu, 7 Apr 2022 12:25:49 -0700
Message-ID: <20220407192552.2343076-3-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407192552.2343076-1-kuifeng@fb.com>
References: <20220407192552.2343076-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DYNGZz4LnPV5RJD3iPtZVYjS5T4w0j4_
X-Proofpoint-GUID: DYNGZz4LnPV5RJD3iPtZVYjS5T4w0j4_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_04,2022-04-07_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
---
 arch/x86/net/bpf_jit_comp.c | 55 +++++++++++++++++++++++++++++++++++++
 include/linux/bpf.h         | 17 +++++++++---
 kernel/bpf/syscall.c        |  4 +--
 kernel/bpf/trampoline.c     | 23 +++++++++++++---
 4 files changed, 89 insertions(+), 10 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8a1720988996..61b72d537f5b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1748,10 +1748,26 @@ static int invoke_bpf_prog(const struct btf_func_=
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
@@ -1797,6 +1813,8 @@ static int invoke_bpf_prog(const struct btf_func_mo=
del *m, u8 **pprog,
 	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
 	/* arg2: mov rsi, rbx <- start time in nsec */
 	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
+	/* arg3: mov rdx, rsp (struct bpf_run_ctx *) */
+	EMIT3(0x48, 0x89, 0xE2);
 	if (emit_call(&prog,
 		      p->aux->sleepable ? __bpf_prog_exit_sleepable :
 		      __bpf_prog_exit, prog))
@@ -2057,6 +2075,16 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 		}
 	}
=20
+	if (nr_args < 3 && (fentry->nr_links || fexit->nr_links || fmod_ret->nr=
_links))
+		EMIT1(0x52);	/* push rdx */
+
+	if (fentry->nr_links || fexit->nr_links || fmod_ret->nr_links) {
+		/* Prepare struct bpf_tramp_run_ctx.
+		 * sub rsp, sizeof(struct bpf_tramp_run_ctx)
+		 */
+		EMIT4(0x48, 0x83, 0xEC, sizeof(struct bpf_tramp_run_ctx));
+	}
+
 	if (fentry->nr_links)
 		if (invoke_bpf(m, &prog, fentry, regs_off,
 			       flags & BPF_TRAMP_F_RET_FENTRY_RET))
@@ -2076,6 +2104,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 	}
=20
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
+		/* pop struct bpf_tramp_run_ctx
+		 * add rsp, sizeof(struct bpf_tramp_run_ctx)
+		 */
+		if (fentry->nr_links || fexit->nr_links || fmod_ret->nr_links)
+			EMIT4(0x48, 0x83, 0xC4, sizeof(struct bpf_tramp_run_ctx));
+
+		if (nr_args < 3 && (fentry->nr_links || fexit->nr_links || fmod_ret->n=
r_links))
+			EMIT1(0x5A); /* pop rdx */
+
 		restore_regs(m, &prog, nr_args, regs_off);
=20
 		/* call original function */
@@ -2088,6 +2125,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 		im->ip_after_call =3D prog;
 		memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
 		prog +=3D X86_PATCH_SIZE;
+
+		if (nr_args < 3 && (fentry->nr_links || fexit->nr_links || fmod_ret->n=
r_links))
+			EMIT1(0x52);	/* push rdx */
+
+		/* Prepare struct bpf_tramp_run_ctx.
+		 * sub rsp, sizeof(struct bpf_tramp_run_ctx)
+		 */
+		if (fentry->nr_links || fexit->nr_links || fmod_ret->nr_links)
+			EMIT4(0x48, 0x83, 0xEC, sizeof(struct bpf_tramp_run_ctx));
 	}
=20
 	if (fmod_ret->nr_links) {
@@ -2111,6 +2157,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 			goto cleanup;
 		}
=20
+	/* pop struct bpf_tramp_run_ctx
+	 * add rsp, sizeof(struct bpf_tramp_run_ctx)
+	 */
+	if (fentry->nr_links || fexit->nr_links || fmod_ret->nr_links)
+		EMIT4(0x48, 0x83, 0xC4, sizeof(struct bpf_tramp_run_ctx));
+
+	if (nr_args < 3 && (fentry->nr_links || fexit->nr_links || fmod_ret->nr=
_links))
+		EMIT1(0x5A); /* pop rdx */
+
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
 		restore_regs(m, &prog, nr_args, regs_off);
=20
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c4b8ca17024b..7b4896c86dcc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -681,6 +681,8 @@ struct bpf_tramp_links {
 	int nr_links;
 };
=20
+struct bpf_tramp_run_ctx;
+
 /* Different use cases for BPF trampoline:
  * 1. replace nop at the function entry (kprobe equivalent)
  *    flags =3D BPF_TRAMP_F_RESTORE_REGS
@@ -707,10 +709,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
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
@@ -1304,6 +1307,12 @@ struct bpf_trace_run_ctx {
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
index dcd285929cf3..12a1c0ff6646 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4786,13 +4786,13 @@ BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr =
*, attr, u32, attr_size)
 			return -EINVAL;
 		}
=20
-		if (!__bpf_prog_enter_sleepable(prog)) {
+		if (!__bpf_prog_enter_sleepable(prog, NULL)) {
 			/* recursion detected */
 			bpf_prog_put(prog);
 			return -EBUSY;
 		}
 		attr->test.retval =3D bpf_prog_run(prog, (void *) (long) attr->test.ct=
x_in);
-		__bpf_prog_exit_sleepable(prog, 0 /* bpf_prog_run does runtime stats *=
/);
+		__bpf_prog_exit_sleepable(prog, 0 /* bpf_prog_run does runtime stats *=
/, NULL);
 		bpf_prog_put(prog);
 		return 0;
 #endif
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5916f1da059d..a2971119ca10 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -580,11 +580,15 @@ static void notrace inc_misses_counter(struct bpf_p=
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
+	if (run_ctx)
+		run_ctx->saved_run_ctx =3D bpf_set_run_ctx(&run_ctx->run_ctx);
+
 	if (unlikely(__this_cpu_inc_return(*(prog->active)) !=3D 1)) {
 		inc_misses_counter(prog);
 		return 0;
@@ -614,20 +618,27 @@ static void notrace update_prog_stats(struct bpf_pr=
og *prog,
 	}
 }
=20
-void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
+void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bp=
f_tramp_run_ctx *run_ctx)
 	__releases(RCU)
 {
+	if (run_ctx)
+		bpf_reset_run_ctx(run_ctx->saved_run_ctx);
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
+	if (run_ctx)
+		run_ctx->saved_run_ctx =3D bpf_set_run_ctx(&run_ctx->run_ctx);
+
 	if (unlikely(__this_cpu_inc_return(*(prog->active)) !=3D 1)) {
 		inc_misses_counter(prog);
 		return 0;
@@ -635,8 +646,12 @@ u64 notrace __bpf_prog_enter_sleepable(struct bpf_pr=
og *prog)
 	return bpf_prog_start_time();
 }
=20
-void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start)
+void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
+				       struct bpf_tramp_run_ctx *run_ctx)
 {
+	if (run_ctx)
+		bpf_reset_run_ctx(run_ctx->saved_run_ctx);
+
 	update_prog_stats(prog, start);
 	__this_cpu_dec(*(prog->active));
 	migrate_enable();
--=20
2.30.2

