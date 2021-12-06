Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B983C46AE5A
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 00:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346631AbhLFX0J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 18:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350577AbhLFX0J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 18:26:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD40CC061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 15:22:39 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x5-20020a2584c5000000b005f89a35e57eso22215043ybm.19
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 15:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h4dtStAUO0ImimS7OE7LnYNE6mMISzdVyj/bDpguyas=;
        b=dVRhVo+jRqaaPFig9MlURkvlDrRGot4oUIzaxkT2SljE15cc8t4tjenCf7gkBrAdyF
         PDg/tKA00DtFb7nq6EDU7L+GSYVQdru+Dwd7szKs1ikKMh3G0JCvZOYGafJYJnMexKIg
         N8MF2mJyY91KeAamBYgo1ACxcLqsKTiV59YbWB+8XyPodonwoM3Zx/SRIgLrdDd+8H73
         OwvZiPmAIEy8rLn/Blss8FnXM8/wvVIadmXTT9R1dykcf6o5Een7ZQndoJx/z54T/jNd
         gfYDjVQd7p5AWyiTzXbzkyflAQRXlopOmwouTvTEXokrxVZ+poETYSR1DhvjO4RMfMte
         Z5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h4dtStAUO0ImimS7OE7LnYNE6mMISzdVyj/bDpguyas=;
        b=QgUboETroidxCzt103jvzpDigO16aLdCJVt4mowFYimXqBCmGWqxksc2QHKoKkGYiH
         2ZN80lY2CVNKSa7F0N7HlGDB6BM/e09V3AMm7BkqcsUwu8eu9Np2TWNsQFMAcYvSII0y
         ZnHkVpQFCQfn/pdE4s6vlflCJXL6y3kTVV0HbDhlEcqz4UJl8IRSkQaLwfxo9CvBYqy4
         CXYPaLXBIVfYYkYdfZ1e1l173rEGTta5jJE91mNW++HnrgsInXgc7isRtTXSUpyt5uAO
         A3fmrSeTxdV60yk6I1Rp7K9JWFItp9iaxunsmmK1X2FfyqfU2R/y+HhnaEts8Tx3L1L4
         txqA==
X-Gm-Message-State: AOAM531YN74aEpcP46lYudoEwO2l1mqTu4rblbQWaLFAAp7K0jjEyoCw
        7EjpH+vJ/iqxmiehUnGR0e+HLZilKYk=
X-Google-Smtp-Source: ABdhPJy4S2H018NgYgjgBsVLlEKbBL1ewY/CdOSDZzuEo+hOqNVBHik+OxL9mcflVIt5PW9A4ClP7bUriRU=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:2977:d88c:3c3:c52a])
 (user=haoluo job=sendgmr) by 2002:a25:c092:: with SMTP id c140mr7481947ybf.153.1638832959122;
 Mon, 06 Dec 2021 15:22:39 -0800 (PST)
Date:   Mon,  6 Dec 2021 15:22:22 -0800
In-Reply-To: <20211206232227.3286237-1-haoluo@google.com>
Message-Id: <20211206232227.3286237-5-haoluo@google.com>
Mime-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH bpf-next v1 4/9] bpf: Replace PTR_TO_XXX_OR_NULL with
 PTR_TO_XXX | PTR_MAYBE_NULL
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

We have introduced a new type to make bpf_reg composable, by
allocating bits in the type to represent flags.

One of the flags is PTR_MAYBE_NULL which indicates a pointer
may be NULL. This patch switches the qualified reg_types to
use this flag. The reg_types changed in this patch include:

1. PTR_TO_MAP_VALUE_OR_NULL
2. PTR_TO_SOCKET_OR_NULL
3. PTR_TO_SOCK_COMMON_OR_NULL
4. PTR_TO_TCP_SOCK_OR_NULL
5. PTR_TO_BTF_ID_OR_NULL
6. PTR_TO_MEM_OR_NULL
7. PTR_TO_RDONLY_BUF_OR_NULL
8. PTR_TO_RDWR_BUF_OR_NULL

Signed-off-by: Hao Luo <haoluo@google.com>
---
 drivers/net/ethernet/netronome/nfp/bpf/fw.h |   4 +-
 include/linux/bpf.h                         |  16 +-
 kernel/bpf/btf.c                            |   7 +-
 kernel/bpf/map_iter.c                       |   4 +-
 kernel/bpf/verifier.c                       | 278 ++++++++------------
 net/core/bpf_sk_storage.c                   |   2 +-
 net/core/sock_map.c                         |   2 +-
 7 files changed, 126 insertions(+), 187 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/fw.h b/drivers/net/ethernet/netronome/nfp/bpf/fw.h
index 4268a7e0f344..33f9058ed32e 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/fw.h
+++ b/drivers/net/ethernet/netronome/nfp/bpf/fw.h
@@ -13,8 +13,8 @@
  */
 #define NFP_BPF_SCALAR_VALUE		1
 #define NFP_BPF_MAP_VALUE		4
