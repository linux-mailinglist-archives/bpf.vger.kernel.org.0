Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51ACC4629B3
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 02:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbhK3Bd0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 20:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbhK3BdT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 20:33:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81D6C061746
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:30:00 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g25-20020a25b119000000b005c5e52a0574so26392084ybj.5
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lA1hBdaZg5MwMiiaOpI7SPqUloc5nJnkvSFqWFJ9T8k=;
        b=Qc8yrTRjIVMGLJiQ5c7DXAvQbTqBGSgEKWjhFGpgNPG5ZZ1kOYdnyBm6dNhxJz4F5G
         Jfem9WluttH3vRkYkr23vpBPiDG9MMIrXxg6uZkSM3Fctl3o+oFcw7ncVZq/+LIFRqVP
         szFSktN8p46sVqTECzzcqoFTAn+fHjlfJx70zrxXcYXi4lc60Ugb/h36lQROOUUXvGn4
         gzOWNGXbci6EUTjNh4cCokPGf0NbK8ie2AngJnSSSJDqoiA4P3Uf3VcbnBK1zrXLlAKh
         2MjbWrW7+Q3MRndRuSQBML6kyudQKvsc5nf35WXaV6SB0IY/TXvb2Bnvvs5e76yqcVvm
         yqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lA1hBdaZg5MwMiiaOpI7SPqUloc5nJnkvSFqWFJ9T8k=;
        b=fMTbnf83Db59oGCDg9eD5wH3taxGm/veXpTqtjWnjc7GKNgxvkv5SQ59uYpPBmBPgX
         IDTnSUl59TKdOonuI6t7mL/aKkJ0eD3nJzg4RqLKYowVgPkK+sEguvTKsKj9XyORakLt
         PhqaqkWx2hdK28wtFNiGIy2jtBarOkG17I5698urBNGmI/6XSYITqSa5AL8Xny8K1Rgu
         aCYdA4xJO0OLuJhd9EETyZmE2aYPqgkUVgScGbwOip7v12R7MJxt3RUyeX19TgZClOoz
         ezki3pRZitRysjYb7/+RIyU/7a5fkXhTe/0HipCHGSLQzTfIAKzvpaGSMRwr8b9oqoqp
         JzNw==
X-Gm-Message-State: AOAM531v+Fi7WM/r52TswXyTjtkMNIHyfPQcHc31OrFX1Gf4u+/igXMD
        pUiA6Ysg66QmsoUug8//tsxWKEh/SMQ=
X-Google-Smtp-Source: ABdhPJzTZ8FaJT32YQag4zplW67RBXzvMiX/XMlPtb5oeYjUWc9lAVMEG3SPE4T5V5XS5ALm2kZjSg8VZr0=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:bbf5:5c09:9dfe:483c])
 (user=haoluo job=sendgmr) by 2002:a25:b202:: with SMTP id i2mr36026540ybj.349.1638235800054;
 Mon, 29 Nov 2021 17:30:00 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:29:42 -0800
In-Reply-To: <20211130012948.380602-1-haoluo@google.com>
Message-Id: <20211130012948.380602-4-haoluo@google.com>
Mime-Version: 1.0
References: <20211130012948.380602-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [RFC PATCH bpf-next v2 3/9] bpf: Replace RET_XXX_OR_NULL with RET_XXX
 | PTR_MAYBE_NULL
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        bpf@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We have introduced a new type to make bpf_ret composable, by
introducing flags to tag a particular type.

One of the flag is PTR_MAYBE_NULL, which indicates a pointer
may be NULL. This patch switches the qualified arg_types to
use this flag. The ret_types changed in this patch include:

