Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419D15FAA0D
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJKB01 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiJKB0G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:26:06 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279F283057
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:25:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 67so12145968pfz.12
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2eKd6+gEAX6b4on0Cm/dSLV4a1mf/YuEgaNlbjdlM4=;
        b=TAN3DfGWXVWRJd0yPfvygxYZtPCVuZq5/9Yg4aFFU2reAGosRooPplgjwuqa1eMLcj
         tBmvxTsWOmlgrhyE2zAd0o3F15yjXeFOpGI1hYw362WQ1/ucCdVM3n6kU/fMtAwuvca9
         /YhDl0rku/bns0lkfFKVvyOAC0PGNxaqkeOOWgi1gjyPn6XkYy6PmtMrFVkxRiND2SOK
         +mYxjOsAZ4cJ6Z4Wh7ioifgzP+uFJJ6n5iykL3seQpvUrVy1wtSnycPbRRNyXXDj/zWb
         HvxSlZC0TJ+eWw1VEixeXnjEQU7Qhoa3GwW0fb6JK70QYfxMojc/K5j/iNepL+b9Tt5O
         w8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2eKd6+gEAX6b4on0Cm/dSLV4a1mf/YuEgaNlbjdlM4=;
        b=XFJs0gkuyacm8QZHi4AmA3CmyLcFHuJvvyQ/g4JR0Ueg+AjX9UJh2Cv1khO48ev1HM
         +q2Hi9m66X2j6eJrGKDXjwvSVwgqIvHqQLVU1o22+85Zi+Yy6U9DkNCRVKMpEmnlfCfu
         PUHMDl9ZbdxRcz+0Smcv9DCnqUwp+Jd1GB2NCkgSr0Yc4m+E9/1kf6nXaAA0wA7pB3AR
         iCEf8U17wu2CXrftEO/QQcf3LPeDxrdZloo0O3G6GIQs4hfiATLSjghoiXM3bLPAK+De
         xo4fevv2KYE8CrLV8TBQLCLn6Ppq4P/sFp+E8UdrvVLIhGcokKfysigGwMokReY1yRtQ
         OGlA==
X-Gm-Message-State: ACrzQf0wdBqZJHfkzsfWUs/zVYjlM8YViEtI+Toye29Rj00gWj3ZbqM+
        B+3c2ByQxVXKD4EkIGlc9+dea6q2JM5wbA==
X-Google-Smtp-Source: AMsMyM6FDvolLiIUgcXQtGApe93NodhNrj03VCl+oLZO8OZSRoOR5vf2a75j60V1PJWhH0t39m5Epw==
X-Received: by 2002:a05:6a00:7ce:b0:562:b271:9854 with SMTP id n14-20020a056a0007ce00b00562b2719854mr21573051pfu.46.1665451549274;
        Mon, 10 Oct 2022 18:25:49 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b0017829f986a5sm7310362plg.133.2022.10.10.18.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:25:48 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 13/25] bpf: Support locking bpf_spin_lock in local kptr
Date:   Tue, 11 Oct 2022 06:52:28 +0530
Message-Id: <20221011012240.3149-14-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6733; i=memxor@gmail.com; h=from:subject; bh=lthzra5XXFLPjCrvBCgmbmN2GLUiMRSpO0gDolPAPsw=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUbJHiV6sTE0a2CMO5ZSamYQEwWu/3P+6w6wDZC ZHUo3i6JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGwAKCRBM4MiGSL8RysKQD/ wL3eVE0BKgQF9VK9bf1rdxxZhRqQfX8wRnpbaYfTqPvMmBA23hlbKdyK80o68ySvlXR7Nd+9HuCKLg lA/qwwdwIEEqOuQGI55BJqNQDuXVbm0g8VJQusID9ewPFqyhN/44z1mJ0u/MbvriWSHK9m3nw628fK AqcUCrKiIZg9pl7F4Mj+JPrEcooEOGGOuRVadvRPGVXv5RHs8BQoQUHfbxmBp3oRMYYJjgdT1KVOHZ pVKkxqVxfKyGXviuyCoK+eUYLXYgxJUIUwqPxjIoq1LXnUlRhPrJAVTQcSkiHZZT6+760NrZdas0WN F1cZ4GnrmV4ANVWxLoGG8JCy+t4UEkpjqZl+Szn75EFhOsMmZBl4thYOT9QHUg9Qt6esPesnolsA0J 5YqWCHX+gropjxZBXOv0tCv2hkJ1Rf4mM29CaKOsruKIgIl5cCKqQNx3NGWyn6ZcG6aaI8dNqzXFrv lQZwacZxp2kh2GLd9RS3W0PAd9l94RDSERPaKQ7GxluYGdgee9VDbGKGTWr9vuyGzE/nGwPQ09hYJx ClufSzsHcFw9fgUsgqm7akbCRMS+oOutV0gVlK6PoL17ulQms+wNTB4aqWfs3nNgNVD0sUNFLhEs7y IJd03A5y27thzWVT01JE1qqow93xYFYg67bD9pWMIV6dZhJ+RaHCHpm/ScbA==
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

Allow locking a bpf_spin_lock embedded in local kptr, in addition to
already support map value pointers. The handling is similar to that
of map values, by just preserving the reg->id of local kptrs as well,
and adjusting process_spin_lock to work with non-PTR_TO_MAP_VALUE and
remember the id in verifier state.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c  |  2 ++
 kernel/bpf/verifier.c | 74 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 19d20bf39708..882cd0ebf117 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -336,6 +336,7 @@ const struct bpf_func_proto bpf_spin_lock_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_SPIN_LOCK,
