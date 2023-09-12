Return-Path: <bpf+bounces-9830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C51379DCAE
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47EC281F48
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520D814F6E;
	Tue, 12 Sep 2023 23:32:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5381429F
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:22 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C59F10FE
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:22 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-52eed139ec2so6313590a12.2
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561540; x=1695166340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WLolWLG60Kjojm7uamT/JxAmYWhvrYdhW6u3XhIoUw=;
        b=IUpjBrA2XokbgFi7RspmLRH9dJxDgq/d+GKxuTtgiHixCdIE2NyCcJphkGLbm1kREV
         vACXZ5HRYILSMjAPt0jfLgE2e66R4199m2bOhwpKHWv56kHOvCMPHQcqTG6t7ueseZ/8
         HmtQWCD9kvDjy8Zjk/BLEtAwTJ/h7Q5aeMW2RYWhIcRH8x/mYiNiEngitKwDjbpSU1C5
         AL5ip070xwNBvMDB16+5RIcYAYX2Xc87KaCcWZD5xcOdful2Dpfqm4m8t+MIXV0TXxJM
         +zvpb2eCHTMxnbCzImtjLkTrucSD9OBxEhd5Nh9sD1v4HCzZ/oOOeCmyZqODQw3SQ0LY
         689w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561540; x=1695166340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WLolWLG60Kjojm7uamT/JxAmYWhvrYdhW6u3XhIoUw=;
        b=KZFDDt17aNtb5Tpw2AYroXIUOZsKQdsesurU+G8aFIHwfiRSXuy7sxbTERnoBXpA4+
         DWeyn7evC7C6HqTQ5ZCPU/6aXYhDlJ80JiW2+q1ff3cHj4g8eYPAPOYxQ6oPC28FGF/l
         lYd+FhXGhNE8shp8fPRzt5Ut2cQBqmQE740/9AlsWlzQ5KNg6vOuuEa6TvWKPC7wjPd4
         guSjxnR3nOuaKxbL9VHX5aavMPIvP2xJls7h0HKfysJl6IHPuKAHZckklcuY9F7gA2Tt
         5KkvkgIFZSk5xQWVjPTwEYEX2m+6Zz6oLXUANp47Jxpmm4KIgTZ1y3J8SP+XIb3KDRK7
         JvDQ==
X-Gm-Message-State: AOJu0YwymtttjktR/EQOE2m3or4uL7LL4jgBO5yAZdlbGuils/UObrX/
	BECCgfcD3UT336pWrv5nBtW/54PEnnCQ0g==
X-Google-Smtp-Source: AGHT+IEHAuFU2vLP9Tbx7iPEmYWHdrrWlMQ3HPmCUsKMW2km2m3f2Ytts9JIXC13edVINCmKohainw==
X-Received: by 2002:a17:906:d8:b0:9ad:8ab4:523d with SMTP id 24-20020a17090600d800b009ad8ab4523dmr526618eji.69.1694561540470;
        Tue, 12 Sep 2023 16:32:20 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id oy25-20020a170907105900b0099d0c0bb92bsm7430493ejb.80.2023.09.12.16.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:20 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 06/17] bpf: Add support for custom exception callbacks
