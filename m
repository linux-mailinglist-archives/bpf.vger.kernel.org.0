Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FAC5FAA15
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiJKB1x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJKB1v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:27:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AF01402F
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:27:51 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p14so7850662pfq.5
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puLmuAuJcffy9eAjZWfTWoAkx6VHPwAnTTlh8AZP39s=;
        b=VDdV9qZ3L20TMzcqlw2oYG39Tzsn8DpYx1TK/Hq8CNJjnmAIH487aePRIZ8w8qoBpQ
         6bRKgtf5rtLB3COTJnHIh4F9Buil1rTXa0CQT8z36VioHwo/hnOdT8bwfr7h6Um+RyWk
         wdQNmTEF5X1DUyFfymko09dK0k65KDLiWmcLJK5RzdJUnyRAvNFIc/vWC20NZlScNpAT
         bRlSE/RSmr2ORQq2YbDHg7hIge/39S7/Vx8e9k9N0uGHd1AGpYZP4pt+Dssp4ntSmHlP
         WRY0ezCK2Fbd5bd7x+liM3ClyehXim5eTSqQPjh+7GiwFDoEpRes6yatehoN3L3uahGM
         DCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puLmuAuJcffy9eAjZWfTWoAkx6VHPwAnTTlh8AZP39s=;
        b=PUPtvmpH8pvs6og3K/IDYXZf4fml+suTUEqInTLOUUVICJ52WAzORzEqelhwiORYFO
         /BiKvf+OXVD7bvPcJWTQrD5XYcXWt5Tdr2XfE1CAPHync3ZkZQVCLRvW0NxtAApM2DsH
         j3rFSMmriVeqSUax5q6G5oCvVMFNdAPFMyuY+UceH847Yk8cIqdu/Ex+Sk3t4XwnJ7L4
         xygPHc+L4v9oVvMqh5vjexNYL8cYynUzT9fozIJX4nvGQ733+Bv7DLBLeSk5S9wyxva6
         v2nHM3aY/Eu0hToT7cWr4DOqz2+lgcDV0phBs095C6lnsJAxqWXN6R3TrqPGl8LkvVWX
         2+tg==
X-Gm-Message-State: ACrzQf1gN24M2rvCtjF9Cb0PehQHMzfW6ADMIzGcWihxjLFO81E0OOjz
        2SiffOO+QOjdCgWRfMrizRMRE7PHSm7tGQ==
X-Google-Smtp-Source: AMsMyM5L1piovc1K1s3XcDeOoKxKUZ3NUkYfXed2O5W/lGnpfVs3pa2TT7YR9w0oneqTWXbdIteQlw==
X-Received: by 2002:a63:2a97:0:b0:457:23e9:586d with SMTP id q145-20020a632a97000000b0045723e9586dmr18825810pgq.190.1665451670235;
        Mon, 10 Oct 2022 18:27:50 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e80400b0018099c987e6sm5735642plg.285.2022.10.10.18.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:27:49 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 20/25] bpf: Introduce bpf_kptr_drop
Date:   Tue, 11 Oct 2022 06:52:35 +0530
Message-Id: <20221011012240.3149-21-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7960; i=memxor@gmail.com; h=from:subject; bh=QERsWQ37S31KC1RANbJUn8tjGy2WCtflnEWATPXqxVI=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUbA1Cvm+u9ADyBY9KuHacmztDozZh/z5Dt6pSq W/5LWaiJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGwAKCRBM4MiGSL8RyqlwEA CfIZHo3wiilAshWwYPdl3QV5BZscWBgw+YMBCgw4++S6ECeyzyze092cJK+5bNyFw6KecSzaIixesX 7/EHASCf3A3p3s9ywmmKXUsEiQo4zGYJPg3GEY5hdIaK3K2rvjYcFwiunAgqkyU+RV7h9yQCkJNNib oRn733vYrVIrWUtjRWXTRsp0EchrkZhHCBDqw6WmbkY2POTAwjIjq+e+Jr9ERLOtEeB0BK25afIaMq lAynzwZMsGCSuhkcehYNTr9QNzU/Lq2QoJvBAxwE3RIacEWWOFDIH8fzVUJIJAZwL/sN7Fa8WajNTj UZr9R4ixHSokwcxHv8psrA4Akh4kCUmhghbDtybrwnLvUpNu1k+4C55Qgnae5+4mBJ3GBG8ZVxKiqQ wkEsLneC8B/lMd4GRXG9NK4aKldKRbIpuI2czPaV2SKENaP35SAoWzTrw9Jz1uLAKvcLOdmB2Th334 KwstKqIF7Cnq5nZSrgHp2U+FtSOqfEUCGOjbxzZ7+QWo9mq36HBiKVyvYl0NhF64p2kQOtLef+9+Pv +6dg3/l1JnUR+ZsLiauY60mpwkF+9NvQFJI6kh/vtmYczFM95AHmy39JOXYKKrFlHh8Zh6IdOtqRkS FAjvXOFcjEKGNljijQSoCe7DHR7wRy1IDF/SSJO1lijuipDgTWj5SpVEVzLA==
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
index c7c3c049e647..90e3000d1c3a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1755,6 +1755,16 @@ void *bpf_kptr_new_impl(u64 local_type_id__k, u64 flags, void *meta__ign)
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
@@ -1762,6 +1772,7 @@ BTF_SET8_START(generic_btf_ids)
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_kptr_new_impl, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kptr_drop_impl, KF_RELEASE)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 21d71db16699..cda854715981 100644
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
2.34.1

