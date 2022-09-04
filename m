Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C575AC66F
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiIDUmO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiIDUmM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295792CDFA
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:05 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id bj12so13403954ejb.13
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=HQCdSJNlxaXmOsZS9tnKFCxgepJVNdB/Dm0F24xT02k=;
        b=Zwy9oMMQlHWRkeGUvZ0ntL4Aobr8BZUhgPVriwfgpvcwRbNuq54PuOBzboHGd+yCXZ
         yGK8OBOGMam94SdWdFL1JS8akhDCEYVU+FeuqB+SQlyJN6KnXYYDc53MWSFJyaJlhWwO
         3Qx6mse2vEXkUEqd4gC8MbsKWETakxMGo+xM3qCu4ZJyUG/IN7ATF+dc7Jj23eQfshEm
         zKWJM2dYjjFazIm1898i83vatScuV28Hb1x4iRD5IGA8QHKnRRhVgQUAsski5UMgrpj4
         yz654L6cvz51OBgXlB+hjsQdytuZ5BASKU9g+Og0SLe9WM0VWP0K/Rh6L96NmB4wpusR
         cY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HQCdSJNlxaXmOsZS9tnKFCxgepJVNdB/Dm0F24xT02k=;
        b=Rv1/9elM3TpNpP9EHfWmhXzK/WmFfUYM06x8z8+o7Wz2a1/uCqL2eQhLvqPZ6ZhIT8
         3esBFv+mW/iY3NNaRGF9orORPfeHbYu0sXMy8fmnBxENT3cfhMmKtc75n/ZqBoTxAA58
         TeNuZum6PBAvF0+IqcaVWF82t2+s7KBjmxQVko3h8uLy3WFKMpYvegiqwRNe7TQCaccv
         yZznb64WihMd9ibfx2XgOw6u/WyjgM5P766FaptZRd31n/XHuI3hJNYuXGzfWZHy2lw5
         8T8Gc746i0voeqnUxF17RrX4rMXFLDRDE40MdCmYtnV3bAsHoiFlFvWQXgXgeCY3RmCb
         ZGGA==
X-Gm-Message-State: ACgBeo0mpUo9RcBP3QxacNtvIGQ4ICe1AteHYkCpUf/IG9tLxwVBD3Rc
        LPSFSOzQUyJVWVeMS/A78yw2JZZgPwooyA==
X-Google-Smtp-Source: AA6agR4Cdrf/vbxNAU6bOv7y9tDbf6lqd7iIGW4x+Bzvk1oENuiHB+gdm2XOarjgzggRjNefgKVikg==
X-Received: by 2002:a17:907:2716:b0:73d:cdf9:b08a with SMTP id w22-20020a170907271600b0073dcdf9b08amr32753354ejk.463.1662324124115;
        Sun, 04 Sep 2022 13:42:04 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id n12-20020aa7c68c000000b0044e8d0682b2sm527797edq.71.2022.09.04.13.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:03 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 14/32] bpf: Introduce bpf_kptr_alloc helper
Date:   Sun,  4 Sep 2022 22:41:27 +0200
Message-Id: <20220904204145.3089-15-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17684; i=memxor@gmail.com; h=from:subject; bh=kdPECa49O/2+OJLmISQNWs29QQyLXZSERZjriEzRHdo=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1wodupiAnSIWZDlW2Lr6h5XsVSeN5EUYjyU5HZ cT+sZ2iJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcAAKCRBM4MiGSL8RyhUPEA C9tLPggWndDizNu/8N4mqckGJZU0lvo6k9WyIQ09xero2qdDqdNHn3XS/GemFDNXdJ7GZ+hz5yqT7U r9rbjqc0UYzgcVQNmxrYKguFW5sIDk60saA7bH6FS7wNmaOOsncyjqLQKUqBnjHUDXsKe0FlOYg6oR cxJzgIr75lHhxEUolTmzj0g9Bv+Z6Na2DI3fGajvHndopB9dVSFJztjfKuhpcnb4H2dhmqpGbw+s97 NcKCSPp5jEZ7vJ5GaeNKFsRIHv1I1OQU/7R5TdjpZChnMAnuFcgmJgOjuAmzZRrNXCX4Ejpk5CFyMJ M4dvkSgT1juPEErIoM6NwQqoyytxa6iVa5aULZa3NNhvguHUsuabB2Hsf5e4IQo8HdBtL5uwIg54pl Jql+3KyW5G1knHJ5mY5/vj5Eyzzii4T2tbjjwiZ2RIXZzf42x6awRYkeAS6cyI6IzPifyR/2cYwb5B vNN/Uhz9CZyhslm8qaUNj8I3YYYyqfFIUE3hLa2ROG24k4t6oTZMDsBGGBVYXgL8Sd0O5DAsG1OLU6 vXoX1gJUblGLGggiPOHGIF0dIw+RtNc1N4Ebq67g8sdFYf2146r29hjdeRoAKoi4aHMfhWfvXgMRoK WnHuaypj7wFBZiFkcfn+mAz1zO1frqBmaU9R+MPZnJB2TEkDaFYuNdzRLhBg==
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

