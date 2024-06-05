Return-Path: <bpf+bounces-31397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74258FC056
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 02:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7106E1F23792
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 00:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557294A1E;
	Wed,  5 Jun 2024 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzzR5T3H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FC3D9E
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 00:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717546601; cv=none; b=lurgf7rFYUR6GC89WwNtqrCrVYfzY2K/15WZqZ074nZNvFwGY9mqToEqtdDRV6ghxXZo5sFWxmYW88yMuAHtJ6svuFkmhQyQkSJ0vUkLIlewqcQ9zESsXNNGzHEWCkBpdn868cbHWUN0R2Re50/lFkMn8NEO4KA+7CbXnrB01N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717546601; c=relaxed/simple;
	bh=FL+p12EBMF93yKnF6PwP+VHMUurX2lw3XffaiTzLIY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+VVU41z23CvEbbfRYGn05d9fMPYcJhwCreoCc0IgRYVNMuQLJ9gWMQ9Q9J8hF0xGInuZGjQ4kvuHHLf7EeWqay5HVDSjifWZAMEJU6QMf8SyCbUvfDTLxO3UQouh4qCbye5CoVhanxXGhRi9olgE9pEg++qGRIL9oazH7F9fzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzzR5T3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E98DC2BBFC;
	Wed,  5 Jun 2024 00:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717546601;
	bh=FL+p12EBMF93yKnF6PwP+VHMUurX2lw3XffaiTzLIY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gzzR5T3Hcw02Xe6x/QDJxqi+ad9pINcaQ6mEGUIX0rHKMHD/OCRN+eXbNn7YyVid8
	 ItbtcI+JOC3nIJBme+gsphnYfNUe23ccMCd+Rj+7xLTNRXHF/wloAoqhUJOoSQUD+q
	 bY89+F/q3Ox2U/QIASF9sRn8hO8xghIQ35eAgpfmxcqJvjLN9MF07d6OPHG5JngPj0
	 vedKnQTD74Ff1PFVvydEzIhDNJ1DsWBUsLdi7fxtaKkDv+dgstmmV5KLvcTPsjPSMM
	 Op1KZSP1/CjLeetlH1KxQf9iP5i9Oa/2iGz8J+2/D46y05GMVr670ucp71cPKouA41
	 FcePFTWB6D7NA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: alan.maguire@oracle.com,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 3/5] libbpf: make use of BTF field iterator in BTF handling code
Date: Tue,  4 Jun 2024 17:16:27 -0700
Message-ID: <20240605001629.4061937-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605001629.4061937-1-andrii@kernel.org>
References: <20240605001629.4061937-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use new BTF field iterator logic to replace all the callback-based
visitor calls. There is still a .BTF.ext callback-based visitor APIs
that should be converted, which will happens as a follow up.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c | 76 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 22 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d72260ac26a5..0190fd819f58 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1739,9 +1739,8 @@ struct btf_pipe {
 	struct hashmap *str_off_map; /* map string offsets from src to dst */
 };
 
-static int btf_rewrite_str(__u32 *str_off, void *ctx)
+static int btf_rewrite_str(struct btf_pipe *p, __u32 *str_off)
 {
-	struct btf_pipe *p = ctx;
 	long mapped_off;
 	int off, err;
 
@@ -1774,7 +1773,9 @@ static int btf_rewrite_str(__u32 *str_off, void *ctx)
 int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_type *src_type)
 {
 	struct btf_pipe p = { .src = src_btf, .dst = btf };
+	struct btf_field_iter it;
 	struct btf_type *t;
+	__u32 *str_off;
 	int sz, err;
 
 	sz = btf_type_size(src_type);
@@ -1791,26 +1792,17 @@ int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_t
 
 	memcpy(t, src_type, sz);
 
-	err = btf_type_visit_str_offs(t, btf_rewrite_str, &p);
+	err = btf_field_iter_init(&it, t, BTF_FIELD_ITER_STRS);
 	if (err)
 		return libbpf_err(err);
 
-	return btf_commit_type(btf, sz);
-}
-
-static int btf_rewrite_type_ids(__u32 *type_id, void *ctx)
-{
-	struct btf *btf = ctx;
-
-	if (!*type_id) /* nothing to do for VOID references */
-		return 0;
+	while ((str_off = btf_field_iter_next(&it))) {
+		err = btf_rewrite_str(&p, str_off);
+		if (err)
+			return libbpf_err(err);
+	}
 
-	/* we haven't updated btf's type count yet, so
-	 * btf->start_id + btf->nr_types - 1 is the type ID offset we should
-	 * add to all newly added BTF types
-	 */
-	*type_id += btf->start_id + btf->nr_types - 1;
-	return 0;
+	return btf_commit_type(btf, sz);
 }
 
 static size_t btf_dedup_identity_hash_fn(long key, void *ctx);
