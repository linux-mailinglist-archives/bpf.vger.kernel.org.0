Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D3A6261FD
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbiKKTde (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiKKTdc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:33:32 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0C7B1E3
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:30 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso8613558pjc.0
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDKjaXQrzw8xzAKuOLSOkHReeUI2bgGmwlrnNY+xHtA=;
        b=NhpRCOOVZdtqTH2jNaDSbQ96S1XZ+sdIUPAoEcXp1kHjvZShn+1NKcgUH0DtEGMh09
         FViI4ClZKIYuDZ5Sc9/tcyWMJIXdC4bfGrzzeXPFQnzEnZIItFtnGESpme06sPgngzuE
         LCQGLg3noPY1K5MbHWoLpdyViFq87nF3otF7eCgsTxf1QkP1oUJIgZZ65b+LZauEBFu6
         uc8ZRbXsWKOw5IhcZmK20OQm7STLiIDhNn/sFLchk3nk0UNU28MekSHAWFmnPzOwnLU0
         78iti8qYQWi9kwfyEV7Xuzhz1jQ7shdPpfCppXZkz0t2k+E2gDEww1a0K6A6FZRJVyd9
         CnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDKjaXQrzw8xzAKuOLSOkHReeUI2bgGmwlrnNY+xHtA=;
        b=kgoe88kkX7Nw7eSBdoG3ziEVxqBVmnQCZJxfpkTjLs3CqmNom8pJv3eKY/uzOEAvqx
         4/lKUDfiCYawxJhQhkiHvaOx8yxWpkUzLvllwStYLoTEp7x/99tnXvEJl+0kxbELxaZi
         MrvPvqzJ0tdLM+NaQHe2y6XRbiQzeeRmNlhPMsNhlpd9NFTW+bhyx7of4UkcY8uYsUpN
         //E5PuERa+EcxC1L4Qir3hxTWJVpxX7Wx4QnjeEoWB8CxaFrCab95ZXMMCk9tkiMZm7R
         hfQLX6yUsN11oWFH8w2U2sLZJim8dBUHQtDvLn7BEfny9VDBOiCaHbmRVIxoa8GiD3Ex
         qEnw==
X-Gm-Message-State: ANoB5pniLlmx6nhExmhzK7/KpFh2GYw5WbwpkWOvJKW7sSe3DwZbWNRg
        9ilwS6hmeWvoojMKMiY1VwUI/kD/NVsekg==
X-Google-Smtp-Source: AA0mqf7fqHoVBn1EKj/Bn8GibTQXjGaNnfOWESzI6+dqOCmZsACWk03WgnqoVwpYdP82mB/d3WYBVQ==
X-Received: by 2002:a17:90b:3c44:b0:212:ec17:3fd0 with SMTP id pm4-20020a17090b3c4400b00212ec173fd0mr3423344pjb.241.1668195210052;
        Fri, 11 Nov 2022 11:33:30 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090ade0100b0020dc318a43esm1949847pjv.25.2022.11.11.11.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:33:29 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 07/26] bpf: Refactor btf_struct_access
Date:   Sat, 12 Nov 2022 01:02:05 +0530
Message-Id: <20221111193224.876706-8-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12746; i=memxor@gmail.com; h=from:subject; bh=J59s9TVGQk1qIQ03OK9PLmTtdwn8dkmFxeIuacvaOIY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqInSTonag6VERR0d31rxPLsk5FtlPEhOYfOuBUo kWTQYQeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iJwAKCRBM4MiGSL8Rypn4D/ 9mUUFTXN2NIrhQjI3WHoQqvV8O2gH16y/j9sJk+E9YxPU41oSKOCd+mrzvYuhdnfKS8j4JTv7ohozl 7/eTb6f0OUfZcSK0CciWJUZ/eSvrBzMuMFk/R13ARLXO5591KAjQ1xqncCtawwQUBYC39kS+9yeCEf s5mWkiYsqpShbgABqFLyZpAMYOkbMQ+TNGn6RthQT7deInX9bZfTRcPKpXkY/RsBrp8FjEndNAygem ghVJVHvY34GmZgkRRT2LUQUbygYryVwnNvC7/9i8+1oSdDbZzjikpebYQ8lELaaoifdo94hPbLEdQ3 u5ulRPS9QcpDu1ENBo6LEETWMHbGworB7VY2Lk9vTnK33Kf13jteuSboebGZMlMjt4DNZgUkQnrovi h8VLttcwmhNIhPh8eWQdPh6CH/RKI3japPNQisPnw64rmOG0z+5kml23Toj91bQWslVz82ZGmLnhZv mcxZdtSzcyHUUzATey9zGVD88eQrUS/st8C2FeWUJQqsbxnHZJV0zQmQKmW4xB5C7TTAtGJR2PjCKg NqhfrzlcaKuNAENmnCzSVPjI/3zJkT4SFSAife32LrQUvdrMMBwhVRAAzbbV+Ke3fc2Z6Z4fJi5ppu JU+7AEtNmmjybIeHtX1/S9RSoa5oF7MYVRriGl4xaQgoc5d2sYLFj4zSuTtw==
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
index 5fca156eca43..bbbb0f27c7d1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4683,16 +4683,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
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
@@ -4718,6 +4716,7 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 {
 	struct bpf_reg_state *reg = regs + regno;
 	struct bpf_map *map = reg->map_ptr;
+	struct bpf_reg_state map_reg;
 	enum bpf_type_flag flag = 0;
 	const struct btf_type *t;
 	const char *tname;
@@ -4756,7 +4755,10 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
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
index cb3b635e35be..199632e6a7cb 100644
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

