Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB7662E1AB
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbiKQQ0v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbiKQQ02 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:28 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0285679912
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:38 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 62so2371227pgb.13
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++ULrfF8CmAP2xQVn0biv80cUJKxHLKHh12y4coOwaU=;
        b=aWVDQNdWFKAev0H8EY5w59DfKUnsWaoQwjhoYg1bP/a87Qu/kJ/F6bSkQSMZdWwI4L
         7sMcZN5UcFkhK77lwFQ3xOgcUdirhxOiJvYT/JyB+JE7Ol6WqssBWDEEXms8GKN1IM50
         cM8vpf1YcjewK7Yy4FFfFn4PjmH+gKuBJ3IlJ8CpsmY4vKLGyOm3QLAXrQDDsvECWw1C
         6TjW/RH+LtB+hW+Yp6lUTOGboTSDNA5CtSKot+XSrYn4/28Snc6P7wyZDyB7kvCI1ngY
         dDeiVkNREUuE6EAozr7s7j/Xx/mE4Ch2pKQOJ7OJKePlfmE6f28mMVHxV5ly2HxkJi7L
         C01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++ULrfF8CmAP2xQVn0biv80cUJKxHLKHh12y4coOwaU=;
        b=kcs/A0vjEjlA7Ir+dZLgMvyDcvpYEt3R0MSOltDVe5tOuDDFEqJNHZJ5t3HfGt4Cnk
         7NvOPAesmVbN2q8lyxh3/z4wZikcnqaDxBIqTKTT9ootTTajJmALbg/3Feai6Cwy2Pge
         tmqP2JHaHI46ebUclHzI1d9s9l10dujphtazDCdjZyyqatIZKL7Gerwm1TgE+mVrHMvS
         V4kxP/W4MKr6P6QM4J2ao2IR4E9YrXoUjGJ0udqGsXPKd+pxJlmPsx+pyxdrY/ddJifk
         nPQrDMcTRVD+PsfyGuXVJEUxeyMp2kkGmpRmSaBB7loiMH2B5dmDW5Lk7OrWtcnXcYOT
         WbwA==
X-Gm-Message-State: ANoB5pk/Nw2KNlQ5YloJsnHkAAsGm/muXflwpPllhm++CVKAk4wpbQeI
        kaVRPwEd7ygRa7WnMtLmK9uRf5xsQOc=
X-Google-Smtp-Source: AA0mqf7mSVQasep5MNQvN605EsoFrox7eAp4DSFI0gvZNEsMkdww1B0XYiSguZyjMmtiKpS2r99CxQ==
X-Received: by 2002:a63:f966:0:b0:476:f0df:3f48 with SMTP id q38-20020a63f966000000b00476f0df3f48mr2741075pgk.278.1668702337221;
        Thu, 17 Nov 2022 08:25:37 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id e89-20020a17090a6fe200b002137d3da760sm3741832pjk.39.2022.11.17.08.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:25:36 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v8 14/22] bpf: Introduce bpf_obj_drop