To allocate local kptr of types pointing into program BTF instead of
kernel BTF, bpf_kptr_alloc is a new helper that takes the local type's
BTF ID and returns a pointer to it. The size is automatically inferred
from the type ID by the BPF verifier, so user only passes the BTF ID and
flags, if any. For now, no flags are supported.

First, we use the new constant argument type support for kfuncs that
enforces argument is a constant. We need to know the local type's BTF ID
statically to enforce safety properties for the allocation. Next, we
remember this and dynamically assign the return type. During that phase,
we also query the actual size of the structure being allocated, and
whether it is a struct type. If so, we stash the actual size for
do_misc_fixups phase where we rewrite the first argument to be size
instead of local type's BTF ID, which we can then pass on to the kernel
allocator.

This needs some additional support for kfuncs as we were not doing
argument rewrites for them. The fixup has been moved inside
fixup_kfunc_call itself to avoid polluting the huge do_misc_fixups,
and delta, prog, and insn pointers are recalculated based on if any
instructions were patched.

The returned pointer needs to be handled specially as well. While
normally, only struct pointers may be returned, a new internal kfunc
flag __KF_RET_DYN_BTF is used to indicate the BTF is ascertained from
arguments dynamically, hence it is now forced to be void * instead.
For now, bpf_kptr_alloc is the only user of this support.

Hence, allocations using bpf_kptr_alloc are type safe. Later patches
will introduce constructor and destructor support to local kptrs
allocated from this helper. This would allow embedding kernel objects
like bpf_spin_lock, bpf_list_node, bpf_list_head inside a local kptr
allocation, and ensuring they are correctly initialized before use.

A new type flag is associated with PTR_TO_BTF_ID returned from
bpf_kptr_alloc: MEM_TYPE_LOCAL. This indicates that the type of the
memory is of a local type coming from program's BTF.

