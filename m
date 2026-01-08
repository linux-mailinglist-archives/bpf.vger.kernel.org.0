Return-Path: <bpf+bounces-78192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B1DD00D3F
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 04:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 775FD3004842
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 03:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFACEAC7;
	Thu,  8 Jan 2026 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGBBOouk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF022B8B6
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 03:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842218; cv=none; b=fR3hyBkwH8bIlm9tdMu4JzrmJ+UxoqOQETqBH9K2iDaOErF+MX7d8rsDab6p+WvOkADkEtyN1oaALzWgpgZeSTtuwPG9BLGuXZEvRYo9y6U/Vn2VI0b2SqWnzquVY7wKUX6loP7hRD6GDdA4ZZbUuNIUD2xDs8fc3h4iJw6wolc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842218; c=relaxed/simple;
	bh=ksqELPO0cXKauiYwTecfnPaKtxldFgV/kANERx4D1IY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Asn8NhQQ6TYU0T/TQCDNDKFpzM6at0EKUd5RriLnpTROsljZJEKTcvLf0oLTRVpmcYeyTZfBJNy/RJVTTgRdAeRq9lvf3c2veFJMWv6uU8e3KaahbVl0j6iqnUGAAXOC95n9619rP+VsIIOOszLoOIui78021/YjvHVDF2nuVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGBBOouk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso1782566b3a.2
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 19:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767842216; x=1768447016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQF9Y2EREf+dgAVABdiiMRWyZAZapN+hexHBR/LqK4M=;
        b=KGBBOoukJlESMM5DeiT9zqoi9PHV8qR8FU9VSHoScQVtsdqoLxMyBjn8uPLU5r1Z8+
         89uhIf2gKHJSoVkQJLeLYrVZhQnDhKGDXyWfNagRXyg2g6On6g8Nlqj2Xndf8HE+C27P
         Sqewzf7eGsqCrTWIP8WgU5ZMaOieh2PdoJFywof1xbxxAo+t6ZIYUZUerijqF99vaEBO
         IkUJf9Pr48iNSYYUKkWVc9Sgrn8trHjw2ZsCz2dRlq2gDIEmx4Y5TuKa2uRgosF+q0I3
         Oc0lt7VrMUaXzhc30rw/LAHvzn+5XEnaQO4tas1bdlCI8AADXT4pqv1vuruo7669OL3B
         9hEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842216; x=1768447016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQF9Y2EREf+dgAVABdiiMRWyZAZapN+hexHBR/LqK4M=;
        b=vYyxXeG5l2v2c8xjGLgfOrOuomh5a01d8+/QICurZaPsdkVXzSTgONLzkgNi1QkT+0
         yri0KPgJjGdTR6ORT2XEf9rTDNp4oQZcOwBCwRcgXlASbdmjgc/JabVLqdS6h6HLQqzp
         fq70lqlpBhw5njBdq2jjCPJ7hTNCFtdDaILJ/sb/vyxYjaDOo3dBOn6a7/ozgBxJZWHC
         QalNA1wz5FJmJrbQGw90QI+/yX0NWu9oJL+g5mKrgora7pfbt7qawby7ugETjqMYQ0rY
         w4fF7+/pytD1ISyhmt58EzB7mEn+rZste9yGIbO1oeiA2EAIegGVWG5doGCUQTLLQ8cU
         AKiw==
X-Forwarded-Encrypted: i=1; AJvYcCXRxoupJSVlKfucizgqNvp6rs45s38wtSQBCGxOyLNH+g2Mc3pCy4MfKY4ivfFERK0p5GE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdnPMUlpBCBbbnK/oWYeis265IDedI+MnZbtemqgExsVfExoOD
	n84AF93GpzXfLHLfcRhLllcjKKBnBzVxploong+Rrq0S6qpIC5Lf/B7n
X-Gm-Gg: AY/fxX6N2TGtHl+nY8kKtLRMktX45T/+EC/QhuLC1+R+9BCDuC2su4/pHoB67Cakqwg
	1/shd5hvCfhJoEPcf6teJnTnWsM3qFceKXzzVOXEBXAnMGcVDRBmDl6RwIcrs5UXcoQmeUgMk/f
	CjXNVjKuiIKXQbMUsCxBttZ+RsHlMtTAokrGxXbBXSZnn+YVf1illL/wP/6yScJvmd8l86HYY6X
	9tqHzaKnYhSCA0SrfJNM0zEaWB9dLcUQUAYMRp1FzY9E+DndtyyjwghXcicGGPj8rTDUyBYlPKx
	xrQNUrdgPzNa6x+DKUwAJSsqDLwXbYQSFWJIvulw5Ny2AZNmiJOxo81AaBp9m75wZNp7lOuZGsI
	dQSyCMQjAx4xAQ7sqE5cb9gbXLjPcjLE3GYdqQn97ZgSuUU8FR9zBni4g/FyjeUglOPQBADM0lH
	PIrVBg4V66qpRtp6sVPbGP25C6hRI=
