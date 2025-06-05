Return-Path: <bpf+bounces-59810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF9EACF9E6
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 01:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569A416ED7D
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 23:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2E527FB3C;
	Thu,  5 Jun 2025 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTy4PrYp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595ED27C16A
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749164787; cv=none; b=fyUt96NVa5mcoadQ01/byv2I/D2W0nztkRybpXaPdkpB1BhK2B5QxCnNfvFBiGPKrM6TtnjxB5dGiFik6Mgi1aGLPodDK16sSP9czvcLQwAjQiA2uPvQ90ZFCUcMFMvNl7N6iRczhW3Q0zsce1BRHS+XbxVa3PnGUqnmvG/Cc1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749164787; c=relaxed/simple;
	bh=VhVmK93qMOCfM+/l6V3JoO2CYo6wVbZ9pbORtOqaoKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdmPso5kwOdNV+hQw/hnC5l2vDi8QkblfjaDX7kJftF8mh8SQ9MJOH703tW9TYPOIDtv3ZnzJ2U363i2o/iOjJ6k78oNBGQHmrjyKpkQMAEtrYAWMNW/YxervfP6ovjxrAklElii+1NzA4kphAi1FFxpgjuI4jD/aTKp/0Wl5hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTy4PrYp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234b440afa7so16027165ad.0
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 16:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749164784; x=1749769584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5JsImy9coVDLiyefPBg5JeIM2qwigf12lTk6nfs13s=;
        b=kTy4PrYpgLtMU226HYOm3TncsZ4rQc4odzuGRT+LW55nVTJ7muNaRa3AQxosY+6nPz
         ow9zdqxDpfF30EvvYMASpUAz1xU1V3rfKUyL96KRvcAxgOlCJfKgfsXD7XOY3LcIcodl
         4k3dLpWyQULm3EbysA5pMGQr5BlhXpVT6hDB0h4iVg5qv+bvodIdx2pzPVMQMT4oAwx9
         MN0XfTEDaBSWps2y1tgEj8Yk7da/CXEP0pAKl6hJhHMRkfUXRt00zF8fJxhG0cYpUkEH
         acrxTGTXQ+AiZn49k48JkRj0Cx1pDEqC0TLDQ9xes9NhHL+pAAVOL6HauuKEtJXIeWDE
         a+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749164784; x=1749769584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5JsImy9coVDLiyefPBg5JeIM2qwigf12lTk6nfs13s=;
        b=owatJr8+MWaEn105y1Nqg9ddyR+xaLnnAbgY2mPO9eujwjXSiZ2KcP6ZtOe8ekbmqb
         fU48Ajx8ss2Lgm/mpcdyUsV3uEtZFTyOLEbzNudi/SylswrGHgDWV6S+/c5fWR4+IXQG
         RkzLl8XhZGWMZriEVr5uQyzzcxAPJIcfV+tsNjh+CiJyB5H0uYdQEKPCMnHf4hkaLyEk
         E0ugBHFl4f0sbu7Z+8Wn1EEtuRrpCd3T6LEscZsWM9sKyd82yrvgMp0RX42JKpw2pEs6
         smBd2IptGLGXzBIX8/RS9hoj+yiS64Lkb+WzA35Qd9iN6nWK9R3WUOWKPRHAF0po8FIS
         bl5g==
X-Gm-Message-State: AOJu0YydassC5y+NM4dwQbeIEI0jqlpHM5isIyizMfqil7gUVu5NbVsz
	QWQpVqwalQmhlTW6CmIdLNuoAnPhxWP0L2tAUW1+b0ssOmfwMCoTQGy2+Ztqt+f0ruY=
X-Gm-Gg: ASbGncuKBPL1T1z1MP0qlplqxiH8N7NZtrbSNbaSzBGJ2ZcIMaHW1lzL1bBRJB3B6ot
	P1qNwtCUQzvTdkUVy80qNgfv1QiRnhkFVFneefFxSb7mjqySEYVsa1OLxd6d6G5RXTYVvB5x1Hh
	VNWmKpIISidI3lWaHNJoo5Inlmo51KhxJ07FqLrbfnrQ4ybnUuL4BhJbv0u2duh55YWD9Oyso4V
	R3RX21CNfx/YetL7U7ozBN3BSLPUhQhWeCYxr/CAoDV6nTgIC+kxMA/lJZ/MOotoH6rsOdS40Cn
	nScTDSu/evMbKYD+XilNn5pTvxuDVDY6BK8Q0SSZk4RewBbxVHnxqmYRng==
X-Google-Smtp-Source: AGHT+IF413OiRAOKzYlq+A+L0wayKA8tIHl+SY3UTZy6tKinWXePH8Mpqc8G76Vh8QHdW74yDNr3wQ==
X-Received: by 2002:a17:902:ecc8:b0:234:8a16:d62b with SMTP id d9443c01a7336-23601cfb634mr14806955ad.12.1749164784419;
        Thu, 05 Jun 2025 16:06:24 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092635sm1305655ad.81.2025.06.05.16.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 16:06:24 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 1/2] bpf: include verifier memory allocations in memcg statistics
