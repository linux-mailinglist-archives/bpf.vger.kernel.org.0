Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7E146AE59
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 00:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242479AbhLFX0H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 18:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350577AbhLFX0G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 18:26:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71CFC061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 15:22:37 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t1-20020a5b03c1000000b005f6ee3e97easo22082343ybp.16
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 15:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+fkEIkHGI9YsXJ5tQP3SIKgfpFv15O0Qka7bEAWV0iI=;
        b=FFNEnA+TXFLNalSwwKIYE++89Y6mfHy+OkiQRO9JJL7pmXf23W9uu1JoTl5WKxqgfD
         8/BLouZm9lPT602szo+v6PY4e7hbJhUFBHu1XdwgEga34Mqd5MX1ltetYpvSUyA5SKXI
         waYnSf9qTChaO0TuspAwiAfACzUJVIY3T0jc7HoUTh8GF/jGKXI3sIFWc7pUNacTIVwR
         9Ug3fbIoS34o1gA0Q4awPPlRABRWkjP1OsbiRTm4E2fIspk7uCsmvqjXYO05BYgdNv1K
         yo4s5m3p7/iL2GnsU7xurGdZwBCpKYwZZkNOzhD8btHxHVzdM02y1Y/JwuUluiTb4eQM
         3Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+fkEIkHGI9YsXJ5tQP3SIKgfpFv15O0Qka7bEAWV0iI=;
        b=GClVK7Yg1lP4bWGZ5YmTqWRZkNYlniWm4ruAUHdRodtiYw1Cp7155dj/VuqwS4020D
         EGvoeu243kWQg2vUhXPUHlPRyZG77ATt0etitOaO6pyHIZ/dKBMsgSNesSd1dd9bV2UQ
         uZMjgxegEhXaQwBx9OTAD4euqCQ6qa7n4jzvDvsaktfSI9z8Md658U66Kt/KNUsASKDt
         Ih/ZLbKNBYlnOsyh4CIuSXCqW6t2d7muVnOF9HAJfRiwBo9TGfAZ9weK8UBZGXH/RuMX
         upYYMP9E+OhXeteDvlvmHy3bXsp6nkWsaNSi3v0n9D91zRH3adxAOXt2ZMxJ2S02tu5b
         5v2g==
X-Gm-Message-State: AOAM532kI6mggT8dO0B9EO06D2bKRsUAf6v+w/bf39h8/7VwvSqraa/m
        QD1b4CUqTjs3RyQyXNJi4X001XRt4+U=
X-Google-Smtp-Source: ABdhPJyFClBplbguIGlmCbsAUYt7JGOep15XYrDVCQAjNJvssTp/4DxjdTUC7AFwpmstP9JZ6/LGUoZnDcU=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:2977:d88c:3c3:c52a])
 (user=haoluo job=sendgmr) by 2002:a25:8111:: with SMTP id o17mr49385721ybk.651.1638832956992;
 Mon, 06 Dec 2021 15:22:36 -0800 (PST)
Date:   Mon,  6 Dec 2021 15:22:21 -0800
In-Reply-To: <20211206232227.3286237-1-haoluo@google.com>
Message-Id: <20211206232227.3286237-4-haoluo@google.com>
Mime-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH bpf-next v1 3/9] bpf: Replace RET_XXX_OR_NULL with RET_XXX | PTR_MAYBE_NULL
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
reserving high bits to represent flags.

One of the flag is PTR_MAYBE_NULL, which indicates a pointer
may be NULL. When applying this flag to ret_types, it means
the returned value could be a NULL pointer. This patch
switches the qualified arg_types to use this flag.
The ret_types changed in this patch include:

1. RET_PTR_TO_MAP_VALUE_OR_NULL
2. RET_PTR_TO_SOCKET_OR_NULL
3. RET_PTR_TO_TCP_SOCK_OR_NULL
4. RET_PTR_TO_SOCK_COMMON_OR_NULL
5. RET_PTR_TO_ALLOC_MEM_OR_NULL
6. RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL
7. RET_PTR_TO_BTF_ID_OR_NULL

