Return-Path: <bpf+bounces-75038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0BDC6C97F
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 04:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39DAA4F5D3D
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 03:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703CC2FBE1C;
	Wed, 19 Nov 2025 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeAp0qNH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B72F5A32
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 03:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522516; cv=none; b=XqvYxDwO4Ul25JHqE2VMJfaEKl/4Zh7rDGhPNlXMXD/LExix6Rj8d9xpVsM61ug5HfzUrWExzeU3CBu+GMruTj9TF4J3QHv2r2BAgoSwztc3jwqoNyeUGIOkMbO3/gdnFtfUA0qT4na346v5GdnGgpCIyZQTqx5n5js9w/rIiRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522516; c=relaxed/simple;
	bh=pRQusZkSLe1fwc7vB/uN8SQmj+69/j5iu2aOU15S3L4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KogAT2wqLeO5TQsoe77RmuXzP4fZMn2DlOkgEwtvzXGMl0YQ3CJb5JRS806sTJkxr5aSsmiBL1YGa6HuWZhfzciFQFTba9vk2ey0TI9dHzvksWlGs42Eg7sZrpnH7WUUfrZWWC/+sJWvaljthkxD7qxo0K8vAHWUoJHWh1ty74Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeAp0qNH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2984dfae0acso84991585ad.0
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 19:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763522513; x=1764127313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+FkS3xOd3KY3Oh85nihoYx6o93mfmCHv+PUDaVgOok=;
        b=MeAp0qNHN/n5zj4FNV0Ezs1VuC7VueWWTg7oSv+y8vCAdJ11O3ZtAQ0F5pBKfv8ZCd
         FU9Fqg4WtcIlb7On/uV3vnuKM3jfYVzV3BVcip+hVvoafeG1KGHoY4j0NLS9yqDjWyr+
         xLAsnwVizWqJ3U9I1T8GOQtTLer8TmC4Ex7WI9+oGvjZFLrwnCQcv28hQwvJ1ie6REhI
         xxjn2G31lAKU6VqtXLUNQVEeagtM/smIHWnW7SloSqZjFCRBzG95s1Csu2UI72qs0weH
         PW4QQOlP7d9lsZW45ECRTPJo47wlg3wbGS84Uc/4ERi0Ar0mBqKaH+/9t0W8829SYkFW
         xChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763522513; x=1764127313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+FkS3xOd3KY3Oh85nihoYx6o93mfmCHv+PUDaVgOok=;
        b=WOyfarE6LkPaKulJtJlGBynp9wmLuKtoJFaGGc1Zmt5Uu6471F/kx8UFQe1dqsqXJo
         5+DzXzYe3xZ7GJUsBtWYNqTyJIIDLVPV2fZePQ0V4vV30OvU70QGZFQqA6Q4jzazeAgh
         OpnyG+2kGXm+4YOvI1EcTPon49yfGhqoXhy6jC8glQScfJQKhttbHH6ffXSGFOWHqGu0
         t9W0+qpP3/23aY69RvWmi4JARZKQU70AE0XBwBtu1XZ3Cbj2jqNbkzvUPoYawsc+skwx
         RPj9c2YufQzEyuJzI/HTii8yaS0RxNjw+UixWHYeChWyZZbwBLlDTJjUUJMfb1GvOUfJ
         QCKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsVZnbv5MPVQescWWRzolGV7jCY0VQU51wSk9T4iMD98hUb9Q4kY+mQGI5fckOdDhu1IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4v/JsTM2CLHAvwi86Ht/LwKlFvKgqwH9B24EmwPpix8eB+Bij
	ETfgbdLwskhDWieMxRan+6l16oAFtK8N1g7JVKESFgnNkrvCOXp6JApJ
X-Gm-Gg: ASbGnctyNYFRDlqsl4v+ttG2j6w5DwuGBjU39PclQTjiiYaQ07ZiieABhdwnxk0gnVN
	YsPWfL+gmQZss8ow1eFUO7Ck4yPOvzYuFuFtSByLL5huHnOqiSCKRQnKMWAgMw11qYwotsjIk32
	+kFEWcVU/qte2qXCFIXDdSNK7lEi8onePlB09tP8FbXaZaZ8vt0SuyxtIySXgFwOnmddMXT2/MC
	pPr+ajyP65PiA/UjBaoiHbke/ZEKkI3kTVEFmvEM3FmkwFJqBWjhg5SF8pOYvPymZSlopVI/AjD
	uCZwvcpW0U7LZsTJDJ4vqhrBpVRMA6m1eP92q0U86D31TGG4iHdp5ZmPgAWSmBKUABBN23vsJEv
	opk1Xuk/q64gJqSQWgUrK+XBQ76E8aphSrLw//cri3LU4AZplsanuMMX66fogpIqG+k9JEnavNt
	4A4ARjvyMU4tPQcdA/RIdg0W2RIsutJFKDRXhDsA==
X-Google-Smtp-Source: AGHT+IFUoGb4wi50+IfBdQ0MktBJM2JOUYOy3xmChyxxc0HHiTUr7XweRhKfvx+O/GiZMLxsvLk7Xg==
X-Received: by 2002:a17:903:1b2c:b0:297:fc22:3ab2 with SMTP id d9443c01a7336-2986a73aefdmr216874545ad.36.1763522513507;
        Tue, 18 Nov 2025 19:21:53 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed5asm188352485ad.88.2025.11.18.19.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 19:21:52 -0800 (PST)
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
Subject: [RFC PATCH v7 4/7] libbpf: Optimize type lookup with binary search for sorted BTF
Date: Wed, 19 Nov 2025 11:15:28 +0800
Message-Id: <20251119031531.1817099-5-dolinux.peng@gmail.com>
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

