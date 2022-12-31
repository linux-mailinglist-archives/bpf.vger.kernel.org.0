Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF42B65A5BB
	for <lists+bpf@lfdr.de>; Sat, 31 Dec 2022 17:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiLaQcJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Dec 2022 11:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiLaQcB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 31 Dec 2022 11:32:01 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41596418
        for <bpf@vger.kernel.org>; Sat, 31 Dec 2022 08:31:58 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f34so35821291lfv.10
        for <bpf@vger.kernel.org>; Sat, 31 Dec 2022 08:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVKBH/7z1csl7Vm5CqJKuI80GjBbwfyD7SXRRAfFPXg=;
        b=Gsw2dWEePEi73W3VXtnIQxYA1MYKBs5Ne8wl7elxG0D5/L72UEmIMhusegYHg6OkZv
         EUIEi+Ax08LKlAcvmuQPTtl8Ijcgn4sjlN78vwubUaAZU7fyzc+awN/S5p+L7pXIdkK7
         ksfReogB/XlO7p0GP6A0VF/Mjt8RH0YBlSiXSLGMEUA/dhe7SMSu/GZ8t242khVmS0DA
         87Vhbq8d6lWhuYAB+eWHuvg1OtIyDteCL97KjtbTznf+IYtVLn0EAfHRBIpL/mr/M6fj
         srnjaj9zNUCh9GbrYQfZwk0GuGWM8pEepABSHPXq6a4m9+CNJuzA9H+smcDmGnNUy5/O
         vsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVKBH/7z1csl7Vm5CqJKuI80GjBbwfyD7SXRRAfFPXg=;
        b=DqPH1XAFrZ61sxRhOzUcJkv3864Dae6c9tRIwb55kvRo2x0B4WqNj/Yw4QJcewO/41
         VKSsobisDsvmYZeYveMTwH9WGFb+HWromRB1/udzBnJNEPGF+/waUXWUHY/sSeGXdS/v
         aRTCyGs5K8PpRQ9gSZZg4Ulsjjjcxc8KaqbxPlDoVLM3RAnTSD60MyapUhHJmo/noO/3
         JB2j6K8tOmjBDk/sqr8BB0Qv8iRytBiNZWeayPxv/OTD7ezU+p/JGaFaTBIX67JaForv
         6xU+0OOVdLkals8ftNn065E7kFBkurSAyHCmIhUOcrodx4X3K2UhaDpo0NuccCaf65Do
         6U0A==
X-Gm-Message-State: AFqh2krBvqyV1d1zHYWxuWPp5RsyTi31B0SLHHSmkFfgSxBVpTtnEWDA
        4wipPTpGSvZbrwW7GArAR63eghQydjg=
X-Google-Smtp-Source: AMrXdXvXsDWD2qELO4VBYpB01MQlcZ592PbudbNwL8EJsjcRSvyz574NdcazGVru1uTF6ycI/N3Dog==
X-Received: by 2002:a05:6512:2394:b0:4b5:987c:de3e with SMTP id c20-20020a056512239400b004b5987cde3emr15213024lfv.69.1672504316816;
        Sat, 31 Dec 2022 08:31:56 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c10-20020a19e34a000000b004b4930d53b5sm3876784lfk.134.2022.12.31.08.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:31:56 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 3/5] bpf: allow ctx writes using BPF_ST_MEM instruction
Date:   Sat, 31 Dec 2022 18:31:20 +0200
Message-Id: <20221231163122.1360813-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231163122.1360813-1-eddyz87@gmail.com>
References: <20221231163122.1360813-1-eddyz87@gmail.com>
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
   it are updated to handle BPF_ST instruction alongside BPF_STX.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/cgroup.c                        | 49 ++++++++------
 kernel/bpf/verifier.c                      | 79 +++++++++++-----------
 net/core/filter.c                          | 72 ++++++++++----------
 tools/testing/selftests/bpf/verifier/ctx.c | 11 ---
 4 files changed, 108 insertions(+), 103 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index bf2fdb33fb31..a57f1b44dc6c 100644
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
index 585edea642e1..be7d8df7257d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13742,6 +13742,31 @@ static bool reg_type_mismatch(enum bpf_reg_type src, enum bpf_reg_type prev)
 			       !reg_type_mismatch_ok(prev));
 }
 
