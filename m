Return-Path: <bpf+bounces-31654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1638F9011D0
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 16:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5EA282AE7
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E895179647;
	Sat,  8 Jun 2024 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6HVChLQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E404C65;
	Sat,  8 Jun 2024 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717855728; cv=none; b=au0v/vB/shnTBAN8qPFDQe2Skz9r0BQp7CPCANbFxXLvHey3O3zmwJPsOhLYZxpXrhv1AEPzNyPZu+CLvoHPR6Fflo5bDyWHBAef3pS2qbEjK+W4C3jA4XLjN65ApVBAMRm5R94qpJFNOtgwNe6+NUyyzVtSeXMjNUKq3C5Hzag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717855728; c=relaxed/simple;
	bh=HEGG7Jw4XHa7+t9x8HlMvbHURJ9XIkCwF5oDiANqgWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=APAfMQE1fB19TK+WT7fbS2hiHC0l/b6sQghExrhqwzHEkHShezhl8/0QPsP9gd4mC3UkcNMqpDMKKKnDt2zI8Xr0IPJkw6myW+dBzpPn2F5crGcxxmV1pypohpagSKMoaEUPMY2+GHL+JxOTdlHnN8ReocvTMsziqvkZO+/B/LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6HVChLQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f480624d0dso28008055ad.1;
        Sat, 08 Jun 2024 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717855726; x=1718460526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=82uFoB+tBxexAeZtfE5Hpu0dPUHwTBBC/545Tq9KKx0=;
        b=K6HVChLQwGKOH8+84BVevKqWkAYscLsZKlFTZmmOagsMJnapjbQAc8msXETvgwbOgz
         DdFYC+IyPua1ir5ev5Uk5pd/CHDlvk0P1iK7eGpcII1ravw1Weipj2gJP5nh4KzBW3Fl
         CZmGOzEt36SDpHhftw1eeBAiKUBK665511Bo+CFEo76lizJt7gs8aeepgn4aCEjt13wf
         Eu14IJfzVxCrg1Xs5aS16e5XBoGPIuoREEuWNyyP+oBMtHFbCLkXftU0mxMUx6nEwoMc
         e+kuMvje1WYSGC9Ap9f1x6l5U44V9OcIjyDutiMrNdiAxhcG+eWlACT6CHy3VGVjRpNv
         2jBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717855726; x=1718460526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82uFoB+tBxexAeZtfE5Hpu0dPUHwTBBC/545Tq9KKx0=;
        b=JXjEDWPUUdXUEi2ywblMQfTw0hpUPOi7Sn0iM0pnzogwzkP8V/Fr4ixuusHE5/hJt0
         5D9+uXbu7FaVs9V0f4wTfV4pinQ53wuzB0smhAvnweE1wZ2flQTT1j2RwNnGvTVZYjJb
         ArGup0P+3+Hs/XjI1vddMKh1TmUQcVT0HoPSVNagYyuIoxdHSYOZh6pMlfFNV+IkWlEP
         ift3+ikYdpSzsBtKYV7gGBEdBqKu4IKIAFMjdOcXb2g9eXcD/CnC6jnOMxCAERojsrQ9
         RLM5vG49d2PLRs3w1dIjIpSM0uWhB8jXF9rHjHSW5LprcXLQ1zOSS/5Uw702V7EG8pyK
         kdMg==
X-Forwarded-Encrypted: i=1; AJvYcCV5RwSJ212+jcpqr8epH/MmVIAAxirrhH8DVIBRfOjnrcCmFYUyjnfVVnuJg7rlS6dHYd+e20Ms5IBIXiZnPInbsUXIvFXUbkhjKMt6vn4md3OjBa8MAcyPRQKMHC9yJxH7
X-Gm-Message-State: AOJu0YxRn0SK++bb4LiGLEq1GtU/WGSMeiGlAVJpVPu4tpXlWNyozZku
	n+BgOtZ2hRLe5KMNi8s0rQP86jfTSUz+/zGBVOzvWOlbMrqb4t8NoeTvffVR2r0=
X-Google-Smtp-Source: AGHT+IFOQmBxfL0iXd/IBi8keHyE3FeerLEbDBeUnyR5Ru4tPOwr+DjLV4TNdgucpbVU3GM4gKrJfQ==
X-Received: by 2002:a17:902:d509:b0:1f6:677b:ea1b with SMTP id d9443c01a7336-1f6d02dd7c0mr73051705ad.24.1717855725951;
        Sat, 08 Jun 2024 07:08:45 -0700 (PDT)