Date: Wed, 13 Sep 2023 01:32:03 +0200
Message-ID: <20230912233214.1518551-7-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
References: <20230912233214.1518551-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14967; i=memxor@gmail.com; h=from:subject; bh=TDfzw634HmkH1qVCVePwzkM2jE1F2uiZx1L4alpQjTM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlAPSsL7t77AucDPyTTLAKmcVekU7OJFloBpBK7 VZvoOFgh1+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQD0rAAKCRBM4MiGSL8R ysemEACNPNAYCB2cQN4hROiLygjE42W9w/aqhRPKy8Ww3cJBHiOzPVZtKezS60WBA5omivAKIcp QXwwUszS4XP52QnhZeazOyQF7+h3Q7FYx4o32WvsvqI/RxW/UGr1JH8rdE0FkaJPSag8hGvY75D yq46pF21tm//Wclsfd+bge00k7nnPIkGM3RziuJzbOcuwRYJVdsf41NdRjxXCJA1vgztgp9Qz7H jOi4X4Z6AUuf4lRVQi0PzZnl7hdZtjiPvs6E2blf7ztlQRppYXwww0u+8FSNm78cOjqcS1WHb4U Gk4vq0wnNsPahuuqrst6zGbDiLzQpka2FkTsplwmsibg1ubYsdqn6/eI+pUFRKanxYEIKCHZkMt dh73ZNfLOhKW5/+rAe89rzrxNzKSR0zb1Llk1UhbECL/sQeW91gWVoR9kEqc6g5Fzvc1oBJOhOg 6PiVaCHhSdl8xejym+xKimzA+oullUOPh98Kl7MbdFhK24cpIVVhGxmiL6YqfrkkAFkVujEDMHq YO2NIQl0YGnb6+UemTQ8gDF6T1zBrFJnUJUFTPNEU++/G0tLQ4hFlyZlbrOm9X3E76gfSypMe/v z0RqfFFelcddrhhvW5w2eXjReubXqS3u4WsDgnfWiTXBZpLyxfd15UFbtzzBEXtAZ075clPFVA5 4XAGYJxYM+REDPQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

By default, the subprog generated by the verifier to handle a thrown
exception hardcodes a return value of 0. To allow user-defined logic
and modification of the return value when an exception is thrown,
introduce the 'exception_callback:' declaration tag, which marks a
callback as the default exception handler for the program.

The format of the declaration tag is 'exception_callback:<value>', where
<value> is the name of the exception callback. Each main program can be
tagged using this BTF declaratiion tag to associate it with an exception
callback. In case the tag is absent, the default callback is used.

As such, the exception callback cannot be modified at runtime, only set
during verification.

Allowing modification of the callback for the current program execution
at runtime leads to issues when the programs begin to nest, as any
per-CPU state maintaing this information will have to be saved and
restored. We don't want it to stay in bpf_prog_aux as this takes a
global effect for all programs. An alternative solution is spilling
the callback pointer at a known location on the program stack on entry,
and then passing this location to bpf_throw as a parameter.

However, since exceptions are geared more towards a use case where they
are ideally never invoked, optimizing for this use case and adding to
the complexity has diminishing returns.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                           |   4 +-
 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/btf.c                              |  29 +++--
 kernel/bpf/verifier.c                         | 113 ++++++++++++++++--
 .../testing/selftests/bpf/bpf_experimental.h  |  31 ++++-
 5 files changed, 160 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 16740ee82082..30063a760b5a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2422,9 +2422,11 @@ int btf_check_subprog_arg_match(struct bpf_verifier_env *env, int subprog,
 int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
 			   struct bpf_reg_state *regs);
 int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
-			  struct bpf_reg_state *reg);
+			  struct bpf_reg_state *reg, bool is_ex_cb);
 int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *prog,
 			 struct btf *btf, const struct btf_type *t);
+const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type *pt,
+				    int comp_idx, const char *tag_key);
 
 struct bpf_prog *bpf_prog_by_id(u32 id);
 struct bpf_link *bpf_link_by_id(u32 id);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index da21a3ec5027..94ec766432f5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -300,6 +300,7 @@ struct bpf_func_state {
 	bool in_callback_fn;
 	struct tnum callback_ret_range;
 	bool in_async_callback_fn;
+	bool in_exception_callback_fn;
 
 	/* The following fields should be last. See copy_func_state() */
 	int acquired_refs;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 187b57276fec..f93e835d90af 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3310,10 +3310,10 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 	return BTF_FIELD_FOUND;
 }
 
