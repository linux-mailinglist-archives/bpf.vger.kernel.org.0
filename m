Return-Path: <bpf+bounces-67683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 174C7B4812D
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 01:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF19189EE98
	for <lists+bpf@lfdr.de>; Sun,  7 Sep 2025 23:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DBA231A3B;
	Sun,  7 Sep 2025 23:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rd3HJtJt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188152236EB
	for <bpf@vger.kernel.org>; Sun,  7 Sep 2025 23:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757286275; cv=none; b=NWpgxxYxivkzwWzWdma5OI7/iFjNmpvhZYKMqOpR1mS2LcJ7I2joF0xtZzHcgzmUvWhrZiAjYMOOf7Q5/kKo4Kpca2coouwo6B618E1EG9NfikN+Revn2gMwKJVyzD33KAZAapc61OVmhIuzaivIFcfO6qnRjlHtkcgPSbR8SIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757286275; c=relaxed/simple;
	bh=6/74q4qUxhm2ELHmjmSLgP6nRI7k0a7rywQXeQzGLTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sb2MQgN453OGAE+V0jOhW6IGmBa/Uiax8b+Y13cYLyP7PmKhqRi7ZH9Es5rrHFEGYwNBUhl9YkrPdhvS8+okMrsudNGGhVfIDbe1IVNONf3gWUKFAQiQTPQJiGVJbaT1O6n/55zW+X4pekY5Ig67s6oQ0fKy5HNan8eLBPaZGhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rd3HJtJt; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4c738ee2fbso3005476a12.3
        for <bpf@vger.kernel.org>; Sun, 07 Sep 2025 16:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757286273; x=1757891073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl/5x5+d2VMj2AmeBnSV78Zj1+WhxLXoMFjHLBsRJE0=;
        b=Rd3HJtJtHVRpsgRzKcLFN+NeRqXRd22ZsfbAGnPrnqAw94yCWFXGVbu0rgXdTZ/nP/
         mFU2f96z4t/e/FurLZglz3SO+dGQExKl9xs2TH+1j2YZgj9YGfCKLLQ4s7v3MX/mCrPn
         ELsDUrZ8KeL1akb5KxNpfHWuUH1ZZguzFBe8TIsEJHcaF2whE0QxixKKaKpAfDGtQNl4
         jrOWXubq/iQe2LTECJI1QndUTTDDz9hwb6VjX6P+vLkBJBSNr2AQE81kgypJVfh2tdpW
         uUK5x1IyjNDjBqxtmoOok+Nf7G7Pto8H5lB6OCLBGmI9LenM41weDn2qLav/X+E87N4r
         yIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757286273; x=1757891073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dl/5x5+d2VMj2AmeBnSV78Zj1+WhxLXoMFjHLBsRJE0=;
        b=ZGwxhlfuJGHWPYlTsA4C+4YrUGQI7tCE04VW8+HCVQY+J8BsxTV8VrUkQvlkikRJOK
         P2njRpLUSKw5sbeyP4F5WJDyM+DcteU4t1RVYko+PGe3bFVdIoP4Wg1OWXSN3bX/shTB
         pkVnoggwXG1rYtFZmTIqeXHDOZRpp7ad+Lyu1/h3L2PQn/6dTm4/+PHnkS3vzQzcffuK
         A3vlrDjH7nAIhCyEr13h71NhDx8yduSvSY6A9W8Cb5HKlfuv2hipLDwLpKt40tRFwSpA
         n9tcruCpI1z/k5Hr358Um+myAFSnoU2eIzeEEyRVFKBEOG1P2/7YVtLaujorVs5xLLRH
         N+Iw==
X-Gm-Message-State: AOJu0YwOznlIWat7jDd0c6Q5dKwNDjvOyIVGr2nRZYLoDCDi6J2ObE1d
	ViBFwhzXEDj6UV/DD/cWDgBQiNXL6+9XJitW/+6VNvMlXV1vH7B5T+s9eqp/6ZfK
X-Gm-Gg: ASbGncu4x2vlj1nSctDEJioLmNz7hxNmqOcdhtgKZ1WTL2kbzD6NYwAI8WlywmhQAEr
	0wUT6BSgcMz4oe45K8B0RvUiw5A5y3KdtlBZXDt/DSvVb2ChnVkomc+hfazJ6Xg/WvraQclvs9B
	fsdSLmTTYvG+Pu0uBTj7BaBoLZqcvLDoIvB9vW+ihEuicjJEIagB1FMeVxRdpgtfg+BTZOApXCr
	SQQ72NUyV1VdNZLHh0td0lgMzG9FwiaHw6KukOWKClpmUOsdT8s8YeV6nrwvzxtPd8REOz1fFAM
	/Y0lDHFs/FWDRADr85NK4g3jrl8mc0yRr8cbiPD13v2LGbPGC2GsSsFTj9qRy/+V+Xxt6Noi5uv
	ypXkchmeCun8ji4Xp8Lqsj0KsXfLGL+iiJJUE6mSpfwv8FfTJQJyEPnMsROjbrguuDIQzql9ku2
	xbG+ZkxHNeiQOiI/6mvVw/
