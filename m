Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4268478155
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhLQAcO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhLQAcN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 19:32:13 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148A4C061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:32:13 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id de12-20020a05620a370c00b00467697ab8a7so375061qkb.9
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S2+f7KDx0aIbai3p3qBoFds9wgCqlF5JL1/AKp4ZZCI=;
        b=JIY8gJWyuWMBWVb9z7P4nOL0odsrTJGbRbn3O9Kz0ywuOUE+R2SfRO48NR0tFd7BgR
         us/NgcyJEtkbiLFo0vwVU0VSfGZNRSQMivTZw9Bhpq3beKPRyzdPgPWsLGfFHaAmh2wW
         VSVLUyivLx5NDEWa4B+5roxbqEQhaf0KRFsSquBcdaeFkKvr/obznEQGSD5k0IErYiYi
         Atl2C1nam4OmLEvfs/4oLhqn9KjUrM/t7GAvBRk7ly5nYhHs5gSLJQiL8DUGSxD8E68n
         XGlfwmSEhPYBITIuqRMPKhI8BK4yGTMo+l77UNE3CYqiieH5vWfiXPngdN2KdYRO98nm
         xzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S2+f7KDx0aIbai3p3qBoFds9wgCqlF5JL1/AKp4ZZCI=;
        b=IGOnkzk8llvfnS6NpSmYa0uQd21wf5a6GcH05hLWXEgy1bP090lZxLF5rxSiRDXGWu
         Z86z9W6GSUmEG5LSAkk8cvxtA1JO3qScvDpszpijEPUU04d5yGAM+OeaO2NPTUCO5loe
         NSaAsrwcMjLX9H9ELrAx1kGUrb92bn4PxuiJKs5b4WPXTxGwfWzVmSJDYx5eTIz0zv2x
         2YAr962142qBErLrfMWk957aWJEndA6MIipNKRs/r2BKbMr8PZKHyDiKta+U4hw84Z0B
         siRpNf8ESXy9QU0JOLzTkguXIzsh287ZpIRFktgMQoJW7aZKo5e9XnaaTGFSwBjrSVZg
         L04w==
X-Gm-Message-State: AOAM532wJKsfSEJyS4YTzeKAVbJeS2S4Tb2MvoHcF2YzEezDrehqYRyv
        5wETm05ejOiZL2mTELZqrnWgXSETc4Y=
X-Google-Smtp-Source: ABdhPJyRn5RghMFngKP6Mc2CiSstYmvGTjRHC4fmMCq3H9r4bznNYYytaeeH0osN8GsoX9IADFv9qrPmjqw=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:9064:adcd:ab38:7d29])
 (user=haoluo job=sendgmr) by 2002:a05:622a:113:: with SMTP id
 u19mr477846qtw.274.1639701132191; Thu, 16 Dec 2021 16:32:12 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:31:48 -0800
In-Reply-To: <20211217003152.48334-1-haoluo@google.com>
Message-Id: <20211217003152.48334-6-haoluo@google.com>
Mime-Version: 1.0
References: <20211217003152.48334-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH bpf-next v2 5/9] bpf: Introduce MEM_RDONLY flag
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
 include/linux/bpf.h       |  8 ++--
 kernel/bpf/btf.c          |  3 +-
 kernel/bpf/map_iter.c     |  4 +-
 kernel/bpf/verifier.c     | 84 +++++++++++++++++++++++----------------
 net/core/bpf_sk_storage.c |  2 +-
 net/core/sock_map.c       |  2 +-
 6 files changed, 60 insertions(+), 43 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c3de62267b84..126048110bdb 100644
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
@@ -492,8 +495,7 @@ enum bpf_reg_type {
 	 * an explicit null check is required for this struct.
 	 */
 	PTR_TO_MEM,		 /* reg points to valid memory region */
-	PTR_TO_RDONLY_BUF,	 /* reg points to a readonly buffer */
-	PTR_TO_RDWR_BUF,	 /* reg points to a read/write buffer */
+	PTR_TO_BUF,		 /* reg points to a read/write buffer */
 	PTR_TO_PERCPU_BTF_ID,	 /* reg points to a percpu kernel variable */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
 	__BPF_REG_TYPE_MAX,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4e2ca7bea6c4..d1447b075c73 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4944,8 +4944,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 
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
index 97e48f73aabe..7a74fa9ed6a6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -455,6 +455,11 @@ static bool reg_type_may_be_refcounted_or_null(enum bpf_reg_type type)
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
@@ -530,7 +535,7 @@ static bool is_cmpxchg_insn(const struct bpf_insn *insn)
 static const char *reg_type_str(struct bpf_verifier_env *env,
 				enum bpf_reg_type type)
 {
-	char postfix[16] = {0};
+	char postfix[16] = {0}, prefix[16] = {0};
 	static const char * const str[] = {
 		[NOT_INIT]		= "?",
 		[SCALAR_VALUE]		= "inv",
@@ -550,8 +555,7 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 		[PTR_TO_BTF_ID]		= "ptr_",
 		[PTR_TO_PERCPU_BTF_ID]	= "percpu_ptr_",
 		[PTR_TO_MEM]		= "mem",
-		[PTR_TO_RDONLY_BUF]	= "rdonly_buf",
-		[PTR_TO_RDWR_BUF]	= "rdwr_buf",
+		[PTR_TO_BUF]		= "buf",
 		[PTR_TO_FUNC]		= "func",
 		[PTR_TO_MAP_KEY]	= "map_key",
 	};
@@ -564,8 +568,11 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 			strncpy(postfix, "_or_null", 16);
 	}
 
-	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s",
-		 str[base_type(type)], postfix);
+	if (type & MEM_RDONLY)
+		strncpy(prefix, "rdonly_", 16);
+
+	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
+		 prefix, str[base_type(type)], postfix);
 	return env->type_str_buf;
 }
 
