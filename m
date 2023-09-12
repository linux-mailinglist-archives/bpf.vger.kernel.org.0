Return-Path: <bpf+bounces-9827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DED579DCAB
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9414D1C21398
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3251400E;
	Tue, 12 Sep 2023 23:32:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0749017C2
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:20 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0577F10FF
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id ffacd0b85a97d-31c6d17aec4so6107237f8f.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561538; x=1695166338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fOfWa2tmL8t6EH3saX0Z0ggyM4Di2cdRmBbwAqkfyk=;
        b=qPPRishCaidTLj6eKgXHgLU6KajK913VGvCq3p+ySUsemjX8u3t1C0VJ/4cIaoNdEE
         JutnnRQe6kTpuQKW+eHoa5JqYW9UcxWg9J3hpWDqibxwi3EPhK79MKJjIP+fR63sg4DS
         xiJincs/vGG/GjxqP/8sw782fo4xaivrCVNxzA/R6B/tEroWXjj0k+ELgEVgVbaR6xO6
         WamoTQZqogS2EtRJy2Nn+xpqoe37VSaYCwbdrLK+PndA3i9EbRlFVXUwxcbe19mF6bD+
         xb8tN2x6AaqbYqTF8rDQBvcsidW/ggDMMw1sJL7yr3aS94IbTBCuymgBGaBkQOCStiTn
         kttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561538; x=1695166338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fOfWa2tmL8t6EH3saX0Z0ggyM4Di2cdRmBbwAqkfyk=;
        b=vCAUHb+A6LEPEsAfQFG1IyMiIVo+o+lT9kE9beQZQb0f8R9KMRYjIb2iK6QSCl2rxn
         7meIQAZj4TIxYO0V2ltDA/mA56a9d+I+Hth6NwbaVLB2Fl/mvUg/HMfXyxzR6Yvwt9QW
         gNTezeuQz2f0iJIZfBUTS7Qe1D+6AK3Kuqger/us4qk+lKfXNAosKoZ85jBV6ZSz7eJs
         Jqh2AVq5v7go0twMRn3WHcL5/YPXlhl6p/tj2QEMBlCBp+sd+vjorhuP7PQWPcuiIfBr
         G8HscjClo8h0cJp/VkMC8eDL4sHkA8vOS9HYQVeUv6voKJfYHI3LrecWmwcdcyfrIiuA
         dqdQ==
X-Gm-Message-State: AOJu0Yzfz4wcj4hrhiSr6uORIWou9Vn1jymLlmX3ySi06jzmaKfcsqlf
	XMr/cySUAe/zvC2FOfAbKK3XyEf9tf9yGg==
X-Google-Smtp-Source: AGHT+IHknOJTnoJd4b1Sq1Rj5m7sOTA1uPpiGYA337JJFHfK70Y6vShIU3tPSaBO5Ada6WLZIBSfkg==
X-Received: by 2002:adf:d4c1:0:b0:31f:a277:4cde with SMTP id w1-20020adfd4c1000000b0031fa2774cdemr700068wrk.43.1694561538254;
        Tue, 12 Sep 2023 16:32:18 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id u12-20020aa7d98c000000b0052a1d98618bsm6506825eds.54.2023.09.12.16.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:18 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 03/17] bpf: Implement support for adding hidden subprogs
