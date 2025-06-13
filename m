Return-Path: <bpf+bounces-60582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6461AAD83FD
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 09:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8DC1189B008
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 07:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6616F2C3269;
	Fri, 13 Jun 2025 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWU1aQq/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3D127466E
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749799313; cv=none; b=QglUKV3VmTnzUd8jAgpGQA/x95le4BRRwTNC8KTzfAy3e8c8qBc7HNRIc+HctLQ6D2UuXJRaUprBtecHYR4Z/QuB3UODuSl1ajPlHxHYudBI+6okrmArtw7UMnRB9qz/+Y3VI2ri9v/dzq+9O6r8BMJpTEEyTavL6Evt9BTUHXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749799313; c=relaxed/simple;
	bh=d6bZQz3/n5jARsNZdxT27L5qG+2ouO40LZrbPJer0PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+/TLlGUYAPUAOEX/DqWYyzQKFoMmrvMMAIvxiJ89OcF0JO3QyXDfSv/9sC4SEqKcXh0355AWq6SH+ygt9UTyNsYrDnDtZBaBKTrpc6nIdQ+IMQhQe74bIJzUsJLNlBonjQMNBYXQxa1OagQS+u8eslTAqjTlzLagzeuhfuyRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWU1aQq/; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7086dcab64bso15808717b3.1
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 00:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749799310; x=1750404110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IT+Ag5357vHHQ31Yg8tJM5YjKogrbiBMm3ScEf9JDSA=;
        b=FWU1aQq//6vU6r49PQCr8NgmuDkzBpN3bwes7Rmfvta+9a6wAMDynIRnx1Jw3hAqDm
         qstMVXAmLI09ZsSweVYIRJ8Fqj64y3kBQgOeIvDJZfNCuQUjKXV51LZ0nE9heTHtpPkY
         eCBfALUog9jUStyR12UN2AbEtaQH5ihR2hMJxKGL4alUUDmdKR8FPfbdKqkeBrEUrKZB
         /70bUlfwo875KvLOTQjU9NemHdJQvbMwmRP/Zj39S3JNaCOI/ishRLNk1dhVPcjtl3L5
         dyfqWJAy6xuCVtG0QOvs8run6+52VDU5NDeqidovFvS+NSgL2TBL5E9PMpG3UZ8kzLNo
         +1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749799310; x=1750404110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IT+Ag5357vHHQ31Yg8tJM5YjKogrbiBMm3ScEf9JDSA=;
        b=QPhwm2vRKDZfT/nmr7HYZbqq7iibkbret7RzTs+3zRmEyLy5gnF0KSiCIOk4n/NmJY
         eKDNZhtpTfw+kRskSHf0zIjgGTKnEEdhbAzepFbyBzrClZRzvrNci7w5AnWrPEMIfhhT
         +txSGYvYNsEwnOywWq+4nCOBfXdiMC7ca7J3r7BRb2PBeQHYHhWAbd+pTGKIe7DYC2tZ
         uWmy/t6Co4aOg5kLysnIy7beNijexJ+qxOUujfzbM3PKToLzZfFVVgrOEQEMRkgmnZrX
         +j99sj06GFpu9jVuNfaRuJjr6oTlsbdZov0cFupbYx+BTHSs1Caq+Hai/JQ3ht7nppdb
         bg4A==
X-Gm-Message-State: AOJu0Yw4ssgKysQESj6EXTbkcWikFzNav8dZeGNvc0tZcEr43poS4LN/
	4H/bFUxqFFlSmrNfkMXn7HMZVBwhdQMZi5+uAt2Lct2RW7bV+9M8JLXBb0RQXTAN
X-Gm-Gg: ASbGncuzDsqzHARCHHJgawXiaLr5Lx8gHxZHSo9LIMe0amV85YlKzqKd+0wyzVdeZGm
	gUNLdAk5KYXKAUF2Y7Fww7/tgf7Yuxd550ZCLPo0CT8eDi4bDTivrTKqrMK8lmDMMzGBNSraAgx
	/I9XI8QcqN64K1Y/grMWgw7Mwr/Fupso2/VVYHVQpOu/WWu6RnocQ+302zJ/ua4970zpn6w7FQ3
	azIlTgF4T2KTIZpeA8LBXVtPT5xy3DkzyJTZDDCwfAf2/lcxS8p7HS4hX6oAzdP+kyI5Mf5oy9b
	9sCGJNZkUd5nEX1eiHnnJ6LvO9Se+zP8Vhygyn5L+y9MnpJkw/Ogxg==
