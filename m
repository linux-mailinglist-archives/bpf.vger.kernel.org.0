Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B47616EB7
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 21:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiKBU2R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 16:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiKBU2O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 16:28:14 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495961017
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 13:28:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso2936496pjc.5
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG8o8uW9XszyfkfJACdT1jDxvuWkt+oiXMvURNnvU3U=;
        b=GJfgEhkKKbqLPJsFcNsE1wmxVfqwkGe9An1q4C0vFDfKaEJ2PmuTKAc0Dpl8G9rAFO
         E4zllVDT1pn8OswRh3FDKZl7qDIH6MhOl4cWOBThUd4e30a0uHZGkDhsf0PRkQzq97WO
         I8OAFakNPZSDW9F44ITO0G/yYAtFJXPVBuDP/lFR//tU5FGXdd+L2t2nvmzlSa3BwPaW
         y3K41CZU1qNbCh1mf976nYfr8at0UYJt+JW/4Tk9vmh4z4muul7x369312qUQ8db1V66
         JT6aj45hQlgidpMJepjIgEWQbArozUujJNsvZy9uoA209LHa9Xfe1QTm6f/o0qzWoi/6
         tinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG8o8uW9XszyfkfJACdT1jDxvuWkt+oiXMvURNnvU3U=;
        b=2ckrXxybR6/NQ25IxDDRh0CoVg4rwgUUlWsaZG0nlzHEW6kiCb6LHv1Wag0Azk2y2k
         vRdB0uAbGMZAfD+IJNMKNNnWX20Sw0GHIyYEPJ8EM0Zz5vqo7/ShvgfM2dpu6qbSTNbJ
         N2S1G+sXROXg0mSptyuXHxohjUrUYWKexgu9fRcNex7JC8jqpzYREWquxgvXXafT5sXN
         Wf9u/awqJ3lOazmSGiBwKw8hdu+IJ3cmUtfhLkY+rWh8KXl8GWumsdjugm7LpPv/xIYk
         xSGqUPLMUGb8pNIhsqI+BEffMu1hH3+2ft2NclgDxSRbPYSV81b0r88L23UOq38JIAG0
         OZCw==
X-Gm-Message-State: ACrzQf1DbWqJ5l/KRqltDarOOL1LvsyIXEwV68sqBec6y37whHASBMEG
        Tp0fo3i6yB5GqC+pWy5aL2G3GkwTcvX4Aw==
X-Google-Smtp-Source: AMsMyM5Z1BlS2QWW1rC2aotF/UMan+OPlYglf5dAa0NjBkJywOvC4A1f8xD2n8FzOoT0Q0QzwfUqvg==
X-Received: by 2002:a17:902:b708:b0:184:3921:df30 with SMTP id d8-20020a170902b70800b001843921df30mr27068827pls.43.1667420892517;
        Wed, 02 Nov 2022 13:28:12 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id z24-20020a63e558000000b004351358f056sm8021704pgj.85.2022.11.02.13.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:28:12 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v3 20/24] bpf: Introduce bpf_obj_drop
Date:   Thu,  3 Nov 2022 01:56:54 +0530
Message-Id: <20221102202658.963008-21-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102202658.963008-1-memxor@gmail.com>
References: <20221102202658.963008-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7833; i=memxor@gmail.com; h=from:subject; bh=MAEW+hWhTi4elChCRPozW1y5QOCCjuZcXJDJeUONMvo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjYtIEUAXl4Sh8YONtxPjhoK5W5bEa7o+nr/gdpils xrHP7ayJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2LSBAAKCRBM4MiGSL8RypDBEA CxbCbXiz3d9KsgG/XZ8pPE9vrK+wLiW8HeLafjzfGDNDs8k4RJr0Hc4kDh+07qxbefMIgYAHpvVw17 shx4MYPXVrWnxwr1aYQw1jC7eu607+LM5HqqkqDV8fUTdYulJ1aY0AVijfgR/4SBVt6xCeoR7bxx6o 5/ijOm/5lmChC5HVDyuvoiwujRlsHqrHhzYosUyKIXTjBjDMCyFXhQehCM9SX5qeSeqhhqHtKZIcdD aXm0/hK5MtvdtBzmmDY7v2gitgTGFNmorVjXlX+U8dY0WDCqeZLN460To9C1+4at4uv+e042P2K6c0 2OLLL3pmfgi80jWDibl+tAu9JycaPZe1yzF0C67f8QcKTJnp0lGHp1uhTqydYzSphhkQc3S7jW8pTa ztY9v3HnLbBHkZVPw+PKE6+b1K9mc6J+/9ljDwQjMevt4aok/HRAE7avAl0RWNNGYQ1glV3zbRIhkB VrJSDt1igeI8mgzr6C7CC5Xq6h+/ee148AhNwOMB2owz2yQaBR6kz6vffKcLb2d2CTGortlk02nk1P OFSnudmqPTEsXo7hpkpgR6SrCQe6pqfJCBxuH2LSIpt4OsB1VZ3Wa7HVmw/UzyGDVlpEdjpr8kcQqk epv8mu0PGKNjLC7P76ezpDJz6zxGnjN1aKTj4laN8MevUOWbPDqQ1aBkH50A==
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

