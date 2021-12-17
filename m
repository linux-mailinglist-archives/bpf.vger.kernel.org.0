Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EC2478151
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhLQAcF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhLQAcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 19:32:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125A8C061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:32:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e131-20020a25d389000000b005fb5e6eb757so1390735ybf.22
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1LyiZYlB9/b0BKejENkS7Wc4B/ommIJrDAxJJecZ9mA=;
        b=TKlR7Z8WFktlqlF/JFyxkoEdUVmfIPqg4jaq9/fmeLFdO1WzpFcvA3osiAEK80Nzxu
         75H1Ih+/OxtYiYHH1DmxjJ2nge4jS5tMHtOBLPIk84wUMt2wjEIk2IZNkBlxNFJm9rzT
         k0/0x5Ic3F1CnHPH+Y9hP9B2/6HN9vWgHys755osIDF85n+N9QwT9j4QG+9wC8sPddHe
         5gr62a+JlJbfFtRkeS9Vrbe2U0YcpapInseQ8TCAFV2kpxdIZxbol17+x2qfVeKC1nc/
         syRzCBpAe9mjg9rIaWJj/4svdk/aRUrLwvehm/vst22b7AiUUcdMUUnnY+lhvT+Zgnj4
         MVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1LyiZYlB9/b0BKejENkS7Wc4B/ommIJrDAxJJecZ9mA=;
        b=3EFFoLLZO5hUHPTOmJskXVsfovicrSkaro/lBp8GSYIdP0NfJA0kFqAzm1DUJ0B4xc
         QdDv1/3bhB56w6BvTGoVggBYQ4PrHdYDUUp1zLzE01t8r6eEEzd+HJPKfxhKW7cmpzd4
         JThXb9TEPvhxLmmZFSozn+vFmplqUwds3/OIA94JOnIKm5c5Cym+G8zuX1mbsVZ47Im6
         +AHkRSivez4Y+YpqI/RIaRbjE+SMp8jMNLrYMKNO5mjMVANTCcap2ufax1Whq+YTZVDD
         dn5JgTrQ/oQiRgYaZGqUj6aXP97S2jRCPJLrqBBu75ri9NhpY1hRfKnE0PQFKrwA7CUc
         oJgw==
X-Gm-Message-State: AOAM530iZ10ZHGk9VVhT2IsXhKhsBdcNgvUTY4Tnf2MEd9C9sGKlgNvk
        pRW3DH9JbBIZUJ+V63KCZNDOS+VWU5Y=
X-Google-Smtp-Source: ABdhPJwoFxxTo69/bbhwocD/V+PAHdw7OoDXPxhLuo/iGUqps3Y/zW1Oo7CnCkxS4Sn5o5Nq/eQT0EDB+Cc=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:9064:adcd:ab38:7d29])
 (user=haoluo job=sendgmr) by 2002:a05:6902:1501:: with SMTP id
 q1mr1155622ybu.580.1639701124360; Thu, 16 Dec 2021 16:32:04 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:31:45 -0800
In-Reply-To: <20211217003152.48334-1-haoluo@google.com>
Message-Id: <20211217003152.48334-3-haoluo@google.com>
Mime-Version: 1.0
References: <20211217003152.48334-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH bpf-next v2 2/9] bpf: Replace ARG_XXX_OR_NULL with ARG_XXX | PTR_MAYBE_NULL
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

We have introduced a new type to make bpf_arg composable, by
reserving high bits of bpf_arg to represent flags of a type.

One of the flags is PTR_MAYBE_NULL which indicates a pointer
may be NULL. When applying this flag to an arg_type, it means
the arg can take NULL pointer. This patch switches the
qualified arg_types to use this flag. The arg_types changed
in this patch include:

1. ARG_PTR_TO_MAP_VALUE_OR_NULL
2. ARG_PTR_TO_MEM_OR_NULL
3. ARG_PTR_TO_CTX_OR_NULL
4. ARG_PTR_TO_SOCKET_OR_NULL
5. ARG_PTR_TO_ALLOC_MEM_OR_NULL
6. ARG_PTR_TO_STACK_OR_NULL

