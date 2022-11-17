Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3CF62E8D3
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbiKQW4M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiKQW4K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:56:10 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC276657F3
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:56:09 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id r18so3398481pgr.12
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++ULrfF8CmAP2xQVn0biv80cUJKxHLKHh12y4coOwaU=;
        b=m/9dLYPqUIDl56gmGLMERMYPtDrChkKkWcCCfbJiFmmx7UeRIZVrByWMCo26xpWpOz
         tXTbI97DzT6FXGUCmRHl3Kkncr+ucGW+UWFl0z7btepfTr8Bav9t54sLDkU6c3CMe/SZ
         5NQp3pe5GL+TNCKiz1ksHnfIFiq1yiF5An7iEdkoKE6Y/6fV3q6Xef3BJKlYoIekxzdJ
         DBY9ZYUXG8Y1vHtxoIT0tQS9U/2+o35jvG1vBmFzBMwMyFP+O15W01Fovl0K1LrW3bNC
         zPXUslVm9+V2IG2zW1p33NBbJ+FSiXqzT9uqvv2PHbXmMrQA5QRTkKyfxxizTYUpmc+r
         Mrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++ULrfF8CmAP2xQVn0biv80cUJKxHLKHh12y4coOwaU=;
        b=W82XAadG/hI0yl22/ql+qdzusJnKmI0+oKAbeCcVoAH0TgZ3w7yaiDjv4V2T/zgUKN
         aXI+Za+a7gMo/pmi1MAeU6oGws2yHlZV9vZmLFN8Ab/OVK3oe6WIeF0/IJXXfcqQbZVL
         E3N5cqQpz6ZeD3E6aHEx3cUcuvj3LnukHXcEv4ANYdoLqixFRI37a9EOhnTW/A2TbOEK
         RuK/OpW2XV3/ZwspuzFoxvUdgNv8Zb9iQNoKiPZyCRDJkEhirAiuyZeNYFkFILFLl+zx
         fV3S9cg26YjyQ206WP19KN33y8wcJAdmuQyhgW1sV/Ybk/K751dwELqftyPg09pJOdfP
         mWcw==
X-Gm-Message-State: ANoB5pmd2joWpSYk6MIKgjpn4yDk+uJjxOxZh0ZnnEI9+lqgh0+nli/a
        mHWIErLuqM6Ig9pdcRBZo4f4CYtLRGY=
X-Google-Smtp-Source: AA0mqf4anDXAwyMCqnidz7nRCJDwxHwEctZCLy4uLljbXnZECpb5BqiiQ9PohGi2Ql0bgnwTQNavaQ==
X-Received: by 2002:a63:1760:0:b0:46f:9c0b:1e86 with SMTP id 32-20020a631760000000b0046f9c0b1e86mr3904530pgx.508.1668725768881;
        Thu, 17 Nov 2022 14:56:08 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7948b000000b0056262811c5fsm1706285pfk.59.2022.11.17.14.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:56:08 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v9 14/23] bpf: Introduce bpf_obj_drop
Date:   Fri, 18 Nov 2022 04:25:01 +0530
Message-Id: <20221117225510.1676785-15-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117225510.1676785-1-memxor@gmail.com>
References: <20221117225510.1676785-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7736; i=memxor@gmail.com; h=from:subject; bh=mZvoCqtK4h6DgMb78xDqGgfqpZU5R/RixAo8Aq5Ac4M=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdrkcy5zIvV+rHl3HnRQRK/23jp1DhZbBL7igEk0m 7vRD9rCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3a5HAAKCRBM4MiGSL8RyjH6EA Cm3/rAN7TeRtHMaj4wav1xPRAzLmFMn4P6Ezf1CokgXN9lkD+pNdOA7Vfeyxm+RJyTYf+l7tpLYfJs UHw9lIG2cLWeoCQzYjsrtA28kAOCrZiqI/i1OdpbvKL7gENxMN8h9m8yp4b7DqhISCEbyOB1iDtoMJ adZatYCbByXyMgtd0pA6LUEjObH5eKEuR4YdWJ5CN+bqtREg8hpNIrMAoYS7rOLGAsxOl61vRWDsGB vTDevJ4pPXPp/AK/zDYXXaDPaUuczMeHxnvT794YoYWgqaqKGZoK4GyZLaSIW3iy2NuuJPshfb8DkE pARczDtltYevtk160rKScwpYjEs37r8EpH29VkQY6kg7MuOd2eK8cm2n+/3sKpjuTvLHdENp9Z7Ggf zahIP36nowViLTQZAuMVItHkIKCWLZa4QlNO7dkw5D2Y2bCsdbEonon7Z6be5OwMGqnlaQ04FENU/m N+Z9I/B1X8eVJuNTNrqLUn6lkEVTLoX+D2vk3KhHcFQSgmpgMO89tQzxa/1Z1ecMxOu0SuSovZ2P47 yzQWmSKr9hyqvO918Mj4dHwFAc3lDWqnM1bjoYs0RsbKbpvA7idQ0OxYLuFPtYqz1COVek8I7CYpl+ 36DShHnHjPpA1W1viLJBYBleVdg1RXEMwaVOJcnmHgVoRtgPoh7WoTkQDKCA==
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

