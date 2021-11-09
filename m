Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6294C449F8C
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 01:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhKIAd6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 19:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhKIAd5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 19:33:57 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141FBC061570
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 16:31:13 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id i3-20020a170902c94300b0014287dc7dcbso1343176pla.16
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 16:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SqS340R8tYvjHqkbMME5XQSRdoVQbqbhDaLXQIx8wbk=;
        b=FEntVGXeL+PoN0dX0y+ESjBYwahc+7+Ah1jRUL+plOKzl1Ys5Q/cvkeAFwt8kdSUTX
         hYX+lHkxgos8fyDyZgtZfDie9EzMhak4aZRoBQqyNAcc9p4TqRnxlhxZTFegkulStlq5
         AX+PwZbmqq8xK1B7fAY36HeOfrATO0qZIf9jEy00zIQQnNpMtYxJj6EFruRhbN6R17VT
         h5k+8nvhCdZF/j/2ILuLbp2aFgdlPaknV80sedyQ003LP8wrz5+YJRE0YuomrdQWEE52
         ShZCLfjc+HZs/DNT2WViRmIdGIVt23S1NiRvvErFGxJzZIF7G4WUpqa8D9ZU/hGCEOYy
         pSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SqS340R8tYvjHqkbMME5XQSRdoVQbqbhDaLXQIx8wbk=;
        b=jhpivVo/9TNfLc+R4t5lAVs796PS+W2rcTpWW4OZ1+SsP2il8AmOtYxg9fl+QQuwt3
         TbuTNDO+4c1WiDeR5a6vqbJFUzxImBSPi5jZkO1XyiEC0OPBqP4ZLoT7eAMff1WQ8wB0
         hDtQj8CA6jgcr7rtmdHw+vVT8la4bfet4gaAIuqoQDs3vNz4In9s56e1eLmk+vFfswdD
         rMagfeDe4cDNmM6Eb7UJTL5+K2xOIe0949B+UbnGhIlh0iEnhnnwWRl2x1qu4BkGlSnM
         ZpD9s71DvRTV2xBaDXcMp1+MLT5p49I2Rn0xicDvXK6W63K6TDKGO+tkrvHcU9Vxemvy
         wN8Q==
X-Gm-Message-State: AOAM530EVn6eLKXUU1GT1zUtd0wNMY3X9rI4FHqN08t9mCiUrLzMClOt
        wlwMt/XmytQRpafwW8JFuIDwNYprLd0=
X-Google-Smtp-Source: ABdhPJwjHrBHeU+jFggjw9HfJNxVughJpxMTLQktKsgmKzdaj63lrkW9nLRM5pgPbBrcip/DbmO9B/zHc+I=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:4c6:4bbe:e4c5:ff76])
 (user=haoluo job=sendgmr) by 2002:a63:9207:: with SMTP id o7mr2705778pgd.236.1636417872502;
 Mon, 08 Nov 2021 16:31:12 -0800 (PST)
Date:   Mon,  8 Nov 2021 16:30:50 -0800
In-Reply-To: <20211109003052.3499225-1-haoluo@google.com>
Message-Id: <20211109003052.3499225-2-haoluo@google.com>
Mime-Version: 1.0
References: <20211109003052.3499225-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v3 bpf-next 1/3] bpf: Prevent write to ksym memory
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A ksym could be used to refer a global variable in the kernel.
Previously if this variable is of non-struct type, bpf verifier resolves
its value type to be PTR_TO_MEM, which allows the program to write
to the memory. This patch introduces PTR_TO_RDONLY_MEM, which is
similar to PTR_TO_MEM, but forbids writing. This should prevent
program from writing kernel memory through ksyms.

Right now a PTR_TO_RDONLY_MEM can not be passed into any helper as
argument. But a PTR_TO_RDONLY_MEM can be read into a PTR_TO_MEM (e.g.
stack variable), which can be passed to helpers such as bpf_snprintf.

The following patch will add checks to differentiate the read-write
arguments and read-only arguments, and support for passing
PTR_TO_RDONLY_MEM to helper's read-only arguments.