Date: Thu,  5 Jun 2025 16:06:08 -0700
Message-ID: <20250605230609.1444980-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250605230609.1444980-1-eddyz87@gmail.com>
References: <20250605230609.1444980-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds __GFP_ACCOUNT flag to verifier induced memory
allocations. The intent is to account for all allocations reachable
from BPF_PROG_LOAD command, which is needed to track verifier memory
consumption in veristat. This includes allocations done in verifier.c,
and some allocations in btf.c, functions in log.c do not allocate.

There is also a utility function bpf_memcg_flags() which selectively
adds GFP_ACCOUNT flag depending on the `cgroup.memory=nobpf` option.
As far as I understand [1], the idea is to remove bpf_prog instances
and maps from memcg accounting as these objects do not strictly belong
to cgroup, hence it should not apply here.

(btf_parse_fields() is reachable from both program load and map
 creation, but allocated record is not persistent as is freed as soon
 as map_check_btf() exits).

[1] https://lore.kernel.org/all/20230210154734.4416-1-laoar.shao@gmail.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/btf.c      | 15 ++++++-------
 kernel/bpf/verifier.c | 49 ++++++++++++++++++++++---------------------
 2 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1d2cf898e21e..682acb1ed234 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3443,7 +3443,8 @@ btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
 	node_field_name = strstr(value_type, ":");
 	if (!node_field_name)
 		return -EINVAL;
-	value_type = kstrndup(value_type, node_field_name - value_type, GFP_KERNEL | __GFP_NOWARN);
+	value_type = kstrndup(value_type, node_field_name - value_type,
+			      GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!value_type)
 		return -ENOMEM;
 	id = btf_find_by_name_kind(btf, value_type, BTF_KIND_STRUCT);
@@ -3958,7 +3959,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	/* This needs to be kzalloc to zero out padding and unused fields, see
 	 * comment in btf_record_equal.
 	 */
-	rec = kzalloc(struct_size(rec, fields, cnt), GFP_KERNEL | __GFP_NOWARN);
+	rec = kzalloc(struct_size(rec, fields, cnt), GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!rec)
 		return ERR_PTR(-ENOMEM);
 
@@ -9019,7 +9020,7 @@ static struct bpf_cand_cache *populate_cand_cache(struct bpf_cand_cache *cands,
 		bpf_free_cands_from_cache(*cc);
 		*cc = NULL;
 	}