+static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type)
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
+		verbose(env, "same insn cannot be used with different pointers\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int do_check(struct bpf_verifier_env *env)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
@@ -13851,7 +13876,7 @@ static int do_check(struct bpf_verifier_env *env)
 				return err;
 
 		} else if (class == BPF_LDX) {
-			enum bpf_reg_type *prev_src_type, src_reg_type;
+			enum bpf_reg_type src_reg_type;
 
 			/* check for reserved fields is already done */
 
@@ -13875,29 +13900,11 @@ static int do_check(struct bpf_verifier_env *env)
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
-				verbose(env, "same insn cannot be used with different pointers\n");
-				return -EINVAL;
-			}
-
+			err = save_aux_ptr_type(env, src_reg_type);
+			if (err)
+				return err;
 		} else if (class == BPF_STX) {
-			enum bpf_reg_type *prev_dst_type, dst_reg_type;
+			enum bpf_reg_type dst_reg_type;
 
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
 				err = check_atomic(env, env->insn_idx, insn);
@@ -13930,16 +13937,12 @@ static int do_check(struct bpf_verifier_env *env)
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
+			err = save_aux_ptr_type(env, dst_reg_type);
+			if (err)
+				return err;
 		} else if (class == BPF_ST) {
+			enum bpf_reg_type dst_reg_type;
+
 			if (BPF_MODE(insn->code) != BPF_MEM ||
 			    insn->src_reg != BPF_REG_0) {
 				verbose(env, "BPF_ST uses reserved fields\n");
@@ -13950,12 +13953,7 @@ static int do_check(struct bpf_verifier_env *env)
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
@@ -13964,6 +13962,9 @@ static int do_check(struct bpf_verifier_env *env)
 			if (err)
 				return err;
 
+			err = save_aux_ptr_type(env, dst_reg_type);
+			if (err)
+				return err;
 		} else if (class == BPF_JMP || class == BPF_JMP32) {
 			u8 opcode = BPF_OP(insn->code);
 
@@ -15087,7 +15088,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			   insn->code == (BPF_ST | BPF_MEM | BPF_W) ||
 			   insn->code == (BPF_ST | BPF_MEM | BPF_DW)) {
 			type = BPF_WRITE;
-			ctx_access = BPF_CLASS(insn->code) == BPF_STX;
+			ctx_access = true;
 		} else {
 			continue;
 		}
diff --git a/net/core/filter.c b/net/core/filter.c
index c746e4d77214..1353bb1d476a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9221,11 +9221,15 @@ static struct bpf_insn *bpf_convert_tstamp_write(const struct bpf_prog *prog,
 #endif
 
 	/* <store>: skb->tstamp = tstamp */
-	*insn++ = BPF_STX_MEM(BPF_DW, skb_reg, value_reg,
-			      offsetof(struct sk_buff, tstamp));
+	*insn++ = BPF_RAW_INSN(BPF_CLASS(si->code) | BPF_DW | BPF_MEM,
+			       skb_reg, value_reg, offsetof(struct sk_buff, tstamp), si->imm);
 	return insn;
 }
 
+#define BPF_COPY_STORE(size, si, off)					\
+	BPF_RAW_INSN((si)->code | (size) | BPF_MEM,			\
+		     (si)->dst_reg, (si)->src_reg, (off), (si)->imm)
+
 static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 				  const struct bpf_insn *si,
 				  struct bpf_insn *insn_buf,
@@ -9255,9 +9259,9 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 
 	case offsetof(struct __sk_buff, priority):
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
-					      bpf_target_off(struct sk_buff, priority, 4,
-							     target_size));
+			*insn++ = BPF_COPY_STORE(BPF_W, si,
+						 bpf_target_off(struct sk_buff, priority, 4,
+								target_size));
 		else
 			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
 					      bpf_target_off(struct sk_buff, priority, 4,
@@ -9288,9 +9292,9 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 
 	case offsetof(struct __sk_buff, mark):
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
-					      bpf_target_off(struct sk_buff, mark, 4,
-							     target_size));
+			*insn++ = BPF_COPY_STORE(BPF_W, si,
+						 bpf_target_off(struct sk_buff, mark, 4,
+								target_size));
 		else
 			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
 					      bpf_target_off(struct sk_buff, mark, 4,
@@ -9310,10 +9314,10 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 	case offsetof(struct __sk_buff, queue_mapping):
 		if (type == BPF_WRITE) {
 			*insn++ = BPF_JMP_IMM(BPF_JGE, si->src_reg, NO_QUEUE_MAPPING, 1);
-			*insn++ = BPF_STX_MEM(BPF_H, si->dst_reg, si->src_reg,
-					      bpf_target_off(struct sk_buff,
-							     queue_mapping,
-							     2, target_size));
+			*insn++ = BPF_COPY_STORE(BPF_H, si,
+						 bpf_target_off(struct sk_buff,
+								queue_mapping,
+								2, target_size));
 		} else {
 			*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
 					      bpf_target_off(struct sk_buff,
@@ -9349,8 +9353,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 		off += offsetof(struct sk_buff, cb);
 		off += offsetof(struct qdisc_skb_cb, data);
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_SIZE(si->code), si->dst_reg,
-					      si->src_reg, off);
+			*insn++ = BPF_COPY_STORE(BPF_SIZE(si->code), si, off);
 		else
 			*insn++ = BPF_LDX_MEM(BPF_SIZE(si->code), si->dst_reg,
 					      si->src_reg, off);
@@ -9365,8 +9368,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 		off += offsetof(struct qdisc_skb_cb, tc_classid);
 		*target_size = 2;
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_H, si->dst_reg,
-					      si->src_reg, off);
+			*insn++ = BPF_COPY_STORE(BPF_H, si, off);
 		else
 			*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg,
 					      si->src_reg, off);
