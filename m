Return-Path: <bpf+bounces-73434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6FDC3145A
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 14:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB60D462C84
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6088E328B6C;
	Tue,  4 Nov 2025 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWXYA3cA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE34329376
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263649; cv=none; b=LaqE+5JL+lu3ez40O8Lw2G4fm5cJp12HkOhfNngn9Kw0SdFsYyOBBMmL6dluZO9o5AvUgStTuuqDkund8lB7BTr6E0dr8sVQxp2ykEiiieKFuuzRxdRF0INFyuL65fB4QBVsIYa5Cv0XjHJ2S7w86H2I65ic8WNyy6QL92pOUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263649; c=relaxed/simple;
	bh=sa1HxtYH0/eacZwbT2sndIG1i6ajxhbyuue/J9blO8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QgvF3+t+O4gHFort7LEz6C06rUMz0CjQVvGtWtp26wdME4NiLrbRA13mnqoUgupsI3mB3SsizjzKSTHXdICDWu5k5P9msOPEH7/VZd6qhatT4uA/sGK/Wb4igjrLDOYEZ2R7EvIs477H6ptdVVBFBKOLHCWYH4IQKgLRgB7/MJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWXYA3cA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso2207377b3a.3
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 05:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762263647; x=1762868447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkgAadX906NxjuzkPoGZPIWqZ+t9g+NGVEVLREnfGtI=;
        b=IWXYA3cA6awmPshednZ+0PaiP+FqxD66hafF869r5S5Y5aItoOxBTvHPPDFWNAwlHm
         Qe3ej5vygdgeK2jYZO9N7nXkKrY1qV4tqKPDWCDAh5rWr+e26ulhcsrOb5qBEZALtJhX
         wcl30BNTXTE+esssmQ29GUUAH9vnp0OawgZ/+ctgMoAtf/xmyR+7scr5aW2rdLfxYqpk
         b6EJg5g1zBnAJG5Wr/0WidS/WMujPO5p/ikjADHH8ahfA4bq9FUiYsvInsnC8Sic0web
         jxJFy1C9T71jQmm8iV5UKbN75PcdvT8cwaZM0Cba1mjj0Ly7pELGmMnoerwbPE5gt9+3
         +MXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263647; x=1762868447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkgAadX906NxjuzkPoGZPIWqZ+t9g+NGVEVLREnfGtI=;
        b=guyJTZU0jKaP95pbXVi5FStzwdvpKRRDA9tteVhxnWNMFnmS7ZTWWJKUbIli3TjtYd
         idNJhLKG0Eayu3XIUul+djKrv2w2j5NMa9ffyalHSUuJBCwiz+JAsR+8FZ20kgMWl8+O
         voRAUoACUT6UNv0sPkgUOv5ASACFMcOsbPUfNY0e8dTLI1XxvbhlW5FqBlbIpB3gDBRo
         raWdxiar4SCSI5VHZCl9qXSIQTs3ewCs4bgfebqlAj2hkshfb1P1PZ/zGREQ+zoNy4Hr
         xMmIPwSZNCqrsVrnCgi5fXiteztech8+mzyfeyd5V00fk0zhrqyJ55AN7/9KPwrzxDAf
         T08g==
X-Forwarded-Encrypted: i=1; AJvYcCV4eh3fVl4m98PdJD8Y81g7UtL+KsNGk5up2drmOyHpSJFl2wgNUUjaVKYWPUCYqoTVlvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywxkp3nbGJb43qYFbtFkwjsAxKulE8S3F/6MF0UzwBtAfhHPSe
	KBQQYO6vcadEKzbp3E9yTzOZOf5bYiJuac1+XHjcRNqX0Kn57B8va0aM
X-Gm-Gg: ASbGncujpx3/kajUhLQjSQ3dmAbcos1plNKFlOhHjiObOvX35Mp1LLEP8go5WqHp/j5
	gkx5z21xItcYon92RdSzf/tsbBjCEsVu6UaGIkG4LwW83upSbYwTPXNS0GBindsPNt2s2Lkp+XS
	JJ/UqOb03yo34YIqkJzdBI5lNF7Ivm8zICLTBlHf60d1Q2K+ifHJhqy/Z3XNZE30Wl33gjT66qE
	8+hNMPgulUU6NaF8tzCi0h0I9oSvoJieC3AndSKNPF6reteq0ZbtdGz1z+gRauksqosySHtijcn
	aE+2q4kzAqIbflp5PiKCGY5J0hdcik6JMswEiZOnW1j/CGl4jYCpm7ogNB01CMKayaR8yBYuNSx
	eZTEspg3lMvfBcX8JppYtYp/E0PgTo5C519IccuS2IFJJ2Bky/zE7Z8GIu0ED56/QzEDjbeCVa+
	BmHJDGSwEflyrXRwhu
X-Google-Smtp-Source: AGHT+IGvrZ0IfTiFVGGZzy9AqFylOrJxoiLe+/NaJrwhGcWgVZ3B+6sZXWpvKl0Du/8Blex1JSR1gw==
X-Received: by 2002:a05:6a20:12c3:b0:343:1f71:8179 with SMTP id adf61e73a8af0-348cbda9931mr22173044637.35.1762263647423;
        Tue, 04 Nov 2025 05:40:47 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a7287sm2499238a12.31.2025.11.04.05.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:40:46 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type reordering
Date: Tue,  4 Nov 2025 21:40:28 +0800
Message-Id: <20251104134033.344807-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104134033.344807-1-dolinux.peng@gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
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

