Return-Path: <bpf+bounces-75035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3775C6C97C
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 04:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55487350D75
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 03:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7CC2F12AF;
	Wed, 19 Nov 2025 03:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNRXtCgG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401B42E92AB
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 03:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522506; cv=none; b=a1Cdr20RNDYAeZQf5GUq9FfmG+C7owyYZtdMvlfrxu65buMjOnQcZckaLeY5z79KFOWb6mSgLvFGVBcgUn/ah2GEd0qUnhIeA2cnBJCuW1hq6v3wF09ng9Rofq1BuUAwd4YDIGMJdG/OzzafJWTtbhtrGHLy9mps5gtN9+3ySz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522506; c=relaxed/simple;
	bh=H01WYWTjit4IDrTI6i2QFoyvRtKnaGfvGo11pfu3UXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RPEJ7XfuZT1rC8cLhiCYwgtw15zNpr7/NCW5X8vEDM+tOXFolyoOmyY5hCHtqsHY5Pg1bEff9kYEJHBmSBuA5luyMw20VgPynLk7f8I9WEUVbxLVJXufFaZkHeonRqEoHD5WacCRsHEcL1+065mVtbcQwBdxKbOJ9VKWO3HtfXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNRXtCgG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29844c68068so62871745ad.2
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 19:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763522503; x=1764127303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4Efz0DfhwaNbhU/ThUpGlzfbjEU0d17SrWYpmaJZf4=;
        b=KNRXtCgGAohG0AR7pskH6uDdatdM/pyuADSf7/3J8gz+ZlS91zMi85lbCZw0Ywa9W1
         7K4TZJGgx/DdZCmn5PhDCooyZhjiXAZ5lkXugP5ET55Izf96hWQt0jzYXU7VlMYsd8oO
         lYJbO4uqWiqqa3aE4Z+gB0ecj/ZalXpVUcLbSh/8xHm104NYjQCqckZBbM6aT0XKONAO
         0FKahA1/9uHLnZrCVRHtxxAUpFKIW/nP+GASSxdhZGFJsRaNERrd/Po5UCJ/prtWu/So
         kLe2E+DOUQ99MZgi1xaoJMBGw56QRRLYiikmtrvBUuF5ZXQZtvlKNnEAqZtB5D/m1lYq
         cX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763522503; x=1764127303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j4Efz0DfhwaNbhU/ThUpGlzfbjEU0d17SrWYpmaJZf4=;
        b=ihDeQ2sZmMDcNHG/jDDFROsp5tuAsyDiFXUztuaZYv5TXJGgDYg0eh4TGO+xnblW+G
         T6KF6pFQKaNVYmCrr4OMEaU+Ko5gQBFLzuynTIonKqFdevzV3HmZF/c93b63+dD27MS4
         kri/PAJf42XSQhEpdl70t24WlkssdTHiBsn85smjE9oziRoGgCASTMlt328pytGfOafV
         QbbNC7X0vS2Br3L+DObU/50PoD6z8r1gCsRvVf5t+wRKIpE1Vfi2T349v+IWQk9eRNbs
         8pY8rXMLEG2dB+tFW/V3Ky5fRs1etOArEfsCM7C9LRvgaYVF6fmG7ruoxz1qCnPdht/K
         QzlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdtwvyNwj8cJRlaY9+EBTIeitPBMEtK9Q1DHZNUq+g7aJ3WdZPG9FKela31yXDLL6zNCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMx4HJAPfJOV7eAbjnXzhTXT0qJi9woOJG7BDCYWBf+u64gp4W
	eFbsNWPuQQc8zl+OsdVOfJ//hWrwq6Vl5favEAJ/A8zPypf/FAaAjPFu
X-Gm-Gg: ASbGncs4hMXouPU6xKJ0IuNbTiNgY9OEFnh2pSE2xJXkDurh6d5yWdcsq8aVTFaT5i9
	6ykf43dA7fsAUh/m4J7aCB+SJVD2UMCXvuylDHvUFHhuoPh2j8lH6xItPn6cMmBVH9jSjO7ZAsu
	mV/mwzvSZF4jeNooyioh7Q3iiFixZ7W91KYi5AWaMLNSbgr+0slGfU8Soq+LHq7eYcLjfUp1+W9
	kK+7+rTisO14EhKigPspVYkUrD4vza23BPCImmubHUkBU9zok0N9w6ZH6OUNvWjiYfeOUQfyaBa
	nZwVgjzJfZnnMdqgXTfa/tHqPcbDWi4FAFnC/Q6gB7oy5cO7smHaJfIC7r8nxa/gRLS6lDDlsse
	MmeEauBrgtRUeoSSRSns3W/8Stdyxzq4PYxASlaU/dHiiLqIHKRaNDI8rSpGe5/C4vQvWFiM7FP
	WC/zp647nd2DGQgA8ES28P94FagytYM/+L5VjRDA==
X-Google-Smtp-Source: AGHT+IEhg8XZRWBMSEKpku63c8O1q1ZZte16uMZdW/35liLEU8vQeK8GgJdwK6G0silDHSovmO93kw==
X-Received: by 2002:a17:903:18c:b0:297:df8f:b056 with SMTP id d9443c01a7336-2986a6ba482mr241202595ad.11.1763522503541;
        Tue, 18 Nov 2025 19:21:43 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed5asm188352485ad.88.2025.11.18.19.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 19:21:42 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>
