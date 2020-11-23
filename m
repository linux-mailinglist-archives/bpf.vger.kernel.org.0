Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EB32C1202
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 18:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbgKWRcb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 12:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732710AbgKWRca (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 12:32:30 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E580C0613CF
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 09:32:29 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id a134so5300953wmd.8
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 09:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MZWj62TEXO2rSEWHtRgGeUrEOIO8zUoO+RufRGJ/Ofk=;
        b=aZjwJMDOiwPE3Tb99Bdl1ECVk72dKzYF3IomI52aWNAXtJcH3YGNi89gkqdtsXIZ66
         J4sz/seaWJM/SJTwBtqckZinxbLF5RU2Gbj/uDs+tGhrDYY9L/9j0ErWB2P72Wu6seB0
         /9SlwvuN0oLHb0chvhPhPy1CoTF3WoV1FqwQ26SkRKUoaX+dIwe6h3/wknbklGxMw7XD
         Pe2w9l7TqhMALGHCBhE40lw6QKr9lafx+UFhn2uzNJZSkUMJ22MLDNSIIFykzzGRDIy2
         7NnElzPAUIwb5hhXXP2PPXfg8smmYoyhYtP5qvAsWxdKEXNU+Yf1RkX6wx3MT+gYrtLq
         ZR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MZWj62TEXO2rSEWHtRgGeUrEOIO8zUoO+RufRGJ/Ofk=;
        b=as4dNh3wqJ0db0Zb9bc20ZqPcgBfzy+Cr+LTreGJcS6NHqujbTvZWwnLWrTXHeg1a6
         4TrnlpkZ8Y5BHMOfkUdOTGncz8CYCia+mlIWqNLnDU1Ah6Wr1ChbM3bqwGdrKcYAAVTX
         baZeEN5khyJvHo/QM5F5FXdpS55K8GsGzQpeU9xHv/2dDalgth3rgokACA+4Yejsxwhn
         Ym8LVVuLY2bwX68SSsqMQ7Imw1JRW+2as6k+h1JbgsU3M3HtTvBdBHJre6AXI8OYNyPO
         mELbG2pOFaQ2XATOTgVET3nOpSZl3mMUDP2gPtUMm5WzqN28jtpE41MFEa4qnoxLf76i
         51Uw==
X-Gm-Message-State: AOAM531OIbg7y4qhodQH+kG63ed983tgLDVx4zgI/7qAjAIcrKcqEQZn
        sqhzxBfeT6Gj7f3GffGluZ6a8pM3wJ9JYwSJNpXHPaXc2buB1bZS+zaYNZrmd8teO4Ut/tRwfxT
        BGEC4iJA7l4ippVakniwg4PgXWBl0IGX1LN5n/3CImC+IakmGdVXrLkQHX1nSIDI=
X-Google-Smtp-Source: ABdhPJwN8/k3npSpPlVI2m+IioEdGOt0i7Ok0/gdje6pmn+4jt+ynInNf4kvMgiv48BPvic3gBawjJ5RRb1fvw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:6856:: with SMTP id
 d83mr389791wmc.13.1606152747589; Mon, 23 Nov 2020 09:32:27 -0800 (PST)
Date:   Mon, 23 Nov 2020 17:32:00 +0000
In-Reply-To: <20201123173202.1335708-1-jackmanb@google.com>
Message-Id: <20201123173202.1335708-6-jackmanb@google.com>
Mime-Version: 1.0
References: <20201123173202.1335708-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 5/7] bpf: Add BPF_FETCH field / create atomic_fetch_add instruction
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
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
 arch/x86/net/bpf_jit_comp.c    | 21 ++++++++++---------
 include/linux/filter.h         |  9 +++++++++
 include/uapi/linux/bpf.h       |  3 +++
 kernel/bpf/core.c              | 17 ++++++++++++++--
 kernel/bpf/disasm.c            |  6 ++++++
 kernel/bpf/verifier.c          | 37 +++++++++++++++++++++++++---------
 tools/include/linux/filter.h   | 10 ++++++++-
 tools/include/uapi/linux/bpf.h |  3 +++
 8 files changed, 84 insertions(+), 22 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 0ff2416d99b6..b475bf525424 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1255,22 +1255,25 @@ st:			if (is_imm8(insn->off))
 
 		case BPF_STX | BPF_ATOMIC | BPF_W:
 		case BPF_STX | BPF_ATOMIC | BPF_DW:
