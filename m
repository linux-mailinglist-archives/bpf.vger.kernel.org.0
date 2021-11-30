Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652254629B4
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 02:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhK3Bd1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 20:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbhK3BdZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 20:33:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF9C061758
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:30:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l145-20020a25cc97000000b005c5d04a1d52so26116111ybf.23
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4jklj3oJWpkeckRRCLf4IP7gydyC9JzTi3jfjvfjIN4=;
        b=erFjTMfn9tmqXM6f4/zhg27NW/gI0wiKWSLLWjwIqe0RAZycZlZyiaoMICrN60kErk
         m2jsR2fNWupKrkUk2Impcl6kNNipDmcbPP6cKrf8FFR6kA7GVXdajJ7K4ssnR4r3epkn
         8gMrPRrgdpOF5S+Sq4AuUoB0jkJQSdaAjNEyaILQzawAxpo2nxnitF/SdZ64KS7Y7Xdi
         Huj71MCZ5nrFKg9LffZyQNtW1mPKgmltAPZe/YcQ+dLpUNyFEcyeStVPGsUXfZ2Dq9FX
         SLJxZfDqhjrq20BgybL4IiBwt435EVlA97rzs8eLUAn4C1T2/gIH4KRWwnjs5FPYKaUU
         dqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4jklj3oJWpkeckRRCLf4IP7gydyC9JzTi3jfjvfjIN4=;
        b=zm9bSWXlDrc/K9w8PpQ5aRmkavkZLNvBKzIV8Q+406S272Is3aKyym8bvNL/xF8sDG
         gh7NIOFc7bRmLhrxhvGNMwBgZzduSlYHvK/HmEbvswroABVAbcnZMVz3uRotkJPA8QOC
         4dCi6JfaKq4G/JMjRNEDC/UaCOJN1W38GJHYTmvNkN60VSodu9hRHMlJpxSZWW3vfEXw
         HBictw60ZuXryUaaN7Hc2i3CzGHTi4GyDC98s+zKlRUu6JR6V5qXgGri4mmUcjYgQQo2
         +CZWe+iKPccEfryFQKZxcyifVJBCvUI+KjoCp8N9ewDkSS4+QG3yDJDSc3jURBWD5FBd
         skeg==
X-Gm-Message-State: AOAM5318pxz3Mxs3xQauHozvWWDIyFVD3nqGuLOwVS3FmhpDpXa7gaKK
        vQKWQKCVqCtA4xt50YOjDXC2kbGHCYg=
X-Google-Smtp-Source: ABdhPJymEMzU6UrMExvUvTdEDrzV4Ibf8fG0KIyt1DYd9M/vhGn6qChEXy7Dtl2u6YTVWHgTe/5E1edXNKE=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:bbf5:5c09:9dfe:483c])
 (user=haoluo job=sendgmr) by 2002:a25:848d:: with SMTP id v13mr42118362ybk.178.1638235804012;
 Mon, 29 Nov 2021 17:30:04 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:29:44 -0800
In-Reply-To: <20211130012948.380602-1-haoluo@google.com>
Message-Id: <20211130012948.380602-6-haoluo@google.com>
Mime-Version: 1.0
References: <20211130012948.380602-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [RFC PATCH bpf-next v2 5/9] bpf: Introduce MEM_RDONLY flag
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

This patch introduce another flag MEM_RDONLY to tag a reg value is
pointing to a read-only memory. It makes the following changes:

