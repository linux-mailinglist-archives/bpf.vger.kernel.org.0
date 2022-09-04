Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E085AC66B
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiIDUmG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiIDUmD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:03 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04442CDFA
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:00 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id fc24so4453470ejc.3
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TkCdMGiKmyLXxX7d4BnZ/uV3pekGIp8Nq/Ww/a2hyzo=;
        b=Q3oqts8nAZnRJLui0THTFXVzuFpdynpKnI0iwHdAm/8t9pD03DIxhE7F2kdlsyRhZi
         iUf4z3yU6U+j+2heGYYrzsS36SINHD5heIdpGlWmldl7c171k+3/mZv8ElnAQBnAErL9
         8Nid5jV0O3OFZipkQaDGMCoVPu5RPt3SHZVX+EP7qdI9J/tpSgiwRdqysTFqnC4eyPdM
         KLDuTzBcWRGCDZJxh8OJ5h1p88Sa6jGCBq4aDa1ivTAPVwQyafOHvPtb2tZobopoO5Fs
         vAIFP8iKh3ysH+WOAQSLSCrxnqDpkKyzczRejRKwczcehSJrctwL3FImJxZQOhDAznLi
         CUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TkCdMGiKmyLXxX7d4BnZ/uV3pekGIp8Nq/Ww/a2hyzo=;
        b=Asgq2aU174nmEGmmEYt9mrl/a9qAj8gAUgQzcXY7uURdJ7hJUWwI5m63RdjS/6BFfV
         fsvDCXcocGQMP5+HtGe0WLJRdoRSxiNG5+g87E8b5giODKsO0IpYO7qOWBdqMbjoEu2c
         BHMm3vKQrLCsmmdz5KCRffu4reTi2wYOySaEX2SJ9Y6xfVGqJ4+isl0z5yDYXAv+4RsL
         lY0aEuk6nLmWXylCI3k9osqxnkMMiX7iNPkMRf6CkvPXELOoQ4C+bwNLFBXJ7ADuxgNl
         of6oqzY4YKEioJhpCTue1eq6vyLKxIy56gVpT4wEQm24x8TvntF65eAxiqTln56sc3YV
         XFwg==
X-Gm-Message-State: ACgBeo3EOK7dqEcpm55i2z5lzYedYHchMExYMZiYc875RzPtZqMkVsM0
        V6xjD8Vii+BCWXWTI7OXVvCmRONU3kEwuQ==
X-Google-Smtp-Source: AA6agR4Yku7PtiScBdW7GGuuSzjm2htyX6m2rFmHKj4F6lE1VYPJYAMGXkh44p1/ibyrzp7Fmo28kQ==
X-Received: by 2002:a17:907:b013:b0:73d:c708:3f22 with SMTP id fu19-20020a170907b01300b0073dc7083f22mr32717786ejc.608.1662324119800;
        Sun, 04 Sep 2022 13:41:59 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b0073d83f80b05sm4135961ejh.94.2022.09.04.13.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:41:59 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 10/32] bpf: Drop kfunc support from btf_check_func_arg_match
Date:   Sun,  4 Sep 2022 22:41:23 +0200
Message-Id: <20220904204145.3089-11-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14298; i=memxor@gmail.com; h=from:subject; bh=GF9nfMSI9oHlU6IG2gGMZ/Sab31pK+f7H6++lTDpx5o=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1wcCXBrecoUZPTKgby0G/yt4XEFP94Of0HZPgX Fv0G3vaJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcAAKCRBM4MiGSL8RyhlkD/ 0auW3665z6OFlsqjUnMB2FJbTGv1DR8Av3j8RlHpllxytiC2lNKTyaYRolSyedVcqTOCzjPLTxswoi KVicjZrh809JCk1VP8S6EALE7qngeYiaD1dl8Nm4sti3tzvyQd15ChWlQER046ho7+i+T7Q9xQbHnc 6V+1nweaSO38raOdpK7JKVzFjgGz484BjmrkUaRNYQ0sF7d4YFz+ue3B3wWP7+tf4rPy8HCmDZfacE +nehjYfj4WNnsKPcxU2FU5C9S+RG1PzS+E+WH24dyjZNOW4t4fYRKWN+zVAXYyQFM2igt1eA6ZYLsn i9LDkFMzvsSynpWJIjYo8B/mulpCQ/eGpjHFFmHs8z5qr64z31zNM5jMzuJXBcqfOgdSifuMM3xskH zXOyxCiEofg0Pr001VtV2nsOTSC/UDK57wrGwzct7L+eE0Y+zjp3rh8eU3HA924I7UyUIpIqp3FbeU XrFi01K+kvw4UUivkB9+01/Uc0BM3JtiPIOLHzA/DdOSi9ZsdLlyq6SDTDUPzRItyVB1e5snY7NRbM gBOm3UjC5maxVzVacf9doamzTtuRWa/5Ta493N5P1aCp1RVLODw6dUmmW4snS3JgD7iaBOEoWsaFlR DdwbqL4ABD+r3v5wxGhlmYDWEK+GQ3fu2pkxR1X3hWyMvNxjBIU+g6I+CnYg==
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

Remove all kfunc related bits now from btf_check_func_arg_match, as
users have been converted away to refactored kfunc argument handling.

This is split into a separate commit to aid review, in order to compare
what has been preserved from the removed bits easily instead of mixing
removed hunks with previous patch.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h          |   4 -
 include/linux/bpf_verifier.h |   2 -
 kernel/bpf/btf.c             | 262 ++---------------------------------
 kernel/bpf/verifier.c        |   4 +-
 4 files changed, 10 insertions(+), 262 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cdc0a8c1b1d1..d4e6bf789c02 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1976,10 +1976,6 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 struct bpf_reg_state;
 int btf_check_subprog_arg_match(struct bpf_verifier_env *env, int subprog,
 				struct bpf_reg_state *regs);