-#define NFP_BPF_STACK			6
-#define NFP_BPF_PACKET_DATA		8
+#define NFP_BPF_STACK			5
+#define NFP_BPF_PACKET_DATA		7
 
 enum bpf_cap_tlv_type {
 	NFP_BPF_CAP_TYPE_FUNC		= 1,
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 202eb5155edc..c3371a1b9452 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -465,18 +465,14 @@ enum bpf_reg_type {
 	PTR_TO_CTX,		 /* reg points to bpf_context */
 	CONST_PTR_TO_MAP,	 /* reg points to struct bpf_map */
 	PTR_TO_MAP_VALUE,	 /* reg points to map element value */
-	PTR_TO_MAP_VALUE_OR_NULL,/* points to map elem value or NULL */
 	PTR_TO_STACK,		 /* reg == frame_pointer + offset */
 	PTR_TO_PACKET_META,	 /* skb->data - meta_len */
 	PTR_TO_PACKET,		 /* reg points to skb->data */
 	PTR_TO_PACKET_END,	 /* skb->data + headlen */
 	PTR_TO_FLOW_KEYS,	 /* reg points to bpf_flow_keys */
 	PTR_TO_SOCKET,		 /* reg points to struct bpf_sock */
-	PTR_TO_SOCKET_OR_NULL,	 /* reg points to struct bpf_sock or NULL */
 	PTR_TO_SOCK_COMMON,	 /* reg points to sock_common */
-	PTR_TO_SOCK_COMMON_OR_NULL, /* reg points to sock_common or NULL */
 	PTR_TO_TCP_SOCK,	 /* reg points to struct tcp_sock */
-	PTR_TO_TCP_SOCK_OR_NULL, /* reg points to struct tcp_sock or NULL */
 	PTR_TO_TP_BUFFER,	 /* reg points to a writable raw tp's buffer */
 	PTR_TO_XDP_SOCK,	 /* reg points to struct xdp_sock */
 	/* PTR_TO_BTF_ID points to a kernel struct that does not need
@@ -494,18 +490,22 @@ enum bpf_reg_type {
 	 * been checked for null. Used primarily to inform the verifier
 	 * an explicit null check is required for this struct.
 	 */
-	PTR_TO_BTF_ID_OR_NULL,
 	PTR_TO_MEM,		 /* reg points to valid memory region */
-	PTR_TO_MEM_OR_NULL,	 /* reg points to valid memory region or NULL */
 	PTR_TO_RDONLY_BUF,	 /* reg points to a readonly buffer */
-	PTR_TO_RDONLY_BUF_OR_NULL, /* reg points to a readonly buffer or NULL */
 	PTR_TO_RDWR_BUF,	 /* reg points to a read/write buffer */
-	PTR_TO_RDWR_BUF_OR_NULL, /* reg points to a read/write buffer or NULL */
 	PTR_TO_PERCPU_BTF_ID,	 /* reg points to a percpu kernel variable */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
 	PTR_TO_MAP_KEY,		 /* reg points to a map element key */
 	__BPF_REG_TYPE_MAX,
 
+	/* Extended reg_types. */
+	PTR_TO_MAP_VALUE_OR_NULL	= PTR_MAYBE_NULL | PTR_TO_MAP_VALUE,
+	PTR_TO_SOCKET_OR_NULL		= PTR_MAYBE_NULL | PTR_TO_SOCKET,
+	PTR_TO_SOCK_COMMON_OR_NULL	= PTR_MAYBE_NULL | PTR_TO_SOCK_COMMON,
+	PTR_TO_TCP_SOCK_OR_NULL		= PTR_MAYBE_NULL | PTR_TO_TCP_SOCK,
+	PTR_TO_BTF_ID_OR_NULL		= PTR_MAYBE_NULL | PTR_TO_BTF_ID,
+	PTR_TO_MEM_OR_NULL		= PTR_MAYBE_NULL | PTR_TO_MEM,
+
 	/* This must be the last entry. Its purpose is to ensure the enum is
 	 * wide enough to hold the higher bits reserved for bpf_type_flag.
 	 */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6b9d23be1e99..4e3a1a6bf7d2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4941,10 +4941,13 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	/* check for PTR_TO_RDONLY_BUF_OR_NULL or PTR_TO_RDWR_BUF_OR_NULL */
 	for (i = 0; i < prog->aux->ctx_arg_info_size; i++) {
 		const struct bpf_ctx_arg_aux *ctx_arg_info = &prog->aux->ctx_arg_info[i];
+		u32 type, flag;
 
+		type = base_type(ctx_arg_info->reg_type);
+		flag = type_flag(ctx_arg_info->reg_type);
 		if (ctx_arg_info->offset == off &&
-		    (ctx_arg_info->reg_type == PTR_TO_RDONLY_BUF_OR_NULL ||
-		     ctx_arg_info->reg_type == PTR_TO_RDWR_BUF_OR_NULL)) {
+		    (type == PTR_TO_RDWR_BUF || type == PTR_TO_RDONLY_BUF) &&
+		    (flag & PTR_MAYBE_NULL)) {
 			info->reg_type = ctx_arg_info->reg_type;
 			return true;
 		}
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 6a9542af4212..631f0e44b7a9 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -174,9 +174,9 @@ static const struct bpf_iter_reg bpf_map_elem_reg_info = {
 	.ctx_arg_info_size	= 2,
 	.ctx_arg_info		= {
 		{ offsetof(struct bpf_iter__bpf_map_elem, key),
-		  PTR_TO_RDONLY_BUF_OR_NULL },
+		  PTR_TO_RDONLY_BUF | PTR_MAYBE_NULL },
 		{ offsetof(struct bpf_iter__bpf_map_elem, value),
-		  PTR_TO_RDWR_BUF_OR_NULL },
+		  PTR_TO_RDWR_BUF | PTR_MAYBE_NULL },
 	},
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 253de4a99ba5..7e55e783838d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -439,18 +439,6 @@ static bool reg_type_not_null(enum bpf_reg_type type)
 		type == PTR_TO_SOCK_COMMON;
 }
 
-static bool reg_type_may_be_null(enum bpf_reg_type type)
-{
-	return type == PTR_TO_MAP_VALUE_OR_NULL ||
-	       type == PTR_TO_SOCKET_OR_NULL ||
-	       type == PTR_TO_SOCK_COMMON_OR_NULL ||
-	       type == PTR_TO_TCP_SOCK_OR_NULL ||
-	       type == PTR_TO_BTF_ID_OR_NULL ||
-	       type == PTR_TO_MEM_OR_NULL ||
-	       type == PTR_TO_RDONLY_BUF_OR_NULL ||
-	       type == PTR_TO_RDWR_BUF_OR_NULL;
-}
-
 static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 {
 	return reg->type == PTR_TO_MAP_VALUE &&
@@ -459,12 +447,9 @@ static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 
 static bool reg_type_may_be_refcounted_or_null(enum bpf_reg_type type)
 {
-	return type == PTR_TO_SOCKET ||
-		type == PTR_TO_SOCKET_OR_NULL ||
-		type == PTR_TO_TCP_SOCK ||
-		type == PTR_TO_TCP_SOCK_OR_NULL ||
-		type == PTR_TO_MEM ||
-		type == PTR_TO_MEM_OR_NULL;
+	return base_type(type) == PTR_TO_SOCKET ||
+		base_type(type) == PTR_TO_TCP_SOCK ||
+		base_type(type) == PTR_TO_MEM;
 }
 
 static bool arg_type_may_be_refcounted(enum bpf_arg_type type)
@@ -535,38 +520,35 @@ static bool is_cmpxchg_insn(const struct bpf_insn *insn)
 }
 
 /* string representation of 'enum bpf_reg_type' */
-static const char * const reg_type_str[] = {
-	[NOT_INIT]		= "?",
-	[SCALAR_VALUE]		= "inv",
-	[PTR_TO_CTX]		= "ctx",
-	[CONST_PTR_TO_MAP]	= "map_ptr",
-	[PTR_TO_MAP_VALUE]	= "map_value",
-	[PTR_TO_MAP_VALUE_OR_NULL] = "map_value_or_null",
-	[PTR_TO_STACK]		= "fp",
-	[PTR_TO_PACKET]		= "pkt",
-	[PTR_TO_PACKET_META]	= "pkt_meta",
-	[PTR_TO_PACKET_END]	= "pkt_end",
-	[PTR_TO_FLOW_KEYS]	= "flow_keys",
-	[PTR_TO_SOCKET]		= "sock",
-	[PTR_TO_SOCKET_OR_NULL] = "sock_or_null",
-	[PTR_TO_SOCK_COMMON]	= "sock_common",
-	[PTR_TO_SOCK_COMMON_OR_NULL] = "sock_common_or_null",
-	[PTR_TO_TCP_SOCK]	= "tcp_sock",
-	[PTR_TO_TCP_SOCK_OR_NULL] = "tcp_sock_or_null",
-	[PTR_TO_TP_BUFFER]	= "tp_buffer",
-	[PTR_TO_XDP_SOCK]	= "xdp_sock",
-	[PTR_TO_BTF_ID]		= "ptr_",
-	[PTR_TO_BTF_ID_OR_NULL]	= "ptr_or_null_",
-	[PTR_TO_PERCPU_BTF_ID]	= "percpu_ptr_",
-	[PTR_TO_MEM]		= "mem",
-	[PTR_TO_MEM_OR_NULL]	= "mem_or_null",
-	[PTR_TO_RDONLY_BUF]	= "rdonly_buf",
-	[PTR_TO_RDONLY_BUF_OR_NULL] = "rdonly_buf_or_null",
-	[PTR_TO_RDWR_BUF]	= "rdwr_buf",
-	[PTR_TO_RDWR_BUF_OR_NULL] = "rdwr_buf_or_null",
-	[PTR_TO_FUNC]		= "func",
-	[PTR_TO_MAP_KEY]	= "map_key",
-};
+static const char *reg_type_str(enum bpf_reg_type type)
+{
+	static const char * const str[] = {
+		[NOT_INIT]		= "?",
+		[SCALAR_VALUE]		= "inv",
+		[PTR_TO_CTX]		= "ctx",
+		[CONST_PTR_TO_MAP]	= "map_ptr",
+		[PTR_TO_MAP_VALUE]	= "map_value",
+		[PTR_TO_STACK]		= "fp",
+		[PTR_TO_PACKET]		= "pkt",
+		[PTR_TO_PACKET_META]	= "pkt_meta",
+		[PTR_TO_PACKET_END]	= "pkt_end",
+		[PTR_TO_FLOW_KEYS]	= "flow_keys",
+		[PTR_TO_SOCKET]		= "sock",
+		[PTR_TO_SOCK_COMMON]	= "sock_common",
+		[PTR_TO_TCP_SOCK]	= "tcp_sock",
+		[PTR_TO_TP_BUFFER]	= "tp_buffer",
+		[PTR_TO_XDP_SOCK]	= "xdp_sock",
+		[PTR_TO_BTF_ID]		= "ptr_",
+		[PTR_TO_PERCPU_BTF_ID]	= "percpu_ptr_",
+		[PTR_TO_MEM]		= "mem",
+		[PTR_TO_RDONLY_BUF]	= "rdonly_buf",
+		[PTR_TO_RDWR_BUF]	= "rdwr_buf",
+		[PTR_TO_FUNC]		= "func",
+		[PTR_TO_MAP_KEY]	= "map_key",
+	};
+
+	return str[base_type(type)];
+}
 
 static char slot_type_char[] = {
 	[STACK_INVALID]	= '?',
@@ -631,7 +613,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 			continue;
 		verbose(env, " R%d", i);
 		print_liveness(env, reg->live);
-		verbose(env, "=%s", reg_type_str[t]);
+		verbose(env, "=%s", reg_type_str(t));
 		if (t == SCALAR_VALUE && reg->precise)
 			verbose(env, "P");
 		if ((t == SCALAR_VALUE || t == PTR_TO_STACK) &&
@@ -639,9 +621,8 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 			/* reg->off should be 0 for SCALAR_VALUE */
 			verbose(env, "%lld", reg->var_off.value + reg->off);
 		} else {
-			if (t == PTR_TO_BTF_ID ||
-			    t == PTR_TO_BTF_ID_OR_NULL ||
-			    t == PTR_TO_PERCPU_BTF_ID)
+			if (base_type(t) == PTR_TO_BTF_ID ||
+			    base_type(t) == PTR_TO_PERCPU_BTF_ID)
 				verbose(env, "%s", kernel_type_name(reg->btf, reg->btf_id));
 			verbose(env, "(id=%d", reg->id);
 			if (reg_type_may_be_refcounted_or_null(t))
@@ -650,10 +631,9 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 				verbose(env, ",off=%d", reg->off);
 			if (type_is_pkt_pointer(t))
 				verbose(env, ",r=%d", reg->range);
-			else if (t == CONST_PTR_TO_MAP ||
-				 t == PTR_TO_MAP_KEY ||
-				 t == PTR_TO_MAP_VALUE ||
-				 t == PTR_TO_MAP_VALUE_OR_NULL)
+			else if (base_type(t) == CONST_PTR_TO_MAP ||
+				 base_type(t) == PTR_TO_MAP_KEY ||
+				 base_type(t) == PTR_TO_MAP_VALUE)
 				verbose(env, ",ks=%d,vs=%d",
 					reg->map_ptr->key_size,
 					reg->map_ptr->value_size);
@@ -723,7 +703,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 		if (is_spilled_reg(&state->stack[i])) {
 			reg = &state->stack[i].spilled_ptr;
 			t = reg->type;
-			verbose(env, "=%s", reg_type_str[t]);
+			verbose(env, "=%s", reg_type_str(t));
 			if (t == SCALAR_VALUE && reg->precise)
 				verbose(env, "P");
 			if (t == SCALAR_VALUE && tnum_is_const(reg->var_off))
@@ -1136,8 +1116,7 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
 
 static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
 {
-	switch (reg->type) {
-	case PTR_TO_MAP_VALUE_OR_NULL: {
+	if (base_type(reg->type) == PTR_TO_MAP_VALUE) {
 		const struct bpf_map *map = reg->map_ptr;
 
 		if (map->inner_map_meta) {
@@ -1155,32 +1134,10 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
 		} else {
 			reg->type = PTR_TO_MAP_VALUE;
 		}
-		break;
-	}
-	case PTR_TO_SOCKET_OR_NULL:
-		reg->type = PTR_TO_SOCKET;
-		break;
-	case PTR_TO_SOCK_COMMON_OR_NULL:
-		reg->type = PTR_TO_SOCK_COMMON;
-		break;
-	case PTR_TO_TCP_SOCK_OR_NULL:
-		reg->type = PTR_TO_TCP_SOCK;
-		break;
-	case PTR_TO_BTF_ID_OR_NULL:
-		reg->type = PTR_TO_BTF_ID;
-		break;
-	case PTR_TO_MEM_OR_NULL:
-		reg->type = PTR_TO_MEM;
-		break;
-	case PTR_TO_RDONLY_BUF_OR_NULL:
-		reg->type = PTR_TO_RDONLY_BUF;
-		break;
-	case PTR_TO_RDWR_BUF_OR_NULL:
-		reg->type = PTR_TO_RDWR_BUF;
-		break;
-	default:
-		WARN_ONCE(1, "unknown nullable register type");
+		return;
 	}
+
+	reg->type &= ~PTR_MAYBE_NULL;
 }
 
 static bool reg_is_pkt_pointer(const struct bpf_reg_state *reg)
@@ -2035,7 +1992,7 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 			break;
 		if (parent->live & REG_LIVE_DONE) {
 			verbose(env, "verifier BUG type %s var_off %lld off %d\n",
-				reg_type_str[parent->type],
+				reg_type_str(parent->type),
 				parent->var_off.value, parent->off);
 			return -EFAULT;
 		}
@@ -2698,9 +2655,8 @@ static int mark_chain_precision_stack(struct bpf_verifier_env *env, int spi)
 
 static bool is_spillable_regtype(enum bpf_reg_type type)
 {
-	switch (type) {
+	switch (base_type(type)) {
 	case PTR_TO_MAP_VALUE:
-	case PTR_TO_MAP_VALUE_OR_NULL:
 	case PTR_TO_STACK:
 	case PTR_TO_CTX:
 	case PTR_TO_PACKET:
@@ -2709,21 +2665,14 @@ static bool is_spillable_regtype(enum bpf_reg_type type)
 	case PTR_TO_FLOW_KEYS:
 	case CONST_PTR_TO_MAP:
 	case PTR_TO_SOCKET:
-	case PTR_TO_SOCKET_OR_NULL:
 	case PTR_TO_SOCK_COMMON:
-	case PTR_TO_SOCK_COMMON_OR_NULL:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_TCP_SOCK_OR_NULL:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
-	case PTR_TO_BTF_ID_OR_NULL:
 	case PTR_TO_RDONLY_BUF:
-	case PTR_TO_RDONLY_BUF_OR_NULL:
 	case PTR_TO_RDWR_BUF:
-	case PTR_TO_RDWR_BUF_OR_NULL:
 	case PTR_TO_PERCPU_BTF_ID:
 	case PTR_TO_MEM:
-	case PTR_TO_MEM_OR_NULL:
 	case PTR_TO_FUNC:
 	case PTR_TO_MAP_KEY:
 		return true;
@@ -3564,7 +3513,7 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
 		 */
 		*reg_type = info.reg_type;
 
-		if (*reg_type == PTR_TO_BTF_ID || *reg_type == PTR_TO_BTF_ID_OR_NULL) {
+		if (base_type(*reg_type) == PTR_TO_BTF_ID) {
 			*btf = info.btf;
 			*btf_id = info.btf_id;
 		} else {
@@ -3632,7 +3581,7 @@ static int check_sock_access(struct bpf_verifier_env *env, int insn_idx,
 	}
 
 	verbose(env, "R%d invalid %s access off=%d size=%d\n",
-		regno, reg_type_str[reg->type], off, size);
+		regno, reg_type_str(reg->type), off, size);
 
 	return -EACCES;
 }
@@ -4382,7 +4331,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			} else {
 				mark_reg_known_zero(env, regs,
 						    value_regno);
-				if (reg_type_may_be_null(reg_type))
+				if (type_may_be_null(reg_type))
 					regs[value_regno].id = ++env->id_gen;
 				/* A load of ctx field could have different
 				 * actual load size with the one encoded in the
@@ -4390,8 +4339,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 				 * a sub-register.
 				 */
 				regs[value_regno].subreg_def = DEF_NOT_SUBREG;
-				if (reg_type == PTR_TO_BTF_ID ||
-				    reg_type == PTR_TO_BTF_ID_OR_NULL) {
+				if (base_type(reg_type) == PTR_TO_BTF_ID) {
 					regs[value_regno].btf = btf;
 					regs[value_regno].btf_id = btf_id;
 				}
@@ -4444,7 +4392,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	} else if (type_is_sk_pointer(reg->type)) {
 		if (t == BPF_WRITE) {
 			verbose(env, "R%d cannot write into %s\n",
-				regno, reg_type_str[reg->type]);
+				regno, reg_type_str(reg->type));
 			return -EACCES;
 		}
 		err = check_sock_access(env, insn_idx, regno, off, size, t);
@@ -4463,7 +4411,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	} else if (reg->type == PTR_TO_RDONLY_BUF) {
 		if (t == BPF_WRITE) {
 			verbose(env, "R%d cannot write into %s\n",
-				regno, reg_type_str[reg->type]);
+				regno, reg_type_str(reg->type));
 			return -EACCES;
 		}
 		err = check_buffer_access(env, reg, regno, off, size, false,
@@ -4479,7 +4427,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			mark_reg_unknown(env, regs, value_regno);
 	} else {
 		verbose(env, "R%d invalid mem access '%s'\n", regno,
-			reg_type_str[reg->type]);
+			reg_type_str(reg->type));
 		return -EACCES;
 	}
 
@@ -4546,7 +4494,7 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	    is_sk_reg(env, insn->dst_reg)) {
 		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
 			insn->dst_reg,
-			reg_type_str[reg_state(env, insn->dst_reg)->type]);
+			reg_type_str(reg_state(env, insn->dst_reg)->type));
 		return -EACCES;
 	}
 
@@ -4767,8 +4715,8 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 			return 0;
 
 		verbose(env, "R%d type=%s expected=%s\n", regno,
-			reg_type_str[reg->type],
-			reg_type_str[PTR_TO_STACK]);
+			reg_type_str(reg->type),
+			reg_type_str(PTR_TO_STACK));
 		return -EACCES;
 	}
 }