Fixes: 63d9b80dcf2c ("bpf: Introducte bpf_this_cpu_ptr()")
Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
Fixes: 4976b718c355 ("bpf: Introduce pseudo_btf_id")
Signed-off-by: Hao Luo <haoluo@google.com>
---
 Changes since v2:
  - Rebase

 Changes since v1:
  - Added Fixes tag.
  - Removed PTR_TO_RDONLY_MEM[_OR_NULL] from reg_type_may_be_refcounted.

 include/linux/bpf.h            |  6 ++++--
 include/uapi/linux/bpf.h       |  4 ++--
 kernel/bpf/helpers.c           |  4 ++--
 kernel/bpf/verifier.c          | 36 ++++++++++++++++++++++++++--------
 tools/include/uapi/linux/bpf.h |  4 ++--
 5 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index df3410bff4b0..64494d5964fa 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -356,8 +356,8 @@ enum bpf_return_type {
 	RET_PTR_TO_SOCK_COMMON_OR_NULL,	/* returns a pointer to a sock_common or NULL */
 	RET_PTR_TO_ALLOC_MEM_OR_NULL,	/* returns a pointer to dynamically allocated memory or NULL */
 	RET_PTR_TO_BTF_ID_OR_NULL,	/* returns a pointer to a btf_id or NULL */
-	RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL, /* returns a pointer to a valid memory or a btf_id or NULL */
-	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a btf_id */
+	RET_PTR_TO_RDONLY_MEM_OR_BTF_ID_OR_NULL, /* returns a pointer to a readonly memory or a btf_id or NULL */
+	RET_PTR_TO_RDONLY_MEM_OR_BTF_ID, /* returns a pointer to a readonly memory or a btf_id */
 	RET_PTR_TO_BTF_ID,		/* returns a pointer to a btf_id */
 };
 
