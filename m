Return-Path: <bpf+bounces-73857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDDBC3B2EE
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34BE188ECDC
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 13:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E5F330B2D;
	Thu,  6 Nov 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQjYe9Xr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83763314C5
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435228; cv=none; b=Sr/xn6bAUjh7p9aIqpLjt1+aWXqxnH9TiLcdjoGYSuVm2F7Xt5DtxFLcKWep/kEVHUuCfTO6uCYMRO65K/O0ubDBnEiePGmrABqzFjVZ9obbkCBvr7VxfBl3XGi4VeXxAiEVejxdaoKHacK3vHVOTLGvtDI1/QujE8nm5djUR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435228; c=relaxed/simple;
	bh=5WMlMP0Qa86xjepvackGCM9Kudf88xqqA/oP2jNoOCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nl4bbia+VlWUtOnGiQWVNopUMlRq8IA2rFSE2S8BiKKKWAEGXtCyOZVnZUagdut9hvU3L6hmPp9LwtYH1/h4T+U5fl6KCk9ZCYTGFLXD+AmRsT8iq9ytgpXOdxTsJ+sYnSJ+S8HBLwovrxdNA9c2Zq0DLNF1h+aWxP0UPh70TF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQjYe9Xr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340c680fe8cso980255a91.0
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 05:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762435224; x=1763040024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eE4f1ExBgKlia9rPOG35Lwiq1YmfGukK360i7Hwinqw=;
        b=aQjYe9XrE+e8eNCSH/ilBMoiaZvJph4A6bFp+4ZXXtG/XGfXd0amdwEJQ8GlXP1TUG
         SodsMDPHx5a8dEX0TTiURx+Y26FjkGpO6gXEqvH5G/KlyhfUXl7NcAjyQLSPqEPiz9Y4
         0VFyhTbix9sildE0McG/lVIfEcWHQL2EjUHPa4ef2T0RWh1vn7u3+MsN4JssMPMJNJnG
         fbKrg9WAzBnr2q3zraxY7dmhz9J+Hw5Moh1FU2fIFTYHTOaZ63brZR+WlcZ+0x7gjNHc
         m+2a8iIcfDfqsVsFM1rXB5PetEfNe8S8XrTkxsfLjdtFwXbUKQpH+x0DSJYjv8AlGzek
         I0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435224; x=1763040024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE4f1ExBgKlia9rPOG35Lwiq1YmfGukK360i7Hwinqw=;
        b=L2CVDxjdJ/BtUY0CbVWk2vzo/iK22SNni84pES2d+cr4U/lagq432k8YBPcPY6FAPs
         zC6bTQ9REMfI9o4rm8iTstQ6BRbTUxeUoHQMFa2ZeNLGgeZQM2bJTsEJk2kbr8ckYGNQ
         ROUQgmP2+0YYfXw+TQxP3/XTF53wX6x7/EH6VwgAC3x4hfPouOeOJVT0RUENOIMVPHpo
         KF1rau721kYuR1PsBB24DsQxIBi3DBEGK0dBcYbHC8ijGlwBxBKDY9ozA5AtblIT1eUp
         JfXYVAJzPULH/8+6bg02lV7IBlzELxubUqbvSE5GTSAZlO7Cq+tP0UnZmYR2Mm/osrWX
         MaIA==
X-Forwarded-Encrypted: i=1; AJvYcCXNBOsX1duQXWf4QoV4fft4Vbvjple82IH2yq444Al8CIDItITeGzA/YqlRDLxFY12jyTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jjjr/WylUEc0Ih5g5oPQfz2zGZiEt5hvIXk/nH4uQl7JKBgR
	fTL52NeFTM5BwOiIT6fStRlke1xEvunrWAl+zrobaDJpvfxJ1V3KuXrm/u29QvGQgPQ=
X-Gm-Gg: ASbGncsD7Sl6Qlu76b4weYKjs5GIAZ0zchGpo1p1Fx8auFNsaoq/T6c0KojHQLqHJtn
	NqDHtTmkyVW5S7sZfmxLY6eVlf5PeM7FeE6QXWJp367LuLtsLAzI3DmrH/d9Z47/0AIrwgHarFo
	VuZf0GLri09ovPqKu8Ub4M0yiTJ2ge7psI1v+8R0xYKPAzI5No7UcGOZbbWHFktVW5t9LC0m6t3
	IKT0r2TAktK8yqLw6BGra6FhBu8eAfyUojkKCk1l9LNrPtTlR20Y5E7Ev1nc/DEKpHBSXpZT32L
	IH/lR5yQzkQUhA0r5z5s7dRruvwmH1Omj1qbELrwg8nmVtEPBNES1dSfe/oDxhhp6/gC5iDtjCI
	O6xTFjoTM8GvbVDo+WqGX9sqixcbW8suFx8Q4Gx8b6JWBv3j/YWSl5IjUNBtDsDFddsM7e5D6aJ
	gd42ns4guUtozvaW9U
