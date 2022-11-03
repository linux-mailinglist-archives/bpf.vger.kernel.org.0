Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFA6618854
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiKCTLn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiKCTLl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:11:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E65212AB2
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:11:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k5so2564551pjo.5
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nr9W3jcG5DiPLCfFuyx6BUS1TphhznmlLmSjPiY/lm4=;
        b=e7sKEHKXI+cX4mx54rXvGX9G+JP6kWUlMbjGY+sHbrvT6t/NQ3bR/I5a14UPJ8kkHB
         gU0vCPL5NQWldqNeYzk9gaWGO7AKK0S3ba/rydBb+HFzOnJUtBkBAvvMrm+QQYdiJ9pz
         tLUTBw8NrzfIixrDlgNvdBkTb9BeEg0c/alLwpfOiQTYdsWPcBFG36vzVoNU/BNGMCcf
         QK8FQB2wR6zTp37GzrqxglN2QUoyF07Ie5nrlFH9kMvx53q7brQoT1tcR6PYYLPjHB5j
         +lSTU5L2FZ9TqXM4cZ6dAoTdBn9MYB4QgtbSmIFUu4pyvKeZgHSItOyD3D12Y3v1Tw2l
         Jq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nr9W3jcG5DiPLCfFuyx6BUS1TphhznmlLmSjPiY/lm4=;
        b=qjQdwh3iu53veCVeFhai4OfBwakyyRtoEFrNyq41VWMKY5AxpAvW3itE5dYmkJLuyG
         9AuYAYcta02BFYaFt3nHOMrTx5HNZrDBo1deDfapEobs689PxhjQ0Rd9QvgGTXnafRvI
         Q7lHbmsh8yP/O8AK1Ob3vfYite9WGghmBY8wyoC1/ffBWJojBgAr+0xfvm0qfnuxjpQt
         27yeh+zy5bgiN0qT0FsBNiOZ9bIyTeujh8dS7tXSEBdqKLTTzk5SfoMfu5ALlcUvmwtL
         icSEB+crLn7DjWC2sppbcA1fOkbPI4ZLctlmks7v+Qp/kXdmrsTl/TfXAw6cmmLu4jXz
         PWmg==
X-Gm-Message-State: ACrzQf270no841cMTgN8Cowe711SMecx1OterUWmxcj2FIpy4rBbumzu
        DaSeTMfwkRe/lePcx8rnSJHTvSTCk9qWmQ==
X-Google-Smtp-Source: AMsMyM5TtPDpKOhJIB1eDmpjb03LB3sokoaoGVVFgra438wkBfgU8PxMhmnIKyvK53EtdFChR8S1xQ==
X-Received: by 2002:a17:902:da8a:b0:187:3d6:4c60 with SMTP id j10-20020a170902da8a00b0018703d64c60mr31583334plx.117.1667502699888;
        Thu, 03 Nov 2022 12:11:39 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id r15-20020aa79ecf000000b0056dde9895e2sm1138916pfq.30.2022.11.03.12.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:11:39 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 20/24] bpf: Introduce bpf_obj_drop
Date:   Fri,  4 Nov 2022 00:40:09 +0530
Message-Id: <20221103191013.1236066-21-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7833; i=memxor@gmail.com; h=from:subject; bh=cGPPXevu25hWwBJIqgw7tM/l5HNm1tVAOSbw+BvOG2A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIBusLX1kBgAms28Thnj54tVLnhaeknFRx/P3Bs 4ODb8uWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAQAKCRBM4MiGSL8Ryv+xD/ 4oU0xIciWMPHyuAip/ULiLBo4h0DVODsoB9Yh3FbY8Gyu4FZsXFceGxZLcSPavOA6aGsbhOTelRlOt Jb55Ih1mZQLNWGkqFOEBMdwml9KvDrA1S4eEwy7ThEDdu0DBi05RUuaN0xDEtDwdJ0wkdO+kVvQdhs YPvYda2DRsOb6SO7QcG8XHOKARSZZx3cLdPARe6yuKJCbg+YVQgsMdTIiSg9KZkodasNXXKVsjKYua RX0nLudUYJlpAm+j1JOCbi2RReQKsbTKreaVAl2V6qv1zc2n8ViNMe6lm/I70N5xrPg5Lap+jyZuqu BcWytjodMNk+c8Y6FORZyI65SdGh9s3V+eaR1+HZ2Y9Dh15pqnYNY8PToM8xcR30q9/L4mFTRsPOHR 6wuMYjr/ZOLUGaPlIXPT1bvNeTImaoCbPsNKFEiBEqXjBAJ4oYiKlDiInWzjG2xm1GCTluVpnP6zj+ lFrhUKrUmIrw2Q9RKci2x2CANSENzwyVH46c9ELDcdZuSvvC53Y+uvc/2xB66qT5I55IOlA6q3DBED D61IGpishM+y7vj0g8M0gQ6+z1h1KuECFY53I9Su0FJ0VfgMOyXmwsjvI77f35dxwJV1GLRKPYaHcd BvQdTOezqGhWLkZnNin1Ds+eGUf1Ni0RTqoQb4dN/zBxO5KYUaWdDl1G+L+A==
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
index e10245e054e4..a30f6573e805 100644
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
index c573282338e1..1e72e559ea6b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7704,6 +7704,10 @@ struct bpf_kfunc_call_arg_meta {
 		u64 value;
 		bool found;
 	} arg_constant;
+	struct {
+		struct btf *btf;
+		u32 btf_id;
+	} arg_obj_drop;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7782,6 +7786,11 @@ static bool is_kfunc_arg_sfx_ignore(const struct btf *btf, const struct btf_para
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
@@ -7882,6 +7891,7 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 
 enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CTX,
+	KF_ARG_PTR_TO_LOCAL_BTF_ID,  /* Local kptr */
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
 	KF_ARG_PTR_TO_KPTR_STRONG,   /* PTR_TO_KPTR but type specific */
 	KF_ARG_PTR_TO_DYNPTR,
@@ -7889,6 +7899,20 @@ enum kfunc_ptr_arg_type {
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
@@ -7909,6 +7933,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (btf_get_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
 		return KF_ARG_PTR_TO_CTX;
 
+	if (is_kfunc_arg_local_kptr(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_LOCAL_BTF_ID;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -8127,6 +8154,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return kf_arg_type;
 
 		switch (kf_arg_type) {
+		case KF_ARG_PTR_TO_LOCAL_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (is_kfunc_trusted_args(meta) && !reg->ref_obj_id) {
 				verbose(env, "R%d must be referenced\n", regno);
@@ -8161,6 +8189,21 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
@@ -8231,17 +8274,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
@@ -8368,6 +8400,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -14574,6 +14610,14 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

