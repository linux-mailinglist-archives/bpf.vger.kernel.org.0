Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1A76AA730
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 02:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCDBPR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 20:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjCDBPO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 20:15:14 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C24C9
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 17:14:24 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id i20so4024159lja.11
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 17:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677892379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8GCSDF8nYKuN8XX/bW7kbWfmRld73jvPZd4sV0S/JY=;
        b=RobmXUPBu6Dr52yt1snbgwD3KACTQRYIiRQXmpNi4cV+z3ZAT7UQ32hxQIXj938C4e
         AUMTzGkXppEPii3+lcy/5J7R4ww1jN9klLB2iXmj4enIpfP0R6me2C4ycmLk7/jxBtcU
         qSq/j/ae7c6+E26G8G1Fr80mjDNixUcuDIaKIQheNIDFV+Ls2sRG7Pju3Jgvi6dakwQb
         SW2aFI6jGwOM/1bQQiMfGdf0iB5LRsdA2SEmZjdCoJLl+oJujTlc2H5E9aNomoMImv+B
         LAYqR7I5KWrNFRwL3DSqxetxcRKFc5jziUAPrf0+TOFicMZQqIxifM3FnrLVjAbAxIPl
         amgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677892379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8GCSDF8nYKuN8XX/bW7kbWfmRld73jvPZd4sV0S/JY=;
        b=Dv8fZwo0YEUiQ0oVwfH76X+az7c8OHd0KjwUtXe7VGphfrwWb0LNtOu0AzxlFXkiVa
         NZXcnbXS9n5NlFbQ/Dkq2Eo72vyG6AiB2CkCZyGUi6r1p3Dykvk+DgBbEzzL/tcJiiOu
         2WfhoSnIDBSs2ejuIGVgN6SfbVuuCcnPcq6mxbQxXhbwcayQ6m/vohr8C8viK1F8WEqO
         6q02Vxc+gUXfhYcDBkP2ZPaRpevM/b1GGUOLJFO66NcrCPSx2j7dRpkwuoCVygOQ77tj
         KxV20TG6/kUMm29FlFOhNCy37RWodyHD3R8Fd8RDNhF5wtWEoro2A9mONWSDujUfP05x
         2ALA==
X-Gm-Message-State: AO0yUKVEFF+//8Js5ZMbkxJSpRtpjy1vKThzTEBNpmztuxtzCp1L2WMA
        m8G/WJoJ5VCBKANCpYmmiXWf8EyF9TkdBA==
X-Google-Smtp-Source: AK7set86UIkRZw2PBrexMY9sRcNe36nkPGySMFc28nuSUwexFkGeAXs72Ca3mSJQT2NYzrhZnS8BZw==
X-Received: by 2002:a05:651c:1204:b0:28f:265d:11da with SMTP id i4-20020a05651c120400b0028f265d11damr885593lja.13.1677892379233;
        Fri, 03 Mar 2023 17:12:59 -0800 (PST)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id x7-20020a05651c104700b00295b588d21dsm569609ljm.49.2023.03.03.17.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 17:12:58 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/3] bpf: allow ctx writes using BPF_ST_MEM instruction
Date:   Sat,  4 Mar 2023 03:12:45 +0200
Message-Id: <20230304011247.566040-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230304011247.566040-1-eddyz87@gmail.com>
References: <20230304011247.566040-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lift verifier restriction to use BPF_ST_MEM instructions to write to
context data structures. This requires the following changes:
 - verifier.c:do_check() for BPF_ST updated to:
   - no longer forbid writes to registers of type PTR_TO_CTX;
   - track dst_reg type in the env->insn_aux_data[...].ptr_type field
     (same way it is done for BPF_STX and BPF_LDX instructions).
 - verifier.c:convert_ctx_access() and various callbacks invoked by
   it are updated to handled BPF_ST instruction alongside BPF_STX.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/cgroup.c                        |  49 +++++----
 kernel/bpf/verifier.c                      | 110 ++++++++++-----------
 net/core/filter.c                          |  79 ++++++++-------
 tools/testing/selftests/bpf/verifier/ctx.c |  11 ---
 4 files changed, 126 insertions(+), 123 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index a4ae422b8f12..53edb8ad2471 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2223,10 +2223,12 @@ static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
 				BPF_FIELD_SIZEOF(struct bpf_sysctl_kern, ppos),
 				treg, si->dst_reg,
 				offsetof(struct bpf_sysctl_kern, ppos));
