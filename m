Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C50967BECC
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbjAYVkD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbjAYVj5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:39:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A375D48A3A
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:39:53 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLqaF027329;
        Wed, 25 Jan 2023 21:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FieC9ZW0dhz6eIyubiKO6uU5nttbY6E29QizhcWZMGY=;
 b=UNHrXz5Ip2Wre/0NEBLFTFVPnRPK99NPCKXX5Ce8E2x+U/Vj+Uv3LdBZRv3GFvH5KxEe
 KBvIfZz0DMWtJQcxBk2+frcvWtQEq7GiG4bchg13B2eYwvqrjnLb8fysGbE1ZUXPkJ/G
 wvAXJQIUT0gDVs8NyWvMzTasEvs3P7R3J2qtRbsdE/u7aKnWrmrfeZV1pAKl3qF5XWag
 3QDbg3/bJx4AiE1vVFkfY0eI0UD/nQz+4boVtDBmWxIjmr6gW4NbCisdgcVoeFCCdBeO
 cOxXs4ffmdtQ0dxO4yNbxyWT/VzuIHNYY9kUb2sdku/tlV69LGyQs5UTgpvLly9BXBRU Ww== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb6na2w71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:39 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PEqJ3O016365;
        Wed, 25 Jan 2023 21:39:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3n87p6c1e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLdXcE42008980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:39:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6608120043;
        Wed, 25 Jan 2023 21:39:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22FB220040;
        Wed, 25 Jan 2023 21:39:33 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.149])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:39:33 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 22/24] s390/bpf: Implement arch_prepare_bpf_trampoline()
Date:   Wed, 25 Jan 2023 22:38:15 +0100
Message-Id: <20230125213817.1424447-23-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125213817.1424447-1-iii@linux.ibm.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mev5DfMbeO1WJWQQFl9_3QIHFObzjbfk
X-Proofpoint-ORIG-GUID: mev5DfMbeO1WJWQQFl9_3QIHFObzjbfk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250193
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

arch_prepare_bpf_trampoline() is used for direct attachment of eBPF
programs to various places, bypassing kprobes. It's responsible for
calling a number of eBPF programs before, instead and/or after
whatever they are attached to.

Add a s390x implementation, paying attention to the following:

- Reuse the existing JIT infrastructure, where possible.
- Like the existing JIT, prefer making multiple passes instead of
  backpatching. Currently 2 passes is enough. If literal pool is
  introduced, this needs to be raised to 3. However, at the moment
  adding literal pool only makes the code larger. If branch
  shortening is introduced, the number of passes needs to be
  increased even further.
- Support both regular and ftrace calling conventions, depending on
  the trampoline flags.
- Use expolines for indirect calls.
- Handle the mismatch between the eBPF and the s390x ABIs.
- Sign-extend fmod_ret return values.

