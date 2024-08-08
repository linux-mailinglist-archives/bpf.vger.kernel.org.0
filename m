Return-Path: <bpf+bounces-36734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBFC94C753
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 01:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0940E286C98
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 23:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BA7160796;
	Thu,  8 Aug 2024 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZswSJP03"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59321474A5
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723159363; cv=none; b=LESXEXoloZAnGS/LoE+jGa9sXBbCXbNCQ+pYYK61yoRlYccme/EXpMKgMkvWzHBuM0+52XqazffRV7uZ8ucsC5/JRnZ9jFSLCuadCMACMHFiqr9PpZAPc244y450dQUgtKLOm7p4I/c9le+2U6hswyFWcHL2LhiF97RwYu+03/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723159363; c=relaxed/simple;
	bh=I0yNWr6fIJl96Sh2OqzuVYEikJ8GnLgK2heAeag7+hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvXvwwTxT3AdUXjAmGsLpr4MWAkoNQ6QKFpK/ANMn6L+mpoboV9K86yGgC3ryt9riAZgdm0RkTGhSDQqJOBLxAs/dr9UPfiMk81D80mRNNbSGXplQlTytjeegcD6Acf4jRDeHwvmMeXxlYRxTbjwFK/4MvLBFx65sAPUNbTBnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZswSJP03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1D1C32782;
	Thu,  8 Aug 2024 23:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723159363;
	bh=I0yNWr6fIJl96Sh2OqzuVYEikJ8GnLgK2heAeag7+hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZswSJP03N5+c9llw8FA2vn+ZE0kb1WLRMh2fByHuBpATujfcS17b875t5AUmaESo+
	 /TTc2SuZWQvSYnp/1FCpfnK4mYHI6D+e87qv/c4TVQh0cn8GKs+jSF4ZDbmlZP8ux5
	 ZjOwiEBFcz0mvukhImmSbIK7lFYQfjqzQNiobYp88HkO473JlQMPh8MjAdpLQxUAPq
	 3BrZXGJ4x8ItxSyBK2eM3xFMus1WLdEMM021qPFtNGH8k9qoFNcq8WTYr7lCipfySk
	 0lhUmlG5V0MzfWjumU1CZNmlqJMeMt7PUM/YyrHUNUUF2U/izIqZ3Ouk/QDAF3IoQa
	 j3JzOy44getKg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: tj@kernel.org,
	void@manifault.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 2/3] bpf: allow passing struct bpf_iter_<type> as kfunc arguments
Date: Thu,  8 Aug 2024 16:22:29 -0700
Message-ID: <20240808232230.2848712-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240808232230.2848712-1-andrii@kernel.org>
References: <20240808232230.2848712-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are potentially useful cases where a specific iterator type might
need to be passed into some kfunc. So, in addition to existing
bpf_iter_<type>_{new,next,destroy}() kfuncs, allow to pass iterator
pointer to any kfunc.

We employ "__iter" naming suffix for arguments that are meant to accept
iterators. We also enforce that they accept PTR -> STRUCT btf_iter_<type>
type chain and point to a valid initialized on-the-stack iterator state.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index df3be12096cf..920d7c5fe944 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7970,12 +7970,17 @@ static bool is_iter_destroy_kfunc(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_ITER_DESTROY;
 }
 
-static bool is_kfunc_arg_iter(struct bpf_kfunc_call_arg_meta *meta, int arg)
+static bool is_kfunc_arg_iter(struct bpf_kfunc_call_arg_meta *meta, int arg_idx,
+			      const struct btf_param *arg)
 {
 	/* btf_check_iter_kfuncs() guarantees that first argument of any iter
 	 * kfunc is iter state pointer
 	 */
-	return arg == 0 && is_iter_kfunc(meta);
+	if (is_iter_kfunc(meta))
+		return arg_idx == 0;
+
+	/* iter passed as an argument to a generic kfunc */
+	return btf_param_match_suffix(meta->btf, arg, "__iter");
 }
 
 static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_idx,
@@ -7983,14 +7988,20 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	const struct btf_type *t;
-	const struct btf_param *arg;
-	int spi, err, i, nr_slots;
-	u32 btf_id;
+	int spi, err, i, nr_slots, btf_id;
 
-	/* btf_check_iter_kfuncs() ensures we don't need to validate anything here */
-	arg = &btf_params(meta->func_proto)[0];
-	t = btf_type_skip_modifiers(meta->btf, arg->type, NULL);	/* PTR */
-	t = btf_type_skip_modifiers(meta->btf, t->type, &btf_id);	/* STRUCT */
+	/* For iter_{new,next,destroy} functions, btf_check_iter_kfuncs()
+	 * ensures struct convention, so we wouldn't need to do any BTF
+	 * validation here. But given iter state can be passed as a parameter
+	 * to any kfunc, if arg has "__iter" suffix, we need to be a bit more
+	 * conservative here.
+	 */
+	btf_id = btf_check_iter_arg(meta->btf, meta->func_proto, regno - 1);
+	if (btf_id < 0) {
+		verbose(env, "expected valid iter pointer as arg #%d\n", regno);
+		return -EINVAL;
+	}
+	t = btf_type_by_id(meta->btf, btf_id);
 	nr_slots = t->size / BPF_REG_SIZE;
 
 	if (is_iter_new_kfunc(meta)) {
@@ -8012,7 +8023,9 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 		if (err)
 			return err;
 	} else {
-		/* iter_next() or iter_destroy() expect initialized iter state*/
+		/* iter_next() or iter_destroy(), as well as any kfunc
+		 * accepting iter argument, expect initialized iter state
+		 */
 		err = is_iter_reg_valid_init(env, reg, meta->btf, btf_id, nr_slots);
 		switch (err) {
 		case 0:
@@ -11382,7 +11395,7 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_dynptr(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_DYNPTR;
 
-	if (is_kfunc_arg_iter(meta, argno))
+	if (is_kfunc_arg_iter(meta, argno, &args[argno]))
 		return KF_ARG_PTR_TO_ITER;
 
 	if (is_kfunc_arg_list_head(meta->btf, &args[argno]))
-- 
2.43.5