-			*insn++ = BPF_STX_MEM(
-				BPF_SIZEOF(u32), treg, si->src_reg,
+			*insn++ = BPF_RAW_INSN(
+				BPF_CLASS(si->code) | BPF_MEM | BPF_SIZEOF(u32),
+				treg, si->src_reg,
 				bpf_ctx_narrow_access_offset(
-					0, sizeof(u32), sizeof(loff_t)));
+					0, sizeof(u32), sizeof(loff_t)),
+				si->imm);
 			*insn++ = BPF_LDX_MEM(
 				BPF_DW, treg, si->dst_reg,
 				offsetof(struct bpf_sysctl_kern, tmp_reg));
@@ -2376,10 +2378,17 @@ static bool cg_sockopt_is_valid_access(int off, int size,
 	return true;
 }
 
-#define CG_SOCKOPT_ACCESS_FIELD(T, F)					\
-	T(BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, F),			\
-	  si->dst_reg, si->src_reg,					\
-	  offsetof(struct bpf_sockopt_kern, F))
+#define CG_SOCKOPT_READ_FIELD(F)					\
+	BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, F),	\
+		    si->dst_reg, si->src_reg,				\
+		    offsetof(struct bpf_sockopt_kern, F))
+
+#define CG_SOCKOPT_WRITE_FIELD(F)					\
+	BPF_RAW_INSN((BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, F) |	\
+		      BPF_MEM | BPF_CLASS(si->code)),			\
+		     si->dst_reg, si->src_reg,				\
+		     offsetof(struct bpf_sockopt_kern, F),		\
+		     si->imm)
 
 static u32 cg_sockopt_convert_ctx_access(enum bpf_access_type type,
 					 const struct bpf_insn *si,
@@ -2391,25 +2400,25 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_access_type type,
 
 	switch (si->off) {
 	case offsetof(struct bpf_sockopt, sk):
-		*insn++ = CG_SOCKOPT_ACCESS_FIELD(BPF_LDX_MEM, sk);
+		*insn++ = CG_SOCKOPT_READ_FIELD(sk);
 		break;
 	case offsetof(struct bpf_sockopt, level):
 		if (type == BPF_WRITE)
-			*insn++ = CG_SOCKOPT_ACCESS_FIELD(BPF_STX_MEM, level);
+			*insn++ = CG_SOCKOPT_WRITE_FIELD(level);
 		else
-			*insn++ = CG_SOCKOPT_ACCESS_FIELD(BPF_LDX_MEM, level);
+			*insn++ = CG_SOCKOPT_READ_FIELD(level);
 		break;
 	case offsetof(struct bpf_sockopt, optname):
 		if (type == BPF_WRITE)
-			*insn++ = CG_SOCKOPT_ACCESS_FIELD(BPF_STX_MEM, optname);
+			*insn++ = CG_SOCKOPT_WRITE_FIELD(optname);
 		else
-			*insn++ = CG_SOCKOPT_ACCESS_FIELD(BPF_LDX_MEM, optname);
+			*insn++ = CG_SOCKOPT_READ_FIELD(optname);
 		break;
 	case offsetof(struct bpf_sockopt, optlen):
 		if (type == BPF_WRITE)
-			*insn++ = CG_SOCKOPT_ACCESS_FIELD(BPF_STX_MEM, optlen);
+			*insn++ = CG_SOCKOPT_WRITE_FIELD(optlen);
 		else
-			*insn++ = CG_SOCKOPT_ACCESS_FIELD(BPF_LDX_MEM, optlen);
+			*insn++ = CG_SOCKOPT_READ_FIELD(optlen);
 		break;
 	case offsetof(struct bpf_sockopt, retval):
 		BUILD_BUG_ON(offsetof(struct bpf_cg_run_ctx, run_ctx) != 0);
@@ -2429,9 +2438,11 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_access_type type,
 			*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct task_struct, bpf_ctx),
 					      treg, treg,
 					      offsetof(struct task_struct, bpf_ctx));
