Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F0162E8CD
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiKQW4B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiKQWzs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:55:48 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05806186FC
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:55:48 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 136so3465277pga.1
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbEyJK9HHakkaLmZTBG+aVA2e5HoR3xLLcJ7jqCnp4M=;
        b=PHGxijOIt5+W8su/yKT1fiSwsuZfSCQx4gDDlx9RwLzUXU0PMfBXE1Mq4mGM13gmKm
         Diqs32ia79k8JRpBKWJ85XFcClbRn/6lDnITprrKJToV48y+sRr6qjJou6/xdjMpMeAj
         rjm/Lz12rUW+VQ4xnIkSUDjR8xXOOKb+VgLHjkE9FfTH8KzJEC8So5SbqPVgo2Paq20i
         13tabbEEz60GOe12IemPet5TyOu96xKQA4UdHf2soOUX/efVjZXaumVIJ4rP4n6acVe6
         RDlqlGukNStGN5jOdLYFvKr1HQ+ep+o0N7W4qrWqUYlvpj4olm9s1V7O4nTZvocNYrP4
         hbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbEyJK9HHakkaLmZTBG+aVA2e5HoR3xLLcJ7jqCnp4M=;
        b=T8iFpghptT8ptwniv6GlQennBe9+q3gm3dFYhkPNN2GVGeC6nt8yD0wHRIO7I3n9O0
         lgreF9Oeh+Cpm81weZCB48aqUZBsxv9dELKB+ap8KdDe2G8JSbDBgOqILKCS4r8EQZZ0
         hH5BKeSEFw39sNvWMDz7fPlzFZvZpMXwS7kg0sS2sysCRlTVKIt74NOOFsWd5fL5TGgr
         yO+IWO3XO/nLkLhmzFaYi3iBHJP5+oKOLRzTX54wxGPGcyYWb3B/IVJhzDV+pk+ojBzy
         q2GNa3nyTRmszba/ENvBo593nLT3+9LuoOHH+EcQFsYLPTUpIEiB59JMotYpe4FqjuhP
         obyg==
X-Gm-Message-State: ANoB5pkV+hlpzOHarKBakC3QBuz9utBQV6+vITN7qGGc/bKKrW2l3wXa
        gfbaDkWA0PBdkKojJwa2ZgeJn1z2Mqk=
X-Google-Smtp-Source: AA0mqf6FlaVmG04nOW2KxrzCl3PP96Q6ukmBFyax0pzay0MRBgY4bizguQJJbP4bkqC3kV8C9Bib8A==
X-Received: by 2002:aa7:8608:0:b0:52f:db84:81cf with SMTP id p8-20020aa78608000000b0052fdb8481cfmr5104465pfn.26.1668725747259;
        Thu, 17 Nov 2022 14:55:47 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b00188fcc4fc00sm243982pln.79.2022.11.17.14.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:55:46 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v9 08/23] bpf: Allow locking bpf_spin_lock in allocated objects
