Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E6F61884A
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiKCTLK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiKCTLH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:11:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06401F637
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:11:05 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso2693056pjc.5
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJYbigs0tGAK3tmPuWEHhuyqvI7PEn4okvyEGuSYl6A=;
        b=jMXP7C5yN0J4IzAnPKZH6+na+r8RHQUIEHbHRTJ2DNsnB/rEY3eQ4KfYpnJ2eYVtLL
         eWlcnlttS0OYaBllutOS+X9taHzc9wCJ5QW9JJvBNtpLMtGIY0vTPMl+hhvJUfKld2xn
         lP2nvclTp/z13WXfUclTFcv/MSqipWn78SWixb2Og5hgBgcOUsq/35sKUPQ1y/GJh+B1
         Gj7yS22LIehRNRZ3Xw/Sg31sQ+0oA9j4I+kmsKpa74CziYgEFHS5HYXFNwwD9Ww+GboN
         NoXbuiv/GmLv/JVSzLHPzV2msI/B6TiYzXMw9qYiNKntnbyQiXO7y1wM3boQYNILqqai
         O05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJYbigs0tGAK3tmPuWEHhuyqvI7PEn4okvyEGuSYl6A=;
        b=Xh/G4hp6lZs1vDUi5sNZo7TVPgxBiPHCO69ou9g00rWW1S0ZAFzfYANSWqfcsiE/Ba
         JNLKJ0tOIQvrpfa1sS6t38YapR1A8k4Wu3ejO5rxF7na2ASt0VWTv303KWNnMf9AYOJD
         +RNxMC1E9GDV0QNY9R/PktPSyj2tNZSQE/lVie7UilzUokr4hhTFFnxTuOrO+YVSX9ah
         rvF3gF4wnSAa9tivd4AjFmHM2RF679pN4qk8ZLuZrmaP9TN25enZPXMqzF0RnLXeShlj
         q3s7Kn/Oy4D5Luus4wRCx+Yqcklrj2WuN5bjHbRk5ns6fhYAq37yRb/KZegdp5zuZLQh
         R8sQ==
X-Gm-Message-State: ACrzQf16O+KI90QU8BvReX0lr08WCi5y2+Jv9eovn+8WieASJOR0KmwD
        FYTu5xbIj9kKAlMxmbrXItlky0BfB0bPJA==
X-Google-Smtp-Source: AMsMyM7FOVcF92RAA0Vn3IQ19I02HHboyJGByP46KLzesIhzwBpUdVe1UvefVi+qeBN7YXz3EGAHkg==
X-Received: by 2002:a17:902:e745:b0:187:2033:1832 with SMTP id p5-20020a170902e74500b0018720331832mr23164434plf.119.1667502664882;
        Thu, 03 Nov 2022 12:11:04 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e5d000b0017f778d4543sm986121plf.241.2022.11.03.12.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:11:04 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 10/24] bpf: Introduce local kptrs
Date:   Fri,  4 Nov 2022 00:39:59 +0530
Message-Id: <20221103191013.1236066-11-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16148; i=memxor@gmail.com; h=from:subject; bh=pkIvA3LkNTk8nnQg0mFuW1CqqOIOMK2xpiunsY1tPlY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIAtn539ueUHak8LzDCecGVSo/2eJdQUBcOhSPa A7KyFtuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAAAKCRBM4MiGSL8RyrasEA Cf6f57wc40fr08mZ/4t08Uf0CqG8XsH48n90idSbGkIcf0LPTAvda18taTPkIaCcYs5PoHpz0Tt09E sELdn1vVoKEEriNjJ17kssWDnbq6pe11kBOnnpC2y7CXSfT6cQa7sojGRVvHqn3JRJJhlipSFL61Dx k0tBcX09k8KZ/gDLaQzg/L0HEgXe0f3+PT/I3qXlh55xNCS5E1Os/J7pI+S9KB1xuj4fvE1PUNnUw+ QQGk59RiBaBzMH+QiZm5Ev4DrelLKkF8zV7BjU/eCvD3WF77n7VgviCVzy7rCZRQiDhhMjrZYvysMu Ur33ZU2uS09gcW9DVVbN9R3pDOsW7ci074/gVTwudfj9SnWrlNY/NQunQhr3QSF1DFMnKmsIDyITml Lem9hZtjidi2CLeAXNhIQcs9oqXrrDfuDEiVQv25CJ5SORB4GFC5jnk8efKLdGr87wOKGDO2TTZrtg DYGMHo7E/XtLHXeDWcgC4uUJHbK5nb8Hpozv9k15Jq/YXk182JJj26GbIsh+Dp6mZXfkRJoJG34V2W T4NzFnAHEPt4rrw1/j0f3gzTuWi5YHAaGSk8JfHDNU+8wsEvtNGIq+lAmqhuuVDrdq2FaUvjdeAgOw 3KZ+2j/3Un3iJJGlR1nbqyf99cP7kiU9FwMdTrtHeYcpt/xee4YpOpW+YHhw==
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