-			*insn++ = BPF_STX_MEM(BPF_FIELD_SIZEOF(struct bpf_cg_run_ctx, retval),
-					      treg, si->src_reg,
-					      offsetof(struct bpf_cg_run_ctx, retval));
+			*insn++ = BPF_RAW_INSN(BPF_CLASS(si->code) | BPF_MEM |
+					       BPF_FIELD_SIZEOF(struct bpf_cg_run_ctx, retval),
+					       treg, si->src_reg,
+					       offsetof(struct bpf_cg_run_ctx, retval),
+					       si->imm);
 			*insn++ = BPF_LDX_MEM(BPF_DW, treg, si->dst_reg,
 					      offsetof(struct bpf_sockopt_kern, tmp_reg));
 		} else {
@@ -2447,10 +2458,10 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_access_type type,
 		}
 		break;
 	case offsetof(struct bpf_sockopt, optval):
-		*insn++ = CG_SOCKOPT_ACCESS_FIELD(BPF_LDX_MEM, optval);
+		*insn++ = CG_SOCKOPT_READ_FIELD(optval);
 		break;
 	case offsetof(struct bpf_sockopt, optval_end):
-		*insn++ = CG_SOCKOPT_ACCESS_FIELD(BPF_LDX_MEM, optval_end);
+		*insn++ = CG_SOCKOPT_READ_FIELD(optval_end);
 		break;
 	}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c2adf3c24c64..4c5d2b5e25c8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14813,6 +14813,44 @@ static bool reg_type_mismatch(enum bpf_reg_type src, enum bpf_reg_type prev)
 			       !reg_type_mismatch_ok(prev));
 }
 
