Return-Path: <bpf+bounces-7335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3157775DEA
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 13:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F398D1C21187
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 11:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4E617ABA;
	Wed,  9 Aug 2023 11:41:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD8E17AAB
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 11:41:50 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BDB1FD2
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 04:41:48 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so8930370a12.1
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 04:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691581307; x=1692186107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4R4rA62kVSnDZWKBc7RUYNS8basysfRTud29ctuoGuU=;
        b=XupG/Hx9zEdFmy3gtjLT4W1aMC6Nfr85ZLChbCveBmCQ/P5MI0/eIfStnjZF3n7/wm
         uEBtx1stsEL+IJEQe7HIoF9QSdSOeA81py+QR8TtbhvEQxnMYWkBWVg2gY3DE5QKq46n
         8qwhfEY9vvBqbdaHN2p1e9mo4x0eJtTDmQR72PHsbFg77p8En3ZgofAaJDUaGLCWVgNX
         G5RULiusSvQQGyBjJw4UM7Qm20mNYcrht+dWmhgX6gkv30ORI4vw2ZKFA6TcD9uMsHH+
         rkCI+rwyu8sn/TwM4nlTi4wkSNt2WTypSIMmpQ2LFdfedR4fU5T6UVD/CV1vM8D9S2Of
         x7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581307; x=1692186107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4R4rA62kVSnDZWKBc7RUYNS8basysfRTud29ctuoGuU=;
        b=jyI9fNpGcUPgbMWxJUta59SY1iqgEqm5xXnt9aQTwpWP9KU/xLcclBAz2vlcdMj5DU
         R64iCOyEiKUI0wNDDEXTrxmQys12C7dv93vsfxs0FNKOdn4FVUm6R+Tv8i533uMzrJVD
         4eICCzMiZqVkb3/h72ycCGF/OtJtk+2abRE13Bg6WNDLVNdCpYsVCy5MezDvUMGDYGHn
         Od/9uTX11with6Ze+q/x3JcX07ojy2B6mLu4nmnpapqENCI4kTtCkf+fvZvDILBmiYNN
         bhE066ioMiYePAwmCQ8xtRts6w6XJIinTsyL4f/PSvDCOHh9GOUm7Zu2yTmsEcTRPnL7
         Nf3g==
X-Gm-Message-State: AOJu0YzVVTF82p4zmUa3DH9mLNVVT469Z0GHVrcgENex8hYQCrglzAwv
	VTL31/0WQ/ONvvKqCXkzg4+zHuAE5yJYgYsd9p0=
X-Google-Smtp-Source: AGHT+IEdutLpWWPvLxpxnncslh1DzD1jVO+SVYzrxIEGmy8MnWkWjeQoF91ELN1O5pRkCFVUm8gpAA==
X-Received: by 2002:a17:906:2097:b0:991:c842:2ca2 with SMTP id 23-20020a170906209700b00991c8422ca2mr2155723ejq.15.1691581306733;
        Wed, 09 Aug 2023 04:41:46 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:1f3a:4dfc:39ef:546b])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709066d0800b0099cadcf13cesm6977876ejr.66.2023.08.09.04.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:41:45 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 02/14] bpf: Implement support for adding hidden subprogs
Date: Wed,  9 Aug 2023 17:11:04 +0530
Message-ID: <20230809114116.3216687-3-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809114116.3216687-1-memxor@gmail.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8798; i=memxor@gmail.com; h=from:subject; bh=KFQ9FWW0oxq2pX5bNBd6GsvJzMUT24XEyjPEvCLV0HA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk03rI0gyMCy72lU88JrAdEyJbKWftIXk0si2Gk 4ez8YU/HfuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZNN6yAAKCRBM4MiGSL8R yv1ID/9qN/dUl4I3VDbTi42ARnofWs5Wq4x4/b7SsAhTjN5BQIrIc8LtjlT11KPozmmYhQpWXyc rtL5F7zYGuL9UxyfHVLSSt3fYg8ETo4QL9duhczX7DXSSIIN7S/pI9Um9veYSeX5XBmcBMrBPN0 s/NOclfIIz6Tf4qVhUdwgINCVYqhkG30d0uGuyPvlazK+7Pn0QY+sjMUS+A3atF84G5zNjoOzfl K6XDtlTBsS6roM3I267dJ49T+iNWaPdcibyU7bCRcPFHk9kOO05oVJ92TmDWskKYlH7GLPOUico TgboHa0VV+cfex00m7hQa462ANS05h6YNx2XbBbBe9tGOUK5PPqbgy8Q8FVc/L83j/rLGKx7jnI cxSOAqfUepfuqwrivqTOx1NdbPFLdv6NgiIBliUv6VxhWG2hW4itRZFEiOjRYl3L4KJsJCulx+4 Poe0rbe33iWxrTBHGUIXlzq2cP2I6imOOoFx+Pjr/NSHkWEOSd0p3lXLmUB1AUh00PinrqCe+uz LfAETNu5ZYwU3VY+0iqvBu2JVwKy79pidJm7KdIKVDygyMzfRRHiHvon6S26HYQsJ+li5vI9pWe I6s1VFskkvPWANdK6o8L/rSuuImAsl7FTt8kuaZYgcKyCjhhhKRhs59VggV+wdrsML9tC6d22tN 2aCm6IbXRTuFrlg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce support in the verifier for generating a subprogram and
include it as part of a BPF program dynamically after the do_check phase
is complete. The first user will be the next patch which generates
default exception callbacks if none are set for the program. The phase
of invocation will be do_misc_fixups. Note that this is an internal
verifier function, and should be used with instruction blocks which
uphold the invariants stated in check_subprogs.

