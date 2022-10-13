Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943A45FD4C0
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJMGYf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJMGYd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:24:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CC5122BEA
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c24so971276plo.3
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SDwwUAQcU4UQaqFj4888/4mcm46ff8kE75Sc8ddomE=;
        b=bQ/h16TaBrbEKL471sGSKt7Fnhx54Oxo+i13Wh5RLVqdbCO/c1Xo1KgrE1zmiKqGYJ
         +QxO8EWGhiADry5WPa0A7BdPK/Twph7L5UsJih/OxQ65BdZ/7Auc+SduAQudFUR3NVB7
         4KqhuXr2tL+FV61ZJAPMvd7zTmKXUgFg/jdDhNbUFzFfST54hKLd4rjWFvknggIDYgbG
         pFfMDIcwGDsV7aRLMoATfmpAMWldqZnAoBY1kytfrOJ65FybS8nY4o7aUHKtFvJxPh2S
         IyI62p4U3RbDcnsvLjxPiEDgKZXNOD1L4ruDdDWNXi2JbjFzazW3C+DNKehaE9atlv4q
         RsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SDwwUAQcU4UQaqFj4888/4mcm46ff8kE75Sc8ddomE=;
        b=3F7I7xyksucUjjZdY0MTnFxPMmvj6qKUC5EEMGYnjPPNeLp1XUDSL8CdZ/2+y2bk6Q
         Lbp9o+N6ZZDT4H2kGUSN20u0ZmC4DNj38h+2JlQfJq01qk5PAso4ohJjxVbMWmciZzOB
         cfKyfFJlsQC16R04uqpWbAQynrzP3jVDxDMhbVhIbCWEleG0s9UPuMJGTZujhjMaN+HI
         QknnRQsaajlptrbQSUXbYtifaslqo4Y2e84kAacqfKL9HRvun4eTLdiO6bBzX1VfJAxp
         YE0fvZL2X/RwX/trehJrEBcok7g+rGORKGp08zVsQP1yI9pt0SMT1yusewoheXworchF
         FD4Q==
X-Gm-Message-State: ACrzQf2a7S5BiOhxuuNBU5NQsV0CFPE63pUqgqPKwkEqDLz4rQhsERCr
        SZBsv6lPGJVqAM6SFLGjtaUX8kJZISg=
X-Google-Smtp-Source: AMsMyM73+Ru4hOwj3ZhsNfuAW4ebqfRjpOZucPxLsdSxpJQi1mX2sXLWn2RQW9aqYtVxTRjTXfd0kg==
X-Received: by 2002:a17:902:d544:b0:17d:318a:adf7 with SMTP id z4-20020a170902d54400b0017d318aadf7mr33796758plf.148.1665642272053;
        Wed, 12 Oct 2022 23:24:32 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id i68-20020a626d47000000b005631f2b9ba2sm1050067pfc.14.2022.10.12.23.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:24:31 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 20/25] bpf: Introduce bpf_kptr_drop
Date:   Thu, 13 Oct 2022 11:52:58 +0530
Message-Id: <20221013062303.896469-21-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7960; i=memxor@gmail.com; h=from:subject; bh=ZtpIjNKX5FgyEGZYfuOBT9+eo59UGzqq4QKdTH+njYc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67E3jC6LvuNdeh8l5XO6L/xquRvqITIP9ksb4nq jYdXngmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euxAAKCRBM4MiGSL8Ryi1oEA CcYrEVEyBbnFxgltQMMIUvG95JbnH9260THcJxyDtdMMykd4dvG05KgQAU8zp5XvSM1BKXoRh4pTzu O5cUyf4QzieirW6cS55b6M+A4S9qfo41ApLCZkqOwo2X4SubnJPhBzYQUWh+xFdzhgMbtYP/xg5CqX 8z7+nB/xMtOvvUkP5/TV41p/kL6I0WsSK50GrKtV4nP4uevKNtTfOhg1IBCe1gPRktbbgiORcy6xxt 3SbJvwrt/EWurrict1ZMrhaDQu4kPPlFh/vgrMQuX8RTXh4SZ1Q0Vavtu+SuDtu7pWpxz2n0Bs1+x1 sB9ZYqdeBp+uEkRc3HjtZ33avNJacdy6Dl76TA30JgXjjVJtfKHuH1F7Krrfq9Rt3xiNTKHB2i4dn1 wQjNmgpcD28MqswYsM+3TO6I/9scnBrf2d1BQKHZQE/siHcfuFmQKKHRe/3HjRpW5yo37uzE1gGF9N hX434tB99NwOv2slZgxn/jOqfHQnEG75VJWuOM5ucgUxdE3eK7Hk48rSq39qpW31RXwW1/WLU5znH4 JbgpoIBWkmEp+EZIo/nhabAx7uWN8AL8rjEMeWiVH6DeetBG6YhNXY4mMtfc8/95ZXojUyIZV8Dp5N 6A0g9ojzCASAJPYb2cXNMOLbnnUT3TkewwyFtaE+abCwrKdEwUim2QSJjXSA==
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

Introduce bpf_kptr_drop, which is the kfunc used to free local kptrs
allocated using bpf_kptr_new. Similar to bpf_kptr_new, it implicitly
destructs the fields part of the local kptr automatically without user
intervention.

Just like the previous patch, btf_struct_meta that is needed to free up
the special fields is passed as a hidden argument to the kfunc.

For the user, a convenience macro hides over the kernel side kfunc which
is named bpf_kptr_drop_impl.

Continuing the previous example:

