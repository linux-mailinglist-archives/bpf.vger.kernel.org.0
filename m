Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F27F4629B1
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 02:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236521AbhK3Bd0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 20:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbhK3BdR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 20:33:17 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475A3C061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:29:58 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id q19-20020a056a00151300b004a4ca777976so11845751pfu.19
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HdlumpO2WzFE2O+rYxIEHozE9S+Y9a3N8vRCwaE8OLk=;
        b=oarwECPvpTJndPioSj9oRARwTbvoqRjZq3XWcIT7defX3bFMFRWfs3ftCK25Llur4Z
         L+e0XdFdhS4COA+orppraHTeykGe7wo0L8js8I13f2fAyJq3HLKCQxJYfcBYoslNWLOI
         7HxVaUXHSY+c+TqzdBoBJQbQ5go3xqGMM7mzILSK9SukCGCmg5sMp37LQ6ck/2C+4UUC
         woNp1uA6MQPfECQI57IeqCk0SipHIDE/B/7RWpuo4qIMNlJVn2z/8+8dxCD66zzoR6F8
         1wP0h1vZYGj6eqltb50Q0uYBLsRglqAlCoyJnhr3KSd8RwexTrefmxiBOYcSRenFu5Ih
         rGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HdlumpO2WzFE2O+rYxIEHozE9S+Y9a3N8vRCwaE8OLk=;
        b=u3jsl00HfFO9LtMBfel/K9oiXGed8+Lsjke9ITALJgwlViQxcV0ylLx4yvsIREEcBc
         M9zbTDV6M2FqSmyrBnWUKwvU3HxmEKLhhZ1fisqSwnyrNynBmkF0WU8y6OyWuO3lPDna
         yPSXAn7ddQAbOilQCGyPzIJN29vbGmNM6NEx7YaM1yZZgYm2KGX4ZelYl2S5QwSlQxDP
         nQ14ASQY4ikzY8UQ2O1CQOhtJiypU4fQEHSKB7M9QgGP7BEfLH+A4XGv9TZwgUXWQAm/
         HAj4XCfNW5kPhQCP28F5ybIOT7eqljxH3k4Ikcb1hs3EPsuB6kWxHgzFTByU3Aqr7bys
         WmFQ==
X-Gm-Message-State: AOAM531VK3WvoHyzKv9/ck/WsPhYDh3xNSk889peLlIcLQC+Pa+m6mSd
        xc1ynFZSNMVeO7IJBMrtU2NStKkXjkY=
X-Google-Smtp-Source: ABdhPJxdtQPvYHy1hPXXtmpJsged8ihSuHwYw0Vmc3O6CurYoQ+GgogMP8rOzEv4OQ51aW1hv5Bzk+3TxPw=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:bbf5:5c09:9dfe:483c])
 (user=haoluo job=sendgmr) by 2002:a17:902:d491:b0:142:892d:a89 with SMTP id
 c17-20020a170902d49100b00142892d0a89mr62288346plg.20.1638235797746; Mon, 29
 Nov 2021 17:29:57 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:29:41 -0800
In-Reply-To: <20211130012948.380602-1-haoluo@google.com>
Message-Id: <20211130012948.380602-3-haoluo@google.com>
Mime-Version: 1.0
References: <20211130012948.380602-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [RFC PATCH bpf-next v2 2/9] bpf: Replace ARG_XXX_OR_NULL with ARG_XXX
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

We have introduced a new type to make bpf_arg composable, by
introducing flags to tag a particular type.

One of the flag is PTR_MAYBE_NULL, which indicates a pointer
may be NULL. This patch switches the qualified arg_types to
use this flag. The arg_types changed in this patch include:

1. ARG_PTR_TO_MAP_VALUE_OR_NULL
2. ARG_PTR_TO_MEM_OR_NULL
3. ARG_PTR_TO_CTX_OR_NULL
4. ARG_PTR_TO_SOCKET_OR_NULL
5. ARG_PTR_TO_ALLOC_MEM_OR_NULL
6. ARG_PTR_TO_STACK_OR_NULL

