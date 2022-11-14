Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110AF628907
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbiKNTQ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbiKNTQS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:16:18 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8F327CDB
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:13 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so11646559pjl.3
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x03vizVK0BDArb4SMVvzX4tl/M5tTj6rRG7Qo5Aazu0=;
        b=RQOZrZE/OZ+NEx/yGfNp81uWY8o/5rHLhAYOkkgZxDxSjDuTaFW41N3gFzVH5n5Y9a
         OsrxtT1LTWfeH3HXrIsiSx4mvh2jzDf7a5jjDi2d5wNaRrTxQNcp3/pe69xmYQEawNbI
         AgBLGLEXvKn7vdPwu6babmecWbOA/ZwN5+Y2Qz555cNhu3uL4NY9VeT/MfLyqB+zy+hq
         bi91WURD65aayvIRa1ckdCWQ0m6T1dq0lpdriSFVvd9/H3ylx6iG5FuURRpvMRt4f5Yk
         dsIUeoKz7aZWBprrlqJU6PxKjJpW9yPuSjtzFY3wVOO0gJ03g1QgAzNChQ6GgJlZpI7c
         OcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x03vizVK0BDArb4SMVvzX4tl/M5tTj6rRG7Qo5Aazu0=;
        b=rDO2fur6COZ/U1b0Ofu1hBOm0UjVf/YBykKN/5M95t7GXwn5m+acs2Y+dXgTf9Fkfr
         sC7beGQLs1dyn+0tK8zidgnxO8OlA3Yl8FWrfvkaZ+uEV/OrNgbDNu5lfPMhCGaUdRTA
         Cn+3R/gzL4Ee1l/woXLdnINc2EjHtHoj524UmoCwia58cZzvGTc1I9N9+neupYENUDDm
         CYGKAIkJ+fL585V0iD+tLuUa919iCl+VQAHxMQYnK0+X9OfA+KbgLG7ejfeo2jzaF4/F
         prB//T7h7xzW0mWaAzVpwxhXNQmx6E41quo6QAW4Bk8dOsx0JjaFYjKvxVnRk9Ly4AW1
         DRlA==
X-Gm-Message-State: ANoB5pktbcLp/v8NkRcip/VjCM7t1cbUNX3u/zQ64C0JrlbTBDNcWjyc
        7SKsp51L87AlkuOAgOxZc5DFNp3UyhNJQw==
X-Google-Smtp-Source: AA0mqf5GzN3XBPcsH4ENTaCLUTM3VmPL4UIL1MtA5G3PlN9MmXgBu981tULwOc135FJh3XXZxkYc8A==
X-Received: by 2002:a17:902:9f97:b0:186:de87:7ffd with SMTP id g23-20020a1709029f9700b00186de877ffdmr579598plq.94.1668453373198;
        Mon, 14 Nov 2022 11:16:13 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b00186727e5f5csm7900083plh.248.2022.11.14.11.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:16:12 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 07/26] bpf: Refactor btf_struct_access