Date:   Thu, 17 Nov 2022 21:54:22 +0530
Message-Id: <20221117162430.1213770-15-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117162430.1213770-1-memxor@gmail.com>
References: <20221117162430.1213770-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7736; i=memxor@gmail.com; h=from:subject; bh=mZvoCqtK4h6DgMb78xDqGgfqpZU5R/RixAo8Aq5Ac4M=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdl7/y5zIvV+rHl3HnRQRK/23jp1DhZbBL7igEk0m 7vRD9rCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3Ze/wAKCRBM4MiGSL8RyreUD/ 0RKDDfWH44BJ4I7nwEG6HXjzynAC/FABlJiEQRWrXvp36fxj0p74LqJCw7gwT24wlxVH6djG/0ql+b LMG3Eym6sUeeTxGcRXgnbEMMN0Tl63hHNyAXe0D9O3JEw6NA2/bnbyzrY09mPufZFiSq4E3vITuQ8f gGTH957OgYxrZEa0QFSkz6GVaJjzzbSt3GdlJhIOPAkfqHHLUboeiqg5qrI97b+CaXhiazXL5Jzh/J bIdUiForJS2XLr9APXQJUI/G/RDqXCuWG06dcb9kwQYMEtD2lI9i/ZExpEEtCA/qVTVHJr45+lmx9H yOyNt2BJr1iThyNVov5oqsf2ke9IHon22rSI2ntFcIdHDiSYgc+FxwDMdb5FBMOPgepJMTtisdNCG+ jCmwiELnwuhRE+zDW4EyllutPneHQwhjOTep3Y0dOpEjByaquZD0wpRTiqStQb+cVKUZQfTdDj66u2 PzYXh6OSvyt73w6jk7PmMTxe5uBf8OsZr3mu0JymkE+cn+zr5R5bvB/cvSpRTjbeTlhVxrbPbVbtK5 GKHUT8OAv2tqL7F3rsXeSrL9dCaPzcNYy23aesgqRNWQTVfNcAcNIAczuffQKmG2o6bZRRAaAkVmPO SktDLpXT5uNpVv3yfUAXtqpp32AJ1lZLy5/LDdgpyG0iEqSr0mzayy8saLnw==
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

Introduce bpf_obj_drop, which is the kfunc used to free allocated
objects (allocated using bpf_obj_new). Pairing with bpf_obj_new, it
implicitly destructs the fields part of object automatically without
user intervention.

Just like the previous patch, btf_struct_meta that is needed to free up
the special fields is passed as a hidden argument to the kfunc.

For the user, a convenience macro hides over the kernel side kfunc which
is named bpf_obj_drop_impl.

Continuing the previous example:

void prog(void) {
	struct foo *f;

	f = bpf_obj_new(typeof(*f));
	if (!f)
		return;
	bpf_obj_drop(f);
}

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c                          | 11 ++++
 kernel/bpf/verifier.c                         | 66 +++++++++++++++----
 .../testing/selftests/bpf/bpf_experimental.h  | 13 ++++
 3 files changed, 79 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c4f1c22cc44c..71d803ca0c1d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1770,6 +1770,16 @@ void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
 	return p;
 }
 
+void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
+{
+	struct btf_struct_meta *meta = meta__ign;
+	void *p = p__alloc;
+
+	if (meta)
+		bpf_obj_free_fields(meta->record, p);
+	bpf_mem_free(&bpf_global_ma, p);
+}
+
 __diag_pop();
 
 BTF_SET8_START(generic_btf_ids)
@@ -1777,6 +1787,7 @@ BTF_SET8_START(generic_btf_ids)
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ab91037df1c8..b96c525fa413 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7878,6 +7878,10 @@ struct bpf_kfunc_call_arg_meta {
 		u64 value;
 		bool found;
 	} arg_constant;
+	struct {
+		struct btf *btf;
+		u32 btf_id;
+	} arg_obj_drop;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7956,6 +7960,11 @@ static bool is_kfunc_arg_ignore(const struct btf *btf, const struct btf_param *a
 	return __kfunc_param_match_suffix(btf, arg, "__ign");
 }
 
+static bool is_kfunc_arg_alloc_obj(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__alloc");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -8050,6 +8059,7 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 
 enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CTX,
+	KF_ARG_PTR_TO_ALLOC_BTF_ID,  /* Allocated object */
 	KF_ARG_PTR_TO_KPTR,	     /* PTR_TO_KPTR but type specific */
 	KF_ARG_PTR_TO_DYNPTR,
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
@@ -8057,6 +8067,20 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip it */
 };
 