@@ -9399,9 +9401,9 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 	case offsetof(struct __sk_buff, tc_index):
 #ifdef CONFIG_NET_SCHED
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_H, si->dst_reg, si->src_reg,
-					      bpf_target_off(struct sk_buff, tc_index, 2,
-							     target_size));
+			*insn++ = BPF_COPY_STORE(BPF_H, si,
+						 bpf_target_off(struct sk_buff, tc_index, 2,
+								target_size));
 		else
 			*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
 					      bpf_target_off(struct sk_buff, tc_index, 2,
@@ -9602,8 +9604,8 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
 		BUILD_BUG_ON(sizeof_field(struct sock, sk_bound_dev_if) != 4);
 
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
-					offsetof(struct sock, sk_bound_dev_if));
+			*insn++ = BPF_COPY_STORE(BPF_W, si,
+						 offsetof(struct sock, sk_bound_dev_if));
 		else
 			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
 				      offsetof(struct sock, sk_bound_dev_if));
@@ -9613,8 +9615,8 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
 		BUILD_BUG_ON(sizeof_field(struct sock, sk_mark) != 4);
 
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
-					offsetof(struct sock, sk_mark));
+			*insn++ = BPF_COPY_STORE(BPF_W, si,
+						 offsetof(struct sock, sk_mark));
 		else
 			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
 				      offsetof(struct sock, sk_mark));
@@ -9624,8 +9626,8 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
 		BUILD_BUG_ON(sizeof_field(struct sock, sk_priority) != 4);
 
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
-					offsetof(struct sock, sk_priority));
+			*insn++ = BPF_COPY_STORE(BPF_W, si,
+						 offsetof(struct sock, sk_priority));
 		else
 			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
 				      offsetof(struct sock, sk_priority));
@@ -9890,10 +9892,12 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
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
@@ -10128,9 +10132,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
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
@@ -10165,8 +10171,7 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 		off -= offsetof(struct bpf_sock_ops, replylong[0]);
 		off += offsetof(struct bpf_sock_ops_kern, replylong[0]);
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
-					      off);
+			*insn++ = BPF_COPY_STORE(BPF_W, si, off);
 		else
 			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
 					      off);
@@ -10523,8 +10528,7 @@ static u32 sk_skb_convert_ctx_access(enum bpf_access_type type,
 		off += offsetof(struct sk_buff, cb);
 		off += offsetof(struct sk_skb_cb, data);
 		if (type == BPF_WRITE)
-			*insn++ = BPF_STX_MEM(BPF_SIZE(si->code), si->dst_reg,
-					      si->src_reg, off);
+			*insn++ = BPF_COPY_STORE(BPF_SIZE(si->code), si, off);
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
2.39.0