1. PTR_TO_RDWR_BUF -> PTR_TO_BUF
2. PTR_TO_RDONLY_BUF -> PTR_TO_BUF | MEM_RDONLY

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h       |  8 +++--
 kernel/bpf/btf.c          |  3 +-
 kernel/bpf/map_iter.c     |  4 +--
 kernel/bpf/verifier.c     | 76 +++++++++++++++++++++++----------------
 net/core/bpf_sk_storage.c |  2 +-
 net/core/sock_map.c       |  2 +-
 6 files changed, 55 insertions(+), 40 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d484f6637e60..61b72dbaeae8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -311,7 +311,10 @@ enum bpf_type_flag {
 	/* PTR may be NULL. */
 	PTR_MAYBE_NULL		= BIT(0 + BPF_BASE_TYPE_BITS),
 
-	__BPF_TYPE_LAST_FLAG	= PTR_MAYBE_NULL,
+	/* MEM is read-only. */
+	MEM_RDONLY		= BIT(1 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	= MEM_RDONLY,
 };
 
 #define BPF_BASE_TYPE_MASK	GENMASK(BPF_BASE_TYPE_BITS, 0)
@@ -499,8 +502,7 @@ enum bpf_reg_type {
 	 * an explicit null check is required for this struct.
 	 */
 	PTR_TO_MEM,		 /* reg points to valid memory region */
-	PTR_TO_RDONLY_BUF,	 /* reg points to a readonly buffer */
-	PTR_TO_RDWR_BUF,	 /* reg points to a read/write buffer */
+	PTR_TO_BUF,		 /* reg points to a read/write buffer */
 	PTR_TO_PERCPU_BTF_ID,	 /* reg points to a percpu kernel variable */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
 	PTR_TO_MAP_KEY,		 /* reg points to a map element key */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 62a86db7d8ec..19ddd6fe5663 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4946,8 +4946,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 
 		type = BPF_BASE_TYPE(ctx_arg_info->reg_type);
 		flag = BPF_TYPE_FLAG(ctx_arg_info->reg_type);
-		if (ctx_arg_info->offset == off &&
-		    (type == PTR_TO_RDWR_BUF || type == PTR_TO_RDONLY_BUF) &&
+		if (ctx_arg_info->offset == off && type == PTR_TO_BUF &&
 		    (flag & PTR_MAYBE_NULL)) {
 			info->reg_type = ctx_arg_info->reg_type;
 			return true;
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 631f0e44b7a9..b0fa190b0979 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -174,9 +174,9 @@ static const struct bpf_iter_reg bpf_map_elem_reg_info = {
 	.ctx_arg_info_size	= 2,
 	.ctx_arg_info		= {
 		{ offsetof(struct bpf_iter__bpf_map_elem, key),
-		  PTR_TO_RDONLY_BUF | PTR_MAYBE_NULL },
+		  PTR_TO_BUF | PTR_MAYBE_NULL | MEM_RDONLY },
 		{ offsetof(struct bpf_iter__bpf_map_elem, value),
-		  PTR_TO_RDWR_BUF | PTR_MAYBE_NULL },
+		  PTR_TO_BUF | PTR_MAYBE_NULL },
 	},
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01a564a23562..27f3440f4b18 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -457,6 +457,11 @@ static bool reg_type_may_be_refcounted_or_null(enum bpf_reg_type type)
 		BPF_BASE_TYPE(type) == PTR_TO_MEM;
 }
 
+static bool reg_type_is_rdonly_mem(enum bpf_reg_type type)
+{
+	return BPF_TYPE_FLAG(type) & MEM_RDONLY;
+}
+
 static bool arg_type_may_be_refcounted(enum bpf_arg_type type)
 {
 	return type == ARG_PTR_TO_SOCK_COMMON;
@@ -551,8 +556,7 @@ static const char * const reg_type_str(enum bpf_reg_type type)
 		[PTR_TO_BTF_ID]		= "ptr_",
 		[PTR_TO_PERCPU_BTF_ID]	= "percpu_ptr_",
 		[PTR_TO_MEM]		= "mem",
-		[PTR_TO_RDONLY_BUF]	= "rdonly_buf",
-		[PTR_TO_RDWR_BUF]	= "rdwr_buf",
+		[PTR_TO_BUF]		= "rdwr_buf",
 		[PTR_TO_FUNC]		= "func",
 		[PTR_TO_MAP_KEY]	= "map_key",
 	};
@@ -2679,8 +2683,7 @@ static bool is_spillable_regtype(enum bpf_reg_type type)
 	case PTR_TO_TCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
-	case PTR_TO_RDONLY_BUF:
-	case PTR_TO_RDWR_BUF:
+	case PTR_TO_BUF:
 	case PTR_TO_PERCPU_BTF_ID:
 	case PTR_TO_MEM:
 	case PTR_TO_FUNC:
@@ -4418,23 +4421,30 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	} else if (reg->type == CONST_PTR_TO_MAP) {
 		err = check_ptr_to_map_access(env, regs, regno, off, size, t,
 					      value_regno);
-	} else if (reg->type == PTR_TO_RDONLY_BUF) {
-		if (t == BPF_WRITE) {
-			verbose(env, "R%d cannot write into %s\n",
-				regno, reg_type_str(reg->type));
-			return -EACCES;
+	} else if (BPF_BASE_TYPE(reg->type) == PTR_TO_BUF) {
+		bool rdonly_mem = reg_type_is_rdonly_mem(reg->type);
+		const char *buf_info;
+		u32 *max_access;
+
+		if (rdonly_mem) {
+			if (t == BPF_WRITE) {
+				verbose(env, "R%d cannot write into rdonly %s\n",
+					regno, reg_type_str(reg->type));
+				return -EACCES;
+			}
+			buf_info = "rdonly";
+			max_access = &env->prog->aux->max_rdonly_access;
+		} else {
+			buf_info = "rdwr";
+			max_access = &env->prog->aux->max_rdwr_access;
 		}
+
 		err = check_buffer_access(env, reg, regno, off, size, false,
-					  "rdonly",
-					  &env->prog->aux->max_rdonly_access);
+					  buf_info, max_access);
+
 		if (!err && value_regno >= 0)
-			mark_reg_unknown(env, regs, value_regno);
-	} else if (reg->type == PTR_TO_RDWR_BUF) {
-		err = check_buffer_access(env, reg, regno, off, size, false,
-					  "rdwr",
-					  &env->prog->aux->max_rdwr_access);
-		if (!err && t == BPF_READ && value_regno >= 0)
-			mark_reg_unknown(env, regs, value_regno);
+			if (rdonly_mem || t == BPF_READ)
+				mark_reg_unknown(env, regs, value_regno);
 	} else {
 		verbose(env, "R%d invalid mem access '%s'\n", regno,
 			reg_type_str(reg->type));
@@ -4681,8 +4691,10 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 				   struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	const char *buf_info;
+	u32 *max_access;
 
-	switch (reg->type) {
+	switch (BPF_BASE_TYPE(reg->type)) {
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
 		return check_packet_access(env, regno, reg->off, access_size,
@@ -4701,18 +4713,20 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		return check_mem_region_access(env, regno, reg->off,
 					       access_size, reg->mem_size,
 					       zero_size_allowed);
-	case PTR_TO_RDONLY_BUF:
-		if (meta && meta->raw_mode)
-			return -EACCES;
-		return check_buffer_access(env, reg, regno, reg->off,
-					   access_size, zero_size_allowed,
-					   "rdonly",
-					   &env->prog->aux->max_rdonly_access);
-	case PTR_TO_RDWR_BUF:
+	case PTR_TO_BUF:
+		if (reg_type_is_rdonly_mem(reg->type)) {
+			if (meta && meta->raw_mode)
+				return -EACCES;
+
+			buf_info = "rdonly";
+			max_access = &env->prog->aux->max_rdonly_access;
+		} else {
+			buf_info = "rdwr";
+			max_access = &env->prog->aux->max_rdwr_access;
+		}
 		return check_buffer_access(env, reg, regno, reg->off,
 					   access_size, zero_size_allowed,
-					   "rdwr",
-					   &env->prog->aux->max_rdwr_access);
+					   buf_info, max_access);
 	case PTR_TO_STACK:
 		return check_stack_range_initialized(
 				env,
@@ -4991,8 +5005,8 @@ static const struct bpf_reg_types mem_types = {
 		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
 		PTR_TO_MEM,
-		PTR_TO_RDONLY_BUF,
-		PTR_TO_RDWR_BUF,
+		PTR_TO_BUF,
+		PTR_TO_BUF | MEM_RDONLY,
 	},
 };
 
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 4cb5ef8eddbc..ea61dfe19c86 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -929,7 +929,7 @@ static struct bpf_iter_reg bpf_sk_storage_map_reg_info = {
 		{ offsetof(struct bpf_iter__bpf_sk_storage_map, sk),
 		  PTR_TO_BTF_ID_OR_NULL },
 		{ offsetof(struct bpf_iter__bpf_sk_storage_map, value),
-		  PTR_TO_RDWR_BUF | PTR_MAYBE_NULL },
+		  PTR_TO_BUF | PTR_MAYBE_NULL },
 	},
 	.seq_info		= &iter_seq_info,
 };
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 8b2632be3771..005bf58b1148 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1559,7 +1559,7 @@ static struct bpf_iter_reg sock_map_iter_reg = {
 	.ctx_arg_info_size	= 2,
 	.ctx_arg_info		= {
 		{ offsetof(struct bpf_iter__sockmap, key),
-		  PTR_TO_RDONLY_BUF | PTR_MAYBE_NULL },
+		  PTR_TO_BUF | PTR_MAYBE_NULL | MEM_RDONLY },
 		{ offsetof(struct bpf_iter__sockmap, sk),
 		  PTR_TO_BTF_ID_OR_NULL },
 	},
-- 
2.34.0.384.gca35af8252-goog