-static const char *btf_find_decl_tag_value(const struct btf *btf,
-					   const struct btf_type *pt,
-					   int comp_idx, const char *tag_key)
+const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type *pt,
+				    int comp_idx, const char *tag_key)
 {
+	const char *value = NULL;
 	int i;
 
 	for (i = 1; i < btf_nr_types(btf); i++) {
@@ -3327,9 +3327,14 @@ static const char *btf_find_decl_tag_value(const struct btf *btf,
 			continue;
 		if (strncmp(__btf_name_by_offset(btf, t->name_off), tag_key, len))
 			continue;
-		return __btf_name_by_offset(btf, t->name_off) + len;
+		/* Prevent duplicate entries for same type */
+		if (value)
+			return ERR_PTR(-EEXIST);
+		value = __btf_name_by_offset(btf, t->name_off) + len;
 	}
-	return NULL;
+	if (!value)
+		return ERR_PTR(-ENOENT);
+	return value;
 }
 
 static int
@@ -3347,7 +3352,7 @@ btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
 	if (t->size != sz)
 		return BTF_FIELD_IGNORE;
 	value_type = btf_find_decl_tag_value(btf, pt, comp_idx, "contains:");
-	if (!value_type)
+	if (IS_ERR(value_type))
 		return -EINVAL;
 	node_field_name = strstr(value_type, ":");
 	if (!node_field_name)
@@ -6954,7 +6959,7 @@ int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
  * (either PTR_TO_CTX or SCALAR_VALUE).
  */
 int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
-			  struct bpf_reg_state *regs)
+			  struct bpf_reg_state *regs, bool is_ex_cb)
 {
 	struct bpf_verifier_log *log = &env->log;
 	struct bpf_prog *prog = env->prog;
@@ -7011,7 +7016,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
 		return -EINVAL;
 	}
-	/* check that function returns int */
+	/* check that function returns int, exception cb also requires this */
 	t = btf_type_by_id(btf, t->type);
 	while (btf_type_is_modifier(t))
 		t = btf_type_by_id(btf, t->type);
@@ -7060,6 +7065,14 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 			i, btf_type_str(t), tname);
 		return -EINVAL;
 	}
+	/* We have already ensured that the callback returns an integer, just
+	 * like all global subprogs. We need to determine it only has a single
+	 * scalar argument.
+	 */
+	if (is_ex_cb && (nargs != 1 || regs[BPF_REG_1].type != SCALAR_VALUE)) {
+		bpf_log(log, "exception cb only supports single integer argument\n");
+		return -EINVAL;
+	}
 	return 0;
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ec767ae08c2b..ec3f22312516 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2457,6 +2457,68 @@ static int add_subprog(struct bpf_verifier_env *env, int off)
 	return env->subprog_cnt - 1;
 }
 
