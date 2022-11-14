Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72E4628916
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiKNTQ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiKNTQg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:16:36 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3888E26559
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:34 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id 4so11000881pli.0
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b9M0ntE1BJ/xQLOmPampTkRhvEiEUSMkpBcqYJ1fqU=;
        b=E6MVc6DqRvUMMiyPjtpNjCSpo9LuJ+qi/9OAXjjoGmGYUD/5JMsdVdz3h1tPQT0auZ
         3Yaq7JWLJ0hpUFi5kvPdQDlLn4LBt2IsID79fGsDM1NYMsnYe1bOnn8dlFkbZaMGDoJ6
         i+uQpI09zn9wRGmN6ocsABQtoG5sVwdb44ey1b3z5AIKIpniy9E7DlCfuDOv35Uvfc4J
         C5AO9PyQlbdmDSFA6QgfDR3WV9E88e/I7WrCMkX8lDCfJn952RGktcJAICrUlUjeKICV
         NKI68rJA1BsRfhrseEzB78Zy8r55BNqzCY+eexDYGCAqu2Kcer3xK44colm63fNcQTBB
         s04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+b9M0ntE1BJ/xQLOmPampTkRhvEiEUSMkpBcqYJ1fqU=;
        b=0lfAKPx5hISZXzIk6PeyEMkBoPlr+nbG9DznNA+mprUYdsrn4Gl+O2BF4mcWwYwv+v
         en3h+VqKzxYrZV4x/a6gIdq+sygC+z/cBBvOZcuZHxQkN0HFTEScH+wDGoDMzcSBEo4H
         EhvzaLZ1UhNf8JI86rpRke7q7H4uCsSdncqHLQ5pHZZB7lskzpITf3WqMEcb7YaAige9
         db5HrqFNZ1QwK+ZrLOfSkD7uhMv4REia2Q1GO2mk0NScgAFgi3dMEd0YTrFfQj5ev00p
         ZjJrozqyU29qR24cLvnJ/osyySgqDGfi5Pj8mmYdbp3AqFAaEL8p08fvc/A31v1vw0Ii
         86lA==
X-Gm-Message-State: ANoB5pnVYgmBqN0+zAMFzT7fbAI3F1wiV8AUS+CPbcSv8yFO+BtZWAqu
        TRfEseFjFX4hhMX8woTs7PpcEMgCX24ftQ==
X-Google-Smtp-Source: AA0mqf5Y1xh9OsOr2urBorWjaTz10qjZU3DdtgxrrNequYt+9LN9Fv1tCIcfRqbs6aMyUl+rtFUaPA==
X-Received: by 2002:a17:902:6a8c:b0:188:b840:deec with SMTP id n12-20020a1709026a8c00b00188b840deecmr739829plk.15.1668453393421;
        Mon, 14 Nov 2022 11:16:33 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id 69-20020a17090a09cb00b00212d4c50647sm10118843pjo.36.2022.11.14.11.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:16:33 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 14/26] bpf: Rewrite kfunc argument handling
Date:   Tue, 15 Nov 2022 00:45:35 +0530
Message-Id: <20221114191547.1694267-15-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=27126; i=memxor@gmail.com; h=from:subject; bh=QHXbbMbvHOvIvJKU6M9E2CKFGLuy7gTYKmwEuLz6jME=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPJ07lMBh6ZtclYbiFacC3QHZ1RPsuPDMeXWxr0 g6XANVGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTyQAKCRBM4MiGSL8Ryv3gD/ 9to2Itw5XDpEGi/KdaRSTYMDeFsQzDh6gQLeNCLuDL/jzTckFlhGHpSl+g06YKijKMMWxdC6wyO+1N 7ItRf8k+/gXpxnr+pRFeqhMvFj2kzG2THqo9cAJeP4plKWv2t0fu+IRCzAjL5uVTqwqpY7rlAyr98n kAF602W6Y5u6aOoln2lY2oBNERwsoflBfAnhUojgGO3c/Vn/MG9cI+KHqG/wb33T9EH+Efhg5IYwLg nfPXi0fqXZc5tU4oLLXy8sRTzJQ2i8pJQpwCuvgqwmGhjWmh/yaHprjkSTqu1im6PsNHgv+7ZthDA7 bAA7mN3qLnRYNMfk6XUBBKE3qLNmGE0Z43YHcXrKluxdl/x3Oa4ANSQ+cqQV5lhPmaKyXY4l0Cfq3U 4VAYOFozfeHbt3mT20HdE2R5FW0dr8M4JFL410Uuttqr38dsZ4rMqLWANxbInLcAbWuwQ0hIsH5fAS xaDIAxdD/5IImj0j3FAVWdZJfiosqsxfs6ISeZZeW9oUSA2uKIpbV30QVN8B/IcIYTbTJ5zlUOBAKJ K9jPssXib8rOEZMXJAEx6Pn+iMBsmnjfg25fGCGaO+SHunEkvXUij/AIT3fCuSICmzi+EWGzNejoHU 9UbV/hG/um+OCrXXYKapMsmVrhPTsHKIA1f2gpAJ3u6KWO2P7J5AUHDqngyg==
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