Introduce bpf_obj_drop, which is the kfunc used to free local kptrs
allocated using bpf_obj_new. Similar to bpf_obj_new, it implicitly
destructs the fields part of the local kptr automatically without user
intervention.

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
index b78eaf8ae554..69fc73479f34 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1764,6 +1764,16 @@ void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
 	return p;
 }
 
+void bpf_obj_drop_impl(void *p__lkptr, void *meta__ign)
+{
+	struct btf_struct_meta *meta = meta__ign;
+	void *p = p__lkptr;
+
+	if (meta)
+		bpf_obj_free_fields(meta->record, p);
+	bpf_mem_free(&bpf_global_ma, p);
+}
+
 __diag_pop();
 
 BTF_SET8_START(generic_btf_ids)
@@ -1771,6 +1781,7 @@ BTF_SET8_START(generic_btf_ids)
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kptr_drop_impl, KF_RELEASE)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a04a98b23524..bb47eb8b0254 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7703,6 +7703,10 @@ struct bpf_kfunc_call_arg_meta {
 		u64 value;
 		bool found;
 	} arg_constant;
+	struct {
+		struct btf *btf;
+		u32 btf_id;
+	} arg_obj_drop;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7781,6 +7785,11 @@ static bool is_kfunc_arg_sfx_ignore(const struct btf *btf, const struct btf_para
 	return __kfunc_param_match_suffix(btf, arg, "__ign");
 }
 
+static bool is_kfunc_arg_local_kptr(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__lkptr");
+}
+
 static bool is_kfunc_arg_ret_buf_size(const struct btf *btf,
 				      const struct btf_param *arg,
 				      const struct bpf_reg_state *reg,
@@ -7881,6 +7890,7 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 
 enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CTX,
+	KF_ARG_PTR_TO_LOCAL_BTF_ID,  /* Local kptr */
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
 	KF_ARG_PTR_TO_KPTR_STRONG,   /* PTR_TO_KPTR but type specific */
 	KF_ARG_PTR_TO_DYNPTR,
@@ -7888,6 +7898,20 @@ enum kfunc_ptr_arg_type {
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
@@ -7908,6 +7932,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (btf_get_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
 		return KF_ARG_PTR_TO_CTX;
 
+	if (is_kfunc_arg_local_kptr(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_LOCAL_BTF_ID;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -8126,6 +8153,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return kf_arg_type;
 
 		switch (kf_arg_type) {
+		case KF_ARG_PTR_TO_LOCAL_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (is_kfunc_trusted_args(meta) && !reg->ref_obj_id) {
 				verbose(env, "R%d must be referenced\n", regno);
@@ -8160,6 +8188,21 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return -EINVAL;
 			}
 			break;
+		case KF_ARG_PTR_TO_LOCAL_BTF_ID:
+			if (reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL)) {
+				verbose(env, "arg#%d expected point to local kptr\n", i);
+				return -EINVAL;
+			}
+			if (!reg->ref_obj_id) {
+				verbose(env, "local kptr must be referenced\n");
+				return -EINVAL;
+			}
+			if (meta->btf == btf_vmlinux &&
+			    meta->func_id == special_kfunc_list[KF_bpf_obj_drop_impl]) {
+				meta->arg_obj_drop.btf = reg->btf;
+				meta->arg_obj_drop.btf_id = reg->btf_id;
+			}
+			break;
 		case KF_ARG_PTR_TO_BTF_ID:
 			/* Only base_type is checked, further checks are done here */
 			if (reg->type != PTR_TO_BTF_ID &&
@@ -8230,17 +8273,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
@@ -8367,6 +8399,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -14573,6 +14609,14 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
index 1d3451084a68..29a5520a4250 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -18,3 +18,16 @@ extern void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
 
 /* Convenience macro to wrap over bpf_obj_new_impl */
 #define bpf_obj_new(type) bpf_obj_new_impl(bpf_core_type_id_local(type), NULL)
+
+/* Description
+ *	Free a local kptr. All fields of local kptr that require destruction
+ *	will be destructed before the storage is freed.
+ *
+ *	The 'meta' parameter is a hidden argument that is ignored.
+ * Returns
+ *	Void.
+ */
+extern void bpf_obj_drop_impl(void *kptr, void *meta) __ksym;
+
+/* Convenience macro to wrap over bpf_obj_drop_impl */
+#define bpf_obj_drop(kptr) bpf_obj_drop_impl(kptr, NULL)
-- 
2.38.1

