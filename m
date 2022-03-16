Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C874DA70D
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 01:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352842AbiCPAqC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 20:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiCPAqC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 20:46:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960664A917
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 17:44:48 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22FNkbw4004130
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 17:44:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=IX13ARVTyTDONegkfBTMKcczyu7xf0t/fXL2o3xqA2M=;
 b=fsjLd7ErDH4r9aG50xKSsHDI+/CsAEt7cAblXKt/e6LkQ98wBnmCgGyTC4mtAdlQMlr8
 LESOnKhdTe0/LQbPSNAPib4v6+TE9RUkF9BQoLLXIfajqkPRgwq6GSl4c63So+FLp8Ye
 LJdbi0lP92p7JcFDvzu4MLzzk2X51RKsGUA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3et99mm0q4-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 17:44:47 -0700
Received: from twshared29473.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 17:44:42 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 074B91269EDA; Tue, 15 Mar 2022 17:44:36 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v2 2/4] bpf, x86: Create bpf_trace_run_ctx on the caller thread's stack
Date:   Tue, 15 Mar 2022 17:42:29 -0700
Message-ID: <20220316004231.1103318-3-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316004231.1103318-1-kuifeng@fb.com>
References: <20220316004231.1103318-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JnFkmNIBnQXs8Djpm-pgZ5nuuJ2XjHL4
X-Proofpoint-ORIG-GUID: JnFkmNIBnQXs8Djpm-pgZ5nuuJ2XjHL4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_11,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF trampolines will create a bpf_trace_run_ctx on their stacks, and
set/reset the current bpf_run_ctx whenever calling/returning from a
bpf_prog.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/bpf.h         | 12 ++++++++----
 kernel/bpf/syscall.c        |  4 ++--
 kernel/bpf/trampoline.c     | 21 +++++++++++++++++----
 4 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1228e6e6a420..29775a475513 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1748,10 +1748,33 @@ static int invoke_bpf_prog(const struct btf_func_=
model *m, u8 **pprog,
 {
 	u8 *prog =3D *pprog;
 	u8 *jmp_insn;
+	int ctx_cookie_off =3D offsetof(struct bpf_trace_run_ctx, bpf_cookie);
 	struct bpf_prog *p =3D l->prog;
=20
+	EMIT1(0x52);		 /* push rdx */
+
+	/* mov rdi, 0 */
+	emit_mov_imm64(&prog, BPF_REG_1, 0, 0);
+
+	/* Prepare struct bpf_trace_run_ctx.
+	 * sub rsp, sizeof(struct bpf_trace_run_ctx)
+	 * mov rax, rsp
+	 * mov QWORD PTR [rax + ctx_cookie_off], rdi
+	 */
+	EMIT4(0x48, 0x83, 0xEC, sizeof(struct bpf_trace_run_ctx));
+	EMIT3(0x48, 0x89, 0xE0);
+	EMIT4(0x48, 0x89, 0x78, ctx_cookie_off);
+
+	/* mov rdi, rsp */
+	EMIT3(0x48, 0x89, 0xE7);
+	/* mov QWORD PTR [rdi + sizeof(struct bpf_trace_run_ctx)], rax */
+	emit_stx(&prog, BPF_DW, BPF_REG_1, BPF_REG_0, sizeof(struct bpf_trace_r=
un_ctx));
+
 	/* arg1: mov rdi, progs[i] */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
+	/* arg2: mov rsi, rsp (struct bpf_run_ctx *) */
+	EMIT3(0x48, 0x89, 0xE6);
+
 	if (emit_call(&prog,
 		      p->aux->sleepable ? __bpf_prog_enter_sleepable :
 		      __bpf_prog_enter, prog))
@@ -1797,11 +1820,20 @@ static int invoke_bpf_prog(const struct btf_func_=
model *m, u8 **pprog,
 	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
 	/* arg2: mov rsi, rbx <- start time in nsec */
 	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
+	/* arg3: mov rdx, rsp (struct bpf_run_ctx *) */
+	EMIT3(0x48, 0x89, 0xE2);
 	if (emit_call(&prog,
 		      p->aux->sleepable ? __bpf_prog_exit_sleepable :
 		      __bpf_prog_exit, prog))
 			return -EINVAL;
=20
+	/* pop struct bpf_trace_run_ctx
+	 * add rsp, sizeof(struct bpf_trace_run_ctx)
+	 */
+	EMIT4(0x48, 0x83, 0xC4, sizeof(struct bpf_trace_run_ctx));
+
+	EMIT1(0x5A); /* pop rdx */
+
 	*pprog =3D prog;
 	return 0;
 }
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3dcae8550c21..d20a23953696 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -681,6 +681,8 @@ struct bpf_tramp_links {
 	int nr_links;
 };
=20
+struct bpf_trace_run_ctx;
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
+u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_trace_run=
_ctx *run_ctx);
+void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bp=
f_trace_run_ctx *run_ctx);
+u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf=
_trace_run_ctx *run_ctx);
+void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
+				       struct bpf_trace_run_ctx *run_ctx);
 void notrace __bpf_tramp_enter(struct bpf_tramp_image *tr);
 void notrace __bpf_tramp_exit(struct bpf_tramp_image *tr);
=20
@@ -1291,6 +1294,7 @@ struct bpf_cg_run_ctx {
 struct bpf_trace_run_ctx {
 	struct bpf_run_ctx run_ctx;
 	u64 bpf_cookie;
+	struct bpf_run_ctx *saved_run_ctx;
 };
=20
 static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *ne=
w_ctx)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fecfc803785d..a289ef55ea17 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4793,13 +4793,13 @@ BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr =
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
index 54c695d49ec9..0b050aa2f159 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -580,9 +580,12 @@ static void notrace inc_misses_counter(struct bpf_pr=
og *prog)
  * [2..MAX_U64] - execute bpf prog and record execution time.
  *     This is start time.
  */
-u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
+u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_trace_run=
_ctx *run_ctx)
 	__acquires(RCU)
 {
+	if (run_ctx)
+		run_ctx->saved_run_ctx =3D bpf_set_run_ctx(&run_ctx->run_ctx);
+
 	rcu_read_lock();
 	migrate_disable();
 	if (unlikely(__this_cpu_inc_return(*(prog->active)) !=3D 1)) {
@@ -614,17 +617,23 @@ static void notrace update_prog_stats(struct bpf_pr=
og *prog,
 	}
 }
=20
-void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
+void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bp=
f_trace_run_ctx *run_ctx)
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
_trace_run_ctx *run_ctx)
 {
+	if (run_ctx)
+		run_ctx->saved_run_ctx =3D bpf_set_run_ctx(&run_ctx->run_ctx);
+
 	rcu_read_lock_trace();
 	migrate_disable();
 	might_fault();
@@ -635,8 +644,12 @@ u64 notrace __bpf_prog_enter_sleepable(struct bpf_pr=
og *prog)
 	return bpf_prog_start_time();
 }
=20
-void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start)
+void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
+				       struct bpf_trace_run_ctx *run_ctx)
 {
+	if (run_ctx)
+		bpf_reset_run_ctx(run_ctx->saved_run_ctx);
+
 	update_prog_stats(prog, start);
 	__this_cpu_dec(*(prog->active));
 	migrate_enable();
--=20
2.30.2

