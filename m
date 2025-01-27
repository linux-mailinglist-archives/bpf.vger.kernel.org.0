Return-Path: <bpf+bounces-49903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2781BA201C8
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BB31885DE1
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8351DDC21;
	Mon, 27 Jan 2025 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R7LN801A"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E141DC99A
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021209; cv=none; b=QJVRVh6pi5CGj95MZFECUdYxbv+9txYxx1g2WL0wbK8cRwTrVcdZlGPt4zmWq8Ol6WjitwuqnH4yW2RTiP8rTxBx+KiitTgg7M+ea+Q5qXzCNuZUJ+stJdSaR9JXjWjJ8Lb8zCV7x41eK3xCV0srtpoyhyoxXIhmNzoGPgdDl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021209; c=relaxed/simple;
	bh=PCOYDJiwxbVEs+4JReGlFrYwNK+scF3fXd8TpFeOA0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+xvpSlzvWD7TCOtIIqLMwT5wPTVjVPBduOrJQT+DnYus93gP/KUatVGLMa9vouu7mWECTySLpW4KWZo7C5jd4lUOA3ArsvAPp/U3Y+iprv+Vb6D4kJlhVJSuyXBHIqOaT8EqXaxAu63M1aOUkGcu+ktbJMospPcZf8mCKVmV1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R7LN801A; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738021204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3LQwwf7RuiXHTCYSns2BPyBCmC265HBOedZgb3p9PJ0=;
	b=R7LN801AoQVRAXbvVMQsIj8IonVmHlMvmSTrHnNoypqSLiWumXQrhHKnrUWsMeZEn86FO6
	sD2wffsN/aHEgnHpSSYb/gE2PO13ZktLxYFLSq5ckWRc6PszksVvApQMDbgTNUIT14O8s5
	OGj6bXP5QE93ehFcyLA4Pw9cfwh/pi4=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mykolal@fb.com,
	jose.marchesi@oracle.com
Subject: [PATCH bpf-next v2 1/6] libbpf: introduce kflag for type_tags and decl_tags in BTF
Date: Mon, 27 Jan 2025 15:39:50 -0800
Message-ID: <20250127233955.2275804-2-ihor.solodrai@linux.dev>
In-Reply-To: <20250127233955.2275804-1-ihor.solodrai@linux.dev>
References: <20250127233955.2275804-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the following functions to libbpf API:
  * btf__add_type_attr()
  * btf__add_decl_attr()

These functions allow to add to BTF the type tags and decl tags with
info->kflag set to 1. The kflag indicates that the tag directly
encodes an __attribute__ and not a normal tag.

See Documentation/bpf/btf.rst changes in the subsequent patch for
details on the semantics.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 86 +++++++++++++++++++++++++++++-----------
 tools/lib/bpf/btf.h      |  3 ++
 tools/lib/bpf/libbpf.map |  2 +
 3 files changed, 68 insertions(+), 23 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 48c66f3a9200..f21862bab755 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2090,7 +2090,7 @@ static int validate_type_id(int id)
 }
 
 /* generic append function for PTR, TYPEDEF, CONST/VOLATILE/RESTRICT */
