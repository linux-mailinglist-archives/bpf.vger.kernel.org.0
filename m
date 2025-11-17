Return-Path: <bpf+bounces-74735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 82857C6460C
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 14:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84AED3586C8
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7505933291B;
	Mon, 17 Nov 2025 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hff5GoYR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3B33328ED
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763385996; cv=none; b=E9dU0bKKKYPnR3BdsvH5Q6AyC2UP4kvSfdrHSwI6GUum1q8LD1IKPn2GgjAjNJaFYNluZZAygCAzzSYSpGvKIPT0w2NkgsW/TCjgOCNuxAf1rORfWjBaYKtbK9GzQyN1nIAinEpx8RCztdUsk32jL1tfWh/KT2oPRPg5UYRO93k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763385996; c=relaxed/simple;
	bh=6VBbAusWLjZvaGOC/+K+V+im/qf4tqKKK59Uc/T8Ph0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A30Smc9MdJVAaAB34tlp12Qfp/tmd7rhU4LPzmxcNEdXYfivYw34WvcQKPfRCuEWgkcQ6+xiFcUVU5elrJzkv6px/ok3oX/q6wHuvaGNfYgwDTxTdeJuOeInwlsFdwfdc93iM6JsrD9Lwg7r38TspTPLdgP1IbC1dF4/H90J3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hff5GoYR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7ba55660769so2580329b3a.1
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 05:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763385993; x=1763990793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBbxUx6nVTODhi42u5LXpziwCIk3CPqNxfSqUe5bn+c=;
        b=Hff5GoYRLNJS2BQp8bczKrl6ga8Z1VxA67Zyl9XibD6T74RYge340yv+LKxOlnjK4m
         RxRYjEYfiGf9BcDcbxdMPEPckM3C8jAt46ljcZ3zZsPCnmy6Qw9u7eDpUClGcodW62pA
         Abosi7oOSH9rIGVvhjYVUvmolmmxh/ky/rXvjLbvfHaL6laFtnCLr5kdwApvTrNBSn2j
         ngsG9PA1rTCtyYNntu4Jk1f2NlAGUmDxRN/2IiwtRNCgvkhjVYZaqiHJ5JDK6n48Zihw
         KYHgI5l1GweU3yNJhaEB9DpwVRZ+zTavsxX712DhHI1+u58gxLm5vBcaDGbwoV6eaLyV
         zylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763385993; x=1763990793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DBbxUx6nVTODhi42u5LXpziwCIk3CPqNxfSqUe5bn+c=;
        b=ABpjx/Ty1TFRcMAtk50L2hOaIyxgL2vtqPbCt7kY2MztrWODTSnN4TFLp6c17W+L2n
         LmLX8gob4xDu3OBMR8yJh587ABMGhZ9A8zYvTdm0LwJkHFPznRlv4sva3rv1F9TJkJEG
         tsQiq1bNyOEtSWsJlxmX+BoDpfb98pk8VA51bhXHZxeJ3BACZLH+r/AFxEYQp548/B2s
         rvW32mxEyzOT4MevokHp1Kzr+aXJuuACAU+GGBm6VB5S4CbhJ7a66J6mIOgYOT2sDpBm
         OZbNJ/fqdod/1e4n3e/hL5oUQfbWvtMkPlgrs4pucPxRmiDn7g7W5tVNx/qtm3ewPUwo
         CNkw==
X-Forwarded-Encrypted: i=1; AJvYcCWJXSJenVTb075X5fXuOR7V4UVfKWcuBGld43B3vqDQ6P1Yw2VsA8uj6j2OVR6dHqG3p+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDiwUsSPxooIOZr2dTXZMhWv5r7v2bYoAs0VnqDLeiRoN7IXDX
	E+7oXebbwKSFRVE89qcbGQLujyjKFrs6WOQ1F6Gio/4Y2QXmZnwWkdRR
X-Gm-Gg: ASbGncuafr230dlFDTarOFDqGfeuhSvqrkU00+XgFTNE7SDVs0BDn7swGn2uuUyS+2O
	K+JUEYKfytjNb9qRfV7IToHQsD/wWzc4lRb2NLckXj1YVGLbwyjgGgnSzWuPnLoS/s6WkfZMkbu
	bqi9+ZUjVdG3nOMegpSF+vGduDKcT7ZfVHrov3YmJjoENxRKG401l5DbuDTbtlZqtfv54mGFZpx
	UVzp4BFvZrnaFLnKyA/qVIwmsZPwYcddt+vtX4fv5dsebvE8IozEggiXff8+YP2cM0570uv/xYB
	w2vh/V0d/hm3U1qJZAiHN0up0nHYhZE6BS6a47TpazDEbihpOu0whDPBfvLRrxpfOm/U9kal2t0
	H0CMBugfmshUpizsLSkw9uALXpDOKLvJQAIyGPtAARR92AMwubfSAO122MmxjkVn35d7gKV1h2I
	QINPyo7Rai9UgwQdSJiV+ASsdSjrc=
X-Google-Smtp-Source: AGHT+IGbXFMdLTSTTZa1RPQl3rBb9sfz0EW9VgsJegiZI/gWTT/GjQE/NwLRF8MyNLpZwsf2nDRPyQ==
X-Received: by 2002:a05:6a20:729d:b0:360:1b2e:5257 with SMTP id adf61e73a8af0-3601b2e54e1mr2570118637.2.1763385993351;
        Mon, 17 Nov 2025 05:26:33 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924cd89bcsm13220953b3a.15.2025.11.17.05.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 05:26:32 -0800 (PST)
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
Subject: [RFC PATCH v6 1/7] libbpf: Add BTF permutation support for type reordering
Date: Mon, 17 Nov 2025 21:26:17 +0800
Message-Id: <20251117132623.3807094-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117132623.3807094-1-dolinux.peng@gmail.com>
References: <20251117132623.3807094-1-dolinux.peng@gmail.com>
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
 tools/lib/bpf/btf.c      | 191 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h      |  43 +++++++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 235 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 18907f0fcf9f..e3aa31c735c8 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5829,3 +5829,194 @@ int btf__relocate(struct btf *btf, const struct btf *base_btf)
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
+	if (!OPTS_VALID(opts, btf_permute_opts))
+		return libbpf_err(-EINVAL);
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
+	if (id_map_cnt != n)
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


