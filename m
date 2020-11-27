Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9F12C6B2F
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 18:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbgK0R61 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 12:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732901AbgK0R6F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Nov 2020 12:58:05 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7919C0617A7
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:58:03 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id g28so4135219qka.4
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OcGetHndj/pHr70a737GqKJhkLB+N6xuhPL+W0UqXWw=;
        b=oP1RtxUz3VsX5kHcTFm2PRALRYVLFg6CljCExzA6CpXRNrUwEEHBSPb79E9chrIzqx
         4b5nI6NEhr+Y/TCoPvF8+H2jyRue/9CfjoF3xKAdNB/doDlElPqMrXJs1qw1mRJcU7mS
         WA/FZd9kEq4DhHrALSCU05m55BYNzBiXdyKEmJ/MzB71PbUFL/QhZTWMSBEH69xQ7+OC
         82FKD9O4RCgXFjhiaQl1SNpChnjj8Zsml2m/9s70RcYPgMsphccEu/xxJ1q07k8t7Mnu
         hP92udfm/uVIfGN/ugE65L1rF/n4ixZk4yd++vaklFCy5xvVWZhCeg9ZSl4KYRFdvlHH
         Y8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OcGetHndj/pHr70a737GqKJhkLB+N6xuhPL+W0UqXWw=;
        b=NM77iMYL/s3bQ9udrjHOHX37HMp9XM46zm2dWFt9bQn4hOYcv2S545jvbSU3xiKL/H
         KFyz/lXHYuUSjsgUNhSPKsUJiiVe3dd4aR04xkT769qR8xAkvxFcG0LJs2EWuH2xorCi
         hZ1jPCrHL3oJ4qpcQrjW9GS758F3VqLE+l6TVrlAcpCBuEpStsSWyhwkLVFsPQ5TqSao
         Pid9zqMuc+AOx+/Ne5DUZaY/+D83kqVlhHypIaMjkTjUOZbBOd84tfQFVoUyfOVUet2h
         2WlduKzQCBgs9437AYZsc7w3iAcLhdOSXiPYYGMzaqZ0qTDmTSnhHIQWbI/ecd80jOed
         lMjA==
X-Gm-Message-State: AOAM531yPkHWKL0CBKnE0b0FAxCEOO6WNiMPucSgRXyxH00r4J38x2dm
        X0zxOCgGe4wfkUzzFnpsny7SJYhCR+Jd2ljL9ltC/1tc5KtMs0VOdSMLFb3YFjKzWxQsE5aAZ0L
        +9xYWtEUFcWjFbC364WoosDCTyDoHw5L4ZZmHKSUELpBRtX/IabEhysQYheLzC6E=
X-Google-Smtp-Source: ABdhPJyaXSLD8oAmb/bJB/DYjXGeC2Es+yRxgNIXnnDI/9bi9jI4O0nduo6xHZgByKQBICV5emPyL+Gvvj6Mlw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:ad4:42c8:: with SMTP id
 f8mr9672404qvr.29.1606499883005; Fri, 27 Nov 2020 09:58:03 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:57:32 +0000
In-Reply-To: <20201127175738.1085417-1-jackmanb@google.com>
Message-Id: <20201127175738.1085417-8-jackmanb@google.com>
Mime-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 bpf-next 07/13] bpf: Add BPF_FETCH field / create
 atomic_fetch_add instruction
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This value can be set in bpf_insn.imm, for BPF_ATOMIC instructions,
in order to have the previous value of the atomically-modified memory
location loaded into the src register after an atomic op is carried
out.

Suggested-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c    |  4 ++++
 include/linux/filter.h         |  9 +++++++++
 include/uapi/linux/bpf.h       |  3 +++
 kernel/bpf/core.c              | 13 +++++++++++++
 kernel/bpf/disasm.c            |  7 +++++++
 kernel/bpf/verifier.c          | 35 ++++++++++++++++++++++++----------
 tools/include/linux/filter.h   | 10 ++++++++++
 tools/include/uapi/linux/bpf.h |  3 +++
 8 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 7c47ad70ddb4..d3cd45bcd0c1 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -827,6 +827,10 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 		/* lock *(u32/u64*)(dst_reg + off) <op>= src_reg */
 		EMIT1(simple_alu_opcodes[atomic_op]);
 		break;
+	case BPF_ADD | BPF_FETCH:
+		/* src_reg = atomic_fetch_add(*(dst_reg + off), src_reg); */
+		EMIT2(0x0F, 0xC1);
+		break;
 	default:
 		pr_err("bpf_jit: unknown atomic opcode %02x\n", atomic_op);
 		return -EFAULT;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index ce19988fb312..4e04d0fc454f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -270,6 +270,15 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 		.imm   = BPF_ADD })
 #define BPF_STX_XADD BPF_ATOMIC_ADD /* alias */
 
+/* Atomic memory add with fetch, src_reg = atomic_fetch_add(*(dst_reg + off), src_reg); */
+
+#define BPF_ATOMIC_FETCH_ADD(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_ADD | BPF_FETCH })
 
 /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d0adc48db43c..025e377e7229 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -44,6 +44,9 @@
 #define BPF_CALL	0x80	/* function call */
 #define BPF_EXIT	0x90	/* function return */
 
