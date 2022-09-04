Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526565AC672
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiIDUmT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiIDUmP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:15 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D1A2CE02
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:09 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id z2so9061455edc.1
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2Joh8f9QE4aYdO/0AKDt7yzOz+OpO6AEPfJ0H2S3MAs=;
        b=Zj+8StUfl5U+J0fzLUN6g1evk5V0pzxH8n0+nMEN5WUDCFn+8VRdxwbMYQ5QkZUDOW
         IodfpzwOd50hVoskxp26kUkl81QynxAb2Ohxy8C042pq8RV3xydybG4NA99i34bQXxv6
         UuSH3iuiv+xeGS0ddR6OU2AzxsRnqtdYzoHOZuu7HeECjlwEhv7VTOwUcwr4hd1Eqo5j
         x062buk4a8yKcWx49KyCjX71O5zkG+etCWCPt1QZya4yDtf1uwWd+Y92nq8dt5c54CSx
         g8P5Y28NVKVFoAr+3gAMvKk4rGq9Lu84hMEEX6n+TXRu2fw50JA6dFHygApdGS2Xa4t6
         oesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2Joh8f9QE4aYdO/0AKDt7yzOz+OpO6AEPfJ0H2S3MAs=;
        b=BIvfuA+TRz6eLyZLedukCtGhkfsO0QjOMxZcLaPDtzcRO7qGbLe9PhA8UiomJTHKqr
         zqqk7eoRcMxlqcYkg5u7UPRbQl6qjUbH97EvdJcF5jm+WO24icj9qH0muMj9yLvvBFn6
         xS/Fgovns06XtXbp9r1lfX3VuOJdftn/Ob8HmCuaYBKDYCXnDdilWHMksmtrY76QejOl
         dkZWhvsihcaIG3iy7nXz0FhdPD6xvfVmUzHqHif9gdXq3boj3ej+vjc84LCBJVPBrQr7
         plToLN39ymgC0BeXsTanu0f3OayZbpZR2mKEHk0lbiZPTi870ZeqBHfV0clx8/OBPoqJ
         Noew==
X-Gm-Message-State: ACgBeo1ocAdB1anUjm9/xnxFIesOvaYsZuh4ON+wZMfYgtvHJZEQ4FHX
        bxJmVVLJKxblqJ3Q8z7z5QGVzz26ILkLFw==
X-Google-Smtp-Source: AA6agR68ToFre/vjkmYwC01slAauw9cryQlPWf3K77Z8f2nS4DOVxN/+aVvshz5FVN5WrALyIO+6WA==
X-Received: by 2002:a05:6402:520e:b0:448:ce28:3512 with SMTP id s14-20020a056402520e00b00448ce283512mr23051612edd.130.1662324128306;
        Sun, 04 Sep 2022 13:42:08 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id b10-20020a056402138a00b0044e81203bebsm992680edv.31.2022.09.04.13.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:08 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 18/32] bpf: Support bpf_spin_lock in local kptrs
