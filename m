Return-Path: <bpf+bounces-74483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64124C5C27A
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B5EE35996B
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95D3302165;
	Fri, 14 Nov 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjiRKt5w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994D30171E
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111040; cv=none; b=gdBToS/bWEInJznOI35J3wBzwnDbovfzNr6br3JpL18zHvP0lYgqllIAyNANhvbEqtTrM+CXnx3M1YnTsYnUkEXGm/+gIQwpDb0TGh+UEb8Z2CtVgHbX9dX4nwmLuHBv5YK4Wx/gzNO7sQBgST/e6c/3S/x64dcd3rr8R2GRAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111040; c=relaxed/simple;
	bh=mSwnWCwoL+MLuntCffdTS1GyT+kU9z+/dn8QhVSGrPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JZQAtba/ozoU1eUle7dfYP369+ELIX6g+E96hOeOZeLtIOfhz0mBm1W5NrgYNoUsDwVpquC1iMmolDaOPc4mL0hqi3nGv09/8tgoSTxP/BOCUJvzDJQBOASNiZfNETSP1lKV3U/wZpzZRk+io6VH0EfVV+g+fxA4LJEDk8wGU00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjiRKt5w; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-295548467c7so19946425ad.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 01:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763111037; x=1763715837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqQyqGcdeA3UbShSzK/mrDf85bRWtniYX8zTmwsdvNI=;
        b=cjiRKt5w/qoJFPt0icJoQgP8GFCr+4NaOvQP76XH92wHIto4vcFQ12aZy8+LYrZhzG
         2a6znCXh1PjMn8F4IuIFbTUOl38OLb/Yunav6tBuBYt/EjePgF2Qj4RnWAPalFJNJyBY
         Oy9dtUhrSDH0AW6t0I2CHOD8zAgCsnB97ZtvHvJckIxL2yvBHlWUKFHPXP6fwXFiBeQL
         qo6uFBVaEhMtj/hHiXJPv8CHvQCk0SOeDypRZEnsHsmDxcofHh6o9crNVK/6uqCSf2Gm
         dxoZDKq/EuzpP+8jeMzeUrhKZs+CD+s/inZP+5ATltQGl3j55JDky7QJZCf6Hzp++WnH
         mxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763111037; x=1763715837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BqQyqGcdeA3UbShSzK/mrDf85bRWtniYX8zTmwsdvNI=;
        b=bz7PXeEzD1UGeU98+70xyQpWn9numks59VKlnT3FHkzlbcJsD13tGqSyXyue1mWNsR
         ofdQBGUTMTE67gkwKGl5oKiNclsdXN1yR6U4QgPo0HhJ76Nuh9fR1OKWzz2vUC/UkmPi
         v9agHaTXQNl/zFEggmskUENZHZCtO/g1k3xjOc5xMYUyhcTTN/UAo5I31xWOiQ636uuA
         mEq0EEGs6kC7kq3VElwFyM0FdS991mdosm6LlG30gL+JYoGPbOAl5I5wGtXYw9Xn51xf
         tptRrzWBdUHO1/aaWRWXlYRS2aaSSWff1V3nTKKvjbPZuSW9TzXjLfB3ngTZcHqul/i2
         4iyw==
X-Forwarded-Encrypted: i=1; AJvYcCU2uB3bTeZwriyAmWvFBfkyXXahE5CmrXAXknFtnAzL97xC9uvBeIGSM9HoQgCnyvbfd0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy82ud6qxzm9fokANH62A35AG+y/+SI/qE3XqVJ+q1Uk4NRzRia
	4+Dthjx72apnwl1U3MP+QCME1bSlnvEiB3rqf1/QfZ9LRWBX65eqOQBV
X-Gm-Gg: ASbGncu9DuB6jnOEkLMt6AMi6Zh0FkOha18B597yK/6H1E9MyORK3we0KEaai5C4C1I
	r44Uy52l4LhhN+4AOUnXGheIGI8n/pNzWvee0YAf/q2C7l1iEfBH36DPK4NBD5FxnNZHPSjs+1L
	hJPMshCFPCNkC080WRIr5Fuilo9ifdETO2dnGQFlQxIt8KaTZPckHAK3lPSpI1H8zAzCSGOKR9g
	BvERnso66uwwheiikMnqJLijLFKIir/0qu930dBV/0fKjdQK7nra6pVquUdNXz6/WBV3SEpA1ZY
	SXyFHl2HjuhyktXC/A16amZOX2h/e5mPl2sL6VfAIaJrk78/N/cvB2C8Jl3CbgS71xL50qXoJpe
	CkxfojqwwVMSpWgeVwXHKblp6vi5PhRCYK3OCA491c564DJfol99rCqDZBVfgY5lLQpPUYnRBj4
	eZIDxBoT8oe2TtDgD1PPRY+mTr0yE=
