Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D215AC679
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiIDUmY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiIDUmS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:18 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475632CE00
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:16 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id x73so2051287ede.10
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8/CFT6Y3nmEO53/jh/XdjMGE3EGIIWr/sn8UeILSdBE=;
        b=X/bsKXbW2odHkwFb7TvlMp74lV0pjviDnocrMWcUiJ+p1Afjq39Bzcc41gb4oPX0qg
         SAzUb146j3rTNj+K++CSsDkuK5pkLoN0275T3y8oq2t36zi29f3xTniH8zCm9MNNLiKX
         qwwCmW+InAO3DLAe9ecMijRFBK3QjB+eUfTzf12FxQkgLcPlTm63jakWAljYmb3ujmp1
         Mk4ZeEh3RDqty100hBu34m/4HAKcBmoCLfgWrMcccxlBQICM8uv1e3/RaiQwqsVLV6Jg
         c1wV9HSqGbAgKvcjGgO5h1aHiShKE0GE1zyw5ijcslqVDSIpoV8uq/rPck/k/3lC5v8u
         mQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8/CFT6Y3nmEO53/jh/XdjMGE3EGIIWr/sn8UeILSdBE=;
        b=UP5feN3N4fFpKqCqe5xmpqsO/P3uhBXvOzwV+03Uw9Op6ZvMi/+m24xWgb6fL8VFSa
         bTUeskUEgPCg4G8fbrdXN5HmFoQrkJn8gHNALadIlruZeo/IkyA4cfG8g8ac0BuN/N/G
         8N0SDh8jjlPJlGESC2kQSgBMjFWfbJ99Jq7rcbeCgFch5+kvG9DjxF6aNwafxED/qILW
         ZsObnfD4CALlCMtVReIm0Lfs977ZyA1dXu51M4enjzpFftgzDmUrphQBiZNvPGl3ZYMU
         f9TcmR0aWzC6wgAquSF9TYx4rGjw9H5kcJtmsAt+j3KkwKsHSe2UIpuot2b1NWlQIU5q
         3utA==
X-Gm-Message-State: ACgBeo1vm/1BAvZGX1Q2tKZhvAAlTnjbzSTSLmVSnCEk7uPt5ueVT96g
        4YRUYmrFSb8gVUYMFsVVJIDMzx8e/fpCHw==
X-Google-Smtp-Source: AA6agR6q5aKwIt78+wNy4x5nyYCDl6EySr8Qy7xIjQhGWlgKvo0bwf8UeAZr9Wki041qj+bW1i9Ycg==
X-Received: by 2002:a05:6402:1d54:b0:447:fcf3:a1cc with SMTP id dz20-20020a0564021d5400b00447fcf3a1ccmr36047997edb.19.1662324135441;
        Sun, 04 Sep 2022 13:42:15 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id q17-20020a1709064cd100b0073d678f50bfsm4137322ejt.164.2022.09.04.13.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:15 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 25/32] bpf: Allow storing local kptrs in BPF maps