Date:   Tue, 15 Nov 2022 00:45:28 +0530
Message-Id: <20221114191547.1694267-8-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12746; i=memxor@gmail.com; h=from:subject; bh=ZQSBi2SUjzUwh5VlOA5tnWKvkKqR/kwB1k+0YEpN5qQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPIbaid2b7h0ZuVZskIxcbw00s5zbZBj4fCsdfd F9ewLTCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTyAAKCRBM4MiGSL8RyqfeD/ 4/EB7w24AsbF134PA21AqdBogaIAkMq2EX4ZlM1vlYGpnYSHAvZtQ7MCrjS8Z8mS1ERUpLtD55OVXm iHZOAsWemJs2ZLqwY7K9t8burRcCINzIw+hKC2oEIBoNzqjaCU0Ec2BcVSvf4uxrK3iOYCYknGhmwD 06W1I+vC45Yswm1K2BIaU6nEUCoCzcI2KO1zleoNYo/hpG7GU99utki6POw4QWg6PfsmN4F1f4ekC4 Q33q6qoH8g58iWeDenUqQA0szr3WTEcKNyQzLaNlrGBLUTLST5j1LXzyqfjILDxZqtyZ4JmezLFq3a OskH4uiSjrSpepbvyzkU+hO9l/fe3I9a6BU+Pe0Iu0HWk1dgUnrLjvbzT+UPMx35peMrvmHoL8T2rc OTbS0U8i0FdlWlZ/4bS8uf5tWcSSjCHLQgqVu0cq1NvfikqEai18oRZ82BIX3fw/scKbKXOVBNlGx+ QMp8pcCMKdAENsNBkitxXPgYu6gq5zErqlWAgEYUnYJYWnR5EI4JwGa0uYkv78dOThBUBB7KY2P4Mo f6JizUKHJD5XFgDTm/K4E+NWQQl2V9At1mpFk+H7PiWohv5mpgB57oyLWIhR3tV4FqjbzJydjUeyfj DNDem2BE7TXvNqwpwzocD0JAxrspoLFb69Rb3q4yw1ueTa6HMuwRXMfHAj2Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of having to pass multiple arguments that describe the register,
pass the bpf_reg_state into the btf_struct_access callback. Currently,
all call sites simply reuse the btf and btf_id of the reg they want to
check the access of. The only exception to this pattern is the callsite
in check_ptr_to_map_access, hence for that case create a dummy reg to
simulate PTR_TO_BTF_ID access.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h              | 17 ++++++++--------
 include/linux/filter.h           |  8 ++++----
 kernel/bpf/btf.c                 | 11 +++++++----
 kernel/bpf/verifier.c            | 12 ++++++-----
 net/bpf/bpf_dummy_struct_ops.c   | 14 ++++++-------
 net/core/filter.c                | 34 +++++++++++++-------------------
 net/ipv4/bpf_tcp_ca.c            | 13 ++++++------
 net/netfilter/nf_conntrack_bpf.c | 17 +++++++---------
 8 files changed, 60 insertions(+), 66 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index afc1c51b59ff..49f9d2bec401 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -771,6 +771,7 @@ struct bpf_prog_ops {
 			union bpf_attr __user *uattr);
 };
 
+struct bpf_reg_state;
 struct bpf_verifier_ops {
 	/* return eBPF function prototype for verification */
 	const struct bpf_func_proto *
@@ -792,9 +793,8 @@ struct bpf_verifier_ops {
 				  struct bpf_insn *dst,
 				  struct bpf_prog *prog, u32 *target_size);
 	int (*btf_struct_access)(struct bpf_verifier_log *log,
-				 const struct btf *btf,
-				 const struct btf_type *t, int off, int size,
-				 enum bpf_access_type atype,
+				 const struct bpf_reg_state *reg,
+				 int off, int size, enum bpf_access_type atype,
 				 u32 *next_btf_id, enum bpf_type_flag *flag);
 };
 
@@ -2080,9 +2080,9 @@ static inline bool bpf_tracing_btf_ctx_access(int off, int size,
 	return btf_ctx_access(off, size, type, prog, info);
 }
 