Subject: [RFC PATCH v7 1/7] libbpf: Add BTF permutation support for type reordering
Date: Wed, 19 Nov 2025 11:15:25 +0800
Message-Id: <20251119031531.1817099-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119031531.1817099-1-dolinux.peng@gmail.com>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

Introduce btf__permute() API to allow in-place rearrangement of BTF types.
This function reorganizes BTF type order according to a provided array of
type IDs, updating all type references to maintain consistency.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 tools/lib/bpf/btf.c      | 166 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h      |  43 ++++++++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 210 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 18907f0fcf9f..ab95ff19fde3 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5829,3 +5829,169 @@ int btf__relocate(struct btf *btf, const struct btf *base_btf)
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
+	/* skip references that point into the base BTF or VOID */
+	if (new_type_id < p->btf->start_id)
+		return 0;
+
+	/* invalid reference id */
+	if (new_type_id >= btf__type_cnt(p->btf))
+		return -EINVAL;
+
+	new_type_id = p->id_map[new_type_id - p->btf->start_id];
+	/* reference a dropped type is not allowed */
+	if (new_type_id == 0)
+		return -EINVAL;
+
+	*type_id = new_type_id;
+	return 0;
+}
+
+int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
+		 const struct btf_permute_opts *opts)
+{
+	struct btf_permute p;
+	struct btf_ext *btf_ext;
+	void *next_type, *end_type;
+	void *nt, *new_types = NULL;
+	int err = 0, i, new_type_len;
+	__u32 *order_map = NULL;
+	__u32 id, new_nr_types = 0;
+
+	if (!OPTS_VALID(opts, btf_permute_opts) || id_map_cnt != btf->nr_types)
+		return libbpf_err(-EINVAL);
+
+	/* used to record the storage sequence of types */
+	order_map = calloc(btf->nr_types, sizeof(*id_map));
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
+		/* Drop the specified type */
+		if (id == 0)
+			continue;
+		/* Invalid id  */
+		if (id < btf->start_id || id >= btf__type_cnt(btf)) {
+			err = -EINVAL;
+			goto done;
+		}
+		id -= btf->start_id;
+		/* Multiple types cannot be mapped to the same ID */
+		if (order_map[id]) {
+			err = -EINVAL;
+			goto done;
+		}
+		order_map[id] = i + btf->start_id;
+		new_nr_types = max(id + 1, new_nr_types);
+	}
+
+	/* Check for missing IDs */
+	for (i = 0; i < new_nr_types; i++) {
+		if (order_map[i] == 0) {
+			err = -EINVAL;
+			goto done;
+		}
+	}
+
+	p.btf = btf;
+	p.id_map = id_map;
+	nt = new_types;
+	for (i = 0; i < new_nr_types; i++) {
+		struct btf_field_iter it;
+		const struct btf_type *t;
+		__u32 *type_id;
+		int type_size;
+
+		id = order_map[i];
+		/* must be a valid type ID */
+		t = btf__type_by_id(btf, id);
+		if (!t) {
+			err = -EINVAL;
+			goto done;
+		}
+		type_size = btf_type_size(t);
+		memcpy(nt, t, type_size);
+
+		/* Fix up referenced IDs for BTF */
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
+	/* Fix up referenced IDs for btf_ext */
+	btf_ext = OPTS_GET(opts, btf_ext, NULL);
+	if (btf_ext) {
+		err = btf_ext_visit_type_ids(btf_ext, btf_permute_remap_type_id, &p);
+		if (err)
+			goto done;
+	}
+
+	new_type_len = nt - new_types;
+	next_type = new_types;
+	end_type = next_type + new_type_len;
+	i = 0;
+	while (next_type + sizeof(struct btf_type) <= end_type) {
+		btf->type_offs[i++] = next_type - new_types;
+		next_type += btf_type_size(next_type);
+	}
+
+	/* Resize */
+	if (new_type_len < btf->hdr->type_len) {
+		void *tmp_types;
+
+		tmp_types = realloc(new_types, new_type_len);
+		if (new_type_len && !tmp_types) {
+			err = -ENOMEM;
+			goto done;
+		}
+		new_types = tmp_types;
+		btf->nr_types = new_nr_types;
+		btf->type_offs_cap = btf->nr_types;
+		btf->types_data_cap = new_type_len;
+		btf->hdr->type_len = new_type_len;
+		btf->hdr->str_off = new_type_len;
+		btf->raw_size = btf->hdr->hdr_len + btf->hdr->type_len + btf->hdr->str_len;
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
index ccfd905f03df..e63dcce531b3 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -273,6 +273,49 @@ LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
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
+ * Setting @id_map element to 0 drops the corresponding type. Dropped types must not
+ * be referenced by any retained types. After permutation, type references in BTF
+ * data and optional extension are updated automatically.
+ *
+ * Note: Dropping types may orphan some strings, requiring subsequent **btf__dedup()**
+ * to clean up unreferenced strings.
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