@@ -4779,7 +4727,7 @@ int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 	if (register_is_null(reg))
 		return 0;
 
-	if (reg_type_may_be_null(reg->type)) {
+	if (type_may_be_null(reg->type)) {
 		/* Assuming that the register contains a value check if the memory
 		 * access is safe. Temporarily save and restore the register's state as
 		 * the conversion shouldn't be visible to a caller.
@@ -5113,10 +5061,10 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			goto found;
 	}
 
-	verbose(env, "R%d type=%s expected=", regno, reg_type_str[type]);
+	verbose(env, "R%d type=%s expected=", regno, reg_type_str(type));
 	for (j = 0; j + 1 < i; j++)
-		verbose(env, "%s, ", reg_type_str[compatible->types[j]]);
-	verbose(env, "%s\n", reg_type_str[compatible->types[j]]);
+		verbose(env, "%s, ", reg_type_str(compatible->types[j]));
+	verbose(env, "%s\n", reg_type_str(compatible->types[j]));
 	return -EACCES;
 
 found:
@@ -6371,6 +6319,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 {
 	const struct bpf_func_proto *fn = NULL;
 	enum bpf_return_type ret_type;
+	enum bpf_type_flag ret_flag;
 	struct bpf_reg_state *regs;
 	struct bpf_call_arg_meta meta;
 	int insn_idx = *insn_idx_p;
@@ -6512,6 +6461,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	/* update return register (already marked as written above) */
 	ret_type = fn->ret_type;
+	ret_flag = type_flag(fn->ret_type);
 	if (ret_type == RET_INTEGER) {
 		/* sets type to SCALAR_VALUE */
 		mark_reg_unknown(env, regs, BPF_REG_0);
@@ -6531,25 +6481,23 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 		regs[BPF_REG_0].map_ptr = meta.map_ptr;
 		regs[BPF_REG_0].map_uid = meta.map_uid;
-		if (type_may_be_null(ret_type)) {
-			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
-		} else {
-			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE;
-			if (map_value_has_spin_lock(meta.map_ptr))
-				regs[BPF_REG_0].id = ++env->id_gen;
+		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE | ret_flag;
+		if (!type_may_be_null(ret_type) &&
+		    map_value_has_spin_lock(meta.map_ptr)) {
+			regs[BPF_REG_0].id = ++env->id_gen;
 		}
 	} else if (base_type(ret_type) == RET_PTR_TO_SOCKET) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
-		regs[BPF_REG_0].type = PTR_TO_SOCKET_OR_NULL;
+		regs[BPF_REG_0].type = PTR_TO_SOCKET | ret_flag;
 	} else if (base_type(ret_type) == RET_PTR_TO_SOCK_COMMON) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
-		regs[BPF_REG_0].type = PTR_TO_SOCK_COMMON_OR_NULL;
+		regs[BPF_REG_0].type = PTR_TO_SOCK_COMMON | ret_flag;
 	} else if (base_type(ret_type) == RET_PTR_TO_TCP_SOCK) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
-		regs[BPF_REG_0].type = PTR_TO_TCP_SOCK_OR_NULL;
+		regs[BPF_REG_0].type = PTR_TO_TCP_SOCK | ret_flag;
 	} else if (base_type(ret_type) == RET_PTR_TO_ALLOC_MEM) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
