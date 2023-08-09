Return-Path: <bpf+bounces-7338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA48775E00
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 13:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C3B1C21174
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 11:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1413317FE0;
	Wed,  9 Aug 2023 11:42:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C049D17AB8
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 11:42:57 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF18210C
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 04:42:52 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-99c353a395cso927761766b.2
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 04:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691581370; x=1692186170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXcswezpT6mGJeYdhmBOBcDAXUG/QIQG0ZIMU88BxEU=;
        b=QKa6vLaTDAnevI2KuK0buVeHN2eL1jzM8n+NGCW9W7VQQS0U3O6GVEXkkDgicHbSKR
         j1l8WOgLw7Cf6tCUHoAYldo4mEZYP1G/CjETwLyNG8UjPh8J0QIoVcswfdLVG90fIWQN
         /I0hVh2/XvkXSOc+p5O2svA3mDHTaOYucYYnH+ypXxDr3/QvEc9pTHOqanMhIbWZSDSV
         OC8BLVB8wHA45x2IPV6QRbPAlH+3Ke/hRt62h1cXmwaW+hUWogoGAQg9/zEScr+IRPo8
         U8r12VleoYmkXKPE1wvwFFGspvGzkVQgotcIrVcgWsrTpIR86PGGC8PvFpVvGmuGBMtf
         ROtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581370; x=1692186170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXcswezpT6mGJeYdhmBOBcDAXUG/QIQG0ZIMU88BxEU=;
        b=Tf3HCynajw1zS+25b4Db5gZKgi8finQ0B5a/KFO/gmdwAK9BoLkYWUysT4oyzj99XZ
         OHH0s7o26k8a4iTO9DeUVQGVb58z1p4pup0KKxRCFAsWvqb1+sofXbtKscpEkIQnpiDB
         Pwm7skBnW1Gk8qyMwyC++cUHw9k6GjpI0TwNyCQ8ptCebQdJkGicLd8gesWl6WP/eupq
         j9aZoQ/xfzKcGO3G/RpfMYapHCx6Z5msN2porJM8/3KS476lb0xVuVI56/oo5g77gzZ8
         z4wX0ebNZ80RE/0xKy7UeuVSkF9gmcEtFfreEB7DqwwtmCoW/YXL7rAxQgAJ/GdTKrn5
         Nbuw==
X-Gm-Message-State: AOJu0Yzd0dr06wyY8r3yr6D3Dy7U5ttOe75CN5VJ+L4LhAkAB2FVhz0U
	UNN/7RT+AIub83iNit+aHqZMcy9qYCSxQdCDQYY=
X-Google-Smtp-Source: AGHT+IEwfzGRH8aRChEN2gBKHbWqaI7WvDc53PZgDw9clXokBT8BvN9RtCfzQ26URP761vrSiMfdZg==
X-Received: by 2002:a17:906:8a77:b0:99b:f03d:de37 with SMTP id hy23-20020a1709068a7700b0099bf03dde37mr1793712ejc.60.1691581369932;
        Wed, 09 Aug 2023 04:42:49 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:1f3a:4dfc:39ef:546b])
        by smtp.gmail.com with ESMTPSA id h4-20020a1709062dc400b0099bc2d1429csm7917345eji.72.2023.08.09.04.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:42:49 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 05/14] bpf: Add support for custom exception callbacks
