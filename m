Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBFB25D72B
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 13:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgIDL1T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 07:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbgIDL01 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 07:26:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7E6C0619C9
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 04:24:27 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so6334495wrs.11
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 04:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JqaHMp9F5knJnlUKGdFXE/JSaVFbob0Mhs7o6M9E2z8=;
        b=n3/x74AeScH7iu2PzPIE5BhVRoR2Y3qQKcFwWnMVroYUf/KmqEVd7JvvXcgY/ZrOQx
         EVfrdEFpnw82tps9UcFEcGS8Zu1BEzBaplt2xWJyl0gEEMSce06MvSJz/6iSkEYkuGk+
         YwlXBmGcmxpMkweKUNvyOrcybYz0GXmX97Nfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JqaHMp9F5knJnlUKGdFXE/JSaVFbob0Mhs7o6M9E2z8=;
        b=Xl6cayoaTbDyA5lKvJSirJjMec0eBLFJwR56UlXl7u/bPFQuPIiVaIZ1m7GpiRux2C
         g8vjXd2DOLzJK4sCVEPUiDXm7vyguu2B9vBnTgxcLWjVAzjL09dGhgL8QNqeWLR/uTou
         0jS6LFA0xYlh/KATZGuDgTEbEyB5buOxIqjyxSaxnKlq1ahBXbHZ7W6KSwr1klhxJTwe
         jDAZlT4JBHZVUPvD1xdNcGlhiaHUtrLSVISgLYJyhAidjpM+6Q2hX7DF71miRIbHPyo/
         n/ykPl6xMrAWmsuAoKP93EnmnVBaR7GTlJIaH4uU5+jVgreqdnceldJ6eNNTvgI1VxPy
         4CEw==
X-Gm-Message-State: AOAM533ms1hD4jEMr/EUwgIOjNHCa9mDBIMTxOt72rmJjpalYbYkl3bY
        d0rVYQ22Wron0z0tflMdpuLEfQ==
X-Google-Smtp-Source: ABdhPJxRMGTH6v3cOAD5kiSeuckVp2qhR+FDRWGGODbinSe4AAQmJPYVfOUNaqpLjLtJQp2QFhSqYA==
X-Received: by 2002:adf:8b48:: with SMTP id v8mr7121617wra.21.1599218666217;
        Fri, 04 Sep 2020 04:24:26 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id v2sm9104408wrm.16.2020.09.04.04.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 04:24:25 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 11/11] bpf: use a table to drive helper arg type checks
Date:   Fri,  4 Sep 2020 12:24:01 +0100
Message-Id: <20200904112401.667645-12-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904112401.667645-1-lmb@cloudflare.com>
References: <20200904112401.667645-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The mapping between bpf_arg_type and bpf_reg_type is encoded in a big
hairy if statement that is hard to follow. The debug output also leaves
to be desired: if a reg_type doesn't match we only print one of the
options, instead printing all the valid ones.

Convert the if statement into a table which is then used to drive type
checking. If none of the reg_types match we print all options, e.g.:

    R2 type=rdonly_buf expected=[fp, pkt, pkt_meta, map_value]

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/linux/bpf.h   |   1 +
 kernel/bpf/verifier.c | 193 +++++++++++++++++++++++++-----------------
 2 files changed, 117 insertions(+), 77 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 36276e78dc75..ff52f22cedf7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -293,6 +293,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_ALLOC_MEM,	/* pointer to dynamically allocated memory */
 	ARG_PTR_TO_ALLOC_MEM_OR_NULL,	/* pointer to dynamically allocated memory or NULL */
 	ARG_CONST_ALLOC_SIZE_OR_ZERO,	/* number of allocated bytes requested */
+	__ARG_TYPE_MAX,
 };
 
 /* type of values returned from helper functions */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f124551c316a..5c61a378c805 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3856,12 +3856,6 @@ static bool arg_type_is_mem_size(enum bpf_arg_type type)
 	       type == ARG_CONST_SIZE_OR_ZERO;
 }
 