invoke_bpf_prog() produces about 120 bytes; it might be possible to
slightly optimize this, but reaching 50 bytes, like on x86_64, looks
unrealistic: just loading cookie, __bpf_prog_enter, bpf_func, insnsi
and __bpf_prog_exit as literals already takes at least 5 * 12 = 60
bytes, and we can't use relative addressing for most of them.
Therefore, lower BPF_MAX_TRAMP_LINKS on s390x.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 535 +++++++++++++++++++++++++++++++++--
 include/linux/bpf.h          |   4 +
 2 files changed, 517 insertions(+), 22 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index c72eb3fc1f98..ea8203bd4112 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -71,6 +71,10 @@ struct bpf_jit {
 #define REG_0		REG_W0			/* Register 0 */
 #define REG_1		REG_W1			/* Register 1 */
 #define REG_2		BPF_REG_1		/* Register 2 */
+#define REG_3		BPF_REG_2		/* Register 3 */
+#define REG_4		BPF_REG_3		/* Register 4 */
+#define REG_7		BPF_REG_6		/* Register 7 */
+#define REG_8		BPF_REG_7		/* Register 8 */
 #define REG_14		BPF_REG_0		/* Register 14 */
 
 /*
@@ -595,6 +599,43 @@ static void bpf_jit_prologue(struct bpf_jit *jit, u32 stack_depth)
 	}
 }
 
+/*
+ * Emit an expoline for a jump that follows
+ */
+static void emit_expoline(struct bpf_jit *jit)
+{
+	/* exrl %r0,.+10 */
+	EMIT6_PCREL_RIL(0xc6000000, jit->prg + 10);
+	/* j . */
+	EMIT4_PCREL(0xa7f40000, 0);
+}
+
+/*
+ * Emit __s390_indirect_jump_r1 thunk if necessary
+ */
+static void emit_r1_thunk(struct bpf_jit *jit)
+{
+	if (nospec_uses_trampoline()) {
+		jit->r1_thunk_ip = jit->prg;
+		emit_expoline(jit);
+		/* br %r1 */
+		_EMIT2(0x07f1);
+	}
+}
+
+/*
+ * Call r1 either directly or via __s390_indirect_jump_r1 thunk
+ */
+static void call_r1(struct bpf_jit *jit)
+{
+	if (nospec_uses_trampoline())
+		/* brasl %r14,__s390_indirect_jump_r1 */
+		EMIT6_PCREL_RILB(0xc0050000, REG_14, jit->r1_thunk_ip);
+	else
+		/* basr %r14,%r1 */
+		EMIT2(0x0d00, REG_14, REG_1);
+}
+
 /*
  * Function epilogue
  */
@@ -608,25 +649,13 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
 	if (nospec_uses_trampoline()) {
 		jit->r14_thunk_ip = jit->prg;
 		/* Generate __s390_indirect_jump_r14 thunk */
-		/* exrl %r0,.+10 */
-		EMIT6_PCREL_RIL(0xc6000000, jit->prg + 10);
-		/* j . */
-		EMIT4_PCREL(0xa7f40000, 0);
+		emit_expoline(jit);
 	}
 	/* br %r14 */
 	_EMIT2(0x07fe);
 
-	if ((nospec_uses_trampoline()) &&
-	    (is_first_pass(jit) || (jit->seen & SEEN_FUNC))) {
-		jit->r1_thunk_ip = jit->prg;
-		/* Generate __s390_indirect_jump_r1 thunk */
-		/* exrl %r0,.+10 */
-		EMIT6_PCREL_RIL(0xc6000000, jit->prg + 10);
-		/* j . */
-		EMIT4_PCREL(0xa7f40000, 0);
-		/* br %r1 */
-		_EMIT2(0x07f1);
-	}
+	if (is_first_pass(jit) || (jit->seen & SEEN_FUNC))
+		emit_r1_thunk(jit);
 
 	jit->prg = ALIGN(jit->prg, 8);
 	jit->prologue_plt = jit->prg;
@@ -707,6 +736,34 @@ static int bpf_jit_probe_mem(struct bpf_jit *jit, struct bpf_prog *fp,
 	return 0;
 }
 
+/*
+ * Sign-extend the register if necessary
+ */
+static int sign_extend(struct bpf_jit *jit, int r, u8 size, u8 flags)
+{
+	if (!(flags & BTF_FMODEL_SIGNED_ARG))
+		return 0;
+
+	switch (size) {
+	case 1:
+		/* lgbr %r,%r */
+		EMIT4(0xb9060000, r, r);
+		return 0;
+	case 2:
+		/* lghr %r,%r */
+		EMIT4(0xb9070000, r, r);
+		return 0;
+	case 4:
+		/* lgfr %r,%r */
+		EMIT4(0xb9140000, r, r);
+		return 0;
+	case 8:
+		return 0;
+	default:
+		return -1;
+	}
+}
+
 /*
  * Compile one eBPF instruction into s390x code
  *
@@ -1355,13 +1412,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		jit->seen |= SEEN_FUNC;
 		/* lgrl %w1,func */
 		EMIT6_PCREL_RILB(0xc4080000, REG_W1, _EMIT_CONST_U64(func));
-		if (nospec_uses_trampoline()) {
-			/* brasl %r14,__s390_indirect_jump_r1 */
-			EMIT6_PCREL_RILB(0xc0050000, REG_14, jit->r1_thunk_ip);
-		} else {
-			/* basr %r14,%w1 */
-			EMIT2(0x0d00, REG_14, REG_W1);
-		}
+		/* %r1() */
+		call_r1(jit);
 		/* lgr %b0,%r2: load return value into %b0 */
 		EMIT4(0xb9040000, BPF_REG_0, REG_2);
 		break;
@@ -1964,3 +2016,442 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 
 	return 0;
 }
