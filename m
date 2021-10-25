Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D16543A803
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 01:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhJYXP0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 19:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhJYXP0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 19:15:26 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845E4C061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 16:13:03 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id p10-20020a056a000b4a00b0044cf01eccdbso7276122pfo.19
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 16:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eBsK+hWSeBPw9+4g3rN87k1gD0iWMBYoLR6VY9WttkE=;
        b=URFeoI2I9qBs65gG6z1xqucZDzTgLuX4pvLcoXkM+jWRK6K/hM+wAM4CH7sFknFMrY
         Ju6aJBnv8WOeFCkVxixCaXEcsMXl4Xt7PArxdOVSn+hK3Rvgn0kOYylMJF/vKrIFIrvF
         onH6CUySn5RAXAqV66mJOdQl0IFQ6mW6STqreXB31wDNp9rSCR1QKU4aPge2XLNEMbK2
         J9UzI3jgmllH5PXYs8r8qrNM2mo5duItVGykDPC44Ol8qQq0PHuk4IeczfyeMa+z/hcT
         rJCuG6ogb9m5WMmgJkzBGBk+FN8EBItjJPtXog56GgMwnp2bjMOno4T3Y5R54MaSp4fK
         g88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eBsK+hWSeBPw9+4g3rN87k1gD0iWMBYoLR6VY9WttkE=;
        b=TNZaW83c95+OeP8/Y3yJAKeyXUeQMdd2FqG0sOdL2Hi8yAEbKjuSf0jfPYTC3yo1MB
         7vS1qpJ9wDDWO9Bd0NbERN9qsnxrqj9pPneudgq2p+M4m6lI0xWWBeogtpMaT/Brts7n
         1PvQah6kOo1FaKEI29ZmGjIkqm1GKxULQEEpI0TVBQUJAnKGs6W9jPsLeDVzNQvH7lv3
         La9RYUBaMnW8OF9XwaFmQs7TOXUxE/OdyaNKOPaaBkS4o4qIeI/oVz37ZYCSifUCyo7A
         dPVa1fj6iKiwlfz/QXfRj4gQw9i9T5Ohvop5ZF4xBldZVwG4WuwIyDrJnIoEuSCcVgzD
         qutw==
X-Gm-Message-State: AOAM530+8Bg+mLR0xa4k2MSUWBqijaJap4mDk45A042uDQknsVYbDeEY
        NDswijbcWCVCIoVDnNsSoDSwqmsTpOQ=
X-Google-Smtp-Source: ABdhPJyShj3n4QFlCqQnU8qwErxSIEXI9qkpgfnKg/fPbY+9FW5OGsLg/vTL4h1v1rpTEcOgL6cIRvoREQA=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:b4ab:b78c:418f:ca5c])
 (user=haoluo job=sendgmr) by 2002:a17:90b:60d:: with SMTP id
 gb13mr200414pjb.0.1635203582514; Mon, 25 Oct 2021 16:13:02 -0700 (PDT)
Date:   Mon, 25 Oct 2021 16:12:54 -0700
In-Reply-To: <20211025231256.4030142-1-haoluo@google.com>
Message-Id: <20211025231256.4030142-2-haoluo@google.com>
Mime-Version: 1.0
References: <20211025231256.4030142-1-haoluo@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH bpf-next 1/3] bpf: Prevent write to ksym memory
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
index 31421c74ba08..7b47e8f344cb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -355,8 +355,8 @@ enum bpf_return_type {
 	RET_PTR_TO_SOCK_COMMON_OR_NULL,	/* returns a pointer to a sock_common or NULL */
 	RET_PTR_TO_ALLOC_MEM_OR_NULL,	/* returns a pointer to dynamically allocated memory or NULL */
 	RET_PTR_TO_BTF_ID_OR_NULL,	/* returns a pointer to a btf_id or NULL */
-	RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL, /* returns a pointer to a valid memory or a btf_id or NULL */
-	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a btf_id */
+	RET_PTR_TO_RDONLY_MEM_OR_BTF_ID_OR_NULL, /* returns a pointer to a readonly memory or a btf_id or NULL */
+	RET_PTR_TO_RDONLY_MEM_OR_BTF_ID, /* returns a pointer to a readonly memory or a btf_id */
 	RET_PTR_TO_BTF_ID,		/* returns a pointer to a btf_id */
 };
 
@@ -459,6 +459,8 @@ enum bpf_reg_type {
 	PTR_TO_PERCPU_BTF_ID,	 /* reg points to a percpu kernel variable */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
 	PTR_TO_MAP_KEY,		 /* reg points to a map element key */
+	PTR_TO_RDONLY_MEM,	 /* reg points to valid readonly memory region */
+	PTR_TO_RDONLY_MEM_OR_NULL, /* reg points to valid readonly memory region or null */
 	__BPF_REG_TYPE_MAX,
 };
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c10820037883..9fb931de668a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1141,8 +1141,8 @@ enum bpf_link_type {
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
index c6616e325803..ae3ff297240e 100644
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
@@ -6532,8 +6551,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_MEM_OR_NULL;
 		regs[BPF_REG_0].mem_size = meta.mem_size;
-	} else if (fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL ||
-		   fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID) {
+	} else if (fn->ret_type == RET_PTR_TO_RDONLY_MEM_OR_BTF_ID_OR_NULL ||
+		   fn->ret_type == RET_PTR_TO_RDONLY_MEM_OR_BTF_ID) {
 		const struct btf_type *t;
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
@@ -6552,12 +6571,12 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -9363,7 +9382,7 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 
 		dst_reg->type = aux->btf_var.reg_type;
 		switch (dst_reg->type) {
-		case PTR_TO_MEM:
+		case PTR_TO_RDONLY_MEM:
 			dst_reg->mem_size = aux->btf_var.mem_size;
 			break;
 		case PTR_TO_BTF_ID:
@@ -11510,7 +11529,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 			err = -EINVAL;
 			goto err_put;
 		}
-		aux->btf_var.reg_type = PTR_TO_MEM;
+		aux->btf_var.reg_type = PTR_TO_RDONLY_MEM;
 		aux->btf_var.mem_size = tsize;
 	} else {
 		aux->btf_var.reg_type = PTR_TO_BTF_ID;
@@ -13332,7 +13351,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				mark_reg_known_zero(env, regs, i);
 			else if (regs[i].type == SCALAR_VALUE)
 				mark_reg_unknown(env, regs, i);
-			else if (regs[i].type == PTR_TO_MEM_OR_NULL) {
+			else if (regs[i].type == PTR_TO_MEM_OR_NULL ||
+				 regs[i].type == PTR_TO_RDONLY_MEM_OR_NULL) {
 				const u32 mem_size = regs[i].mem_size;
 
 				mark_reg_known_zero(env, regs, i);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c10820037883..9fb931de668a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1141,8 +1141,8 @@ enum bpf_link_type {
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
2.33.0.1079.g6e70778dc9-goog