-static int btf_add_ref_kind(struct btf *btf, int kind, const char *name, int ref_type_id)
+static int btf_add_ref_kind(struct btf *btf, int kind, const char *name, int ref_type_id, int kflag)
 {
 	struct btf_type *t;
 	int sz, name_off = 0;
@@ -2113,7 +2113,7 @@ static int btf_add_ref_kind(struct btf *btf, int kind, const char *name, int ref
 	}
 
 	t->name_off = name_off;
-	t->info = btf_type_info(kind, 0, 0);
+	t->info = btf_type_info(kind, 0, kflag);
 	t->type = ref_type_id;
 
 	return btf_commit_type(btf, sz);
@@ -2128,7 +2128,7 @@ static int btf_add_ref_kind(struct btf *btf, int kind, const char *name, int ref
  */
 int btf__add_ptr(struct btf *btf, int ref_type_id)
 {
-	return btf_add_ref_kind(btf, BTF_KIND_PTR, NULL, ref_type_id);
+	return btf_add_ref_kind(btf, BTF_KIND_PTR, NULL, ref_type_id, 0);
 }
 
 /*
@@ -2506,7 +2506,7 @@ int btf__add_fwd(struct btf *btf, const char *name, enum btf_fwd_kind fwd_kind)
 		struct btf_type *t;
 		int id;
 
-		id = btf_add_ref_kind(btf, BTF_KIND_FWD, name, 0);
+		id = btf_add_ref_kind(btf, BTF_KIND_FWD, name, 0, 0);
 		if (id <= 0)
 			return id;
 		t = btf_type_by_id(btf, id);
@@ -2536,7 +2536,7 @@ int btf__add_typedef(struct btf *btf, const char *name, int ref_type_id)
 	if (!name || !name[0])
 		return libbpf_err(-EINVAL);
 
-	return btf_add_ref_kind(btf, BTF_KIND_TYPEDEF, name, ref_type_id);
+	return btf_add_ref_kind(btf, BTF_KIND_TYPEDEF, name, ref_type_id, 0);
 }
 
 /*
@@ -2548,7 +2548,7 @@ int btf__add_typedef(struct btf *btf, const char *name, int ref_type_id)
  */
 int btf__add_volatile(struct btf *btf, int ref_type_id)
 {
-	return btf_add_ref_kind(btf, BTF_KIND_VOLATILE, NULL, ref_type_id);
+	return btf_add_ref_kind(btf, BTF_KIND_VOLATILE, NULL, ref_type_id, 0);
 }
 
 /*
@@ -2560,7 +2560,7 @@ int btf__add_volatile(struct btf *btf, int ref_type_id)
  */
 int btf__add_const(struct btf *btf, int ref_type_id)
 {
-	return btf_add_ref_kind(btf, BTF_KIND_CONST, NULL, ref_type_id);
+	return btf_add_ref_kind(btf, BTF_KIND_CONST, NULL, ref_type_id, 0);
 }
 
 /*
@@ -2572,7 +2572,7 @@ int btf__add_const(struct btf *btf, int ref_type_id)
  */
 int btf__add_restrict(struct btf *btf, int ref_type_id)
 {
-	return btf_add_ref_kind(btf, BTF_KIND_RESTRICT, NULL, ref_type_id);
+	return btf_add_ref_kind(btf, BTF_KIND_RESTRICT, NULL, ref_type_id, 0);
 }
 
 /*
@@ -2588,7 +2588,24 @@ int btf__add_type_tag(struct btf *btf, const char *value, int ref_type_id)
 	if (!value || !value[0])
 		return libbpf_err(-EINVAL);
 
-	return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id);
+	return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id, 0);
+}
+
+/*
+ * Append new BTF_KIND_TYPE_TAG type with:
+ *   - *value*, non-empty/non-NULL tag value;
+ *   - *ref_type_id* - referenced type ID, it might not exist yet;
+ * Set info->kflag to 1, indicating this tag is an __attribute__
+ * Returns:
+ *   - >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_type_attr(struct btf *btf, const char *value, int ref_type_id)
+{
+	if (!value || !value[0])
+		return libbpf_err(-EINVAL);
+
+	return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id, 1);
 }
 
 /*
@@ -2610,7 +2627,7 @@ int btf__add_func(struct btf *btf, const char *name,
 	    linkage != BTF_FUNC_EXTERN)
 		return libbpf_err(-EINVAL);
 
-	id = btf_add_ref_kind(btf, BTF_KIND_FUNC, name, proto_type_id);
+	id = btf_add_ref_kind(btf, BTF_KIND_FUNC, name, proto_type_id, 0);
 	if (id > 0) {
 		struct btf_type *t = btf_type_by_id(btf, id);
 
@@ -2845,18 +2862,8 @@ int btf__add_datasec_var_info(struct btf *btf, int var_type_id, __u32 offset, __
 	return 0;
 }
 
-/*
- * Append new BTF_KIND_DECL_TAG type with:
- *   - *value* - non-empty/non-NULL string;
- *   - *ref_type_id* - referenced type ID, it might not exist yet;
- *   - *component_idx* - -1 for tagging reference type, otherwise struct/union
- *     member or function argument index;
- * Returns:
- *   - >0, type ID of newly added BTF type;
- *   - <0, on error.
- */
-int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
-		 int component_idx)
+static int btf_add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
+			    int component_idx, int kflag)
 {
 	struct btf_type *t;
 	int sz, value_off;
@@ -2880,13 +2887,46 @@ int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
 		return value_off;
 
 	t->name_off = value_off;
-	t->info = btf_type_info(BTF_KIND_DECL_TAG, 0, false);
+	t->info = btf_type_info(BTF_KIND_DECL_TAG, 0, kflag);
 	t->type = ref_type_id;
 	btf_decl_tag(t)->component_idx = component_idx;
 
 	return btf_commit_type(btf, sz);
 }
 
