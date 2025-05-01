Return-Path: <bpf+bounces-57171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05F3AA678F
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 01:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7AA4629AA
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 23:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371BC1DFDB9;
	Thu,  1 May 2025 23:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXErRMmH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F13D6A
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 23:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746143560; cv=none; b=R1jdxX3o20Uv3J8pnA/3UXNbBH2UUWQ3J6m2T3u7sAd+u72qjGgyFGW6LjShBs+pO/YeoLL+3VzMBNr9g9WjuiptrjYhDBhB8WLxKATnRxVZornqE5wrl7kDU65YC9eDoAWkaTxaonRZtrVdNhXftisld4zc9hbUknES6jqjPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746143560; c=relaxed/simple;
	bh=2ECGobiWAIoYp+BvSvYTqwpPAYFyJ7KER55drs900ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ad8HV8MupplVpkLVfgxQSHQnLbPJKT7duVHiDlEruhyVbO4qhu2ejvNb+a4aznZ/1A2PUKLz6rzGnYxummDnWCfCvJaTR3JTC1y5ai2VTWKK9reZnWnaroV7rXymbqle/DpiAveC8EVn2uAgBdYWJYkG+PEAa+vT4b5z4GQiNHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXErRMmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BED1C4CEE3;
	Thu,  1 May 2025 23:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746143560;
	bh=2ECGobiWAIoYp+BvSvYTqwpPAYFyJ7KER55drs900ZQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EXErRMmHVKniD48nzLYyR/zCZDkcqd2z/xCRC9Y/1YvsEZLC6MXGIIJ4DHD7f/LBr
	 PqHHghCrVeDWip9l4zaW6Cr515HRr/lMPSXjGUSXlNsmVOCtY1CKSvO3Cn9mEz2Olu
	 wBGIP69z+hn5KBvsQeTQBzUdbCyQhJeaX/yhKGF/rlmtJ+RMOw3/vUzwaGMHObdETi
	 FD8AKggbt2cEZSD4BQwWk9agFaHsNiy7uig5PlVV9ZiaJMVXcpBnzwNYjSuIRzWT/S
	 DCYiJq/+rC6CQDIi+J4qmpaGAR4VwC+MvC25MQDx4q/VhPcauMop+nGmbzXBPnEhmZ
	 a/Rx8mIq7eSdw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] libbpf: improve BTF dedup handling of "identical" BTF types
Date: Thu,  1 May 2025 16:52:31 -0700
Message-ID: <20250501235231.1339822-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BTF dedup has a strong assumption that compiler with deduplicate identical
types within any given compilation unit (i.e., .c file). This property
is used when establishing equilvalence of two subgraphs of types.

Unfortunately, this property doesn't always holds in practice. We've
seen cases of having truly identical structs, unions, array definitions,
and, most recently, even pointers to the same type being duplicated
within CU.

Previously, we mitigated this on a case-by-case basis, adding a few
simple heuristics for validating that two BTF types (having two
different type IDs) are structurally the same. But this approach scales
poorly, and we can have more weird cases come up in the future.

So let's take a half-step back, and implement a bit more generic
structural equivalence check, recursively. We still limit it to
reasonable depth to avoid long reference loops. Depth-wise limiting of
potentially cyclical graph isn't great, but as I mentioned below doesn't
seem to be detrimental performance-wise. We can always improve this in
the future with per-type visited markers, if necessary.

Performance-wise this doesn't seem too affect vmlinux BTF dedup, which
makes sense because this logic kicks in not so frequently and only if we
already established a canonical candidate type match, but suddenly find
a different (but probably identical) type.

On the other hand, this seems to help to reduce duplication across many
kernel modules. In my local test, I had 639 kernel module built. Overall
.BTF sections size goes down from 41MB bytes down to 5MB (!), which is
pretty impressive for such a straightforward piece of logic added. But
it would be nice to validate independently just in case my bash and
Python-fu is broken.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c | 137 ++++++++++++++++++++++++++++----------------
 1 file changed, 89 insertions(+), 48 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b7513d4cce55..f18d7e6a453c 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4356,59 +4356,109 @@ static inline __u16 btf_fwd_kind(struct btf_type *t)
 	return btf_kflag(t) ? BTF_KIND_UNION : BTF_KIND_STRUCT;
 }
 