Date:   Fri, 18 Nov 2022 04:24:55 +0530
Message-Id: <20221117225510.1676785-9-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117225510.1676785-1-memxor@gmail.com>
References: <20221117225510.1676785-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8926; i=memxor@gmail.com; h=from:subject; bh=ae8q9s9cDVzghCLBYYIt/0OQIWliZosyXk12KKyNFuE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdrkbtufLpx78Y1jeLtm63SLV+2UVK0aVakc7X0u1 XlbMtHmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3a5GwAKCRBM4MiGSL8Ryo9+EA CoXWfBRYL+HF5wKNAOr4XJA51wZ0cxE3bQPboLhp/FI3Edgdrk+aLkIfQBFs7dFZovRfLy0EPTsFt6 +BahZAub9ArFViJHFU60nGPqFtDbhprqOcGf0TTMWcEyhBuCbcbad8EsudyvssoSMCMrgLAWIaXt6J Tdlm7LVruFHvdvvLBocBIMn2r83MRHByluLu1NOR3wjvwzM+4il0yUtOHQ11sBVxXUv/qGkpWgnDEK iMvf4ONDIeyeUn+7mLZdSnNXl0joEM/XRzRdK2YqcdPYlLvAbXdrwPrb9OqzxblfQeWe+Bk/r8/RD7 F6A04Rn+AC1Sh4oKeep3qbr5M2xb3cX4P/bto6HJg0aqFOyIMAsJw6q142QRIuvALvSAatZVPUr39a f75C58u8fOZ3DtYlm1LYMje6rJf4I26iIjk8rdBYz6wssBMA3VLsCmOgyVM4K4p5UGHfzAUofj4n3c sbPa26jQaZ0Iq+wty4OCsEkJ9AJsSAaVEolq8wFtp1/MT9+rLKm3+Xt/3VMfZgsTfgLvZC0jti3vFG iOa/iyPiywpI1PCGJBd5qiOMkYfonObIn1UaXNXPsoq24OIBfWFJYHd5MGmPHrUR8aCxrrzWku9RyV JSfjaR6BT83AxFOgzvqhufLWFv2b25ynvANIgEpnPCB5M//VVU7eozncz7xA==
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

Allow locking a bpf_spin_lock in an allocated object, in addition to
already supported map value pointers. The handling is similar to that of
map values, by just preserving the reg->id of PTR_TO_BTF_ID | MEM_ALLOC
as well, and adjusting process_spin_lock to work with them and remember
the id in verifier state.

Refactor the existing process_spin_lock to work with PTR_TO_BTF_ID |
MEM_ALLOC in addition to PTR_TO_MAP_VALUE. We need to update the
reg_may_point_to_spin_lock which is used in mark_ptr_or_null_reg to
preserve reg->id, that will be used in env->cur_state->active_spin_lock
to remember the currently held spin lock.

Also update the comment describing bpf_spin_lock implementation details
to also talk about PTR_TO_BTF_ID | MEM_ALLOC type.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c  |  2 +
 kernel/bpf/verifier.c | 89 +++++++++++++++++++++++++++++++------------
 2 files changed, 66 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7bc71995f17c..5bc0b9f0f306 100644
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
index 49e08c1c2c61..8eddecfc3a5e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -453,8 +453,16 @@ static bool reg_type_not_null(enum bpf_reg_type type)
 
 static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 {
-	return reg->type == PTR_TO_MAP_VALUE &&
-	       btf_record_has_field(reg->map_ptr->record, BPF_SPIN_LOCK);
+	struct btf_record *rec = NULL;
+
+	if (reg->type == PTR_TO_MAP_VALUE) {
+		rec = reg->map_ptr->record;
+	} else if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
+		struct btf_struct_meta *meta = btf_find_struct_meta(reg->btf, reg->btf_id);
+		if (meta)
+			rec = meta->record;
+	}
+	return btf_record_has_field(rec, BPF_SPIN_LOCK);
 }
 
 static bool type_is_rdonly_mem(u32 type)