+	.arg1_btf_id    = BPF_PTR_POISON,
 };
 
 static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
@@ -358,6 +359,7 @@ const struct bpf_func_proto bpf_spin_unlock_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_SPIN_LOCK,
+	.arg1_btf_id    = BPF_PTR_POISON,
 };
 
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6ee8c06c2080..156c1a1254d5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -453,8 +453,16 @@ static bool reg_type_not_null(enum bpf_reg_type type)
 
 static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 {
-	return reg->type == PTR_TO_MAP_VALUE &&
-		btf_type_fields_has_field(reg->map_ptr->fields_tab, BPF_SPIN_LOCK);
+	struct btf_type_fields *tab = NULL;
+
+	if (reg->type == PTR_TO_MAP_VALUE) {
+		tab = reg->map_ptr->fields_tab;
+	} else if (reg->type == (PTR_TO_BTF_ID | MEM_TYPE_LOCAL)) {
+		struct btf_struct_meta *meta = btf_find_struct_meta(reg->btf, reg->btf_id);
+		if (meta)
+			tab = meta->fields_tab;
+	}
+	return btf_type_fields_has_field(tab, BPF_SPIN_LOCK);
 }
 
 static bool type_is_rdonly_mem(u32 type)
@@ -5412,8 +5420,10 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	struct bpf_verifier_state *cur = env->cur_state;
 	bool is_const = tnum_is_const(reg->var_off);
-	struct bpf_map *map = reg->map_ptr;
 	u64 val = reg->var_off.value;
+	struct btf_type_fields *tab;
+	struct bpf_map *map = NULL;
+	struct btf *btf = NULL;
 
 	if (!is_const) {
 		verbose(env,
@@ -5421,19 +5431,32 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			regno);
 		return -EINVAL;
 	}
-	if (!map->btf) {
-		verbose(env,
-			"map '%s' has to have BTF in order to use bpf_spin_lock\n",
-			map->name);
-		return -EINVAL;
+	if (reg->type == PTR_TO_MAP_VALUE) {
+		map = reg->map_ptr;
+		if (!map->btf) {
+			verbose(env,
+				"map '%s' has to have BTF in order to use bpf_spin_lock\n",
+				map->name);
+			return -EINVAL;
+		}
+		tab = map->fields_tab;
+	} else {
+		struct btf_struct_meta *meta;
+
+		btf = reg->btf;
+		meta = btf_find_struct_meta(reg->btf, reg->btf_id);
+		if (meta)
+			tab = meta->fields_tab;
 	}
-	if (!btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
-		verbose(env, "map '%s' has no valid bpf_spin_lock\n", map->name);
+
+	if (!btf_type_fields_has_field(tab, BPF_SPIN_LOCK)) {
+		verbose(env, "%s '%s' has no valid bpf_spin_lock\n", map ? "map" : "local",
+			map ? map->name : "kptr");
 		return -EINVAL;
 	}
-	if (map->fields_tab->spin_lock_off != val + reg->off) {
+	if (tab->spin_lock_off != val + reg->off) {
 		verbose(env, "off %lld doesn't point to 'struct bpf_spin_lock' that is at %d\n",
-			val + reg->off, map->fields_tab->spin_lock_off);
+			val + reg->off, tab->spin_lock_off);
 		return -EINVAL;
 	}
 	if (is_lock) {
@@ -5649,13 +5672,19 @@ static const struct bpf_reg_types int_ptr_types = {
 	},
 };
 
+static const struct bpf_reg_types spin_lock_types = {
+	.types = {
+		PTR_TO_MAP_VALUE,
+		PTR_TO_BTF_ID | MEM_TYPE_LOCAL,
+	}
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
@@ -5759,8 +5788,13 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			}
 			arg_btf_id = compatible->btf_id;
 		}
-
-		if (meta->func_id == BPF_FUNC_kptr_xchg) {
+		if (meta->func_id == BPF_FUNC_spin_lock || meta->func_id == BPF_FUNC_spin_unlock) {
+			if (WARN_ON_ONCE(!(reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL))))
+				return -EFAULT;
+			/* process_spin_lock later checks whether bpf_spin_lock
+			 * field exists or not.
+			 */
+		} if (meta->func_id == BPF_FUNC_kptr_xchg) {
 			if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
 				return -EACCES;
 		} else {
@@ -5896,7 +5930,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		goto skip_type_check;
 
 	/* arg_btf_id and arg_size are in a union. */
-	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID)
+	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
+	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
 	err = check_reg_type(env, regno, arg_type, arg_btf_id, meta);
@@ -6504,9 +6539,10 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
-		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID && !fn->arg_btf_id[i])
-			return false;
-
+		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID)
+			return !!fn->arg_btf_id[i];
+		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_SPIN_LOCK)
+			return fn->arg_btf_id[i] == BPF_PTR_POISON;
 		if (base_type(fn->arg_type[i]) != ARG_PTR_TO_BTF_ID && fn->arg_btf_id[i] &&
 		    /* arg_btf_id and arg_size are in a union. */
 		    (base_type(fn->arg_type[i]) != ARG_PTR_TO_MEM ||
-- 
2.34.1

