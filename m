Return-Path: <bpf+bounces-52903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13207A4A2EC
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 20:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B59189AD25
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6A11F4CA8;
	Fri, 28 Feb 2025 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gaYe/n+l"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D858230BC7
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772034; cv=none; b=cZt87EjElGtrO46eia/uYmty9FuSwr1G0Dg3Ec06RU7/GDoccPAPM7MBmqm5HulfPVRyRpk9Fj954dYPfKYRSRbGAyT3oCQ+u5D/eHWpZMHgAuUsqC8uCeCw3k0UjHkinTyZYNlwhb41oAe/ZSC89moqWhxv52lW27ocGNpRR3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772034; c=relaxed/simple;
	bh=3Txd3Ms1F59MwpYvrRNNRH+qO33S+ATOzdEx6jmHkl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1nLjW1yPvy26Onn42pT6tSLeo5HozwBgUAoZt8FNIREOeKBTdoS/Hk92II+doUuv+RFO41PG5tHJ/dN1yXBf/L5k7Vk04yyhvu8f4urEpAPtJxnd5zUzzXnkhX6vvVpOM0ucT0B+adqV/h4PIFt4OusijRFcpAI8PS6C7xmE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gaYe/n+l; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740772030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlLTD2oNXwm4m9BNqPFwBV6D5WIkef4KAuCcKYTayCY=;
	b=gaYe/n+lvNTDcWKUE3sL72DM2mi9WBpza0YEcqUM3TDbeJ7krKBHhG7ws9XPvSEXUeSuBh
	ZVSRzmKYrSmxSr2OpAnrwVXNYRP+6aIPFujfno4rn18LKyc3Ui4wAwIv9YoWKDIzYCYgrV
	4lMwT77NZx2us7S5SZfBQhMJkW4YyvQ=
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
Subject: [PATCH dwarves v4 4/6] btf_encoder: emit type tags for bpf_arena pointers
Date: Fri, 28 Feb 2025 11:46:52 -0800
Message-ID: <20250228194654.1022535-5-ihor.solodrai@linux.dev>
In-Reply-To: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
References: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
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
 btf_encoder.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 dwarves.h     |  1 +
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 12a040f..991aba6 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -41,7 +41,13 @@
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
@@ -718,6 +724,81 @@ static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t tag_t
 	return encoder->type_id_off + tag_type;
 }
 
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
+	if (!btf__add_type_attr) {
+		fprintf(stderr, "btf__add_type_attr is not available, is libbpf < 1.6?\n");
+		return -ENOTSUP;
+	}
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
+
+static inline bool is_kfunc_state(struct btf_encoder_func_state *state)
+{
+	return state && state->elf && state->elf->kfunc;
+}
+
 static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype,
 					   struct btf_encoder_func_state *state)
 {
@@ -731,6 +812,10 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
 
 	assert(ftype != NULL || state != NULL);
 
+	if (is_kfunc_state(state) && encoder->tag_kfuncs)
+		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
+			return -1;
+
 	/* add btf_type for func_proto */
 	if (ftype) {
 		btf = encoder->btf;
diff --git a/dwarves.h b/dwarves.h
index ab32204..4202dfb 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -52,6 +52,7 @@ enum load_steal_kind {
 struct btf;
 __weak extern int btf__add_enum64(struct btf *btf, const char *name, __u32 byte_sz, bool is_signed);
 __weak extern int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value);
+__weak extern int btf__add_type_attr(struct btf *btf, const char *value, int ref_type_id);
 __weak extern int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf, struct btf **new_split_btf);
 
 /*
-- 
2.48.1


