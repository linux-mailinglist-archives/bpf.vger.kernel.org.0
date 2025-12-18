Return-Path: <bpf+bounces-76971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 267D9CCB9E4
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60477301F7E4
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 11:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1572631AA8A;
	Thu, 18 Dec 2025 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhTZH7Tc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA6731A803
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057476; cv=none; b=ivXyoAbe5SquX18TYoKN7qlyw3Kx6f6q9PjOb2sqVxMyhASpjNooI9JwhMLD561IGTRz7ith5Wt4MVZVG4dCDmsWDc+PNqKrWXY/LFvIAAUoAO0264e4MEuVuQwQYN73D+efkNZ+YCNd+VzZu5eYKp3BavZnULbGmLhVMGW0dIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057476; c=relaxed/simple;
	bh=YhgJ9w2mpWwT1l163tIuzQE2TeqsSQofdQK+jrLBJY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IW2GAXa/JUHMwIs7QdkCR/rnQV+xj38DMWJCqvBkpi7/jGAOSrbmYKPxKhx4Et65PJdG3ZSI8RZ8DDKI37YDyfapjkIhOm2Kc41/Rnh05B2Ftf+tKhrkBWwFxxNxXKjtn1tSIXAc2TW63LXNgWzc5rZofHNMzsUEUuyAzSvubzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhTZH7Tc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c718c5481so510584a91.3
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 03:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766057474; x=1766662274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwtrPyApu5OKLhu1m0R33rOrz3b0Od/pu+2hCHtjT5A=;
        b=DhTZH7TcsYXusbjuMLRU21DzRW6BfdD6IK3StTYGMgceGGzem+cwt8I6vl6JUpG4gS
         f8FWs19Ifhyn9bZlwTVs4DB6T20LLPyv41jC24E7HPBVtau8cY5zrRsTljwZBYpxeONf
         8CRGgOmzc+KaczUdR6MT8L2DSZuAHJt7cvj26S3kaNjJAvdBPZP+gAu/tfUsZAPRpdYx
         MMCZkQju9ffNrAKDWszP20rZh7zuEHmbuWwaiPWQy3DGydNv60VMAZy9TRzX686J7VPr
         tZhKr7L1kPOJz519xp4MGatBqeG+frJLVmbgxUCsGpTYjYVO+UPt1WEELCyAxvk2DjrK
         pY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766057474; x=1766662274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rwtrPyApu5OKLhu1m0R33rOrz3b0Od/pu+2hCHtjT5A=;
        b=lP94/5EHaHJT1xjpczLStRviNLPLinhBlnLrDbZjQ6aeOfBunp4+cA0B4AODMR9zcb
         TVvbbadz50jhJd+K0kf7+WcVBA2Od5ox9ymVRaBq9TsazjBcJIspx+CLEp9H1dscISmi
         VjNcyuL1O9SgRmPu+L6tEzFn0hTA4xxy6TRWXyX77WQSTMYMVZwbf+kG7LngSrMQWUp3
         2uVSf8WGvSyBON1UI6mEkaEiwskj9U+HoBOk18UMCcNR0zAZeVvXJ7B9bi8dJZjXIhgM
         WGLEGyp+1UFKDZBHg5DqKycNqs+J+ELnb6sybl2ZSnnuwUAuDzqi46jj0ux7+4q4aQPJ
         jIsg==
X-Forwarded-Encrypted: i=1; AJvYcCUDJq0JUBcjFwkVeFmtdHdJoElPJtTV/J5xp+DuQYdCiefyijzydYhN+ZxIGsqHf9MOS5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxay9Cea4hJiyddOhaaemPW4IFo7WZL4V4m5wxCBOBW16oAO6UI
	qjJN5yiLXxYoA5k3DrFutqG3CpMOiLWt4dR8ERkNzY8ZoN2CeryrquE0
X-Gm-Gg: AY/fxX7xleZ/yiNkaxNqZegcC30JtYKJSv1qO9UGdY+iTOA0A/qPWzEsUdd7k3F4qeA
	xN/XX7FLBJH1UqjiwVho1pZUTcK1QGy6+ebvFJL/o5o6wcZsDjga9tvyENPTTY4gMQcwn56Cg8q
	sXL7UR5Vp77VwncAKjgMtIQrSxLpq0L7kHEiDRVoU/ccxEqFFrBlCkUS/87q1daFgr7wuGh4ufo
	rOxHK/yDaMhXQCRff3r3LvucvnpWV5uGJsQ/bgNKeqjQFmB9NCspta1UwaCIJFcqNHzQjFRKATQ
	FRHQ+HTWUsxHEgcseVdX0awswqu2jodLi6S01XWPCGiXu8ZxUXBw36K4i91B0ChcnH4+lBryzuU
	+QiKiAwVEYV8o6tSaxmahsaN9LiuURTF0l920DGgdUURhlRVu5Tt0aq/WhS4aifwyl2G/uo5Au5
	7h+BnZLHe9OtYj0s2cZcfXv+/5/to=
X-Google-Smtp-Source: AGHT+IFVQfIxDi/VYL5j2krPuLS3c9hBg9Z2+cMwNmaB0ZeP+5lhhD1BnA4xectZ75VE1Cja4zJDGA==
X-Received: by 2002:a17:90b:270a:b0:340:b912:536 with SMTP id 98e67ed59e1d1-34abd77f7cbmr16495764a91.31.1766057474127;
        Thu, 18 Dec 2025 03:31:14 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm2328237a91.3.2025.12.18.03.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 03:31:12 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v10 01/13] libbpf: Add BTF permutation support for type reordering
Date: Thu, 18 Dec 2025 19:30:39 +0800
Message-Id: <20251218113051.455293-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218113051.455293-1-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf.c      | 119 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h      |  36 ++++++++++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 156 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b136572e889a..ab204ca403dc 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5887,3 +5887,122 @@ int btf__relocate(struct btf *btf, const struct btf *base_btf)
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
index cc01494d6210..5d560571b1b5 100644
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
+ * @id_map must include all types from ID `start_id` to `btf__type_cnt(btf) - 1`.
+ * @id_map_cnt should be `btf__type_cnt(btf) - start_id`
+ * The mapping is defined as: `id_map[original_id - start_id] = new_id`
+ *
+ * For base BTF, its `start_id` is fixed to 1, i.e. the VOID type can
+ * not be redefined or remapped and its ID is fixed to 0.
+ *
+ * For split BTF, its `start_id` can be retrieved by calling
+ * `btf__type_cnt(btf__base_btf(btf))`.
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