+static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
+			     bool allow_trust_missmatch)
+{
+	enum bpf_reg_type *prev_type = &env->insn_aux_data[env->insn_idx].ptr_type;
+
+	if (*prev_type == NOT_INIT) {
+		/* Saw a valid insn
+		 * dst_reg = *(u32 *)(src_reg + off)
+		 * save type to validate intersecting paths
+		 */
+		*prev_type = type;
+	} else if (reg_type_mismatch(type, *prev_type)) {
+		/* Abuser program is trying to use the same insn
+		 * dst_reg = *(u32*) (src_reg + off)
+		 * with different pointer types:
+		 * src_reg == ctx in one branch and
+		 * src_reg == stack|map in some other branch.
+		 * Reject it.
+		 */
+		if (allow_trust_missmatch &&
+		    base_type(type) == PTR_TO_BTF_ID &&
+		    base_type(*prev_type) == PTR_TO_BTF_ID) {
+			/*
+			 * Have to support a use case when one path through
+			 * the program yields TRUSTED pointer while another
+			 * is UNTRUSTED. Fallback to UNTRUSTED to generate
+			 * BPF_PROBE_MEM.
+			 */
+			*prev_type = PTR_TO_BTF_ID | PTR_UNTRUSTED;
+		} else {
+			verbose(env, "same insn cannot be used with different pointers\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int do_check(struct bpf_verifier_env *env)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
@@ -14922,7 +14960,7 @@ static int do_check(struct bpf_verifier_env *env)
 				return err;
 
 		} else if (class == BPF_LDX) {
-			enum bpf_reg_type *prev_src_type, src_reg_type;
+			enum bpf_reg_type src_reg_type;
 
 			/* check for reserved fields is already done */
 
@@ -14946,43 +14984,11 @@ static int do_check(struct bpf_verifier_env *env)
 			if (err)
 				return err;
 
-			prev_src_type = &env->insn_aux_data[env->insn_idx].ptr_type;
-
-			if (*prev_src_type == NOT_INIT) {
-				/* saw a valid insn
-				 * dst_reg = *(u32 *)(src_reg + off)
-				 * save type to validate intersecting paths
-				 */
-				*prev_src_type = src_reg_type;
-
-			} else if (reg_type_mismatch(src_reg_type, *prev_src_type)) {
-				/* ABuser program is trying to use the same insn
-				 * dst_reg = *(u32*) (src_reg + off)
-				 * with different pointer types:
-				 * src_reg == ctx in one branch and
-				 * src_reg == stack|map in some other branch.
-				 * Reject it.
-				 */
-				if (base_type(src_reg_type) == PTR_TO_BTF_ID &&
-				    base_type(*prev_src_type) == PTR_TO_BTF_ID) {
-					/*
-					 * Have to support a use case when one path through
-					 * the program yields TRUSTED pointer while another
-					 * is UNTRUSTED. Fallback to UNTRUSTED to generate
-					 * BPF_PROBE_MEM.
-					 */
-					*prev_src_type = PTR_TO_BTF_ID | PTR_UNTRUSTED;
-				} else {
-					verbose(env,
-						"The same insn cannot be used with different pointers: %s",
-						reg_type_str(env, src_reg_type));
-					verbose(env, " != %s\n", reg_type_str(env, *prev_src_type));
-					return -EINVAL;
-				}
-			}
-
+			err = save_aux_ptr_type(env, src_reg_type, true);
+			if (err)
+				return err;
 		} else if (class == BPF_STX) {
-			enum bpf_reg_type *prev_dst_type, dst_reg_type;
+			enum bpf_reg_type dst_reg_type;
 
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
 				err = check_atomic(env, env->insn_idx, insn);
@@ -15015,16 +15021,12 @@ static int do_check(struct bpf_verifier_env *env)
 			if (err)
 				return err;
 
-			prev_dst_type = &env->insn_aux_data[env->insn_idx].ptr_type;
-
-			if (*prev_dst_type == NOT_INIT) {
-				*prev_dst_type = dst_reg_type;
-			} else if (reg_type_mismatch(dst_reg_type, *prev_dst_type)) {
-				verbose(env, "same insn cannot be used with different pointers\n");
-				return -EINVAL;
-			}
-
+			err = save_aux_ptr_type(env, dst_reg_type, false);
+			if (err)
+				return err;
 		} else if (class == BPF_ST) {
+			enum bpf_reg_type dst_reg_type;
+
 			if (BPF_MODE(insn->code) != BPF_MEM ||
 			    insn->src_reg != BPF_REG_0) {
 				verbose(env, "BPF_ST uses reserved fields\n");
@@ -15035,12 +15037,7 @@ static int do_check(struct bpf_verifier_env *env)
 			if (err)
 				return err;
 
-			if (is_ctx_reg(env, insn->dst_reg)) {
-				verbose(env, "BPF_ST stores into R%d %s is not allowed\n",
-					insn->dst_reg,
-					reg_type_str(env, reg_state(env, insn->dst_reg)->type));
-				return -EACCES;
-			}
+			dst_reg_type = regs[insn->dst_reg].type;
 
 			/* check that memory (dst_reg + off) is writeable */
 			err = check_mem_access(env, env->insn_idx, insn->dst_reg,
@@ -15049,6 +15046,9 @@ static int do_check(struct bpf_verifier_env *env)
 			if (err)
 				return err;
 
+			err = save_aux_ptr_type(env, dst_reg_type, false);
+			if (err)
+				return err;
 		} else if (class == BPF_JMP || class == BPF_JMP32) {
 			u8 opcode = BPF_OP(insn->code);
 
@@ -16157,14 +16157,12 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		bpf_convert_ctx_access_t convert_ctx_access;
-		bool ctx_access;
 
 		if (insn->code == (BPF_LDX | BPF_MEM | BPF_B) ||
 		    insn->code == (BPF_LDX | BPF_MEM | BPF_H) ||
 		    insn->code == (BPF_LDX | BPF_MEM | BPF_W) ||
 		    insn->code == (BPF_LDX | BPF_MEM | BPF_DW)) {
 			type = BPF_READ;
-			ctx_access = true;
 		} else if (insn->code == (BPF_STX | BPF_MEM | BPF_B) ||
 			   insn->code == (BPF_STX | BPF_MEM | BPF_H) ||
 			   insn->code == (BPF_STX | BPF_MEM | BPF_W) ||
@@ -16174,7 +16172,6 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			   insn->code == (BPF_ST | BPF_MEM | BPF_W) ||
 			   insn->code == (BPF_ST | BPF_MEM | BPF_DW)) {
 			type = BPF_WRITE;
-			ctx_access = BPF_CLASS(insn->code) == BPF_STX;
 		} else {
 			continue;
 		}
@@ -16197,9 +16194,6 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			continue;
 		}
 
-		if (!ctx_access)
-			continue;
-
 		switch ((int)env->insn_aux_data[i + delta].ptr_type) {
 		case PTR_TO_CTX:
 			if (!ops->convert_ctx_access)
diff --git a/net/core/filter.c b/net/core/filter.c
index a2dc44e70ea0..50f649f1b4a9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9279,11 +9279,15 @@ static struct bpf_insn *bpf_convert_tstamp_write(const struct bpf_prog *prog,
 #endif
 
 	/* <store>: skb->tstamp = tstamp */
-	*insn++ = BPF_STX_MEM(BPF_DW, skb_reg, value_reg,
-			      offsetof(struct sk_buff, tstamp));
+	*insn++ = BPF_RAW_INSN(BPF_CLASS(si->code) | BPF_DW | BPF_MEM,
+			       skb_reg, value_reg, offsetof(struct sk_buff, tstamp), si->imm);
 	return insn;
 }
 
+#define BPF_EMIT_STORE(size, si, off)					\
+	BPF_RAW_INSN(BPF_CLASS((si)->code) | (size) | BPF_MEM,		\
+		     (si)->dst_reg, (si)->src_reg, (off), (si)->imm)
+
 static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 				  const struct bpf_insn *si,
 				  struct bpf_insn *insn_buf,
@@ -9313,9 +9317,9 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 
 	case offsetof(struct __sk_buff, priority):
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
-					      bpf_target_off(struct sk_buff, priority, 4,
-							     target_size));
+			*insn++ = BPF_EMIT_STORE(BPF_W, si,
+						 bpf_target_off(struct sk_buff, priority, 4,
+								target_size));
 		else
 			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
 					      bpf_target_off(struct sk_buff, priority, 4,
@@ -9346,9 +9350,9 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 
 	case offsetof(struct __sk_buff, mark):
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
-					      bpf_target_off(struct sk_buff, mark, 4,
-							     target_size));
+			*insn++ = BPF_EMIT_STORE(BPF_W, si,
+						 bpf_target_off(struct sk_buff, mark, 4,
+								target_size));
 		else
 			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
 					      bpf_target_off(struct sk_buff, mark, 4,
@@ -9367,11 +9371,16 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 
 	case offsetof(struct __sk_buff, queue_mapping):
 		if (type == BPF_WRITE) {
-			*insn++ = BPF_JMP_IMM(BPF_JGE, si->src_reg, NO_QUEUE_MAPPING, 1);
-			*insn++ = BPF_STX_MEM(BPF_H, si->dst_reg, si->src_reg,
-					      bpf_target_off(struct sk_buff,
-							     queue_mapping,
-							     2, target_size));
+			u32 off = bpf_target_off(struct sk_buff, queue_mapping, 2, target_size);
+
+			if (BPF_CLASS(si->code) == BPF_ST && si->imm >= NO_QUEUE_MAPPING) {
+				*insn++ = BPF_JMP_A(0); /* noop */
+				break;
+			}
+
+			if (BPF_CLASS(si->code) == BPF_STX)
+				*insn++ = BPF_JMP_IMM(BPF_JGE, si->src_reg, NO_QUEUE_MAPPING, 1);
+			*insn++ = BPF_EMIT_STORE(BPF_H, si, off);
 		} else {
 			*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
 					      bpf_target_off(struct sk_buff,
@@ -9407,8 +9416,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 		off += offsetof(struct sk_buff, cb);
 		off += offsetof(struct qdisc_skb_cb, data);
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_SIZE(si->code), si->dst_reg,
-					      si->src_reg, off);
+			*insn++ = BPF_EMIT_STORE(BPF_SIZE(si->code), si, off);
 		else
 			*insn++ = BPF_LDX_MEM(BPF_SIZE(si->code), si->dst_reg,
 					      si->src_reg, off);
@@ -9423,8 +9431,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 		off += offsetof(struct qdisc_skb_cb, tc_classid);
 		*target_size = 2;
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_H, si->dst_reg,
-					      si->src_reg, off);
+			*insn++ = BPF_EMIT_STORE(BPF_H, si, off);
 		else
 			*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg,
 					      si->src_reg, off);
@@ -9457,9 +9464,9 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 	case offsetof(struct __sk_buff, tc_index):
 #ifdef CONFIG_NET_SCHED
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_H, si->dst_reg, si->src_reg,
-					      bpf_target_off(struct sk_buff, tc_index, 2,
-							     target_size));
+			*insn++ = BPF_EMIT_STORE(BPF_H, si,
+						 bpf_target_off(struct sk_buff, tc_index, 2,
+								target_size));
 		else
 			*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
 					      bpf_target_off(struct sk_buff, tc_index, 2,
@@ -9660,8 +9667,8 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
 		BUILD_BUG_ON(sizeof_field(struct sock, sk_bound_dev_if) != 4);
 
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
-					offsetof(struct sock, sk_bound_dev_if));
+			*insn++ = BPF_EMIT_STORE(BPF_W, si,
+						 offsetof(struct sock, sk_bound_dev_if));
 		else
 			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
 				      offsetof(struct sock, sk_bound_dev_if));
@@ -9671,8 +9678,8 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
 		BUILD_BUG_ON(sizeof_field(struct sock, sk_mark) != 4);
 
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
-					offsetof(struct sock, sk_mark));
+			*insn++ = BPF_EMIT_STORE(BPF_W, si,
+						 offsetof(struct sock, sk_mark));
 		else
 			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
 				      offsetof(struct sock, sk_mark));
@@ -9682,8 +9689,8 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
 		BUILD_BUG_ON(sizeof_field(struct sock, sk_priority) != 4);
 
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
-					offsetof(struct sock, sk_priority));
+			*insn++ = BPF_EMIT_STORE(BPF_W, si,
+						 offsetof(struct sock, sk_priority));
 		else
 			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
 				      offsetof(struct sock, sk_priority));