+enum special_kfunc_type {
+	KF_bpf_obj_new_impl,
+	KF_bpf_obj_drop_impl,
+};
+
+BTF_SET_START(special_kfunc_set)
+BTF_ID(func, bpf_obj_new_impl)
+BTF_ID(func, bpf_obj_drop_impl)
+BTF_SET_END(special_kfunc_set)
+
+BTF_ID_LIST(special_kfunc_list)
+BTF_ID(func, bpf_obj_new_impl)
+BTF_ID(func, bpf_obj_drop_impl)
+
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_kfunc_call_arg_meta *meta,
@@ -8077,6 +8101,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (btf_get_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
 		return KF_ARG_PTR_TO_CTX;
 
+	if (is_kfunc_arg_alloc_obj(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_ALLOC_BTF_ID;
+
 	if (is_kfunc_arg_kptr_get(meta, argno)) {
 		if (!btf_type_is_ptr(ref_t)) {
 			verbose(env, "arg#0 BTF type must be a double pointer for kptr_get kfunc\n");
@@ -8293,6 +8320,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return kf_arg_type;
 
 		switch (kf_arg_type) {
+		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_kfunc_trusted_args(meta))
 				break;
@@ -8329,6 +8357,21 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return -EINVAL;
 			}
 			break;
+		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
+			if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
+				verbose(env, "arg#%d expected pointer to allocated object\n", i);
+				return -EINVAL;
+			}
+			if (!reg->ref_obj_id) {
+				verbose(env, "allocated object must be referenced\n");
+				return -EINVAL;
+			}
+			if (meta->btf == btf_vmlinux &&
+			    meta->func_id == special_kfunc_list[KF_bpf_obj_drop_impl]) {
+				meta->arg_obj_drop.btf = reg->btf;
+				meta->arg_obj_drop.btf_id = reg->btf_id;
+			}
+			break;
 		case KF_ARG_PTR_TO_KPTR:
 			if (reg->type != PTR_TO_MAP_VALUE) {
 				verbose(env, "arg#0 expected pointer to map value\n");
@@ -8399,17 +8442,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 	return 0;
 }
 
-enum special_kfunc_type {
-	KF_bpf_obj_new_impl,
-};
-
-BTF_SET_START(special_kfunc_set)
-BTF_ID(func, bpf_obj_new_impl)
-BTF_SET_END(special_kfunc_set)
-
-BTF_ID_LIST(special_kfunc_list)
-BTF_ID(func, bpf_obj_new_impl)
-
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
@@ -8531,6 +8563,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				env->insn_aux_data[insn_idx].obj_new_size = ret_t->size;
 				env->insn_aux_data[insn_idx].kptr_struct_meta =
 					btf_find_struct_meta(ret_btf, ret_btf_id);
+			} else if (meta.func_id == special_kfunc_list[KF_bpf_obj_drop_impl]) {
+				env->insn_aux_data[insn_idx].kptr_struct_meta =
+					btf_find_struct_meta(meta.arg_obj_drop.btf,
+							     meta.arg_obj_drop.btf_id);
 			} else {
 				verbose(env, "kernel function %s unhandled dynamic return type\n",
 					meta.func_name);
@@ -14767,6 +14803,14 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[2] = addr[1];
 		insn_buf[3] = *insn;
 		*cnt = 4;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_obj_drop_impl]) {
+		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
+		struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
+
+		insn_buf[0] = addr[0];
+		insn_buf[1] = addr[1];
+		insn_buf[2] = *insn;
+		*cnt = 3;
 	}
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index aeb6a7fcb7c4..8473395a11af 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -22,4 +22,17 @@ extern void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
 /* Convenience macro to wrap over bpf_obj_new_impl */
 #define bpf_obj_new(type) ((type *)bpf_obj_new_impl(bpf_core_type_id_local(type), NULL))
 
+/* Description
+ *	Free an allocated object. All fields of the object that require
+ *	destruction will be destructed before the storage is freed.
+ *
+ *	The 'meta' parameter is a hidden argument that is ignored.
+ * Returns
+ *	Void.
+ */
+extern void bpf_obj_drop_impl(void *kptr, void *meta) __ksym;
+
+/* Convenience macro to wrap over bpf_obj_drop_impl */
+#define bpf_obj_drop(kptr) bpf_obj_drop_impl(kptr, NULL)
+
 #endif
-- 
2.38.1

