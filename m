Return-Path: <bpf+bounces-50727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D523FA2B8B4
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 03:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F74B3A6CEA
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 02:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C471494DD;
	Fri,  7 Feb 2025 02:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R5LECFlF"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6896154439
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 02:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738894504; cv=none; b=nlq9BfLs+/5516hTGjCF8zM12kCXfjOKL7FY/JLY+0y2iu70mIMsYX3CRq73c9B1rZb7q4YpStjgYm18qujJJdaOiTYjrl6Y+FOfOlM9GbazTO+GiGUy9SXh1TA8hTaBTl0nN3vYFereSkvHEQLaTJSc7ZzO+9O1f5CzZxOGC3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738894504; c=relaxed/simple;
	bh=xH6JVxKXv02D9eBvNCN/2zADWeZazcaYrH3iv3ta4vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcEoqC2jarcG1MDRxGxYlR5IlncdLp6KlXVUud64L02hDWcFV1hYXwpVdd1lzrxnbyUloHGJA7v7gfPfFLbowY2YpiSWUyF5+IGFtkHM57p5EUuSfh4litFzQvLWAVd0cgzJyBJ/npMJmz/h2nj4S1kukEWM01zVE34BK3mJ+Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R5LECFlF; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738894500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MSiZyIbYtR+URtoCK7wRmnwe0Y1izHjUCMvMV44yoA=;
	b=R5LECFlFuh5y2CCUq/aQ9Hvd2hGHC52pKsJTAutt6e8MzXAW1g8p0YDaJMmMWL2I10Y/NM
	0ZVZXOCk2h9Lb1FIsQ3CRDEqf67SD9b5A69Hei66AFRVJvZrIlEuU2zl9FgmonXhDpVxwj
	tlIjauQSQOuMak00MA1mKDWHj4yHz28=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Cc: acme@kernel.org,
	alan.maguire@oracle.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH dwarves 2/3] btf_encoder: emit type tags for bpf_arena pointers
Date: Thu,  6 Feb 2025 18:14:41 -0800
Message-ID: <20250207021442.155703-3-ihor.solodrai@linux.dev>
In-Reply-To: <20250207021442.155703-1-ihor.solodrai@linux.dev>
References: <20250207021442.155703-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When adding a kfunc prototype to BTF, check for the flags indicating
bpf_arena pointers and emit a type tag encoding
__attribute__((address_space(1))) for them. This also requires
updating BTF type ids in the btf_encoder_func_state, which is done as
a side effect in the tagging functions.

This feature depends on recent update in libbpf, supporting arbitrarty
attribute encoding [1].

[1] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 btf_encoder.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index e9f4baf..d7837c2 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -40,7 +40,13 @@
 #define BTF_SET8_KFUNCS		(1 << 0)
 #define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
 #define BTF_FASTCALL_TAG       "bpf_fastcall"
-#define KF_FASTCALL            (1 << 12)
+#define BPF_ARENA_ATTR         "address_space(1)"
+
+/* kfunc flags, see include/linux/btf.h in the kernel source */
+#define KF_FASTCALL   (1 << 12)
+#define KF_ARENA_RET  (1 << 13)
+#define KF_ARENA_ARG1 (1 << 14)
+#define KF_ARENA_ARG2 (1 << 15)
 
 struct btf_id_and_flag {
 	uint32_t id;
@@ -743,6 +749,91 @@ static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t tag_t
 	return encoder->type_id_off + tag_type;
 }
 
+static inline struct kfunc_info* btf_encoder__kfunc_by_name(struct btf_encoder *encoder, const char *name) {
+	struct kfunc_info *kfunc;
+
+	list_for_each_entry(kfunc, &encoder->kfuncs, node) {
+		if (strcmp(kfunc->name, name) == 0)
+			return kfunc;
+	}
+	return NULL;
+}
+
+#if LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 6
+static int btf_encoder__tag_bpf_arena_ptr(struct btf *btf, int ptr_id)
+{
+	const struct btf_type *ptr;
+	int tagged_type_id;
+
+	ptr = btf__type_by_id(btf, ptr_id);
+	if (!btf_is_ptr(ptr))
+		return -EINVAL;
+
+	tagged_type_id = btf__add_type_attr(btf, BPF_ARENA_ATTR, ptr->type);
+	if (tagged_type_id < 0)
+		return tagged_type_id;
+
+	return btf__add_ptr(btf, tagged_type_id);
+}
+
+static int btf_encoder__tag_bpf_arena_arg(struct btf *btf, struct btf_encoder_func_state *state, int idx)
+{
+	int id;
+
+	if (state->nr_parms <= idx)
+		return -EINVAL;
+
+	id = btf_encoder__tag_bpf_arena_ptr(btf, state->parms[idx].type_id);
+	if (id < 0) {
+		btf__log_err(btf, BTF_KIND_TYPE_TAG, BPF_ARENA_ATTR, true, id,
+			"Error adding BPF_ARENA_ATTR for an argument of kfunc '%s'", state->elf->name);
+		return id;
+	}
+	state->parms[idx].type_id = id;
+
+	return id;
+}
+
+static int btf_encoder__add_bpf_arena_type_tags(struct btf_encoder *encoder, struct btf_encoder_func_state *state)
+{
+	struct kfunc_info *kfunc = NULL;
+	int ret_type_id;
+	int err = 0;
+
+	if (!state || !state->elf || !state->elf->kfunc)
+		goto out;
+
+	kfunc = btf_encoder__kfunc_by_name(encoder, state->elf->name);
+	if (!kfunc)
+		goto out;
+
+	if (KF_ARENA_RET & kfunc->flags) {
+		ret_type_id = btf_encoder__tag_bpf_arena_ptr(encoder->btf, state->ret_type_id);
+		if (ret_type_id < 0) {
+			btf__log_err(encoder->btf, BTF_KIND_TYPE_TAG, BPF_ARENA_ATTR, true, ret_type_id,
+				"Error adding BPF_ARENA_ATTR for return type of kfunc '%s'", state->elf->name);
+			err = ret_type_id;
+			goto out;
+		}
+		state->ret_type_id = ret_type_id;
+	}
+
+	if (KF_ARENA_ARG1 & kfunc->flags) {
+		err = btf_encoder__tag_bpf_arena_arg(encoder->btf, state, 0);
+		if (err < 0)
+			goto out;
+	}
+
+	if (KF_ARENA_ARG2 & kfunc->flags) {
+		err = btf_encoder__tag_bpf_arena_arg(encoder->btf, state, 1);
+		if (err < 0)
+			goto out;
+	}
+out:
+	return err;
+}
+#endif // LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 6
+
 static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype,
 					   struct btf_encoder_func_state *state)
 {
@@ -762,6 +853,10 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
 		nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
 		type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
 	} else if (state) {
+#if LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 6
+		if (btf_encoder__add_bpf_arena_type_tags(encoder, state) < 0)
+			return -1;
+#endif
 		encoder = state->encoder;
 		btf = state->encoder->btf;
 		nr_params = state->nr_parms;
-- 
2.48.1


