Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E4E5FD4BC
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJMGYX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiJMGYU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:24:20 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3965123473
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:17 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m6so1130844pfb.0
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7ThlXRQYQeC8GUBPAbWKJqnAt2+pcDZSIz0XqHoMw0=;
        b=eTEnTf69UHJKJAxjB8sBmw4m46PSaiCKo4K+vY4K56PG4FLfRugdiB0Bn9zIQGb4qo
         InZmtLuLaSq/uxWHdRRVE0eYXFyqD1DQdJ928He/SYBnEWFNXxLfBfp5xZBbT/kRD77l
         Ey4ZmbZpYQBFcDRoekThYmlppg/DIS+Zfz/5tDMgVJmzSM+F+kjPUTGFVPcenP1wz9u0
         yS7+eIOP0T3FAYy71fCrghnXwDOgSzzfYzo2QpKDDvvfnPVf53iiii6pDjyluhY3+Bqp
         aGB1YSeYm+66S8di0iUzbvg79eFIFPRzLwwFV5p8oT2ofXsUSHRMI9kVJ29DlXyOqmJ/
         J6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7ThlXRQYQeC8GUBPAbWKJqnAt2+pcDZSIz0XqHoMw0=;
        b=vdBC1/5vk84CgPVlbs6vJcsDR0E9AU6e4H0uU8IvzOHfhUv6xhWNtUFgAYCAvty5aM
         Bbaum4mzIA3Aw5ob33rxGKJrxGo1F4wbztT6+A0X/GiS48vv8E/ipvwBMZ+hb5nXzRZZ
         jjha/Ma2ySEh6rMHP+367KHUxui7AFjNgrvE56yk7udxLzaC7IcInedrSLaKbCP8unic
         eck+bCxVMyuIecZ4s7rg4mAEPGiuHDDYJWRBF4x/yHokHOgCzZ9hDpQ0/3Mu+hWx0cCr
         u3BmaAo6ZOvxRidMg77bTSjBO7PCbQkTCVoku5CVl3PPjmKqPKVdbx4WmYpS/+LlKcWo
         2HWw==
X-Gm-Message-State: ACrzQf1jL6LlQCFytoOCwW1EWozpxqFxQO5g13YT5X7VgotNhl0dATBE
        Clpy5nGu/JI8aszoXPqf1LeMk5cLeKE=
X-Google-Smtp-Source: AMsMyM7pJyhWNxwhgiC0spGBsyQnb6NBvjDgYsc4wZqu0rPUiIBAIk1FP/HEYgZtCBnkLzvIk5GFyg==
X-Received: by 2002:a63:3104:0:b0:459:a367:95ad with SMTP id x4-20020a633104000000b00459a36795admr29624934pgx.112.1665642256794;
        Wed, 12 Oct 2022 23:24:16 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id a198-20020a621acf000000b00545f5046372sm954932pfa.208.2022.10.12.23.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:24:16 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 16/25] bpf: Drop kfunc bits from btf_check_func_arg_match