-	new_cands = kmemdup(cands, sizeof_cands(cands->cnt), GFP_KERNEL);
+	new_cands = kmemdup(cands, sizeof_cands(cands->cnt), GFP_KERNEL_ACCOUNT);
 	if (!new_cands) {
 		bpf_free_cands(cands);
 		return ERR_PTR(-ENOMEM);
@@ -9027,7 +9028,7 @@ static struct bpf_cand_cache *populate_cand_cache(struct bpf_cand_cache *cands,
 	/* strdup the name, since it will stay in cache.
 	 * the cands->name points to strings in prog's BTF and the prog can be unloaded.
 	 */
-	new_cands->name = kmemdup_nul(cands->name, cands->name_len, GFP_KERNEL);
+	new_cands->name = kmemdup_nul(cands->name, cands->name_len, GFP_KERNEL_ACCOUNT);
 	bpf_free_cands(cands);
 	if (!new_cands->name) {
 		kfree(new_cands);
@@ -9111,7 +9112,7 @@ bpf_core_add_cands(struct bpf_cand_cache *cands, const struct btf *targ_btf,
 			continue;
 
 		/* most of the time there is only one candidate for a given kind+name pair */
-		new_cands = kmalloc(sizeof_cands(cands->cnt + 1), GFP_KERNEL);
+		new_cands = kmalloc(sizeof_cands(cands->cnt + 1), GFP_KERNEL_ACCOUNT);
 		if (!new_cands) {
 			bpf_free_cands(cands);
 			return ERR_PTR(-ENOMEM);
@@ -9228,7 +9229,7 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 	/* ~4k of temp memory necessary to convert LLVM spec like "0:1:0:5"
 	 * into arrays of btf_ids of struct fields and array indices.
 	 */
-	specs = kcalloc(3, sizeof(*specs), GFP_KERNEL);
+	specs = kcalloc(3, sizeof(*specs), GFP_KERNEL_ACCOUNT);
 	if (!specs)
 		return -ENOMEM;
 
@@ -9253,7 +9254,7 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 			goto out;
 		}
 		if (cc->cnt) {
-			cands.cands = kcalloc(cc->cnt, sizeof(*cands.cands), GFP_KERNEL);
+			cands.cands = kcalloc(cc->cnt, sizeof(*cands.cands), GFP_KERNEL_ACCOUNT);
 			if (!cands.cands) {
 				err = -ENOMEM;
 				goto out;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7d6e0c5928b..dbf22877c0d8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1403,7 +1403,7 @@ static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
 		goto out;
 
 	alloc_size = kmalloc_size_roundup(size_mul(new_n, size));
-	new_arr = krealloc(arr, alloc_size, GFP_KERNEL);
+	new_arr = krealloc(arr, alloc_size, GFP_KERNEL_ACCOUNT);
 	if (!new_arr) {
 		kfree(arr);
 		return NULL;
@@ -1420,7 +1420,7 @@ static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
 static int copy_reference_state(struct bpf_verifier_state *dst, const struct bpf_verifier_state *src)
 {
 	dst->refs = copy_array(dst->refs, src->refs, src->acquired_refs,
-			       sizeof(struct bpf_reference_state), GFP_KERNEL);
+			       sizeof(struct bpf_reference_state), GFP_KERNEL_ACCOUNT);
 	if (!dst->refs)
 		return -ENOMEM;
 
@@ -1439,7 +1439,7 @@ static int copy_stack_state(struct bpf_func_state *dst, const struct bpf_func_st
 	size_t n = src->allocated_stack / BPF_REG_SIZE;
 
 	dst->stack = copy_array(dst->stack, src->stack, n, sizeof(struct bpf_stack_state),
-				GFP_KERNEL);
+				GFP_KERNEL_ACCOUNT);
 	if (!dst->stack)
 		return -ENOMEM;
 
@@ -1760,7 +1760,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
-			dst = kzalloc(sizeof(*dst), GFP_KERNEL);
+			dst = kzalloc(sizeof(*dst), GFP_KERNEL_ACCOUNT);
 			if (!dst)
 				return -ENOMEM;
 			dst_state->frame[i] = dst;
@@ -2020,7 +2020,7 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	struct bpf_verifier_stack_elem *elem;
 	int err;
 
-	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL);
+	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL_ACCOUNT);
 	if (!elem)
 		goto err;
 
@@ -2787,7 +2787,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	struct bpf_verifier_stack_elem *elem;
 	struct bpf_func_state *frame;
 
-	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL);
+	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL_ACCOUNT);
 	if (!elem)
 		goto err;
 
@@ -2815,7 +2815,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	elem->st.in_sleepable = is_sleepable;
 	elem->st.insn_hist_start = env->cur_state->insn_hist_end;
 	elem->st.insn_hist_end = elem->st.insn_hist_start;
-	frame = kzalloc(sizeof(*frame), GFP_KERNEL);
+	frame = kzalloc(sizeof(*frame), GFP_KERNEL_ACCOUNT);
 	if (!frame)
 		goto err;
 	init_func_state(env, frame,
@@ -3167,7 +3167,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 			return -EINVAL;
 		}
 
-		tab = kzalloc(sizeof(*tab), GFP_KERNEL);
+		tab = kzalloc(sizeof(*tab), GFP_KERNEL_ACCOUNT);
 		if (!tab)
 			return -ENOMEM;
 		prog_aux->kfunc_tab = tab;
@@ -3183,7 +3183,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 		return 0;
 
 	if (!btf_tab && offset) {
-		btf_tab = kzalloc(sizeof(*btf_tab), GFP_KERNEL);
+		btf_tab = kzalloc(sizeof(*btf_tab), GFP_KERNEL_ACCOUNT);
 		if (!btf_tab)
 			return -ENOMEM;
 		prog_aux->kfunc_btf_tab = btf_tab;
@@ -10279,7 +10279,7 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	}
 
 	caller = state->frame[state->curframe];
-	callee = kzalloc(sizeof(*callee), GFP_KERNEL);
+	callee = kzalloc(sizeof(*callee), GFP_KERNEL_ACCOUNT);
 	if (!callee)
 		return -ENOMEM;
 	state->frame[state->curframe + 1] = callee;
@@ -17606,17 +17606,18 @@ static int check_cfg(struct bpf_verifier_env *env)
 	int *insn_stack, *insn_state, *insn_postorder;
 	int ex_insn_beg, i, ret = 0;
 
-	insn_state = env->cfg.insn_state = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
+	insn_state = env->cfg.insn_state = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
 	if (!insn_state)
 		return -ENOMEM;
 
-	insn_stack = env->cfg.insn_stack = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
+	insn_stack = env->cfg.insn_stack = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
 	if (!insn_stack) {
 		kvfree(insn_state);
 		return -ENOMEM;
 	}
 
-	insn_postorder = env->cfg.insn_postorder = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
+	insn_postorder = env->cfg.insn_postorder =
+		kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
 	if (!insn_postorder) {
 		kvfree(insn_state);
 		kvfree(insn_stack);
@@ -17750,7 +17751,7 @@ static int check_btf_func_early(struct bpf_verifier_env *env,
 	urecord = make_bpfptr(attr->func_info, uattr.is_kernel);
 	min_size = min_t(u32, krec_size, urec_size);
 
-	krecord = kvcalloc(nfuncs, krec_size, GFP_KERNEL | __GFP_NOWARN);
+	krecord = kvcalloc(nfuncs, krec_size, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!krecord)
 		return -ENOMEM;
 
@@ -17850,7 +17851,7 @@ static int check_btf_func(struct bpf_verifier_env *env,
 	urecord = make_bpfptr(attr->func_info, uattr.is_kernel);
 
 	krecord = prog->aux->func_info;
-	info_aux = kcalloc(nfuncs, sizeof(*info_aux), GFP_KERNEL | __GFP_NOWARN);
+	info_aux = kcalloc(nfuncs, sizeof(*info_aux), GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!info_aux)
 		return -ENOMEM;
 
@@ -17936,7 +17937,7 @@ static int check_btf_line(struct bpf_verifier_env *env,
 	 * pass in a smaller bpf_line_info object.
 	 */
 	linfo = kvcalloc(nr_linfo, sizeof(struct bpf_line_info),
-			 GFP_KERNEL | __GFP_NOWARN);
+			 GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!linfo)
 		return -ENOMEM;
 
@@ -19283,7 +19284,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	 * When looping the sl->state.branches will be > 0 and this state
 	 * will not be considered for equivalence until branches == 0.
 	 */
-	new_sl = kzalloc(sizeof(struct bpf_verifier_state_list), GFP_KERNEL);
+	new_sl = kzalloc(sizeof(struct bpf_verifier_state_list), GFP_KERNEL_ACCOUNT);
 	if (!new_sl)
 		return -ENOMEM;
 	env->total_states++;
@@ -22698,13 +22699,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	env->prev_linfo = NULL;
 	env->pass_cnt++;
 
-	state = kzalloc(sizeof(struct bpf_verifier_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct bpf_verifier_state), GFP_KERNEL_ACCOUNT);
 	if (!state)
 		return -ENOMEM;
 	state->curframe = 0;
 	state->speculative = false;
 	state->branches = 1;
-	state->frame[0] = kzalloc(sizeof(struct bpf_func_state), GFP_KERNEL);
+	state->frame[0] = kzalloc(sizeof(struct bpf_func_state), GFP_KERNEL_ACCOUNT);
 	if (!state->frame[0]) {
 		kfree(state);
 		return -ENOMEM;
@@ -22930,7 +22931,7 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
 			       const struct bpf_ctx_arg_aux *info, u32 cnt)
 {
-	prog->aux->ctx_arg_info = kmemdup_array(info, cnt, sizeof(*info), GFP_KERNEL);
+	prog->aux->ctx_arg_info = kmemdup_array(info, cnt, sizeof(*info), GFP_KERNEL_ACCOUNT);
 	prog->aux->ctx_arg_info_size = cnt;
 
 	return prog->aux->ctx_arg_info ? 0 : -ENOMEM;
@@ -23874,7 +23875,7 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 	 * - repeat the computation while {in,out} fields changes for
 	 *   any instruction.
 	 */
-	state = kvcalloc(insn_cnt, sizeof(*state), GFP_KERNEL);
+	state = kvcalloc(insn_cnt, sizeof(*state), GFP_KERNEL_ACCOUNT);
 	if (!state) {
 		err = -ENOMEM;
 		goto out;
@@ -23948,7 +23949,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	/* 'struct bpf_verifier_env' can be global, but since it's not small,
 	 * allocate/free it every time bpf_check() is called
 	 */
-	env = kvzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
+	env = kvzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL_ACCOUNT);
 	if (!env)
 		return -ENOMEM;
 
@@ -24138,7 +24139,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		/* if program passed verifier, update used_maps in bpf_prog_info */
 		env->prog->aux->used_maps = kmalloc_array(env->used_map_cnt,
 							  sizeof(env->used_maps[0]),
-							  GFP_KERNEL);
+							  GFP_KERNEL_ACCOUNT);
 
 		if (!env->prog->aux->used_maps) {
 			ret = -ENOMEM;
@@ -24153,7 +24154,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		/* if program passed verifier, update used_btfs in bpf_prog_aux */
 		env->prog->aux->used_btfs = kmalloc_array(env->used_btf_cnt,
 							  sizeof(env->used_btfs[0]),
-							  GFP_KERNEL);
+							  GFP_KERNEL_ACCOUNT);
 		if (!env->prog->aux->used_btfs) {
 			ret = -ENOMEM;
 			goto err_release_maps;
-- 
2.48.1