+
+struct bpf_tramp_jit {
+	struct bpf_jit common;
+	int orig_stack_args_off;/* Offset of arguments placed on stack by the
+				 * func_addr's original caller
+				 */
+	int stack_size;		/* Trampoline stack size */
+	int stack_args_off;	/* Offset of stack arguments for calling
+				 * func_addr, has to be at the top
+				 */
+	int reg_args_off;	/* Offset of register arguments for calling
+				 * func_addr
+				 */
+	int ip_off;		/* For bpf_get_func_ip(), has to be at
+				 * (ctx - 16)
+				 */
+	int arg_cnt_off;	/* For bpf_get_func_arg_cnt(), has to be at
+				 * (ctx - 8)
+				 */
+	int bpf_args_off;	/* Offset of BPF_PROG context, which consists
+				 * of BPF arguments followed by return value
+				 */
+	int retval_off;		/* Offset of return value (see above) */
+	int r7_r8_off;		/* Offset of saved %r7 and %r8, which are used
+				 * for __bpf_prog_enter() return value and
+				 * func_addr respectively
+				 */
+	int r14_off;		/* Offset of saved %r14 */
+	int run_ctx_off;	/* Offset of struct bpf_tramp_run_ctx */
+	int do_fexit;		/* do_fexit: label */
+};
+
+static void load_imm64(struct bpf_jit *jit, int dst_reg, u64 val)
+{
+	/* llihf %dst_reg,val_hi */
+	EMIT6_IMM(0xc00e0000, dst_reg, (val >> 32));
+	/* oilf %rdst_reg,val_lo */
+	EMIT6_IMM(0xc00d0000, dst_reg, val);
+}
+
+static void invoke_bpf_prog(struct bpf_tramp_jit *tjit,
+			    const struct btf_func_model *m,
+			    struct bpf_tramp_link *tlink, bool save_ret)
+{
+	struct bpf_jit *jit = &tjit->common;
+	int cookie_off = tjit->run_ctx_off +
+			 offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
+	struct bpf_prog *p = tlink->link.prog;
+	int patch;
+
+	/*
+	 * run_ctx.cookie = tlink->cookie;
+	 */
+
+	/* %r0 = tlink->cookie */
+	load_imm64(jit, REG_W0, tlink->cookie);
+	/* stg %r0,cookie_off(%r15) */
+	EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W0, REG_0, REG_15, cookie_off);
+
+	/*
+	 * if ((start = __bpf_prog_enter(p, &run_ctx)) == 0)
+	 *         goto skip;
+	 */
+
+	/* %r1 = __bpf_prog_enter */
+	load_imm64(jit, REG_1, (u64)bpf_trampoline_enter(p));
+	/* %r2 = p */
+	load_imm64(jit, REG_2, (u64)p);
+	/* la %r3,run_ctx_off(%r15) */
+	EMIT4_DISP(0x41000000, REG_3, REG_15, tjit->run_ctx_off);
+	/* %r1() */
+	call_r1(jit);
+	/* ltgr %r7,%r2 */
+	EMIT4(0xb9020000, REG_7, REG_2);
+	/* brcl 8,skip */
+	patch = jit->prg;
+	EMIT6_PCREL_RILC(0xc0040000, 8, 0);
+
+	/*
+	 * retval = bpf_func(args, p->insnsi);
+	 */
+
+	/* %r1 = p->bpf_func */
+	load_imm64(jit, REG_1, (u64)p->bpf_func);
+	/* la %r2,bpf_args_off(%r15) */
+	EMIT4_DISP(0x41000000, REG_2, REG_15, tjit->bpf_args_off);
+	/* %r3 = p->insnsi */
+	if (!p->jited)
+		load_imm64(jit, REG_3, (u64)p->insnsi);
+	/* %r1() */
+	call_r1(jit);
+	/* stg %r2,retval_off(%r15) */
+	if (save_ret) {
+		sign_extend(jit, REG_2, m->ret_size, m->ret_flags);
+		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_2, REG_0, REG_15,
+			      tjit->retval_off);
+	}
+
+	/* skip: */
+	if (jit->prg_buf)
+		*(u32 *)&jit->prg_buf[patch + 2] = (jit->prg - patch) >> 1;
+
+	/*
+	 * __bpf_prog_exit(p, start, &run_ctx);
+	 */
+
+	/* %r1 = __bpf_prog_exit */
+	load_imm64(jit, REG_1, (u64)bpf_trampoline_exit(p));
+	/* %r2 = p */
+	load_imm64(jit, REG_2, (u64)p);
+	/* lgr %r3,%r7 */
+	EMIT4(0xb9040000, REG_3, REG_7);
+	/* la %r4,run_ctx_off(%r15) */
+	EMIT4_DISP(0x41000000, REG_4, REG_15, tjit->run_ctx_off);
+	/* %r1() */
+	call_r1(jit);
+}
+
+static int alloc_stack(struct bpf_tramp_jit *tjit, size_t size)
+{
+	int stack_offset = tjit->stack_size;
+
+	tjit->stack_size += size;
+	return stack_offset;
+}
+
+/* ABI uses %r2 - %r6 for parameter passing. */
+#define MAX_NR_REG_ARGS 5
+
+/* The "L" field of the "mvc" instruction is 8 bits. */
+#define MAX_MVC_SIZE 256
+#define MAX_NR_STACK_ARGS (MAX_MVC_SIZE / sizeof(u64))
+
+/* -mfentry generates a 6-byte nop on s390x. */
+#define S390X_PATCH_SIZE 6
+
+int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
+				  struct bpf_tramp_jit *tjit,
+				  const struct btf_func_model *m,
+				  u32 flags, struct bpf_tramp_links *tlinks,
+				  void *func_addr)
+{
+	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
+	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
+	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
+	int nr_bpf_args, nr_reg_args, nr_stack_args;
+	struct bpf_jit *jit = &tjit->common;
+	int arg, bpf_arg_off;
+	int i, j;
+
+	/* Support as many stack arguments as "mvc" instruction can handle. */
+	nr_reg_args = min_t(int, m->nr_args, MAX_NR_REG_ARGS);
+	nr_stack_args = m->nr_args - nr_reg_args;
+	if (nr_stack_args > MAX_NR_STACK_ARGS)
+		return -ENOTSUPP;
+
+	/* Return to %r14, since func_addr and %r0 are not available. */
+	if (!func_addr && !(flags & BPF_TRAMP_F_ORIG_STACK))
+		flags |= BPF_TRAMP_F_SKIP_FRAME;
+
+	/*
+	 * Compute how many arguments we need to pass to BPF programs.
+	 * BPF ABI mirrors that of x86_64: arguments that are 16 bytes or
+	 * smaller are packed into 1 or 2 registers; larger arguments are
+	 * passed via pointers.
+	 * In s390x ABI, arguments that are 8 bytes or smaller are packed into
+	 * a register; larger arguments are passed via pointers.
+	 * We need to deal with this difference.
+	 */
+	nr_bpf_args = 0;
+	for (i = 0; i < m->nr_args; i++) {
+		if (m->arg_size[i] <= 8)
+			nr_bpf_args += 1;
+		else if (m->arg_size[i] <= 16)
+			nr_bpf_args += 2;
+		else
+			return -ENOTSUPP;
+	}
+
+	/*
+	 * Calculate the stack layout.
+	 */
+
+	/* Reserve STACK_FRAME_OVERHEAD bytes for the callees. */
+	tjit->stack_size = STACK_FRAME_OVERHEAD;
+	tjit->stack_args_off = alloc_stack(tjit, nr_stack_args * sizeof(u64));
+	tjit->reg_args_off = alloc_stack(tjit, nr_reg_args * sizeof(u64));
+	tjit->ip_off = alloc_stack(tjit, sizeof(u64));
+	tjit->arg_cnt_off = alloc_stack(tjit, sizeof(u64));
+	tjit->bpf_args_off = alloc_stack(tjit, nr_bpf_args * sizeof(u64));
+	tjit->retval_off = alloc_stack(tjit, sizeof(u64));
+	tjit->r7_r8_off = alloc_stack(tjit, 2 * sizeof(u64));
+	tjit->r14_off = alloc_stack(tjit, sizeof(u64));
+	tjit->run_ctx_off = alloc_stack(tjit,
+					sizeof(struct bpf_tramp_run_ctx));
+	/* The caller has already reserved STACK_FRAME_OVERHEAD bytes. */
+	tjit->stack_size -= STACK_FRAME_OVERHEAD;
+	tjit->orig_stack_args_off = tjit->stack_size + STACK_FRAME_OVERHEAD;
+
+	/* aghi %r15,-stack_size */
+	EMIT4_IMM(0xa70b0000, REG_15, -tjit->stack_size);
+	/* stmg %r2,%rN,fwd_reg_args_off(%r15) */
+	if (nr_reg_args)
+		EMIT6_DISP_LH(0xeb000000, 0x0024, REG_2,
+			      REG_2 + (nr_reg_args - 1), REG_15,
+			      tjit->reg_args_off);
+	for (i = 0, j = 0; i < m->nr_args; i++) {
+		if (i < MAX_NR_REG_ARGS)
+			arg = REG_2 + i;
+		else
+			arg = tjit->orig_stack_args_off +
+			      (i - MAX_NR_REG_ARGS) * sizeof(u64);
+		bpf_arg_off = tjit->bpf_args_off + j * sizeof(u64);
+		if (m->arg_size[i] <= 8) {
+			if (i < MAX_NR_REG_ARGS)
+				/* stg %arg,bpf_arg_off(%r15) */
+				EMIT6_DISP_LH(0xe3000000, 0x0024, arg,
+					      REG_0, REG_15, bpf_arg_off);
+			else
+				/* mvc bpf_arg_off(8,%r15),arg(%r15) */
+				_EMIT6(0xd207f000 | bpf_arg_off,
+				       0xf000 | arg);
+			j += 1;
+		} else {
+			if (i < MAX_NR_REG_ARGS) {
+				/* mvc bpf_arg_off(16,%r15),0(%arg) */
+				_EMIT6(0xd20ff000 | bpf_arg_off,
+				       reg2hex[arg] << 12);
+			} else {
+				/* lg %r1,arg(%r15) */
+				EMIT6_DISP_LH(0xe3000000, 0x0004, REG_1, REG_0,
+					      REG_15, arg);
+				/* mvc bpf_arg_off(16,%r15),0(%r1) */
+				_EMIT6(0xd20ff000 | bpf_arg_off, 0x1000);
+			}
+			j += 2;
+		}
+	}
+	/* stmg %r7,%r8,r7_r8_off(%r15) */
+	EMIT6_DISP_LH(0xeb000000, 0x0024, REG_7, REG_8, REG_15,
+		      tjit->r7_r8_off);
+	/* stg %r14,r14_off(%r15) */
+	EMIT6_DISP_LH(0xe3000000, 0x0024, REG_14, REG_0, REG_15, tjit->r14_off);
+
+	if (flags & BPF_TRAMP_F_ORIG_STACK) {
+		/*
+		 * The ftrace trampoline puts the return address (which is the
+		 * address of the original function + S390X_PATCH_SIZE) into
+		 * %r0; see ftrace_shared_hotpatch_trampoline_br and
+		 * ftrace_init_nop() for details.
+		 */
+
+		/* lgr %r8,%r0 */
+		EMIT4(0xb9040000, REG_8, REG_0);
+	} else {
+		/* %r8 = func_addr + S390X_PATCH_SIZE */
+		load_imm64(jit, REG_8, (u64)func_addr + S390X_PATCH_SIZE);
+	}
+
+	/*
+	 * ip = func_addr;
+	 * arg_cnt = m->nr_args;
+	 */
+
+	if (flags & BPF_TRAMP_F_IP_ARG) {
+		/* %r0 = func_addr */
+		load_imm64(jit, REG_0, (u64)func_addr);
+		/* stg %r0,ip_off(%r15) */
+		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_0, REG_0, REG_15,
+			      tjit->ip_off);
+	}
+	/* lghi %r0,nr_bpf_args */
+	EMIT4_IMM(0xa7090000, REG_0, nr_bpf_args);
+	/* stg %r0,arg_cnt_off(%r15) */
+	EMIT6_DISP_LH(0xe3000000, 0x0024, REG_0, REG_0, REG_15,
+		      tjit->arg_cnt_off);
+
+	if (flags & BPF_TRAMP_F_CALL_ORIG) {
+		/*
+		 * __bpf_tramp_enter(im);
+		 */
+
+		/* %r1 = __bpf_tramp_enter */
+		load_imm64(jit, REG_1, (u64)__bpf_tramp_enter);
+		/* %r2 = im */
+		load_imm64(jit, REG_2, (u64)im);
+		/* %r1() */
+		call_r1(jit);
+	}
+
+	for (i = 0; i < fentry->nr_links; i++)
+		invoke_bpf_prog(tjit, m, fentry->links[i],
+				flags & BPF_TRAMP_F_RET_FENTRY_RET);
+
+	if (fmod_ret->nr_links) {
+		/*
+		 * retval = 0;
+		 */
+
+		/* xc retval_off(8,%r15),retval_off(%r15) */
+		_EMIT6(0xd707f000 | tjit->retval_off,
+		       0xf000 | tjit->retval_off);
+
+		for (i = 0; i < fmod_ret->nr_links; i++) {
+			invoke_bpf_prog(tjit, m, fmod_ret->links[i], true);
+
+			/*
+			 * if (retval)
+			 *         goto do_fexit;
+			 */
+
+			/* ltg %r0,retval_off(%r15) */
+			EMIT6_DISP_LH(0xe3000000, 0x0002, REG_0, REG_0, REG_15,
+				      tjit->retval_off);
+			/* brcl 7,do_fexit */
+			EMIT6_PCREL_RILC(0xc0040000, 7, tjit->do_fexit);
+		}
+	}
+
+	if (flags & BPF_TRAMP_F_CALL_ORIG) {
+		/*
+		 * retval = func_addr(args);
+		 */
+
+		/* lmg %r2,%rN,reg_args_off(%r15) */
+		if (nr_reg_args)
+			EMIT6_DISP_LH(0xeb000000, 0x0004, REG_2,
+				      REG_2 + (nr_reg_args - 1), REG_15,
+				      tjit->reg_args_off);
+		/* mvc stack_args_off(N,%r15),orig_stack_args_off(%r15) */
+		if (nr_stack_args)
+			_EMIT6(0xd200f000 |
+				       (nr_stack_args * sizeof(u64) - 1) << 16 |
+				       tjit->stack_args_off,
+			       0xf000 | tjit->orig_stack_args_off);
+		/* lgr %r1,%r8 */
+		EMIT4(0xb9040000, REG_1, REG_8);
+		/* %r1() */
+		call_r1(jit);
+		/* stg %r2,retval_off(%r15) */
+		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_2, REG_0, REG_15,
+			      tjit->retval_off);
+
+		im->ip_after_call = jit->prg_buf + jit->prg;
+
+		/*
+		 * The following nop will be patched by bpf_tramp_image_put().
+		 */
+
+		/* brcl 0,im->ip_epilogue */
+		EMIT6_PCREL_RILC(0xc0040000, 0, (u64)im->ip_epilogue);
+	}
+
+	/* do_fexit: */
+	tjit->do_fexit = jit->prg;
+	for (i = 0; i < fexit->nr_links; i++)
+		invoke_bpf_prog(tjit, m, fexit->links[i], false);
+
+	if (flags & BPF_TRAMP_F_CALL_ORIG) {
+		im->ip_epilogue = jit->prg_buf + jit->prg;
+
+		/*
+		 * __bpf_tramp_exit(im);
+		 */
+
+		/* %r1 = __bpf_tramp_exit */
+		load_imm64(jit, REG_1, (u64)__bpf_tramp_exit);
+		/* %r2 = im */
+		load_imm64(jit, REG_2, (u64)im);
+		/* %r1() */
+		call_r1(jit);
+	}
+
+	/* lmg %r2,%rN,reg_args_off(%r15) */
+	if ((flags & BPF_TRAMP_F_RESTORE_REGS) && nr_reg_args)
+		EMIT6_DISP_LH(0xeb000000, 0x0004, REG_2,
+			      REG_2 + (nr_reg_args - 1), REG_15,
+			      tjit->reg_args_off);
+	/* lgr %r1,%r8 */
+	if (!(flags & BPF_TRAMP_F_SKIP_FRAME))
+		EMIT4(0xb9040000, REG_1, REG_8);
+	/* lmg %r7,%r8,r7_r8_off(%r15) */
+	EMIT6_DISP_LH(0xeb000000, 0x0004, REG_7, REG_8, REG_15,
+		      tjit->r7_r8_off);
+	/* lg %r14,r14_off(%r15) */
+	EMIT6_DISP_LH(0xe3000000, 0x0004, REG_14, REG_0, REG_15, tjit->r14_off);
+	/* lg %r2,retval_off(%r15) */
+	if (flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET))
+		EMIT6_DISP_LH(0xe3000000, 0x0004, REG_2, REG_0, REG_15,
+			      tjit->retval_off);
+	/* aghi %r15,stack_size */
+	EMIT4_IMM(0xa70b0000, REG_15, tjit->stack_size);
+	/* Emit an expoline for the following indirect jump. */
+	if (nospec_uses_trampoline())
+		emit_expoline(jit);
+	if (flags & BPF_TRAMP_F_SKIP_FRAME)
+		/* br %r14 */
+		_EMIT2(0x07fe);
+	else
+		/* br %r1 */
+		_EMIT2(0x07f1);
+
+	emit_r1_thunk(jit);
+
+	return 0;
+}
+
+int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
+				void *image_end, const struct btf_func_model *m,
+				u32 flags, struct bpf_tramp_links *tlinks,
+				void *func_addr)
+{
+	struct bpf_tramp_jit tjit;
+	int ret;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		if (i == 0) {
+			/* Compute offsets, check whether the code fits. */
+			memset(&tjit, 0, sizeof(tjit));
+		} else {
+			/* Generate the code. */
+			tjit.common.prg = 0;
+			tjit.common.prg_buf = image;
+		}
+		ret = __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
+						    tlinks, func_addr);
+		if (ret < 0)
+			return ret;
+		if (tjit.common.prg > (char *)image_end - (char *)image)
+			/*
+			 * Use the same error code as for exceeding
+			 * BPF_MAX_TRAMP_LINKS.
+			 */
+			return -E2BIG;
+	}
+
+	return ret;
+}
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cf89504c8dda..52ff43bbf996 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -943,7 +943,11 @@ struct btf_func_model {
 /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
  * bytes on x86.
  */
+#if defined(__s390x__)
+#define BPF_MAX_TRAMP_LINKS 27
+#else
 #define BPF_MAX_TRAMP_LINKS 38
+#endif
 
 struct bpf_tramp_links {
 	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
-- 
2.39.1