Date:   Sun,  4 Sep 2022 22:41:31 +0200
Message-Id: <20220904204145.3089-19-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14596; i=memxor@gmail.com; h=from:subject; bh=vKle5HUXpNrrnCaGmlRfhFfiMJtSs3m7HifQ4mhHMcA=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1xJte63ag+WdyRZH2iNUaIg8w1C28gfj1IUfXd LkDU1riJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcQAKCRBM4MiGSL8Ryq+BD/ 94iAEwfB7o40VS8eLYSxNpkOWGWnW8D/H8KQPa6bvXLmIQBllJ6/ffZrM1CSiBOmmCoPBYE6dQs6ZP QuYGuLhL7M/N1jCiApF4f1nmTHPQFD+5YjIiySWjB9sxgHXnYnSgBVnqaXDbPvalVm8+qOAQUByCJ+ 9p6Yb9ZSGJBr8+F4tOpTXhB9dDeISJibYol8/W2mSOl9f3jp/FOm2Zr5le1VXNPK0ZscSPZ7+gtMb9 ed1ffY9itFV3PE/IzjBqTH16Jx+c3ruTnrZjj8DuVNVYBj0ImigRBF+ryTy9nV4yEJlzR/HlHhIFxI aPdZvGwQqe7PfRe8jS75l8Q9+ZfT4Ye75VuTs10e9l+eL3q40GzzQpIGjnuC1mXccpzm2qpB0iMxo5 WgSlDO0KC8pfSpY6UMcOCTSNZNYbEdKfjFYzCxY2LMCdiWpjlgMPV5tTGna0IgSS7h9Xx0OumCHRPk /v1xbaWi1smHQ8OCqW1SwkghERqp/dzU8VzZMeWluSdi3zWlSJdDiURWKtBDTJE+IzAqMmN1IbDt6O 8aX67/YXPlGXooU5s+J2d8F2JlSTQBamvkLBgByqDK7BC8ejx0JnA9A3ijCEZypdycx72SeTBm6j8G KrCTr1GDa60TnfOI3JpW5Tg6T+PfjB4qNJ+Z9BwZzwryiBJTRwVSW7fGyMzg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To allow users to lock and protect data in their local kptr allocation,
add support for embedding a bpf_spin_lock as a member. This is following
how bpf_list_node is supported as a member already, by suitably tagging
the field. We will later use bpf_spin_lock to allow implementing
map-in-map style intrusive collection, while still associating the lock
of linked list together in one single allocation. Only one bpf_spin_lock
is allowed, and when a PTR_TO_BTF_ID | MEM_TYPE_LOCAL reg->type has it,
it will preserve its reg->id during mark_ptr_or_null_reg marking, so
that verifier can figure out the pairing of spin_lock and spin_unlock
calls.

Existing process_spin_lock is refactored to support such spin_locks in
allocated items. Still the restriction of holding single spin lock at
one point does not go away, which is needed for deadlock safety.

The tagging works similar to bpf_list_node, it needs to be tagged using
a "kernel" BTF declaration tag, like so:

struct item {
    int data;
    struct bpf_spin_lock lock __kernel;
};

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h                           |   8 ++
 include/linux/poison.h                        |   3 +
 kernel/bpf/btf.c                              |  10 +-
 kernel/bpf/helpers.c                          |  14 ++-
 kernel/bpf/verifier.c                         | 104 ++++++++++++++----
 .../testing/selftests/bpf/bpf_experimental.h  |   9 ++
 6 files changed, 121 insertions(+), 27 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 062bc45e1cc9..d99cad21e6d9 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -435,6 +435,8 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 		      int arg);
 int btf_local_type_has_bpf_list_node(const struct btf *btf,
 				     const struct btf_type *t, u32 *offsetp);
+int btf_local_type_has_bpf_spin_lock(const struct btf *btf,
+				     const struct btf_type *t, u32 *offsetp);
 bool btf_local_type_has_special_fields(const struct btf *btf,
 				       const struct btf_type *t);
 #else
@@ -481,6 +483,12 @@ static inline int btf_local_type_has_bpf_list_node(const struct btf *btf,
 {
 	return -ENOENT;
 }
+static inline int btf_local_type_has_bpf_spin_lock(const struct btf *btf,
+					           const struct btf_type *t,
+					           u32 *offsetp)
+{
+	return -ENOENT;
+}
 static inline bool btf_local_type_has_special_fields(const struct btf *btf,
 						     const struct btf_type *t)
 {
diff --git a/include/linux/poison.h b/include/linux/poison.h
index d62ef5a6b4e9..753e00b81acf 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -81,4 +81,7 @@
 /********** net/core/page_pool.c **********/
 #define PP_SIGNATURE		(0x40 + POISON_POINTER_DELTA)
 
+/********** kernel/bpf/helpers.c **********/
+#define BPF_PTR_POISON		((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
+
 #endif
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d8bc4752204c..63193c324898 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5954,9 +5954,16 @@ int btf_local_type_has_bpf_list_node(const struct btf *btf,
 	return btf_find_local_type_field(btf, t, BTF_FIELD_LIST_NODE, offsetp);
 }
 
+int btf_local_type_has_bpf_spin_lock(const struct btf *btf,
+				     const struct btf_type *t, u32 *offsetp)
+{
+	return btf_find_local_type_field(btf, t, BTF_FIELD_SPIN_LOCK, offsetp);
+}
+
 bool btf_local_type_has_special_fields(const struct btf *btf, const struct btf_type *t)
 {
-	return btf_local_type_has_bpf_list_node(btf, t, NULL) == 1;
+	return btf_local_type_has_bpf_list_node(btf, t, NULL) == 1 ||
+	       btf_local_type_has_bpf_spin_lock(btf, t, NULL) == 1;
 }
 
 int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
@@ -5985,6 +5992,7 @@ int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
 		}									\
 	}
 		PREVENT_DIRECT_WRITE(bpf_list_node);