void prog(void) {
	struct foo *f;

	f = bpf_kptr_new(typeof(*f));
	if (!f)
		return;
	bpf_kptr_drop(f);
}

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c                          | 11 ++++
 kernel/bpf/verifier.c                         | 66 +++++++++++++++----
 .../testing/selftests/bpf/bpf_experimental.h  | 13 ++++
 3 files changed, 79 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 954e0bf18269..43a7c9999e94 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1758,6 +1758,16 @@ void *bpf_kptr_new_impl(u64 local_type_id__k, u64 flags, void *meta__ign)
 	return p;
 }
 
+void bpf_kptr_drop_impl(void *p__lkptr, void *meta__ign)
+{
+	struct btf_struct_meta *meta = meta__ign;
+	void *p = p__lkptr;
+
+	if (meta)
+		bpf_obj_free_fields(meta->fields_tab, p);
+	bpf_mem_free(&bpf_global_ma, p);
+}
+
 __diag_pop();
 
 BTF_SET8_START(generic_btf_ids)
@@ -1765,6 +1775,7 @@ BTF_SET8_START(generic_btf_ids)
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_kptr_new_impl, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kptr_drop_impl, KF_RELEASE)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9cc01535e391..a4a806cb68dc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7693,6 +7693,10 @@ struct bpf_kfunc_call_arg_meta {
 		u64 value;
 		bool found;
 	} arg_constant;
+	struct {
+		struct btf *btf;
+		u32 btf_id;
+	} arg_kptr_drop;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7771,6 +7775,11 @@ static bool is_kfunc_arg_sfx_ignore(const struct btf *btf, const struct btf_para
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
@@ -7871,6 +7880,7 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 
 enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CTX,
+	KF_ARG_PTR_TO_LOCAL_BTF_ID,  /* Local kptr */
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
 	KF_ARG_PTR_TO_KPTR_STRONG,   /* PTR_TO_KPTR but type specific */
 	KF_ARG_PTR_TO_DYNPTR,
@@ -7878,6 +7888,20 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip it */
 };
 
+enum special_kfunc_type {
+	KF_bpf_kptr_new_impl,
+	KF_bpf_kptr_drop_impl,
+};
+
+BTF_SET_START(special_kfunc_set)
+BTF_ID(func, bpf_kptr_new_impl)
+BTF_ID(func, bpf_kptr_drop_impl)
+BTF_SET_END(special_kfunc_set)
+
+BTF_ID_LIST(special_kfunc_list)
+BTF_ID(func, bpf_kptr_new_impl)
+BTF_ID(func, bpf_kptr_drop_impl)
+
 enum kfunc_ptr_arg_type get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 						struct bpf_kfunc_call_arg_meta *meta,
 						const struct btf_type *t,
@@ -7899,6 +7923,9 @@ enum kfunc_ptr_arg_type get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (btf_get_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
 		return KF_ARG_PTR_TO_CTX;
 
+	if (is_kfunc_arg_local_kptr(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_LOCAL_BTF_ID;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -8117,6 +8144,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return kf_arg_type;
 
 		switch (kf_arg_type) {
+		case KF_ARG_PTR_TO_LOCAL_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (is_kfunc_trusted_args(meta) && !reg->ref_obj_id) {
 				verbose(env, "R%d must be referenced\n", regno);
@@ -8151,6 +8179,21 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
+			    meta->func_id == special_kfunc_list[KF_bpf_kptr_drop_impl]) {
+				meta->arg_kptr_drop.btf = reg->btf;
+				meta->arg_kptr_drop.btf_id = reg->btf_id;
+			}
+			break;
 		case KF_ARG_PTR_TO_BTF_ID:
 			/* Only base_type is checked, further checks are done here */
 			if (reg->type != PTR_TO_BTF_ID &&
@@ -8221,17 +8264,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 	return 0;
 }
 
-enum special_kfunc_type {
-	KF_bpf_kptr_new_impl,
-};
-
-BTF_SET_START(special_kfunc_set)
-BTF_ID(func, bpf_kptr_new_impl)
-BTF_SET_END(special_kfunc_set)
-
-BTF_ID_LIST(special_kfunc_list)
-BTF_ID(func, bpf_kptr_new_impl)
-
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
@@ -8358,6 +8390,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				env->insn_aux_data[insn_idx].kptr_new_size = ret_t->size;
 				env->insn_aux_data[insn_idx].kptr_struct_meta =
 					btf_find_struct_meta(ret_btf, ret_btf_id);
+			} else if (meta.func_id == special_kfunc_list[KF_bpf_kptr_drop_impl]) {
+				env->insn_aux_data[insn_idx].kptr_struct_meta =
+					btf_find_struct_meta(meta.arg_kptr_drop.btf,
+							     meta.arg_kptr_drop.btf_id);
 			} else {
 				verbose(env, "kernel function %s unhandled dynamic return type\n",
 					meta.func_name);
@@ -14557,6 +14593,14 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[2] = addr[1];
 		insn_buf[3] = *insn;
 		*cnt = 4;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_kptr_drop_impl]) {
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
index 9c7d0badb02e..c47d16f3e817 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -39,4 +39,17 @@ extern void *bpf_kptr_new_impl(__u64 local_type_id, __u64 flags, void *meta__ign
 /* Convenience macro to wrap over bpf_kptr_new_impl */
 #define bpf_kptr_new(type) bpf_kptr_new_impl(bpf_core_type_id_local(type), 0, NULL)
 
+/* Description
+ *	Free a local kptr. All fields of local kptr that require destruction
+ *	will be destructed before the storage is freed.
+ *
+ *	The 'meta__ign' parameter is a hidden argument that is ignored.
+ * Returns
+ *	Void.
+ */
+extern void bpf_kptr_drop_impl(void *kptr, void *meta__ign) __ksym;
+
+/* Convenience macro to wrap over bpf_kptr_drop_impl */
+#define bpf_kptr_drop(kptr) bpf_kptr_drop_impl(kptr, NULL)
+
 #endif
-- 
2.38.0