As we continue to add more features, argument types, kfunc flags, and
different extensions to kfuncs, the code to verify the correctness of
the kfunc prototype wrt the passed in registers has become ad-hoc and
ugly to read. To make life easier, and make a very clear split between
different stages of argument processing, move all the code into
verifier.c and refactor into easier to read helpers and functions.

This also makes sharing code within the verifier easier with kfunc
argument processing. This will be more and more useful in later patches
as we are now moving to implement very core BPF helpers as kfuncs, to
keep them experimental before baking into UAPI.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h                           |  31 +-
 kernel/bpf/btf.c                              |  16 +-
 kernel/bpf/verifier.c                         | 547 +++++++++++++++++-
 .../bpf/prog_tests/kfunc_dynptr_param.c       |   2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   2 +-
 .../selftests/bpf/verifier/ref_tracking.c     |   4 +-
 6 files changed, 569 insertions(+), 33 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 42d8f3730a8d..d5b26380a60f 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -338,6 +338,16 @@ static inline bool btf_type_is_struct(const struct btf_type *t)
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
@@ -439,9 +449,10 @@ static inline void *btf_id_set8_contains(const struct btf_id_set8 *set, u32 id)
 	return bsearch(&id, set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func);
 }
 
-#ifdef CONFIG_BPF_SYSCALL
 struct bpf_prog;
+struct bpf_verifier_log;
 
+#ifdef CONFIG_BPF_SYSCALL
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
 const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
@@ -455,6 +466,12 @@ s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
 				struct module *owner);
 struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id);
+const struct btf_member *
+btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
+		      const struct btf_type *t, enum bpf_prog_type prog_type,
+		      int arg);
+bool btf_types_are_same(const struct btf *btf1, u32 id1,
+			const struct btf *btf2, u32 id2);
 #else
 static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 						    u32 type_id)
@@ -490,6 +507,18 @@ static inline struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf
 {
 	return NULL;
 }
+static inline const struct btf_member *
+btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
+		      const struct btf_type *t, enum bpf_prog_type prog_type,
+		      int arg)
+{
+	return NULL;
+}
+static inline bool btf_types_are_same(const struct btf *btf1, u32 id1,
+				      const struct btf *btf2, u32 id2)
+{
+	return false;
+}
 #endif
 
 static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 10644343d877..ff8b46c209dd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -478,16 +478,6 @@ static bool btf_type_nosize_or_null(const struct btf_type *t)
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
@@ -5537,7 +5527,7 @@ static u8 bpf_ctx_convert_map[] = {
 #undef BPF_MAP_TYPE
 #undef BPF_LINK_TYPE
 
-static const struct btf_member *
+const struct btf_member *
 btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 		      const struct btf_type *t, enum bpf_prog_type prog_type,
 		      int arg)