+/*
+ * Append new BTF_KIND_DECL_TAG type with:
+ *   - *value* - non-empty/non-NULL string;
+ *   - *ref_type_id* - referenced type ID, it might not exist yet;
+ *   - *component_idx* - -1 for tagging reference type, otherwise struct/union
+ *     member or function argument index;
+ * Returns:
+ *   - >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
+		      int component_idx)
+{
+	return btf_add_decl_tag(btf, value, ref_type_id, component_idx, 0);
+}
+
+/*
+ * Append new BTF_KIND_DECL_TAG type with:
+ *   - *value* - non-empty/non-NULL string;
+ *   - *ref_type_id* - referenced type ID, it might not exist yet;
+ *   - *component_idx* - -1 for tagging reference type, otherwise struct/union
+ *     member or function argument index;
+ * Set info->kflag to 1, indicating this tag is an __attribute__
+ * Returns:
+ *   - >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_decl_attr(struct btf *btf, const char *value, int ref_type_id,
+		       int component_idx)
+{
+	return btf_add_decl_tag(btf, value, ref_type_id, component_idx, 1);
+}
+
 struct btf_ext_sec_info_param {
 	__u32 off;
 	__u32 len;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 47ee8f6ac489..4392451d634b 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -227,6 +227,7 @@ LIBBPF_API int btf__add_volatile(struct btf *btf, int ref_type_id);
 LIBBPF_API int btf__add_const(struct btf *btf, int ref_type_id);
 LIBBPF_API int btf__add_restrict(struct btf *btf, int ref_type_id);
 LIBBPF_API int btf__add_type_tag(struct btf *btf, const char *value, int ref_type_id);
+LIBBPF_API int btf__add_type_attr(struct btf *btf, const char *value, int ref_type_id);
 
 /* func and func_proto construction APIs */
 LIBBPF_API int btf__add_func(struct btf *btf, const char *name,
@@ -243,6 +244,8 @@ LIBBPF_API int btf__add_datasec_var_info(struct btf *btf, int var_type_id,
 /* tag construction API */
 LIBBPF_API int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
 			    int component_idx);
+LIBBPF_API int btf__add_decl_attr(struct btf *btf, const char *value, int ref_type_id,
+				  int component_idx);
 
 struct btf_dedup_opts {
 	size_t sz;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a8b2936a1646..8616e10b3c1b 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -436,4 +436,6 @@ LIBBPF_1.6.0 {
 		bpf_linker__add_buf;
 		bpf_linker__add_fd;
 		bpf_linker__new_fd;
+                btf__add_decl_attr;
+                btf__add_type_attr;
 } LIBBPF_1.5.0;
-- 
2.48.1