@@ -5564,23 +5572,26 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
 }
 
 /* Implementation details:
- * bpf_map_lookup returns PTR_TO_MAP_VALUE_OR_NULL
+ * bpf_map_lookup returns PTR_TO_MAP_VALUE_OR_NULL.
+ * bpf_obj_new returns PTR_TO_BTF_ID | MEM_ALLOC | PTR_MAYBE_NULL.
  * Two bpf_map_lookups (even with the same key) will have different reg->id.
- * For traditional PTR_TO_MAP_VALUE the verifier clears reg->id after
- * value_or_null->value transition, since the verifier only cares about
- * the range of access to valid map value pointer and doesn't care about actual
- * address of the map element.
+ * Two separate bpf_obj_new will also have different reg->id.
+ * For traditional PTR_TO_MAP_VALUE or PTR_TO_BTF_ID | MEM_ALLOC, the verifier
+ * clears reg->id after value_or_null->value transition, since the verifier only
+ * cares about the range of access to valid map value pointer and doesn't care
+ * about actual address of the map element.
  * For maps with 'struct bpf_spin_lock' inside map value the verifier keeps
  * reg->id > 0 after value_or_null->value transition. By doing so
  * two bpf_map_lookups will be considered two different pointers that
- * point to different bpf_spin_locks.
+ * point to different bpf_spin_locks. Likewise for pointers to allocated objects
+ * returned from bpf_obj_new.
  * The verifier allows taking only one bpf_spin_lock at a time to avoid
  * dead-locks.
  * Since only one bpf_spin_lock is allowed the checks are simpler than
  * reg_is_refcounted() logic. The verifier needs to remember only
  * one spin_lock instead of array of acquired_refs.
- * cur_state->active_spin_lock remembers which map value element got locked
- * and clears it after bpf_spin_unlock.
+ * cur_state->active_spin_lock remembers which map value element or allocated
+ * object got locked and clears it after bpf_spin_unlock.
  */
 static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			     bool is_lock)
@@ -5588,8 +5599,10 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	struct bpf_verifier_state *cur = env->cur_state;
 	bool is_const = tnum_is_const(reg->var_off);
-	struct bpf_map *map = reg->map_ptr;
+	struct btf_record *rec = NULL;
 	u64 val = reg->var_off.value;
+	struct bpf_map *map = NULL;
+	struct btf *btf = NULL;
 
 	if (!is_const) {
 		verbose(env,
@@ -5597,19 +5610,32 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
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
+		rec = map->record;
+	} else {
+		struct btf_struct_meta *meta;
+
+		btf = reg->btf;
+		meta = btf_find_struct_meta(reg->btf, reg->btf_id);
+		if (meta)
+			rec = meta->record;
 	}
-	if (!btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
-		verbose(env, "map '%s' has no valid bpf_spin_lock\n", map->name);
+
+	if (!btf_record_has_field(rec, BPF_SPIN_LOCK)) {
+		verbose(env, "%s '%s' has no valid bpf_spin_lock\n", map ? "map" : "local",
+			map ? map->name : "kptr");
 		return -EINVAL;
 	}
-	if (map->record->spin_lock_off != val + reg->off) {
+	if (rec->spin_lock_off != val + reg->off) {
 		verbose(env, "off %lld doesn't point to 'struct bpf_spin_lock' that is at %d\n",
-			val + reg->off, map->record->spin_lock_off);
+			val + reg->off, rec->spin_lock_off);
 		return -EINVAL;
 	}
 	if (is_lock) {
@@ -5815,13 +5841,19 @@ static const struct bpf_reg_types int_ptr_types = {
 	},
 };
 
+static const struct bpf_reg_types spin_lock_types = {
+	.types = {
+		PTR_TO_MAP_VALUE,
+		PTR_TO_BTF_ID | MEM_ALLOC,
+	}
+};
+
 static const struct bpf_reg_types fullsock_types = { .types = { PTR_TO_SOCKET } };
 static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
 static const struct bpf_reg_types ringbuf_mem_types = { .types = { PTR_TO_MEM | MEM_RINGBUF } };
 static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
 static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
-static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
 static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
@@ -5946,6 +5978,11 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 				return -EACCES;
 			}
 		}
+	} else if (type_is_alloc(reg->type)) {
+		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock) {
+			verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
+			return -EFAULT;
+		}
 	}
 
 	return 0;
@@ -6062,7 +6099,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		goto skip_type_check;
 
 	/* arg_btf_id and arg_size are in a union. */
-	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID)
+	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
+	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
 	err = check_reg_type(env, regno, arg_type, arg_btf_id, meta);
@@ -6680,9 +6718,10 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
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
2.38.1

