Return-Path: <bpf+bounces-51985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7C9A3CAFE
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 22:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBECD188F851
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 21:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A948E255E2F;
	Wed, 19 Feb 2025 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bB5PVP8h"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D2253356
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999135; cv=none; b=IRJIm4n3A53PpK2LZNgnazz5QJuGvi4PC5RQJP6Li8UA8eXOu9r7zSUTIcKYOISV0J858/P1+LaprVrE5H5z/84mOhDgGJWsUOxoODuPY3DPphgb6xb6Mu5UI8fNCA2A/yNTsVmJqRvgqELu8ltyVD4yOHaM3qgkYamUeVO/tEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999135; c=relaxed/simple;
	bh=NR401DGkZ6X0Kw083X0R0d4HY284E4gJ6o98sSyUiDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcZBmnuCJs9ne2LdePHsQS8KDJ+hSquQjuxjbGhGnSRfE8uj9NBsxA9w7FZe8n4kyE7+bneR9g7HwjsO4hIAKt0yEGzXZEyIMIAd3dmR36+4/gpHh4BVwxawPMkQcZDMaRNd044pI/NrUn9PSFQDbBscjD1t93atwlGLkNBuJSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bB5PVP8h; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739999131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbEsZw1sAzT1POVT60+LaNyybURR5s1P5UwFZxeCkzk=;
	b=bB5PVP8hzubddN0lQaqfY5ggKZv9CvPfLIxOnB1kN4hVAKD/UR4+Y5IsxhrSZsghlVBInl
	igNV/GoNK3J/2zNNRHDmEI7C+3m4JZhHHjpRAGxbgnICFBqmp105KbbbsPJNsdwMzOLhJO
	6k1/LhnbeNM3O/hEu9SpgbB1gn0xWmM=
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
Subject: [PATCH bpf-next v3 2/4] btf_encoder: emit type tags for bpf_arena pointers
Date: Wed, 19 Feb 2025 13:05:18 -0800
Message-ID: <20250219210520.2245369-3-ihor.solodrai@linux.dev>
In-Reply-To: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
References: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
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
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 2bea5ee..844938f 100644
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
@@ -731,6 +737,78 @@ static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t tag_t
 	return encoder->type_id_off + tag_type;
 }
 
+#if LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 6
+static int btf__tag_bpf_arena_ptr(struct btf *btf, int ptr_id)
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
+static int btf__tag_bpf_arena_arg(struct btf *btf, struct btf_encoder_func_state *state, int idx)
+{
+	int id;
+
+	if (state->nr_parms <= idx)
+		return -EINVAL;
+
+	id = btf__tag_bpf_arena_ptr(btf, state->parms[idx].type_id);
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
+static int btf__add_bpf_arena_type_tags(struct btf *btf, struct btf_encoder_func_state *state)
+{
+	uint32_t flags = state->elf->kfunc_flags;
+	int ret_type_id;
+	int err;
+
+	if (KF_ARENA_RET & flags) {
+		ret_type_id = btf__tag_bpf_arena_ptr(btf, state->ret_type_id);
+		if (ret_type_id < 0) {
+			btf__log_err(btf, BTF_KIND_TYPE_TAG, BPF_ARENA_ATTR, true, ret_type_id,
+				"Error adding BPF_ARENA_ATTR for return type of kfunc '%s'", state->elf->name);
+			return ret_type_id;
+		}
+		state->ret_type_id = ret_type_id;
+	}
+
+	if (KF_ARENA_ARG1 & flags) {
+		err = btf__tag_bpf_arena_arg(btf, state, 0);
+		if (err < 0)
+			return err;
+	}
+
+	if (KF_ARENA_ARG2 & flags) {
+		err = btf__tag_bpf_arena_arg(btf, state, 1);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+#endif // LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 6
+
+static inline bool is_kfunc_state(struct btf_encoder_func_state *state)
+{
+	return state && state->elf && state->elf->kfunc;
+}
+
 static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype,
 					   struct btf_encoder_func_state *state)
 {
@@ -744,6 +822,12 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
 
 	assert(ftype != NULL || state != NULL);
 
+#if LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 6
+	if (is_kfunc_state(state) && encoder->tag_kfuncs)
+		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
+			return -1;
+#endif
+
 	/* add btf_type for func_proto */
 	if (ftype) {
 		btf = encoder->btf;
-- 
2.48.1