X-Google-Smtp-Source: AGHT+IFtBd44GyXRK7CD2/Mw+hodrFx+L2Whsyml5Ruqaq0m4Zi1Jys/WkUb27Pa0stPg+poigG+fQ==
X-Received: by 2002:a05:690c:6b09:b0:70e:2b60:1562 with SMTP id 00721157ae682-71163658116mr32712527b3.16.1749799310430;
        Fri, 13 Jun 2025 00:21:50 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-711527b7937sm5505447b3.91.2025.06.13.00.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 00:21:49 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH bpf-next v3 1/2] bpf: include verifier memory allocations in memcg statistics
Date: Fri, 13 Jun 2025 00:21:46 -0700
Message-ID: <20250613072147.3938139-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613072147.3938139-1-eddyz87@gmail.com>
References: <20250613072147.3938139-1-eddyz87@gmail.com>
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
 kernel/bpf/btf.c      | 15 +++++-----
 kernel/bpf/verifier.c | 69 ++++++++++++++++++++++---------------------
 2 files changed, 43 insertions(+), 41 deletions(-)

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
index c378074516cf..fd81cff11617 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1404,7 +1404,7 @@ static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
 		goto out;
 
 	alloc_size = kmalloc_size_roundup(size_mul(new_n, size));
-	new_arr = krealloc(arr, alloc_size, GFP_KERNEL);
+	new_arr = krealloc(arr, alloc_size, GFP_KERNEL_ACCOUNT);
 	if (!new_arr) {
 		kfree(arr);
 		return NULL;
@@ -1421,7 +1421,7 @@ static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
 static int copy_reference_state(struct bpf_verifier_state *dst, const struct bpf_verifier_state *src)
 {
 	dst->refs = copy_array(dst->refs, src->refs, src->acquired_refs,
-			       sizeof(struct bpf_reference_state), GFP_KERNEL);
+			       sizeof(struct bpf_reference_state), GFP_KERNEL_ACCOUNT);
 	if (!dst->refs)
 		return -ENOMEM;
 
@@ -1440,7 +1440,7 @@ static int copy_stack_state(struct bpf_func_state *dst, const struct bpf_func_st
 	size_t n = src->allocated_stack / BPF_REG_SIZE;
 
 	dst->stack = copy_array(dst->stack, src->stack, n, sizeof(struct bpf_stack_state),
-				GFP_KERNEL);
+				GFP_KERNEL_ACCOUNT);
 	if (!dst->stack)
 		return -ENOMEM;
 
@@ -1731,7 +1731,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 
 	dst_state->jmp_history = copy_array(dst_state->jmp_history, src->jmp_history,
 					  src->jmp_history_cnt, sizeof(*dst_state->jmp_history),
-					  GFP_USER);
+					  GFP_KERNEL_ACCOUNT);
 	if (!dst_state->jmp_history)
 		return -ENOMEM;
 	dst_state->jmp_history_cnt = src->jmp_history_cnt;
@@ -1760,7 +1760,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
-			dst = kzalloc(sizeof(*dst), GFP_KERNEL);
+			dst = kzalloc(sizeof(*dst), GFP_KERNEL_ACCOUNT);
 			if (!dst)
 				return -ENOMEM;
 			dst_state->frame[i] = dst;
@@ -1874,7 +1874,7 @@ static struct bpf_scc_visit *scc_visit_alloc(struct bpf_verifier_env *env,
 	info = env->scc_info[scc];
 	num_visits = info ? info->num_visits : 0;
 	new_sz = sizeof(*info) + sizeof(struct bpf_scc_visit) * (num_visits + 1);
-	info = kvrealloc(env->scc_info[scc], new_sz, GFP_KERNEL);
+	info = kvrealloc(env->scc_info[scc], new_sz, GFP_KERNEL_ACCOUNT);
 	if (!info)
 		return NULL;
 	env->scc_info[scc] = info;
@@ -2095,7 +2095,7 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	struct bpf_verifier_stack_elem *elem;
 	int err;
 
-	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL);
+	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL_ACCOUNT);
 	if (!elem)
 		goto err;
 