Date:   Thu, 13 Oct 2022 11:52:54 +0530
Message-Id: <20221013062303.896469-17-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18726; i=memxor@gmail.com; h=from:subject; bh=QdORMICv09YFc2jeiBWRLF0xaBV3/1eg4kN94DrWLeE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67EBx/r64/rZbA9Yi4rC0HzsJeoCX8bnXqTa51g KtVaCluJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euxAAKCRBM4MiGSL8RygAEEA C2yYITXyqaUrqWe7B2Y0Z4ywwgzYAS6hz9yk6xvH6nTKrL5FFB3EONlm9xN8hnWQ9+guubydd6DErM 5x3joNB/wI1V8U1Ba5sYp9La4AuPfKEaslKq+gDhglpLqxGc+YueNfa5lyNhr4CXtCZMwoYzVZ+d/g PYt7LmpNIox3xyvzIOJoxsHaegHY4OFbrmjzJIwu+5hjF3kfPsE1Hi4HTwQSLX+TF3Urgap+RdtBKB DnEun24IJtMknszFx98aWEInHh1xEWQdmIJdnuQUujqCVH3X0w1WVD8kRtQHt574DBz30JfvC/80Ht A36mnWxuWI7FFJHgN+IL0bw8b+LJlStqBXpPE3+JJBT7/P8gWU3k1JhtzKI3DnKou1AQAAWle8FzRA j4SoJlmDdLJxcRshmYVsrkl6U0vbprlWT02beoh8PdAvk/BY602p+hOWjD10H739qVA8x9NVJN1PAs 3yUqSvlFoxORifj/szVgnsEfbLOycmzOdJ3KxrujHjiMPosk2tjGWmtLo/UJbjGPqyvA3vdpYj20BT H5DCOk+r0MmUzLw76WRupIR3HIxRCm7tzGbd1Da4EeuLWmmMGYx322QEx3bPehvO1x4J78r84EjFfu 1yrgQBb9KaqgphAjZycetmKweHObfokCvicF4TIkRipieMUr2vOEaye71+Ew==
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

Remove all kfunc related bits now from btf_check_func_arg_match, as
users have been converted away to refactored kfunc argument handling.

This is split into a separate commit to aid review, in order to compare
what has been preserved from the removed bits easily instead of mixing
removed hunks with previous patch.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h          |  11 --
 include/linux/bpf_verifier.h |   2 -
 kernel/bpf/btf.c             | 364 +----------------------------------
 kernel/bpf/verifier.c        |   4 +-
 4 files changed, 10 insertions(+), 371 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b2419752542a..7ffafa5bb866 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2107,22 +2107,11 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 			   const char *func_name,
 			   struct btf_func_model *m);
 
-struct bpf_kfunc_arg_meta {
-	u64 r0_size;
-	bool r0_rdonly;
-	int ref_obj_id;
-	u32 flags;
-};
-
 struct bpf_reg_state;
 int btf_check_subprog_arg_match(struct bpf_verifier_env *env, int subprog,
 				struct bpf_reg_state *regs);
 int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
 			   struct bpf_reg_state *regs);
-int btf_check_kfunc_arg_match(struct bpf_verifier_env *env,
-			      const struct btf *btf, u32 func_id,
-			      struct bpf_reg_state *regs,
-			      struct bpf_kfunc_arg_meta *meta);
 int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 			  struct bpf_reg_state *reg);
 int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *prog,
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c283484f8b94..4585de45ad1c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -590,8 +590,6 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
 int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg, int regno,
 			   enum bpf_arg_type arg_type);
-int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-			     u32 regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		   u32 regno, u32 mem_size);
 bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 56757ec79c1a..8a22f3a3c293 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6595,122 +6595,19 @@ int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *pr
 	return btf_check_func_type_match(log, btf1, t1, btf2, t2);
 }
 
