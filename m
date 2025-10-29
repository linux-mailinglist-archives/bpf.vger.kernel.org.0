Return-Path: <bpf+bounces-72866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1CAC1CE30
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A88DB34C2EF
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E768A3590C4;
	Wed, 29 Oct 2025 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BezHKazF"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33950359F81
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764595; cv=none; b=pSA0pQah8SA2RUpbCkViE3E7hyGLZ9BrYqmrxwPOpXIr9toZpf7FvGkRSAyQMJjQyPl3QQvX7kZp5Ds3w11sMpXEm4ByirhxYZLo/3ipoE6bBM7w2BZw4WzgWLb+gu/+pgqD3NYHHFfuoEA6h0LEY2XIKoDC/cQXQvTKQ8aw1Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764595; c=relaxed/simple;
	bh=RGO1j4Dju8yQfdDBWbVtKAPBSjnNy+5CTClWybOAxXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gm6CiTwsOOwK9xo02Tt0Vv6RrrznIZW3A6hN/rbEOgrEGhZgOu3WocAh1lzpQJh2cRf+n3zewtVLl3O7hiPr5x3ZkKXb2WYT2IjHm33+9Spbh1T2lMmNGfJs9eQ3eZHsWR9B1mq9BrAs3vj3Fqql5wskOw4iz0LL2Bk69tUyA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BezHKazF; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761764591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/iuo7SQRLCCySQCpSHDHmbX9U2oDKQrTYMzN8xEyVM=;
	b=BezHKazFEnktQ3HSWbX8vMOYhIQPzP0PYaM3eOccZM72VtJKFc/eiHNl+KJJKK7Qe2U8J3
	2xlkMsi/wZluOHJv8UMk9KNkRvA7O1Suf4DjukXDcdtQOzEnK8ePr1jUi5weJcFX2fjT/N
	CHJhUfCQHPBcj2fYFBfw6zinevFZBsw=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	tj@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v1 3/3] btf_encoder: support kfuncs with KF_MAGIC_ARGS flag
Date: Wed, 29 Oct 2025 12:02:49 -0700
Message-ID: <20251029190249.3323752-4-ihor.solodrai@linux.dev>
In-Reply-To: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
References: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

For BPF kernel functions marked with KF_MAGIC_ARGS flag we emit two
functions to BTF:
  * kfunc_impl() with prototype that matches kernel declaration
  * kfunc() with prototype that omits __magic arguments

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 btf_encoder.c | 121 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index b730280..7a10be3 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -48,6 +48,7 @@
 #define KF_ARENA_RET  (1 << 13)
 #define KF_ARENA_ARG1 (1 << 14)
 #define KF_ARENA_ARG2 (1 << 15)
+#define KF_MAGIC_ARGS (1 << 16)
 
 struct btf_id_and_flag {
 	uint32_t id;
@@ -1404,8 +1405,8 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 	return btf_fn_id;
 }
 