The permutation process involves:
1. Shuffling types into new order based on the provided ID mapping
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
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 tools/lib/bpf/btf.c      | 161 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h      |  34 +++++++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 196 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 5e1c09b5dce8..3bc03f7fe31f 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5830,3 +5830,164 @@ int btf__relocate(struct btf *btf, const struct btf *base_btf)
 		btf->owns_base = false;
 	return libbpf_err(err);
 }
+
+struct btf_permute {
+	/* .BTF section to be permuted in-place */
+	struct btf *btf;
+	struct btf_ext *btf_ext;
+	/* Array of type IDs used for permutation. The array length must equal
+	 * the number of types in the BTF being permuted, excluding the special
+	 * void type at ID 0. For split BTF, the length corresponds to the
+	 * number of types added on top of the base BTF.
+	 */
+	__u32 *ids;
+	/* Array of type IDs used to map from original type ID to a new permuted
+	 * type ID, its length equals to the above ids */
+	__u32 *map;
+};
+
+static int btf_permute_shuffle_types(struct btf_permute *p);
+static int btf_permute_remap_types(struct btf_permute *p);
+static int btf_permute_remap_type_id(__u32 *type_id, void *ctx);
+
+int btf__permute(struct btf *btf, __u32 *ids, const struct btf_permute_opts *opts)
+{
+	struct btf_permute p;
+	int i, err = 0;
+	__u32 *map = NULL;
+
+	if (!OPTS_VALID(opts, btf_permute_opts) || !ids)
+		return libbpf_err(-EINVAL);
+
+	map = calloc(btf->nr_types, sizeof(*map));
+	if (!map) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	for (i = 0; i < btf->nr_types; i++)
+		map[i] = BTF_UNPROCESSED_ID;
+
+	p.btf = btf;
+	p.btf_ext = OPTS_GET(opts, btf_ext, NULL);
+	p.ids = ids;
+	p.map = map;
+
+	if (btf_ensure_modifiable(btf)) {
+		err = -ENOMEM;
+		goto done;
+	}
+	err = btf_permute_shuffle_types(&p);
+	if (err < 0) {
+		pr_debug("btf_permute_shuffle_types failed: %s\n", errstr(err));
+		goto done;
+	}
+	err = btf_permute_remap_types(&p);
+	if (err < 0) {
+		pr_debug("btf_permute_remap_types failed: %s\n", errstr(err));
+		goto done;
+	}
+
+done:
+	free(map);
+	return libbpf_err(err);
+}
+
+/* Shuffle BTF types.
+ *
+ * Rearranges types according to the permutation map in p->ids. The p->map
+ * array stores the mapping from original type IDs to new shuffled IDs,
+ * which is used in the next phase to update type references.
+ *
+ * Validates that all IDs in the permutation array are valid and unique.
+ */
+static int btf_permute_shuffle_types(struct btf_permute *p)
+{
+	struct btf *btf = p->btf;
+	const struct btf_type *t;
+	__u32 *new_offs = NULL, *map;
+	void *nt, *new_types = NULL;
+	int i, id, len, err;
+
+	new_offs = calloc(btf->nr_types, sizeof(*new_offs));
+	new_types = calloc(btf->hdr->type_len, 1);
+	if (!new_offs || !new_types) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+
+	nt = new_types;
+	for (i = 0; i < btf->nr_types; i++) {
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
+		map = &p->map[id - btf->start_id];
+		/* duplicate type IDs are not allowed */
+		if (*map != BTF_UNPROCESSED_ID) {
+			err = -EINVAL;
+			goto out_err;
+		}
+		len = btf_type_size(t);
+		memcpy(nt, t, len);
+		new_offs[i] = nt - new_types;
+		*map = btf->start_id + i;
+		nt += len;
+	}
+
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
+ * permuted type ID using the mapping table.
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
+	new_type_id = p->map[*type_id - p->btf->start_id];
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
+ * in btf_permute->map and is populated during shuffle phase. During remapping
+ * phase we are rewriting all type IDs  referenced from any BTF type (e.g.,
+ * struct fields, func proto args, etc) to their final deduped type IDs.
+ */
+static int btf_permute_remap_types(struct btf_permute *p)
+{
+	return btf_remap_types(p->btf, p->btf_ext, btf_permute_remap_type_id, p);
+}
+
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index ccfd905f03df..441f6445d762 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -273,6 +273,40 @@ LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
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
+ * @param ids Array defining new type order. Must contain exactly btf->nr_types elements,
+ *        each being a valid type ID in range [btf->start_id, btf->start_id + btf->nr_types - 1]
+ * @param opts Optional parameters, including BTF extension data for reference updates
+ * @return 0 on success, negative error code on failure
+ *
+ * **btf__permute()** performs an in-place permutation of BTF types, rearranging them
+ * according to the order specified in @p ids array. After reordering, all type references
+ * within the BTF data and optional BTF extension are updated to maintain consistency.
+ *
+ * The permutation process consists of two phases:
+ * 1. Type shuffling: Physical reordering of type data in memory
+ * 2. Reference remapping: Updating all type ID references to new locations
+ *
+ * This is particularly useful for optimizing type locality after BTF deduplication
+ * or for meeting specific layout requirements in specialized use cases.
+ *
+ * On error, negative error code is returned and errno is set appropriately.
+ * Common error codes include:
+ *   - -EINVAL: Invalid parameters or invalid ID mapping (e.g., duplicate IDs, out-of-range IDs)
+ *   - -ENOMEM: Memory allocation failure during permutation process
+ */
+LIBBPF_API int btf__permute(struct btf *btf, __u32 *ids, const struct btf_permute_opts *opts);
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