X-Google-Smtp-Source: AGHT+IFJrTd/3WgA5G3RSj5vnqv20GNu5gNrDb1G2KnKtOXeWu465ojHHj0jMIdUcBNR+DgL5Tc6pg==
X-Received: by 2002:a17:902:f711:b0:240:1850:cb18 with SMTP id d9443c01a7336-251755cab1fmr74796045ad.53.1757286273026;
        Sun, 07 Sep 2025 16:04:33 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24caf245690sm111254675ad.10.2025.09.07.16.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 16:04:32 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	djwillia@vt.edu,
	miloc@vt.edu,
	ericts@vt.edu,
	rahult@vt.edu,
	doniaghazy@vt.edu,
	quanzhif@vt.edu,
	jinghao7@illinois.edu,
	sidchintamaneni@gmail.com,
	memxor@gmail.com,
	egor@vt.edu,
	sairoop10@gmail.com,
	rjsu26@gmail.com
Subject: [PATCH 2/4] bpf: Creating call sites table to stub instructions during runtime
Date: Sun,  7 Sep 2025 23:04:13 +0000
Message-ID: <20250907230415.289327-3-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250907230415.289327-1-sidchintamaneni@gmail.com>
References: <20250907230415.289327-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create callsites tables and store jit indexes of RET_NULL calls
to poke them later with dummy functions. Additional to jit indexes,
meta data about helpers/kfuncs/loops is stored. Later this could
be extended to remaining potential long running iterator helpers/kfuncs.

Signed-off-by: Raj Sahu <rjsu26@gmail.com>
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c  |   9 +++
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/core.c            |   5 +-
 kernel/bpf/verifier.c        | 135 +++++++++++++++++++++++++++++++----
 4 files changed, 137 insertions(+), 13 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 7e3fca164620..107a44729675 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3733,6 +3733,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 
 	if (!image || !prog->is_func || extra_pass) {
+		
+		if (addrs) {
+			struct bpf_term_patch_call_sites *patch_call_sites = prog->term_states->patch_call_sites;
+			for (int i = 0; i < patch_call_sites->call_sites_cnt; i++) {
+				struct call_aux_states *call_states = patch_call_sites->call_states + i;
+				call_states->jit_call_idx = addrs[call_states->call_bpf_insn_idx];
+			}
+		}
+		
 		if (image)
 			bpf_prog_fill_jited_linfo(prog, addrs + 1);
 out_addrs:
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 020de62bd09c..2c8bfde8191a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -677,6 +677,7 @@ struct bpf_subprog_info {
 	bool is_cb: 1;
 	bool is_async_cb: 1;
 	bool is_exception_cb: 1;
+	bool is_bpf_loop_cb_non_inline: 1;
 	bool args_cached: 1;
 	/* true if bpf_fastcall stack region is used by functions that can't be inlined */
 	bool keep_fastcall_stack: 1;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 740b5a3a6b55..93442ab2acde 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -136,6 +136,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	fp->term_states = term_states;
 	fp->term_states->patch_call_sites = patch_call_sites;
 	fp->term_states->patch_call_sites->call_sites_cnt = 0;
+	fp->term_states->patch_call_sites->call_states = NULL;
 	fp->term_states->prog = fp;
 
 #ifdef CONFIG_CGROUP_BPF
@@ -314,8 +315,10 @@ void __bpf_prog_free(struct bpf_prog *fp)
 		kfree(fp->aux);
 	}
 	if (fp->term_states) {
-		if (fp->term_states->patch_call_sites)
+		if (fp->term_states->patch_call_sites) {
+			vfree(fp->term_states->patch_call_sites->call_states);
 			kfree(fp->term_states->patch_call_sites);
+		}
 		kfree(fp->term_states);
 	}
 	free_percpu(fp->stats);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b9394f8fac0e..1d27208e1078 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3491,6 +3491,7 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 	 * logic. 'subprog_cnt' should not be increased.
 	 */
 	subprog[env->subprog_cnt].start = insn_cnt;
+	subprog[env->subprog_cnt].is_bpf_loop_cb_non_inline = false;
 
 	if (env->log.level & BPF_LOG_LEVEL2)
 		for (i = 0; i < env->subprog_cnt; i++)
@@ -11319,19 +11320,30 @@ static bool loop_flag_is_zero(struct bpf_verifier_env *env)
 static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
 {
 	struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
+	struct bpf_subprog_info *prev_info, *info = subprog_info(env, subprogno);
 
 	if (!state->initialized) {
 		state->initialized = 1;
 		state->fit_for_inline = loop_flag_is_zero(env);
 		state->callback_subprogno = subprogno;
+		if (!state->fit_for_inline)
+			info->is_bpf_loop_cb_non_inline = 1;
 		return;
 	}
 
-	if (!state->fit_for_inline)
+	if (!state->fit_for_inline) {
+		info->is_bpf_loop_cb_non_inline = 1;
 		return;
+	}
 
 	state->fit_for_inline = (loop_flag_is_zero(env) &&
 				 state->callback_subprogno == subprogno);
+
+	if (state->callback_subprogno != subprogno) {
+		info->is_bpf_loop_cb_non_inline = 1;
+		prev_info = subprog_info(env, state->callback_subprogno);
+		prev_info->is_bpf_loop_cb_non_inline = 1;
+	}
 }
 
 /* Returns whether or not the given map type can potentially elide
@@ -21120,6 +21132,9 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	int i, patch_len, delta = 0, len = env->prog->len;
 	struct bpf_insn *insns = env->prog->insnsi;
 	struct bpf_prog *new_prog;
+	struct bpf_term_aux_states *term_states = env->prog->term_states;
+	u32 call_sites_cnt = term_states->patch_call_sites->call_sites_cnt;
+	struct call_aux_states *call_states = term_states->patch_call_sites->call_states;
 	bool rnd_hi32;
 
 	rnd_hi32 = attr->prog_flags & BPF_F_TEST_RND_HI32;
@@ -21205,6 +21220,15 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 		insns = new_prog->insnsi;
 		aux = env->insn_aux_data;
 		delta += patch_len - 1;
+
+		/* Adust call instruction offsets
+		 * w.r.t adj_idx
+		 */
+		for (int iter = 0; iter < call_sites_cnt; iter++) {
+			if (call_states[iter].call_bpf_insn_idx < adj_idx)
+				continue;
+			call_states[iter].call_bpf_insn_idx += patch_len - 1;
+		}
 	}
 
 	return 0;