The btf_struct_access mechanism is tuned to allow BPF_WRITE access to
these allocated objects, so that programs can store data as usual in
them. On following a pointer type inside such PTR_TO_BTF_ID, WALK_PTR
sets the destination register as scalar instead. It would not be safe to
recognize pointer types in local types. This can be changed in the
future if it is allowed to embed kptrs inside such local kptrs.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                           |  12 +-
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/btf.h                           |   3 +
 kernel/bpf/btf.c                              |   8 +-
 kernel/bpf/helpers.c                          |  17 ++
 kernel/bpf/verifier.c                         | 156 +++++++++++++++---
 net/bpf/bpf_dummy_struct_ops.c                |   5 +-
 net/ipv4/bpf_tcp_ca.c                         |   5 +-
 .../testing/selftests/bpf/bpf_experimental.h  |  14 ++
 9 files changed, 191 insertions(+), 30 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 35c2e9caeb98..5c8bfb0eba17 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -486,6 +486,12 @@ enum bpf_type_flag {
 	/* Size is known at compile time. */
 	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
 
+	/* MEM is of a type from program BTF, not kernel BTF. This is used to
+	 * tag PTR_TO_BTF_ID allocated using bpf_kptr_alloc, since they have
+	 * entirely different semantics.
+	 */
+	MEM_TYPE_LOCAL		= BIT(11 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
@@ -757,7 +763,8 @@ struct bpf_verifier_ops {
 				 const struct btf *btf,
 				 const struct btf_type *t, int off, int size,
 				 enum bpf_access_type atype,
-				 u32 *next_btf_id, enum bpf_type_flag *flag);
+				 u32 *next_btf_id, enum bpf_type_flag *flag,
+				 bool local_type);
 };
 
 struct bpf_prog_offload_ops {
@@ -1995,7 +2002,8 @@ static inline bool bpf_tracing_btf_ctx_access(int off, int size,
 int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
 		      const struct btf_type *t, int off, int size,
 		      enum bpf_access_type atype,
-		      u32 *next_btf_id, enum bpf_type_flag *flag);
+		      u32 *next_btf_id, enum bpf_type_flag *flag,
+		      bool local_type);
 bool btf_struct_ids_match(struct bpf_verifier_log *log,
 			  const struct btf *btf, u32 id, int off,
 			  const struct btf *need_btf, u32 need_type_id,
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c4d21568d192..c6d550978d63 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -403,6 +403,7 @@ struct bpf_insn_aux_data {
 		 */
 		struct bpf_loop_inline_state loop_inline_state;
 	};
+	u64 kptr_alloc_size; /* used to store size of local kptr allocation */
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 9b62b8b2117e..fc35c932e89e 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -52,6 +52,9 @@
 #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
 #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
 
+/* Internal kfunc flags, not meant for general use */
+#define __KF_RET_DYN_BTF (1 << 7) /* kfunc returns dynamically ascertained PTR_TO_BTF_ID */
+
 struct btf;
 struct btf_member;
 struct btf_type;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0fb045be3837..17977e0f4e09 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5919,7 +5919,8 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
 		      const struct btf_type *t, int off, int size,
 		      enum bpf_access_type atype __maybe_unused,
-		      u32 *next_btf_id, enum bpf_type_flag *flag)
+		      u32 *next_btf_id, enum bpf_type_flag *flag,
+		      bool local_type)
 {
 	enum bpf_type_flag tmp_flag = 0;
 	int err;
@@ -5930,6 +5931,11 @@ int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
 
 		switch (err) {
 		case WALK_PTR:
+			/* For local types, the destination register cannot
+			 * become a pointer again.
+			 */
+			if (local_type)
+				return SCALAR_VALUE;
 			/* If we found the pointer or scalar on t+off,
 			 * we're done.
 			 */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index fc08035f14ed..d417aa4f0b22 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1696,10 +1696,27 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 	}
 }
 
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+void *bpf_kptr_alloc(u64 local_type_id__k, u64 flags)
+{
+	/* Verifier patches local_type_id__k to size */
+	u64 size = local_type_id__k;
+
+	if (flags)
+		return NULL;
+	return kmalloc(size, GFP_ATOMIC);
+}
+
+__diag_pop();
+
 BTF_SET8_START(tracing_btf_ids)
 #ifdef CONFIG_KEXEC_CORE
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
+BTF_ID_FLAGS(func, bpf_kptr_alloc, KF_ACQUIRE | KF_RET_NULL | __KF_RET_DYN_BTF)
 BTF_SET8_END(tracing_btf_ids)
 
 static const struct btf_kfunc_id_set tracing_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ab91e5ca7e41..8f28aa7f1e8d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -472,6 +472,11 @@ static bool type_may_be_null(u32 type)
 	return type & PTR_MAYBE_NULL;
 }
 
+static bool type_is_local(u32 type)
+{
+	return type & MEM_TYPE_LOCAL;
+}
+
 static bool is_acquire_function(enum bpf_func_id func_id,
 				const struct bpf_map *map)
 {
@@ -4556,17 +4561,22 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (env->ops->btf_struct_access) {
+	/* For allocated PTR_TO_BTF_ID pointing to a local type, we cannot do
+	 * btf_struct_access callback.
+	 */
+	if (env->ops->btf_struct_access && !type_is_local(reg->type)) {
 		ret = env->ops->btf_struct_access(&env->log, reg->btf, t,
-						  off, size, atype, &btf_id, &flag);
+						  off, size, atype, &btf_id, &flag,
+						  false);
 	} else {
-		if (atype != BPF_READ) {
+		/* It is allowed to write to pointer to a local type */
+		if (atype != BPF_READ && !type_is_local(reg->type)) {
 			verbose(env, "only read is supported\n");
 			return -EACCES;
 		}
 
 		ret = btf_struct_access(&env->log, reg->btf, t, off, size,
-					atype, &btf_id, &flag);
+					atype, &btf_id, &flag, type_is_local(reg->type));
 	}
 
 	if (ret < 0)
@@ -4630,7 +4640,7 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	ret = btf_struct_access(&env->log, btf_vmlinux, t, off, size, atype, &btf_id, &flag);
+	ret = btf_struct_access(&env->log, btf_vmlinux, t, off, size, atype, &btf_id, &flag, false);
 	if (ret < 0)
 		return ret;
 
@@ -7661,6 +7671,11 @@ static bool is_kfunc_destructive(struct bpf_kfunc_arg_meta *meta)
 	return meta->kfunc_flags & KF_DESTRUCTIVE;
 }
 
