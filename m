Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F695AC66C
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiIDUmH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiIDUmD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:03 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581512CDE5
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id bj12so13403753ejb.13
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=W8C31xb74HJMrbk5BIvg4AQyKVRgyhEh/MCevSVhLwI=;
        b=bAOSAugUK8f/7RR8C7gFWOIwCpMOE29KIri+583CiotbGW5MpMhFTKAfMUoBHTALW1
         PWOA8hLdISQUvGDghtqVPb9fATki5n50RmP/Vp+guwyh0tLSllWrlojMi3nVgo6a/e6Y
         uF5K4IH9aerP7hqMWarEWI0xY3rXPDAMaUDp8MTd4aCXPDc/VOV+Y4eT2fGAReBX3ALD
         WRixTTMa/5KwASfisCDSs910s+GWpAONssqUVVexDx1XvXJCswieQrW70eUQQs7zj7c4
         kqOrcpVYFfTqeKq2LMP/lrc1rg8KzYe6UatVV+CFsUUWYjKUiklgV6cGjbCGRMQQreAE
         NatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=W8C31xb74HJMrbk5BIvg4AQyKVRgyhEh/MCevSVhLwI=;
        b=uGYxfr4djdHPt8UD26+9WHY5agvsqAfH/yENRPqbwMT+Z7OeJPO8HGISgewY4xBxKe
         3I0H8M+fvvHzmbKzaa2MoXfccvxLFNb3mZAkwrVaIksPA+oo9JIRlQdNJBweIOQ3H6fP
         jTZ/VyvvMJEIspmOIok6Ku8x0zt+26/w+nKZWpTXqxTyqh24MPNbsxsxoJZ36aqxM/kE
         4tmdjqSe00nlYAOcNUglkklziWzidUqhRT19Lw4+awnn1pyHoNFDteb/MKI3fEPJxnJA
         rvjxlsSZ/4feksblRZ7g7cE3MzYSK5iwBRGJoUc4roaAJBQhlHHA7m3+/5mljB6LCXeR
         6R2g==
X-Gm-Message-State: ACgBeo2Afx70DpkPfbK6pZ5wIsvgYMaCpFoG8wENKl9IZorIbQqGuhNc
        PWADCiQUcOfY3CB9jE/O/Ye91K4oQR6g7g==
X-Google-Smtp-Source: AA6agR5qmd43HRd/8/O/hIGQR0SDNHFNmlsEGCLMhfMHKtk2XJbVTfBVQn83SSAea05LQSBD44aVHg==
X-Received: by 2002:a17:906:8442:b0:73d:a2fc:a87 with SMTP id e2-20020a170906844200b0073da2fc0a87mr33341739ejy.625.1662324118546;
        Sun, 04 Sep 2022 13:41:58 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id gj10-20020a170907740a00b007304bdf18cfsm4059353ejc.136.2022.09.04.13.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:41:58 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 09/32] bpf: Rewrite kfunc argument handling
Date:   Sun,  4 Sep 2022 22:41:22 +0200
Message-Id: <20220904204145.3089-10-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20690; i=memxor@gmail.com; h=from:subject; bh=QzrlSPaf288UiAQ++p0VcbmYXGoSGZrzJMZqLjMRM7s=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1wdhxTuxmwVg9iMdJsJcv5mfuFiwQ4Cnrb8mIg 0l5Xo+CJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcAAKCRBM4MiGSL8Ryp6cD/ 46sWwwCiOfqCyQFAd5BOr+TRSUYYzopB1mIu14L5SBxNZYyfZseXR1gz6b1MX9k/IHXdowe8smZDnN 0kb0Njs1lPYnZIZdDWYqMmaZRt552BUcIBh2ft+uSbXzyXFlBA5y4s90uW5qv+gFBIuJ4UKt0sbrnI D3TwX8aH7vCVLgtsgjUujhhiVxjyox4DoG8fnNmL3nalkNIKw1IR1P6U9lyt+NOGzBvcnC1Gvl1yIP /KycHoXc3QjecnprpJ7nIJOYMV9ULaZDXPfgxnbOfnrlqfKgcnJ0BYwTwNiqnE9Pt/jk1TFe+0+WdD l5X5rSo9Uj/BgF3NrqGZfjcl89GDdaaf1L/fuGRHAB5YxEpv8yt11006BGHdX/BkrqI2XGk1xIzUo0 iu1Yr/A8ULt465Bo2CXrFoXXLXgQAfLZswpxsgf+/lEhqRUU/lzL2TiTw93WZa/C2IT86ocyFNtW2z OVm+AsfTpfVxe8FA5DG5BGrymTDQ73XcU1iG9Sbgb1E4b8PfdUmi0obI4cXS4HwiIefmSKxQaqu9e+ Bo4KwO4f7VnMOoaoHz/0wSO9ZKDbMj0FNpINpXw8HXohqove3WkLJlhQ2TYv5Mp8HfMeakrTK1KsNu LfBy65janiwkc2R5zCqIErLeG4+f0vdo5lViVVueUh9+BEZqsEpE9whwmt3Q==
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

