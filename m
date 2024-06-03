Return-Path: <bpf+bounces-31276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F9C8FA652
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 01:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E611228AAE5
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 23:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1B483CDA;
	Mon,  3 Jun 2024 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2mf6lFK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768881E49B
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717456652; cv=none; b=R22eqxX3WcSgNHDjmNiE26DxR0tPBQ2peFLNfyNu2KdJMR4aIjYDONCix21qgXWhWb7nRHQ6yDYWZZr2GKNH/QtTyapUOo4JUfYJGVholKDPzl/hkVjomWH5xT+YSxOthAh3p8amHLbO5HzQc6LxHKVDD5iFks1kwb+f2jnkOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717456652; c=relaxed/simple;
	bh=oTVSjxR+jA2OgYfl8Msx3bwXu90sHWszDziL9fwBy3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uu928kCIBPjxGPe0uOZSktv5hJsfn+k9ZBDu+nWLkfq95N5CwrbgcFQl9YkEz1In72ZdA19HxQIII/EIC+5XHfpbU6iiVDsYhuRKMhIYUisN9Myzsux/Dnj0uzh5oDIIVPk6wrAypXWyt7AZ4dA02BGbyoRbOXqzWW/IUE8graQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2mf6lFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE82C32782;
	Mon,  3 Jun 2024 23:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717456652;
	bh=oTVSjxR+jA2OgYfl8Msx3bwXu90sHWszDziL9fwBy3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P2mf6lFKX/MR45XeqxZYeKkPmdZT109LFXBA36gmN7HQrmXNAPZ4j2XSfVu6V8/MR
	 NYUtk15fC3CN3zz1PUgydyLuF0ft2Ym4Oc3FGHA4jyBNkrX7QSSquPAHIkjnQ1Y3fk
	 KpaR++VSP02Y8iYfMa62qYvc1fPhQ5JQ9TKS3YJ1faFoorQtd489cDDdqdLa3S5/PO
	 o7NATCeqwo7V2gAYI/awIEzfdySCAoHShTsU+uWdfp8NlDsf0RyAkAdFlPhuME0Cmj
	 fwv5GPmbpDdLHE1/zRzLAT2C+qOj/HQGDbAqpgmUts/9Kxr5H0GEeIlChqruthfIDA
	 eWHhLnl7KUQVw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: alan.maguire@oracle.com,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 2/5] libbpf: make use of BTF field iterator in BPF linker code
Date: Mon,  3 Jun 2024 16:17:16 -0700
Message-ID: <20240603231720.1893487-3-andrii@kernel.org>
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

Switch all BPF linker code dealing with iterating BTF type ID and string
offset fields to new btf_field_iter facilities.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/linker.c | 60 ++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 0d4be829551b..be6539e59cf6 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -957,19 +957,35 @@ static int check_btf_str_off(__u32 *str_off, void *ctx)
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
+		const char *s;
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
+			s = btf__str_by_offset(obj->btf, *str_off);
+			if (!s)
+				return -EINVAL;
+		}
 	}
 
 	return 0;
@@ -2234,26 +2250,10 @@ static int linker_fixup_btf(struct src_obj *obj)
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
@@ -2324,9 +2324,25 @@ static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
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