-static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
-#ifdef CONFIG_NET
-	[PTR_TO_SOCKET] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
-	[PTR_TO_SOCK_COMMON] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
-	[PTR_TO_TCP_SOCK] = &btf_sock_ids[BTF_SOCK_TYPE_TCP],
-#endif
-};
-
-/* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
-static bool __btf_type_is_scalar_struct(struct bpf_verifier_log *log,
-					const struct btf *btf,
-					const struct btf_type *t, int rec)
-{
-	const struct btf_type *member_type;
-	const struct btf_member *member;
-	u32 i;
-
-	if (!btf_type_is_struct(t))
-		return false;
-
-	for_each_member(i, t, member) {
-		const struct btf_array *array;
-
-		member_type = btf_type_skip_modifiers(btf, member->type, NULL);
-		if (btf_type_is_struct(member_type)) {
-			if (rec >= 3) {
-				bpf_log(log, "max struct nesting depth exceeded\n");
-				return false;
-			}
-			if (!__btf_type_is_scalar_struct(log, btf, member_type, rec + 1))
-				return false;
-			continue;
-		}
-		if (btf_type_is_array(member_type)) {
-			array = btf_type_array(member_type);
-			if (!array->nelems)
-				return false;
-			member_type = btf_type_skip_modifiers(btf, array->type, NULL);
-			if (!btf_type_is_scalar(member_type))
-				return false;
-			continue;
-		}
-		if (!btf_type_is_scalar(member_type))
-			return false;
-	}
-	return true;
-}
-
-static bool is_kfunc_arg_mem_size(const struct btf *btf,
-				  const struct btf_param *arg,
-				  const struct bpf_reg_state *reg)
-{
-	int len, sfx_len = sizeof("__sz") - 1;
-	const struct btf_type *t;
-	const char *param_name;
-
-	t = btf_type_skip_modifiers(btf, arg->type, NULL);
-	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
-		return false;
-
-	/* In the future, this can be ported to use BTF tagging */
-	param_name = btf_name_by_offset(btf, arg->name_off);
-	if (str_is_empty(param_name))
-		return false;
-	len = strlen(param_name);
-	if (len < sfx_len)
-		return false;
-	param_name += len - sfx_len;
-	if (strncmp(param_name, "__sz", sfx_len))
-		return false;
-
-	return true;
-}
-
-static bool btf_is_kfunc_arg_mem_size(const struct btf *btf,
-				      const struct btf_param *arg,
-				      const struct bpf_reg_state *reg,
-				      const char *name)
-{
-	int len, target_len = strlen(name);
-	const struct btf_type *t;
-	const char *param_name;
-
-	t = btf_type_skip_modifiers(btf, arg->type, NULL);
-	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
-		return false;
-
-	param_name = btf_name_by_offset(btf, arg->name_off);
-	if (str_is_empty(param_name))
-		return false;
-	len = strlen(param_name);
-	if (len != target_len)
-		return false;
-	if (strcmp(param_name, name))
-		return false;
-
-	return true;
-}
-
 static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				    const struct btf *btf, u32 func_id,
 				    struct bpf_reg_state *regs,
 				    bool ptr_to_mem_ok,
-				    struct bpf_kfunc_arg_meta *kfunc_meta,
 				    bool processing_call)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
-	bool rel = false, kptr_get = false, trusted_args = false;
-	bool sleepable = false;
 	struct bpf_verifier_log *log = &env->log;
-	u32 i, nargs, ref_id, ref_obj_id = 0;
-	bool is_kfunc = btf_is_kernel(btf);
 	const char *func_name, *ref_tname;
 	const struct btf_type *t, *ref_t;
 	const struct btf_param *args;
-	int ref_regno = 0, ret;
+	u32 i, nargs, ref_id;
+	int ret;
 
 	t = btf_type_by_id(btf, func_id);
 	if (!t || !btf_type_is_func(t)) {
@@ -6736,14 +6633,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	if (is_kfunc && kfunc_meta) {
-		/* Only kfunc can be release func */
-		rel = kfunc_meta->flags & KF_RELEASE;
-		kptr_get = kfunc_meta->flags & KF_KPTR_GET;
-		trusted_args = kfunc_meta->flags & KF_TRUSTED_ARGS;
-		sleepable = kfunc_meta->flags & KF_SLEEPABLE;
-	}
-
 	/* check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
@@ -6751,42 +6640,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		enum bpf_arg_type arg_type = ARG_DONTCARE;
 		u32 regno = i + 1;
 		struct bpf_reg_state *reg = &regs[regno];
-		bool obj_ptr = false;
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 		if (btf_type_is_scalar(t)) {
-			if (is_kfunc && kfunc_meta) {
-				bool is_buf_size = false;
-
-				/* check for any const scalar parameter of name "rdonly_buf_size"
-				 * or "rdwr_buf_size"
-				 */
-				if (btf_is_kfunc_arg_mem_size(btf, &args[i], reg,
-							      "rdonly_buf_size")) {
-					kfunc_meta->r0_rdonly = true;
-					is_buf_size = true;
-				} else if (btf_is_kfunc_arg_mem_size(btf, &args[i], reg,
-								     "rdwr_buf_size"))
-					is_buf_size = true;
-
-				if (is_buf_size) {
-					if (kfunc_meta->r0_size) {
-						bpf_log(log, "2 or more rdonly/rdwr_buf_size parameters for kfunc");
-						return -EINVAL;
-					}
-
-					if (!tnum_is_const(reg->var_off)) {
-						bpf_log(log, "R%d is not a const\n", regno);
-						return -EINVAL;
-					}
-
-					kfunc_meta->r0_size = reg->var_off.value;
-					ret = mark_chain_precision(env, regno);
-					if (ret)
-						return ret;
-				}
-			}
-
 			if (reg->type == SCALAR_VALUE)
 				continue;
 			bpf_log(log, "R%d is not a scalar\n", regno);