As we continue to add more features, argument types, kfunc flags, and
different extensions to kfuncs, the code to verify the correctness of
the kfunc prototype wrt the passed in registers has become ad-hoc and
ugly to read.

To make life easier, and make a very clear split between different
stages of argument processing, move all the code into verifier.c and
refactor into easier to read helpers and functions.

This also makes sharing code within the verifier easier with kfunc
argument processing. This will be more and more useful in later patches
as we are now moving to implement very core BPF helpers as kfuncs, to
keep them experimental before baking into UAPI.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h                          |  22 +
 kernel/bpf/btf.c                             |  12 +-
 kernel/bpf/verifier.c                        | 426 ++++++++++++++++++-
 tools/testing/selftests/bpf/verifier/calls.c |   2 +-
 4 files changed, 438 insertions(+), 24 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index b3d47e9b9d5c..8062f9da7c40 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -314,6 +314,16 @@ static inline bool btf_type_is_struct(const struct btf_type *t)
 	return kind == BTF_KIND_STRUCT || kind == BTF_KIND_UNION;
 }
 
+static inline bool __btf_type_is_struct(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_STRUCT;
+}
+
+static inline bool btf_type_is_array(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_ARRAY;
+}
+
 static inline u16 btf_type_vlen(const struct btf_type *t)
 {
 	return BTF_INFO_VLEN(t->info);
@@ -400,6 +410,7 @@ static inline struct btf_param *btf_params(const struct btf_type *t)
 
 #ifdef CONFIG_BPF_SYSCALL
 struct bpf_prog;
+struct bpf_verifier_log;
 
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
 const char *btf_name_by_offset(const struct btf *btf, u32 offset);
@@ -413,6 +424,10 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
 				struct module *owner);
+const struct btf_member *
+btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
+		      const struct btf_type *t, enum bpf_prog_type prog_type,
+		      int arg);
 #else
 static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 						    u32 type_id)
@@ -444,6 +459,13 @@ static inline int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dt
 {
 	return 0;
 }
+static inline const struct btf_member *
+btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
+		      const struct btf_type *t, enum bpf_prog_type prog_type,
+		      int arg)
+{
+	return NULL;
+}
 #endif
 
 #endif
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5e860f76595c..0ad809a3055d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -477,16 +477,6 @@ static bool btf_type_nosize_or_null(const struct btf_type *t)
 	return !t || btf_type_nosize(t);
 }
 
-static bool __btf_type_is_struct(const struct btf_type *t)
-{
-	return BTF_INFO_KIND(t->info) == BTF_KIND_STRUCT;
-}
-
-static bool btf_type_is_array(const struct btf_type *t)
-{
-	return BTF_INFO_KIND(t->info) == BTF_KIND_ARRAY;
-}
-
 static bool btf_type_is_datasec(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_DATASEC;
@@ -5089,7 +5079,7 @@ static u8 bpf_ctx_convert_map[] = {
 #undef BPF_MAP_TYPE
 #undef BPF_LINK_TYPE
 
-static const struct btf_member *
+const struct btf_member *
 btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 		      const struct btf_type *t, enum bpf_prog_type prog_type,
 		      int arg)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0c19a98c748d..663c91020f82 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7578,6 +7578,401 @@ static void mark_btf_func_reg_size(struct bpf_verifier_env *env, u32 regno,
 	}
 }
 