1. RET_PTR_TO_MAP_VALUE_OR_NULL
2. RET_PTR_TO_SOCKET_OR_NULL
3. RET_PTR_TO_TCP_SOCK_OR_NULL
4. RET_PTR_TO_SOCK_COMMON_OR_NULL
5. RET_PTR_TO_ALLOC_MEM_OR_NULL
6. RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL
7. RET_PTR_TO_BTF_ID_OR_NULL

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h   | 19 ++++++++++------
 kernel/bpf/helpers.c  |  2 +-
 kernel/bpf/verifier.c | 53 +++++++++++++++++++++++--------------------
 3 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index da31c79724d4..d6189eb14a1f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -390,17 +390,22 @@ enum bpf_return_type {
 	RET_INTEGER,			/* function returns integer */
 	RET_VOID,			/* function doesn't return anything */
 	RET_PTR_TO_MAP_VALUE,		/* returns a pointer to map elem value */
-	RET_PTR_TO_MAP_VALUE_OR_NULL,	/* returns a pointer to map elem value or NULL */
-	RET_PTR_TO_SOCKET_OR_NULL,	/* returns a pointer to a socket or NULL */
-	RET_PTR_TO_TCP_SOCK_OR_NULL,	/* returns a pointer to a tcp_sock or NULL */
-	RET_PTR_TO_SOCK_COMMON_OR_NULL,	/* returns a pointer to a sock_common or NULL */
-	RET_PTR_TO_ALLOC_MEM_OR_NULL,	/* returns a pointer to dynamically allocated memory or NULL */
-	RET_PTR_TO_BTF_ID_OR_NULL,	/* returns a pointer to a btf_id or NULL */
-	RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL, /* returns a pointer to a valid memory or a btf_id or NULL */
+	RET_PTR_TO_SOCKET,		/* returns a pointer to a socket */
+	RET_PTR_TO_TCP_SOCK,		/* returns a pointer to a tcp_sock */
+	RET_PTR_TO_SOCK_COMMON,		/* returns a pointer to a sock_common */
+	RET_PTR_TO_ALLOC_MEM,		/* returns a pointer to dynamically allocated memory */
 	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a btf_id */
 	RET_PTR_TO_BTF_ID,		/* returns a pointer to a btf_id */
 	__BPF_RET_TYPE_MAX,
 
+	/* Extended ret_types. */
+	RET_PTR_TO_MAP_VALUE_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_MAP_VALUE,
+	RET_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
+	RET_PTR_TO_TCP_SOCK_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
+	RET_PTR_TO_SOCK_COMMON_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
+	RET_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_ALLOC_MEM,
+	RET_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
+
 	/* This must be the last entry. Its purpose is to ensure the enum is
 	 * wide enough to hold the higher bits reserved for bpf_type_flag.
 	 */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1ffd469c217f..293d9314ec7f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -667,7 +667,7 @@ BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
 const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
 	.func		= bpf_per_cpu_ptr,
 	.gpl_only	= false,
-	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL,
+	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL,
 	.arg1_type	= ARG_PTR_TO_PERCPU_BTF_ID,
 	.arg2_type	= ARG_ANYTHING,
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 78227d2cffb1..fb44db2456f2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -477,6 +477,11 @@ static bool arg_type_may_be_null(enum bpf_arg_type type)
 	return BPF_TYPE_FLAG(type) & PTR_MAYBE_NULL;
 }
 
+static bool ret_type_may_be_null(enum bpf_return_type type)
+{
+	return BPF_TYPE_FLAG(type) & PTR_MAYBE_NULL;
+}
+
 /* Determine whether the function releases some resources allocated by another
  * function call. The first reference type argument will be assumed to be
  * released by release_reference().
@@ -6370,6 +6375,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			     int *insn_idx_p)
 {
 	const struct bpf_func_proto *fn = NULL;
+	enum bpf_return_type ret_type;
 	struct bpf_reg_state *regs;
 	struct bpf_call_arg_meta meta;
 	int insn_idx = *insn_idx_p;
@@ -6510,13 +6516,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
 
 	/* update return register (already marked as written above) */