@@ -2862,7 +2862,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	struct bpf_verifier_stack_elem *elem;
 	struct bpf_func_state *frame;
 
-	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL);
+	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL_ACCOUNT);
 	if (!elem)
 		goto err;
 
@@ -2885,7 +2885,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	 */
 	elem->st.branches = 1;
 	elem->st.in_sleepable = is_sleepable;
-	frame = kzalloc(sizeof(*frame), GFP_KERNEL);
+	frame = kzalloc(sizeof(*frame), GFP_KERNEL_ACCOUNT);
 	if (!frame)
 		goto err;
 	init_func_state(env, frame,
@@ -3237,7 +3237,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 			return -EINVAL;
 		}
 
-		tab = kzalloc(sizeof(*tab), GFP_KERNEL);
+		tab = kzalloc(sizeof(*tab), GFP_KERNEL_ACCOUNT);
 		if (!tab)
 			return -ENOMEM;
 		prog_aux->kfunc_tab = tab;
@@ -3253,7 +3253,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 		return 0;
 
 	if (!btf_tab && offset) {
-		btf_tab = kzalloc(sizeof(*btf_tab), GFP_KERNEL);
+		btf_tab = kzalloc(sizeof(*btf_tab), GFP_KERNEL_ACCOUNT);
 		if (!btf_tab)
 			return -ENOMEM;
 		prog_aux->kfunc_btf_tab = btf_tab;
@@ -3939,7 +3939,7 @@ static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_st
 
 	cnt++;
 	alloc_size = kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
-	p = krealloc(cur->jmp_history, alloc_size, GFP_USER);
+	p = krealloc(cur->jmp_history, alloc_size, GFP_KERNEL_ACCOUNT);
 	if (!p)
 		return -ENOMEM;
 	cur->jmp_history = p;
@@ -10356,7 +10356,7 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	}
 
 	caller = state->frame[state->curframe];
-	callee = kzalloc(sizeof(*callee), GFP_KERNEL);
+	callee = kzalloc(sizeof(*callee), GFP_KERNEL_ACCOUNT);
 	if (!callee)
 		return -ENOMEM;
 	state->frame[state->curframe + 1] = callee;