Received: from ubuntu.localdomain ([240e:304:7695:3989:4506:7d59:e2a5:432a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6e4aba444sm26773205ad.156.2024.06.08.07.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 07:08:45 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	mhiramat@kernel.org,
	song@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [RFC PATCH v3] bpf: Using binary search to improve the performance of btf_find_by_name_kind
Date: Sat,  8 Jun 2024 07:08:35 -0700
Message-Id: <20240608140835.965949-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we are only using the linear search method to find the type id
by the name, which has a time complexity of O(n). This change involves
sorting the names of btf types in ascending order and using binary search,
which has a time complexity of O(log(n)). This idea was inspired by the
following patch:

60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup_name()").

At present, this improvement is only for searching in vmlinux's and
module's BTFs.

Another change is the search direction, where we search the BTF first and
then its base, the type id of the first matched btf_type will be returned.

Here is a time-consuming result that finding 87590 type ids by their names in
vmlinux's BTF.

Before: 158426 ms
After:     114 ms

The average lookup performance has improved more than 1000x in the above scenario.

Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
Changes in RFC v3:
 - Sort the btf types during the build process in order to reduce memory usage
   and decrease boot time.

RFC v2:
 - https://lore.kernel.org/all/20230909091646.420163-1-pengdonglin@sangfor.com.cn
---
 include/linux/btf.h |   1 +
 kernel/bpf/btf.c    | 160 +++++++++++++++++++++++++++++++++---
 tools/lib/bpf/btf.c | 195 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 345 insertions(+), 11 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f9e56fd12a9f..1dc1000a7dc9 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -214,6 +214,7 @@ bool btf_is_kernel(const struct btf *btf);
 bool btf_is_module(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
 u32 btf_nr_types(const struct btf *btf);
+u32 btf_type_cnt(const struct btf *btf);
 bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
 			   u32 expected_offset, u32 expected_size);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 821063660d9f..5b7b464204bf 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -262,6 +262,7 @@ struct btf {
 	u32 data_size;
 	refcount_t refcnt;
 	u32 id;
+	u32 nr_types_sorted;
 	struct rcu_head rcu;
 	struct btf_kfunc_set_tab *kfunc_set_tab;
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
@@ -542,23 +543,102 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
-s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
+u32 btf_type_cnt(const struct btf *btf)
+{
+	return btf->start_id + btf->nr_types;
+}
+
+static s32 btf_find_by_name_bsearch(const struct btf *btf, const char *name,
+				    int *start, int *end)
 {
 	const struct btf_type *t;
-	const char *tname;
-	u32 i, total;
+	const char *name_buf;
+	int low, low_start, mid, high, high_end;
+	int ret, start_id;
+
+	start_id = btf->base_btf ? btf->start_id : 1;
+	low_start = low = start_id;
+	high_end = high = start_id + btf->nr_types_sorted - 1;
+
+	while (low <= high) {
+		mid = low + (high - low) / 2;
+		t = btf_type_by_id(btf, mid);
+		name_buf = btf_name_by_offset(btf, t->name_off);
+		ret = strcmp(name, name_buf);
+		if (ret > 0)
+			low = mid + 1;
+		else if (ret < 0)
+			high = mid - 1;
+		else
+			break;
+	}
 
-	total = btf_nr_types(btf);
-	for (i = 1; i < total; i++) {
-		t = btf_type_by_id(btf, i);
-		if (BTF_INFO_KIND(t->info) != kind)
-			continue;
+	if (low > high)
+		return -ESRCH;
 
-		tname = btf_name_by_offset(btf, t->name_off);
-		if (!strcmp(tname, name))
-			return i;
+	if (start) {
+		low = mid;
+		while (low > low_start) {
+			t = btf_type_by_id(btf, low-1);
+			name_buf = btf_name_by_offset(btf, t->name_off);
+			if (strcmp(name, name_buf))
+				break;
+			low--;
+		}
+		*start = low;
 	}
 
+	if (end) {
+		high = mid;
+		while (high < high_end) {
+			t = btf_type_by_id(btf, high+1);
+			name_buf = btf_name_by_offset(btf, t->name_off);
+			if (strcmp(name, name_buf))
+				break;
+			high++;
+		}
+		*end = high;
+	}
+
+	return mid;
+}
+
+s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
+{
+	const struct btf_type *t;
+	const char *tname;
+	int start, end;
+	s32 id, total;
+
+	do {
+		if (btf->nr_types_sorted) {
+			/* binary search */
+			id = btf_find_by_name_bsearch(btf, name, &start, &end);
+			if (id > 0) {
+				while (start <= end) {
+					t = btf_type_by_id(btf, start);
+					if (BTF_INFO_KIND(t->info) == kind)
+						return start;
+					start++;
+				}
+			}
+		} else {
+			/* linear search */
+			total = btf_type_cnt(btf);
+			for (id = btf->base_btf ? btf->start_id : 1;
+				id < total; id++) {
+				t = btf_type_by_id(btf, id);
+				if (BTF_INFO_KIND(t->info) != kind)
+					continue;
+
+				tname = btf_name_by_offset(btf, t->name_off);
+				if (!strcmp(tname, name))
+					return id;
+			}
+		}
+		btf = btf->base_btf;
+	} while (btf);
+
 	return -ENOENT;
 }
 
@@ -5979,6 +6059,56 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
 	return kctx_type_id;
 }
 
+static int btf_check_sort(struct btf *btf, int start_id)
+{
+	int i, n, nr_names = 0;
+
+	n = btf_nr_types(btf);
+	for (i = start_id; i < n; i++) {
+		const struct btf_type *t;
+		const char *name;
+
+		t = btf_type_by_id(btf, i);
+		if (!t)
+			return -EINVAL;
+
+		name = btf_str_by_offset(btf, t->name_off);
+		if (!str_is_empty(name))
+			nr_names++;
+	}
+
+	if (nr_names < 3)
+		goto out;
+
+	for (i = 0; i < nr_names - 1; i++) {
+		const struct btf_type *t1, *t2;
+		const char *s1, *s2;
+
+		t1 = btf_type_by_id(btf, start_id + i);
+		if (!t1)
+			return -EINVAL;
+
+		s1 = btf_str_by_offset(btf, t1->name_off);
+		if (str_is_empty(s1))
+			goto out;
+
+		t2 = btf_type_by_id(btf, start_id + i + 1);
+		if (!t2)
+			return -EINVAL;
+
+		s2 = btf_str_by_offset(btf, t2->name_off);
+		if (str_is_empty(s2))
+			goto out;
+
+		if (strcmp(s1, s2) > 0)
+			goto out;
+	}
+
+	btf->nr_types_sorted = nr_names;
+out:
+	return 0;
+}
+
 BTF_ID_LIST(bpf_ctx_convert_btf_id)
 BTF_ID(struct, bpf_ctx_convert)
 
@@ -6029,6 +6159,10 @@ struct btf *btf_parse_vmlinux(void)
 	if (err)
 		goto errout;
 
+	err = btf_check_sort(btf, 1);
+	if (err)
+		goto errout;
+
 	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
 	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
 
@@ -6111,6 +6245,10 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
 	if (err)
 		goto errout;
 
+	err = btf_check_sort(btf, btf_nr_types(base_btf));
+	if (err)
+		goto errout;
+
 	btf_verifier_env_free(env);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 2d0840ef599a..93c1ab677bfa 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 /* Copyright (c) 2018 Facebook */
 
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include <byteswap.h>
 #include <endian.h>
 #include <stdio.h>
@@ -3072,6 +3075,7 @@ static int btf_dedup_ref_types(struct btf_dedup *d);
 static int btf_dedup_resolve_fwds(struct btf_dedup *d);
 static int btf_dedup_compact_types(struct btf_dedup *d);
 static int btf_dedup_remap_types(struct btf_dedup *d);
+static int btf_sort_type_by_name(struct btf *btf);
 
 /*
  * Deduplicate BTF types and strings.
@@ -3270,6 +3274,11 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
 		pr_debug("btf_dedup_remap_types failed:%d\n", err);
 		goto done;
 	}
+	err = btf_sort_type_by_name(btf);
+	if (err < 0) {
+		pr_debug("btf_sort_type_by_name failed:%d\n", err);
+		goto done;
+	}
 
 done:
 	btf_dedup_free(d);
@@ -5212,3 +5221,189 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void
 
 	return 0;
 }
+
+static int btf_compare_type_name(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	__u32 ta = *(const __u32 *)a;
+	__u32 tb = *(const __u32 *)b;
+	struct btf_type *bta, *btb;
+	const char *na, *nb;
+
+	bta = (struct btf_type *)(btf->types_data + ta);
+	btb = (struct btf_type *)(btf->types_data + tb);
+	na = btf__str_by_offset(btf, bta->name_off);
+	nb = btf__str_by_offset(btf, btb->name_off);
+
+	return strcmp(na, nb);
+}
+
+static int btf_compare_offs(const void *o1, const void *o2)
+{
+	__u32 *offs1 = (__u32 *)o1;
+	__u32 *offs2 = (__u32 *)o2;
+
+	return *offs1 - *offs2;
+}
+
+static inline __u32 btf_get_mapped_type(struct btf *btf, __u32 *maps, __u32 type)
+{
+	if (type < btf->start_id)
+		return type;
+	return maps[type - btf->start_id] + btf->start_id;
+}
+
+/*
+ * Collect and move the btf_types with names to the start location, and
+ * sort them in ascending order by name, so we can use the binary search
+ * method.
+ */
+static int btf_sort_type_by_name(struct btf *btf)
+{
+	struct btf_type *bt;
+	__u32 *new_type_offs = NULL, *new_type_offs_noname = NULL;
+	__u32 *maps = NULL, *found_offs;
+	void *new_types_data = NULL, *loc_data;
+	int i, j, k, type_cnt, ret = 0, type_size;
+	__u32 data_size;
+
+	if (btf_ensure_modifiable(btf))
+		return libbpf_err(-ENOMEM);
+
+	type_cnt = btf->nr_types;
+	data_size = btf->type_offs_cap * sizeof(*new_type_offs);
+
+	maps = (__u32 *)malloc(type_cnt * sizeof(__u32));
+	if (!maps) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	new_type_offs = (__u32 *)malloc(data_size);
+	if (!new_type_offs) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	new_type_offs_noname = (__u32 *)malloc(data_size);
+	if (!new_type_offs_noname) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	new_types_data = malloc(btf->types_data_cap);
+	if (!new_types_data) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	memset(new_type_offs, 0, data_size);
+
+	for (i = 0, j = 0, k = 0; i < type_cnt; i++) {
+		const char *name;
+
+		bt = (struct btf_type *)(btf->types_data + btf->type_offs[i]);
+		name = btf__str_by_offset(btf, bt->name_off);
+		if (!name || !name[0])
+			new_type_offs_noname[k++] = btf->type_offs[i];
+		else
+			new_type_offs[j++] = btf->type_offs[i];
+	}
+
+	memmove(new_type_offs + j, new_type_offs_noname, sizeof(__u32) * k);
+
+	qsort_r(new_type_offs, j, sizeof(*new_type_offs),
+		btf_compare_type_name, btf);
+
+	for (i = 0; i < type_cnt; i++) {
+		found_offs = bsearch(&new_type_offs[i], btf->type_offs, type_cnt,
+					sizeof(__u32), btf_compare_offs);
+		if (!found_offs) {
+			ret = -EINVAL;
+			goto err_out;
+		}
+		maps[found_offs - btf->type_offs] = i;
+	}
+
+	loc_data = new_types_data;
+	for (i = 0; i < type_cnt; i++, loc_data += type_size) {
+		bt = (struct btf_type *)(btf->types_data + new_type_offs[i]);
+		type_size = btf_type_size(bt);
+		if (type_size < 0) {
+			ret = type_size;
+			goto err_out;
+		}
+
+		memcpy(loc_data, bt, type_size);
+
+		bt = (struct btf_type *)loc_data;
+		switch (btf_kind(bt)) {
+		case BTF_KIND_PTR:
+		case BTF_KIND_CONST:
+		case BTF_KIND_VOLATILE:
+		case BTF_KIND_RESTRICT:
+		case BTF_KIND_TYPEDEF:
+		case BTF_KIND_TYPE_TAG:
+		case BTF_KIND_FUNC:
+		case BTF_KIND_VAR:
+		case BTF_KIND_DECL_TAG:
+			bt->type = btf_get_mapped_type(btf, maps, bt->type);
+			break;
+		case BTF_KIND_ARRAY: {
+			struct btf_array *arr = (void *)(bt + 1);
+
+			arr->type = btf_get_mapped_type(btf, maps, arr->type);
+			arr->index_type = btf_get_mapped_type(btf, maps, arr->index_type);
+			break;
+		}
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION: {
+			struct btf_member *m = (void *)(bt + 1);
+			__u16 vlen = BTF_INFO_VLEN(bt->info);
+
+			for (j = 0; j < vlen; j++, m++)
+				m->type = btf_get_mapped_type(btf, maps, m->type);
+			break;
+		}
+		case BTF_KIND_FUNC_PROTO: {
+			struct btf_param *p = (void *)(bt + 1);
+			__u16 vlen = BTF_INFO_VLEN(bt->info);
+
+			bt->type = btf_get_mapped_type(btf, maps, bt->type);
+			for (j = 0; j < vlen; j++, p++)
+				p->type = btf_get_mapped_type(btf, maps, p->type);
+
+			break;
+		}
+		case BTF_KIND_DATASEC: {
+			struct btf_var_secinfo *v = (void *)(bt + 1);
+			__u16 vlen = BTF_INFO_VLEN(bt->info);
+
+			for (j = 0; j < vlen; j++, v++)
+				v->type = btf_get_mapped_type(btf, maps, v->type);
+			break;
+		}
+		default:
+			break;
+		}
+	}
+
+	free(btf->type_offs);
+	btf->type_offs = new_type_offs;
+	free(btf->types_data);
+	btf->types_data = new_types_data;
+	free(maps);
+	free(new_type_offs_noname);
+	return 0;
+
+err_out:
+	if (maps)
+		free(maps);
+	if (new_type_offs)
+		free(new_type_offs);
+	if (new_type_offs_noname)
+		free(new_type_offs_noname);
+	if (new_types_data)
+		free(new_types_data);
+	return libbpf_err(ret);
+}
-- 
2.25.1