@@ -9948,10 +9955,12 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
 				      offsetof(S, TF));			       \
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(S, F), tmp_reg,	       \
 				      si->dst_reg, offsetof(S, F));	       \
-		*insn++ = BPF_STX_MEM(SIZE, tmp_reg, si->src_reg,	       \
+		*insn++ = BPF_RAW_INSN(SIZE | BPF_MEM | BPF_CLASS(si->code),   \
+				       tmp_reg, si->src_reg,		       \
 			bpf_target_off(NS, NF, sizeof_field(NS, NF),	       \
 				       target_size)			       \
-				+ OFF);					       \
+				       + OFF,				       \
+				       si->imm);			       \
 		*insn++ = BPF_LDX_MEM(BPF_DW, tmp_reg, si->dst_reg,	       \
 				      offsetof(S, TF));			       \
 	} while (0)
@@ -10186,9 +10195,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 						struct bpf_sock_ops_kern, sk),\
 				      reg, si->dst_reg,			      \
 				      offsetof(struct bpf_sock_ops_kern, sk));\
-		*insn++ = BPF_STX_MEM(BPF_FIELD_SIZEOF(OBJ, OBJ_FIELD),	      \
-				      reg, si->src_reg,			      \
-				      offsetof(OBJ, OBJ_FIELD));	      \
+		*insn++ = BPF_RAW_INSN(BPF_FIELD_SIZEOF(OBJ, OBJ_FIELD) |     \
+				       BPF_MEM | BPF_CLASS(si->code),	      \
+				       reg, si->src_reg,		      \
+				       offsetof(OBJ, OBJ_FIELD),	      \
+				       si->imm);			      \
 		*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->dst_reg,		      \
 				      offsetof(struct bpf_sock_ops_kern,      \
 					       temp));			      \