-			if (insn->imm != BPF_ADD) {
+			if (BPF_OP(insn->imm) != BPF_ADD) {
 				pr_err("bpf_jit: unknown opcode %02x\n", insn->imm);
 				return -EFAULT;
 			}
 
-			/* XADD: lock *(u32/u64*)(dst_reg + off) += src_reg */
+			EMIT1(0xF0); /* lock prefix */
 
-			if (BPF_SIZE(insn->code) == BPF_W) {
-				/* Emit 'lock add dword ptr [rax + off], eax' */
-				if (is_ereg(dst_reg) || is_ereg(src_reg))
-					EMIT3(0xF0, add_2mod(0x40, dst_reg, src_reg), 0x01);
-				else
-					EMIT2(0xF0, 0x01);
+			maybe_emit_rex(&prog, dst_reg, src_reg,
+				       BPF_SIZE(insn->code) == BPF_DW);
+
+			/* emit opcode */
+			if (insn->imm & BPF_FETCH) {
+				/* src_reg = sync_fetch_and_add(*(dst_reg + off), src_reg); */
+				EMIT2(0x0F, 0xC1);
 			} else {
-				EMIT3(0xF0, add_2mod(0x48, dst_reg, src_reg), 0x01);
+				/* lock *(u32/u64*)(dst_reg + off) += src_reg */
+				EMIT1(0x01);
 			}
+
 			emit_modrm_dstoff(&prog, dst_reg, src_reg, insn->off);
 			break;
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index ce19988fb312..bf0ff3649f46 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -270,6 +270,15 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 		.imm   = BPF_ADD })
 #define BPF_STX_XADD BPF_ATOMIC_ADD /* alias */
 
+/* Atomic memory add with fetch, src_reg = sync_fetch_and_add(*(dst_reg + off), src_reg); */
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
index dcd08783647d..ec7f415f331b 100644
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
index 48b192a8edce..49a2a533db60 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1627,21 +1627,34 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 #undef LDX_PROBE
 
 	STX_ATOMIC_W:
-		switch (insn->imm) {
+		switch (IMM) {
 		case BPF_ADD:
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
-		switch (insn->imm) {
+		switch (IMM) {
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
index 37c8d6e9b4cc..669cef265493 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -160,6 +160,12 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off,
 				insn->src_reg);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == (BPF_ADD | BPF_FETCH)) {
+			verbose(cbs->private_data, "(%02x) r%d = atomic_fetch_add(*(%s *)(r%d %+d), r%d)\n",
+				insn->code, insn->src_reg,
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->dst_reg, insn->off, insn->src_reg);
 		} else {
 			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 609cc5e9571f..14f5053daf22 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3600,9 +3600,14 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 
 static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
 {
+	struct bpf_reg_state *regs = cur_regs(env);
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
@@ -3631,7 +3636,7 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	    is_pkt_reg(env, insn->dst_reg) ||
 	    is_flow_key_reg(env, insn->dst_reg) ||
 	    is_sk_reg(env, insn->dst_reg)) {
-		verbose(env, "atomic stores into R%d %s is not allowed\n",
+		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
 			insn->dst_reg,
 			reg_type_str[reg_state(env, insn->dst_reg)->type]);
 		return -EACCES;
@@ -3644,8 +3649,21 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
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
+	regs[insn->src_reg].type = SCALAR_VALUE;
+
+	return 0;
 }
 
 static int __check_stack_boundary(struct bpf_verifier_env *env, u32 regno,
@@ -9490,12 +9508,6 @@ static int do_check(struct bpf_verifier_env *env)
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
@@ -9504,6 +9516,11 @@ static int do_check(struct bpf_verifier_env *env)
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
index 95ff51d97f25..8f2707ebab18 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -180,7 +180,15 @@
 		.imm   = BPF_ADD })
 #define BPF_STX_XADD BPF_ATOMIC_ADD /* alias */
 
-/* Memory store, *(uint *) (dst_reg + off16) = imm32 */
+/* Atomic memory add with fetch, src_reg = sync_fetch_and_add(*(dst_reg + off), src_reg); */
+
+#define BPF_ATOMIC_FETCH_ADD(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_ADD | BPF_FETCH })
 
 #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
 	((struct bpf_insn) {					\
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index dcd08783647d..ec7f415f331b 100644
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