-static bool arg_type_is_alloc_mem_ptr(enum bpf_arg_type type)
-{
-	return type == ARG_PTR_TO_ALLOC_MEM ||
-	       type == ARG_PTR_TO_ALLOC_MEM_OR_NULL;
-}
-
 static bool arg_type_is_alloc_size(enum bpf_arg_type type)
 {
 	return type == ARG_CONST_ALLOC_SIZE_OR_ZERO;
@@ -3914,15 +3908,120 @@ BTF_SET_START(btf_fullsock_ids)
 BTF_ID(struct, sock)
 BTF_SET_END(btf_fullsock_ids)
 
+struct bpf_reg_types {
+	const enum bpf_reg_type types[10];
+	const struct btf_id_set *btf_ids;
+};
+
+static const struct bpf_reg_types map_key_value_types = {
+	.types = {
+		PTR_TO_STACK,
+		PTR_TO_PACKET,
+		PTR_TO_PACKET_META,
+		PTR_TO_MAP_VALUE,
+	},
+};
+
+static const struct bpf_reg_types sock_types = {
+	.types = {
+		PTR_TO_SOCK_COMMON,
+		PTR_TO_SOCKET,
+		PTR_TO_TCP_SOCK,
+		PTR_TO_XDP_SOCK,
+	},
+};
+
+static const struct bpf_reg_types mem_types = {
+	.types = {
+		PTR_TO_STACK,
+		PTR_TO_PACKET,
+		PTR_TO_PACKET_META,
+		PTR_TO_MAP_VALUE,
+		PTR_TO_MEM,
+		PTR_TO_RDONLY_BUF,
+		PTR_TO_RDWR_BUF,
+	},
+};
+
+static const struct bpf_reg_types int_ptr_types = {
+	.types = {
+		PTR_TO_STACK,
+		PTR_TO_PACKET,
+		PTR_TO_PACKET_META,
+		PTR_TO_MAP_VALUE,
+	},
+};
+
+static const struct bpf_reg_types fullsock_types = {
+	.types = { PTR_TO_SOCKET, PTR_TO_BTF_ID },
+	.btf_ids = &btf_fullsock_ids,
+};
+
+static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
+static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
+static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM } };
+static const struct bpf_reg_types const_map_ptr_types = { .types = {CONST_PTR_TO_MAP } };
+static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
+static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
+
+static const struct bpf_reg_types *compatible_reg_types[] = {
+	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
+	[ARG_PTR_TO_MAP_VALUE]		= &map_key_value_types,
+	[ARG_PTR_TO_UNINIT_MAP_VALUE]	= &map_key_value_types,
+	[ARG_PTR_TO_MAP_VALUE_OR_NULL]	= &map_key_value_types,
+	[ARG_CONST_SIZE]		= &scalar_types,
+	[ARG_CONST_SIZE_OR_ZERO]	= &scalar_types,
+	[ARG_CONST_ALLOC_SIZE_OR_ZERO]	= &scalar_types,
+	[ARG_CONST_MAP_PTR]		= &const_map_ptr_types,
+	[ARG_PTR_TO_CTX]		= &context_types,
+	[ARG_PTR_TO_CTX_OR_NULL]	= &context_types,
+	[ARG_PTR_TO_SOCK_COMMON]	= &sock_types,
+	[ARG_PTR_TO_SOCKET]		= &fullsock_types,
+	[ARG_PTR_TO_SOCKET_OR_NULL]	= &fullsock_types,
+	[ARG_PTR_TO_BTF_ID]		= &btf_ptr_types,
+	[ARG_PTR_TO_SPIN_LOCK]		= &spin_lock_types,
+	[ARG_PTR_TO_MEM]		= &mem_types,
+	[ARG_PTR_TO_MEM_OR_NULL]	= &mem_types,
+	[ARG_PTR_TO_UNINIT_MEM]		= &mem_types,
+	[ARG_PTR_TO_ALLOC_MEM]		= &alloc_mem_types,
+	[ARG_PTR_TO_ALLOC_MEM_OR_NULL]	= &alloc_mem_types,
+	[ARG_PTR_TO_INT]		= &int_ptr_types,
+	[ARG_PTR_TO_LONG]		= &int_ptr_types,
+	[__ARG_TYPE_MAX]		= NULL,
+};
+
+static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
+			  const struct bpf_reg_types *compatible)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	enum bpf_reg_type expected, type = reg->type;
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(compatible->types); i++) {
+		expected = compatible->types[i];
+		if (expected == NOT_INIT)
+			break;
+
+		if (type == expected)
+			return 0;
+	}
+
+	verbose(env, "R%d type=%s expected=[", regno, reg_type_str[type]);
+	for (j = 0; j + 1 < i; j++)
+		verbose(env, "%s, ", reg_type_str[compatible->types[j]]);
+	verbose(env, "%s]\n", reg_type_str[compatible->types[j]]);
+	return -EACCES;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn)
 {
 	u32 regno = BPF_REG_1 + arg;
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
-	enum bpf_reg_type expected_type, type = reg->type;
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
-	const struct btf_id_set *btf_ids = NULL;
+	const struct bpf_reg_types *compatible;
+	enum bpf_reg_type type = reg->type;
 	int err = 0;
 
 	if (arg_type == ARG_DONTCARE)
@@ -3961,75 +4060,19 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 */
 		goto skip_type_check;
 
-	if (arg_type == ARG_PTR_TO_MAP_KEY ||
-	    arg_type == ARG_PTR_TO_MAP_VALUE ||
-	    arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
-	    arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
-		expected_type = PTR_TO_STACK;
-		if (!type_is_pkt_pointer(type) &&
-		    type != PTR_TO_MAP_VALUE &&
-		    type != expected_type)
-			goto err_type;
-	} else if (arg_type == ARG_CONST_SIZE ||
-		   arg_type == ARG_CONST_SIZE_OR_ZERO ||
-		   arg_type == ARG_CONST_ALLOC_SIZE_OR_ZERO) {
-		expected_type = SCALAR_VALUE;
-		if (type != expected_type)
-			goto err_type;
-	} else if (arg_type == ARG_CONST_MAP_PTR) {
-		expected_type = CONST_PTR_TO_MAP;
-		if (type != expected_type)
-			goto err_type;
-	} else if (arg_type == ARG_PTR_TO_CTX ||
-		   arg_type == ARG_PTR_TO_CTX_OR_NULL) {
-		expected_type = PTR_TO_CTX;
-		if (type != expected_type)
-			goto err_type;
-	} else if (arg_type == ARG_PTR_TO_SOCK_COMMON) {
-		expected_type = PTR_TO_SOCK_COMMON;
-		/* Any sk pointer can be ARG_PTR_TO_SOCK_COMMON */
-		if (!type_is_sk_pointer(type))
-			goto err_type;
-	} else if (arg_type == ARG_PTR_TO_SOCKET ||
-		   arg_type == ARG_PTR_TO_SOCKET_OR_NULL) {
-		expected_type = PTR_TO_SOCKET;
-		if (type != expected_type &&
-			type != PTR_TO_BTF_ID)
-			goto err_type;
-		btf_ids = &btf_fullsock_ids;
-	} else if (arg_type == ARG_PTR_TO_BTF_ID) {
-		expected_type = PTR_TO_BTF_ID;
-		if (type != expected_type)
-			goto err_type;
-	} else if (arg_type == ARG_PTR_TO_SPIN_LOCK) {
-		expected_type = PTR_TO_MAP_VALUE;
-		if (type != expected_type)
-			goto err_type;
-	} else if (arg_type_is_mem_ptr(arg_type)) {
-		expected_type = PTR_TO_STACK;
-		if (!type_is_pkt_pointer(type) &&
-		    type != PTR_TO_MAP_VALUE &&
-		    type != PTR_TO_MEM &&
-		    type != PTR_TO_RDONLY_BUF &&
-		    type != PTR_TO_RDWR_BUF &&
-		    type != expected_type)
-			goto err_type;
-	} else if (arg_type_is_alloc_mem_ptr(arg_type)) {
-		expected_type = PTR_TO_MEM;
-		if (type != expected_type)
-			goto err_type;
-	} else if (arg_type_is_int_ptr(arg_type)) {
-		expected_type = PTR_TO_STACK;
-		if (!type_is_pkt_pointer(type) &&
-		    type != PTR_TO_MAP_VALUE &&
-		    type != expected_type)
-			goto err_type;
-	} else {
-		verbose(env, "unsupported arg_type %d\n", arg_type);
+	compatible = compatible_reg_types[arg_type];
+	if (!compatible) {
+		verbose(env, "verifier internal error: unsupported arg type %d\n", arg_type);
 		return -EFAULT;
 	}
 
+	err = check_reg_type(env, regno, compatible);
+	if (err)
+		return err;
+
 	if (type == PTR_TO_BTF_ID) {
+		const struct btf_id_set *btf_ids = compatible->btf_ids;
+
 		if (fn->arg_btf_ids[arg])
 			btf_ids = fn->arg_btf_ids[arg];
 
@@ -4185,10 +4228,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	}
 
 	return err;
-err_type:
-	verbose(env, "R%d type=%s expected=%s\n", regno,
-		reg_type_str[type], reg_type_str[expected_type]);
-	return -EACCES;
 }
 
 static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
-- 
2.25.1