X-Google-Smtp-Source: AGHT+IHl0IBfcX7XHHEZM/JveOzysrq0UeZjBlkdDeFpHD0i/NWXnablAyZP2GJ7vtmKTkU9OsY4CA==
X-Received: by 2002:a17:90b:2fcd:b0:338:3d07:5174 with SMTP id 98e67ed59e1d1-341a6c4189bmr8351963a91.5.1762435223917;
        Thu, 06 Nov 2025 05:20:23 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d3e0b0b2sm1914869a91.21.2025.11.06.05.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:20:22 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>,
	Donglin Peng <pengdonglin@xiaomi.com>
Subject: [PATCH v5 2/7] libbpf: Add BTF permutation support for type reordering
Date: Thu,  6 Nov 2025 21:19:51 +0800
Message-Id: <20251106131956.1222864-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106131956.1222864-1-dolinux.peng@gmail.com>
References: <20251106131956.1222864-1-dolinux.peng@gmail.com>
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

The permutation process involves:
1. Shuffling types into new order based on the provided IDs array
2. Remapping all type ID references to point to new locations
3. Handling BTF extension data if provided via options

This is particularly useful for optimizing type locality after BTF
deduplication or for meeting specific layout requirements in specialized
use cases.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf.c      | 176 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h      |  31 +++++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 208 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 0c1dab8a199a..aad630822584 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5830,3 +5830,179 @@ int btf__relocate(struct btf *btf, const struct btf *base_btf)
 		btf->owns_base = false;
 	return libbpf_err(err);
 }
