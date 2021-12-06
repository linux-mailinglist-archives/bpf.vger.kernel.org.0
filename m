Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F90F46AE5B
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 00:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356298AbhLFX0L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 18:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350577AbhLFX0K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 18:26:10 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF19EC061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 15:22:41 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id k11-20020a63d84b000000b003252e72da7eso7576395pgj.23
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 15:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BOkZYoxj/6uquiN9qsBxBl7WGCHU5Fc6SzWSQUZQhU4=;
        b=b2x0t5zjLy/ywQmRVtt4+/JIhQCtUJTcD9HNeCBnfmzkJ/aImDsR4TYrT+rBoBRqFr
         Jn/BwraHCrxqdXMm9r9S5rCSmP6j1DbnFF/bGFxh/Ym7a7gmgRJcN0mrvA9C68Gc9PEq
         mur2QSZrRb2FkxTKFtNLh7LJqeG2kVxMMTXd3aC+AkzDJqa1xqlPSobUirKvHH3NKmVg
         d/BfWhCtOEpJB55CNIxb/ADWLuqUCfQnJJUWuobipLeADl5lFuR8T/T42jsAQPG0Nj5n
         ZaqnWjrSrUGfhEG7WaqXlQP0V62y9bC9hAIwM/GRvOEkKpRXvIi3coLJdls/lAv5cnXB
         L7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BOkZYoxj/6uquiN9qsBxBl7WGCHU5Fc6SzWSQUZQhU4=;
        b=d9B/efhDGOwD41FjKqs1+sfGIjuluJ14xiyQQSjtv6r1KGXV97IYzEs3DVJcMNaS9o
         vdSp6+QuS5/BJzWui4X2ypbNi+inHDixOYoIymnzfNnAXbwX6F0PUuryLOk6leVcaoFz
         ERbB5pagEG0AnsTOnV0zzqYL1bcXHXiJZC2Y7mbgeEYu8JoHAdJ6K8o0vKQ69+B99vKo
         Iu4/6dnkQVWJFJlKRtTVWv+dMWE7F/NG1Q0PZ9KBIwKTOuL6c7Q6orbA2FP9oNyE2IPa
         fWoRJHtyrfaROsorNT2A2hbLRbgMUB7jJHLKXrwLg7tAX0d4na39mWTzoHF+wo9FFoYi
         Da8Q==
X-Gm-Message-State: AOAM530ZXrJE92uFUUZcgW1QX07vQDtrGo9O+JysgKX+gO+ZnLrgvDLt
        YGDzZvFJ5ftblkwxeAIe1q1TS/f/Et4=
X-Google-Smtp-Source: ABdhPJyLMK3yguphfkAOHO7qvTgWRgH01jEmTra7/t56x1dSKnRUlWT2uYWshMhdEhy8x2fFS4NK1NN6bfs=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:2977:d88c:3c3:c52a])
 (user=haoluo job=sendgmr) by 2002:a63:6e0c:: with SMTP id j12mr9126013pgc.117.1638832961188;
 Mon, 06 Dec 2021 15:22:41 -0800 (PST)
Date:   Mon,  6 Dec 2021 15:22:23 -0800
In-Reply-To: <20211206232227.3286237-1-haoluo@google.com>
Message-Id: <20211206232227.3286237-6-haoluo@google.com>
Mime-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH bpf-next v1 5/9] bpf: Introduce MEM_RDONLY flag
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

This patch introduce a flag MEM_RDONLY to tag a reg value
pointing to read-only memory. It makes the following changes:

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
index c3371a1b9452..0d88e6027ca1 100644
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
 
 /* Max number of base types. */
@@ -491,8 +494,7 @@ enum bpf_reg_type {
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
index 4e3a1a6bf7d2..a51b9f54b77a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4945,8 +4945,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 
 		type = base_type(ctx_arg_info->reg_type);
 		flag = type_flag(ctx_arg_info->reg_type);
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
index 7e55e783838d..66e3891f5811 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -452,6 +452,11 @@ static bool reg_type_may_be_refcounted_or_null(enum bpf_reg_type type)
 		base_type(type) == PTR_TO_MEM;
 }
 
+static bool type_is_rdonly_mem(u32 type)
+{
+	return type & MEM_RDONLY;
+}
+
 static bool arg_type_may_be_refcounted(enum bpf_arg_type type)
 {
 	return type == ARG_PTR_TO_SOCK_COMMON;
@@ -541,8 +546,7 @@ static const char *reg_type_str(enum bpf_reg_type type)
 		[PTR_TO_BTF_ID]		= "ptr_",
 		[PTR_TO_PERCPU_BTF_ID]	= "percpu_ptr_",
 		[PTR_TO_MEM]		= "mem",
-		[PTR_TO_RDONLY_BUF]	= "rdonly_buf",
-		[PTR_TO_RDWR_BUF]	= "rdwr_buf",
+		[PTR_TO_BUF]		= "rdwr_buf",
 		[PTR_TO_FUNC]		= "func",
 		[PTR_TO_MAP_KEY]	= "map_key",
 	};
@@ -2669,8 +2673,7 @@ static bool is_spillable_regtype(enum bpf_reg_type type)
 	case PTR_TO_TCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
-	case PTR_TO_RDONLY_BUF:
-	case PTR_TO_RDWR_BUF:
+	case PTR_TO_BUF:
 	case PTR_TO_PERCPU_BTF_ID:
 	case PTR_TO_MEM:
 	case PTR_TO_FUNC:
@@ -4408,23 +4411,30 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	} else if (reg->type == CONST_PTR_TO_MAP) {
 		err = check_ptr_to_map_access(env, regs, regno, off, size, t,
 					      value_regno);
-	} else if (reg->type == PTR_TO_RDONLY_BUF) {
-		if (t == BPF_WRITE) {
-			verbose(env, "R%d cannot write into %s\n",
-				regno, reg_type_str(reg->type));
-			return -EACCES;
+	} else if (base_type(reg->type) == PTR_TO_BUF) {
+		bool rdonly_mem = type_is_rdonly_mem(reg->type);
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
@@ -4671,8 +4681,10 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 				   struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	const char *buf_info;
+	u32 *max_access;
 
-	switch (reg->type) {
+	switch (base_type(reg->type)) {
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
 		return check_packet_access(env, regno, reg->off, access_size,
@@ -4691,18 +4703,20 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
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
+		if (type_is_rdonly_mem(reg->type)) {
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
@@ -4981,8 +4995,8 @@ static const struct bpf_reg_types mem_types = {
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
2.34.1.400.ga245620fadb-goog