+struct bpf_kfunc_arg_meta {
+	/* In parameters */
+	struct btf *btf;
+	u32 func_id;
+	u32 kfunc_flags;
+	const struct btf_type *func_proto;
+	const char *func_name;
+	/* Out parameters */
+	u32 ref_obj_id;
+	u8 release_regno;
+};
+
+static bool is_kfunc_acquire(struct bpf_kfunc_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_ACQUIRE;
+}
+
+static bool is_kfunc_ret_null(struct bpf_kfunc_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_RET_NULL;
+}
+
+static bool is_kfunc_release(struct bpf_kfunc_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_RELEASE;
+}
+
+static bool is_kfunc_trusted_args(struct bpf_kfunc_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_TRUSTED_ARGS;
+}
+
+static bool is_kfunc_sleepable(struct bpf_kfunc_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_SLEEPABLE;
+}
+
+static bool is_kfunc_destructive(struct bpf_kfunc_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_DESTRUCTIVE;
+}
+
+static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_arg_meta *meta, int arg)
+{
+	return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
+}
+
+static bool is_kfunc_arg_mem_size(const struct btf *btf,
+				  const struct btf_param *arg,
+				  const struct bpf_reg_state *reg)
+{
+	int len, sfx_len = sizeof("__sz") - 1;
+	const struct btf_type *t;
+	const char *param_name;
+
+	t = btf_type_skip_modifiers(btf, arg->type, NULL);
+	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
+		return false;
+
+	/* In the future, this can be ported to use BTF tagging */
+	param_name = btf_name_by_offset(btf, arg->name_off);
+	if (str_is_empty(param_name))
+		return false;
+	len = strlen(param_name);
+	if (len < sfx_len)
+		return false;
+	param_name += len - sfx_len;
+	if (strncmp(param_name, "__sz", sfx_len))
+		return false;
+
+	return true;
+}
+
+/* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
+static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
+					const struct btf *btf,
+					const struct btf_type *t, int rec)
+{
+	const struct btf_type *member_type;
+	const struct btf_member *member;
+	u32 i;
+
+	if (!btf_type_is_struct(t))
+		return false;
+
+	for_each_member(i, t, member) {
+		const struct btf_array *array;
+
+		member_type = btf_type_skip_modifiers(btf, member->type, NULL);
+		if (btf_type_is_struct(member_type)) {
+			if (rec >= 3) {
+				verbose(env, "max struct nesting depth exceeded\n");
+				return false;
+			}
+			if (!__btf_type_is_scalar_struct(env, btf, member_type, rec + 1))
+				return false;
+			continue;
+		}
+		if (btf_type_is_array(member_type)) {
+			array = btf_array(member_type);
+			if (!array->nelems)
+				return false;
+			member_type = btf_type_skip_modifiers(btf, array->type, NULL);
+			if (!btf_type_is_scalar(member_type))
+				return false;
+			continue;
+		}
+		if (!btf_type_is_scalar(member_type))
+			return false;
+	}
+	return true;
+}
+
+
+static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
+#ifdef CONFIG_NET
+	[PTR_TO_SOCKET] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
+	[PTR_TO_SOCK_COMMON] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
+	[PTR_TO_TCP_SOCK] = &btf_sock_ids[BTF_SOCK_TYPE_TCP],
+#endif
+};
+
+enum kfunc_ptr_arg_types {
+	KF_ARG_PTR_TO_CTX,
+	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
+	KF_ARG_PTR_TO_KPTR_STRONG,   /* PTR_TO_KPTR but type specific */
+	KF_ARG_PTR_TO_MEM,
+	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip it */
+};
+
+enum kfunc_ptr_arg_types get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
+						struct bpf_kfunc_arg_meta *meta,
+						const struct btf_type *t,
+						const struct btf_type *ref_t,
+						const char *ref_tname,
+						const struct btf_param *args,
+						int argno, int nargs)
+{
+	struct bpf_reg_state *regs = cur_regs(env);
+	bool arg_mem_size = false;
+	u32 regno = argno + 1;
+	struct bpf_reg_state *reg = &regs[regno];
+
+	/* In this function, we verify the kfunc's BTF as per the argument type,
+	 * leaving the rest of the verification with respect to the register
+	 * type to our caller. When a set of conditions hold in the BTF type of
+	 * arguments, we resolve it to a known kfunc_ptr_arg_types enum
+	 * constant.
+	 */
+	if (is_kfunc_arg_kptr_get(meta, argno)) {
+		if (!btf_type_is_ptr(ref_t)) {
+			verbose(env, "arg#0 BTF type must be a double pointer for kptr_get kfunc\n");
+			return -EINVAL;
+		}
+		ref_t = btf_type_by_id(meta->btf, ref_t->type);
+		ref_tname = btf_name_by_offset(meta->btf, ref_t->name_off);
+		if (!btf_type_is_struct(ref_t)) {
+			verbose(env, "kernel function %s args#0 pointer type %s %s is not supported\n",
+				meta->func_name, btf_type_str(ref_t), ref_tname);
+			return -EINVAL;
+		}
+		return KF_ARG_PTR_TO_KPTR_STRONG;
+	}
+
+	if (btf_get_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
+		return KF_ARG_PTR_TO_CTX;
+
+	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
+		if (!btf_type_is_struct(ref_t)) {
+			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
+				meta->func_name, argno, btf_type_str(ref_t), ref_tname);
+			return -EINVAL;
+		}
+		return KF_ARG_PTR_TO_BTF_ID;
+	}
+
+	if (argno + 1 < nargs && is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]))
+		arg_mem_size = true;
+
+	/* Permit pointer to mem, but only when argument
+	 * type is pointer to scalar, or struct composed
+	 * (recursively) of scalars.
+	 * When arg_mem_size is true, the pointer can be
+	 * void *.
+	 */
+	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0) &&
+	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
+		verbose(env, "arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
+			argno, btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
+		return -EINVAL;
+	}
+	return arg_mem_size ? KF_ARG_PTR_TO_MEM_SIZE : KF_ARG_PTR_TO_MEM;
+}
+
+static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
+					struct bpf_reg_state *reg,
+					const struct btf_type *ref_t,
+					const char *ref_tname, u32 ref_id,
+					struct bpf_kfunc_arg_meta *meta,
+					int argno)
+{
+	const struct btf_type *reg_ref_t;
+	bool strict_type_match = false;
+	const struct btf *reg_btf;
+	const char *reg_ref_tname;
+	u32 reg_ref_id;
+
+	if (reg->type == PTR_TO_BTF_ID) {
+		reg_btf = reg->btf;
+		reg_ref_id = reg->btf_id;
+	} else {
+		reg_btf = btf_vmlinux;
+		reg_ref_id = *reg2btf_ids[base_type(reg->type)];
+	}
+
+	if (is_kfunc_trusted_args(meta) || (is_kfunc_release(meta) && reg->ref_obj_id))
+		strict_type_match = true;
+
+	reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_ref_id);
+	reg_ref_tname = btf_name_by_offset(reg_btf, reg_ref_t->name_off);
+	if (!btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->off, meta->btf, ref_id, strict_type_match)) {
+		verbose(env, "kernel function %s args#%d expected pointer to %s %s but R%d has a pointer to %s %s\n",
+			meta->func_name, argno, btf_type_str(ref_t), ref_tname, argno + 1,
+			btf_type_str(reg_ref_t), reg_ref_tname);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
+					     struct bpf_reg_state *reg,
+					     const struct btf_type *ref_t,
+					     const char *ref_tname,
+					     struct bpf_kfunc_arg_meta *meta,
+					     int argno)
+{
+	struct bpf_map_value_off_desc *off_desc;
+
+	/* check_func_arg_reg_off allows var_off for
+	 * PTR_TO_MAP_VALUE, but we need fixed offset to find
+	 * off_desc.
+	 */
+	if (!tnum_is_const(reg->var_off)) {
+		verbose(env, "arg#0 must have constant offset\n");
+		return -EINVAL;
+	}
+
+	off_desc = bpf_map_kptr_off_contains(reg->map_ptr, reg->off + reg->var_off.value);
+	if (!off_desc || off_desc->type != BPF_KPTR_REF) {
+		verbose(env, "arg#0 no referenced kptr at map value offset=%llu\n",
+			reg->off + reg->var_off.value);
+		return -EINVAL;
+	}
+
+	if (!btf_struct_ids_match(&env->log, meta->btf, ref_t->type, 0, off_desc->kptr.btf,
+				  off_desc->kptr.btf_id, true)) {
+		verbose(env, "kernel function %s args#%d expected pointer to %s %s\n",
+			meta->func_name, argno, btf_type_str(ref_t), ref_tname);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_arg_meta *meta)
+{
+	const char *func_name = meta->func_name, *ref_tname;
+	const struct btf *btf = meta->btf;
+	const struct btf_param *args;
+	u32 i, nargs;
+	int ret;
+
+	args = (const struct btf_param *)(meta->func_proto + 1);
+	nargs = btf_type_vlen(meta->func_proto);
+	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
+		verbose(env, "Function %s has %d > %d args\n", func_name, nargs,
+			MAX_BPF_FUNC_REG_ARGS);
+		return -EINVAL;
+	}
+
+	if (is_kfunc_sleepable(meta) && !env->prog->aux->sleepable) {
+		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
+		return -EINVAL;
+	}
+
+	/* Check that BTF function arguments match actual types that the
+	 * verifier sees.
+	 */
+	for (i = 0; i < nargs; i++) {
+		struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[i + 1];
+		const struct btf_type *t, *ref_t, *resolve_ret;
+		enum bpf_arg_type arg_type = ARG_DONTCARE;
+		u32 regno = i + 1, ref_id, type_size;
+
+		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
+		if (btf_type_is_scalar(t)) {
+			if (reg->type == SCALAR_VALUE)
+				continue;
+			verbose(env, "R%d is not a scalar\n", regno);
+			return -EINVAL;
+		}
+
+		if (!btf_type_is_ptr(t)) {
+			verbose(env, "Unrecognized arg#%d type %s\n", i, btf_type_str(t));
+			return -EINVAL;
+		}
+
+		/* Check if argument must be a referenced pointer, args + i has
+		 * been verified to be a pointer (after skipping modifiers).
+		 */
+		if (is_kfunc_trusted_args(meta) && !reg->ref_obj_id) {
+			verbose(env, "R%d must be referenced\n", regno);
+			return -EINVAL;
+		}
+
+		if (reg->ref_obj_id) {
+			if (is_kfunc_release(meta) && meta->ref_obj_id) {
+				verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
+					regno, reg->ref_obj_id,
+					meta->ref_obj_id);
+				return -EFAULT;
+			}
+			meta->ref_obj_id = reg->ref_obj_id;
+			if (is_kfunc_release(meta))
+				meta->release_regno = regno;
+		}
+
+		/* Trusted args have the same offset checks as release arguments */
+		if (is_kfunc_trusted_args(meta) || (is_kfunc_release(meta) && reg->ref_obj_id))
+			arg_type |= OBJ_RELEASE;
+		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
+		if (ret < 0)
+			return ret;
+
+		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
+		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+
+		switch (get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname, args, i, nargs)) {
+		case KF_ARG_PTR_TO_CTX:
+			if (reg->type != PTR_TO_CTX) {
+				verbose(env, "arg#%d expected pointer to ctx, but got %s\n", i, btf_type_str(t));
+				return -EINVAL;
+			}
+			break;
+		case KF_ARG_PTR_TO_BTF_ID:
+			/* Only base_type is checked, further checks are done here */
+			if (reg->type != PTR_TO_BTF_ID &&
+			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
+				verbose(env, "arg#%d expected pointer to btf or socket\n", i);
+				return -EINVAL;
+			}
+			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
+			if (ret < 0)
+				return ret;
+			break;
+		case KF_ARG_PTR_TO_KPTR_STRONG:
+			if (reg->type != PTR_TO_MAP_VALUE) {
+				verbose(env, "arg#0 expected pointer to map value\n");
+				return -EINVAL;
+			}
+			ret = process_kf_arg_ptr_to_kptr_strong(env, reg, ref_t, ref_tname, meta, i);
+			if (ret < 0)
+				return ret;
+			break;
+		case KF_ARG_PTR_TO_MEM:
+			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
+			if (IS_ERR(resolve_ret)) {
+				verbose(env, "arg#%d reference type('%s %s') size cannot be determined: %ld\n",
+					i, btf_type_str(ref_t), ref_tname, PTR_ERR(resolve_ret));
+				return -EINVAL;
+			}
+			ret = check_mem_reg(env, reg, regno, type_size);
+			if (ret < 0)
+				return ret;
+			break;
+		case KF_ARG_PTR_TO_MEM_SIZE:
+			ret = check_kfunc_mem_size_reg(env, &regs[regno + 1], regno + 1);
+			if (ret < 0) {
+				verbose(env, "arg#%d arg#%d memory, len pair leads to invalid memory access\n", i, i + 1);
+				return ret;
+			}
+			/* Skip next '__sz' argument */
+			i++;
+			break;
+		}
+	}
+
+	if (is_kfunc_release(meta) && !meta->release_regno) {
+		verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
+			func_name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
@@ -7586,10 +7981,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	const char *func_name, *ptr_type_name;
 	u32 i, nargs, func_id, ptr_type_id;
 	int err, insn_idx = *insn_idx_p;
+	struct bpf_kfunc_arg_meta meta;
 	const struct btf_param *args;
 	struct btf *desc_btf;
 	u32 *kfunc_flags;
-	bool acq;
 
 	/* skip for now, but return error when we find this in fixup_kfunc_call */
 	if (!insn->imm)
@@ -7610,22 +8005,29 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			func_name);
 		return -EACCES;
 	}