-/* Check if given two types are identical ARRAY definitions */
-static bool btf_dedup_identical_arrays(struct btf_dedup *d, __u32 id1, __u32 id2)
+static bool btf_dedup_identical_types(struct btf_dedup *d, __u32 id1, __u32 id2, int depth)
 {
 	struct btf_type *t1, *t2;
+	int k1, k2;
+recur:
+	if (depth <= 0)
+		return false;
 
 	t1 = btf_type_by_id(d->btf, id1);
 	t2 = btf_type_by_id(d->btf, id2);
-	if (!btf_is_array(t1) || !btf_is_array(t2))
+
+	k1 = btf_kind(t1);
+	k2 = btf_kind(t2);
+	if (k1 != k2)
 		return false;
 
-	return btf_equal_array(t1, t2);
-}
+	switch (k1) {
+	case BTF_KIND_UNKN: /* VOID */
+		return true;
+	case BTF_KIND_INT:
+		return btf_equal_int_tag(t1, t2);
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
+		return btf_compat_enum(t1, t2);
+	case BTF_KIND_FWD:
+	case BTF_KIND_FLOAT:
+		return btf_equal_common(t1, t2);
+	case BTF_KIND_CONST:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_PTR:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_FUNC:
+	case BTF_KIND_TYPE_TAG:
+		if (t1->info != t2->info || t1->name_off != t2->name_off)
+			return false;
+		id1 = t1->type;
+		id2 = t2->type;
+		goto recur;
+	case BTF_KIND_ARRAY: {
+		struct btf_array *a1, *a2;
 
-/* Check if given two types are identical STRUCT/UNION definitions */
-static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id2)
-{
-	const struct btf_member *m1, *m2;
-	struct btf_type *t1, *t2;
-	int n, i;
+		if (!btf_compat_array(t1, t2))
+			return false;
 
-	t1 = btf_type_by_id(d->btf, id1);
-	t2 = btf_type_by_id(d->btf, id2);
+		a1 = btf_array(t1);
+		a2 = btf_array(t1);
 
-	if (!btf_is_composite(t1) || btf_kind(t1) != btf_kind(t2))
-		return false;
+		if (a1->index_type != a2->index_type &&
+		    !btf_dedup_identical_types(d, a1->index_type, a2->index_type, depth - 1))
+			return false;
 
-	if (!btf_shallow_equal_struct(t1, t2))
-		return false;
+		if (a1->type != a2->type &&
+		    !btf_dedup_identical_types(d, a1->type, a2->type, depth - 1))
+			return false;
 
-	m1 = btf_members(t1);
-	m2 = btf_members(t2);
-	for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
-		if (m1->type != m2->type &&
-		    !btf_dedup_identical_arrays(d, m1->type, m2->type) &&
-		    !btf_dedup_identical_structs(d, m1->type, m2->type))
+		return true;
+	}
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION: {
+		const struct btf_member *m1, *m2;
+		int i, n;
+
+		if (!btf_shallow_equal_struct(t1, t2))
 			return false;
+
+		m1 = btf_members(t1);
+		m2 = btf_members(t2);
+		for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
+			if (m1->type == m2->type)
+				continue;
+			if (!btf_dedup_identical_types(d, m1->type, m2->type, depth - 1))
+				return false;
+		}
+		return true;
 	}
-	return true;
-}
+	case BTF_KIND_FUNC_PROTO: {
+		const struct btf_param *p1, *p2;
+		int i, n;
 
-static bool btf_dedup_identical_ptrs(struct btf_dedup *d, __u32 id1, __u32 id2)
-{
-	struct btf_type *t1, *t2;
+		if (!btf_compat_fnproto(t1, t2))
+			return false;
 
-	t1 = btf_type_by_id(d->btf, id1);
-	t2 = btf_type_by_id(d->btf, id2);
+		if (t1->type != t2->type &&
+		    !btf_dedup_identical_types(d, t1->type, t2->type, depth - 1))
+			return false;
 
-	if (!btf_is_ptr(t1) || !btf_is_ptr(t2))
+		p1 = btf_params(t1);
+		p2 = btf_params(t2);
+		for (i = 0, n = btf_vlen(t1); i < n; i++, p1++, p2++) {
+			if (p1->type == p2->type)
+				continue;
+			if (!btf_dedup_identical_types(d, p1->type, p2->type, depth - 1))
+				return false;
+		}
+		return true;
+	}
+	default:
 		return false;
-
-	return t1->type == t2->type;
+	}
 }
 
+
 /*
  * Check equivalence of BTF type graph formed by candidate struct/union (we'll
  * call it "candidate graph" in this description for brevity) to a type graph
@@ -4527,22 +4577,13 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		 * different fields within the *same* struct. This breaks type
 		 * equivalence check, which makes an assumption that candidate
 		 * types sub-graph has a consistent and deduped-by-compiler
-		 * types within a single CU. So work around that by explicitly
-		 * allowing identical array types here.
+		 * types within a single CU. And similar situation can happen
+		 * with struct/union sometimes, and event with pointers.
+		 * So accommodate cases like this doing a structural
+		 * comparison recursively, but avoiding being stuck in endless
+		 * loops by limiting the depth up to which we check.
 		 */
-		if (btf_dedup_identical_arrays(d, hypot_type_id, cand_id))
-			return 1;
-		/* It turns out that similar situation can happen with
-		 * struct/union sometimes, sigh... Handle the case where
-		 * structs/unions are exactly the same, down to the referenced
-		 * type IDs. Anything more complicated (e.g., if referenced
-		 * types are different, but equivalent) is *way more*
-		 * complicated and requires a many-to-many equivalence mapping.
-		 */
-		if (btf_dedup_identical_structs(d, hypot_type_id, cand_id))
-			return 1;
-		/* A similar case is again observed for PTRs. */
-		if (btf_dedup_identical_ptrs(d, hypot_type_id, cand_id))
+		if (btf_dedup_identical_types(d, hypot_type_id, cand_id, 16))
 			return 1;
 		return 0;
 	}
-- 
2.47.1


