Return-Path: <bpf+bounces-31396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D908FC057
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 02:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5B50B21A24
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 00:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEFA33F7;
	Wed,  5 Jun 2024 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImTCa4a6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475C02F24
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717546598; cv=none; b=s1ZYDsaBbCuPoAzu3syD0RKNcKUVsnH82N9ogdEeu0L/OErNZA2IU/lFQRLrMARqBMGMgZuksDbfftFbN/3gpk8aqQcYzgnBfb3gtvPlTfs6Gb9MK7ZwDG8Nn6sORRM/559R7YIXIv1mezNE1Q02WMc+RDagePvOlgugIdcH3QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717546598; c=relaxed/simple;
	bh=xxDNRubN/LLUk5V3yLdjczII6UnUKI+bzcpSG0lYOWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QM5WFtc8M1KfPBPYXacmUjtnI6pCCvWIsb3lT+08tPmbo/x9hscCOXc25JAj4zEA0lda5fGNMwfHJ3vwyd4Vlso2EobIH84fT7nghxrh+6QEDj+Bi3udnXuYRF5Hhb2VKBV65KXqF0lQ2zW41HJvQxEKLZNE4CUJiRGm9i0+/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImTCa4a6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFF0C2BBFC;
	Wed,  5 Jun 2024 00:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717546598;
	bh=xxDNRubN/LLUk5V3yLdjczII6UnUKI+bzcpSG0lYOWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ImTCa4a6G64Ga3URpHEx4D9pYfQDwK6pD7AawILsvojFqp3jnu0hpY5uW/BMdekK3
	 3QjkWI9J3TKtksXxo6Pi2uOC0DWs1FKQJnXe7xXn3QBJOflk7LEsdEzlXwQC8+q6SI
	 jODjTCZg8Oz/zVah5vuA6zDid0U32aaClS3CD/M20gWLjwGpQvbshzKakrR6hNyBs/
	 tqeDrArdyU7d/nsMYub+5QrE6oqfmB+aPr02HJzNVVi+aem2BFmsabPdp2ktiXS5qI
	 QQWVuwx4jmQKlfzg7WR+HABVjN/UHrJcREUqlUGAj7nRD7AGkrVp7WoBCXKmeo9iJ2
	 WsCyoOTr3lrQg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: alan.maguire@oracle.com,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 2/5] libbpf: make use of BTF field iterator in BPF linker code
Date: Tue,  4 Jun 2024 17:16:26 -0700
Message-ID: <20240605001629.4061937-3-andrii@kernel.org>
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

Switch all BPF linker code dealing with iterating BTF type ID and string
offset fields to new btf_field_iter facilities.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c             |  4 +--
 tools/lib/bpf/libbpf_internal.h |  4 +--
 tools/lib/bpf/linker.c          | 58 ++++++++++++++++++++-------------
 3 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 50ff8b6eaf36..d72260ac26a5 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5267,7 +5267,7 @@ __u32 *btf_field_iter_next(struct btf_field_iter *it)
 		return NULL;
 
 	if (it->m_idx < 0) {
-		if (it->off_idx < it->desc.t_cnt)
+		if (it->off_idx < it->desc.t_off_cnt)
 			return it->p + it->desc.t_offs[it->off_idx++];
 		/* move to per-member iteration */
 		it->m_idx = 0;
@@ -5281,7 +5281,7 @@ __u32 *btf_field_iter_next(struct btf_field_iter *it)
 		return NULL;
 	}
 
-	if (it->off_idx >= it->desc.m_cnt) {
+	if (it->off_idx >= it->desc.m_off_cnt) {
 		/* exhausted this member's fields, go to the next member */
 		it->m_idx++;
 		it->p += it->desc.m_sz;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 80f3d346db33..96c0b0993f8b 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -515,11 +515,11 @@ enum btf_field_iter_kind {
 
 struct btf_field_desc {
 	/* once-per-type offsets */
-	int t_cnt, t_offs[2];
+	int t_off_cnt, t_offs[2];
 	/* member struct size, or zero, if no members */
 	int m_sz;
 	/* repeated per-member offsets */
-	int m_cnt, m_offs[1];
+	int m_off_cnt, m_offs[1];
 };
 
 struct btf_field_iter {
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 0d4be829551b..fa11a671da3e 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -957,19 +957,33 @@ static int check_btf_str_off(__u32 *str_off, void *ctx)
 static int linker_sanity_check_btf(struct src_obj *obj)
 {
 	struct btf_type *t;
-	int i, n, err = 0;
+	int i, n, err;
 
 	if (!obj->btf)
 		return 0;
 
 	n = btf__type_cnt(obj->btf);
 	for (i = 1; i < n; i++) {
+		struct btf_field_iter it;
+		__u32 *type_id, *str_off;
+
 		t = btf_type_by_id(obj->btf, i);
 
-		err = err ?: btf_type_visit_type_ids(t, check_btf_type_id, obj->btf);
-		err = err ?: btf_type_visit_str_offs(t, check_btf_str_off, obj->btf);
+		err = btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
 		if (err)
 			return err;
+		while ((type_id = btf_field_iter_next(&it))) {
+			if (*type_id >= n)
+				return -EINVAL;
+		}
+
+		err = btf_field_iter_init(&it, t, BTF_FIELD_ITER_STRS);
+		if (err)
+			return err;
+		while ((str_off = btf_field_iter_next(&it))) {
+			if (!btf__str_by_offset(obj->btf, *str_off))
+				return -EINVAL;
+		}
 	}
 
 	return 0;
@@ -2234,26 +2248,10 @@ static int linker_fixup_btf(struct src_obj *obj)
 	return 0;
 }
 
-static int remap_type_id(__u32 *type_id, void *ctx)
-{
-	int *id_map = ctx;
-	int new_id = id_map[*type_id];
-
-	/* Error out if the type wasn't remapped. Ignore VOID which stays VOID. */
-	if (new_id == 0 && *type_id != 0) {
-		pr_warn("failed to find new ID mapping for original BTF type ID %u\n", *type_id);
-		return -EINVAL;
-	}
-
-	*type_id = id_map[*type_id];
-
-	return 0;
-}
-
 static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
 {
 	const struct btf_type *t;
-	int i, j, n, start_id, id;
+	int i, j, n, start_id, id, err;
 	const char *name;
 
 	if (!obj->btf)
@@ -2324,9 +2322,25 @@ static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
 	n = btf__type_cnt(linker->btf);
 	for (i = start_id; i < n; i++) {
 		struct btf_type *dst_t = btf_type_by_id(linker->btf, i);
+		struct btf_field_iter it;
+		__u32 *type_id;
 
-		if (btf_type_visit_type_ids(dst_t, remap_type_id, obj->btf_type_map))
-			return -EINVAL;
+		err = btf_field_iter_init(&it, dst_t, BTF_FIELD_ITER_IDS);
+		if (err)
+			return err;
+
+		while ((type_id = btf_field_iter_next(&it))) {
+			int new_id = obj->btf_type_map[*type_id];
+
+			/* Error out if the type wasn't remapped. Ignore VOID which stays VOID. */
+			if (new_id == 0 && *type_id != 0) {
+				pr_warn("failed to find new ID mapping for original BTF type ID %u\n",
+					*type_id);
+				return -EINVAL;
+			}
+
+			*type_id = obj->btf_type_map[*type_id];
+		}
 	}
 
 	/* Rewrite VAR/FUNC underlying types (i.e., FUNC's FUNC_PROTO and VAR's
-- 
2.43.0