-	if (*kfunc_flags & KF_DESTRUCTIVE && !capable(CAP_SYS_BOOT)) {
-		verbose(env, "destructive kfunc calls require CAP_SYS_BOOT capabilities\n");
+
+	/* Prepare kfunc call metadata */
+	memset(&meta, 0, sizeof(meta));
+	meta.btf = desc_btf;
+	meta.func_id = func_id;
+	meta.kfunc_flags = *kfunc_flags;
+	meta.func_proto = func_proto;
+	meta.func_name = func_name;
+
+	if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
+		verbose(env, "destructive kfunc calls require CAP_SYS_BOOT capability\n");
 		return -EACCES;
 	}
 
-	acq = *kfunc_flags & KF_ACQUIRE;
-
 	/* Check the arguments */
-	err = btf_check_kfunc_arg_match(env, desc_btf, func_id, regs, *kfunc_flags);
+	err = check_kfunc_args(env, &meta);
 	if (err < 0)
 		return err;
 	/* In case of release function, we get register number of refcounted
-	 * PTR_TO_BTF_ID back from btf_check_kfunc_arg_match, do the release now
+	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
-	if (err) {
-		err = release_reference(env, regs[err].ref_obj_id);
+	if (meta.release_regno) {
+		err = release_reference(env, regs[meta.release_regno].ref_obj_id);
 		if (err) {
 			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
 				func_name, func_id);
@@ -7639,7 +8041,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	/* Check return type */
 	t = btf_type_skip_modifiers(desc_btf, func_proto->type, NULL);
 
-	if (acq && !btf_type_is_ptr(t)) {
+	if (is_kfunc_acquire(&meta) && !btf_type_is_ptr(t)) {
 		verbose(env, "acquire kernel function does not return PTR_TO_BTF_ID\n");
 		return -EINVAL;
 	}
@@ -7662,13 +8064,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		regs[BPF_REG_0].btf = desc_btf;
 		regs[BPF_REG_0].type = PTR_TO_BTF_ID;
 		regs[BPF_REG_0].btf_id = ptr_type_id;
-		if (*kfunc_flags & KF_RET_NULL) {
+		if (is_kfunc_ret_null(&meta)) {
 			regs[BPF_REG_0].type |= PTR_MAYBE_NULL;
 			/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
 		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
-		if (acq) {
+		if (is_kfunc_acquire(&meta)) {
 			int id = acquire_reference_state(env, insn_idx);
 
 			if (id < 0)
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 3fb4f69b1962..4604d0b1fb04 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -109,7 +109,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "arg#0 pointer type STRUCT prog_test_ref_kfunc must point",
+	.errstr = "arg#0 expected pointer to btf or socket",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_test_acquire", 3 },
 		{ "bpf_kfunc_call_test_release", 5 },
-- 
2.34.1