+static int bpf_find_exception_callback_insn_off(struct bpf_verifier_env *env)
+{
+	struct bpf_prog_aux *aux = env->prog->aux;
+	struct btf *btf = aux->btf;
+	const struct btf_type *t;
+	u32 main_btf_id, id;
+	const char *name;
+	int ret, i;
+
+	/* Non-zero func_info_cnt implies valid btf */
+	if (!aux->func_info_cnt)
+		return 0;
+	main_btf_id = aux->func_info[0].type_id;
+
+	t = btf_type_by_id(btf, main_btf_id);
+	if (!t) {
+		verbose(env, "invalid btf id for main subprog in func_info\n");
+		return -EINVAL;
+	}
+
+	name = btf_find_decl_tag_value(btf, t, -1, "exception_callback:");
+	if (IS_ERR(name)) {
+		ret = PTR_ERR(name);
+		/* If there is no tag present, there is no exception callback */
+		if (ret == -ENOENT)
+			ret = 0;
+		else if (ret == -EEXIST)
+			verbose(env, "multiple exception callback tags for main subprog\n");
+		return ret;
+	}
+
+	ret = btf_find_by_name_kind(btf, name, BTF_KIND_FUNC);
+	if (ret < 0) {
+		verbose(env, "exception callback '%s' could not be found in BTF\n", name);
+		return ret;
+	}
+	id = ret;
+	t = btf_type_by_id(btf, id);
+	if (btf_func_linkage(t) != BTF_FUNC_GLOBAL) {
+		verbose(env, "exception callback '%s' must have global linkage\n", name);
+		return -EINVAL;
+	}
+	ret = 0;
+	for (i = 0; i < aux->func_info_cnt; i++) {
+		if (aux->func_info[i].type_id != id)
+			continue;
+		ret = aux->func_info[i].insn_off;
+		/* Further func_info and subprog checks will also happen
+		 * later, so assume this is the right insn_off for now.
+		 */
+		if (!ret) {
+			verbose(env, "invalid exception callback insn_off in func_info: 0\n");
+			ret = -EINVAL;
+		}
+	}
+	if (!ret) {
+		verbose(env, "exception callback type id not found in func_info\n");
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
 #define MAX_KFUNC_DESCS 256
 #define MAX_KFUNC_BTFS	256
 
@@ -2796,8 +2858,8 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprog = env->subprog_info;
+	int i, ret, insn_cnt = env->prog->len, ex_cb_insn;
 	struct bpf_insn *insn = env->prog->insnsi;
-	int i, ret, insn_cnt = env->prog->len;
 
 	/* Add entry function. */
 	ret = add_subprog(env, 0);
@@ -2823,6 +2885,26 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 			return ret;
 	}
 
+	ret = bpf_find_exception_callback_insn_off(env);
+	if (ret < 0)
+		return ret;
+	ex_cb_insn = ret;
+
+	/* If ex_cb_insn > 0, this means that the main program has a subprog
+	 * marked using BTF decl tag to serve as the exception callback.
+	 */
+	if (ex_cb_insn) {
+		ret = add_subprog(env, ex_cb_insn);
+		if (ret < 0)
+			return ret;
+		for (i = 1; i < env->subprog_cnt; i++) {
+			if (env->subprog_info[i].start != ex_cb_insn)
+				continue;
+			env->exception_callback_subprog = i;
+			break;
+		}
+	}
+
 	/* Add a fake 'exit' subprog which could simplify subprog iteration
 	 * logic. 'subprog_cnt' should not be increased.
 	 */
@@ -5707,6 +5789,10 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
 			/* async callbacks don't increase bpf prog stack size unless called directly */
 			if (!bpf_pseudo_call(insn + i))
 				continue;
+			if (subprog[sidx].is_exception_cb) {
+				verbose(env, "insn %d cannot call exception cb directly\n", i);
+				return -EINVAL;
+			}
 		}
 		i = next_insn;
 		idx = sidx;
@@ -5728,8 +5814,13 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
 	 * tail call counter throughout bpf2bpf calls combined with tailcalls
 	 */
 	if (tail_call_reachable)
-		for (j = 0; j < frame; j++)
+		for (j = 0; j < frame; j++) {
+			if (subprog[ret_prog[j]].is_exception_cb) {
+				verbose(env, "cannot tail call within exception cb\n");
+				return -EINVAL;
+			}
 			subprog[ret_prog[j]].tail_call_reachable = true;
+		}
 	if (subprog[0].tail_call_reachable)
 		env->prog->aux->tail_call_reachable = true;
 
@@ -14630,7 +14721,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 	const bool is_subprog = frame->subprogno;
 
 	/* LSM and struct_ops func-ptr's return type could be "void" */
