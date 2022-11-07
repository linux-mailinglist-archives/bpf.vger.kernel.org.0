Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C8162036C
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiKGXLP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbiKGXLD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:11:03 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0414F2A24C
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:11:02 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id h193so11835450pgc.10
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ien0ATfWvVeirqicjop85pwTRZjU8Lsiw9fs6Z86qKM=;
        b=i79zvBDmE8aZ9mFWbNFbmogII/xjx0VoXm5rcYEtFZ7XIB2B1477+zkJFYeLNXyauw
         oa0rzTHUNbfpP8f3nSAhcjD+5ZfBDTZDmDaf8oRJczYx55YgMzLqGnOvdAmRAhm6D3Xr
         zNnYWHLm4XCMKX1jAa4NtgTz2FPx8R8Fy21YRXcPBlvveqlb+LtJc1kTWRl8T79C1t3A
         iL14jTHd8PkPHC5itaSrxUWRT8KGomV7fy3OdVrREICKPAL52Noa7KvHkge83RjCUaLd
         gFbVxr/nUhEMiT3ae2lKdCJLz0Il4h5iiqLdVgZZshLsZDLpo/4RKTx0Nui7CI4Y2/6l
         zJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ien0ATfWvVeirqicjop85pwTRZjU8Lsiw9fs6Z86qKM=;
        b=MKdbgpfLbUCyr8/HOdilOOrwNSDFpVKPJ2FuJcby5Bv/ZjBKKBmTmLhRHZAdkhoWyC
         NST0zGRUYWeZ0wimWG+g8G7P7Xcb+DExu874G2XSe58/lKc3mreiURdyZRSWyzT9gYQl
         pFRHu16B5AgK807IU66hIxxxrCH/+932HdWQgjICjvEIAe1s9zPqAQfBmCC190H/9zYh
         7ew6P4WBMUkXIWr7GjpmhSf2AATQFlbjSPMrUG0Ax0Jmt9aW5Xb5J4czTi1TAhtUv53d
         YlzrftDCFfN84lF6aHnBZb6xW/oHJ/G8UF2WEziJ3VqgLsW2N+E6u6palZxjFEH1tJA+
         C7Ow==
X-Gm-Message-State: ACrzQf3XyV/YfXANWl1sBPPcqZY4CPawgMHZOdng16osTOIG3alJpWTI
        dauicmgvZctTtIzSAOk8wnEh885uIqmTCQ==
X-Google-Smtp-Source: AMsMyM4pIKCJ1e6MmO9m9UA+r2J81qNj9TRgdXydBY82FpKHW7Rb6wUqVvD+8BZtelcr6DC32hyR5w==
X-Received: by 2002:a62:15cf:0:b0:56e:664f:707c with SMTP id 198-20020a6215cf000000b0056e664f707cmr23845177pfv.39.1667862661210;
        Mon, 07 Nov 2022 15:11:01 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b001782398648dsm5550989plh.8.2022.11.07.15.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:11:00 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 17/25] bpf: Introduce bpf_obj_drop
