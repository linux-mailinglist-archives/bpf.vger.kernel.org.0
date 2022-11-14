Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70A062891B
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbiKNTRE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbiKNTQw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:16:52 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A9E28E33
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:47 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id k15so11959278pfg.2
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgwD7hHjBTRbxXrPOenPO+YEqh7ZDN+ICMghM+V56Yk=;
        b=ZgF/09ybgda0xqnqycvbZGuX1nM2dP7dzaj3XQcJzIIEhytkgDFBcAr+YFPUwDlw4b
         wxzh1rOmiT5FlFnaS5g9JbghrfTLOHzuBA6PM/bo/odP0+/ZiQI9YQXoVBwWASHd/0xJ
         En9PC9rXgg6B6Jn7W4Im5+9LkwQBpijfv8cfbxXiwKb7j76a5raBuufeGer0ggy+9xtx
         zvUc2XO/EVLxmSqO7jGlXB8WkDcUuz1wfzrQMgbDifrbtf26PQyONxoO1UTKSCllPjoL
         cGV0LgcRdJuezTN8uMDT78GucGGEGz0+aUepsAmVngH0txTX3DyGPNcG9ItiSnUk+Jzp
         c8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgwD7hHjBTRbxXrPOenPO+YEqh7ZDN+ICMghM+V56Yk=;
        b=c1NNkVCaXWX6a6lyILj7ejKV6VUJqdHPcaBk0UKMYQS/JVSlFYgmrS0mp4bbXEGYbC
         9TXU0Pdt9NFjrIVub/wOzRXtKYaFpdq7GSy2h1pDNyk9dT/otE7PNHxrpJ5+wl5rxYrh
         icqtSuCaE1rH8h2bo25YW7KqSjBAfJDb5NpQqx8W9JK5tYsNsgoKR1vMMlV9Wm2nBk7z
         /7laqjzMJr/yl9olSv8ip8OTWvs9s9zyt3xf+r+CtWNyRGUobhOkLmzLQC0ZpC1vCXZS
         Z+oLDLfakT7kzXRclxMMnidLd38vzERJlcC1IM+T6daK+XEuilH1h8T1nTMwpdA2Vm5U
         xTiw==
X-Gm-Message-State: ANoB5pkfmO3rmwjnWHh2Wczh41KDGTybxLBvakgaf/jvxPj2KHQLH8so
        9Oe52A7A9kmUUvHVgvYZDYBYbg41IJlb6A==
X-Google-Smtp-Source: AA0mqf4uw1syDLfRRBf8+unNffxyZ9e8Qh63DJxm2ynOrQUwyoUDICmceG7mG1Xac0G/jVjQHf2U4Q==
X-Received: by 2002:aa7:9156:0:b0:56c:a60d:54d7 with SMTP id 22-20020aa79156000000b0056ca60d54d7mr14955383pfi.18.1668453406546;
        Mon, 14 Nov 2022 11:16:46 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id u18-20020a170903125200b001869efb722csm7946220plh.215.2022.11.14.11.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:16:46 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 18/26] bpf: Introduce bpf_obj_drop
Date:   Tue, 15 Nov 2022 00:45:39 +0530
Message-Id: <20221114191547.1694267-19-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7764; i=memxor@gmail.com; h=from:subject; bh=SrU5MfLuSj+AUTV1TBgLP4xjL6su07KJ2IKqwCBFpHo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPJKgHdwZotZv/R3sjAPAYYt51WlOFL7Kk964bz 9KGuAcOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTyQAKCRBM4MiGSL8RypS4EA CEH6Z81L66D210jrJeZNIBjnDCk3GojuQznaCAxk9zNhGhe7u7YRsp0vdoRURlxm2q+Rx7GBJWtpS7 5BKLioyYCvXPb32mAL0ZKbx8sHZ45IW2lB27YFDNpABFSqHO/aqgAie9VGkXucHag3vhogR4qEYHYU 09kGZs9+r+1Wx3PGDXVYua6xcvE1jGl9Nw/EPXLwpgq8zoPicmPXnOP40XgvYXjA/K4b6KXFhStSl+ kBL8TPooyR1WVHWzZBqb2QFhV4xA3WcUgJCXRcLs1Z9BBPOFZrzyWPbba3KnAOcLHM0CdSy7jYR1aI jko7/hONScflnP3f15zq+PF4rcbL2yDgtIivEX9EBamh14oV95VlkdQ4dXdXJ7o07KuT/PFP8UCIGu Jmph4dG8M4fnkI57E18mzDCumRfct/8K7rtFoEqXNLxrPUF+KREiP+96zfdkBZwcAq1ZRYIjaHfKUd P6RULi/0IZOO2jf4VsTd/sOPmn/9NT1EluTvbMH+tU+KX+xQJ2WE1p8hOvzwtybpM2N2B6rXc0O3wu 3NK3Xm5b816KXT5unK07i5MzUMYtI/HQQoIvUv3fEz0lAu6T06C9zWBfFdsqSmYpBs10Ogl99uB0QX xd1CxaMMBNvIrr8qHC8jd1uT86gZ40S5OUt+B7k2QyCF22kCPTpVvNhWV8mA==
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
index c7f5d83783db..7372737cbde9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7875,6 +7875,10 @@ struct bpf_kfunc_call_arg_meta {
 		u64 value;
 		bool found;
 	} arg_constant;
+	struct {
+		struct btf *btf;
+		u32 btf_id;
+	} arg_obj_drop;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7953,6 +7957,11 @@ static bool is_kfunc_arg_sfx_ignore(const struct btf *btf, const struct btf_para
 	return __kfunc_param_match_suffix(btf, arg, "__ign");
 }
 
+static bool is_kfunc_arg_alloc_obj(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__alloc");
+}
+
 static bool is_kfunc_arg_ret_buf_size(const struct btf *btf,
 				      const struct btf_param *arg,
 				      const struct bpf_reg_state *reg,
@@ -8053,6 +8062,7 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 
 enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CTX,
+	KF_ARG_PTR_TO_ALLOC_BTF_ID,  /* Allocated object */
 	KF_ARG_PTR_TO_KPTR_STRONG,   /* PTR_TO_KPTR but type specific */
 	KF_ARG_PTR_TO_DYNPTR,
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
@@ -8060,6 +8070,20 @@ enum kfunc_ptr_arg_type {
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
@@ -8080,6 +8104,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (btf_get_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
 		return KF_ARG_PTR_TO_CTX;
 
+	if (is_kfunc_arg_alloc_obj(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_ALLOC_BTF_ID;
+
 	if (is_kfunc_arg_kptr_get(meta, argno)) {
 		if (!btf_type_is_ptr(ref_t)) {
 			verbose(env, "arg#0 BTF type must be a double pointer for kptr_get kfunc\n");
@@ -8298,6 +8325,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return kf_arg_type;
 
 		switch (kf_arg_type) {
+		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_kfunc_trusted_args(meta))
 				break;
@@ -8334,6 +8362,21 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
 		case KF_ARG_PTR_TO_KPTR_STRONG:
 			if (reg->type != PTR_TO_MAP_VALUE) {
 				verbose(env, "arg#0 expected pointer to map value\n");
@@ -8404,17 +8447,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
@@ -8541,6 +8573,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -14746,6 +14782,14 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