X-Google-Smtp-Source: AGHT+IHxJx1chwNx2IMHnP6vHObc0mE/s4CGIeE8/R0IOP6ROUhqtKdhAwZnrXNr1L4jq8gp1O7kbw==
X-Received: by 2002:a05:6a00:3019:b0:819:6dbc:caf6 with SMTP id d2e1a72fcca58-81b7f101badmr3643122b3a.44.1767842215894;
        Wed, 07 Jan 2026 19:16:55 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de655bsm6134860b3a.60.2026.01.07.19.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:16:55 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v11 01/11] libbpf: Add BTF permutation support for type reordering
Date: Thu,  8 Jan 2026 11:16:35 +0800
Message-Id: <20260108031645.1350069-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108031645.1350069-1-dolinux.peng@gmail.com>
References: <20260108031645.1350069-1-dolinux.peng@gmail.com>
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
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf.c      | 133 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h      |  42 +++++++++++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 176 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b136572e889a..bf75f770d29a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5887,3 +5887,136 @@ int btf__relocate(struct btf *btf, const struct btf *base_btf)
 		btf->owns_base = false;
 	return libbpf_err(err);
 }
+
+struct btf_permute {
+	struct btf *btf;
+	__u32 *id_map;
+	__u32 start_offs;
+};
+
+/* Callback function to remap individual type ID references */
+static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
+{
+	struct btf_permute *p = ctx;
+	__u32 new_id = *type_id;
+
+	/* refer to the base BTF or VOID type */
+	if (new_id < p->btf->start_id)
+		return 0;
+
+	if (new_id >= btf__type_cnt(p->btf))
+		return -EINVAL;
+
+	*type_id = p->id_map[new_id - p->btf->start_id + p->start_offs];
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
+	__u32 n, id, start_offs = 0;
+
+	if (!OPTS_VALID(opts, btf_permute_opts))
+		return libbpf_err(-EINVAL);
+
+	if (btf__base_btf(btf)) {
+		n = btf->nr_types;
+	} else {
+		if (id_map[0] != 0)
+			return libbpf_err(-EINVAL);
+		n = btf__type_cnt(btf);
+		start_offs = 1;
+	}
+
+	if (id_map_cnt != n)
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
+	for (i = start_offs; i < id_map_cnt; i++) {
+		id = id_map[i];
+		if (id < btf->start_id || id >= btf__type_cnt(btf)) {
+			err = -EINVAL;
+			goto done;
+		}
+		id -= btf->start_id - start_offs;
+		/* cannot be mapped to the same ID */
+		if (order_map[id]) {
+			err = -EINVAL;
+			goto done;
+		}
+		order_map[id] = i + btf->start_id - start_offs;
+	}
+
+	p.btf = btf;
+	p.id_map = id_map;
+	p.start_offs = start_offs;
+	nt = new_types;
+	for (i = start_offs; i < id_map_cnt; i++) {
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
+	for (nt = new_types, i = 0; i < id_map_cnt - start_offs; i++) {
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
index cc01494d6210..b30008c267c0 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -281,6 +281,48 @@ LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
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
+ * @brief **btf__permute()** rearranges BTF types in-place according to a specified ID mapping
+ * @param btf BTF object to permute
+ * @param id_map Array mapping original type IDs to new IDs
+ * @param id_map_cnt Number of elements in @id_map
+ * @param opts Optional parameters, including BTF extension data for reference updates
+ * @return 0 on success, negative error code on failure
+ *
+ * **btf__permute()** reorders BTF types based on the provided @id_map array,
+ * updating all internal type references to maintain consistency. The function
+ * operates in-place, modifying the BTF object directly.
+ *
+ * For **base BTF**:
+ * - @id_map must include all types from ID 0 to `btf__type_cnt(btf) - 1`
+ * - @id_map_cnt must be `btf__type_cnt(btf)`
+ * - Mapping is defined as `id_map[original_id] = new_id`
+ * - `id_map[0]` must be 0 (void type cannot be moved)
+ *
+ * For **split BTF**:
+ * - @id_map must include only split types (types added on top of the base BTF)
+ * - @id_map_cnt must be `btf__type_cnt(btf) - btf__type_cnt(btf__base_btf(btf))`
+ * - Mapping is defined as `id_map[original_id - start_id] = new_id`
+ * - `start_id` equals `btf__type_cnt(btf__base_btf(btf))`
+ *
+ * After permutation, all type references within the BTF data and optional
+ * BTF extension (if provided via @opts) are updated automatically.
+ *
+ * On error, returns a negative error code and sets errno:
+ *   - `-EINVAL`: Invalid parameters or invalid ID mapping
+ *   - `-ENOMEM`: Memory allocation failure
+ */
+LIBBPF_API int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
+			    const struct btf_permute_opts *opts);
+
 struct btf_dump;
 
 struct btf_dump_opts {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 84fb90a016c9..d18fbcea7578 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -453,4 +453,5 @@ LIBBPF_1.7.0 {
 		bpf_map__exclusive_program;
 		bpf_prog_assoc_struct_ops;
 		bpf_program__assoc_struct_ops;
+		btf__permute;
 } LIBBPF_1.6.0;
-- 
2.34.1