-		regs[BPF_REG_0].type = PTR_TO_MEM_OR_NULL;
+		regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
 		regs[BPF_REG_0].mem_size = meta.mem_size;
 	} else if (base_type(ret_type) == RET_PTR_TO_MEM_OR_BTF_ID) {
 		const struct btf_type *t;
@@ -6569,14 +6517,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 					tname, PTR_ERR(ret));
 				return -EINVAL;
 			}
-			regs[BPF_REG_0].type =
-				(ret_type & PTR_MAYBE_NULL) ?
-				PTR_TO_MEM_OR_NULL : PTR_TO_MEM;
+			regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
 			regs[BPF_REG_0].mem_size = tsize;
 		} else {
-			regs[BPF_REG_0].type =
-				(ret_type & PTR_MAYBE_NULL) ?
-				PTR_TO_BTF_ID_OR_NULL : PTR_TO_BTF_ID;
+			regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
 			regs[BPF_REG_0].btf = meta.ret_btf;
 			regs[BPF_REG_0].btf_id = meta.ret_btf_id;
 		}
@@ -6584,9 +6528,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		int ret_btf_id;
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
-		regs[BPF_REG_0].type = (ret_type & PTR_MAYBE_NULL) ?
-						     PTR_TO_BTF_ID_OR_NULL :
-						     PTR_TO_BTF_ID;
+		regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
 		ret_btf_id = *fn->ret_btf_id;
 		if (ret_btf_id == 0) {
 			verbose(env, "invalid return type %lu of func %s#%d\n",
@@ -6605,7 +6547,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return -EINVAL;
 	}
 
-	if (reg_type_may_be_null(regs[BPF_REG_0].type))
+	if (type_may_be_null(regs[BPF_REG_0].type))
 		regs[BPF_REG_0].id = ++env->id_gen;
 
 	if (is_ptr_cast_function(func_id)) {
@@ -6814,25 +6756,25 @@ static bool check_reg_sane_offset(struct bpf_verifier_env *env,
 
 	if (known && (val >= BPF_MAX_VAR_OFF || val <= -BPF_MAX_VAR_OFF)) {
 		verbose(env, "math between %s pointer and %lld is not allowed\n",
-			reg_type_str[type], val);
+			reg_type_str(type), val);
 		return false;
 	}
 
 	if (reg->off >= BPF_MAX_VAR_OFF || reg->off <= -BPF_MAX_VAR_OFF) {
 		verbose(env, "%s pointer offset %d is not allowed\n",
-			reg_type_str[type], reg->off);
+			reg_type_str(type), reg->off);
 		return false;
 	}
 
 	if (smin == S64_MIN) {
 		verbose(env, "math between %s pointer and register with unbounded min value is not allowed\n",
-			reg_type_str[type]);
+			reg_type_str(type));
 		return false;
 	}
 
 	if (smin >= BPF_MAX_VAR_OFF || smin <= -BPF_MAX_VAR_OFF) {
 		verbose(env, "value %lld makes %s pointer be out of bounds\n",
-			smin, reg_type_str[type]);
+			smin, reg_type_str(type));
 		return false;
 	}
 