-int btf_check_kfunc_arg_match(struct bpf_verifier_env *env,
-			      const struct btf *btf, u32 func_id,
-			      struct bpf_reg_state *regs,
-			      u32 kfunc_flags);
 int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 			  struct bpf_reg_state *reg);
 int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *prog,
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1fdddbf3546b..b4a11ff56054 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -567,8 +567,6 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
 int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg, int regno,
 			   enum bpf_arg_type arg_type);
-int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-			     u32 regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		   u32 regno, u32 mem_size);
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0ad809a3055d..6740c3ade8f1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6085,96 +6085,18 @@ int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *pr
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
 static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				    const struct btf *btf, u32 func_id,
 				    struct bpf_reg_state *regs,
-				    bool ptr_to_mem_ok,
-				    u32 kfunc_flags)
+				    bool ptr_to_mem_ok)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
-	bool rel = false, kptr_get = false, trusted_arg = false;
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
@@ -6200,14 +6122,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	if (is_kfunc) {
-		/* Only kfunc can be release func */
-		rel = kfunc_flags & KF_RELEASE;
-		kptr_get = kfunc_flags & KF_KPTR_GET;
-		trusted_arg = kfunc_flags & KF_TRUSTED_ARGS;
-		sleepable = kfunc_flags & KF_SLEEPABLE;
-	}
-
 	/* check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
@@ -6230,70 +6144,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			return -EINVAL;
 		}
 
-		/* Check if argument must be a referenced pointer, args + i has
-		 * been verified to be a pointer (after skipping modifiers).
-		 */
-		if (is_kfunc && trusted_arg && !reg->ref_obj_id) {
-			bpf_log(log, "R%d must be referenced\n", regno);
-			return -EINVAL;
-		}
-
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 
-		/* Trusted args have the same offset checks as release arguments */
-		if (trusted_arg || (rel && reg->ref_obj_id))
-			arg_type |= OBJ_RELEASE;
 		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
 		if (ret < 0)
 			return ret;
 
-		/* kptr_get is only true for kfunc */
-		if (i == 0 && kptr_get) {
-			struct bpf_map_value_off_desc *off_desc;
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
-			off_desc = bpf_map_kptr_off_contains(reg->map_ptr, reg->off + reg->var_off.value);
-			if (!off_desc || off_desc->type != BPF_KPTR_REF) {
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
-			if (!btf_struct_ids_match(log, btf, ref_id, 0, off_desc->kptr.btf,
-						  off_desc->kptr.btf_id, true)) {
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
@@ -6303,86 +6161,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
-				/* Ensure only one argument is referenced PTR_TO_BTF_ID */
-				if (reg->ref_obj_id) {
-					if (ref_obj_id) {
-						bpf_log(log, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
-							regno, reg->ref_obj_id, ref_obj_id);
-						return -EFAULT;
-					}
-					ref_regno = regno;
-					ref_obj_id = reg->ref_obj_id;
-				}
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
-						  trusted_arg || (rel && reg->ref_obj_id))) {
-				bpf_log(log, "kernel function %s args#%d expected pointer to %s %s but R%d has a pointer to %s %s\n",
-					func_name, i,
-					btf_type_str(ref_t), ref_tname,
-					regno, btf_type_str(reg_ref_t),
-					reg_ref_tname);
-				return -EINVAL;
-			}
 		} else if (ptr_to_mem_ok) {
 			const struct btf_type *resolve_ret;
 			u32 type_size;
 
-			if (is_kfunc) {
-				bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
-
-				/* Permit pointer to mem, but only when argument
-				 * type is pointer to scalar, or struct composed
-				 * (recursively) of scalars.
-				 * When arg_mem_size is true, the pointer can be
-				 * void *.
-				 */
-				if (!btf_type_is_scalar(ref_t) &&
-				    !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
-				    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
-					bpf_log(log,
-						"arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
-						i, btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
-					return -EINVAL;
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
@@ -6395,33 +6177,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
-	/* returns argument register number > 0 in case of reference release kfunc */
-	return rel ? ref_regno : 0;
+	return 0;
 }
 
 /* Compare BTF of a function with given bpf_reg_state.
@@ -6451,7 +6213,7 @@ int btf_check_subprog_arg_match(struct bpf_verifier_env *env, int subprog,
 		return -EINVAL;
 
 	is_global = prog->aux->func_info_aux[subprog].linkage == BTF_FUNC_GLOBAL;
-	err = btf_check_func_arg_match(env, btf, btf_id, regs, is_global, 0);
+	err = btf_check_func_arg_match(env, btf, btf_id, regs, is_global);
 
 	/* Compiler optimizations can remove arguments from static functions
 	 * or mismatched type can be passed into a global function.
@@ -6462,14 +6224,6 @@ int btf_check_subprog_arg_match(struct bpf_verifier_env *env, int subprog,
 	return err;
 }
 
-int btf_check_kfunc_arg_match(struct bpf_verifier_env *env,
-			      const struct btf *btf, u32 func_id,
-			      struct bpf_reg_state *regs,
-			      u32 kfunc_flags)
-{
-	return btf_check_func_arg_match(env, btf, func_id, regs, true, kfunc_flags);
-}
-
 /* Convert BTF of a function into bpf_reg_state if possible
  * Returns:
  * EFAULT - there is a verifier bug. Abort verification.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 663c91020f82..96fab14eb94e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5338,8 +5338,8 @@ int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
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
2.34.1