@@ -21597,6 +21621,26 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
 		func[i]->aux->size_poke_tab = prog->aux->size_poke_tab;
+		func[i]->aux->is_bpf_loop_cb_non_inline = env->subprog_info[i].is_bpf_loop_cb_non_inline;
+
+		if (prog->term_states->patch_call_sites->call_sites_cnt != 0) {
+			int call_sites_cnt = 0;
+			struct call_aux_states *func_call_states;
+			func_call_states = vzalloc(sizeof(*func_call_states) * len);
+			if (!func_call_states)
+				goto out_free;
+			for (int iter = 0; iter < prog->term_states->patch_call_sites->call_sites_cnt; iter++) {
+				struct call_aux_states call_states = prog->term_states->patch_call_sites->call_states[iter];
+				if (call_states.call_bpf_insn_idx >= subprog_start
+						&& call_states.call_bpf_insn_idx < subprog_end) {
+					func_call_states[call_sites_cnt] = call_states;
+					func_call_states[call_sites_cnt].call_bpf_insn_idx -= subprog_start;
+					call_sites_cnt++;
+				}
+			}
+			func[i]->term_states->patch_call_sites->call_sites_cnt = call_sites_cnt;
+			func[i]->term_states->patch_call_sites->call_states = func_call_states;
+		}
 
 		for (j = 0; j < prog->aux->size_poke_tab; j++) {
 			struct bpf_jit_poke_descriptor *poke;
@@ -21886,15 +21930,21 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 }
 
 static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