@@ -6799,88 +6655,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			return -EINVAL;
 		}
 
-		/* These register types have special constraints wrt ref_obj_id
-		 * and offset checks. The rest of trusted args don't.
-		 */
-		obj_ptr = reg->type == PTR_TO_CTX || reg->type == PTR_TO_BTF_ID ||
-			  reg2btf_ids[base_type(reg->type)];
-
-		/* Check if argument must be a referenced pointer, args + i has
-		 * been verified to be a pointer (after skipping modifiers).
-		 * PTR_TO_CTX is ok without having non-zero ref_obj_id.
-		 */
-		if (is_kfunc && trusted_args && (obj_ptr && reg->type != PTR_TO_CTX) && !reg->ref_obj_id) {
-			bpf_log(log, "R%d must be referenced\n", regno);
-			return -EINVAL;
-		}
-
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 
-		/* Trusted args have the same offset checks as release arguments */
-		if ((trusted_args && obj_ptr) || (rel && reg->ref_obj_id))
-			arg_type |= OBJ_RELEASE;
 		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
 		if (ret < 0)
 			return ret;
 
-		if (is_kfunc && reg->ref_obj_id) {
-			/* Ensure only one argument is referenced PTR_TO_BTF_ID */
-			if (ref_obj_id) {
-				bpf_log(log, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
-					regno, reg->ref_obj_id, ref_obj_id);
-				return -EFAULT;
-			}
-			ref_regno = regno;
-			ref_obj_id = reg->ref_obj_id;
-		}
-
-		/* kptr_get is only true for kfunc */
-		if (i == 0 && kptr_get) {
-			struct btf_field *kptr_field;
-
-			if (reg->type != PTR_TO_MAP_VALUE) {
-				bpf_log(log, "arg#0 expected pointer to map value\n");
-				return -EINVAL;
-			}
-
-			/* check_func_arg_reg_off allows var_off for
-			 * PTR_TO_MAP_VALUE, but we need fixed offset to find
-			 * off_desc.
-			 */
-			if (!tnum_is_const(reg->var_off)) {
-				bpf_log(log, "arg#0 must have constant offset\n");
-				return -EINVAL;
-			}
-
-			kptr_field = btf_type_fields_find(reg->map_ptr->fields_tab, reg->off + reg->var_off.value, BPF_KPTR);
-			if (!kptr_field || kptr_field->type != BPF_KPTR_REF) {
-				bpf_log(log, "arg#0 no referenced kptr at map value offset=%llu\n",
-					reg->off + reg->var_off.value);
-				return -EINVAL;
-			}
-
-			if (!btf_type_is_ptr(ref_t)) {
-				bpf_log(log, "arg#0 BTF type must be a double pointer\n");
-				return -EINVAL;
-			}
-
-			ref_t = btf_type_skip_modifiers(btf, ref_t->type, &ref_id);
-			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
-
-			if (!btf_type_is_struct(ref_t)) {
-				bpf_log(log, "kernel function %s args#%d pointer type %s %s is not supported\n",
-					func_name, i, btf_type_str(ref_t), ref_tname);
-				return -EINVAL;
-			}
-			if (!btf_struct_ids_match(log, btf, ref_id, 0, kptr_field->kptr.btf,
-						  kptr_field->kptr.btf_id, true)) {
-				bpf_log(log, "kernel function %s args#%d expected pointer to %s %s\n",
-					func_name, i, btf_type_str(ref_t), ref_tname);
-				return -EINVAL;
-			}
-			/* rest of the arguments can be anything, like normal kfunc */
-		} else if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
+		if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
 			/* If function expects ctx type in BTF check that caller
 			 * is passing PTR_TO_CTX.
 			 */