@@ -7209,11 +7151,13 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	switch (ptr_reg->type) {
-	case PTR_TO_MAP_VALUE_OR_NULL:
+	if (ptr_reg->type == PTR_TO_MAP_VALUE_OR_NULL) {
 		verbose(env, "R%d pointer arithmetic on %s prohibited, null-check it first\n",
-			dst, reg_type_str[ptr_reg->type]);
+			dst, reg_type_str(ptr_reg->type));
 		return -EACCES;
+	}
+
+	switch (base_type(ptr_reg->type)) {
 	case CONST_PTR_TO_MAP:
 		/* smin_val represents the known value */
 		if (known && smin_val == 0 && opcode == BPF_ADD)
@@ -7221,14 +7165,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		fallthrough;
 	case PTR_TO_PACKET_END:
 	case PTR_TO_SOCKET:
-	case PTR_TO_SOCKET_OR_NULL:
 	case PTR_TO_SOCK_COMMON:
-	case PTR_TO_SOCK_COMMON_OR_NULL:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_TCP_SOCK_OR_NULL:
 	case PTR_TO_XDP_SOCK:
 		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
-			dst, reg_type_str[ptr_reg->type]);
+			dst, reg_type_str(ptr_reg->type));
 		return -EACCES;
 	default:
 		break;