Introduce local kptrs, i.e. PTR_TO_BTF_ID that point to a type in
program BTF. This is indicated by the presence of MEM_TYPE_LOCAL type
tag in reg->type to avoid having to check btf_is_kernel when trying to
match argument types in helpers.

Refactor btf_struct_access callback to just take bpf_reg_state instead
of btf and btf_type paramters. Note that the call site in
check_map_access now simulates access to a PTR_TO_BTF_ID by creating a
dummy reg on stack. Since only the type, btf, and btf_id of the register
matter for the checks, it can be done so without complicating the usual
cases elsewhere in the verifier where reg->btf and reg->btf_id is used
verbatim.

For now, these local kptrs will always be referenced in verifier
context, hence ref_obj_id == 0 for them is a bug. It is allowed to write
to such objects, as long fields that are special are not touched
(support for which will be added in subsequent patches). Note that once
such a local kptr is marked PTR_UNTRUSTED, it is no longer allowed to
write to it.

No PROBE_MEM handling is hence done unless PTR_UNTRUSTED is part of the
register type, since they can never be in an undefined state otherwise,
and their lifetime will always be valid.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h              | 28 ++++++++++++++++--------
 include/linux/filter.h           |  8 +++----
 kernel/bpf/btf.c                 | 16 ++++++++++----
 kernel/bpf/verifier.c            | 37 ++++++++++++++++++++++++++------
 net/bpf/bpf_dummy_struct_ops.c   | 14 ++++++------
 net/core/filter.c                | 34 ++++++++++++-----------------
 net/ipv4/bpf_tcp_ca.c            | 13 ++++++-----
 net/netfilter/nf_conntrack_bpf.c | 17 ++++++---------
 8 files changed, 99 insertions(+), 68 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2d9ebe9efcad..bdd3adfcbe5f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -527,6 +527,11 @@ enum bpf_type_flag {
 	/* Size is known at compile time. */
 	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
 
+	/* MEM is of a type from program BTF, not kernel BTF. This is used to
+	 * tag PTR_TO_BTF_ID allocated using bpf_kptr_alloc.
+	 */
+	MEM_TYPE_LOCAL		= BIT(11 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
@@ -775,6 +780,7 @@ struct bpf_prog_ops {
 			union bpf_attr __user *uattr);
 };
 
+struct bpf_reg_state;
 struct bpf_verifier_ops {
 	/* return eBPF function prototype for verification */
 	const struct bpf_func_proto *
@@ -796,9 +802,8 @@ struct bpf_verifier_ops {
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
 
@@ -2084,9 +2089,9 @@ static inline bool bpf_tracing_btf_ctx_access(int off, int size,
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
@@ -2337,9 +2342,8 @@ static inline struct bpf_prog *bpf_prog_by_id(u32 id)
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
@@ -2796,4 +2800,10 @@ struct bpf_key {
 	bool has_ref;
 };
 #endif /* CONFIG_KEYS */
+
+static inline bool type_is_local_kptr(u32 type)
+{
+	return type & MEM_TYPE_LOCAL;
+}
+
 #endif /* _LINUX_BPF_H */
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
index e56025505467..2e0ec7307f73 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6016,20 +6016,28 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
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
 
 		switch (err) {
 		case WALK_PTR:
+			/* For local types, the destination register cannot
+			 * become a pointer again.
+			 */
+			if (type_is_local_kptr(reg->type))
+				return SCALAR_VALUE;
 			/* If we found the pointer or scalar on t+off,
 			 * we're done.
 			 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 168cd8bb9fd6..4de72a4a39bb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4521,17 +4521,28 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (env->ops->btf_struct_access) {
-		ret = env->ops->btf_struct_access(&env->log, reg->btf, t,
-						  off, size, atype, &btf_id, &flag);
+	if (env->ops->btf_struct_access && !type_is_local_kptr(reg->type)) {
+		if (!btf_is_kernel(reg->btf)) {
+			verbose(env, "verifier internal error: reg->btf must be kernel btf\n");
+			return -EFAULT;
+		}
+		ret = env->ops->btf_struct_access(&env->log, reg, off, size, atype, &btf_id, &flag);
 	} else {
-		if (atype != BPF_READ) {
+		/* Writes are permitted with default btf_struct_access for local
+		 * kptrs (which always have ref_obj_id > 0), but not for
+		 * _untrusted_ local kptrs.
+		 */
+		if (atype != BPF_READ && reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL)) {
 			verbose(env, "only read is supported\n");
 			return -EACCES;
 		}
 
-		ret = btf_struct_access(&env->log, reg->btf, t, off, size,
-					atype, &btf_id, &flag);
+		if (type_is_local_kptr(reg->type) && !reg->ref_obj_id) {
+			verbose(env, "verifier internal error: ref_obj_id for local kptr must be non-zero\n");
+			return -EFAULT;
+		}
+
+		ret = btf_struct_access(&env->log, reg, off, size, atype, &btf_id, &flag);
 	}
 
 	if (ret < 0)
@@ -4557,6 +4568,7 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 {
 	struct bpf_reg_state *reg = regs + regno;
 	struct bpf_map *map = reg->map_ptr;
+	struct bpf_reg_state map_reg;
 	enum bpf_type_flag flag = 0;
 	const struct btf_type *t;
 	const char *tname;
@@ -4595,7 +4607,10 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	ret = btf_struct_access(&env->log, btf_vmlinux, t, off, size, atype, &btf_id, &flag);
+	/* Simulate access to a PTR_TO_BTF_ID */
+	memset(&map_reg, 0, sizeof(map_reg));
+	mark_btf_ld_reg(env, &map_reg, 0, PTR_TO_BTF_ID, btf_vmlinux, *map->ops->map_btf_id, 0);
+	ret = btf_struct_access(&env->log, &map_reg, off, size, atype, &btf_id, &flag);
 	if (ret < 0)
 		return ret;
 
@@ -5805,6 +5820,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	 * fixed offset.
 	 */
 	case PTR_TO_BTF_ID:
+	case PTR_TO_BTF_ID | MEM_TYPE_LOCAL:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * it's fixed offset must be 0.	In the other cases, fixed offset
 		 * can be non-zero.
@@ -13462,6 +13478,13 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			break;
 		case PTR_TO_BTF_ID:
 		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
+		/* PTR_TO_BTF_ID | MEM_TYPE_LOCAL always has a valid lifetime,
+		 * unlike PTR_TO_BTF_ID, and an active ref_obj_id, but the same
+		 * cannot be said once it is marked PTR_UNTRUSTED, hence we must
+		 * handle any faults for loads into such types. BPF_WRITE is
+		 * disallowed for this case.
+		 */
+		case PTR_TO_BTF_ID | MEM_TYPE_LOCAL | PTR_UNTRUSTED:
 			if (type == BPF_READ) {
 				insn->code = BPF_LDX | BPF_PROBE_MEM |
 					BPF_SIZE((insn)->code);
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
index bb0136e7a8e4..1380828d67a3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8647,28 +8647,25 @@ static bool tc_cls_act_is_valid_access(int off, int size,
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
@@ -8734,21 +8731,18 @@ void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog,
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

