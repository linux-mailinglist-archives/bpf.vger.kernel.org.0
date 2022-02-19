Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE39E4BC835
	for <lists+bpf@lfdr.de>; Sat, 19 Feb 2022 12:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbiBSLiK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 06:38:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiBSLiK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 06:38:10 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAC848E44
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 03:37:51 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id u5so9144363ple.3
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 03:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZrNbb/lP1qfFQuwD0rXE6y3suB1KZOEdhvMMRZoTd6M=;
        b=Hsz81QJHOIV9peinrimTkaxNTSOSJpOBNPOHJYtyH0RZGx9llyVdScg9Wo18YGDT0C
         WpYYKDY/ciKHmBEWYaD3tIA0rcSJYFc2AaMC83S9JxyTIDGABtklk79+25vHFuowXZ8r
         t9xU2u+U/Rd7A9z7rvXA2g7Lyl32OI+XmSqTYSnz2s1rfntouZWKOizukBzqjS4x6TJD
         yghx65tjrQfgtLyWDsmPfkfWoEth/R1xZKTQw+oZ1C8JufSwA9kDTExO2xMcWCeU0MeZ
         GX57i3qGC1Irfv3MpVFNaKRV3rS/0vboG2G2GP/XxJm6Ne5D9i+zB7PKGRJdUFggfP1e
         khig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZrNbb/lP1qfFQuwD0rXE6y3suB1KZOEdhvMMRZoTd6M=;
        b=c5u4tTuoAFjjxekjvxHV2qudnIKaGOlZJmHyAdodDNPHXUdMEC51cDV7IyNGxxE107
         KZSNtaTyP7g7S9ChwzwUWNtem+CKb1QSzBqX/+M8WqUDfgeC4sHN1MmOGllNXDdIgW3D
         2gA+cG94hLvJ9hLI1IXCHSIuGRv36A1uQLM1PkDmGRrDcoTP9HMNCqt8LJvJ+MW9Ogsi
         XGfP0A55ZoI1hpe70t8QGlyxFwfQXsY232qGbRsxbAp2Jj/J5LZwH664jO8Xm1Qjwg9m
         l7HerGRBRRymBUqrsD7rRpVShp+sHB07ez/X7MsdDmtW1gztVb6mbvGti6qQHi5PxW3v
         HspQ==
X-Gm-Message-State: AOAM530JPpRqSzhWb/E4g2i3QjOv97gac4fsprrWlpMB8MXjGXiOoURb
        gOF8f08ofwjAOCW3Z7VCuhbBSpLxiz0=
X-Google-Smtp-Source: ABdhPJxPBYQpGLnXV/LvE1gJS5/gWaOlUWu2es9rquGYNVIAS3BtazCY/Y/OWzN5LJQwWeLzA++9uQ==
X-Received: by 2002:a17:902:bb93:b0:14f:3c15:566f with SMTP id m19-20020a170902bb9300b0014f3c15566fmr11136688pls.6.1645270670789;
        Sat, 19 Feb 2022 03:37:50 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id fs9-20020a17090af28900b001b9fa5a1d8dsm2018352pjb.37.2022.02.19.03.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 03:37:50 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf v1 1/5] bpf: Fix kfunc register offset check for PTR_TO_BTF_ID
Date:   Sat, 19 Feb 2022 17:07:40 +0530
Message-Id: <20220219113744.1852259-2-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220219113744.1852259-1-memxor@gmail.com>
References: <20220219113744.1852259-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9351; h=from:subject; bh=nbKT/wMo+3MXK+N+kKKbXprbNQncQ2W6n2tuwcjS4Cg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiENZ5sid9rPny3yrnNTIZfFsCzqgJ4UDUV2A3ReId p0OyqoKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYhDWeQAKCRBM4MiGSL8RytU5D/ 9dfqCPhrt9x3BaZbSKzY9Lp6zj5coqBOWJC4WKe/KvBV/iAEc5zgFR2bGy5iiMLp0QhG81yAsbSiLK 5NNFg3Zof2x6ytw75uiqrQaKKaJpZs3+k88SCoaB69y7aA/snnMrh6tTu5QGQQMdWn0G0cc1ultZwj e3JnQ1UtWo+Cn6BEyptOiHxtjHjcRk8HjccrDCod7cHi07RpdTkPmILWovYdU+H7AYnzcVdA/YjLiW s3pUITDnKSfB0/CkAfaJs40EQGaOi7L2RvJZ17HIVVPqwHyLRMDxb1bA+/dKAJ626OJTbL7GbYnJj3 cWb0K2vhZwM2wqj7avl1b6fwny0hxMxOqT/jRc0DLmYITWRTkVZNz/YAuNncjdzyC5adcMjbHTkwHc noz8L1wvjqtL2coRDsmWqYfzPVp0KeL5ludQ6dOk6TlaYLfU5/nogWac56cJfT3TFiPRvB6Fx10VbY oAQTt2/XrwVaNvDSFBvfC4mcd4O1NK8g9gGEjCBpJIhQtzxRCMVFDBiLAjRmQWrMrsSwOWH9Jz5p4/ xG66Pk4oA3nFe33LT0PLgMsU7zteQefOlckeRtz0JbOJef6+KUWB60WMn6IsLD5ey3+sw5kQMtxaNm oxz+wis0Nf1HBP/AteUPTXR54DfH8/z5sPxuNoLh/H68kCqvLr4yj44kHweQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When kfunc support was added, the ptr_to_ctx block did check_ctx_reg,
but the block checking PTR_TO_BTF_ID only did a btf_struct_ids_match.
This meant that when using a variable offset to the PTR_TO_BTF_ID, we
could pass it and make the kernel think the type at offset matches.

