Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513CB5FD4B7
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJMGYL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJMGYI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:24:08 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B060123474
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:06 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k9so527681pll.11
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peL7jR0uyXfMlhqHzOfASc20MhusOcMWNQv8/yBlnIQ=;
        b=fN7P+WLchUlkN5tbiGCLRLHQrisKZCugXpGbAnnBMRhZu+gMUa9bFX1eo/+ZMX3Flv
         T/17Ns2XjOOrgcRDWKzIdRZdKzTBLXkyNY2u2HvcCGEkgfBXVr94SPl2g1+Bii8KCUcc
         onhb+f/lnUgxFMsMUBj22lYVx1Pmv1H9STsAhJG1kqQMAtgG939VQxb/4cbo/9J7Ne09
         S2xvXriuq5o7ntiQ55HYaPZSWdqB7r20GPiu3qXgaaycuTRR8k7aUhjyM0HNRLqf9ZSk
         WJdcVFcb5TGjXXrQbOg4+LiYI77Wee3eNUXlWecee8RTSB39KdXvSiYr2/vkXneIMRhy
         Idbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peL7jR0uyXfMlhqHzOfASc20MhusOcMWNQv8/yBlnIQ=;
        b=mNd0wJFDe3Rq2JwxJiFyulLqSt4LESP4DO+sz9X6isL1T3Tt4Ogwf2jsZHiQR1qQ0u
         dsvdolffilxYGrDvLB6s8nzYxXXlowyyjMHSaPbZ4xwp4cwvNlpr1OVrZTwkJhJip1b9
         In+5PQlgwexBbwglfVnBzaHJNvFFD64uSgWVntuHFUBoV5XVHk+zNFYfuaLNah3kdZZI
         oyGEJV9PJegt6x4OZOyWcXwVMEq49pDjD9YrbQeDf76MrsFbuquRRmbAHrU3QfamBjhG
         GAESoRKNYBxivjz9NQngxYRhTeN7VKDy43NyjLzpmR97UZfIyQnv9kjdi5pQ7QSYTAxh
         mWMA==
X-Gm-Message-State: ACrzQf2mlnX+W078HoN5D1fz65ShpyrE61hDOlfdhr2aAjptjI/Ze3MJ
        fuVNBiiIht/sJIamaSX2VvJuRRR5OSE=
X-Google-Smtp-Source: AMsMyM5a1BB/c5yOs5K45eA9ol5Lx1mjbLKMNlg40910B6v/M5PeRqb5hQYTGfexc2d3eYM0AIcmxg==
X-Received: by 2002:a17:90a:1690:b0:20a:8f70:14bb with SMTP id o16-20020a17090a169000b0020a8f7014bbmr9359920pja.115.1665642245392;
        Wed, 12 Oct 2022 23:24:05 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903124b00b00176dd41320dsm11856712plh.119.2022.10.12.23.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:24:05 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 13/25] bpf: Support locking bpf_spin_lock in local kptr
Date:   Thu, 13 Oct 2022 11:52:51 +0530
Message-Id: <20221013062303.896469-14-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6521; i=memxor@gmail.com; h=from:subject; bh=54pNPXvh4Xftyy72cC3AW5ZwrPuoLw0Km0OoiI51cUI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67DrLd/eMgrcsit3Fp7KwBn8I0yccnk7GYrYas8 psdk4luJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euwwAKCRBM4MiGSL8RygMGEA CbooB/gC2zKoo0RpJciz/PRO3+LkhBFVZpicahbZcRqU6Wcq/2X+Udl4WdBi6Nu0pbid7YzhUFS/1R Lm1MEUppLxQl0p09BY4uF7mnkoLSHnS3k8IR9fFVNFGe3q/8f6mgQ0ItSGPVAPT0qN5kwRoWkhqwpB /A8bbtE7paA8JnhhCLKK6VNmNx0BsGWmAcWq9oUDEUAQBcR7xAi76mhZ2/bCiRJ47pFY5t0FGi2Egc gXG2uoprqlekSKG90d0a874mfmDbE+ZQz+O/BT2wP8SwK9R3nVx4CYHG6ZDedTtPGuc35eiQYqDeni EiOWqGn4Z2NW+UYRKF5UGv/pOwXu7tSM9cmH43o80ICUC/02WT2CU4tNiaWKsR2TcXL6RD4hbGl/7S usdPpnX7SHtkFZutO1r4VIHAWeoV2SNxznh+dQzeBr6ZqsRse3tXg8DnZVPDNjk6iNvcTjCzGfDP8n oqANaYpn/ntnv/eAB4qGP8YsYNJqA5Rww8mzGchPc/np/pjlNvWeyhNcBunPyG6hCQH5Q3+9IGc9PT 5Bx+pBxblEIynM7tu/TzcEtBnHreaFHe1Baemgcdp6OfvQc2rzws96xIv/nfYryqU8ANW+6OzYj5I/ jN+j7laJ/gFTG4mp76Y3zVhbjb6v48QDCDkeBf5vtR2WEzyS3Maevf9K7sIw==
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
 kernel/bpf/verifier.c | 70 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a2f2fe43916b..238103dc6c5e 100644
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
index 6ee8c06c2080..5114cc97cdd4 100644
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
@@ -5780,6 +5809,11 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 				return -EACCES;
 			}
 		}
+	} else if (reg->type == (PTR_TO_BTF_ID | MEM_TYPE_LOCAL)) {
+		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock) {
+			verbose(env, "verifier internal error: unimplemented handling of local kptr\n");
+			return -EFAULT;
+		}
 	}
 
 	return 0;
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
2.38.0