This patch introduces binary search optimization for BTF type lookups
when the BTF instance contains sorted types.

The optimization significantly improves performance when searching for
types in large BTF instances with sorted type names. For unsorted BTF
or when nr_sorted_types is zero, the implementation falls back to
the original linear search algorithm.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 tools/lib/bpf/btf.c | 104 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 23 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ab95ff19fde3..1d19d95da1d0 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -92,6 +92,12 @@ struct btf {
 	 *   - for split BTF counts number of types added on top of base BTF.
 	 */
 	__u32 nr_types;
+	/* number of sorted and named types in this BTF instance:
+	 *   - doesn't include special [0] void type;
+	 *   - for split BTF counts number of sorted and named types added on
+	 *     top of base BTF.
+	 */
+	__u32 nr_sorted_types;
 	/* if not NULL, points to the base BTF on top of which the current
 	 * split BTF is based
 	 */
@@ -897,44 +903,93 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
-__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
+static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const char *name,
+						__s32 start_id, __s32 end_id)
 {
-	__u32 i, nr_types = btf__type_cnt(btf);
+	const struct btf_type *t;
+	const char *tname;
+	__s32 l, r, m;
+
+	l = start_id;
+	r = end_id;
+	while (l <= r) {
+		m = l + (r - l) / 2;
+		t = btf_type_by_id(btf, m);
+		tname = btf__str_by_offset(btf, t->name_off);
+		if (strcmp(tname, name) >= 0) {
+			if (l == r)
+				return r;
+			r = m;
+		} else {
+			l = m + 1;
+		}
+	}
 
-	if (!strcmp(type_name, "void"))
-		return 0;
+	return btf__type_cnt(btf);
+}
 
-	for (i = 1; i < nr_types; i++) {
-		const struct btf_type *t = btf__type_by_id(btf, i);
-		const char *name = btf__name_by_offset(btf, t->name_off);
+static __s32 btf_find_type_by_name_kind(const struct btf *btf, int start_id,
+				   const char *type_name, __u32 kind)
+{
+	const struct btf_type *t;
+	const char *tname;
+	int err = -ENOENT;
+
+	if (start_id < btf->start_id) {
+		err = btf_find_type_by_name_kind(btf->base_btf, start_id,
+			type_name, kind);
+		if (err > 0)
+			goto out;
+		start_id = btf->start_id;
+	}
+
+	if (btf->nr_sorted_types > 0) {
+		/* binary search */
+		__s32 end_id;
+		int idx;
+
+		end_id = btf->start_id + btf->nr_sorted_types - 1;
+		idx = btf_find_type_by_name_bsearch(btf, type_name, start_id, end_id);
+		for (; idx <= end_id; idx++) {
+			t = btf__type_by_id(btf, idx);
+			tname = btf__str_by_offset(btf, t->name_off);
+			if (strcmp(tname, type_name))
+				goto out;
+			if (kind == -1 || btf_kind(t) == kind)
+				return idx;
+		}
+	} else {
+		/* linear search */
+		__u32 i, total;
 
-		if (name && !strcmp(type_name, name))
-			return i;
+		total = btf__type_cnt(btf);
+		for (i = start_id; i < total; i++) {
+			t = btf_type_by_id(btf, i);
+			if (kind != -1 && btf_kind(t) != kind)
+				continue;
+			tname = btf__str_by_offset(btf, t->name_off);
+			if (tname && !strcmp(tname, type_name))
+				return i;
+		}
 	}
 
-	return libbpf_err(-ENOENT);
+out:
+	return err;
 }
 
 static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
 				   const char *type_name, __u32 kind)
 {
-	__u32 i, nr_types = btf__type_cnt(btf);
-
 	if (kind == BTF_KIND_UNKN || !strcmp(type_name, "void"))
 		return 0;
 
-	for (i = start_id; i < nr_types; i++) {
-		const struct btf_type *t = btf__type_by_id(btf, i);
-		const char *name;
-
-		if (btf_kind(t) != kind)
-			continue;
-		name = btf__name_by_offset(btf, t->name_off);
-		if (name && !strcmp(type_name, name))
-			return i;
-	}
+	return libbpf_err(btf_find_type_by_name_kind(btf, start_id, type_name, kind));
+}
 
-	return libbpf_err(-ENOENT);
+/* the kind value of -1 indicates that kind matching should be skipped */
+__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
+{
+	return btf_find_by_name_kind(btf, btf->start_id, type_name, -1);
 }
 
 __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
@@ -1006,6 +1061,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 	btf->fd = -1;
 	btf->ptr_sz = sizeof(void *);
 	btf->swapped_endian = false;
+	btf->nr_sorted_types = 0;
 
 	if (base_btf) {
 		btf->base_btf = base_btf;
@@ -1057,6 +1113,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	btf->start_id = 1;
 	btf->start_str_off = 0;
 	btf->fd = -1;
+	btf->nr_sorted_types = 0;
 
 	if (base_btf) {
 		btf->base_btf = base_btf;
@@ -1715,6 +1772,7 @@ static void btf_invalidate_raw_data(struct btf *btf)
 		free(btf->raw_data_swapped);
 		btf->raw_data_swapped = NULL;
 	}
+	btf->nr_sorted_types = 0;
 }
 
 /* Ensure BTF is ready to be modified (by splitting into a three memory
-- 
2.34.1