This patch does not eliminate the use of these arg_types, instead
it makes them an alias to the 'ARG_XXX | PTR_MAYBE_NULL'.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h   | 15 +++++++++------
 kernel/bpf/verifier.c | 39 ++++++++++++++-------------------------
 2 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 41bb3687cc85..765bd7cc4272 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -331,13 +331,11 @@ enum bpf_arg_type {
 	ARG_PTR_TO_MAP_KEY,	/* pointer to stack used as map key */
 	ARG_PTR_TO_MAP_VALUE,	/* pointer to stack used as map value */
 	ARG_PTR_TO_UNINIT_MAP_VALUE,	/* pointer to valid memory used to store a map value */
-	ARG_PTR_TO_MAP_VALUE_OR_NULL,	/* pointer to stack used as map value or NULL */
 
 	/* the following constraints used to prototype bpf_memcmp() and other
 	 * functions that access data on eBPF program stack
 	 */
 	ARG_PTR_TO_MEM,		/* pointer to valid memory (stack, packet, map value) */
-	ARG_PTR_TO_MEM_OR_NULL, /* pointer to valid memory or NULL */
 	ARG_PTR_TO_UNINIT_MEM,	/* pointer to memory does not need to be initialized,
 				 * helper function must fill all bytes or clear
 				 * them in error case.
@@ -347,26 +345,31 @@ enum bpf_arg_type {
 	ARG_CONST_SIZE_OR_ZERO,	/* number of bytes accessed from memory or 0 */
 
 	ARG_PTR_TO_CTX,		/* pointer to context */
-	ARG_PTR_TO_CTX_OR_NULL,	/* pointer to context or NULL */
 	ARG_ANYTHING,		/* any (initialized) argument is ok */
 	ARG_PTR_TO_SPIN_LOCK,	/* pointer to bpf_spin_lock */
 	ARG_PTR_TO_SOCK_COMMON,	/* pointer to sock_common */
 	ARG_PTR_TO_INT,		/* pointer to int */
 	ARG_PTR_TO_LONG,	/* pointer to long */
 	ARG_PTR_TO_SOCKET,	/* pointer to bpf_sock (fullsock) */
-	ARG_PTR_TO_SOCKET_OR_NULL,	/* pointer to bpf_sock (fullsock) or NULL */
 	ARG_PTR_TO_BTF_ID,	/* pointer to in-kernel struct */
 	ARG_PTR_TO_ALLOC_MEM,	/* pointer to dynamically allocated memory */
-	ARG_PTR_TO_ALLOC_MEM_OR_NULL,	/* pointer to dynamically allocated memory or NULL */
 	ARG_CONST_ALLOC_SIZE_OR_ZERO,	/* number of allocated bytes requested */
 	ARG_PTR_TO_BTF_ID_SOCK_COMMON,	/* pointer to in-kernel sock_common or bpf-mirrored bpf_sock */
 	ARG_PTR_TO_PERCPU_BTF_ID,	/* pointer to in-kernel percpu type */
 	ARG_PTR_TO_FUNC,	/* pointer to a bpf program function */
-	ARG_PTR_TO_STACK_OR_NULL,	/* pointer to stack or NULL */
+	ARG_PTR_TO_STACK,	/* pointer to stack */
 	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
 	__BPF_ARG_TYPE_MAX,
 
+	/* Extended arg_types. */
+	ARG_PTR_TO_MAP_VALUE_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_MAP_VALUE,
+	ARG_PTR_TO_MEM_OR_NULL		= PTR_MAYBE_NULL | ARG_PTR_TO_MEM,
+	ARG_PTR_TO_CTX_OR_NULL		= PTR_MAYBE_NULL | ARG_PTR_TO_CTX,
+	ARG_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
+	ARG_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_ALLOC_MEM,
+	ARG_PTR_TO_STACK_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
+
 	/* This must be the last entry. Its purpose is to ensure the enum is
 	 * wide enough to hold the higher bits reserved for bpf_type_flag.
 	 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f0604796132f..66967f6a96c2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -475,14 +475,9 @@ static bool arg_type_may_be_refcounted(enum bpf_arg_type type)
 	return type == ARG_PTR_TO_SOCK_COMMON;
 }
 
-static bool arg_type_may_be_null(enum bpf_arg_type type)
+static bool type_may_be_null(u32 type)
 {
-	return type == ARG_PTR_TO_MAP_VALUE_OR_NULL ||
-	       type == ARG_PTR_TO_MEM_OR_NULL ||
-	       type == ARG_PTR_TO_CTX_OR_NULL ||
-	       type == ARG_PTR_TO_SOCKET_OR_NULL ||
-	       type == ARG_PTR_TO_ALLOC_MEM_OR_NULL ||
-	       type == ARG_PTR_TO_STACK_OR_NULL;
+	return type & PTR_MAYBE_NULL;
 }
 
 /* Determine whether the function releases some resources allocated by another
@@ -4951,9 +4946,8 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 
 static bool arg_type_is_mem_ptr(enum bpf_arg_type type)
 {
-	return type == ARG_PTR_TO_MEM ||
-	       type == ARG_PTR_TO_MEM_OR_NULL ||
-	       type == ARG_PTR_TO_UNINIT_MEM;
+	return base_type(type) == ARG_PTR_TO_MEM ||
+	       base_type(type) == ARG_PTR_TO_UNINIT_MEM;
 }
 
 static bool arg_type_is_mem_size(enum bpf_arg_type type)
@@ -5090,31 +5084,26 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
 	[ARG_PTR_TO_MAP_VALUE]		= &map_key_value_types,
 	[ARG_PTR_TO_UNINIT_MAP_VALUE]	= &map_key_value_types,
-	[ARG_PTR_TO_MAP_VALUE_OR_NULL]	= &map_key_value_types,
 	[ARG_CONST_SIZE]		= &scalar_types,
 	[ARG_CONST_SIZE_OR_ZERO]	= &scalar_types,
 	[ARG_CONST_ALLOC_SIZE_OR_ZERO]	= &scalar_types,
 	[ARG_CONST_MAP_PTR]		= &const_map_ptr_types,
 	[ARG_PTR_TO_CTX]		= &context_types,
-	[ARG_PTR_TO_CTX_OR_NULL]	= &context_types,
 	[ARG_PTR_TO_SOCK_COMMON]	= &sock_types,
 #ifdef CONFIG_NET
 	[ARG_PTR_TO_BTF_ID_SOCK_COMMON]	= &btf_id_sock_common_types,
 #endif
 	[ARG_PTR_TO_SOCKET]		= &fullsock_types,
-	[ARG_PTR_TO_SOCKET_OR_NULL]	= &fullsock_types,
 	[ARG_PTR_TO_BTF_ID]		= &btf_ptr_types,
 	[ARG_PTR_TO_SPIN_LOCK]		= &spin_lock_types,
 	[ARG_PTR_TO_MEM]		= &mem_types,
-	[ARG_PTR_TO_MEM_OR_NULL]	= &mem_types,
 	[ARG_PTR_TO_UNINIT_MEM]		= &mem_types,
 	[ARG_PTR_TO_ALLOC_MEM]		= &alloc_mem_types,
-	[ARG_PTR_TO_ALLOC_MEM_OR_NULL]	= &alloc_mem_types,
 	[ARG_PTR_TO_INT]		= &int_ptr_types,
 	[ARG_PTR_TO_LONG]		= &int_ptr_types,
 	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
 	[ARG_PTR_TO_FUNC]		= &func_ptr_types,
-	[ARG_PTR_TO_STACK_OR_NULL]	= &stack_ptr_types,
+	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
 	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
 	[ARG_PTR_TO_TIMER]		= &timer_types,
 };
@@ -5128,7 +5117,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	const struct bpf_reg_types *compatible;
 	int i, j;
 
-	compatible = compatible_reg_types[arg_type];
+	compatible = compatible_reg_types[base_type(arg_type)];
 	if (!compatible) {
 		verbose(env, "verifier internal error: unsupported arg type %d\n", arg_type);
 		return -EFAULT;
@@ -5209,15 +5198,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return -EACCES;
 	}
 
-	if (arg_type == ARG_PTR_TO_MAP_VALUE ||
-	    arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
-	    arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
+	if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE ||
+	    base_type(arg_type) == ARG_PTR_TO_UNINIT_MAP_VALUE) {
 		err = resolve_map_arg_type(env, meta, &arg_type);
 		if (err)
 			return err;
 	}
 
-	if (register_is_null(reg) && arg_type_may_be_null(arg_type))
+	if (register_is_null(reg) && type_may_be_null(arg_type))
 		/* A NULL register has a SCALAR_VALUE type, so skip
 		 * type checking.
 		 */
@@ -5286,10 +5274,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_helper_mem_access(env, regno,
 					      meta->map_ptr->key_size, false,
 					      NULL);
-	} else if (arg_type == ARG_PTR_TO_MAP_VALUE ||
-		   (arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL &&
-		    !register_is_null(reg)) ||
-		   arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE) {
+	} else if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE ||
+		   base_type(arg_type) == ARG_PTR_TO_UNINIT_MAP_VALUE) {
+		if (type_may_be_null(arg_type) && register_is_null(reg))
+			return 0;
+
 		/* bpf_map_xxx(..., map_ptr, ..., value) call:
 		 * check [value, value + map->value_size) validity
 		 */
-- 
2.34.1.173.g76aa8bc2d0-goog

