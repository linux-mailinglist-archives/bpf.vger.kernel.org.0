Return-Path: <bpf+bounces-31275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DCD8FA651
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 01:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53F91F2177A
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 23:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F387FBC4;
	Mon,  3 Jun 2024 23:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLv9Qfxa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC9C1E49B
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717456649; cv=none; b=h0LgjJk3HkEIqqxTo6vGWS9omBcX8yA/YIYx353+A4iinC7WkucBnlccAnr0oekk4ENyUb+WDcGB0dl7pXk70BN5djxj649Hvj8OzIqwgsUC9JL1uwaVctMYqNveA/73Sm2BPJ/9zVVMR3T6Kl6xDoqp4EFQ1cxlEp+iVxKpS64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717456649; c=relaxed/simple;
	bh=wgURctIi1LwJjXH+1P6dh8Khp9vi/0PcWH7V5U3i9dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHSwCd4xNWVqteKEl1bLHAhY69/3N1KwqCIrN7Gte475MmSIdGjFyEEo/TJs5cuFwOe1vGbywe0TtUxe8BPGgwmTrbFnLy4BD+8qA908tgjStFQteaICXD8wIx45kiQbr5dQ6+hzdJ7rw+FgZS4b1hxLImLIVBoK/O484ApUFhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLv9Qfxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836CFC2BD10;
	Mon,  3 Jun 2024 23:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717456648;
	bh=wgURctIi1LwJjXH+1P6dh8Khp9vi/0PcWH7V5U3i9dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLv9Qfxah1+LrnZ6FzM9k4uUA7qPhWiSBpWXAxiD/fNQS8e6w61/5Yh+DufSyuDHQ
	 kESs4MjIS6fbOBMimE0jIU0hgLcyuXszoSiji61ekcsrj9Iv4fF49ZVha/kJcP9JAA
	 HifDp0hELkTgbS+qpbJY5WfvKhqovMGGitBEMCrClI+LS7x7JhYo+mx7JOW83KSJVv
	 uJML9ZmSFBFHu1SU6SF2ZubAf5GdPSuv+t3daI8jkS11iaF5x5kwPfwX17URfSYRoX
	 zy30h0LGiolEEg6KFAXdKrnsR+Kr6zqdhbN8iIBGrlJNByiGIob+lnVztr1iwWeI6a
	 LbhvUUO0mbSxw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: alan.maguire@oracle.com,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 1/5] libbpf: add BTF field iterator
Date: Mon,  3 Jun 2024 16:17:15 -0700
Message-ID: <20240603231720.1893487-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603231720.1893487-1-andrii@kernel.org>
References: <20240603231720.1893487-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement iterator-based type ID and string offset BTF field iterator.
This is used extensively in BTF-handling code and BPF linker code for
various sanity checks, rewriting IDs/offsets, etc. Currently this is
implemented as visitor pattern calling custom callbacks, which makes the
logic (especially in simple cases) unnecessarily obscure and harder to
follow.

Having equivalent functionality using iterator pattern makes for simpler
to understand and maintain code. As we add more code for BTF processing
logic in libbpf, it's best to switch to iterator pattern before adding
more callback-based code.

The idea for iterator-based implementation is to record offsets of
necessary fields within fixed btf_type parts (which should be iterated
just once), and, for kinds that have multiple members (based on vlen
field), record where in each member necessary fields are located.

Generic iteration code then just keeps track of last offset that was
returned and handles N members correctly. Return type is just u32
pointer, where NULL is returned when all relevant fields were already
iterated.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c             | 162 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  24 +++++
 2 files changed, 186 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 2d0840ef599a..50ff8b6eaf36 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5133,6 +5133,168 @@ int btf_type_visit_str_offs(struct btf_type *t, str_off_visit_fn visit, void *ct
 	return 0;
 }
 
