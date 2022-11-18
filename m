Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1CF62EB6F
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiKRB5H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240432AbiKRB5G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:57:06 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF29762047
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:05 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so3286153pjb.0
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzJ1rpf8fgi6dDRt7B1kFIh3QyoP/rjlQsnep4f2CqQ=;
        b=OD5Kkq/ZAd+PAtEZew3yOoPNJo/W6U10wnlqm9uwxoq4IqcYN1XDSBT2+Uo7OHpCbk
         gSUMSfKpQ2p+mVkkyp4sb8uW5rINZcImeFxP5zoTBkdiPaWneknjpxEPkDyNaV71pQH4
         gG6djwG688lXKTe/ikRbArYglS1gqwrLZdDDjdb8WTt0+++sJKMk7FkYDemyeDDkX3DX
         pqAitqtonjz5oyHuO0Jfb7BpPZcnZN7X6xjhKqQBmTey4JnQEXhr9/iWa+OFsosBkm2C
         tYl+zrReY6fEVZK0fvdvkJIj7RuQQEyyOfGs87J99D4UwbwjoS54Av3XJQErQNc++oI8
         EWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzJ1rpf8fgi6dDRt7B1kFIh3QyoP/rjlQsnep4f2CqQ=;
        b=o2mqFCi3RtsOHRrLmUzx3SsLQ1sdnS8rC2gRwed00OKoSNlcAfvadRYYsC6P/4E1n+
         RXwt0KN4X3fbQYCZOLGojZnkgak/KnmELAUVuzmT6QWGPai+yUenYuC/0xa/Oa58DiFq
         yJ/072i/Kwxa1vS9E/hgf65uu76+NpPOhwFd81+ZSGgT6XEiUHuC+rRg8bjS7Jek8ybX
         eMh9mLs+ZmtOPFzbzlBx1wiuVSbluqL22Wm6OiwZZF5a8PKN1/64Oaybrypc/Mxmvzlf
         kmpomtKVvwJJKwNiRhMM4LG+gXOs0MLbbPY0WkmHGNPt0VH7dwLPhQRu/mPxtcngCO6N
         APtQ==
X-Gm-Message-State: ANoB5pnCk/OvJYjUwLf94cj8RnTGyI4HQ/iTWM49YTeqExi2M1TNSUMf
        G6je8sGNBOpZo2+sLsXPsl7s+faqwCM=
X-Google-Smtp-Source: AA0mqf5DRSGfES5gj3juBY2+klaj7Oc7OaL//PdInIWFRrURfXqhcfSziLk/7Fe/N415HbDcTi2iAw==
X-Received: by 2002:a17:90a:4049:b0:210:5de0:f3e3 with SMTP id k9-20020a17090a404900b002105de0f3e3mr5438077pjg.61.1668736624980;
        Thu, 17 Nov 2022 17:57:04 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902768100b00187197c4999sm2086589pll.167.2022.11.17.17.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:57:04 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 14/24] bpf: Introduce bpf_obj_drop
Date:   Fri, 18 Nov 2022 07:26:04 +0530
Message-Id: <20221118015614.2013203-15-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7736; i=memxor@gmail.com; h=from:subject; bh=pDgma4HrQwOgpVLsws3O/mIK4eQBInl3nLeFIeuRnos=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXPtZFtivQtLBkNu+SwLSTapR6fM3fBx/uVVVP+ ILMriN6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzwAKCRBM4MiGSL8RylMUD/ 9/KcW8HQIZtPChIbFJbrZwSZyV7IPPVa8Yxuz4iC0CJ8dB8xdwciyY5oMeC8Om0AnYfyi5MoWIrksW VRBAI4EgTa6CEow9MfzaJsNuKL8bM8yH9maqez+CoULDXdCJcjFDqE4Ghz83jN+Ih0XpBrg9PlL/ui Itvg+iUdaoIrBf/Nd2JAajPmZAYV3EAjDA6AqFRWJN1NYXLNjGstp5JmvUW1A3/0+wkT8LhrHwUgOs GV4YFyPmrkNtYh+6DtGp6sZv0ynONIMt9H8z1P04QqncTlhis0opil44GEI1lisj+fYXY5Y7qC5weR 0ow7nmXgUgktkSjRaObm8sFdUVAmS+AuNuKD0Pr9qy7jQnsOf9n1COsRbmuyDbEAqMwnZnU4tkSw4Q TeH1K/5AWhcarBYGMhCM75f9Ri+WuJphvaVQKZNfMHiQ+G9OJorNn9hDNOz73uv2kMV8u4hlMgREC6 tDTZ1JUiox7q0JkZp5Ay98gz+vdc4BTAiNFho0/nm0Ug3kQAscTaUDefOLkOIlPim2u/sjoXgxrnDS LFsf3EIRpI83p+OxCiaDbKOr92MTo8pNM6RRabgY1WBCbYACrt1H8RW8uUAvWThXhFTWPUee+Yp0/C 9VMhtP38RjbDQrZ4SOgxFuF3yP2OKgkMkU1q04RT02FvxRX66t+jpPb5X78w==
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
index b923cf835802..75aa52b27e8b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7879,6 +7879,10 @@ struct bpf_kfunc_call_arg_meta {
 		u64 value;
 		bool found;
 	} arg_constant;
+	struct {
+		struct btf *btf;
+		u32 btf_id;
+	} arg_obj_drop;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7957,6 +7961,11 @@ static bool is_kfunc_arg_ignore(const struct btf *btf, const struct btf_param *a
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
@@ -8051,6 +8060,7 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 
 enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CTX,
+	KF_ARG_PTR_TO_ALLOC_BTF_ID,  /* Allocated object */
 	KF_ARG_PTR_TO_KPTR,	     /* PTR_TO_KPTR but type specific */
 	KF_ARG_PTR_TO_DYNPTR,
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
@@ -8058,6 +8068,20 @@ enum kfunc_ptr_arg_type {
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
@@ -8078,6 +8102,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (btf_get_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
 		return KF_ARG_PTR_TO_CTX;
 
+	if (is_kfunc_arg_alloc_obj(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_ALLOC_BTF_ID;
+
 	if (is_kfunc_arg_kptr_get(meta, argno)) {
 		if (!btf_type_is_ptr(ref_t)) {
 			verbose(env, "arg#0 BTF type must be a double pointer for kptr_get kfunc\n");
@@ -8294,6 +8321,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return kf_arg_type;
 
 		switch (kf_arg_type) {
+		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_kfunc_trusted_args(meta))
 				break;
@@ -8330,6 +8358,21 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
@@ -8400,17 +8443,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
@@ -8532,6 +8564,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -14768,6 +14804,14 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