@@ -2689,8 +2696,7 @@ static bool is_spillable_regtype(enum bpf_reg_type type)
 	case PTR_TO_TCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
-	case PTR_TO_RDONLY_BUF:
-	case PTR_TO_RDWR_BUF:
+	case PTR_TO_BUF:
 	case PTR_TO_PERCPU_BTF_ID:
 	case PTR_TO_MEM:
 	case PTR_TO_FUNC:
@@ -4443,22 +4449,28 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	} else if (reg->type == CONST_PTR_TO_MAP) {
 		err = check_ptr_to_map_access(env, regs, regno, off, size, t,
 					      value_regno);
-	} else if (reg->type == PTR_TO_RDONLY_BUF) {
-		if (t == BPF_WRITE) {
-			verbose(env, "R%d cannot write into %s\n",
-				regno, reg_type_str(env, reg->type));
-			return -EACCES;
+	} else if (base_type(reg->type) == PTR_TO_BUF) {
+		bool rdonly_mem = type_is_rdonly_mem(reg->type);
+		const char *buf_info;
+		u32 *max_access;
+
+		if (rdonly_mem) {
+			if (t == BPF_WRITE) {
+				verbose(env, "R%d cannot write into %s\n",
+					regno, reg_type_str(env, reg->type));
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
-		if (!err && value_regno >= 0)
-			mark_reg_unknown(env, regs, value_regno);
-	} else if (reg->type == PTR_TO_RDWR_BUF) {
-		err = check_buffer_access(env, reg, regno, off, size, false,
-					  "rdwr",
-					  &env->prog->aux->max_rdwr_access);
-		if (!err && t == BPF_READ && value_regno >= 0)
+					  buf_info, max_access);
+
+		if (!err && value_regno >= 0 && (rdonly_mem || t == BPF_READ))
 			mark_reg_unknown(env, regs, value_regno);
 	} else {
 		verbose(env, "R%d invalid mem access '%s'\n", regno,
@@ -4706,8 +4718,10 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
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
@@ -4726,18 +4740,20 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
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
@@ -5016,8 +5032,8 @@ static const struct bpf_reg_types mem_types = {
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
index 96d4ea7e6918..9618ab6d7cc9 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1564,7 +1564,7 @@ static struct bpf_iter_reg sock_map_iter_reg = {
 	.ctx_arg_info_size	= 2,
 	.ctx_arg_info		= {
 		{ offsetof(struct bpf_iter__sockmap, key),
-		  PTR_TO_RDONLY_BUF | PTR_MAYBE_NULL },
+		  PTR_TO_BUF | PTR_MAYBE_NULL | MEM_RDONLY },
 		{ offsetof(struct bpf_iter__sockmap, sk),
 		  PTR_TO_BTF_ID_OR_NULL },
 	},
-- 
2.34.1.173.g76aa8bc2d0-goog