+		PREVENT_DIRECT_WRITE(bpf_spin_lock);
 
 #undef PREVENT_DIRECT_WRITE
 		err = 0;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0bb11d8bcaca..94a23a544aee 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -335,6 +335,7 @@ const struct bpf_func_proto bpf_spin_lock_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_SPIN_LOCK,
+	.arg1_btf_id	= BPF_PTR_POISON,
 };
 
 static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
@@ -357,6 +358,7 @@ const struct bpf_func_proto bpf_spin_unlock_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_SPIN_LOCK,
+	.arg1_btf_id	= BPF_PTR_POISON,
 };
 
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
@@ -1375,10 +1377,10 @@ BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)
 	return xchg(kptr, (unsigned long)ptr);
 }
 
-/* Unlike other PTR_TO_BTF_ID helpers the btf_id in bpf_kptr_xchg()
- * helper is determined dynamically by the verifier.
+/* Unlike other PTR_TO_BTF_ID helpers the btf_id in bpf_kptr_xchg() helper is
+ * determined dynamically by the verifier. Hence, BPF_PTR_POISON is used as the
+ * placeholder pointer.
  */
-#define BPF_PTR_POISON ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
 
 static const struct bpf_func_proto bpf_kptr_xchg_proto = {
 	.func         = bpf_kptr_xchg,
@@ -1717,6 +1719,11 @@ void bpf_list_node_init(struct bpf_list_node *node__clkptr)
 	INIT_LIST_HEAD((struct list_head *)node__clkptr);
 }
 
+void bpf_spin_lock_init(struct bpf_spin_lock *lock__clkptr)
+{
+	memset(lock__clkptr, 0, sizeof(*lock__clkptr));
+}
+
 __diag_pop();
 
 BTF_SET8_START(tracing_btf_ids)
@@ -1725,6 +1732,7 @@ BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_kptr_alloc, KF_ACQUIRE | KF_RET_NULL | __KF_RET_DYN_BTF)
 BTF_ID_FLAGS(func, bpf_list_node_init)
+BTF_ID_FLAGS(func, bpf_spin_lock_init)
 BTF_SET8_END(tracing_btf_ids)
 
 static const struct btf_kfunc_id_set tracing_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1108b6200501..130a4f0550f5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -451,8 +451,17 @@ static bool reg_type_not_null(enum bpf_reg_type type)
 
 static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 {
-	return reg->type == PTR_TO_MAP_VALUE &&
-		map_value_has_spin_lock(reg->map_ptr);
+	if (reg->type == PTR_TO_MAP_VALUE)
+		return map_value_has_spin_lock(reg->map_ptr);
+	if (reg->type == (PTR_TO_BTF_ID | MEM_TYPE_LOCAL | OBJ_CONSTRUCTING)) {
+		const struct btf_type *t;
+
+		t = btf_type_by_id(reg->btf, reg->btf_id);
+		if (!t)
+			return false;
+		return btf_local_type_has_bpf_spin_lock(reg->btf, t, NULL) == 1;
+	}
+	return false;
 }
 
 static bool reg_type_may_be_refcounted_or_null(enum bpf_reg_type type)