This patch does not eliminate the use of these arg_types, instead, it
makes them an alias to the 'ARG_XXX | PTR_MAYBE_NULL'.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h   | 15 +++++++++------
 kernel/bpf/verifier.c | 35 ++++++++++++-----------------------
 2 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b592b3f7d223..da31c79724d4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -339,13 +339,11 @@ enum bpf_arg_type {
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
@@ -355,26 +353,31 @@ enum bpf_arg_type {
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
index 0763cca139a7..78227d2cffb1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -474,12 +474,7 @@ static bool arg_type_may_be_refcounted(enum bpf_arg_type type)
 
 static bool arg_type_may_be_null(enum bpf_arg_type type)
 {
-	return type == ARG_PTR_TO_MAP_VALUE_OR_NULL ||
-	       type == ARG_PTR_TO_MEM_OR_NULL ||
-	       type == ARG_PTR_TO_CTX_OR_NULL ||
-	       type == ARG_PTR_TO_SOCKET_OR_NULL ||
-	       type == ARG_PTR_TO_ALLOC_MEM_OR_NULL ||
-	       type == ARG_PTR_TO_STACK_OR_NULL;
+	return BPF_TYPE_FLAG(type) & PTR_MAYBE_NULL;
 }
 
 /* Determine whether the function releases some resources allocated by another
@@ -4932,9 +4927,8 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 
 static bool arg_type_is_mem_ptr(enum bpf_arg_type type)
 {
-	return type == ARG_PTR_TO_MEM ||
-	       type == ARG_PTR_TO_MEM_OR_NULL ||
-	       type == ARG_PTR_TO_UNINIT_MEM;
+	return BPF_BASE_TYPE(type) == ARG_PTR_TO_MEM ||
+	       BPF_BASE_TYPE(type) == ARG_PTR_TO_UNINIT_MEM;
 }
 
 static bool arg_type_is_mem_size(enum bpf_arg_type type)
@@ -5071,31 +5065,26 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
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
@@ -5109,7 +5098,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	const struct bpf_reg_types *compatible;
 	int i, j;
 
-	compatible = compatible_reg_types[arg_type];
+	compatible = compatible_reg_types[BPF_BASE_TYPE(arg_type)];
 	if (!compatible) {
 		verbose(env, "verifier internal error: unsupported arg type %d\n", arg_type);
 		return -EFAULT;
@@ -5190,9 +5179,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return -EACCES;
 	}
 
-	if (arg_type == ARG_PTR_TO_MAP_VALUE ||
-	    arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
-	    arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
+	if (BPF_BASE_TYPE(arg_type) == ARG_PTR_TO_MAP_VALUE ||
+	    BPF_BASE_TYPE(arg_type) == ARG_PTR_TO_UNINIT_MAP_VALUE) {
 		err = resolve_map_arg_type(env, meta, &arg_type);
 		if (err)
 			return err;
@@ -5267,10 +5255,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_helper_mem_access(env, regno,
 					      meta->map_ptr->key_size, false,
 					      NULL);
-	} else if (arg_type == ARG_PTR_TO_MAP_VALUE ||
-		   (arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL &&
-		    !register_is_null(reg)) ||
-		   arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE) {
+	} else if (BPF_BASE_TYPE(arg_type) == ARG_PTR_TO_MAP_VALUE ||
+		   BPF_BASE_TYPE(arg_type) == ARG_PTR_TO_UNINIT_MAP_VALUE) {
+		if (!arg_type_may_be_null(arg_type) && register_is_null(reg))
+			return err;
+
 		/* bpf_map_xxx(..., map_ptr, ..., value) call:
 		 * check [value, value + map->value_size) validity
 		 */
-- 
2.34.0.384.gca35af8252-goog

