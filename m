Return-Path: <bpf+bounces-75551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D37C88C04
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CDE9D34EF68
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C849D31BC95;
	Wed, 26 Nov 2025 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMenimB+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17E31A801
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147038; cv=none; b=r0QMUTaCw6OYQtLiXAa1nrAF09hKJ/ehMcgVRk1sTFTsARLRzxDbdLE6dwLXp0HFICSgvhOuRFnyuAaY7r1TznRaa0Vd3O9v/OAi3SwldZ9SqDx/oP26j+M+XighxY8SJIqE0NEHVQazdKws4iDZ5BUUSntNrjZ+YWFwXawdUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147038; c=relaxed/simple;
	bh=YJNPYvfz/GxoZXv79UmIYENyuKk2IR71wtQ8M88Szf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tWYsaDrXuRtKDANIf0S6AwbwKNcb9rBbboRtJPlid+IjvzZiNfTvvnqqXBrnjsI7hXjtOX0ACF/TSgNXBqnFB0S55ASLg141Y7jE2f7QQxY4z5LtzG0C76v/zTLupAdwiFxaUKcA5wsNCdUO4LG3m+69HrKlc/QAnxYyUE5oVvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMenimB+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b9387df58cso10233676b3a.3
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764147036; x=1764751836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4S21SvMIVWAPa44TWVxWwB/nChiaz6KYgp24im87ZU=;
        b=LMenimB+wyVQQmyBG71lF/9Nv1Wuudu14lRXLsJ0OQh2Q7VeAMO3c9bPrRzcPhUPlJ
         pUwDVSyf4l96H50Asxl8MeLcn/GoCspflqPB62WIt8BvjaqdD2J227lrNw00wBM4XKB9
         TzRvvuRNZVyuYtDC66B+BtZwrsTieqg684OL4pM5GW3YcGMe606WPNfHZ+/szs6uDN9R
         wVHuEg/N+qwZcscxw0RvPRWXfUhKNBGVsZI+/1BXGFxbcUYxtmkgx122lAkVX2589ScJ
         SB0UxIHmjKycruGvjo0Ax2+v7UeaLEWrPBeNOl3VKflxxEmbOnqOihjN0jkq3jBnyWZW
         KcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147036; x=1764751836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a4S21SvMIVWAPa44TWVxWwB/nChiaz6KYgp24im87ZU=;
        b=h4n3j6431ZgWDBGoA4YFA2iKdAz02T+4vsvGyCYQfeMI6cAppjKQfFIp+1xChBATAP
         QVc3gCMH7QzidP/eZDI3asfxNw68vVXsAW5BmtP6i3otwRLQia1gTSbq8BfxPu6BEQVw
         OPnHrSzkGMtNdyf6qi2OKJYZ4SgK+db92hPxMisbjJSn3baS2q9AqfdRZq7twKc/2p0P
         NTfbHzmGui67WvkAtd8ooMBhgPytyhIoUDH8oc7sn603dJV3KsS8h58+cbYeow8YLrnH
         og3aBVSha79P3Qydct0Tj3kB0uPv6rFOKvDTGbFy4xqtdVzTSG5FwoSfIITj0EhNAPzG
         E0Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWqWClQIPGtb+/ZABi8f6CjMZOmW61ul7MW+D+MmV+l9JkcsS0khRXdsmiGpn7bGtqwFoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgAC78lc8OY+vvRne4xdjkQ1qMsaN5kEQXq9zBqoHqRFvNsqma
	D4MMpWnP3rC6gTOz2QppRsga5tIuDUmIdyAK660jCCSLtVXWYycW+eQu
X-Gm-Gg: ASbGnctwLDAaK4Y8evBKzGLLq7yZLohwJx5pwF4cyROtF+IpWGXs7xs2mUgH+S0iK2G
	dXdj2UA33uX9zM4VXah8EAdtYq43eqbo/EWV93wrPGJMZ11iZNxu3HlqVYOpgKCRUcEpUUBX+XV
	8YXJyqtDMPw5kHJB05AsoevSN5HC1daLwXXfn9Mw4RSU7Y/aHm6xbJGnPBfRmhJCX52z4NYqzEW
	s9z7MBOPvPQC2QYHrRKmdpK5LMAuvBcZqQYwCzjac/qGi+TXgKbvStPAJSttQLPR+Yzpr9OEyV5
	Q5YwcecHLqawMlF2MwmGIxcigCm1VK4yDjaIB9R++oN51piWXErVnQuh5M/xYD3uw+3Dc6Ayj4L
	KJtovtWizVLNtNhhmysmS9GbPN45AeAfBTqL9DLWdnGW14V8XtTWQTi9/+8YO5Z/LP+4u+soiEH
	p4l8jQ+HTzpvMGMG8Z1wiUcNe5MaM=
X-Google-Smtp-Source: AGHT+IHKWn9NWkYUvRb9WwqZogORsd/GfhCKitXLaO71Cj/o/bBaypLjOcJ6zUVdxpMAoqry3FCk4Q==
X-Received: by 2002:a05:6a00:b53:b0:7ab:5e68:e204 with SMTP id d2e1a72fcca58-7ca8a043bb8mr6202036b3a.29.1764147035605;
        Wed, 26 Nov 2025 00:50:35 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023fd82sm20885721b3a.42.2025.11.26.00.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:50:34 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com,
	zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next v8 1/9] libbpf: Add BTF permutation support for type reordering