@@ -6890,109 +6672,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					i, btf_type_str(t));
 				return -EINVAL;
 			}
-		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
-			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
-			const struct btf_type *reg_ref_t;
-			const struct btf *reg_btf;
-			const char *reg_ref_tname;
-			u32 reg_ref_id;
-
-			if (!btf_type_is_struct(ref_t)) {
-				bpf_log(log, "kernel function %s args#%d pointer type %s %s is not supported\n",
-					func_name, i, btf_type_str(ref_t),
-					ref_tname);
-				return -EINVAL;
-			}
-
-			if (reg->type == PTR_TO_BTF_ID) {
-				reg_btf = reg->btf;
-				reg_ref_id = reg->btf_id;
-			} else {
-				reg_btf = btf_vmlinux;
-				reg_ref_id = *reg2btf_ids[base_type(reg->type)];
-			}
-
-			reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id,
-							    &reg_ref_id);
-			reg_ref_tname = btf_name_by_offset(reg_btf,
-							   reg_ref_t->name_off);
-			if (!btf_struct_ids_match(log, reg_btf, reg_ref_id,
-						  reg->off, btf, ref_id,
-						  trusted_args || (rel && reg->ref_obj_id))) {
-				bpf_log(log, "kernel function %s args#%d expected pointer to %s %s but R%d has a pointer to %s %s\n",
-					func_name, i,
-					btf_type_str(ref_t), ref_tname,
-					regno, btf_type_str(reg_ref_t),
-					reg_ref_tname);
-				return -EINVAL;
-			}
 		} else if (ptr_to_mem_ok && processing_call) {
 			const struct btf_type *resolve_ret;
 			u32 type_size;
 
-			if (is_kfunc) {
-				bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
-				bool arg_dynptr = btf_type_is_struct(ref_t) &&
-						  !strcmp(ref_tname,
-							  stringify_struct(bpf_dynptr_kern));
-
-				/* Permit pointer to mem, but only when argument
-				 * type is pointer to scalar, or struct composed
-				 * (recursively) of scalars.
-				 * When arg_mem_size is true, the pointer can be
-				 * void *.
-				 * Also permit initialized local dynamic pointers.
-				 */
-				if (!btf_type_is_scalar(ref_t) &&
-				    !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
-				    !arg_dynptr &&
-				    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
-					bpf_log(log,
-						"arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
-						i, btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
-					return -EINVAL;
-				}
-
-				if (arg_dynptr) {
-					if (reg->type != PTR_TO_STACK) {
-						bpf_log(log, "arg#%d pointer type %s %s not to stack\n",
-							i, btf_type_str(ref_t),
-							ref_tname);
-						return -EINVAL;
-					}
-
-					if (!is_dynptr_reg_valid_init(env, reg)) {
-						bpf_log(log,
-							"arg#%d pointer type %s %s must be valid and initialized\n",
-							i, btf_type_str(ref_t),
-							ref_tname);
-						return -EINVAL;
-					}
-
-					if (!is_dynptr_type_expected(env, reg,
-							ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL)) {
-						bpf_log(log,
-							"arg#%d pointer type %s %s points to unsupported dynamic pointer type\n",
-							i, btf_type_str(ref_t),
-							ref_tname);
-						return -EINVAL;
-					}
-
-					continue;
-				}
-
-				/* Check for mem, len pair */
-				if (arg_mem_size) {
-					if (check_kfunc_mem_size_reg(env, &regs[regno + 1], regno + 1)) {
-						bpf_log(log, "arg#%d arg#%d memory, len pair leads to invalid memory access\n",
-							i, i + 1);
-						return -EINVAL;
-					}
-					i++;
-					continue;
-				}
-			}
-
 			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
 			if (IS_ERR(resolve_ret)) {
 				bpf_log(log,
@@ -7005,36 +6688,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			if (check_mem_reg(env, reg, regno, type_size))
 				return -EINVAL;
 		} else {
-			bpf_log(log, "reg type unsupported for arg#%d %sfunction %s#%d\n", i,
-				is_kfunc ? "kernel " : "", func_name, func_id);
+			bpf_log(log, "reg type unsupported for arg#%d function %s#%d\n", i,
+				func_name, func_id);
 			return -EINVAL;
 		}
 	}
 
-	/* Either both are set, or neither */
-	WARN_ON_ONCE((ref_obj_id && !ref_regno) || (!ref_obj_id && ref_regno));
-	/* We already made sure ref_obj_id is set only for one argument. We do
-	 * allow (!rel && ref_obj_id), so that passing such referenced
-	 * PTR_TO_BTF_ID to other kfuncs works. Note that rel is only true when
-	 * is_kfunc is true.
-	 */
-	if (rel && !ref_obj_id) {
-		bpf_log(log, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
-			func_name);
-		return -EINVAL;
-	}
-
-	if (sleepable && !env->prog->aux->sleepable) {
-		bpf_log(log, "kernel function %s is sleepable but the program is not\n",
-			func_name);
-		return -EINVAL;
-	}
-
-	if (kfunc_meta && ref_obj_id)
-		kfunc_meta->ref_obj_id = ref_obj_id;
-
-	/* returns argument register number > 0 in case of reference release kfunc */
-	return rel ? ref_regno : 0;
+	return 0;
 }
 
 /* Compare BTF of a function declaration with given bpf_reg_state.
@@ -7064,7 +6724,7 @@ int btf_check_subprog_arg_match(struct bpf_verifier_env *env, int subprog,
 		return -EINVAL;
 
 	is_global = prog->aux->func_info_aux[subprog].linkage == BTF_FUNC_GLOBAL;
-	err = btf_check_func_arg_match(env, btf, btf_id, regs, is_global, NULL, false);
+	err = btf_check_func_arg_match(env, btf, btf_id, regs, is_global, false);
 
 	/* Compiler optimizations can remove arguments from static functions
 	 * or mismatched type can be passed into a global function.
@@ -7107,7 +6767,7 @@ int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
 		return -EINVAL;
 
 	is_global = prog->aux->func_info_aux[subprog].linkage == BTF_FUNC_GLOBAL;
-	err = btf_check_func_arg_match(env, btf, btf_id, regs, is_global, NULL, true);
+	err = btf_check_func_arg_match(env, btf, btf_id, regs, is_global, true);
 
 	/* Compiler optimizations can remove arguments from static functions
 	 * or mismatched type can be passed into a global function.
@@ -7118,14 +6778,6 @@ int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
 	return err;
 }
 
-int btf_check_kfunc_arg_match(struct bpf_verifier_env *env,
-			      const struct btf *btf, u32 func_id,
-			      struct bpf_reg_state *regs,
-			      struct bpf_kfunc_arg_meta *meta)
-{
-	return btf_check_func_arg_match(env, btf, func_id, regs, true, meta, true);
-}
-
 /* Convert BTF of a function into bpf_reg_state if possible
  * Returns:
  * EFAULT - there is a verifier bug. Abort verification.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e29ea51276cb..0ff021ab3064 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5368,8 +5368,8 @@ int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 	return err;
 }
 
-int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-			     u32 regno)
+static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				    u32 regno)
 {
 	struct bpf_reg_state *mem_reg = &cur_regs(env)[regno - 1];
 	bool may_be_null = type_may_be_null(mem_reg->type);
-- 
2.38.0