-int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
-		      const struct btf_type *t, int off, int size,
-		      enum bpf_access_type atype,
+int btf_struct_access(struct bpf_verifier_log *log,
+		      const struct bpf_reg_state *reg,
+		      int off, int size, enum bpf_access_type atype,
 		      u32 *next_btf_id, enum bpf_type_flag *flag);
 bool btf_struct_ids_match(struct bpf_verifier_log *log,
 			  const struct btf *btf, u32 id, int off,
@@ -2333,9 +2333,8 @@ static inline struct bpf_prog *bpf_prog_by_id(u32 id)
 }
 
 static inline int btf_struct_access(struct bpf_verifier_log *log,
-				    const struct btf *btf,
-				    const struct btf_type *t, int off, int size,
-				    enum bpf_access_type atype,
+				    const struct bpf_reg_state *reg,
+				    int off, int size, enum bpf_access_type atype,
 				    u32 *next_btf_id, enum bpf_type_flag *flag)
 {
 	return -EACCES;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index efc42a6e3aed..787d35dbf5b0 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -568,10 +568,10 @@ struct sk_filter {
 DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 
 extern struct mutex nf_conn_btf_access_lock;
-extern int (*nfct_btf_struct_access)(struct bpf_verifier_log *log, const struct btf *btf,
-				     const struct btf_type *t, int off, int size,
-				     enum bpf_access_type atype, u32 *next_btf_id,
-				     enum bpf_type_flag *flag);
+extern int (*nfct_btf_struct_access)(struct bpf_verifier_log *log,
+				     const struct bpf_reg_state *reg,
+				     int off, int size, enum bpf_access_type atype,
+				     u32 *next_btf_id, enum bpf_type_flag *flag);
 
 typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
 					  const struct bpf_insn *insnsi,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c0d73d71c539..875355ff3718 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6017,15 +6017,18 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 	return -EINVAL;
 }
 
-int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
-		      const struct btf_type *t, int off, int size,
-		      enum bpf_access_type atype __maybe_unused,
+int btf_struct_access(struct bpf_verifier_log *log,
+		      const struct bpf_reg_state *reg,
+		      int off, int size, enum bpf_access_type atype __maybe_unused,
 		      u32 *next_btf_id, enum bpf_type_flag *flag)
 {
+	const struct btf *btf = reg->btf;
 	enum bpf_type_flag tmp_flag = 0;
+	const struct btf_type *t;
+	u32 id = reg->btf_id;
 	int err;
-	u32 id;
 
+	t = btf_type_by_id(btf, id);
 	do {
 		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c588e5483540..5e74f460dfd0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4688,16 +4688,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	}
 
 	if (env->ops->btf_struct_access) {
-		ret = env->ops->btf_struct_access(&env->log, reg->btf, t,
-						  off, size, atype, &btf_id, &flag);
+		ret = env->ops->btf_struct_access(&env->log, reg, off, size, atype, &btf_id, &flag);
 	} else {
 		if (atype != BPF_READ) {
 			verbose(env, "only read is supported\n");
 			return -EACCES;
 		}
 
-		ret = btf_struct_access(&env->log, reg->btf, t, off, size,
-					atype, &btf_id, &flag);
+		ret = btf_struct_access(&env->log, reg, off, size, atype, &btf_id, &flag);
 	}
 
 	if (ret < 0)
@@ -4723,6 +4721,7 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 {
 	struct bpf_reg_state *reg = regs + regno;
 	struct bpf_map *map = reg->map_ptr;
+	struct bpf_reg_state map_reg;
 	enum bpf_type_flag flag = 0;
 	const struct btf_type *t;
 	const char *tname;
@@ -4761,7 +4760,10 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	ret = btf_struct_access(&env->log, btf_vmlinux, t, off, size, atype, &btf_id, &flag);
+	/* Simulate access to a PTR_TO_BTF_ID */
+	memset(&map_reg, 0, sizeof(map_reg));
+	mark_btf_ld_reg(env, &map_reg, 0, PTR_TO_BTF_ID, btf_vmlinux, *map->ops->map_btf_id, 0);
+	ret = btf_struct_access(&env->log, &map_reg, off, size, atype, &btf_id, &flag);
 	if (ret < 0)
 		return ret;
 
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index e78dadfc5829..2d434c1f4617 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -156,29 +156,29 @@ static bool bpf_dummy_ops_is_valid_access(int off, int size,
 }
 
 static int bpf_dummy_ops_btf_struct_access(struct bpf_verifier_log *log,
-					   const struct btf *btf,
-					   const struct btf_type *t, int off,
-					   int size, enum bpf_access_type atype,
+					   const struct bpf_reg_state *reg,
+					   int off, int size, enum bpf_access_type atype,
 					   u32 *next_btf_id,
 					   enum bpf_type_flag *flag)
 {
 	const struct btf_type *state;
+	const struct btf_type *t;
 	s32 type_id;
 	int err;
 
-	type_id = btf_find_by_name_kind(btf, "bpf_dummy_ops_state",
+	type_id = btf_find_by_name_kind(reg->btf, "bpf_dummy_ops_state",
 					BTF_KIND_STRUCT);
 	if (type_id < 0)
 		return -EINVAL;
 
-	state = btf_type_by_id(btf, type_id);
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+	state = btf_type_by_id(reg->btf, type_id);
 	if (t != state) {
 		bpf_log(log, "only access to bpf_dummy_ops_state is supported\n");
 		return -EACCES;
 	}
 
-	err = btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
-				flag);
+	err = btf_struct_access(log, reg, off, size, atype, next_btf_id, flag);
 	if (err < 0)
 		return err;
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 6dd2baf5eeb2..37fad5a9b752 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8651,28 +8651,25 @@ static bool tc_cls_act_is_valid_access(int off, int size,
 DEFINE_MUTEX(nf_conn_btf_access_lock);
 EXPORT_SYMBOL_GPL(nf_conn_btf_access_lock);
 
-int (*nfct_btf_struct_access)(struct bpf_verifier_log *log, const struct btf *btf,
-			      const struct btf_type *t, int off, int size,
-			      enum bpf_access_type atype, u32 *next_btf_id,
-			      enum bpf_type_flag *flag);
+int (*nfct_btf_struct_access)(struct bpf_verifier_log *log,
+			      const struct bpf_reg_state *reg,
+			      int off, int size, enum bpf_access_type atype,
+			      u32 *next_btf_id, enum bpf_type_flag *flag);
 EXPORT_SYMBOL_GPL(nfct_btf_struct_access);
 
 static int tc_cls_act_btf_struct_access(struct bpf_verifier_log *log,
-					const struct btf *btf,
-					const struct btf_type *t, int off,
-					int size, enum bpf_access_type atype,
-					u32 *next_btf_id,
-					enum bpf_type_flag *flag)
+					const struct bpf_reg_state *reg,
+					int off, int size, enum bpf_access_type atype,
+					u32 *next_btf_id, enum bpf_type_flag *flag)
 {
 	int ret = -EACCES;
 
 	if (atype == BPF_READ)
-		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
-					 flag);
+		return btf_struct_access(log, reg, off, size, atype, next_btf_id, flag);
 
 	mutex_lock(&nf_conn_btf_access_lock);
 	if (nfct_btf_struct_access)
-		ret = nfct_btf_struct_access(log, btf, t, off, size, atype, next_btf_id, flag);
+		ret = nfct_btf_struct_access(log, reg, off, size, atype, next_btf_id, flag);
 	mutex_unlock(&nf_conn_btf_access_lock);
 
 	return ret;
@@ -8738,21 +8735,18 @@ void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog,
 EXPORT_SYMBOL_GPL(bpf_warn_invalid_xdp_action);
 
 static int xdp_btf_struct_access(struct bpf_verifier_log *log,
-				 const struct btf *btf,
-				 const struct btf_type *t, int off,
-				 int size, enum bpf_access_type atype,
-				 u32 *next_btf_id,
-				 enum bpf_type_flag *flag)
+				 const struct bpf_reg_state *reg,
+				 int off, int size, enum bpf_access_type atype,
+				 u32 *next_btf_id, enum bpf_type_flag *flag)
 {
 	int ret = -EACCES;
 
 	if (atype == BPF_READ)
-		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
-					 flag);
+		return btf_struct_access(log, reg, off, size, atype, next_btf_id, flag);
 
 	mutex_lock(&nf_conn_btf_access_lock);
 	if (nfct_btf_struct_access)
-		ret = nfct_btf_struct_access(log, btf, t, off, size, atype, next_btf_id, flag);
+		ret = nfct_btf_struct_access(log, reg, off, size, atype, next_btf_id, flag);
 	mutex_unlock(&nf_conn_btf_access_lock);
 
 	return ret;
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 6da16ae6a962..d15c91de995f 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -69,18 +69,17 @@ static bool bpf_tcp_ca_is_valid_access(int off, int size,
 }
 
 static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
-					const struct btf *btf,
-					const struct btf_type *t, int off,
-					int size, enum bpf_access_type atype,
-					u32 *next_btf_id,
-					enum bpf_type_flag *flag)
+					const struct bpf_reg_state *reg,
+					int off, int size, enum bpf_access_type atype,
+					u32 *next_btf_id, enum bpf_type_flag *flag)
 {
+	const struct btf_type *t;
 	size_t end;
 
 	if (atype == BPF_READ)
-		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
-					 flag);
+		return btf_struct_access(log, reg, off, size, atype, next_btf_id, flag);
 
+	t = btf_type_by_id(reg->btf, reg->btf_id);
 	if (t != tcp_sock_type) {
 		bpf_log(log, "only read is supported\n");
 		return -EACCES;
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 8639e7efd0e2..24002bc61e07 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -191,19 +191,16 @@ BTF_ID(struct, nf_conn___init)
 
 /* Check writes into `struct nf_conn` */
 static int _nf_conntrack_btf_struct_access(struct bpf_verifier_log *log,
-					   const struct btf *btf,
-					   const struct btf_type *t, int off,
-					   int size, enum bpf_access_type atype,
-					   u32 *next_btf_id,
-					   enum bpf_type_flag *flag)
+					   const struct bpf_reg_state *reg,
+					   int off, int size, enum bpf_access_type atype,
+					   u32 *next_btf_id, enum bpf_type_flag *flag)
 {
-	const struct btf_type *ncit;
-	const struct btf_type *nct;
+	const struct btf_type *ncit, *nct, *t;
 	size_t end;
 
-	ncit = btf_type_by_id(btf, btf_nf_conn_ids[1]);
-	nct = btf_type_by_id(btf, btf_nf_conn_ids[0]);
-
+	ncit = btf_type_by_id(reg->btf, btf_nf_conn_ids[1]);
+	nct = btf_type_by_id(reg->btf, btf_nf_conn_ids[0]);
+	t = btf_type_by_id(reg->btf, reg->btf_id);
 	if (t != nct && t != ncit) {
 		bpf_log(log, "only read is supported\n");
 		return -EACCES;
-- 
2.38.1