@@ -460,6 +460,8 @@ enum bpf_reg_type {
 	PTR_TO_PERCPU_BTF_ID,	 /* reg points to a percpu kernel variable */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
 	PTR_TO_MAP_KEY,		 /* reg points to a map element key */
+	PTR_TO_RDONLY_MEM,	 /* reg points to valid readonly memory region */
+	PTR_TO_RDONLY_MEM_OR_NULL, /* reg points to valid readonly memory region or null */
 	__BPF_REG_TYPE_MAX,
 };
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 509eee5f0393..19c8511c1b14 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1142,8 +1142,8 @@ enum bpf_link_type {
  * insn[0].off:      0
  * insn[1].off:      0
  * ldimm64 rewrite:  address of the kernel variable
- * verifier type:    PTR_TO_BTF_ID or PTR_TO_MEM, depending on whether the var
- *                   is struct/union.
+ * verifier type:    PTR_TO_BTF_ID or PTR_TO_RDONLY_MEM, depending on whether
+ *                   the var is struct/union.
  */
 #define BPF_PSEUDO_BTF_ID	3
 /* insn[0].src_reg:  BPF_PSEUDO_FUNC
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1ffd469c217f..14531757087f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -667,7 +667,7 @@ BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
 const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
 	.func		= bpf_per_cpu_ptr,
 	.gpl_only	= false,
-	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL,
+	.ret_type	= RET_PTR_TO_RDONLY_MEM_OR_BTF_ID_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_PERCPU_BTF_ID,
 	.arg2_type	= ARG_ANYTHING,
 };
@@ -680,7 +680,7 @@ BPF_CALL_1(bpf_this_cpu_ptr, const void *, percpu_ptr)
 const struct bpf_func_proto bpf_this_cpu_ptr_proto = {
 	.func		= bpf_this_cpu_ptr,
 	.gpl_only	= false,
-	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID,
+	.ret_type	= RET_PTR_TO_RDONLY_MEM_OR_BTF_ID,
 	.arg1_type	= ARG_PTR_TO_PERCPU_BTF_ID,
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1aafb43f61d1..eb3ae4a140ac 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -453,6 +453,7 @@ static bool reg_type_may_be_null(enum bpf_reg_type type)
 	       type == PTR_TO_TCP_SOCK_OR_NULL ||
 	       type == PTR_TO_BTF_ID_OR_NULL ||
 	       type == PTR_TO_MEM_OR_NULL ||
+	       type == PTR_TO_RDONLY_MEM_OR_NULL ||
 	       type == PTR_TO_RDONLY_BUF_OR_NULL ||
 	       type == PTR_TO_RDWR_BUF_OR_NULL;
 }
@@ -571,6 +572,8 @@ static const char * const reg_type_str[] = {
 	[PTR_TO_PERCPU_BTF_ID]	= "percpu_ptr_",
 	[PTR_TO_MEM]		= "mem",
 	[PTR_TO_MEM_OR_NULL]	= "mem_or_null",
+	[PTR_TO_RDONLY_MEM]	= "rdonly_mem",
+	[PTR_TO_RDONLY_MEM_OR_NULL] = "rdonly_mem_or_null",
 	[PTR_TO_RDONLY_BUF]	= "rdonly_buf",
 	[PTR_TO_RDONLY_BUF_OR_NULL] = "rdonly_buf_or_null",
 	[PTR_TO_RDWR_BUF]	= "rdwr_buf",
@@ -1183,6 +1186,9 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
 	case PTR_TO_MEM_OR_NULL:
 		reg->type = PTR_TO_MEM;
 		break;
+	case PTR_TO_RDONLY_MEM_OR_NULL:
+		reg->type = PTR_TO_RDONLY_MEM;
+		break;
 	case PTR_TO_RDONLY_BUF_OR_NULL:
 		reg->type = PTR_TO_RDONLY_BUF;
 		break;
@@ -2741,6 +2747,8 @@ static bool is_spillable_regtype(enum bpf_reg_type type)
 	case PTR_TO_PERCPU_BTF_ID:
 	case PTR_TO_MEM:
 	case PTR_TO_MEM_OR_NULL:
+	case PTR_TO_RDONLY_MEM:
+	case PTR_TO_RDONLY_MEM_OR_NULL:
 	case PTR_TO_FUNC:
 	case PTR_TO_MAP_KEY:
 		return true;
@@ -3367,6 +3375,7 @@ static int __check_mem_access(struct bpf_verifier_env *env, int regno,
 			off, size, regno, reg->id, off, mem_size);
 		break;
 	case PTR_TO_MEM:
+	case PTR_TO_RDONLY_MEM:
 	default:
 		verbose(env, "invalid access to memory, mem_size=%u off=%d size=%d\n",
 			mem_size, off, size);
@@ -4377,6 +4386,16 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 					      reg->mem_size, false);
 		if (!err && t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
+	} else if (reg->type == PTR_TO_RDONLY_MEM) {
+		if (t == BPF_WRITE) {
+			verbose(env, "R%d cannot write into %s\n",
+				regno, reg_type_str[reg->type]);
+			return -EACCES;
+		}
+		err = check_mem_region_access(env, regno, off, size,
+					      reg->mem_size, false);
+		if (!err && value_regno >= 0)
+			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_CTX) {
 		enum bpf_reg_type reg_type = SCALAR_VALUE;
 		struct btf *btf = NULL;
@@ -6579,8 +6598,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_MEM_OR_NULL;
 		regs[BPF_REG_0].mem_size = meta.mem_size;
-	} else if (fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL ||
-		   fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID) {
+	} else if (fn->ret_type == RET_PTR_TO_RDONLY_MEM_OR_BTF_ID_OR_NULL ||
+		   fn->ret_type == RET_PTR_TO_RDONLY_MEM_OR_BTF_ID) {
 		const struct btf_type *t;
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
@@ -6599,12 +6618,12 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				return -EINVAL;
 			}
 			regs[BPF_REG_0].type =
-				fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID ?
-				PTR_TO_MEM : PTR_TO_MEM_OR_NULL;
+				fn->ret_type == RET_PTR_TO_RDONLY_MEM_OR_BTF_ID ?
+				PTR_TO_RDONLY_MEM : PTR_TO_RDONLY_MEM_OR_NULL;
 			regs[BPF_REG_0].mem_size = tsize;
 		} else {
 			regs[BPF_REG_0].type =
-				fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID ?
+				fn->ret_type == RET_PTR_TO_RDONLY_MEM_OR_BTF_ID ?
 				PTR_TO_BTF_ID : PTR_TO_BTF_ID_OR_NULL;
 			regs[BPF_REG_0].btf = meta.ret_btf;
 			regs[BPF_REG_0].btf_id = meta.ret_btf_id;
@@ -9410,7 +9429,7 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 
 		dst_reg->type = aux->btf_var.reg_type;
 		switch (dst_reg->type) {
-		case PTR_TO_MEM:
+		case PTR_TO_RDONLY_MEM:
 			dst_reg->mem_size = aux->btf_var.mem_size;
 			break;
 		case PTR_TO_BTF_ID:
@@ -11557,7 +11576,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 			err = -EINVAL;
 			goto err_put;
 		}
-		aux->btf_var.reg_type = PTR_TO_MEM;
+		aux->btf_var.reg_type = PTR_TO_RDONLY_MEM;
 		aux->btf_var.mem_size = tsize;
 	} else {
 		aux->btf_var.reg_type = PTR_TO_BTF_ID;
@@ -13379,7 +13398,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				mark_reg_known_zero(env, regs, i);
 			else if (regs[i].type == SCALAR_VALUE)
 				mark_reg_unknown(env, regs, i);
-			else if (regs[i].type == PTR_TO_MEM_OR_NULL) {
+			else if (regs[i].type == PTR_TO_MEM_OR_NULL ||
+				 regs[i].type == PTR_TO_RDONLY_MEM_OR_NULL) {
 				const u32 mem_size = regs[i].mem_size;
 
 				mark_reg_known_zero(env, regs, i);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 509eee5f0393..19c8511c1b14 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1142,8 +1142,8 @@ enum bpf_link_type {
  * insn[0].off:      0
  * insn[1].off:      0
  * ldimm64 rewrite:  address of the kernel variable
- * verifier type:    PTR_TO_BTF_ID or PTR_TO_MEM, depending on whether the var
- *                   is struct/union.
+ * verifier type:    PTR_TO_BTF_ID or PTR_TO_RDONLY_MEM, depending on whether
+ *                   the var is struct/union.
  */
 #define BPF_PSEUDO_BTF_ID	3
 /* insn[0].src_reg:  BPF_PSEUDO_FUNC
-- 
2.34.0.rc0.344.g81b53c2807-goog