-static int btf_encoder__add_bpf_kfunc(struct btf_encoder *encoder,
-				      struct btf_encoder_func_state *state)
+static int btf_encoder__add_bpf_kfunc_instance(struct btf_encoder *encoder,
+					       struct btf_encoder_func_state *state)
 {
 	int btf_fn_id, err;
 
@@ -1426,6 +1427,122 @@ static int btf_encoder__add_bpf_kfunc(struct btf_encoder *encoder,
 	return 0;
 }
 
+static inline bool str_ends_with(const char *str, const char *suffix)
+{
+	int suffix_len = strlen(suffix);
+	int str_len = strlen(str);
+
+	if (str_len < suffix_len)
+		return false;
+
+	return strcmp(str + str_len - suffix_len, suffix) == 0;
+}
+
+#define BPF_KF_IMPL_SUFFIX "_impl"
+#define BPF_KF_ARG_MAGIC_SUFFIX "__magic"
+
+static inline bool btf__is_kf_magic_arg(const struct btf *btf, const struct btf_encoder_func_parm *p)
+{
+	const char *name;
+
+	name = btf__name_by_offset(btf, p->name_off);
+	if (!name)
+		return false;
+
+	return str_ends_with(name, BPF_KF_ARG_MAGIC_SUFFIX);
+}
+
+/*
+ * A kfunc with KF_MAGIC_ARGS flag has some number of arguments set implicitly by the BPF
+ * verifier. Such arguments are identified by __magic suffix in the argument name.
+ * process_kfunc_magic_args() checks the arguments from last to first, and returns the number of
+ * magic arguments. Note that *all* magic arguments must come after *all* normal arguments in the
+ * function signature. If this assumption is violated, or if no __magic arguments are found,
+ * process_kfunc_magic_args() returns an error.
+ */
+static int process_kfunc_magic_args(struct btf_encoder_func_state *state)
+{
+	const struct btf *btf = state->encoder->btf;
+	const struct btf_encoder_func_parm *p;
+	int cnt = 0, i;
+
+	for (i = state->nr_parms - 1; i >= 0; i--) {
+		p = &state->parms[i];
+		if (btf__is_kf_magic_arg(btf, p)) {
+			cnt++;
+			if (cnt != state->nr_parms - i)
+				goto out_err;
+		} else if (cnt == 0) {
+			goto out_err;
+		}
+	}
+
+	return cnt;
+
+out_err:
+	btf__log_err(btf, BTF_KIND_FUNC_PROTO, state->elf->name, true, 0,
+		     "return=%u Error emitting BTF func proto for KF_MAGIC_ARGS kfunc: unexpected kfunc signature",
+		     p->type_id);
+	return -1;
+}
+
+/*
+ * For KF_MAGIC_ARGS kfuncs we emit two BTF functions (and protos):
+ *   - bpf_foo_impl(<original kernel args>)
+ *   - bpf_foo(<bpf args w/o magic args>)
+ * We achieve this by creating a temporary btf_encoder_func_state-s
+ */
+static int btf_encoder__add_bpf_kfunc_with_magic_args(struct btf_encoder *encoder,
+						      struct btf_encoder_func_state *state)
+{
+	struct btf_encoder_func_annot tmp_annots[state->nr_annots];
+	struct btf_encoder_func_state tmp_state = *state;
+	struct elf_function tmp_elf = *state->elf;
+	char tmp_name[KSYM_NAME_LEN];
+	int err, i, j, nr_magic_args;
+
+	/* First, add kfunc_impl(), modifying only the name */
+	strcpy(tmp_name, state->elf->name);
+	strcat(tmp_name, BPF_KF_IMPL_SUFFIX);
+	tmp_elf.name = tmp_name;
+	tmp_state.elf = &tmp_elf;
+	err = btf_encoder__add_bpf_kfunc_instance(encoder, &tmp_state);
+	if (err < 0)
+		return -1;
+
+	/* Then add kfunc() with omitted magic arguments */
+	nr_magic_args = process_kfunc_magic_args(state);
+	if (nr_magic_args <= 0)
+		return -1;
+
+	tmp_state.elf = state->elf;
+	tmp_state.nr_parms -= nr_magic_args;
+	j = 0;
+	for (i = 0; i < state->nr_annots; i++) {
+		if (state->annots[i].component_idx < tmp_state.nr_parms)
+			tmp_annots[j++] = state->annots[i];
+	}
+	tmp_state.nr_annots = j;
+	tmp_state.annots = tmp_annots;
+	err = btf_encoder__add_bpf_kfunc_instance(encoder, &tmp_state);
+	if (err < 0)
+		return -1;
+
+	return 0;
+}
+
+static inline int btf_encoder__add_bpf_kfunc(struct btf_encoder *encoder,
+					     struct btf_encoder_func_state *state)
+{
+	uint32_t flags = state->elf->kfunc_flags;
+
+	if (KF_MAGIC_ARGS & flags)
+		return btf_encoder__add_bpf_kfunc_with_magic_args(encoder, state);
+
+	return btf_encoder__add_bpf_kfunc_instance(encoder, state);
+}
+
+
 static int elf_function__name_cmp(const void *_a, const void *_b)
 {
 	const struct elf_function *a = _a;
-- 
2.51.1