@@ -5442,8 +5451,11 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	struct bpf_verifier_state *cur = env->cur_state;
 	bool is_const = tnum_is_const(reg->var_off);
-	struct bpf_map *map = reg->map_ptr;
 	u64 val = reg->var_off.value;
+	struct bpf_map *map = NULL;
+	struct btf *btf = NULL;
+	bool has_spin_lock;
+	int spin_lock_off;
 
 	if (!is_const) {
 		verbose(env,
@@ -5451,28 +5463,42 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			regno);
 		return -EINVAL;
 	}
-	if (!map->btf) {
-		verbose(env,
-			"map '%s' has to have BTF in order to use bpf_spin_lock\n",
-			map->name);
-		return -EINVAL;
-	}
-	if (!map_value_has_spin_lock(map)) {
-		if (map->spin_lock_off == -E2BIG)
+	if (reg->type == PTR_TO_MAP_VALUE) {
+		map = reg->map_ptr;
+		if (!map->btf) {
 			verbose(env,
-				"map '%s' has more than one 'struct bpf_spin_lock'\n",
+				"map '%s' has to have BTF in order to use bpf_spin_lock\n",
 				map->name);
-		else if (map->spin_lock_off == -ENOENT)
+			return -EINVAL;
+		}
+		has_spin_lock = map_value_has_spin_lock(map);
+		spin_lock_off = map->spin_lock_off;
+	} else {
+		int ret;
+
+		btf = reg->btf;
+		WARN_ON_ONCE(reg->var_off.value);
+		ret = btf_local_type_has_bpf_spin_lock(reg->btf, btf_type_by_id(reg->btf, reg->btf_id), &spin_lock_off);
+		if (ret <= 0)
+			spin_lock_off = ret;
+		has_spin_lock = ret > 0;
+	}
+	if (!has_spin_lock) {
+		if (spin_lock_off == -E2BIG)
 			verbose(env,
-				"map '%s' doesn't have 'struct bpf_spin_lock'\n",
-				map->name);
+				"%s '%s' has more than one 'struct bpf_spin_lock'\n",
+				map ? "map" : "local", map ? map->name : "kptr");
+		else if (spin_lock_off == -ENOENT)
+			verbose(env,
+				"%s '%s' doesn't have 'struct bpf_spin_lock'\n",
+				map ? "map" : "local", map ? map->name : "kptr");
 		else
 			verbose(env,
-				"map '%s' is not a struct type or bpf_spin_lock is mangled\n",
-				map->name);
+				"%s '%s' is not a struct type or bpf_spin_lock is mangled\n",
+				map ? "map" : "local", map ? map->name : "kptr");
 		return -EINVAL;
 	}
-	if (map->spin_lock_off != val + reg->off) {
+	if (spin_lock_off != val + reg->off) {
 		verbose(env, "off %lld doesn't point to 'struct bpf_spin_lock'\n",
 			val + reg->off);
 		return -EINVAL;
@@ -5709,13 +5735,19 @@ static const struct bpf_reg_types int_ptr_types = {
 	},
 };
 
+static const struct bpf_reg_types spin_lock_types = {
+	.types = {
+		PTR_TO_MAP_VALUE,
+		PTR_TO_BTF_ID | MEM_TYPE_LOCAL,
+	},
+};
+
 static const struct bpf_reg_types fullsock_types = { .types = { PTR_TO_SOCKET } };
 static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
 static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | MEM_ALLOC } };
 static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
 static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
-static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
 static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
@@ -5806,6 +5838,11 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 		bool strict_type_match = arg_type_is_release(arg_type) &&
 					 meta->func_id != BPF_FUNC_sk_release;
 