-	if (!is_subprog) {
+	if (!is_subprog || frame->in_exception_callback_fn) {
 		switch (prog_type) {
 		case BPF_PROG_TYPE_LSM:
 			if (prog->expected_attach_type == BPF_LSM_CGROUP)
@@ -14678,7 +14769,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 		return 0;
 	}
 
-	if (is_subprog) {
+	if (is_subprog && !frame->in_exception_callback_fn) {
 		if (reg->type != SCALAR_VALUE) {
 			verbose(env, "At subprogram exit the register R0 is not a scalar value (%s)\n",
 				reg_type_str(env, reg->type));
@@ -19334,7 +19425,7 @@ static void free_states(struct bpf_verifier_env *env)
 	}
 }
 
-static int do_check_common(struct bpf_verifier_env *env, int subprog)
+static int do_check_common(struct bpf_verifier_env *env, int subprog, bool is_ex_cb)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_verifier_state *state;
@@ -19365,7 +19456,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	regs = state->frame[state->curframe]->regs;
 	if (subprog || env->prog->type == BPF_PROG_TYPE_EXT) {
-		ret = btf_prepare_func_args(env, subprog, regs);
+		ret = btf_prepare_func_args(env, subprog, regs, is_ex_cb);
 		if (ret)
 			goto out;
 		for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
@@ -19381,6 +19472,12 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				regs[i].id = ++env->id_gen;
 			}
 		}
+		if (is_ex_cb) {
+			state->frame[0]->in_exception_callback_fn = true;
+			env->subprog_info[subprog].is_cb = true;
+			env->subprog_info[subprog].is_async_cb = true;
+			env->subprog_info[subprog].is_exception_cb = true;
+		}
 	} else {
 		/* 1st arg to a function */
 		regs[BPF_REG_1].type = PTR_TO_CTX;
@@ -19445,7 +19542,7 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 			continue;
 		env->insn_idx = env->subprog_info[i].start;
 		WARN_ON_ONCE(env->insn_idx == 0);
-		ret = do_check_common(env, i);
+		ret = do_check_common(env, i, env->exception_callback_subprog == i);
 		if (ret) {
 			return ret;
 		} else if (env->log.level & BPF_LOG_LEVEL) {
@@ -19462,7 +19559,7 @@ static int do_check_main(struct bpf_verifier_env *env)
 	int ret;
 
 	env->insn_idx = 0;
-	ret = do_check_common(env, 0);
+	ret = do_check_common(env, 0, false);
 	if (!ret)
 		env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
 	return ret;
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 333b54a86e3a..9a87170524ce 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -165,7 +165,16 @@ extern void bpf_percpu_obj_drop_impl(void *kptr, void *meta) __ksym;
 /* Description
  *	Throw a BPF exception from the program, immediately terminating its
  *	execution and unwinding the stack. The supplied 'cookie' parameter
- *	will be the return value of the program when an exception is thrown.
+ *	will be the return value of the program when an exception is thrown,
+ *	and the default exception callback is used. Otherwise, if an exception
+ *	callback is set using the '__exception_cb(callback)' declaration tag
+ *	on the main program, the 'cookie' parameter will be the callback's only
+ *	input argument.
+ *
+ *	Thus, in case of default exception callback, 'cookie' is subjected to
+ *	constraints on the program's return value (as with R0 on exit).
+ *	Otherwise, the return value of the marked exception callback will be
+ *	subjected to the same checks.
  *
  *	Note that throwing an exception with lingering resources (locks,
  *	references, etc.) will lead to a verification error.
@@ -178,4 +187,24 @@ extern void bpf_percpu_obj_drop_impl(void *kptr, void *meta) __ksym;
  */
 extern void bpf_throw(u64 cookie) __ksym;
 
+/* This macro must be used to mark the exception callback corresponding to the
+ * main program. For example:
+ *
+ * int exception_cb(u64 cookie) {
+ *	return cookie;
+ * }
+ *
+ * SEC("tc")
+ * __exception_cb(exception_cb)
+ * int main_prog(struct __sk_buff *ctx) {
+ *	...
+ *	return TC_ACT_OK;
+ * }
+ *
+ * Here, exception callback for the main program will be 'exception_cb'. Note
+ * that this attribute can only be used once, and multiple exception callbacks
+ * specified for the main program will lead to verification error.
+ */
+#define __exception_cb(name) __attribute__((btf_decl_tag("exception_callback:" #name)))
+
 #endif
-- 
2.41.0