+
+struct btf_permute {
+	/* .BTF section to be permuted in-place */
+	struct btf *btf;
+	/* optional .BTF.ext info along the main BTF info */
+	struct btf_ext *btf_ext;
+	/* Array containing original type IDs (exclude VOID type ID 0)
+	 * in user-defined order
+	 */
+	__u32 *ids;
+	/* Array used to map from original type ID to a new permuted type
+	 * ID
+	 */
+	__u32 *ids_map;
+	/* Number of elements in ids array */
+	__u32 ids_sz;
+};
+
+static int btf_permute_shuffle_types(struct btf_permute *p);
+static int btf_permute_remap_types(struct btf_permute *p);
+static int btf_permute_remap_type_id(__u32 *type_id, void *ctx);
+
+int btf__permute(struct btf *btf, __u32 *ids, __u32 ids_sz, const struct btf_permute_opts *opts)
+{
+	struct btf_permute p;
+	int err = 0;
+	__u32 *ids_map = NULL;
+
+	if (!OPTS_VALID(opts, btf_permute_opts) || (ids_sz > btf->nr_types))
+		return libbpf_err(-EINVAL);
+
+	ids_map = calloc(ids_sz, sizeof(*ids_map));
+	if (!ids_map) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	p.btf = btf;
+	p.btf_ext = OPTS_GET(opts, btf_ext, NULL);
+	p.ids = ids;
+	p.ids_map = ids_map;
+	p.ids_sz = ids_sz;
+
+	if (btf_ensure_modifiable(btf)) {
+		err = -ENOMEM;
+		goto done;
+	}
+	err = btf_permute_shuffle_types(&p);
+	if (err < 0) {
+		goto done;
+	}
+	err = btf_permute_remap_types(&p);
+	if (err < 0) {
+		goto done;
+	}
+
+done:
+	free(ids_map);
+	return libbpf_err(err);
+}
+
+/* Shuffle BTF types.
+ *
+ * Rearranges types according to the order specified in p->ids array.
+ * The p->ids_map array stores the mapping from original type IDs to
+ * new shuffled IDs, which is used in the next phase to update type
+ * references.
+ */
+static int btf_permute_shuffle_types(struct btf_permute *p)
+{
+	struct btf *btf = p->btf;
+	const struct btf_type *t;
+	__u32 *new_offs = NULL, *ids_map;
+	void *nt, *new_types = NULL;
+	int i, id, len, err;
+
+	new_offs = calloc(p->ids_sz, sizeof(*new_offs));
+	new_types = calloc(btf->hdr->type_len, 1);
+	if (!new_offs || !new_types) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+
+	nt = new_types;
+	for (i = 0; i < p->ids_sz; i++) {
+		id = p->ids[i];
+		/* type IDs from base_btf and the VOID type are not allowed */
+		if (id < btf->start_id) {
+			err = -EINVAL;
+			goto out_err;
+		}
+		/* must be a valid type ID */
+		t = btf__type_by_id(btf, id);
+		if (!t) {
+			err = -EINVAL;
+			goto out_err;
+		}
+		ids_map = &p->ids_map[id - btf->start_id];
+		/* duplicate type IDs are not allowed */
+		if (*ids_map) {
+			err = -EINVAL;
+			goto out_err;
+		}
+		len = btf_type_size(t);
+		memcpy(nt, t, len);
+		new_offs[i] = nt - new_types;
+		*ids_map = btf->start_id + i;
+		nt += len;
+	}
+
+	/* resize */
+	if (p->ids_sz < btf->nr_types) {
+		__u32 type_len = nt - new_types;
+		void *tmp_types;
+
+		tmp_types = realloc(new_types, type_len);
+		if (!tmp_types) {
+			err = -ENOMEM;
+			goto out_err;
+		}
+		new_types = tmp_types;
+		btf->nr_types = p->ids_sz;
+		btf->type_offs_cap = p->ids_sz;
+		btf->types_data_cap = type_len;
+		btf->hdr->type_len = type_len;
+		btf->hdr->str_off = type_len;
+		btf->raw_size = btf->hdr->hdr_len + btf->hdr->type_len + btf->hdr->str_len;
+	}
+	free(btf->types_data);
+	free(btf->type_offs);
+	btf->types_data = new_types;
+	btf->type_offs = new_offs;
+	return 0;
+
+out_err:
+	free(new_offs);
+	free(new_types);
+	return err;
+}
+
+/* Callback function to remap individual type ID references
+ *
+ * This callback is invoked by btf_remap_types() for each type ID reference
+ * found in the BTF data. It updates the reference to point to the new
+ * permuted type ID using ids_map array.
+ */
+static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
+{
+	struct btf_permute *p = ctx;
+	__u32 new_type_id = *type_id;
+
+	/* skip references that point into the base BTF */
+	if (new_type_id < p->btf->start_id)
+		return 0;
+
+	new_type_id = p->ids_map[*type_id - p->btf->start_id];
+	if (new_type_id > BTF_MAX_NR_TYPES)
+		return -EINVAL;
+
+	*type_id = new_type_id;
+	return 0;
+}
+
+/* Remap referenced type IDs into permuted type IDs.
+ *
+ * After BTF types are permuted, their final type IDs may differ from original
+ * ones. The map from original to a corresponding permuted type ID is stored
+ * in p->ids_map array and is populated during shuffle phase. During remapping
+ * phase we are rewriting all type IDs  referenced from any BTF type (e.g.,
+ * struct fields, func proto args, etc) to their final permuted type IDs.
+ */
+static int btf_permute_remap_types(struct btf_permute *p)
+{
+	return btf_remap_types(p->btf, p->btf_ext, btf_permute_remap_type_id, p);
+}
+
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index ccfd905f03df..a0bf9b011c94 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -273,6 +273,37 @@ LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
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
+ * @brief **btf__permute()** rearranges BTF types in-place according to specified mapping
+ * @param btf BTF object to permute
+ * @param ids Array containing original type IDs (exclude VOID type ID 0) in user-defined order.
+ * @param ids_sz Number of elements in @ids array
+ * @param opts Optional parameters for BTF extension data reference updates
+ * @return 0 on success, negative error code on failure
+ *
+ * **btf__permute()** performs an in-place permutation of BTF types, rearranging them according
+ * to the order specified in @ids array. If @ids_sz is smaller than the total number of types
+ * in @btf, the BTF will be truncated to contain only the types specified in @ids. After
+ * reordering, all type references within the BTF data and optional BTF extension are updated
+ * to maintain consistency. Subsequent btf__dedup may be required if the BTF is truncated during
+ * permutation.
+ *
+ * On error, negative error code is returned and errno is set appropriately.
+ * Common error codes include:
+ *   - -EINVAL: Invalid parameters or invalid ID mapping (e.g., duplicate IDs, out-of-range IDs)
+ *   - -ENOMEM: Memory allocation failure during permutation process
+ */
+LIBBPF_API int btf__permute(struct btf *btf, __u32 *ids, __u32 ids_sz,
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