@@ -8947,7 +8888,7 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 				 struct bpf_reg_state *reg, u32 id,
 				 bool is_null)
 {
-	if (reg_type_may_be_null(reg->type) && reg->id == id &&
+	if (type_may_be_null(reg->type) && reg->id == id &&
 	    !WARN_ON_ONCE(!reg->id)) {
 		/* Old offset (both fixed and variable parts) should
 		 * have been known-zero, because we don't allow pointer
@@ -9325,7 +9266,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	 */
 	if (!is_jmp32 && BPF_SRC(insn->code) == BPF_K &&
 	    insn->imm == 0 && (opcode == BPF_JEQ || opcode == BPF_JNE) &&
-	    reg_type_may_be_null(dst_reg->type)) {
+	    type_may_be_null(dst_reg->type)) {
 		/* Mark all identical registers in each branch as either
 		 * safe or unknown depending R == 0 or R != 0 conditional.
 		 */
@@ -9579,7 +9520,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 		/* enforce return zero from async callbacks like timer */
 		if (reg->type != SCALAR_VALUE) {
 			verbose(env, "In async callback the register R0 is not a known value (%s)\n",
-				reg_type_str[reg->type]);
+				reg_type_str(reg->type));
 			return -EINVAL;
 		}
 
@@ -9593,7 +9534,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 	if (is_subprog) {
 		if (reg->type != SCALAR_VALUE) {
 			verbose(env, "At subprogram exit the register R0 is not a scalar value (%s)\n",
-				reg_type_str[reg->type]);
+				reg_type_str(reg->type));
 			return -EINVAL;
 		}
 		return 0;
@@ -9657,7 +9598,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 
 	if (reg->type != SCALAR_VALUE) {
 		verbose(env, "At program exit the register R0 is not a known value (%s)\n",
-			reg_type_str[reg->type]);
+			reg_type_str(reg->type));
 		return -EINVAL;
 	}
 
@@ -10438,7 +10379,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		return true;
 	if (rcur->type == NOT_INIT)
 		return false;
-	switch (rold->type) {
+	switch (base_type(rold->type)) {
 	case SCALAR_VALUE:
 		if (env->explore_alu_limits)
 			return false;
@@ -10460,6 +10401,22 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		}
 	case PTR_TO_MAP_KEY:
 	case PTR_TO_MAP_VALUE:
+		/* a PTR_TO_MAP_VALUE could be safe to use as a
+		 * PTR_TO_MAP_VALUE_OR_NULL into the same map.
+		 * However, if the old PTR_TO_MAP_VALUE_OR_NULL then got NULL-
+		 * checked, doing so could have affected others with the same
+		 * id, and we can't check for that because we lost the id when
+		 * we converted to a PTR_TO_MAP_VALUE.
+		 */
+		if (type_may_be_null(rold->type)) {
+			if (!type_may_be_null(rcur->type))
+				return false;
+			if (memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)))
+				return false;
+			/* Check our ids match any regs they're supposed to */
+			return check_ids(rold->id, rcur->id, idmap);
+		}
+
 		/* If the new min/max/var_off satisfy the old ones and
 		 * everything else matches, we are OK.
 		 * 'id' is not compared, since it's only used for maps with
@@ -10471,20 +10428,6 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 		       range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off);
-	case PTR_TO_MAP_VALUE_OR_NULL:
-		/* a PTR_TO_MAP_VALUE could be safe to use as a
-		 * PTR_TO_MAP_VALUE_OR_NULL into the same map.
-		 * However, if the old PTR_TO_MAP_VALUE_OR_NULL then got NULL-
-		 * checked, doing so could have affected others with the same
-		 * id, and we can't check for that because we lost the id when
-		 * we converted to a PTR_TO_MAP_VALUE.
-		 */
-		if (rcur->type != PTR_TO_MAP_VALUE_OR_NULL)
-			return false;
-		if (memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)))
-			return false;
-		/* Check our ids match any regs they're supposed to */
-		return check_ids(rold->id, rcur->id, idmap);
 	case PTR_TO_PACKET_META:
 	case PTR_TO_PACKET:
 		if (rcur->type != rold->type)