+			    struct bpf_insn *insn_buf, int insn_idx, int *cnt, int *kfunc_btf_id)
 {
 	const struct bpf_kfunc_desc *desc;
+	struct bpf_kfunc_call_arg_meta meta;
+	int err;
 
 	if (!insn->imm) {
 		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
 		return -EINVAL;
 	}
 
+	err = fetch_kfunc_meta(env, insn, &meta, NULL);
+	if (err)
+		return err;
+
 	*cnt = 0;
 
 	/* insn->imm has the btf func_id. Replace it with an offset relative to
@@ -21908,8 +21958,11 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 	}
 
-	if (!bpf_jit_supports_far_kfunc_call())
+	if (!bpf_jit_supports_far_kfunc_call()) {
+		if (meta.kfunc_flags & KF_RET_NULL)
+			*kfunc_btf_id = insn->imm;
 		insn->imm = BPF_CALL_IMM(desc->addr);
+	}
 	if (insn->off)
 		return 0;
 	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
@@ -22019,6 +22072,13 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 	return 0;
 }
 
+static bool is_bpf_loop_call(struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_CALL) &&
+		insn->src_reg == 0 &&
+		insn->imm == BPF_FUNC_loop;
+}
+
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
@@ -22039,6 +22099,12 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	struct bpf_subprog_info *subprogs = env->subprog_info;
 	u16 stack_depth = subprogs[cur_subprog].stack_depth;
 	u16 stack_depth_extra = 0;
+	u32 call_sites_cnt = 0;
+	struct call_aux_states *call_states;
+
+	call_states = vzalloc(sizeof(*call_states) * prog->len);
+	if (!call_states)
+		return -ENOMEM;
 
 	if (env->seen_exception && !env->exception_callback_subprog) {
 		struct bpf_insn *patch = insn_buf;
@@ -22368,11 +22434,12 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (insn->src_reg == BPF_PSEUDO_CALL)
 			goto next_insn;
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
-			ret = fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
+			int kfunc_btf_id = 0;
+			ret = fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt, &kfunc_btf_id);
 			if (ret)
 				return ret;
 			if (cnt == 0)
-				goto next_insn;
+				goto store_call_indices;
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
@@ -22381,6 +22448,12 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta	 += cnt - 1;
 			env->prog = prog = new_prog;
 			insn	  = new_prog->insnsi + i + delta;
+store_call_indices:
+			if (kfunc_btf_id != 0) {
+				call_states[call_sites_cnt].call_bpf_insn_idx = i + delta;
+				call_states[call_sites_cnt].is_helper_kfunc = 1;
+				call_sites_cnt++;
+			}
 			goto next_insn;
 		}
 
@@ -22859,6 +22932,15 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 				     func_id_name(insn->imm), insn->imm);
 			return -EFAULT;
 		}
+
+		if ((fn->ret_type & PTR_MAYBE_NULL) || is_bpf_loop_call(insn)) {
+			call_states[call_sites_cnt].call_bpf_insn_idx = i + delta;	
+			if (is_bpf_loop_call(insn))
+				call_states[call_sites_cnt].is_bpf_loop = 1;
+			else
+				call_states[call_sites_cnt].is_helper_kfunc = 1;
+			call_sites_cnt++;
+		}
 		insn->imm = fn->func - __bpf_call_base;
 next_insn:
 		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
@@ -22879,6 +22961,8 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		insn++;
 	}
 
+	env->prog->term_states->patch_call_sites->call_sites_cnt = call_sites_cnt;
+	env->prog->term_states->patch_call_sites->call_states = call_states;
 	env->prog->aux->stack_depth = subprogs[0].stack_depth;
 	for (i = 0; i < env->subprog_cnt; i++) {
 		int delta = bpf_jit_supports_timed_may_goto() ? 2 : 1;
@@ -23014,17 +23098,12 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 	call_insn_offset = position + 12;
 	callback_offset = callback_start - call_insn_offset - 1;
 	new_prog->insnsi[call_insn_offset].imm = callback_offset;
+	/* Marking offset field to identify loop cb */
+	new_prog->insnsi[call_insn_offset].off = 0x1;
 
 	return new_prog;
 }
 
-static bool is_bpf_loop_call(struct bpf_insn *insn)
-{
-	return insn->code == (BPF_JMP | BPF_CALL) &&
-		insn->src_reg == 0 &&
-		insn->imm == BPF_FUNC_loop;
-}
-
 /* For all sub-programs in the program (including main) check
  * insn_aux_data to see if there are bpf_loop calls that require
  * inlining. If such calls are found the calls are replaced with a
@@ -24584,6 +24663,35 @@ static int compute_scc(struct bpf_verifier_env *env)
 	return err;
 }
 
+static int fix_call_sites(struct bpf_verifier_env *env)
+{
+	int err = 0, i, subprog;
+	struct bpf_insn *insn;
+	struct bpf_prog *prog = env->prog;
+	struct bpf_term_aux_states *term_states = env->prog->term_states;
+	u32 *call_sites_cnt = &term_states->patch_call_sites->call_sites_cnt;
+	struct call_aux_states *call_states = term_states->patch_call_sites->call_states;
+
+	if (!env->subprog_cnt)
+		return 0;
+	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
+		if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
+			continue;
+
+		subprog = find_subprog(env, i + insn->imm + 1);
+		if (subprog < 0)
+			return -EFAULT;
+
+		if (insn->off == 0x1) {
+			call_states[*call_sites_cnt].call_bpf_insn_idx = i;
+			call_states[*call_sites_cnt].is_bpf_loop_cb_inline = 1;
+			*call_sites_cnt = *call_sites_cnt + 1;
+			prog->insnsi[i].off = 0x0; /* Removing the marker */
+		}
+	}
+	return err;
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
 	u64 start_time = ktime_get_ns();
@@ -24769,6 +24877,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 								     : false;
 	}
 
+	if (ret == 0)
+		ret = fix_call_sites(env);
+
 	if (ret == 0)
 		ret = fixup_call_args(env);
 
-- 
2.43.0