+/* atomic op type fields (stored in immediate) */
+#define BPF_FETCH	0x01	/* fetch previous value into src reg */
+
 /* Register numbers */
 enum {
 	BPF_REG_0 = 0,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1fbb13d30bbc..49a2a533db60 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1632,16 +1632,29 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 			/* lock xadd *(u32 *)(dst_reg + off16) += src_reg */
 			atomic_add((u32) SRC, (atomic_t *)(unsigned long)
 				   (DST + insn->off));
+			break;
+		case BPF_ADD | BPF_FETCH:
+			SRC = (u32) atomic_fetch_add(
+				(u32) SRC,
+				(atomic_t *)(unsigned long) (DST + insn->off));
+			break;
 		default:
 			goto default_label;
 		}
 		CONT;
+
 	STX_ATOMIC_DW:
 		switch (IMM) {
 		case BPF_ADD:
 			/* lock xadd *(u64 *)(dst_reg + off16) += src_reg */
 			atomic64_add((u64) SRC, (atomic64_t *)(unsigned long)
 				     (DST + insn->off));
+			break;
+		case BPF_ADD | BPF_FETCH:
+			SRC = (u64) atomic64_fetch_add(
+				(u64) SRC,
+				(atomic64_t *)(s64) (DST + insn->off));
+			break;
 		default:
 			goto default_label;
 		}
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 37c8d6e9b4cc..3ee2246a52ef 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -160,6 +160,13 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off,
 				insn->src_reg);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == (BPF_ADD | BPF_FETCH)) {
+			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_add(*(%s *)(r%d %+d), r%d)\n",
+				insn->code, insn->src_reg,
+				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->dst_reg, insn->off, insn->src_reg);
 		} else {
 			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e8b41ccdfb90..cd4c03b25573 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3602,7 +3602,11 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 {
 	int err;
 
-	if (insn->imm != BPF_ADD) {
+	switch (insn->imm) {
+	case BPF_ADD:
+	case BPF_ADD | BPF_FETCH:
+		break;
+	default:
 		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
 		return -EINVAL;
 	}
@@ -3631,7 +3635,7 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	    is_pkt_reg(env, insn->dst_reg) ||
 	    is_flow_key_reg(env, insn->dst_reg) ||
 	    is_sk_reg(env, insn->dst_reg)) {
-		verbose(env, "atomic stores into R%d %s is not allowed\n",
+		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
 			insn->dst_reg,
 			reg_type_str[reg_state(env, insn->dst_reg)->type]);
 		return -EACCES;
@@ -3644,8 +3648,20 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 		return err;
 
 	/* check whether we can write into the same memory */
-	return check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-				BPF_SIZE(insn->code), BPF_WRITE, -1, true);
+	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
+			       BPF_SIZE(insn->code), BPF_WRITE, -1, true);
+	if (err)
+		return err;
+
+	if (!(insn->imm & BPF_FETCH))
+		return 0;
+
+	/* check and record load of old value into src reg  */
+	err = check_reg_arg(env, insn->src_reg, DST_OP);
+	if (err)
+		return err;
+
+	return 0;
 }
 
 static int __check_stack_boundary(struct bpf_verifier_env *env, u32 regno,
@@ -9501,12 +9517,6 @@ static int do_check(struct bpf_verifier_env *env)
 		} else if (class == BPF_STX) {
 			enum bpf_reg_type *prev_dst_type, dst_reg_type;
 
-			if (((BPF_MODE(insn->code) != BPF_MEM &&
-			      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
-				verbose(env, "BPF_STX uses reserved fields\n");
-				return -EINVAL;
-			}
-
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
 				err = check_atomic(env, env->insn_idx, insn);
 				if (err)
@@ -9515,6 +9525,11 @@ static int do_check(struct bpf_verifier_env *env)
 				continue;
 			}
 
+			if (BPF_MODE(insn->code) != BPF_MEM && insn->imm != 0) {
+				verbose(env, "BPF_STX uses reserved fields\n");
+				return -EINVAL;
+			}
+
 			/* check src1 operand */
 			err = check_reg_arg(env, insn->src_reg, SRC_OP);
 			if (err)
diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index 95ff51d97f25..ac7701678e1a 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -180,6 +180,16 @@
 		.imm   = BPF_ADD })
 #define BPF_STX_XADD BPF_ATOMIC_ADD /* alias */
 
+/* Atomic memory add with fetch, src_reg = atomic_fetch_add(*(dst_reg + off), src_reg); */
+
+#define BPF_ATOMIC_FETCH_ADD(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_ADD | BPF_FETCH })
+
 /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
 
 #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d0adc48db43c..025e377e7229 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -44,6 +44,9 @@
 #define BPF_CALL	0x80	/* function call */
 #define BPF_EXIT	0x90	/* function return */
 
+/* atomic op type fields (stored in immediate) */
+#define BPF_FETCH	0x01	/* fetch previous value into src reg */
+
 /* Register numbers */
 enum {
 	BPF_REG_0 = 0,
-- 
2.29.2.454.gaff20da3a2-goog

