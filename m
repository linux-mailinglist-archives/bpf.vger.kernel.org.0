Return-Path: <bpf+bounces-78315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C55FD0A5E8
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 14:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54A5A3158299
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3FA35BDDE;
	Fri,  9 Jan 2026 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flJTaxQd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D36C35C199
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963615; cv=none; b=bLpWiRrRcSqnlrLVxkmDsFv7hp/uUh4uZE3x2UMo87kzlIEtBmfgEY9Gh9LQlURz/REap0ybeAl9Q+enBYmPHw55U2C/ZvD7DZqkniKu1i6XeNKegzJoTv52tkdH2Jt/D4hAROSztkaGxbczqkmksV5SV+/GEU+WEXW2ClfSfDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963615; c=relaxed/simple;
	bh=ksqELPO0cXKauiYwTecfnPaKtxldFgV/kANERx4D1IY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TaBoAfHRHM32SdkzsTrAFoSwCHs+rHr4kcFLbzX6DcykiV/27OeLac900VqH9Fc5yoxRtxkxWnjebregvGK7N48LTEUedQtXzh5ViCnx5FW3mwSVaiWg8I9FpxomiZh8mkcIlBgco2LKtKPfBG6nUh3v2smcl3BAiANM78wZGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flJTaxQd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81dbc0a99d2so506942b3a.1
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 05:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963613; x=1768568413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQF9Y2EREf+dgAVABdiiMRWyZAZapN+hexHBR/LqK4M=;
        b=flJTaxQdrv5Lzpa2CUYap4fjKfT7miz/fibkohjp8eEiKMY6euidWA/nDpiZJ3R6DW
         ZCujTnQqjvY2+YdyAVPqp0+0GPc2V1oSLqIfajgwE4EVQg6AI4VE55GuBKsXgwTIZE3y
         8Ihj4NM1cLuIS3rN+QvWtdswxYdwWWEyGY4F71KIKtL1sFrUg/GukxmRstF6aX+gnmjQ
         jP1TcWNPzNzRNmCWrRo0IuhDwb5x/+X6c+07olsh9BftaHoMVbHli02LCfaIV58FWoXA
         iquTczMhuuJWj2bCw9Xp+N9kBDUCI51XEaKUfSef0HtorK2zD+Skjxmu05gu2Zz1GewY
         4RAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963613; x=1768568413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQF9Y2EREf+dgAVABdiiMRWyZAZapN+hexHBR/LqK4M=;
        b=kQOtBdmjUJzW+hh0zOGyZPYj4RA8PUg1CrhYZf9H/QPYipxumSRjbQzlYu14WzUPNx
         biihD+AXNGWqW+/2ph5A9h7867jskEUPor4wSroW3Y2Iyl1Kj+fK3gPH+22K03gvOMhs
         8WFRgF+JCmgyiFMwo83knni9BqG8BVeCi0fQ1blJdDCe5DlaICjAuWnp3j7uzOEjEXsB
         tpiUHu9X9nzXET016nKhpotDPzypiauS8YwK8e2kXrIe2K3uzF3lFVsj4BoeJC2vsqY+
         vwfIWE19vxMlS1/ZVm5HryAsz8QERU82Ev6Fg1io+acrn6nGdNb97Fb30nhfewNqQQRS
         gaEg==
X-Forwarded-Encrypted: i=1; AJvYcCW9HgUf5+SkcS/MSVEyeD22UzTUf4Bs2kDAxyoltjopgfhk/2OfFp5aKO16/PsQx6Flsnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Cll+U5qHmPkn5T7FaxTf5euWsGxUQRco43sA6D3mMPgKgBsH
	FE47jF/Pt8STIxnPITpzS60TmbNKLQACLsxL5BDYIOeax7LgqA4A17g7
X-Gm-Gg: AY/fxX5AtTFPALdn7BoRCsONOT22gjmzcF8AaduvO8H2ZTcwaLIgpa7PQyFu6hEWRVt
	Sc1qQ3r/gJvl0dJ6buxELlTDRldAq1jKH4mZkr1dShkkB3ubKba3pBUG5U6kLTy0WMdPR2hRGvd
	nuf0cewi3Uh6S5lzWO4G+x3Qvuj5oQWSUFNXCFLl5G5/+1cq21s6UmF4KvyfhgpaBoYN06o034B
	pSnYcdn2KLSf5k4+qYID4l+rbOoOGU2xZq4W46IYQC6Kku9jSz1wMtfE6f/sDXWQqXPkM+mAh0z
	GpfM6xl9JBKQ339JjAcynnqJvwkDGcX9n9IQgDqH587CyxfWET7s0htvunr+2WpboantIO55H1m
	4k6PNRdgLFq6szjWz/5k7g3yEDdA81Ra83bLuAjyAYgxBdP7Zas8rqlMnzWAEalhrzuXPa4I/WK
	REigzH1zD4torUT+yNcEmkjRZUQ7k=
X-Google-Smtp-Source: AGHT+IF51Igam8v/LIPmHw9lFij0EDTO1sN2sr7KpHZqEplaw8HFWRTzlRk8sdAEKOZQNo95zqw+LQ==
X-Received: by 2002:a05:6a20:94c9:b0:366:5bda:1e87 with SMTP id adf61e73a8af0-3898fa40b18mr9183375637.80.1767963612265;
        Fri, 09 Jan 2026 05:00:12 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a328sm104927325ad.4.2026.01.09.05.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:00:11 -0800 (PST)
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
Subject: [PATCH bpf-next v12 01/11] libbpf: Add BTF permutation support for type reordering
Date: Fri,  9 Jan 2026 20:59:53 +0800
Message-Id: <20260109130003.3313716-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109130003.3313716-1-dolinux.peng@gmail.com>
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
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