+		if (type_is_local(reg->type) &&
+		    WARN_ON_ONCE(meta->func_id != BPF_FUNC_spin_lock &&
+				 meta->func_id != BPF_FUNC_spin_unlock))
+			return -EFAULT;
+
 		if (!arg_btf_id) {
 			if (!compatible->btf_id) {
 				verbose(env, "verifier internal error: missing arg compatible BTF ID\n");
@@ -5814,7 +5851,20 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			arg_btf_id = compatible->btf_id;
 		}
 
-		if (meta->func_id == BPF_FUNC_kptr_xchg) {
+		if (meta->func_id == BPF_FUNC_spin_lock || meta->func_id == BPF_FUNC_spin_unlock) {
+			u32 offset;
+			int ret;
+
+			if (WARN_ON_ONCE(!type_is_local(reg->type)))
+				return -EFAULT;
+			ret = btf_local_type_has_bpf_spin_lock(reg->btf,
+							       btf_type_by_id(reg->btf, reg->btf_id),
+							       &offset);
+			if (ret <= 0 || reg->off != offset) {
+				verbose(env, "no bpf_spin_lock field at offset=%d\n", reg->off);
+				return -EACCES;
+			}
+		} else if (meta->func_id == BPF_FUNC_kptr_xchg) {
 			if (map_kptr_match_type(env, meta->kptr_off_desc, reg, regno))
 				return -EACCES;
 		} else if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
@@ -5943,7 +5993,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		goto skip_type_check;
 
 	/* arg_btf_id and arg_size are in a union. */
-	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID)
+	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
+	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
 	err = check_reg_type(env, regno, arg_type, arg_btf_id, meta);
@@ -6530,8 +6581,11 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
-		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID && !fn->arg_btf_id[i])
-			return false;
+		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID)
+			return !!fn->arg_btf_id[i];
+
+		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_SPIN_LOCK)
+			return fn->arg_btf_id[i] == BPF_PTR_POISON;
 
 		if (base_type(fn->arg_type[i]) != ARG_PTR_TO_BTF_ID && fn->arg_btf_id[i] &&
 		    /* arg_btf_id and arg_size are in a union. */
@@ -7756,11 +7810,13 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 BTF_ID_LIST(special_kfuncs)
 BTF_ID(func, bpf_kptr_alloc)
 BTF_ID(func, bpf_list_node_init)
+BTF_ID(func, bpf_spin_lock_init)
 BTF_ID(struct, btf) /* empty entry */
 
 enum bpf_special_kfuncs {
 	KF_SPECIAL_bpf_kptr_alloc,
 	KF_SPECIAL_bpf_list_node_init,
+	KF_SPECIAL_bpf_spin_lock_init,
 	KF_SPECIAL_bpf_empty,
 	KF_SPECIAL_MAX = KF_SPECIAL_bpf_empty,
 };
@@ -7927,6 +7983,7 @@ static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
 struct local_type_field {
 	enum {
 		FIELD_bpf_list_node,
+		FIELD_bpf_spin_lock,
 		FIELD_MAX,
 	} type;
 	enum bpf_special_kfuncs ctor_kfunc;
@@ -7972,6 +8029,7 @@ static int find_local_type_fields(const struct btf *btf, u32 btf_id, struct loca
 	}
 
 	FILL_LOCAL_TYPE_FIELD(bpf_list_node, bpf_list_node_init, bpf_empty, false);
+	FILL_LOCAL_TYPE_FIELD(bpf_spin_lock, bpf_spin_lock_init, bpf_empty, false);
 
 #undef FILL_LOCAL_TYPE_FIELD
 
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index c3c5442742dc..8b1cdfb2f6bc 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -41,4 +41,13 @@ void *bpf_kptr_alloc(__u64 local_type_id, __u64 flags) __ksym;
  */
 void bpf_list_node_init(struct bpf_list_node *node) __ksym;
 
+/* Description
+ *	Initialize bpf_spin_lock field in a local kptr. This kfunc has
+ *	constructor semantics, and thus can only be called on a local kptr in
+ *	'constructing' phase.
+ * Returns
+ *	Void.
+ */
+void bpf_spin_lock_init(struct bpf_spin_lock *node) __ksym;
+
 #endif
-- 
2.34.1