@@ -10220,8 +10231,7 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 		off -= offsetof(struct bpf_sock_ops, replylong[0]);
 		off += offsetof(struct bpf_sock_ops_kern, replylong[0]);
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
-					      off);
+			*insn++ = BPF_EMIT_STORE(BPF_W, si, off);
 		else
 			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
 					      off);
@@ -10578,8 +10588,7 @@ static u32 sk_skb_convert_ctx_access(enum bpf_access_type type,
 		off += offsetof(struct sk_buff, cb);
 		off += offsetof(struct sk_skb_cb, data);
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_SIZE(si->code), si->dst_reg,
-					      si->src_reg, off);
+			*insn++ = BPF_EMIT_STORE(BPF_SIZE(si->code), si, off);
 		else
 			*insn++ = BPF_LDX_MEM(BPF_SIZE(si->code), si->dst_reg,
 					      si->src_reg, off);
diff --git a/tools/testing/selftests/bpf/verifier/ctx.c b/tools/testing/selftests/bpf/verifier/ctx.c
index c8eaf0536c24..2fd31612c0b8 100644
--- a/tools/testing/selftests/bpf/verifier/ctx.c
+++ b/tools/testing/selftests/bpf/verifier/ctx.c
@@ -1,14 +1,3 @@
-{
-	"context stores via ST",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_1, offsetof(struct __sk_buff, mark), 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "BPF_ST stores into R1 ctx is not allowed",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
 {
 	"context stores via BPF_ATOMIC",
 	.insns = {
-- 
2.39.1