+int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t, enum btf_field_iter_kind iter_kind)
+{
+	it->p = NULL;
+	it->m_idx = -1;
+	it->off_idx = 0;
+	it->vlen = 0;
+
+	switch (iter_kind) {
+	case BTF_FIELD_ITER_IDS:
+		switch (btf_kind(t)) {
+		case BTF_KIND_UNKN:
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
+			it->desc = (struct btf_field_desc) {};
+			break;
+		case BTF_KIND_FWD:
+		case BTF_KIND_CONST:
+		case BTF_KIND_VOLATILE:
+		case BTF_KIND_RESTRICT:
+		case BTF_KIND_PTR:
+		case BTF_KIND_TYPEDEF:
+		case BTF_KIND_FUNC:
+		case BTF_KIND_VAR:
+		case BTF_KIND_DECL_TAG:
+		case BTF_KIND_TYPE_TAG:
+			it->desc = (struct btf_field_desc) { 1, {offsetof(struct btf_type, type)} };
+			break;
+		case BTF_KIND_ARRAY:
+			it->desc = (struct btf_field_desc) {
+				2, {sizeof(struct btf_type) + offsetof(struct btf_array, type),
+				    sizeof(struct btf_type) + offsetof(struct btf_array, index_type)}
+			};
+			break;
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+			it->desc = (struct btf_field_desc) {
+				0, {},
+				sizeof(struct btf_member),
+				1, {offsetof(struct btf_member, type)}
+			};
+			break;
+		case BTF_KIND_FUNC_PROTO:
+			it->desc = (struct btf_field_desc) {
+				1, {offsetof(struct btf_type, type)},
+				sizeof(struct btf_param),
+				1, {offsetof(struct btf_param, type)}
+			};
+			break;
+		case BTF_KIND_DATASEC:
+			it->desc = (struct btf_field_desc) {
+				0, {},
+				sizeof(struct btf_var_secinfo),
+				1, {offsetof(struct btf_var_secinfo, type)}
+			};
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case BTF_FIELD_ITER_STRS:
+		switch (btf_kind(t)) {
+		case BTF_KIND_UNKN:
+			it->desc = (struct btf_field_desc) {};
+			break;
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_FWD:
+		case BTF_KIND_ARRAY:
+		case BTF_KIND_CONST:
+		case BTF_KIND_VOLATILE:
+		case BTF_KIND_RESTRICT:
+		case BTF_KIND_PTR:
+		case BTF_KIND_TYPEDEF:
+		case BTF_KIND_FUNC:
+		case BTF_KIND_VAR:
+		case BTF_KIND_DECL_TAG:
+		case BTF_KIND_TYPE_TAG:
+		case BTF_KIND_DATASEC:
+			it->desc = (struct btf_field_desc) {
+				1, {offsetof(struct btf_type, name_off)}
+			};
+			break;
+		case BTF_KIND_ENUM:
+			it->desc = (struct btf_field_desc) {
+				1, {offsetof(struct btf_type, name_off)},
+				sizeof(struct btf_enum),
+				1, {offsetof(struct btf_enum, name_off)}
+			};
+			break;
+		case BTF_KIND_ENUM64:
+			it->desc = (struct btf_field_desc) {
+				1, {offsetof(struct btf_type, name_off)},
+				sizeof(struct btf_enum64),
+				1, {offsetof(struct btf_enum64, name_off)}
+			};
+			break;
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+			it->desc = (struct btf_field_desc) {
+				1, {offsetof(struct btf_type, name_off)},
+				sizeof(struct btf_member),
+				1, {offsetof(struct btf_member, name_off)}
+			};
+			break;
+		case BTF_KIND_FUNC_PROTO:
+			it->desc = (struct btf_field_desc) {
+				1, {offsetof(struct btf_type, name_off)},
+				sizeof(struct btf_param),
+				1, {offsetof(struct btf_param, name_off)}
+			};
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (it->desc.m_sz)
+		it->vlen = btf_vlen(t);
+
+	it->p = t;
+	return 0;
+}
+
+__u32 *btf_field_iter_next(struct btf_field_iter *it)
+{
+	if (!it->p)
+		return NULL;
+
+	if (it->m_idx < 0) {
+		if (it->off_idx < it->desc.t_cnt)
+			return it->p + it->desc.t_offs[it->off_idx++];
+		/* move to per-member iteration */
+		it->m_idx = 0;
+		it->p += sizeof(struct btf_type);
+		it->off_idx = 0;
+	}
+
+	/* if type doesn't have members, stop */
+	if (it->desc.m_sz == 0) {
+		it->p = NULL;
+		return NULL;
+	}
+
+	if (it->off_idx >= it->desc.m_cnt) {
+		/* exhausted this member's fields, go to the next member */
+		it->m_idx++;
+		it->p += it->desc.m_sz;
+		it->off_idx = 0;
+	}
+
+	if (it->m_idx < it->vlen)
+		return it->p + it->desc.m_offs[it->off_idx++];
+
+	it->p = NULL;
+	return NULL;
+}
+
 int btf_ext_visit_type_ids(struct btf_ext *btf_ext, type_id_visit_fn visit, void *ctx)
 {
 	const struct btf_ext_info *seg;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 7e7e686008c6..80f3d346db33 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -508,6 +508,30 @@ struct bpf_line_info_min {
 	__u32	line_col;
 };
 
+enum btf_field_iter_kind {
+	BTF_FIELD_ITER_IDS,
+	BTF_FIELD_ITER_STRS,
+};
+
+struct btf_field_desc {
+	/* once-per-type offsets */
+	int t_cnt, t_offs[2];
+	/* member struct size, or zero, if no members */
+	int m_sz;
+	/* repeated per-member offsets */
+	int m_cnt, m_offs[1];
+};
+
+struct btf_field_iter {
+	struct btf_field_desc desc;
+	void *p;
+	int m_idx;
+	int off_idx;
+	int vlen;
+};
+
+int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t, enum btf_field_iter_kind iter_kind);
+__u32 *btf_field_iter_next(struct btf_field_iter *it);
 
 typedef int (*type_id_visit_fn)(__u32 *type_id, void *ctx);
 typedef int (*str_off_visit_fn)(__u32 *str_off, void *ctx);
-- 
2.43.0