+static bool __is_kfunc_ret_dyn_btf(struct bpf_kfunc_arg_meta *meta)
+{
+	return meta->kfunc_flags & __KF_RET_DYN_BTF;
+}
+
 static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_arg_meta *meta, int arg)
 {
 	return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
@@ -7751,6 +7766,24 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 #endif
 };
 
+BTF_ID_LIST(special_kfuncs)
+BTF_ID(func, bpf_kptr_alloc)
+
+enum bpf_special_kfuncs {
+	KF_SPECIAL_bpf_kptr_alloc,
+	KF_SPECIAL_MAX,
+};
+
+static bool __is_kfunc_special(const struct btf *btf, u32 func_id, unsigned int kf_sp)
+{
+	if (btf != btf_vmlinux || kf_sp >= KF_SPECIAL_MAX)
+		return false;
+	return func_id == special_kfuncs[kf_sp];
+}
+
+#define is_kfunc_special(btf, func_id, func_name) \
+	__is_kfunc_special(btf, func_id, KF_SPECIAL_##func_name)
+
 enum kfunc_ptr_arg_types {
 	KF_ARG_PTR_TO_CTX,
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
@@ -8120,20 +8153,55 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		mark_reg_unknown(env, regs, BPF_REG_0);
 		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
 	} else if (btf_type_is_ptr(t)) {
-		ptr_type = btf_type_skip_modifiers(desc_btf, t->type,
-						   &ptr_type_id);
-		if (!btf_type_is_struct(ptr_type)) {
-			ptr_type_name = btf_name_by_offset(desc_btf,
-							   ptr_type->name_off);
-			verbose(env, "kernel function %s returns pointer type %s %s is not supported\n",
-				func_name, btf_type_str(ptr_type),
-				ptr_type_name);
-			return -EINVAL;
-		}
+		struct btf *ret_btf;
+		u32 ret_btf_id;
+
+		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
 		mark_reg_known_zero(env, regs, BPF_REG_0);
-		regs[BPF_REG_0].btf = desc_btf;
 		regs[BPF_REG_0].type = PTR_TO_BTF_ID;
-		regs[BPF_REG_0].btf_id = ptr_type_id;
+
+		if (__is_kfunc_ret_dyn_btf(&meta)) {
+			const struct btf_type *ret_t;
+
+			/* Currently, only bpf_kptr_alloc needs special handling */
+			if (!is_kfunc_special(meta.btf, meta.func_id, bpf_kptr_alloc) ||
+			    !meta.arg_constant.found || !btf_type_is_void(ptr_type)) {
+				verbose(env, "verifier internal error: misconfigured kfunc\n");
+				return -EFAULT;
+			}
+
+			if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
+				verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");
+				return -EINVAL;
+			}
+
+			ret_btf = env->prog->aux->btf;
+			ret_btf_id = meta.arg_constant.value;
+
+			ret_t = btf_type_by_id(ret_btf, ret_btf_id);
+			if (!ret_t || !__btf_type_is_struct(ret_t)) {
+				verbose(env, "local type ID %d passed to bpf_kptr_alloc does not refer to struct\n",
+					ret_btf_id);
+				return -EINVAL;
+			}
+			/* Remember this so that we can rewrite R1 as size in fixup_kfunc_call */
+			env->insn_aux_data[insn_idx].kptr_alloc_size = ret_t->size;
+			/* For now, since we hardcode prog->btf, also hardcode
+			 * setting of this flag.
+			 */
+			regs[BPF_REG_0].type |= MEM_TYPE_LOCAL;
+		} else {
+			if (!btf_type_is_struct(ptr_type)) {
+				ptr_type_name = btf_name_by_offset(desc_btf, ptr_type->name_off);
+				verbose(env, "kernel function %s returns pointer type %s %s is not supported\n",
+					func_name, btf_type_str(ptr_type), ptr_type_name);
+				return -EINVAL;
+			}
+			ret_btf = desc_btf;
+			ret_btf_id = ptr_type_id;
+		}
+		regs[BPF_REG_0].btf = ret_btf;
+		regs[BPF_REG_0].btf_id = ret_btf_id;
 		if (is_kfunc_ret_null(&meta)) {
 			regs[BPF_REG_0].type |= PTR_MAYBE_NULL;
 			/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
@@ -14371,8 +14439,43 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 	return err;
 }
 
+static int do_kfunc_fixups(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			   s32 imm, int insn_idx, int delta)
+{
+	struct bpf_insn insn_buf[16];
+	struct bpf_prog *new_prog;
+	int cnt;
+
+	/* No need to lookup btf, only vmlinux kfuncs are supported for special
+	 * kfuncs handling. Hence when insn->off is zero, check if it is a
+	 * special kfunc by hardcoding btf as btf_vmlinux.
+	 */
+	if (!insn->off && is_kfunc_special(btf_vmlinux, insn->imm, bpf_kptr_alloc)) {
+		u64 local_type_size = env->insn_aux_data[insn_idx + delta].kptr_alloc_size;
+
+		insn_buf[0] = BPF_MOV64_IMM(BPF_REG_1, local_type_size);
+		insn_buf[1] = *insn;
+		cnt = 2;
+
+		new_prog = bpf_patch_insn_data(env, insn_idx + delta, insn_buf, cnt);
+		if (!new_prog)
+			return -ENOMEM;
+
+		delta += cnt - 1;
+		insn = new_prog->insnsi + insn_idx + delta;
+		goto patch_call_imm;
+	}
+
+	insn->imm = imm;
+	return 0;
+patch_call_imm:
+	insn->imm = imm;
+	return cnt - 1;
+}
+
 static int fixup_kfunc_call(struct bpf_verifier_env *env,
-			    struct bpf_insn *insn)
+			    struct bpf_insn *insn,
+			    int insn_idx, int delta)
 {
 	const struct bpf_kfunc_desc *desc;
 
@@ -14391,9 +14494,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env,
 		return -EFAULT;
 	}
 