This patch doesn't eliminate the use of these names, instead
it makes them aliases to 'RET_PTR_TO_XXX | PTR_MAYBE_NULL'.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h   | 19 ++++++++++------
 kernel/bpf/helpers.c  |  2 +-
 kernel/bpf/verifier.c | 52 +++++++++++++++++++++----------------------
 3 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b0d063972091..202eb5155edc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -382,17 +382,22 @@ enum bpf_return_type {
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
index b8fa88266af7..253de4a99ba5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6370,6 +6370,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			     int *insn_idx_p)
 {
 	const struct bpf_func_proto *fn = NULL;
+	enum bpf_return_type ret_type;
 	struct bpf_reg_state *regs;
 	struct bpf_call_arg_meta meta;
 	int insn_idx = *insn_idx_p;
@@ -6510,13 +6511,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
+	} else if (base_type(ret_type) == RET_PTR_TO_MAP_VALUE) {
 		/* There is no offset yet applied, variable or fixed */
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		/* remember map_ptr, so that check_map_access()
@@ -6530,28 +6531,27 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 		regs[BPF_REG_0].map_ptr = meta.map_ptr;
 		regs[BPF_REG_0].map_uid = meta.map_uid;
-		if (fn->ret_type == RET_PTR_TO_MAP_VALUE) {
+		if (type_may_be_null(ret_type)) {
+			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
+		} else {
 			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE;
 			if (map_value_has_spin_lock(meta.map_ptr))
 				regs[BPF_REG_0].id = ++env->id_gen;
-		} else {
-			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
 		}
-	} else if (fn->ret_type == RET_PTR_TO_SOCKET_OR_NULL) {
+	} else if (base_type(ret_type) == RET_PTR_TO_SOCKET) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_SOCKET_OR_NULL;
-	} else if (fn->ret_type == RET_PTR_TO_SOCK_COMMON_OR_NULL) {
+	} else if (base_type(ret_type) == RET_PTR_TO_SOCK_COMMON) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_SOCK_COMMON_OR_NULL;
-	} else if (fn->ret_type == RET_PTR_TO_TCP_SOCK_OR_NULL) {
+	} else if (base_type(ret_type) == RET_PTR_TO_TCP_SOCK) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_TCP_SOCK_OR_NULL;
-	} else if (fn->ret_type == RET_PTR_TO_ALLOC_MEM_OR_NULL) {
+	} else if (base_type(ret_type) == RET_PTR_TO_ALLOC_MEM) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_MEM_OR_NULL;
 		regs[BPF_REG_0].mem_size = meta.mem_size;
-	} else if (fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL ||
-		   fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID) {
+	} else if (base_type(ret_type) == RET_PTR_TO_MEM_OR_BTF_ID) {
 		const struct btf_type *t;
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
@@ -6570,28 +6570,28 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
+	} else if (base_type(ret_type) == RET_PTR_TO_BTF_ID) {
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
-			verbose(env, "invalid return type %d of func %s#%d\n",
-				fn->ret_type, func_id_name(func_id), func_id);
+			verbose(env, "invalid return type %lu of func %s#%d\n",
+				base_type(ret_type), func_id_name(func_id),
+				func_id);
 			return -EINVAL;
 		}
 		/* current BPF helper definitions are only coming from
@@ -6600,8 +6600,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		regs[BPF_REG_0].btf = btf_vmlinux;
 		regs[BPF_REG_0].btf_id = ret_btf_id;
 	} else {
-		verbose(env, "unknown return type %d of func %s#%d\n",
-			fn->ret_type, func_id_name(func_id), func_id);
+		verbose(env, "unknown return type %lu of func %s#%d\n",
+			base_type(ret_type), func_id_name(func_id), func_id);
 		return -EINVAL;
 	}
 
-- 
2.34.1.400.ga245620fadb-goog