Date: Wed,  9 Aug 2023 17:11:07 +0530
Message-ID: <20230809114116.3216687-6-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809114116.3216687-1-memxor@gmail.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15119; i=memxor@gmail.com; h=from:subject; bh=yqSxAz0oCDyglBWsfGPLR+MGNEhMCs4XTlknsgcty00=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk03rIjUHN61Ov4JN9rFYz+h7JEBcWumPPXsZN/ g8FpcvCdZiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZNN6yAAKCRBM4MiGSL8R ygP1D/oCML2IlBzUzyuRXYhDR8/5YocCsW4YxlAjtLOQvS72b1K9WOC5z4qsEhNSA19d/MUBLcu Va/PjVlXhlH79h8pDfKiWIhGaEic6vCoG+X/fTsDsxxVERWa87DOD7OQwdbIQDBiz/Ph2HuEUEg fxFngeaLicmC4rp6pNY9wCebda+uFCbPX+MlispjEg58YBuTHMf3AK3FIsvEK44p81QXpV3HwXG W6LeX5bSoog5E1FrWB7B6bAj+6EoCzAu41EPnCdh92/shbJHL2diC3Y/mUlzBSrSaEAX3y6EGwu d/QZIIWUTsOp4/3fDaX9FejgsL83lF0BZ2TPzzrosydiAX6dejuwodcYTSMoM1J0gAgdE0VQPLH 26yEkCRBMs8Fv0w8Os05sxdSLmYNasKrR6CUAd+Dzjuw2JyiSv43uN+FG9HICRh6hdhgwe7favp VRjcTZmK2j5tbNpC7RBuS/AXtwyDnogCjyHDIIK8SLz19g8qq71hmFkMyDxYzrZrOJF9/tKQaNh AKg8Qrj/EL5K3bCITyh4sLbpTX7f0Yk/zheaef5mZqomsF7vz/pewpzXaUOEPaDtaKOUYVy6Csc 6UfZVVr0Isp06aSsW5L/utE1KJ0kt71ZHxriMp/7kHQDpzrP4IRtOo6X2crxV7TmjXnAMgjf3x7 53Bow+rFJHS3/8A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 kernel/bpf/verifier.c                         | 118 ++++++++++++++++--
 .../testing/selftests/bpf/bpf_experimental.h  |  31 ++++-
 5 files changed, 165 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e938e75b0998..2125d77ce2e1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2364,9 +2364,11 @@ int btf_check_subprog_arg_match(struct bpf_verifier_env *env, int subprog,
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
index 9e6c25ecac9f..801ada8e614e 100644
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
index 249657c466dd..8da0eac3dcbd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3308,10 +3308,10 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
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
@@ -3325,9 +3325,14 @@ static const char *btf_find_decl_tag_value(const struct btf *btf,
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
@@ -3345,7 +3350,7 @@ btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
 	if (t->size != sz)
 		return BTF_FIELD_IGNORE;
 	value_type = btf_find_decl_tag_value(btf, pt, comp_idx, "contains:");
-	if (!value_type)
+	if (IS_ERR(value_type))
 		return -EINVAL;
 	node_field_name = strstr(value_type, ":");
 	if (!node_field_name)
@@ -6949,7 +6954,7 @@ int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
  * (either PTR_TO_CTX or SCALAR_VALUE).
  */
 int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
-			  struct bpf_reg_state *regs)
+			  struct bpf_reg_state *regs, bool is_ex_cb)
 {
 	struct bpf_verifier_log *log = &env->log;
 	struct bpf_prog *prog = env->prog;
@@ -7006,7 +7011,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
 		return -EINVAL;
 	}
-	/* check that function returns int */
+	/* check that function returns int, exception cb also requires this */
 	t = btf_type_by_id(btf, t->type);
 	while (btf_type_is_modifier(t))
 		t = btf_type_by_id(btf, t->type);
@@ -7055,6 +7060,14 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
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
index d0f6c984272b..9d67d0633c59 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2457,6 +2457,73 @@ static int add_subprog(struct bpf_verifier_env *env, int off)
 	return env->subprog_cnt - 1;
 }
 