@@ -10513,11 +10456,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 	case PTR_TO_PACKET_END:
 	case PTR_TO_FLOW_KEYS:
 	case PTR_TO_SOCKET:
-	case PTR_TO_SOCKET_OR_NULL:
 	case PTR_TO_SOCK_COMMON:
-	case PTR_TO_SOCK_COMMON_OR_NULL:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_TCP_SOCK_OR_NULL:
 	case PTR_TO_XDP_SOCK:
 		/* Only valid matches are exact, which memcmp() above
 		 * would have accepted
@@ -11043,17 +10983,13 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 /* Return true if it's OK to have the same insn return a different type. */
 static bool reg_type_mismatch_ok(enum bpf_reg_type type)
 {
-	switch (type) {
+	switch (base_type(type)) {
 	case PTR_TO_CTX:
 	case PTR_TO_SOCKET:
-	case PTR_TO_SOCKET_OR_NULL:
 	case PTR_TO_SOCK_COMMON:
-	case PTR_TO_SOCK_COMMON_OR_NULL:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_TCP_SOCK_OR_NULL:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
-	case PTR_TO_BTF_ID_OR_NULL:
 		return false;
 	default:
 		return true;
@@ -11277,7 +11213,7 @@ static int do_check(struct bpf_verifier_env *env)
 			if (is_ctx_reg(env, insn->dst_reg)) {
 				verbose(env, "BPF_ST stores into R%d %s is not allowed\n",
 					insn->dst_reg,
-					reg_type_str[reg_state(env, insn->dst_reg)->type]);
+					reg_type_str(reg_state(env, insn->dst_reg)->type));
 				return -EACCES;
 			}
 
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 68d2cbf8331a..4cb5ef8eddbc 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -929,7 +929,7 @@ static struct bpf_iter_reg bpf_sk_storage_map_reg_info = {
 		{ offsetof(struct bpf_iter__bpf_sk_storage_map, sk),
 		  PTR_TO_BTF_ID_OR_NULL },
 		{ offsetof(struct bpf_iter__bpf_sk_storage_map, value),
-		  PTR_TO_RDWR_BUF_OR_NULL },
+		  PTR_TO_RDWR_BUF | PTR_MAYBE_NULL },
 	},
 	.seq_info		= &iter_seq_info,
 };
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index f39ef79ced67..8b2632be3771 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1559,7 +1559,7 @@ static struct bpf_iter_reg sock_map_iter_reg = {
 	.ctx_arg_info_size	= 2,
 	.ctx_arg_info		= {
 		{ offsetof(struct bpf_iter__sockmap, key),
-		  PTR_TO_RDONLY_BUF_OR_NULL },
+		  PTR_TO_RDONLY_BUF | PTR_MAYBE_NULL },
 		{ offsetof(struct bpf_iter__sockmap, sk),
 		  PTR_TO_BTF_ID_OR_NULL },
 	},
-- 
2.34.1.400.ga245620fadb-goog