Date:   Sun,  4 Sep 2022 22:41:38 +0200
Message-Id: <20220904204145.3089-26-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20559; i=memxor@gmail.com; h=from:subject; bh=Q+HVdB1p6s8XuS4l6UTGqkaqWO5QUOPtZhECm0+mz78=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1xKbMKidUEswq5RhGsjeMNreNMvM+VwItgS8Lv l/wHVfaJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcQAKCRBM4MiGSL8RylXBD/ 9+C3Si2KOe3SQHNz1aaqa0rjJDNtWd05l12NauB67qbEF8WYv93hCqKD5XHpcltsJVvfCz5FnG1caK KFyVQ1vdMvRul6LAQb0Yi0T+feu9Fe6fDEVBwyg1X3QAPPlkIMTvNVlRc6QnDgtaO6PWDrTXR2mH0U e26PaFOH3dqNFNFahqps6LPBOZkPofA/TkKcadpeUtpSVLtAkYjh1h5spuSpXdTyort8qKY02rpz9i BxYxs/YOmAjWbLwdYMq4NmUB7TasCormjV3KSKbuhJbNMhwUzzSYsNc54xMnyueOHRng/SxFzoPlEG hiFoQvFgBAqawmGCwMEB5i2HS/4NpYvC0EE0QYQHcGgMdyoqMq/I8Sp6orGUT4Vkro3LHP4nbgcgNE nBZcvCJffWRUp2WY2oSnT/lDwhoFcBFaxkKhkxUq091XrG2gMbNghjCjQRp+xrbOuP40kIveBnuiO3 j1vG324oOVItUxvvJKAbFxhxrTHVxSzybYf5ugZf12HH1LbhM7Cji2ot21BP2wra304223AgyXhN78 Zw/cwgk4khSuZVT3w/hksC/All3aRJX/3pGlpYqnO/7mSiV4Sirm6j9OfvSgZqbjNFJMArVih0d24J 1TiIgbxV1CnF6MuiTjg5zXOqfmnPAeppz0gGmAybXtVlpR2FpnbqZZ/r1RNQ==
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

Enable users to store local kptrs allocated from bpf_kptr_alloc into BPF
maps. These are always referenced, hence they can only be stored in
fields with kptr_ref type tag.

However, compared to normal kptrs, local kptrs point to types in program
BTF. To tell the verifier which BTF to search the target of the pointer
type in map value, introduce a new "local" type tag that can be applied
with kptr_ref type tag.

When both are combined, this means we will not search the type in kernel
BTF, and stash reference to the map BTF instead. When program uses this
map, this map BTF must match program BTF for it to be able to interact
with this local kptr in map value.

Later, more complex type matching (field by field) can be introduced to
allow the case where program BTF differs from map BTF, but for now that
is not done.

Note that for these local kptr fields, bpf_ktpr_xchg will set the type
flag 'MEM_TYPE_LOCAL' so that the type information is preserved when
moving value from program to map and vice versa.

Only fully constructed local kptrs can be moved into maps, i.e. escaping
the program into the map is not possible in constructing or destructing
phase. We may allow allocated but not initialized local kptrs in maps in
the future. This would require that all fields are either in unknown or
destructed state (i.e. state right after allocation or right after
destruction of last field needing destruction). It would allow holding
ownership of storage while the object on it has been destroyed. This
would allow reusing same storage for multiple types that may fit in it.