@@ -6323,8 +6313,8 @@ int btf_struct_access(struct bpf_verifier_log *log,
  * end up with two different module BTFs, but IDs point to the common type in
  * vmlinux BTF.
  */
-static bool btf_types_are_same(const struct btf *btf1, u32 id1,
-			       const struct btf *btf2, u32 id2)
+bool btf_types_are_same(const struct btf *btf1, u32 id1,
+			const struct btf *btf2, u32 id2)
 {
 	if (id1 != id2)
 		return false;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 99b5edb56978..ddb7ac1cb529 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7859,19 +7859,523 @@ static void mark_btf_func_reg_size(struct bpf_verifier_env *env, u32 regno,
 	}
 }
 
+struct bpf_kfunc_call_arg_meta {
+	/* In parameters */
+	struct btf *btf;
+	u32 func_id;
+	u32 kfunc_flags;
+	const struct btf_type *func_proto;
+	const char *func_name;
+	/* Out parameters */
+	u32 ref_obj_id;
+	u8 release_regno;
+	bool r0_rdonly;
+	u64 r0_size;
+};
+
+static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_ACQUIRE;
+}
+
+static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_RET_NULL;
+}
+
+static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_RELEASE;
+}
+
+static bool is_kfunc_trusted_args(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_TRUSTED_ARGS;
+}
+
+static bool is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_SLEEPABLE;
+}
+
+static bool is_kfunc_destructive(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_DESTRUCTIVE;
+}
+
+static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
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
+static bool is_kfunc_arg_ret_buf_size(const struct btf *btf,
+				      const struct btf_param *arg,
+				      const struct bpf_reg_state *reg,
+				      const char *name)
+{
+	int len, target_len = strlen(name);
+	const struct btf_type *t;
+	const char *param_name;
+
+	t = btf_type_skip_modifiers(btf, arg->type, NULL);
+	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
+		return false;
+
+	param_name = btf_name_by_offset(btf, arg->name_off);
+	if (str_is_empty(param_name))
+		return false;
+	len = strlen(param_name);
+	if (len != target_len)
+		return false;
+	if (strcmp(param_name, name))
+		return false;
+
+	return true;
+}
+
+enum {
+	KF_ARG_DYNPTR_ID,
+};
+
+BTF_ID_LIST(kf_arg_btf_ids)
+BTF_ID(struct, bpf_dynptr_kern)
+
+static bool is_kfunc_arg_dynptr(const struct btf *btf,
+				const struct btf_param *arg)
+{
+	const struct btf_type *t;
+	u32 res_id;
+
+	t = btf_type_skip_modifiers(btf, arg->type, NULL);
+	if (!t)
+		return false;
+	if (!btf_type_is_ptr(t))
+		return false;
+	t = btf_type_skip_modifiers(btf, t->type, &res_id);
+	if (!t)
+		return false;
+	return btf_types_are_same(btf, res_id, btf_vmlinux, kf_arg_btf_ids[KF_ARG_DYNPTR_ID]);
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
+enum kfunc_ptr_arg_type {
+	KF_ARG_PTR_TO_CTX,
+	KF_ARG_PTR_TO_KPTR_STRONG,   /* PTR_TO_KPTR but type specific */
+	KF_ARG_PTR_TO_DYNPTR,
+	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
+	KF_ARG_PTR_TO_MEM,
+	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip it */
+};
+
+static enum kfunc_ptr_arg_type
+get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
+		       struct bpf_kfunc_call_arg_meta *meta,
+		       const struct btf_type *t, const struct btf_type *ref_t,
+		       const char *ref_tname, const struct btf_param *args,
+		       int argno, int nargs)
+{
+	u32 regno = argno + 1;
+	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_reg_state *reg = &regs[regno];
+	bool arg_mem_size = false;
+
+	/* In this function, we verify the kfunc's BTF as per the argument type,
+	 * leaving the rest of the verification with respect to the register
+	 * type to our caller. When a set of conditions hold in the BTF type of
+	 * arguments, we resolve it to a known kfunc_ptr_arg_type.
+	 */
+	if (btf_get_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
+		return KF_ARG_PTR_TO_CTX;
+
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
+	if (is_kfunc_arg_dynptr(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_DYNPTR;
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
+	/* This is the catch all argument type of register types supported by
+	 * check_helper_mem_access. However, we only allow when argument type is
+	 * pointer to scalar, or struct composed (recursively) of scalars. When
+	 * arg_mem_size is true, the pointer can be void *.
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
+					struct bpf_kfunc_call_arg_meta *meta,
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
+					     struct bpf_kfunc_call_arg_meta *meta,
+					     int argno)
+{
+	struct btf_field *kptr_field;
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
+	kptr_field = btf_record_find(reg->map_ptr->record, reg->off + reg->var_off.value, BPF_KPTR);
+	if (!kptr_field || kptr_field->type != BPF_KPTR_REF) {
+		verbose(env, "arg#0 no referenced kptr at map value offset=%llu\n",
+			reg->off + reg->var_off.value);
+		return -EINVAL;
+	}
+
+	if (!btf_struct_ids_match(&env->log, meta->btf, ref_t->type, 0, kptr_field->kptr.btf,
+				  kptr_field->kptr.btf_id, true)) {
+		verbose(env, "kernel function %s args#%d expected pointer to %s %s\n",
+			meta->func_name, argno, btf_type_str(ref_t), ref_tname);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
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
+	/* Check that BTF function arguments match actual types that the
+	 * verifier sees.
+	 */
+	for (i = 0; i < nargs; i++) {
+		struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[i + 1];
+		const struct btf_type *t, *ref_t, *resolve_ret;
+		enum bpf_arg_type arg_type = ARG_DONTCARE;
+		u32 regno = i + 1, ref_id, type_size;
+		bool is_ret_buf_sz = false;
+		int kf_arg_type;
+
+		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
+		if (btf_type_is_scalar(t)) {
+			if (reg->type != SCALAR_VALUE) {
+				verbose(env, "R%d is not a scalar\n", regno);
+				return -EINVAL;
+			}
+			if (is_kfunc_arg_ret_buf_size(btf, &args[i], reg, "rdonly_buf_size")) {
+					meta->r0_rdonly = true;
+					is_ret_buf_sz = true;
+			} else if (is_kfunc_arg_ret_buf_size(btf, &args[i], reg, "rdwr_buf_size")) {
+					is_ret_buf_sz = true;
+			}
+
+			if (is_ret_buf_sz) {
+				if (meta->r0_size) {
+					verbose(env, "2 or more rdonly/rdwr_buf_size parameters for kfunc");
+					return -EINVAL;
+				}
+
+				if (!tnum_is_const(reg->var_off)) {
+					verbose(env, "R%d is not a const\n", regno);
+					return -EINVAL;
+				}
+
+				meta->r0_size = reg->var_off.value;
+				ret = mark_chain_precision(env, regno);
+				if (ret)
+					return ret;
+			}
+			continue;
+		}
+
+		if (!btf_type_is_ptr(t)) {
+			verbose(env, "Unrecognized arg#%d type %s\n", i, btf_type_str(t));
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
+		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
+		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+
+		kf_arg_type = get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname, args, i, nargs);
+		if (kf_arg_type < 0)
+			return kf_arg_type;
+
+		switch (kf_arg_type) {
+		case KF_ARG_PTR_TO_BTF_ID:
+			if (!is_kfunc_trusted_args(meta))
+				break;
+			if (!reg->ref_obj_id) {
+				verbose(env, "R%d must be referenced\n", regno);
+				return -EINVAL;
+			}
+			fallthrough;
+		case KF_ARG_PTR_TO_CTX:
+			/* Trusted arguments have the same offset checks as release arguments */
+			arg_type |= OBJ_RELEASE;
+			break;
+		case KF_ARG_PTR_TO_KPTR_STRONG:
+		case KF_ARG_PTR_TO_DYNPTR:
+		case KF_ARG_PTR_TO_MEM:
+		case KF_ARG_PTR_TO_MEM_SIZE:
+			/* Trusted by default */
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			return -EFAULT;
+		}
+
+		if (is_kfunc_release(meta) && reg->ref_obj_id)
+			arg_type |= OBJ_RELEASE;
+		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
+		if (ret < 0)
+			return ret;
+
+		switch (kf_arg_type) {
+		case KF_ARG_PTR_TO_CTX:
+			if (reg->type != PTR_TO_CTX) {
+				verbose(env, "arg#%d expected pointer to ctx, but got %s\n", i, btf_type_str(t));
+				return -EINVAL;
+			}
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
+		case KF_ARG_PTR_TO_DYNPTR:
+			if (reg->type != PTR_TO_STACK) {
+				verbose(env, "arg#%d expected pointer to stack\n", i);
+				return -EINVAL;
+			}
+
+			if (!is_dynptr_reg_valid_init(env, reg)) {
+				verbose(env, "arg#%d pointer type %s %s must be valid and initialized\n",
+					i, btf_type_str(ref_t), ref_tname);
+				return -EINVAL;
+			}
+
+			if (!is_dynptr_type_expected(env, reg, ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL)) {
+				verbose(env, "arg#%d pointer type %s %s points to unsupported dynamic pointer type\n",
+					i, btf_type_str(ref_t), ref_tname);
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
 	const struct btf_type *t, *func, *func_proto, *ptr_type;
 	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_kfunc_arg_meta meta = { 0 };
 	const char *func_name, *ptr_type_name;
+	struct bpf_kfunc_call_arg_meta meta;
 	u32 i, nargs, func_id, ptr_type_id;
 	int err, insn_idx = *insn_idx_p;
 	const struct btf_param *args;
 	struct btf *desc_btf;
 	u32 *kfunc_flags;
-	bool acq;
 
 	/* skip for now, but return error when we find this in fixup_kfunc_call */
 	if (!insn->imm)
@@ -7892,24 +8396,34 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
-	meta.flags = *kfunc_flags;
+	if (is_kfunc_sleepable(&meta) && !env->prog->aux->sleepable) {
+		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
+		return -EACCES;
+	}
 
 	/* Check the arguments */
-	err = btf_check_kfunc_arg_match(env, desc_btf, func_id, regs, &meta);
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
@@ -7923,7 +8437,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	/* Check return type */
 	t = btf_type_skip_modifiers(desc_btf, func_proto->type, NULL);
 
-	if (acq && !btf_type_is_struct_ptr(desc_btf, t)) {
+	if (is_kfunc_acquire(&meta) && !btf_type_is_struct_ptr(meta.btf, t)) {
 		verbose(env, "acquire kernel function does not return PTR_TO_BTF_ID\n");
 		return -EINVAL;
 	}
@@ -7962,20 +8476,23 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].type = PTR_TO_BTF_ID;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
 		}
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
 				return id;
-			regs[BPF_REG_0].id = id;
+			if (is_kfunc_ret_null(&meta))
+				regs[BPF_REG_0].id = id;
 			regs[BPF_REG_0].ref_obj_id = id;
 		}
+		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].id)
+			regs[BPF_REG_0].id = ++env->id_gen;
 	} /* else { add_kfunc_call() ensures it is btf_type_is_void(t) } */
 
 	nargs = btf_type_vlen(func_proto);
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
index c210657d4d0a..55d641c1f126 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
@@ -22,7 +22,7 @@ static struct {
 	 "arg#0 pointer type STRUCT bpf_dynptr_kern points to unsupported dynamic pointer type", 0},
 	{"not_valid_dynptr",
 	 "arg#0 pointer type STRUCT bpf_dynptr_kern must be valid and initialized", 0},
-	{"not_ptr_to_stack", "arg#0 pointer type STRUCT bpf_dynptr_kern not to stack", 0},
+	{"not_ptr_to_stack", "arg#0 expected pointer to stack", 0},
 	{"dynptr_data_null", NULL, -EBADMSG},
 };
 
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index e1a937277b54..86d6fef2e3b4 100644
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
diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
index fd683a32a276..55cba01c99d5 100644
--- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
+++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
@@ -142,7 +142,7 @@
 	.kfunc = "bpf",
 	.expected_attach_type = BPF_LSM_MAC,
 	.flags = BPF_F_SLEEPABLE,
-	.errstr = "arg#0 pointer type STRUCT bpf_key must point to scalar, or struct with scalar",
+	.errstr = "arg#0 expected pointer to btf or socket",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_lookup_user_key", 2 },
 		{ "bpf_key_put", 4 },
@@ -163,7 +163,7 @@
 	.kfunc = "bpf",
 	.expected_attach_type = BPF_LSM_MAC,
 	.flags = BPF_F_SLEEPABLE,
-	.errstr = "arg#0 pointer type STRUCT bpf_key must point to scalar, or struct with scalar",
+	.errstr = "arg#0 expected pointer to btf or socket",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_lookup_system_key", 1 },
 		{ "bpf_key_put", 3 },
-- 
2.38.1