@@ -1858,6 +1850,9 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 	memcpy(t, src_btf->types_data, data_sz);
 
 	for (i = 0; i < cnt; i++) {
+		struct btf_field_iter it;
+		__u32 *type_id, *str_off;
+
 		sz = btf_type_size(t);
 		if (sz < 0) {
 			/* unlikely, has to be corrupted src_btf */
@@ -1869,15 +1864,31 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 		*off = t - btf->types_data;
 
 		/* add, dedup, and remap strings referenced by this BTF type */
-		err = btf_type_visit_str_offs(t, btf_rewrite_str, &p);
+		err = btf_field_iter_init(&it, t, BTF_FIELD_ITER_STRS);
 		if (err)
 			goto err_out;
+		while ((str_off = btf_field_iter_next(&it))) {
+			err = btf_rewrite_str(&p, str_off);
+			if (err)
+				goto err_out;
+		}
 
 		/* remap all type IDs referenced from this BTF type */
-		err = btf_type_visit_type_ids(t, btf_rewrite_type_ids, btf);
+		err = btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
 		if (err)
 			goto err_out;
 
+		while ((type_id = btf_field_iter_next(&it))) {
+			if (!*type_id) /* nothing to do for VOID references */
+				continue;
+
+			/* we haven't updated btf's type count yet, so
+			 * btf->start_id + btf->nr_types - 1 is the type ID offset we should
+			 * add to all newly added BTF types
+			 */
+			*type_id += btf->start_id + btf->nr_types - 1;
+		}
+
 		/* go to next type data and type offset index entry */
 		t += sz;
 		off++;
@@ -3453,11 +3464,19 @@ static int btf_for_each_str_off(struct btf_dedup *d, str_off_visit_fn fn, void *
 	int i, r;
 
 	for (i = 0; i < d->btf->nr_types; i++) {
+		struct btf_field_iter it;
 		struct btf_type *t = btf_type_by_id(d->btf, d->btf->start_id + i);
+		__u32 *str_off;
 
-		r = btf_type_visit_str_offs(t, fn, ctx);
+		r = btf_field_iter_init(&it, t, BTF_FIELD_ITER_STRS);
 		if (r)
 			return r;
+
+		while ((str_off = btf_field_iter_next(&it))) {
+			r = fn(str_off, ctx);
+			if (r)
+				return r;
+		}
 	}
 
 	if (!d->btf_ext)
@@ -4919,10 +4938,23 @@ static int btf_dedup_remap_types(struct btf_dedup *d)
 
 	for (i = 0; i < d->btf->nr_types; i++) {
 		struct btf_type *t = btf_type_by_id(d->btf, d->btf->start_id + i);
+		struct btf_field_iter it;
+		__u32 *type_id;
 
-		r = btf_type_visit_type_ids(t, btf_dedup_remap_type_id, d);
+		r = btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
 		if (r)
 			return r;
+
+		while ((type_id = btf_field_iter_next(&it))) {
+			__u32 resolved_id, new_id;
+
+			resolved_id = resolve_type_id(d, *type_id);
+			new_id = d->hypot_map[resolved_id];
+			if (new_id > BTF_MAX_NR_TYPES)
+				return -EINVAL;
+
+			*type_id = new_id;
+		}
 	}
 
 	if (!d->btf_ext)
-- 
2.43.0


