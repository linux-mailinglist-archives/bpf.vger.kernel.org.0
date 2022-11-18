Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD19A62EB6A
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiKRB44 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240432AbiKRB4q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:56:46 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5F487A77
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:45 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id k5so3241049pjo.5
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybX6fMhSa4vuU1W+XoM5/E7U7c21StDO28whvo2I3y4=;
        b=B1qDJzVDcIcmMB2J95J7kowmKy07ZXqeeLb5NreHHXpC+amB6JY51F4RUiMW2jHyrv
         qDBw+LnBVLdYu6VvSxOXvSEWovYi4/FYSL0yA60plDNvdNFhcvYqAvv85mAiYyBEgtKz
         oIlST5zkl0JxHmBQzw6VqUZsrSwicnXwlpDyuRCWFmmzU3j5kNcHawrqm1QqqWaCLGjq
         v+0bKE7I8wlDxi/44FWz8R4AvihJzBjq9K1lFV6xwueTp9v0jnlaM2va+T89qv6W8IH/
         cVkSua5KJ95esY5pBT3g4Tk7OphnI8SQoZqJRcoL8A9wK42dNaYb/RpTRcFNpZl6e650
         MSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybX6fMhSa4vuU1W+XoM5/E7U7c21StDO28whvo2I3y4=;
        b=VsLOXowMEX5xLHLuAmCw08RpzrdnOHvM4dvGncX3j47BQ0gUMeUj0BcZ0YhzpkNSFp
         0rc2IViptdv0CQGoR4pVd++E8ZGba4LmpkfzmXe3XRvKAi4a3VZo5jYeOfBtYlgN7pL0
         2jki4Z6EPSycNGW0Vg/5vdhHKWCQ+8BbPSoFpbGh9ZBENicbvHsqrKEXC30A/ro3RFL/
         7XoAq3vup7Il/mVcwXhWNMvImfWZdHh5DTSh0DXlslRsSL+zAhG3m1wSP3jNgaZq1Mq5
         vIBkSZoWnb+Er7MF8vCAHIPk7phMbPNNCkJAgR2wYVz/04qOYiH4c/gkfYQpmTKTo9yH
         YJ5A==
X-Gm-Message-State: ANoB5pltwreJ/W4dvBBYM1J5uMDYaa4GX8Rk+5d4PB48RwR6HuNYrgFI
        hBzDTcXuf9wYBCm2yHgVcLXcCIFawio=
X-Google-Smtp-Source: AA0mqf4VIujm6OUStv3BgE53A+Cc8MS3DRhPKGpoHlwH8hYRBn2zfh7Dg0EUU7IBd+IfTZtgSLVkCA==
X-Received: by 2002:a17:90a:1950:b0:20d:2f:709d with SMTP id 16-20020a17090a195000b0020d002f709dmr11494473pjh.40.1668736604603;
        Thu, 17 Nov 2022 17:56:44 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id e89-20020a17090a6fe200b002137d3da760sm4182796pjk.39.2022.11.17.17.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:56:44 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 08/24] bpf: Allow locking bpf_spin_lock in allocated objects
Date:   Fri, 18 Nov 2022 07:25:58 +0530
Message-Id: <20221118015614.2013203-9-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8958; i=memxor@gmail.com; h=from:subject; bh=nC28BcuRnVcdofeigWWjo6bf4xTi3UQJvSPnYyO3KHo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXOSBlUDg1Jo7ro9vWGHVkxImyMS/RM+BbfpmKK AIslAOKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzgAKCRBM4MiGSL8RyjlyEA CB5XeSqBOpAL6Bk+cT2lrMLaS2j6NWuQUqKaTQxMba5NpCJnL85Gu6Z6SldNdtsWMt3on7JGedsaSo F8gv0v+iSZZ0ej6D5foLwFONaeR+cPrxH317nMyhzl+SK5gKhtYGVihzbCa7+16S7A0GNVD+MpUbNL p96iuXBTa3m/zKVLPJeqzkTTwbSrUgUinpY80B9t8MOLtcWle+kzshcylQmEKcI5izxs6z8dEKQMDQ /psOQK/3qJ19sjxR62vLhzJoXf60pqPP1lvOhZSFePGNtwld/vi3fu/sFLrfiV+5aTzAuLwS4R/Des k615DsQobVGW7BMcP3s92OYsppmsMnZzKD7gQAh2z51UDOPsDOs+fNCvnmEWE2DZUMnMZT/9PyIAYk 4A6k/mgfLl0FOGDe42vB7WvVycL/3HOiNoKcp+5FFplpSPVS2NRqzBwa9LVVqLIYXHESuy0DZi7+Gc 0GMAzQaoN00lKJr270qDHNtpkbMIOMpdJVpbFhWaw/HngWY4TkYdoARl8FZz71WNsLawy0U6yLKdbg 9F2kb4SwXVA9uiMaCbqokY4y6/sf6IEBI2gJ3gJ5F+pEI1ISd6sISUtjddY9ZfHJxT6l7PB9zTvcBe 7eZqLW6WvKC5rhczdSHZPTWZ4plTcjJxiDrfSP/72iyHwn77a4/q8zOTiMSQ==
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
 kernel/bpf/verifier.c | 90 +++++++++++++++++++++++++++++++------------
 2 files changed, 67 insertions(+), 25 deletions(-)

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
index 49e08c1c2c61..19467dda5dd9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -451,10 +451,24 @@ static bool reg_type_not_null(enum bpf_reg_type type)
 		type == PTR_TO_SOCK_COMMON;
 }
 
+static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
+{
+	struct btf_record *rec = NULL;
+	struct btf_struct_meta *meta;
+
+	if (reg->type == PTR_TO_MAP_VALUE) {
+		rec = reg->map_ptr->record;
+	} else if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
+		meta = btf_find_struct_meta(reg->btf, reg->btf_id);
+		if (meta)
+			rec = meta->record;
+	}
+	return rec;
+}
+
 static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 {
-	return reg->type == PTR_TO_MAP_VALUE &&
-	       btf_record_has_field(reg->map_ptr->record, BPF_SPIN_LOCK);
+	return btf_record_has_field(reg_btf_record(reg), BPF_SPIN_LOCK);
 }
 
 static bool type_is_rdonly_mem(u32 type)
@@ -5564,23 +5578,26 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
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
@@ -5588,8 +5605,10 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	struct bpf_verifier_state *cur = env->cur_state;
 	bool is_const = tnum_is_const(reg->var_off);
-	struct bpf_map *map = reg->map_ptr;
 	u64 val = reg->var_off.value;
+	struct bpf_map *map = NULL;
+	struct btf *btf = NULL;
+	struct btf_record *rec;
 
 	if (!is_const) {
 		verbose(env,
@@ -5597,19 +5616,27 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
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
+	} else {
+		btf = reg->btf;
 	}
-	if (!btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
-		verbose(env, "map '%s' has no valid bpf_spin_lock\n", map->name);
+
+	rec = reg_btf_record(reg);
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
@@ -5815,13 +5842,19 @@ static const struct bpf_reg_types int_ptr_types = {
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
@@ -5946,6 +5979,11 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
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
@@ -6062,7 +6100,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		goto skip_type_check;
 
 	/* arg_btf_id and arg_size are in a union. */
-	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID)
+	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
+	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
 	err = check_reg_type(env, regno, arg_type, arg_btf_id, meta);
@@ -6680,9 +6719,10 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
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