@@ -17693,17 +17693,18 @@ static int check_cfg(struct bpf_verifier_env *env)
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
@@ -17837,7 +17838,7 @@ static int check_btf_func_early(struct bpf_verifier_env *env,
 	urecord = make_bpfptr(attr->func_info, uattr.is_kernel);
 	min_size = min_t(u32, krec_size, urec_size);
 
-	krecord = kvcalloc(nfuncs, krec_size, GFP_KERNEL | __GFP_NOWARN);
+	krecord = kvcalloc(nfuncs, krec_size, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!krecord)
 		return -ENOMEM;
 
@@ -17937,7 +17938,7 @@ static int check_btf_func(struct bpf_verifier_env *env,
 	urecord = make_bpfptr(attr->func_info, uattr.is_kernel);
 
 	krecord = prog->aux->func_info;
-	info_aux = kcalloc(nfuncs, sizeof(*info_aux), GFP_KERNEL | __GFP_NOWARN);
+	info_aux = kcalloc(nfuncs, sizeof(*info_aux), GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!info_aux)
 		return -ENOMEM;
 
@@ -18023,7 +18024,7 @@ static int check_btf_line(struct bpf_verifier_env *env,
 	 * pass in a smaller bpf_line_info object.
 	 */
 	linfo = kvcalloc(nr_linfo, sizeof(struct bpf_line_info),
-			 GFP_KERNEL | __GFP_NOWARN);
+			 GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!linfo)
 		return -ENOMEM;
 
@@ -19408,7 +19409,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			if (loop) {
 				struct bpf_scc_backedge *backedge;
 
-				backedge = kzalloc(sizeof(*backedge), GFP_KERNEL);
+				backedge = kzalloc(sizeof(*backedge), GFP_KERNEL_ACCOUNT);
 				if (!backedge)
 					return -ENOMEM;
 				err = copy_verifier_state(&backedge->state, cur);
@@ -19472,7 +19473,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	 * When looping the sl->state.branches will be > 0 and this state
 	 * will not be considered for equivalence until branches == 0.
 	 */
-	new_sl = kzalloc(sizeof(struct bpf_verifier_state_list), GFP_KERNEL);
+	new_sl = kzalloc(sizeof(struct bpf_verifier_state_list), GFP_KERNEL_ACCOUNT);
 	if (!new_sl)
 		return -ENOMEM;
 	env->total_states++;
@@ -22976,13 +22977,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
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
@@ -23208,7 +23209,7 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
 			       const struct bpf_ctx_arg_aux *info, u32 cnt)
 {
-	prog->aux->ctx_arg_info = kmemdup_array(info, cnt, sizeof(*info), GFP_KERNEL);
+	prog->aux->ctx_arg_info = kmemdup_array(info, cnt, sizeof(*info), GFP_KERNEL_ACCOUNT);
 	prog->aux->ctx_arg_info_size = cnt;
 
 	return prog->aux->ctx_arg_info ? 0 : -ENOMEM;
@@ -24152,7 +24153,7 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 	 * - repeat the computation while {in,out} fields changes for
 	 *   any instruction.
 	 */
-	state = kvcalloc(insn_cnt, sizeof(*state), GFP_KERNEL);
+	state = kvcalloc(insn_cnt, sizeof(*state), GFP_KERNEL_ACCOUNT);
 	if (!state) {
 		err = -ENOMEM;
 		goto out;
@@ -24244,10 +24245,10 @@ static int compute_scc(struct bpf_verifier_env *env)
 	 * - 'low[t] == n' => smallest preorder number of the vertex reachable from 't' is 'n';
 	 * - 'dfs' DFS traversal stack, used to emulate explicit recursion.
 	 */
-	stack = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
-	pre = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
-	low = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
-	dfs = kvcalloc(insn_cnt, sizeof(*dfs), GFP_KERNEL);
+	stack = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
+	pre = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
+	low = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
+	dfs = kvcalloc(insn_cnt, sizeof(*dfs), GFP_KERNEL_ACCOUNT);
 	if (!stack || !pre || !low || !dfs) {
 		err = -ENOMEM;
 		goto exit;
@@ -24381,7 +24382,7 @@ static int compute_scc(struct bpf_verifier_env *env)
 			dfs_sz--;
 		}
 	}
-	env->scc_info = kvcalloc(next_scc_id, sizeof(*env->scc_info), GFP_KERNEL);
+	env->scc_info = kvcalloc(next_scc_id, sizeof(*env->scc_info), GFP_KERNEL_ACCOUNT);
 	if (!env->scc_info) {
 		err = -ENOMEM;
 		goto exit;
@@ -24409,7 +24410,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	/* 'struct bpf_verifier_env' can be global, but since it's not small,
 	 * allocate/free it every time bpf_check() is called
 	 */
-	env = kvzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
+	env = kvzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL_ACCOUNT);
 	if (!env)
 		return -ENOMEM;
 
@@ -24472,7 +24473,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 
 	env->explored_states = kvcalloc(state_htab_size(env),
 				       sizeof(struct list_head),
-				       GFP_USER);
+				       GFP_KERNEL_ACCOUNT);
 	ret = -ENOMEM;
 	if (!env->explored_states)
 		goto skip_full_check;
@@ -24603,7 +24604,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		/* if program passed verifier, update used_maps in bpf_prog_info */
 		env->prog->aux->used_maps = kmalloc_array(env->used_map_cnt,
 							  sizeof(env->used_maps[0]),
-							  GFP_KERNEL);
+							  GFP_KERNEL_ACCOUNT);
 
 		if (!env->prog->aux->used_maps) {
 			ret = -ENOMEM;
@@ -24618,7 +24619,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		/* if program passed verifier, update used_btfs in bpf_prog_aux */
 		env->prog->aux->used_btfs = kmalloc_array(env->used_btf_cnt,
 							  sizeof(env->used_btfs[0]),
-							  GFP_KERNEL);
+							  GFP_KERNEL_ACCOUNT);
 		if (!env->prog->aux->used_btfs) {
 			ret = -ENOMEM;
 			goto err_release_maps;
-- 
2.47.1