Date: Wed, 26 Nov 2025 16:50:17 +0800
Message-Id: <20251126085025.784288-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126085025.784288-1-dolinux.peng@gmail.com>
References: <20251126085025.784288-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Introduce btf__permute() API to allow in-place rearrangement of BTF types.
This function reorganizes BTF type order according to a provided array of
type IDs, updating all type references to maintain consistency.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 tools/lib/bpf/btf.c      | 119 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h      |  36 ++++++++++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 156 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 84a4b0abc8be..26ebc0234b9b 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5868,3 +5868,122 @@ int btf__relocate(struct btf *btf, const struct btf *base_btf)
 		btf->owns_base = false;
 	return libbpf_err(err);
 }
+
+struct btf_permute {
+	struct btf *btf;
+	__u32 *id_map;
+};
+
+/* Callback function to remap individual type ID references */
+static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
+{
+	struct btf_permute *p = ctx;
+	__u32 new_type_id = *type_id;
+
+	/* refer to the base BTF or VOID type */
+	if (new_type_id < p->btf->start_id)
+		return 0;
+
+	if (new_type_id >= btf__type_cnt(p->btf))
+		return -EINVAL;
+
+	*type_id = p->id_map[new_type_id - p->btf->start_id];
+	return 0;
+}
+
+int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
+		 const struct btf_permute_opts *opts)
+{
+	struct btf_permute p;
+	struct btf_ext *btf_ext;
+	void *nt, *new_types = NULL;
+	__u32 *order_map = NULL;
+	int err = 0, i;
+	__u32 id;
+
+	if (!OPTS_VALID(opts, btf_permute_opts) || id_map_cnt != btf->nr_types)
+		return libbpf_err(-EINVAL);
+
+	/* record the sequence of types */
+	order_map = calloc(id_map_cnt, sizeof(*id_map));
+	if (!order_map) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	new_types = calloc(btf->hdr->type_len, 1);
+	if (!new_types) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	if (btf_ensure_modifiable(btf)) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	for (i = 0; i < id_map_cnt; i++) {
+		id = id_map[i];
+		if (id < btf->start_id || id >= btf__type_cnt(btf)) {
+			err = -EINVAL;
+			goto done;
+		}
+		id -= btf->start_id;
+		/* cannot be mapped to the same ID */
+		if (order_map[id]) {
+			err = -EINVAL;
+			goto done;
+		}
+		order_map[id] = i + btf->start_id;
+	}
+
+	p.btf = btf;
+	p.id_map = id_map;
+	nt = new_types;
+	for (i = 0; i < id_map_cnt; i++) {
+		struct btf_field_iter it;
+		const struct btf_type *t;
+		__u32 *type_id;
+		int type_size;
+
+		id = order_map[i];
+		t = btf__type_by_id(btf, id);
+		type_size = btf_type_size(t);
+		memcpy(nt, t, type_size);
+
+		/* fix up referenced IDs for BTF */
+		err = btf_field_iter_init(&it, nt, BTF_FIELD_ITER_IDS);
+		if (err)
+			goto done;
+		while ((type_id = btf_field_iter_next(&it))) {
+			err = btf_permute_remap_type_id(type_id, &p);
+			if (err)
+				goto done;
+		}
+
+		nt += type_size;
+	}
+
+	/* fix up referenced IDs for btf_ext */
+	btf_ext = OPTS_GET(opts, btf_ext, NULL);
+	if (btf_ext) {
+		err = btf_ext_visit_type_ids(btf_ext, btf_permute_remap_type_id, &p);
+		if (err)
+			goto done;
+	}
+
+	for (nt = new_types, i = 0; i < id_map_cnt; i++) {
+		btf->type_offs[i] = nt - new_types;
+		nt += btf_type_size(nt);
+	}
+
+	free(order_map);
+	free(btf->types_data);
+	btf->types_data = new_types;
+	return 0;
+
+done:
+	free(order_map);
+	free(new_types);
+	return libbpf_err(err);
+}
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index cc01494d6210..ba67e5457e3a 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -281,6 +281,42 @@ LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
  */
 LIBBPF_API int btf__relocate(struct btf *btf, const struct btf *base_btf);
 
+struct btf_permute_opts {
+	size_t sz;
+	/* optional .BTF.ext info along the main BTF info */
+	struct btf_ext *btf_ext;
+	size_t :0;
+};
+#define btf_permute_opts__last_field btf_ext
+
+/**
+ * @brief **btf__permute()** performs in-place BTF type rearrangement
+ * @param btf BTF object to permute
+ * @param id_map Array mapping original type IDs to new IDs
+ * @param id_map_cnt Number of elements in @id_map
+ * @param opts Optional parameters for BTF extension updates
+ * @return 0 on success, negative error code on failure
+ *
+ * **btf__permute()** rearranges BTF types according to the specified ID mapping.
+ * The @id_map array defines the new type ID for each original type ID.
+ *
+ * For **base BTF**:
+ * - @id_map must include all types from ID 1 to `btf__type_cnt(btf)-1`
+ * - @id_map_cnt should be `btf__type_cnt(btf) - 1`
+ * - Mapping uses `id_map[original_id - 1] = new_id`
+ *
+ * For **split BTF**:
+ * - @id_map should cover only split types
+ * - @id_map_cnt should be `btf__type_cnt(btf) - btf__type_cnt(btf__base_btf(btf))`
+ * - Mapping uses `id_map[original_id - btf__type_cnt(btf__base_btf(btf))] = new_id`
+ *
+ * On error, returns negative error code and sets errno:
+ *   - `-EINVAL`: Invalid parameters or ID mapping (duplicates, out-of-range)
+ *   - `-ENOMEM`: Memory allocation failure
+ */
+LIBBPF_API int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
+			    const struct btf_permute_opts *opts);
+
 struct btf_dump;
 
 struct btf_dump_opts {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ed8749907d4..b778e5a5d0a8 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -451,4 +451,5 @@ LIBBPF_1.7.0 {
 	global:
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
+		btf__permute;
 } LIBBPF_1.6.0;
-- 
2.34.1