Commit 6788ab23508b ("bpf: Generally fix helper register offset check")
made some fixes in this area, and generalised these checks to prevent
future problem.

In case of helpers, __check_ptr_off_reg is used to reject this case in
check_func_arg.

Make this function argument register offset checking more generic, by
extracting the code out into a common helper, and calling it from both
helper and kfunc code paths. For consistency, also do the check from
check_mem_reg, even though it shouldn't be a problem there, because the
types permitted by check_helper_mem_access do allow variable and fixed
offsets, but a future refactoring may change such assumption.

In case of ptr_to_mem_ok block, we do allow NULL pointers, patching them
as non-NULL for call verification purposes, hence since the register
pointer is passed into this check_func_arg_reg_off function, the check
needs to happen inside check_mem_reg.

While we are at it, finally reject the cases of reg->off < 0 early.
fixed_off_ok is only ever set for the case of PTR_TO_BTF_ID when we
reach __check_ptr_off_reg, and negative offset in any case is incorrect.
This frees later checks the burden of sanitizing the offset when doing
type matching. This also leads to nicer verifier error than something
confusing like:
...
16: (07) r1 += -4 ; R1_w=ptr_prog_test_ref_kfunc(id=0,ref_obj_id=2,off=-4,imm=0) refs=2
17: (85) call bpf_kfunc_call_test_release#118834
access beyond struct prog_test_ref_kfunc at off 4294967292 size 1

A reason to do this check_func_arg_reg_off call in each block instead of
once for btf_check_func_arg_match, is because the verifier errors would
be confusing (instead of argument type not supported, something about
the offset).

Cc: Martin KaFai Lau <kafai@fb.com>
Fixes: e6ac2450d6de ("bpf: Support bpf program calling kernel function")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  3 ++
 kernel/bpf/btf.c             | 17 ++++++-
 kernel/bpf/verifier.c        | 89 +++++++++++++++++++++++-------------
 3 files changed, 77 insertions(+), 32 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e9993172f892..f657c8ce01b8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -519,6 +519,9 @@ bpf_prog_offload_replace_insn(struct bpf_verifier_env *env, u32 off,
 void
 bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt);
 
+int check_func_arg_reg_off(struct bpf_verifier_env *env,
+			   const struct bpf_reg_state *reg, int regno,
+			   bool arg_alloc_mem);
 int check_ptr_off_reg(struct bpf_verifier_env *env,
 		      const struct bpf_reg_state *reg, int regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3e23b3fa79ff..9c8c429aa4dc 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5686,7 +5686,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					i, btf_type_str(t));
 				return -EINVAL;
 			}
-			if (check_ptr_off_reg(env, reg, regno))
+			if (check_func_arg_reg_off(env, reg, regno, false))
 				return -EINVAL;
 		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
 			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
@@ -5714,6 +5714,16 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 							    &reg_ref_id);
 			reg_ref_tname = btf_name_by_offset(reg_btf,
 							   reg_ref_t->name_off);
+			/* In case of PTR_TO_SOCKET, PTR_TO_SOCK_COMMON,
+			 * PTR_TO_TCP_SOCK, we do type check using BTF IDs of
+			 * in-kernel types they point to, but
+			 * check_func_arg_reg_off using original register type,
+			 * as for them fixed offset case must be disallowed.
+			 * In case of PTR_TO_BTF_ID, check_func_arg_reg_off will
+			 * allow having a reg->off >= 0 fixed offset.
+			 */
+			if (check_func_arg_reg_off(env, reg, regno, false))
+				return -EINVAL;
 			if (!btf_struct_ids_match(log, reg_btf, reg_ref_id,
 						  reg->off, btf, ref_id)) {
 				bpf_log(log, "kernel function %s args#%d expected pointer to %s %s but R%d has a pointer to %s %s\n",
@@ -5724,6 +5734,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				return -EINVAL;
 			}
 		} else if (ptr_to_mem_ok) {
+			/* All check_func_arg_reg_off checks happen inside
+			 * check_mem_reg, because the reg->type needs to be
+			 * cleared of PTR_MAYBE_NULL before the check is done.
+			 */
 			const struct btf_type *resolve_ret;
 			u32 type_size;
 
@@ -5750,6 +5764,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				return -EINVAL;
 			}
 