+static int bpf_find_exception_callback_insn_off(struct bpf_verifier_env *env)
+{
+	struct bpf_prog_aux *aux = env->prog->aux;
+	struct btf *btf = aux->btf;
+	const struct btf_type *t;
+	const char *name;
+	u32 main_btf_id;
+	int ret, i, j;
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
+	ret = -ENOENT;
+	for (i = 0; i < btf_nr_types(btf); i++) {
+		t = btf_type_by_id(btf, i);
+		if (!btf_type_is_func(t))
+			continue;
+		if (strcmp(name, btf_name_by_offset(btf, t->name_off)))
+			continue;
+		if (btf_func_linkage(t) != BTF_FUNC_GLOBAL) {
+			verbose(env, "exception callback '%s' must have global linkage\n", name);
+			return -EINVAL;
+		}
+
+		ret = 0;
+		for (j = 0; j < aux->func_info_cnt; j++) {
+			if (aux->func_info[j].type_id != i)
+				continue;
+			ret = aux->func_info[j].insn_off;
+			/* Further func_info and subprog checks will also happen
+			 * later, so assume this is the right insn_off for now.
+			 */
+			if (!ret) {
+				verbose(env, "invalid exception callback insn_off in func_info: 0\n");
+				ret = -EINVAL;
+			}
+		}
+		if (!ret) {
+			verbose(env, "exception callback type id not found in func_info\n");
+			ret = -EINVAL;
+		}
+		break;
+	}
+	if (ret == -ENOENT)
+		verbose(env, "exception callback '%s' could not be found in BTF\n", name);
+	return ret;
+}
+
 #define MAX_KFUNC_DESCS 256
 #define MAX_KFUNC_BTFS	256
 
@@ -2796,8 +2863,8 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprog = env->subprog_info;
+	int i, ret, insn_cnt = env->prog->len, ex_cb_insn;
 	struct bpf_insn *insn = env->prog->insnsi;
-	int i, ret, insn_cnt = env->prog->len;
 
 	/* Add entry function. */
 	ret = add_subprog(env, 0);
@@ -2823,6 +2890,26 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
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
@@ -5691,6 +5778,10 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
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
@@ -5712,8 +5803,13 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
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
 
@@ -14528,7 +14624,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 	const bool is_subprog = frame->subprogno;
 
 	/* LSM and struct_ops func-ptr's return type could be "void" */
-	if (!is_subprog) {
+	if (!is_subprog || frame->in_exception_callback_fn) {
 		switch (prog_type) {
 		case BPF_PROG_TYPE_LSM:
 			if (prog->expected_attach_type == BPF_LSM_CGROUP)
@@ -14576,7 +14672,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 		return 0;
 	}
 
-	if (is_subprog) {
+	if (is_subprog && !frame->in_exception_callback_fn) {
 		if (reg->type != SCALAR_VALUE) {
 			verbose(env, "At subprogram exit the register R0 is not a scalar value (%s)\n",
 				reg_type_str(env, reg->type));
@@ -19189,7 +19285,7 @@ static void free_states(struct bpf_verifier_env *env)
 	}
 }
 
-static int do_check_common(struct bpf_verifier_env *env, int subprog)
+static int do_check_common(struct bpf_verifier_env *env, int subprog, bool is_ex_cb)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_verifier_state *state;
@@ -19220,7 +19316,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	regs = state->frame[state->curframe]->regs;
 	if (subprog || env->prog->type == BPF_PROG_TYPE_EXT) {
-		ret = btf_prepare_func_args(env, subprog, regs);
+		ret = btf_prepare_func_args(env, subprog, regs, is_ex_cb);
 		if (ret)
 			goto out;
 		for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
@@ -19236,6 +19332,12 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
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
@@ -19300,7 +19402,7 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 			continue;
 		env->insn_idx = env->subprog_info[i].start;
 		WARN_ON_ONCE(env->insn_idx == 0);
-		ret = do_check_common(env, i);
+		ret = do_check_common(env, i, env->exception_callback_subprog == i);
 		if (ret) {
 			return ret;
 		} else if (env->log.level & BPF_LOG_LEVEL) {
@@ -19317,7 +19419,7 @@ static int do_check_main(struct bpf_verifier_env *env)
 	int ret;
 
 	env->insn_idx = 0;
-	ret = do_check_common(env, 0);
+	ret = do_check_common(env, 0, false);
 	if (!ret)
 		env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
 	return ret;
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 952a40cbe09c..612ac86873af 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -134,7 +134,16 @@ extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
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
@@ -147,4 +156,24 @@ extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
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