-	if (fn->ret_type == RET_INTEGER) {
+	ret_type = fn->ret_type;
+	if (ret_type == RET_INTEGER) {
 		/* sets type to SCALAR_VALUE */
 		mark_reg_unknown(env, regs, BPF_REG_0);
-	} else if (fn->ret_type == RET_VOID) {
+	} else if (ret_type == RET_VOID) {
 		regs[BPF_REG_0].type = NOT_INIT;
-	} else if (fn->ret_type == RET_PTR_TO_MAP_VALUE_OR_NULL ||
-		   fn->ret_type == RET_PTR_TO_MAP_VALUE) {
+	} else if (BPF_BASE_TYPE(ret_type) == RET_PTR_TO_MAP_VALUE) {
 		/* There is no offset yet applied, variable or fixed */
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		/* remember map_ptr, so that check_map_access()
@@ -6530,28 +6536,27 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 		regs[BPF_REG_0].map_ptr = meta.map_ptr;
 		regs[BPF_REG_0].map_uid = meta.map_uid;
-		if (fn->ret_type == RET_PTR_TO_MAP_VALUE) {
+		if (ret_type_may_be_null(fn->ret_type)) {
+			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
+		} else {
 			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE;
 			if (map_value_has_spin_lock(meta.map_ptr))
 				regs[BPF_REG_0].id = ++env->id_gen;
-		} else {
-			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
 		}
-	} else if (fn->ret_type == RET_PTR_TO_SOCKET_OR_NULL) {
+	} else if (BPF_BASE_TYPE(ret_type) == RET_PTR_TO_SOCKET) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_SOCKET_OR_NULL;
-	} else if (fn->ret_type == RET_PTR_TO_SOCK_COMMON_OR_NULL) {
+	} else if (BPF_BASE_TYPE(ret_type) == RET_PTR_TO_SOCK_COMMON) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_SOCK_COMMON_OR_NULL;
-	} else if (fn->ret_type == RET_PTR_TO_TCP_SOCK_OR_NULL) {
+	} else if (BPF_BASE_TYPE(ret_type) == RET_PTR_TO_TCP_SOCK) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_TCP_SOCK_OR_NULL;
-	} else if (fn->ret_type == RET_PTR_TO_ALLOC_MEM_OR_NULL) {
+	} else if (BPF_BASE_TYPE(ret_type) == RET_PTR_TO_ALLOC_MEM) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_MEM_OR_NULL;
 		regs[BPF_REG_0].mem_size = meta.mem_size;
-	} else if (fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL ||
-		   fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID) {
+	} else if (BPF_BASE_TYPE(ret_type) == RET_PTR_TO_MEM_OR_BTF_ID) {
 		const struct btf_type *t;
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
@@ -6570,28 +6575,28 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				return -EINVAL;
 			}
 			regs[BPF_REG_0].type =
-				fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID ?
-				PTR_TO_MEM : PTR_TO_MEM_OR_NULL;
+				(ret_type & PTR_MAYBE_NULL) ?
+				PTR_TO_MEM_OR_NULL : PTR_TO_MEM;
 			regs[BPF_REG_0].mem_size = tsize;
 		} else {
 			regs[BPF_REG_0].type =
-				fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID ?
-				PTR_TO_BTF_ID : PTR_TO_BTF_ID_OR_NULL;
+				(ret_type & PTR_MAYBE_NULL) ?
+				PTR_TO_BTF_ID_OR_NULL : PTR_TO_BTF_ID;
 			regs[BPF_REG_0].btf = meta.ret_btf;
 			regs[BPF_REG_0].btf_id = meta.ret_btf_id;
 		}
-	} else if (fn->ret_type == RET_PTR_TO_BTF_ID_OR_NULL ||
-		   fn->ret_type == RET_PTR_TO_BTF_ID) {
+	} else if (BPF_BASE_TYPE(ret_type) == RET_PTR_TO_BTF_ID) {
 		int ret_btf_id;
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
-		regs[BPF_REG_0].type = fn->ret_type == RET_PTR_TO_BTF_ID ?
-						     PTR_TO_BTF_ID :
-						     PTR_TO_BTF_ID_OR_NULL;
+		regs[BPF_REG_0].type = (ret_type & PTR_MAYBE_NULL) ?
+						     PTR_TO_BTF_ID_OR_NULL :
+						     PTR_TO_BTF_ID;
 		ret_btf_id = *fn->ret_btf_id;
 		if (ret_btf_id == 0) {
 			verbose(env, "invalid return type %d of func %s#%d\n",
-				fn->ret_type, func_id_name(func_id), func_id);
+				BPF_BASE_TYPE(ret_type), func_id_name(func_id),
+				func_id);
 			return -EINVAL;
 		}
 		/* current BPF helper definitions are only coming from
@@ -6601,7 +6606,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		regs[BPF_REG_0].btf_id = ret_btf_id;
 	} else {
 		verbose(env, "unknown return type %d of func %s#%d\n",
-			fn->ret_type, func_id_name(func_id), func_id);
+			BPF_BASE_TYPE(ret_type), func_id_name(func_id), func_id);
 		return -EINVAL;
 	}
 
-- 
2.34.0.384.gca35af8252-goog

