Return-Path: <bpf+bounces-76258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A724CAC4A0
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 08:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54E473050CC0
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 07:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500F6311C2C;
	Mon,  8 Dec 2025 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Inscpo3i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B2311589
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175044; cv=none; b=fvkMt9yDyp+3EZ70Wx95h9jeUEaNz4hyZh5jGGQc+qh74wnZzTspr1VjyS0Nal1rEJr6Nr67E3DnlEmj8eWSKGdCry7ceotuN+/h94C1U3aFSQdsRQYpHzrLp4NXta/4++1fkkxCEaxOVsFexynS7qK5hMxskdl8817WN573Ghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175044; c=relaxed/simple;
	bh=YJNPYvfz/GxoZXv79UmIYENyuKk2IR71wtQ8M88Szf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BVtTItHtCsQVtmIaVQrZQtz8vsYWDdzHzmk+gTdD2OXs3KiYCPmAcVpeRKGAtuws/N2ANLMII/Ym2NMZKrUR+PvadStMBkhlYomAObRBtOM+s2nXcP49P9mZIYDyWpTIHkxjtbck3C0NxBUeefZ8qN9kNCVrr3aOMa51PP9pijg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Inscpo3i; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2984dfae0acso77011975ad.0
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 22:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765175042; x=1765779842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4S21SvMIVWAPa44TWVxWwB/nChiaz6KYgp24im87ZU=;
        b=Inscpo3i+e7+hcrXGUjDbYmK2EgvOjf3TpzoG2alf8+Ih3hY8y76kTXcux+zI0CsRT
         UVNAACh5kfYpgGG6OmPlIoGNa2dA0zsfp7ZyvD4/t743MLOKmvAoNLZMOG/TlT9dyEXN
         OUEYa66k/IQ9z+AXToX0w6rM/6Cc+qKIP+Idrr6eMypif5cS/bbtPFtuGyFxLYFZrqNZ
         KKSiaUQkpjqJnfJ5BUOAQ5fpeQWi7kA+kshIA4WU/jMQ0erM1hPHDlBPm8AzIz3+Qb1v
         EuD3HWK7luOBG3aCzGNbGnrpplY9fmELCtlxqEYzG5gPJp2+i/Zza50fsScuLk3Q3pGR
         y/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765175042; x=1765779842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a4S21SvMIVWAPa44TWVxWwB/nChiaz6KYgp24im87ZU=;
        b=A+dg5ju7ICmZtSxDfhzyf2I/0Ti38jYh3q96CL2Qh5Cs1XhOJDUJiLqHXNnCW4eTvA
         jKR0E55K+R6svrjKRsn9sSjR53SLtO+Ol0trqgoN5PauPsU9JX7axBR0ou/assUzsTev
         L0vwGhEqqLbKK83qWkR4MpyuB4fO3b0orf2zWVUEPtnDTKgLYi/skwQo5YbqF87yV25X
         2iRVMNvACp7TPATfOKRd14A3vhEX8W073Mi6Pxo9+Rl+nQzKERwPI8hEik/4W7TQ0oGK
         jOwZNi/X14Qt9jXNE9Z8ujnG/OaqtV54hU4bvhlFo4T9S/narU8M460GYW2wlLIWkYOk
         2mWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwfy9di5aAT96FpqP54oUB11qDRLTlERfPUamdEOFLjnQLbnjmOF+dRS75pdzl/bMnshY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxfB0hAwuVUFb8zEil1ONjKaFfIPrrSXA+oeokb2CzZ+xMOlyl
	BBnjxKiTvLRUNLj5esTYjbSW4iQtX5s5lRE4g/qKfKWrT2aPCxxEhV3e
X-Gm-Gg: ASbGnctzYpYSWv20JBku9GrScrT6703y3FnScDZKo4JiSgImvX9f1XelrrAg/KYVSp/
	DnxPcjFWIVcpo0NnBSAB6nKdvINbZD4+oxuOQAgWEOsM8Byz3Xl8D/p1c1ilwRjKLWHKYPDKlW2
	hlY4N2sZ/DIuIgFQhj1S2Xu2ohHj+VgsS44QDf0sYe+BPOmZSolV+nC47nW3KKgjCIVIch8qU4d
	DM9BSudE5tXzsj37uYr0LVy4Dz2hFcAnrskmpaAIG86ieuoipxw6/odiJfYTHuLHl9E76yNQrZ1
	hVbCQyREFU3zwBX348hzRCohNSbxjDp7Fa2wTpst75NDykOx8ibPwcFn7Rl38/lvU8ketllEcUz
	F8QTpAE3dvate3pkPj2193cFlEtcHzz1vqmccwIg6qAFtqH9sLgTMRvztk49olJ1RI2VShNj1oP
	biqI+X30FcyueyDrtdzqVwsV/Aet0uiGrHqoQtNA==
X-Google-Smtp-Source: AGHT+IESItLESSFpTG1CYIdpiSzT8flxRzcPch7BNYUfij3sEBe7Ci9gXvzRv/G+40+kodvXfyshTQ==
X-Received: by 2002:a17:903:294b:b0:29b:e342:3e3c with SMTP id d9443c01a7336-29df5684a61mr40322655ad.21.1765175042517;
        Sun, 07 Dec 2025 22:24:02 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49ca1esm112555855ad.2.2025.12.07.22.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 22:24:01 -0800 (PST)
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
Subject: [PATCH bpf-next v9 01/10] libbpf: Add BTF permutation support for type reordering
Date: Mon,  8 Dec 2025 14:23:44 +0800
Message-Id: <20251208062353.1702672-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251208062353.1702672-1-dolinux.peng@gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
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