Date: Wed, 13 Sep 2023 01:32:00 +0200
Message-ID: <20230912233214.1518551-4-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
References: <20230912233214.1518551-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8798; i=memxor@gmail.com; h=from:subject; bh=taTmdIM29si9oEtx177zT6xSGvloeVryMsABiMpFttI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlAPSs97mBFCvOHPHvSPjInht5snikqcS62KUx5 kYrP9VSjeWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQD0rAAKCRBM4MiGSL8R ytIbEACfpLni0II7Kn8DVhAWl/ug3O069hXn+ypUEKbcs8x9/JYUyerctHPtuc+85HJjWL2JyFN kmuX6bFwDs2f6eOTcCSxnVzaP2dmZhwCv3jgnVGUOcVDKfzGRXUB0NMaivXrtV5bwTiN6aqydbZ ndhSMum/nVFPu/VR9EbRtB8SV7dpbgHw7A9IoeBBIAiCs6HXm6Bk+BH0oS5SA6A9QUE9zQF+s5Q Fs+9J5OJL9Mq4u4Te3SswHzCc/LfRwy6kKjcj9o4uemTT3pmOU5qWiGiRnG5Ub8girxvZS2ibl9 4Q9Sf2qDxAKfRNd/seGPq7v+LQEkjy0chp8XkZgvpuBOB+bE14xasIs9Ieem8TyK84DV4hMWPOs OF+UpOwr1xSbNZcx78Q3DmCWloYKhBVwl8eV1CnWqXzZ53S62gp5yWh7EvEouyhwYDo5X8LaeeP tme255mjd8H8n1hTIKlBr1y/NnF82LjAV1Dz/neWeq37dc9RULPsx7dWvGLHc/xI9Ec69veTI+e joaRghkW7mJTPvyYCjHTRUgZi6XCyjFKXbasXRoyD3cIr6xxM4w3RXm8NEor7bU435WP3hw+oQ3 D5DrHsAAruI/oNQSPGhyvAmTeb8k1wfNGdYXubxKWAGBikNMUM8qMs/3AdYmO6uWfY8gof2pq6H AR+5Eusi5N7CmHw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

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
index 9171b0b6a590..c3667e95af59 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1389,6 +1389,7 @@ struct bpf_prog_aux {
 	u32 stack_depth;
 	u32 id;
 	u32 func_cnt; /* used by non-func prog as the number of func progs */
+	u32 real_func_cnt; /* includes hidden progs, only used for JIT and freeing progs */
 	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
 	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
 	u32 ctx_arg_info_size;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a3236651ec64..3c2a8636ab29 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -588,6 +588,7 @@ struct bpf_verifier_env {
 	u32 used_map_cnt;		/* number of used maps */
 	u32 used_btf_cnt;		/* number of used BTF objects */
 	u32 id_gen;			/* used to generate unique reg IDs */
+	u32 hidden_subprog_cnt;		/* number of hidden subprogs */
 	bool explore_alu_limits;
 	bool allow_ptr_leaks;
 	bool allow_uninit_stack;
@@ -598,7 +599,7 @@ struct bpf_verifier_env {
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
-	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 1];
+	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 for the fake and exception subprogs */
 	union {
 		struct bpf_idmap idmap_scratch;
 		struct bpf_idset idset_scratch;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c4ac084f2767..840ba952702d 100644
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
index 6a692f3bea15..85c1d908f70f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2749,7 +2749,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	 * period before we can tear down JIT memory since symbols
 	 * are already exposed under kallsyms.
 	 */
-	__bpf_prog_put_noref(prog, prog->aux->func_cnt);
+	__bpf_prog_put_noref(prog, prog->aux->real_func_cnt);
 	return err;
 free_prog_sec:
 	free_uid(prog->aux->user);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 18e673c0ac15..39548e326d53 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15210,7 +15210,8 @@ static void adjust_btf_func(struct bpf_verifier_env *env)
 	if (!aux->func_info)
 		return;
 
-	for (i = 0; i < env->subprog_cnt; i++)
+	/* func_info is not available for hidden subprogs */
+	for (i = 0; i < env->subprog_cnt - env->hidden_subprog_cnt; i++)
 		aux->func_info[i].insn_off = env->subprog_info[i].start;
 }
 
@@ -18151,7 +18152,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		 * the call instruction, as an index for this list
 		 */
 		func[i]->aux->func = func;
-		func[i]->aux->func_cnt = env->subprog_cnt;
+		func[i]->aux->func_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
+		func[i]->aux->real_func_cnt = env->subprog_cnt;
 	}
 	for (i = 0; i < env->subprog_cnt; i++) {
 		old_bpf_func = func[i]->bpf_func;
@@ -18197,7 +18199,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	prog->aux->extable = func[0]->aux->extable;
 	prog->aux->num_exentries = func[0]->aux->num_exentries;
 	prog->aux->func = func;
-	prog->aux->func_cnt = env->subprog_cnt;
+	prog->aux->func_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
+	prog->aux->real_func_cnt = env->subprog_cnt;
 	bpf_prog_jit_attempt_done(prog);
 	return 0;
 out_free:
@@ -18433,6 +18436,33 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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