Since these subprogs are always appended to the end of the instruction
sequence of the program, it becomes relatively inexpensive to do the
related adjustments to the subprog_info of the program. Only the fake
exit subprogram is shifted forward, making room for our new subprog.

This is useful to insert a new subprogram, get it JITed, and obtain its
function pointer. The next patch will use this functionality to insert a
default exception callback which will be invoked after unwinding the
stack.

Note that these added subprograms are invisible to userspace, and never
reported in BPF_OBJ_GET_INFO_BY_ID etc. For now, only a single
subprogram is supported, but more can be easily supported in the future.

To this end, two function counts are introduced now, the existing
func_cnt, and real_func_cnt, the latter including hidden programs. This
allows us to conver the JIT code to use the real_func_cnt for management
of resources while syscall path continues working with existing
func_cnt.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  3 ++-
 kernel/bpf/core.c            | 12 ++++++------
 kernel/bpf/syscall.c         |  2 +-
 kernel/bpf/verifier.c        | 36 +++++++++++++++++++++++++++++++++---
 5 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index db3fe5a61b05..751f565037f9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1377,6 +1377,7 @@ struct bpf_prog_aux {
 	u32 stack_depth;
 	u32 id;
 	u32 func_cnt; /* used by non-func prog as the number of func progs */
+	u32 real_func_cnt; /* includes hidden progs, only used for JIT and freeing progs */
 	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
 	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
 	u32 ctx_arg_info_size;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f70f9ac884d2..beb0e9e01bd5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -587,6 +587,7 @@ struct bpf_verifier_env {
 	u32 used_map_cnt;		/* number of used maps */
 	u32 used_btf_cnt;		/* number of used BTF objects */
 	u32 id_gen;			/* used to generate unique reg IDs */
+	u32 hidden_subprog_cnt;		/* number of hidden subprogs */
 	bool explore_alu_limits;
 	bool allow_ptr_leaks;
 	bool allow_uninit_stack;
@@ -597,7 +598,7 @@ struct bpf_verifier_env {
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
-	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 1];
+	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 for the fake and exception subprogs */
 	union {
 		struct bpf_idmap idmap_scratch;
 		struct bpf_idset idset_scratch;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 526059386e9d..2e5907d15118 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -212,7 +212,7 @@ void bpf_prog_fill_jited_linfo(struct bpf_prog *prog,
 	const struct bpf_line_info *linfo;
 	void **jited_linfo;
 
-	if (!prog->aux->jited_linfo)
+	if (!prog->aux->jited_linfo || prog->aux->func_idx > prog->aux->func_cnt)
 		/* Userspace did not provide linfo */
 		return;
 
@@ -539,7 +539,7 @@ static void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp)
 {
 	int i;
 
-	for (i = 0; i < fp->aux->func_cnt; i++)
+	for (i = 0; i < fp->aux->real_func_cnt; i++)
 		bpf_prog_kallsyms_del(fp->aux->func[i]);
 }
 
@@ -589,7 +589,7 @@ bpf_prog_ksym_set_name(struct bpf_prog *prog)
 	sym  = bin2hex(sym, prog->tag, sizeof(prog->tag));
 
 	/* prog->aux->name will be ignored if full btf name is available */
-	if (prog->aux->func_info_cnt) {
+	if (prog->aux->func_info_cnt && prog->aux->func_idx < prog->aux->func_info_cnt) {
 		type = btf_type_by_id(prog->aux->btf,
 				      prog->aux->func_info[prog->aux->func_idx].type_id);
 		func_name = btf_name_by_offset(prog->aux->btf, type->name_off);
@@ -1208,7 +1208,7 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 		if (!extra_pass)
 			addr = NULL;
 		else if (prog->aux->func &&
-			 off >= 0 && off < prog->aux->func_cnt)
+			 off >= 0 && off < prog->aux->real_func_cnt)
 			addr = (u8 *)prog->aux->func[off]->bpf_func;
 		else
 			return -EINVAL;
@@ -2721,7 +2721,7 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 #endif
 	if (aux->dst_trampoline)
 		bpf_trampoline_put(aux->dst_trampoline);
-	for (i = 0; i < aux->func_cnt; i++) {
+	for (i = 0; i < aux->real_func_cnt; i++) {
 		/* We can just unlink the subprog poke descriptor table as
 		 * it was originally linked to the main program and is also
 		 * released along with it.
@@ -2729,7 +2729,7 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 		aux->func[i]->aux->poke_tab = NULL;
 		bpf_jit_free(aux->func[i]);
 	}
-	if (aux->func_cnt) {
+	if (aux->real_func_cnt) {
 		kfree(aux->func);
 		bpf_prog_unlock_free(aux->prog);
 	} else {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7f4e8c357a6a..d90f5001da83 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2746,7 +2746,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	 * period before we can tear down JIT memory since symbols
 	 * are already exposed under kallsyms.
 	 */
-	__bpf_prog_put_noref(prog, prog->aux->func_cnt);
+	__bpf_prog_put_noref(prog, prog->aux->real_func_cnt);
 	return err;
 free_prog_sec:
 	free_uid(prog->aux->user);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4ccca1f6c998..ed90e22d7600 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15108,7 +15108,8 @@ static void adjust_btf_func(struct bpf_verifier_env *env)
 	if (!aux->func_info)
 		return;
 
-	for (i = 0; i < env->subprog_cnt; i++)
+	/* func_info is not available for hidden subprogs */
+	for (i = 0; i < env->subprog_cnt - env->hidden_subprog_cnt; i++)
 		aux->func_info[i].insn_off = env->subprog_info[i].start;
 }
 
@@ -18053,7 +18054,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		 * the call instruction, as an index for this list
 		 */
 		func[i]->aux->func = func;
-		func[i]->aux->func_cnt = env->subprog_cnt;
+		func[i]->aux->func_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
+		func[i]->aux->real_func_cnt = env->subprog_cnt;
 	}
 	for (i = 0; i < env->subprog_cnt; i++) {
 		old_bpf_func = func[i]->bpf_func;
@@ -18099,7 +18101,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	prog->aux->extable = func[0]->aux->extable;
 	prog->aux->num_exentries = func[0]->aux->num_exentries;
 	prog->aux->func = func;
-	prog->aux->func_cnt = env->subprog_cnt;
+	prog->aux->func_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
+	prog->aux->real_func_cnt = env->subprog_cnt;
 	bpf_prog_jit_attempt_done(prog);
 	return 0;
 out_free:
@@ -18307,6 +18310,33 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
+/* The function requires that first instruction in 'patch' is insnsi[prog->len - 1] */
+static __maybe_unused int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *patch, int len)
+{
+	struct bpf_subprog_info *info = env->subprog_info;
+	int cnt = env->subprog_cnt;
+	struct bpf_prog *prog;
+
+	/* We only reserve one slot for hidden subprogs in subprog_info. */
+	if (env->hidden_subprog_cnt) {
+		verbose(env, "verifier internal error: only one hidden subprog supported\n");
+		return -EFAULT;
+	}
+	/* We're not patching any existing instruction, just appending the new
+	 * ones for the hidden subprog. Hence all of the adjustment operations
+	 * in bpf_patch_insn_data are no-ops.
+	 */
+	prog = bpf_patch_insn_data(env, env->prog->len - 1, patch, len);
+	if (!prog)
+		return -ENOMEM;
+	env->prog = prog;
+	info[cnt + 1].start = info[cnt].start;
+	info[cnt].start = prog->len - len + 1;
+	env->subprog_cnt++;
+	env->hidden_subprog_cnt++;
+	return 0;
+}
+
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
-- 
2.41.0