+			/* This does the check_func_arg_reg_off call */
 			if (check_mem_reg(env, reg, regno, type_size))
 				return -EINVAL;
 		} else {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a39eedecc93a..732dcba85ce5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3979,6 +3979,12 @@ static int __check_ptr_off_reg(struct bpf_verifier_env *env,
 	 * is only allowed in its original, unmodified form.
 	 */
 
+	if (reg->off < 0) {
+		verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
+			reg_type_str(env, reg->type), regno, reg->off);
+		return -EACCES;
+	}
+
 	if (!fixed_off_ok && reg->off) {
 		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
 			reg_type_str(env, reg->type), regno, reg->off);
@@ -4880,6 +4886,8 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		   u32 regno, u32 mem_size)
 {
+	int rv;
+
 	if (register_is_null(reg))
 		return 0;
 
@@ -4889,15 +4897,16 @@ int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		 * the conversion shouldn't be visible to a caller.
 		 */
 		const struct bpf_reg_state saved_reg = *reg;
-		int rv;
 
 		mark_ptr_not_null_reg(reg);
-		rv = check_helper_mem_access(env, regno, mem_size, true, NULL);
+		rv = check_func_arg_reg_off(env, reg, regno, false);
+		rv = rv ?: check_helper_mem_access(env, regno, mem_size, true, NULL);
 		*reg = saved_reg;
 		return rv;
 	}
 
-	return check_helper_mem_access(env, regno, mem_size, true, NULL);
+	rv = check_func_arg_reg_off(env, reg, regno, false);
+	return rv ?: check_helper_mem_access(env, regno, mem_size, true, NULL);
 }
 
 /* Implementation details:
@@ -5255,11 +5264,54 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 				kernel_type_name(btf_vmlinux, *arg_btf_id));
 			return -EACCES;
 		}
+
+		/* var_off check happens later in check_func_arg_reg_off */
 	}
 
 	return 0;
 }
 
+/* Caller ensures reg->type does not have PTR_MAYBE_NULL */
+int check_func_arg_reg_off(struct bpf_verifier_env *env,
+			   const struct bpf_reg_state *reg, int regno,
+			   bool arg_alloc_mem)
+{
+	enum bpf_reg_type type = reg->type;
+	int err;
+
+	WARN_ON_ONCE(type & PTR_MAYBE_NULL);
+
+	switch ((u32)type) {
+	case SCALAR_VALUE:
+	/* Pointer types where reg offset is explicitly allowed: */
+	case PTR_TO_PACKET:
+	case PTR_TO_PACKET_META:
+	case PTR_TO_MAP_KEY:
+	case PTR_TO_MAP_VALUE:
+	case PTR_TO_MEM:
+	case PTR_TO_MEM | MEM_RDONLY:
+	case PTR_TO_MEM | MEM_ALLOC:
+	case PTR_TO_BUF:
+	case PTR_TO_BUF | MEM_RDONLY:
+	case PTR_TO_STACK:
+		/* Some of the argument types nevertheless require a
+		 * zero register offset.
+		 */
+		if (arg_alloc_mem)
+			goto force_off_check;
+		break;
+	/* All the rest must be rejected: */
+	default:
+force_off_check:
+		err = __check_ptr_off_reg(env, reg, regno,
+					  type == PTR_TO_BTF_ID);
+		if (err < 0)
+			return err;
+		break;
+	}
+	return 0;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn)
@@ -5309,34 +5361,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	if (err)
 		return err;
 
-	switch ((u32)type) {
-	case SCALAR_VALUE:
-	/* Pointer types where reg offset is explicitly allowed: */
-	case PTR_TO_PACKET:
-	case PTR_TO_PACKET_META:
-	case PTR_TO_MAP_KEY:
-	case PTR_TO_MAP_VALUE:
-	case PTR_TO_MEM:
-	case PTR_TO_MEM | MEM_RDONLY:
-	case PTR_TO_MEM | MEM_ALLOC:
-	case PTR_TO_BUF:
-	case PTR_TO_BUF | MEM_RDONLY:
-	case PTR_TO_STACK:
-		/* Some of the argument types nevertheless require a
-		 * zero register offset.
-		 */
-		if (arg_type == ARG_PTR_TO_ALLOC_MEM)
-			goto force_off_check;
-		break;
-	/* All the rest must be rejected: */
-	default:
-force_off_check:
-		err = __check_ptr_off_reg(env, reg, regno,
-					  type == PTR_TO_BTF_ID);
-		if (err < 0)
-			return err;
-		break;
-	}
+	err = check_func_arg_reg_off(env, reg, regno, arg_type == ARG_PTR_TO_ALLOC_MEM);
+	if (err < 0)
+		return err;
 
 skip_type_check:
 	if (reg->ref_obj_id) {
-- 
2.35.1