Date:   Tue,  8 Nov 2022 04:39:42 +0530
Message-Id: <20221107230950.7117-18-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7739; i=memxor@gmail.com; h=from:subject; bh=lXVavpEa6FtVbiHBSnYpRTtxRtwUPmP/uwgjuUq7FsY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+32XBuhN3yOg/T8OgNtXhMIP+nKGx8i+cOSL1n V3CFhJCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtwAKCRBM4MiGSL8RyvuAD/ 9UubC1M0El7BWVDSVMjNTtc5ETz8E/cDG+FCQW10L9RaAGfir5x+XqYgsudmmHfYg6B0OF//ruTBSC aim/Vxi1lg+iIZvKN0GI12kgep2SMbzOzWV6E2alXxYxORJ3pTnUrY2EoQ5XOFUNzISZKpKBMS6upN 7xwf6QcPr44nW9+O2ebMt7PKwUwFnWiS3eR9psKEyIQ6yQFBt38oOxdKFMLlKmJ4rN4y/Dvn7jq0uU AivoDLOcsFDM8s3T7WcFuPwLAEcUFk4wQ/QWAmM6urDqN7jJVFC6od3C9LLkJsAd2rTNN+KYn0Jmb0 ZeD0LdpbKN8qAXVEOAl0bkrFl13IWKM3Jce4TRimVIlWFlXqP1ip7KFqoQ0SIUsxQuhHGA6CyiCQ5t d19XUFJHUj6GO4pTqbiCS20dOmCmEWx4eSbrwpc+HW0tGhu9J9yuzOKtBX2pulalVMWgQp5NjZYZYx W6BJntX1yOIUiBVle4Et+jO0RHITNvLjaFUnHmQnEANpvBhetjJwPurM/z5ISzxa2ebiOn97FcBDcE NE+TS2L50aJov8a4+oMxdcpsFqQ7rGEEd5G5wAzcyh4+zMaD9KyLCwV9+6j6XEXfXbCbbEQnjflKBH KO81IiKzLEguXKBv6FNRmuNxjAXFjfUHPXNd7jwU8cWWkL1piPS/QZ0I/hOQ==
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
index c4f1c22cc44c..02045f6a6ad5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1770,6 +1770,16 @@ void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
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
@@ -1777,6 +1787,7 @@ BTF_SET8_START(generic_btf_ids)
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index db658a31d64f..7c5d9e933d97 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7882,6 +7882,10 @@ struct bpf_kfunc_call_arg_meta {
 		u64 value;
 		bool found;
 	} arg_constant;
+	struct {
+		struct btf *btf;
+		u32 btf_id;
+	} arg_obj_drop;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7960,6 +7964,11 @@ static bool is_kfunc_arg_sfx_ignore(const struct btf *btf, const struct btf_para
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
@@ -8060,6 +8069,7 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 
 enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CTX,
+	KF_ARG_PTR_TO_LOCAL_BTF_ID,  /* Local kptr */
 	KF_ARG_PTR_TO_KPTR_STRONG,   /* PTR_TO_KPTR but type specific */
 	KF_ARG_PTR_TO_DYNPTR,
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
@@ -8067,6 +8077,20 @@ enum kfunc_ptr_arg_type {
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
@@ -8087,6 +8111,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (btf_get_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
 		return KF_ARG_PTR_TO_CTX;
 
+	if (is_kfunc_arg_local_kptr(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_LOCAL_BTF_ID;
+
 	if (is_kfunc_arg_kptr_get(meta, argno)) {
 		if (!btf_type_is_ptr(ref_t)) {
 			verbose(env, "arg#0 BTF type must be a double pointer for kptr_get kfunc\n");
@@ -8305,6 +8332,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return kf_arg_type;
 
 		switch (kf_arg_type) {
+		case KF_ARG_PTR_TO_LOCAL_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_kfunc_trusted_args(meta))
 				break;
@@ -8341,6 +8369,21 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return -EINVAL;
 			}
 			break;
+		case KF_ARG_PTR_TO_LOCAL_BTF_ID:
+			if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
+				verbose(env, "arg#%d expected pointer to local kptr\n", i);
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
 		case KF_ARG_PTR_TO_KPTR_STRONG:
 			if (reg->type != PTR_TO_MAP_VALUE) {
 				verbose(env, "arg#0 expected pointer to map value\n");
@@ -8411,17 +8454,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
@@ -8548,6 +8580,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -14764,6 +14800,14 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
index 3588fe89890c..d145c93ea663 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -22,4 +22,17 @@ extern void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
 /* Convenience macro to wrap over bpf_obj_new_impl */
 #define bpf_obj_new(type) ((type *)bpf_obj_new_impl(bpf_core_type_id_local(type), NULL))
 
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
+
 #endif
-- 
2.38.1