X-Google-Smtp-Source: AGHT+IFqWVA/hDgLWbf8Cdc8Trj/t/PBbfDJxyG3yC7b0vYCwasCuQtfKOv+Suf59TOmAo+Cum62Zg==
X-Received: by 2002:a17:902:d492:b0:297:d4a5:64e5 with SMTP id d9443c01a7336-2986a72df5cmr25852425ad.30.1763111036857;
        Fri, 14 Nov 2025 01:03:56 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2cca66sm48362605ad.99.2025.11.14.01.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:03:55 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>
Subject: [RFC PATCH 1/2] libbpf: Add BTF permutation support for type reordering
Date: Fri, 14 Nov 2025 17:02:30 +0800
Message-Id: <20251114090231.2786984-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114090231.2786984-1-dolinux.peng@gmail.com>
References: <20251114090231.2786984-1-dolinux.peng@gmail.com>
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
 tools/lib/bpf/btf.c      | 186 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h      |  43 +++++++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 230 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 18907f0fcf9f..d22a2b0581b3 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5829,3 +5829,189 @@ int btf__relocate(struct btf *btf, const struct btf *base_btf)
 		btf->owns_base = false;
 	return libbpf_err(err);
 }
+
+struct btf_permute {
+	struct btf *btf;
+	__u32 *id_map;
+	__u32 offs;
+};
+
+/* Callback function to remap individual type ID references */
+static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
+{
+	struct btf_permute *p = ctx;
+	__u32 new_type_id = *type_id;
+
+	/* skip references that point into the base BTF */
+	if (new_type_id < p->btf->start_id)
+		return 0;
+
+	/* invalid reference id */
+	if (new_type_id >= btf__type_cnt(p->btf))
+		return -EINVAL;
+
+	new_type_id = p->id_map[new_type_id - p->offs];
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
+	int err = 0, n, i, new_type_len;
+	__u32 *order_map = NULL;
+	__u32 offs, id, new_nr_types = 0;
+
+	if (btf__base_btf(btf)) {
+		/*
+		 * For split BTF, the number of types added on the
+		 * top of base BTF
+		 */
+		n = btf->nr_types;
+		offs = btf->start_id;
+	} else if (id_map[0] != 0) {
+		/* id_map[0] must be 0 for base BTF */
+		err = -EINVAL;
+		goto done;
+	} else {
+		/* include VOID type 0 for base BTF */
+		n = btf__type_cnt(btf);
+		offs = 0;
+	}
+
+	if (!OPTS_VALID(opts, btf_permute_opts) || (id_map_cnt != n))
+		return libbpf_err(-EINVAL);
+
+	/* used to record the storage sequence of types */
+	order_map = calloc(n, sizeof(*id_map));
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
+		/*
+		 * 0: Drop the specified type (exclude base BTF type 0).
+		 * For base BTF, type 0 is always preserved.
+		 */
+		if (id == 0)
+			continue;
+		/* Invalid id  */
+		if (id < btf->start_id || id >= btf__type_cnt(btf)) {
+			err = -EINVAL;
+			goto done;
+		}
+		id -= offs;
+		/* Multiple types cannot be mapped to the same ID */
+		if (order_map[id]) {
+			err = -EINVAL;
+			goto done;
+		}
+		order_map[id] = i + offs;
+		new_nr_types = max(id + 1, new_nr_types);
+	}
+
+	/* Check for missing IDs */
+	for (i = offs ? 0 : 1; i < new_nr_types; i++) {
+		if (order_map[i] == 0) {
+			err = -EINVAL;
+			goto done;
+		}
+	}
+
+	p.btf = btf;
+	p.id_map = id_map;
+	p.offs = offs;
+	nt = new_types;
+	for (i = offs ? 0 : 1; i < new_nr_types; i++) {
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
+		btf->nr_types = new_nr_types - (offs ? 0 : 1);
+		btf->type_offs_cap = btf->nr_types;
+		btf->types_data_cap = new_type_len;
+		btf->hdr->type_len = new_type_len;
+		btf->hdr->str_off = new_type_len;
+		btf->raw_size = btf->hdr->hdr_len + btf->hdr->type_len + btf->hdr->str_len;
+	}
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
index ccfd905f03df..ec4e31e918c3 100644
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
+ * - @id_map must include all types from ID 0 to `btf__type_cnt(btf)-1`
+ * - @id_map_cnt should be `btf__type_cnt(btf)`
+ * - Mapping uses `id_map[original_id] = new_id`
+ *
+ * For **split BTF**:
+ * - @id_map should cover only split types
+ * - @id_map_cnt should be `btf__type_cnt(btf) - btf__type_cnt(btf__base_btf(btf))`
+ * - Mapping uses `id_map[original_id - btf__type_cnt(btf__base_btf(btf))] = new_id`
+ *
+ * Setting @id_map element to 0 (except `id_map[0]` for base BTF) drops the corresponding type.
+ * Dropped types must not be referenced by any retained types. After permutation,
+ * type references in BTF data and optional extension are updated automatically.
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