-	insn->imm = desc->imm;
-
-	return 0;
+	return do_kfunc_fixups(env, insn, desc->imm, insn_idx, delta);
 }
 
 /* Do various post-verification rewrites in a single program pass.
@@ -14534,9 +14635,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (insn->src_reg == BPF_PSEUDO_CALL)
 			continue;
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
-			ret = fixup_kfunc_call(env, insn);
-			if (ret)
+			ret = fixup_kfunc_call(env, insn, i, delta);
+			if (ret < 0)
 				return ret;
+			/* If ret > 0, fixup_kfunc_call did some instruction
+			 * rewrites. Increment delta, reload prog and insn,
+			 * env->prog is already set by it to the new_prog.
+			 */
+			if (ret) {
+				delta += ret;
+				prog = env->prog;
+				insn = prog->insnsi + i + delta;
+			}
 			continue;
 		}
 
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index e78dadfc5829..fa572714c6f6 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -160,7 +160,8 @@ static int bpf_dummy_ops_btf_struct_access(struct bpf_verifier_log *log,
 					   const struct btf_type *t, int off,
 					   int size, enum bpf_access_type atype,
 					   u32 *next_btf_id,
-					   enum bpf_type_flag *flag)
+					   enum bpf_type_flag *flag,
+					   bool local_type)
 {
 	const struct btf_type *state;
 	s32 type_id;
@@ -178,7 +179,7 @@ static int bpf_dummy_ops_btf_struct_access(struct bpf_verifier_log *log,
 	}
 
 	err = btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
-				flag);
+				flag, false);
 	if (err < 0)
 		return err;
 
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 85a9e500c42d..869b6266833c 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -73,13 +73,14 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
 					const struct btf_type *t, int off,
 					int size, enum bpf_access_type atype,
 					u32 *next_btf_id,
-					enum bpf_type_flag *flag)
+					enum bpf_type_flag *flag,
+					bool local_type)
 {
 	size_t end;
 
 	if (atype == BPF_READ)
 		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
-					 flag);
+					 flag, false);
 
 	if (t != tcp_sock_type) {
 		bpf_log(log, "only read is supported\n");
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index ea1b3b1839d1..bddd77093d1e 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -18,4 +18,18 @@ struct bpf_list_node {
 #endif
 
 #ifndef __KERNEL__
+
+/* Description
+ *	Allocates a local kptr of type represented by 'local_type_id' in program
+ *	BTF. User may use the bpf_core_type_id_local macro to pass the type ID
+ *	of a struct in program BTF.
+ *
+ *	The 'local_type_id' parameter must be a known constant.
+ *	The 'flags' parameter must be 0.
+ * Returns
+ *	A local kptr corresponding to passed in 'local_type_id', or NULL on
+ *	failure.
+ */
+void *bpf_kptr_alloc(__u64 local_type_id, __u64 flags) __ksym;
+
 #endif
-- 
2.34.1