Later commit will wire up freeing of these local kptr fields from the
map value.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   |  7 +++-
 include/linux/btf.h   |  2 +-
 kernel/bpf/btf.c      | 75 ++++++++++++++++++++++++++++---------------
 kernel/bpf/helpers.c  |  4 +--
 kernel/bpf/syscall.c  | 40 +++++++++++++++++++++--
 kernel/bpf/verifier.c | 63 ++++++++++++++++++++++++++----------
 6 files changed, 142 insertions(+), 49 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 910aa891b97a..3353c47fefa9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -182,7 +182,9 @@ enum {
 enum bpf_off_type {
 	BPF_KPTR_UNREF,
 	BPF_KPTR_REF,
+	BPF_LOCAL_KPTR_REF,
 	BPF_LIST_HEAD,
+	BPF_OFF_TYPE_MAX,
 };
 
 struct bpf_map_value_off_desc {
@@ -546,6 +548,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_LONG,	/* pointer to long */
 	ARG_PTR_TO_SOCKET,	/* pointer to bpf_sock (fullsock) */
 	ARG_PTR_TO_BTF_ID,	/* pointer to in-kernel struct */
+	ARG_PTR_TO_DYN_BTF_ID,  /* pointer to in-kernel or local struct */
 	ARG_PTR_TO_ALLOC_MEM,	/* pointer to dynamically allocated memory */
 	ARG_CONST_ALLOC_SIZE_OR_ZERO,	/* number of allocated bytes requested */
 	ARG_PTR_TO_BTF_ID_SOCK_COMMON,	/* pointer to in-kernel sock_common or bpf-mirrored bpf_sock */
@@ -565,7 +568,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
 	ARG_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_ALLOC_MEM,
 	ARG_PTR_TO_STACK_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
-	ARG_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
+	ARG_PTR_TO_DYN_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_DYN_BTF_ID,
 	/* pointer to memory does not need to be initialized, helper function must fill
 	 * all bytes or clear them in error case.
 	 */
@@ -591,6 +594,7 @@ enum bpf_return_type {
 	RET_PTR_TO_ALLOC_MEM,		/* returns a pointer to dynamically allocated memory */
 	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a btf_id */
 	RET_PTR_TO_BTF_ID,		/* returns a pointer to a btf_id */
+	RET_PTR_TO_DYN_BTF_ID,		/* returns a pointer to a btf_id determined dynamically */
 	__BPF_RET_TYPE_MAX,
 
 	/* Extended ret_types. */
@@ -601,6 +605,7 @@ enum bpf_return_type {
 	RET_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_ALLOC_MEM,
 	RET_PTR_TO_DYNPTR_MEM_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_ALLOC_MEM,
 	RET_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
+	RET_PTR_TO_DYN_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_DYN_BTF_ID,
 
 	/* This must be the last entry. Its purpose is to ensure the enum is
 	 * wide enough to hold the higher bits reserved for bpf_type_flag.
diff --git a/include/linux/btf.h b/include/linux/btf.h
index bd57a9cae12c..b7d704f730c2 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -157,7 +157,7 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   u32 expected_offset, u32 expected_size);
 int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
 int btf_find_timer(const struct btf *btf, const struct btf_type *t);
-struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
+struct bpf_map_value_off *btf_parse_kptrs(struct btf *btf,
 					  const struct btf_type *t);
 struct bpf_map_value_off *btf_parse_list_heads(struct btf *btf,
 					       const struct btf_type *t);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e2ac088cb64f..54267b52ff0c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3224,8 +3224,10 @@ static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
 static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 			 u32 off, int sz, struct btf_field_info *info)
 {
-	enum bpf_off_type type;
+	enum bpf_off_type type = BPF_OFF_TYPE_MAX;
+	bool local = false;
 	u32 res_id;
+	int i;
 
 	/* Permit modifiers on the pointer itself */
 	if (btf_type_is_volatile(t))
@@ -3237,16 +3239,29 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 
 	if (!btf_type_is_type_tag(t))
 		return BTF_FIELD_IGNORE;
-	/* Reject extra tags */
-	if (btf_type_is_type_tag(btf_type_by_id(btf, t->type)))
-		return -EINVAL;
-	if (!strcmp("kptr", __btf_name_by_offset(btf, t->name_off)))
-		type = BPF_KPTR_UNREF;
-	else if (!strcmp("kptr_ref", __btf_name_by_offset(btf, t->name_off)))
-		type = BPF_KPTR_REF;
-	else
-		return -EINVAL;
-
+	/* Maximum two type tags supported */
+	for (i = 0; i < 2; i++) {
+		if (!strcmp("kptr", __btf_name_by_offset(btf, t->name_off))) {
+			type = BPF_KPTR_UNREF;
+		} else if (!strcmp("kptr_ref", __btf_name_by_offset(btf, t->name_off))) {
+			type = BPF_KPTR_REF;
+		} else if (!strcmp("local", __btf_name_by_offset(btf, t->name_off))) {
+			local = true;
+		} else {
+			return -EINVAL;
+		}
+		if (!btf_type_is_type_tag(btf_type_by_id(btf, t->type)))
+			break;
+		/* Reject extra tags */
+		if (i == 1)
+			return -EINVAL;
+		t = btf_type_by_id(btf, t->type);
+	}
+	if (local) {
+		if (type == BPF_KPTR_UNREF)
+			return -EINVAL;
+		type = BPF_LOCAL_KPTR_REF;
+	}
 	/* Get the base type */
 	t = btf_type_skip_modifiers(btf, t->type, &res_id);
 	/* Only pointer to struct is allowed */
@@ -3521,12 +3536,12 @@ int btf_find_timer(const struct btf *btf, const struct btf_type *t)
 	return info.off;
 }
 
-struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
+struct bpf_map_value_off *btf_parse_kptrs(struct btf *btf,
 					  const struct btf_type *t)
 {
 	struct btf_field_info info_arr[BPF_MAP_VALUE_OFF_MAX];
 	struct bpf_map_value_off *tab;
-	struct btf *kernel_btf = NULL;
+	struct btf *kptr_btf = NULL;
 	struct module *mod = NULL;
 	int ret, i, nr_off;
 
@@ -3547,13 +3562,21 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 
 		/* Find type in map BTF, and use it to look up the matching type
 		 * in vmlinux or module BTFs, by name and kind.
+		 * For local kptrs, stash reference to map BTF and type ID same
+		 * as in info_arr.
 		 */
-		t = btf_type_by_id(btf, info_arr[i].kptr.type_id);
-		id = bpf_find_btf_id(__btf_name_by_offset(btf, t->name_off), BTF_INFO_KIND(t->info),
-				     &kernel_btf);
-		if (id < 0) {
-			ret = id;
-			goto end;
+		if (info_arr[i].kptr.type == BPF_LOCAL_KPTR_REF) {
+			kptr_btf = btf;
+			btf_get(kptr_btf);
+			id = info_arr[i].kptr.type_id;
+		} else {
+			t = btf_type_by_id(btf, info_arr[i].kptr.type_id);
+			id = bpf_find_btf_id(__btf_name_by_offset(btf, t->name_off), BTF_INFO_KIND(t->info),
+					     &kptr_btf);
+			if (id < 0) {
+				ret = id;
+				goto end;
+			}
 		}
 
 		/* Find and stash the function pointer for the destruction function that
@@ -3569,20 +3592,20 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 			 * can be used as a referenced pointer and be stored in a map at
 			 * the same time.
 			 */
-			dtor_btf_id = btf_find_dtor_kfunc(kernel_btf, id);
+			dtor_btf_id = btf_find_dtor_kfunc(kptr_btf, id);
 			if (dtor_btf_id < 0) {
 				ret = dtor_btf_id;
 				goto end_btf;
 			}
 
-			dtor_func = btf_type_by_id(kernel_btf, dtor_btf_id);
+			dtor_func = btf_type_by_id(kptr_btf, dtor_btf_id);
 			if (!dtor_func) {
 				ret = -ENOENT;
 				goto end_btf;
 			}
 
-			if (btf_is_module(kernel_btf)) {
-				mod = btf_try_get_module(kernel_btf);
+			if (btf_is_module(kptr_btf)) {
+				mod = btf_try_get_module(kptr_btf);
 				if (!mod) {
 					ret = -ENXIO;
 					goto end_btf;
@@ -3592,7 +3615,7 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 			/* We already verified dtor_func to be btf_type_is_func
 			 * in register_btf_id_dtor_kfuncs.
 			 */
-			dtor_func_name = __btf_name_by_offset(kernel_btf, dtor_func->name_off);
+			dtor_func_name = __btf_name_by_offset(kptr_btf, dtor_func->name_off);
 			addr = kallsyms_lookup_name(dtor_func_name);
 			if (!addr) {
 				ret = -EINVAL;
@@ -3604,7 +3627,7 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 		tab->off[i].offset = info_arr[i].off;
 		tab->off[i].type = info_arr[i].kptr.type;
 		tab->off[i].kptr.btf_id = id;
-		tab->off[i].kptr.btf = kernel_btf;
+		tab->off[i].kptr.btf = kptr_btf;
 		tab->off[i].kptr.module = mod;
 	}
 	tab->nr_off = nr_off;
@@ -3612,7 +3635,7 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 end_mod:
 	module_put(mod);
 end_btf:
-	btf_put(kernel_btf);
+	btf_put(kptr_btf);
 end:
 	while (i--) {
 		btf_put(tab->off[i].kptr.btf);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9d5709441800..168460a03ec3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1385,10 +1385,10 @@ BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)
 static const struct bpf_func_proto bpf_kptr_xchg_proto = {
 	.func         = bpf_kptr_xchg,
 	.gpl_only     = false,
-	.ret_type     = RET_PTR_TO_BTF_ID_OR_NULL,
+	.ret_type     = RET_PTR_TO_DYN_BTF_ID_OR_NULL,
 	.ret_btf_id   = BPF_PTR_POISON,
 	.arg1_type    = ARG_PTR_TO_KPTR,
-	.arg2_type    = ARG_PTR_TO_BTF_ID_OR_NULL | OBJ_RELEASE,
+	.arg2_type    = ARG_PTR_TO_DYN_BTF_ID_OR_NULL | OBJ_RELEASE,
 	.arg2_btf_id  = BPF_PTR_POISON,
 };
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e1749e0d2143..1af9a7cba08c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -590,6 +590,39 @@ bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_ma
 				       map_value_has_kptrs(map_b));
 }
 
+static void bpf_free_local_kptr(const struct btf *btf, u32 btf_id, void *kptr)
+{
+	struct list_head *list, *olist;
+	u32 offset, list_node_off;
+	const struct btf_type *t;
+	void *entry;
+	int ret;
+
+	if (!kptr)
+		return;
+	/* We must free bpf_list_head in local kptr */
+	t = btf_type_by_id(btf, btf_id);
+	/* TODO: We should just populate this info once in struct btf, and then
+	 * do quick lookups into it. Instead of offset, table would be keyed by
+	 * btf_id.
+	 */
+	ret = __btf_local_type_has_bpf_list_head(btf, t, &offset, NULL, &list_node_off);
+	if (ret <= 0)
+		goto free_kptr;
+	/* List elements for bpf_list_head in local kptr cannot have
+	 * bpf_list_head again. Hence, just iterate and kfree them.
+	 */
+	olist = list = kptr + offset;
+	list = list->next;
+	while (list != olist) {
+		entry = list - list_node_off;
+		list = list->next;
+		kfree(entry);
+	}
+free_kptr:
+	kfree(kptr);
+}
+
 /* Caller must ensure map_value_has_kptrs is true. Note that this function can
  * be called on a map value while the map_value is visible to BPF programs, as
  * it ensures the correct synchronization, and we already enforce the same using
@@ -613,7 +646,10 @@ void bpf_map_free_kptrs(struct bpf_map *map, void *map_value)
 			continue;
 		}
 		old_ptr = xchg(btf_id_ptr, 0);
-		off_desc->kptr.dtor((void *)old_ptr);
+		if (off_desc->type == BPF_LOCAL_KPTR_REF)
+			bpf_free_local_kptr(off_desc->kptr.btf, off_desc->kptr.btf_id, (void *)old_ptr);
+		else
+			off_desc->kptr.dtor((void *)old_ptr);
 	}
 }
 
@@ -1102,7 +1138,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			return -EOPNOTSUPP;
 	}
 
-	map->kptr_off_tab = btf_parse_kptrs(btf, value_type);
+	map->kptr_off_tab = btf_parse_kptrs((struct btf *)btf, value_type);
 	if (map_value_has_kptrs(map)) {
 		if (!bpf_capable()) {
 			ret = -EPERM;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5e0044796671..d2c4ffc80f4d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3713,13 +3713,18 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	/* Only unreferenced case accepts untrusted pointers */
 	if (off_desc->type == BPF_KPTR_UNREF)
 		perm_flags |= PTR_UNTRUSTED;
+	else if (off_desc->type == BPF_LOCAL_KPTR_REF)
+		perm_flags |= MEM_TYPE_LOCAL;
 
 	if (base_type(reg->type) != PTR_TO_BTF_ID || (type_flag(reg->type) & ~perm_flags))
 		goto bad_type;
 
-	if (!btf_is_kernel(reg->btf)) {
+	if (off_desc->type != BPF_LOCAL_KPTR_REF && !btf_is_kernel(reg->btf)) {
 		verbose(env, "R%d must point to kernel BTF\n", regno);
 		return -EINVAL;
+	} else if (off_desc->type == BPF_LOCAL_KPTR_REF && btf_is_kernel(reg->btf)) {
+		verbose(env, "R%d must point to program BTF\n", regno);
+		return -EINVAL;
 	}
 	/* We need to verify reg->type and reg->btf, before accessing reg->btf */
 	reg_name = kernel_type_name(reg->btf, reg->btf_id);
@@ -3759,7 +3764,8 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	 */
 	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
 				  off_desc->kptr.btf, off_desc->kptr.btf_id,
-				  off_desc->type == BPF_KPTR_REF))
+				  off_desc->type == BPF_KPTR_REF ||
+				  off_desc->type == BPF_LOCAL_KPTR_REF))
 		goto bad_type;
 	return 0;
 bad_type:
@@ -3797,18 +3803,21 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 	/* We only allow loading referenced kptr, since it will be marked as
 	 * untrusted, similar to unreferenced kptr.
 	 */
-	if (class != BPF_LDX && off_desc->type == BPF_KPTR_REF) {
+	if (class != BPF_LDX &&
+	    (off_desc->type == BPF_KPTR_REF || off_desc->type == BPF_LOCAL_KPTR_REF)) {
 		verbose(env, "store to referenced kptr disallowed\n");
 		return -EACCES;
 	}
 
 	if (class == BPF_LDX) {
+		int local = (off_desc->type == BPF_LOCAL_KPTR_REF) ? MEM_TYPE_LOCAL : 0;
+
 		val_reg = reg_state(env, value_regno);
 		/* We can simply mark the value_regno receiving the pointer
 		 * value from map as PTR_TO_BTF_ID, with the correct type.
 		 */
 		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, off_desc->kptr.btf,
-				off_desc->kptr.btf_id, PTR_MAYBE_NULL | PTR_UNTRUSTED);
+				off_desc->kptr.btf_id, local | PTR_MAYBE_NULL | PTR_UNTRUSTED);
 		/* For mark_ptr_or_null_reg */
 		val_reg->id = ++env->id_gen;
 	} else if (class == BPF_STX) {
@@ -5648,7 +5657,8 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 		verbose(env, "off=%d doesn't point to kptr\n", kptr_off);
 		return -EACCES;
 	}
-	if (off_desc->type != BPF_KPTR_REF) {
+	if (off_desc->type != BPF_KPTR_REF &&
+	    off_desc->type != BPF_LOCAL_KPTR_REF) {
 		verbose(env, "off=%d kptr isn't referenced kptr\n", kptr_off);
 		return -EACCES;
 	}
@@ -5779,6 +5789,13 @@ static const struct bpf_reg_types spin_lock_types = {
 	},
 };
 
+static const struct bpf_reg_types dyn_btf_ptr_types = {
+	.types = {
+		PTR_TO_BTF_ID,
+		PTR_TO_BTF_ID | MEM_TYPE_LOCAL,
+	},
+};
+
 static const struct bpf_reg_types fullsock_types = { .types = { PTR_TO_SOCKET } };
 static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
@@ -5806,6 +5823,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 #endif
 	[ARG_PTR_TO_SOCKET]		= &fullsock_types,
 	[ARG_PTR_TO_BTF_ID]		= &btf_ptr_types,
+	[ARG_PTR_TO_DYN_BTF_ID]		= &dyn_btf_ptr_types,
 	[ARG_PTR_TO_SPIN_LOCK]		= &spin_lock_types,
 	[ARG_PTR_TO_MEM]		= &mem_types,
 	[ARG_PTR_TO_ALLOC_MEM]		= &alloc_mem_types,
@@ -5867,7 +5885,8 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	return -EACCES;
 
 found:
-	if (reg->type == PTR_TO_BTF_ID) {
+	if (reg->type == PTR_TO_BTF_ID ||
+	    reg->type == (PTR_TO_BTF_ID | MEM_TYPE_LOCAL)) {
 		/* For bpf_sk_release, it needs to match against first member
 		 * 'struct sock_common', hence make an exception for it. This
 		 * allows bpf_sk_release to work for multiple socket types.
@@ -5877,7 +5896,8 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 
 		if (type_is_local(reg->type) &&
 		    WARN_ON_ONCE(meta->func_id != BPF_FUNC_spin_lock &&
-				 meta->func_id != BPF_FUNC_spin_unlock))
+				 meta->func_id != BPF_FUNC_spin_unlock &&
+				 meta->func_id != BPF_FUNC_kptr_xchg))
 			return -EFAULT;
 
 		if (!arg_btf_id) {
@@ -6031,6 +6051,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 
 	/* arg_btf_id and arg_size are in a union. */
 	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
+	    base_type(arg_type) == ARG_PTR_TO_DYN_BTF_ID ||
 	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
@@ -6621,7 +6642,8 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID)
 			return !!fn->arg_btf_id[i];
 
-		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_SPIN_LOCK)
+		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_DYN_BTF_ID ||
+		    base_type(fn->arg_type[i]) == ARG_PTR_TO_SPIN_LOCK)
 			return fn->arg_btf_id[i] == BPF_PTR_POISON;
 
 		if (base_type(fn->arg_type[i]) != ARG_PTR_TO_BTF_ID && fn->arg_btf_id[i] &&
@@ -7575,28 +7597,33 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 	case RET_PTR_TO_BTF_ID:
 	{
-		struct btf *ret_btf;
 		int ret_btf_id;
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
-		if (func_id == BPF_FUNC_kptr_xchg) {
-			ret_btf = meta.kptr_off_desc->kptr.btf;
-			ret_btf_id = meta.kptr_off_desc->kptr.btf_id;
-		} else {
-			ret_btf = btf_vmlinux;
-			ret_btf_id = *fn->ret_btf_id;
-		}
+		ret_btf_id = *fn->ret_btf_id;
 		if (ret_btf_id == 0) {
 			verbose(env, "invalid return type %u of func %s#%d\n",
 				base_type(ret_type), func_id_name(func_id),
 				func_id);
 			return -EINVAL;
 		}
-		regs[BPF_REG_0].btf = ret_btf;
+		regs[BPF_REG_0].btf = btf_vmlinux;
 		regs[BPF_REG_0].btf_id = ret_btf_id;
 		break;
 	}
+	case RET_PTR_TO_DYN_BTF_ID:
+		if (func_id != BPF_FUNC_kptr_xchg) {
+			verbose(env, "verifier internal error: incorrect use of RET_PTR_TO_DYN_BTF_ID\n");
+			return -EFAULT;
+		}
+		mark_reg_known_zero(env, regs, BPF_REG_0);
+		regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
+		if (meta.kptr_off_desc->type == BPF_LOCAL_KPTR_REF)
+			regs[BPF_REG_0].type |= MEM_TYPE_LOCAL;
+		regs[BPF_REG_0].btf = meta.kptr_off_desc->kptr.btf;
+		regs[BPF_REG_0].btf_id = meta.kptr_off_desc->kptr.btf_id;
+		break;
 	default:
 		verbose(env, "unknown return type %u of func %s#%d\n",
 			base_type(ret_type), func_id_name(func_id), func_id);
@@ -14832,6 +14859,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			break;
 		case PTR_TO_BTF_ID:
 		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
+		/* Only untrusted local kptrs need probe_mem conversions for loads */
+		case PTR_TO_BTF_ID | MEM_TYPE_LOCAL | PTR_UNTRUSTED:
 			if (type == BPF_READ) {
 				insn->code = BPF_LDX | BPF_PROBE_MEM |
 					BPF_SIZE((insn)->code);
-- 
2.34.1

