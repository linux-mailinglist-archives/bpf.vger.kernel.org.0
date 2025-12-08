Return-Path: <bpf+bounces-76261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C845CAC2A7
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 07:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54E15305C4C6
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 06:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72AB313521;
	Mon,  8 Dec 2025 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATfACYKh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6BF313282
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175055; cv=none; b=Xwr74jWxJZwxm4dkcYa/8aqAOYzKQkM7La559ZsuJXgjQb3EJcoIjdKDpUDnDUYf7t1kk1mrQG0fvZ31YfMS7byCpv/USs6KBydvSUuJX2I7xoEWbxHM67Mx6ufwqYX1mN32lX8iB7kNL+JiocCIhmufXPSEX8JW4AUpgtbrCjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175055; c=relaxed/simple;
	bh=d3DscDcBlQkBeK2zxMbgxBMfQr0YMduHtPVlM/+IxLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=odhnGgU+pOghkwKVVSGPvSISKVAryDAgBQcheAxokQKHOKseLltc+OMFaxdon4iG+KPCueUyG5ALf9XU/NMp+eeOwzz3B8H0bKjtWMNYIXzgQjCgVduHBuKAkcU/J3vFJ9lP6ut8c+IWHJF3F82KZ3XUV4GzC7UXKJuTckK3j7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATfACYKh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so2730552b3a.2
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 22:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765175053; x=1765779853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay7fnOLJudeGNu6Y3I2222JeR4NzT0GvBbta2hSfvtU=;
        b=ATfACYKh0KmfZyazUaUgBUYGLQAdvuT69fn4lsx5rk9mTgT6rCO0Plqkumwxt6CzaI
         uPcvWLN54kSABX/rt9s6DQZz+Y9WMCZnZEYLF0CLT2pvKKffM7RMROOuU7eQ31Ro6WqI
         MIXxpxq+ZMthz96pwediia9HCW4bSF65cBCguMet9vPzc/RAz+58JyrmRWVZjSqjxSEN
         p2OGQV9S4p/cea2CdDcgsm21jIMjbYd1Br5YF72JSNbh7bWPxBIKPtN7F869p9lMc81Y
         cxjUCSMYsG2t/gOv8rky71+O29NPA7JFW6fpwv6JZ6gEUhZCBQzELchZHbNDXZib8V4D
         CJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765175053; x=1765779853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ay7fnOLJudeGNu6Y3I2222JeR4NzT0GvBbta2hSfvtU=;
        b=MAVLirOi0/SBbWAcilJSY8/1ri9cJIHKpmKrtvZO/FlvARmf0sm/h0Pab+0SeJH4hJ
         Em7UfwRh4jOAnVQQx3Pzs2BVl0CD50EaPq1VxVRAZWYgRl4+KZZhUVSPlwNr8KTrBupg
         lqT9upkblTshu9oDLMba3R9nXrYhxmzN1BrGOVeObcTdC/3DKAsWaAqhLkRr5SFjvWAU
         XDTX9O8b1t31DtGqVvyriSqvqfKsFLSk5fbF50fVvAZWFunlMT/1cLoLQjjmfhnZpNFi
         AC5mb7CT+zLxXiZXFfHz8DgyFXZ7tSV7NJpj9Pb8rfvU3HRqqVojER5yVz2vDmjkAIOG
         hM6g==
X-Forwarded-Encrypted: i=1; AJvYcCVAVHZFINLFGkHUQt7LDSZlTEgSql7t/nVmzz1sxjKA7uOSyrZhIbjUwXbD2tGhLvOT45Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBUfmACuLHDt8nK3B3SHuCCS4vVyNoWdMrklLJzFjoMzyhQU0Y
	UIeQ3tShIHlQ6LwKNtOZtuUDuRDfpgmhvAWWxu6Wco9/jm9fOdo+JHho
X-Gm-Gg: ASbGncutfwbi5PIBBrYfb37LRxSk2Vbriya3igtT1rmu/x7zCVqfwSiQTOCVn2m4wIU
	v0B0DY61AyAXIyocvIjhxgCAhs8GHb13USKFbD0IM44D1LqlHCkK1DaTI/VtnRlKUk0xzz1T2Uk
	jtmear+XNT9MUxzNG4eVCLw3bdz6d5FQpDUjWj90jaPcKsyABh6CzvAhNAQDX5+2ZuZcAoj3VHA
	8JdjSIofuHlc6HxSV693GSgLZg1OnewXmbc/JU0agOK1h1rXcN1RVvL0DBFypzPfqKTSwUWpmP6
	v/J22t59oFTC6i+T9cuDvZvQssgN5ScoMWlqGZLXnmiXcjocXbreq4O6Hqb/7KtjbuNHZzdo8MO
	hoDtSiWpgQ37bYjoXBlKTY4lRN0lxIRKl/EeiXcmgeFRTyzqd9DZDMEIql4+cc5wd/RevEO7JFp
	XoPp5czvRhoD0YJPCsHWZcAqxplSU=
X-Google-Smtp-Source: AGHT+IHNagrkdB1dXKmAfAxFX7NHUjkLDIJK+H77kgo1bz0xfXRjOReqMV8tPTqftsQHvcAYdui28g==
X-Received: by 2002:a05:6a21:6d89:b0:366:14b2:30a with SMTP id adf61e73a8af0-3661801fc52mr7083372637.61.1765175052779;
        Sun, 07 Dec 2025 22:24:12 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49ca1esm112555855ad.2.2025.12.07.22.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 22:24:11 -0800 (PST)
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
Subject: [PATCH bpf-next v9 04/10] libbpf: Optimize type lookup with binary search for sorted BTF
Date: Mon,  8 Dec 2025 14:23:47 +0800
Message-Id: <20251208062353.1702672-5-dolinux.peng@gmail.com>
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

This patch introduces binary search optimization for BTF type lookups
when the BTF instance contains sorted types.

The optimization significantly improves performance when searching for
types in large BTF instances with sorted types. For unsorted BTF, the
implementation falls back to the original linear search.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 tools/lib/bpf/btf.c | 103 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 80 insertions(+), 23 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 26ebc0234b9b..7f150c869bf6 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -92,6 +92,8 @@ struct btf {
 	 *   - for split BTF counts number of types added on top of base BTF.
 	 */
 	__u32 nr_types;
+	/* the start IDs of named types in sorted BTF */
+	int sorted_start_id;
 	/* if not NULL, points to the base BTF on top of which the current
 	 * split BTF is based
 	 */
@@ -897,46 +899,98 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
-__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
+static __s32 btf_find_by_name_bsearch(const struct btf *btf, const char *name,
+						__s32 start_id, __s32 end_id)
 {
-	__u32 i, nr_types = btf__type_cnt(btf);
-
-	if (!strcmp(type_name, "void"))
-		return 0;
-
-	for (i = 1; i < nr_types; i++) {
-		const struct btf_type *t = btf__type_by_id(btf, i);
-		const char *name = btf__name_by_offset(btf, t->name_off);
-
-		if (name && !strcmp(type_name, name))
-			return i;
+	const struct btf_type *t;
+	const char *tname;
+	__s32 l, r, m, lmost = -ENOENT;
+	int ret;
+
+	l = start_id;
+	r = end_id;
+	while (l <= r) {
+		m = l + (r - l) / 2;
+		t = btf_type_by_id(btf, m);
+		tname = btf__str_by_offset(btf, t->name_off);
+		ret = strcmp(tname, name);
+		if (ret < 0) {
+			l = m + 1;
+		} else {
+			if (ret == 0)
+				lmost = m;
+			r = m - 1;
+		}
 	}
 
-	return libbpf_err(-ENOENT);
+	return lmost;
 }
 
 static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
 				   const char *type_name, __u32 kind)
 {
-	__u32 i, nr_types = btf__type_cnt(btf);
+	const struct btf_type *t;
+	const char *tname;
+	__s32 idx;
+
+	if (start_id < btf->start_id) {
+		idx = btf_find_by_name_kind(btf->base_btf, start_id,
+			type_name, kind);
+		if (idx >= 0)
+			return idx;
+		start_id = btf->start_id;
+	}
 
-	if (kind == BTF_KIND_UNKN || !strcmp(type_name, "void"))
+	if (kind == BTF_KIND_UNKN || strcmp(type_name, "void") == 0)
 		return 0;
 
-	for (i = start_id; i < nr_types; i++) {
-		const struct btf_type *t = btf__type_by_id(btf, i);
-		const char *name;
+	if (btf->sorted_start_id > 0) {
+		__s32 end_id = btf__type_cnt(btf) - 1;
+
+		/* skip anonymous types */
+		start_id = max(start_id, btf->sorted_start_id);
+		idx = btf_find_by_name_bsearch(btf, type_name, start_id, end_id);
+		if (unlikely(idx < 0))
+			return libbpf_err(-ENOENT);
+
+		if (unlikely(kind == -1))
+			return idx;
+
+		t = btf_type_by_id(btf, idx);
+		if (likely(BTF_INFO_KIND(t->info) == kind))
+			return idx;
+
+		for (idx++; idx <= end_id; idx++) {
+			t = btf__type_by_id(btf, idx);
+			tname = btf__str_by_offset(btf, t->name_off);
+			if (strcmp(tname, type_name) != 0)
+				return libbpf_err(-ENOENT);
+			if (btf_kind(t) == kind)
+				return idx;
+		}
+	} else {
+		__u32 i, total;
 
-		if (btf_kind(t) != kind)
-			continue;
-		name = btf__name_by_offset(btf, t->name_off);
-		if (name && !strcmp(type_name, name))
-			return i;
+		total = btf__type_cnt(btf);
+		for (i = start_id; i < total; i++) {
+			t = btf_type_by_id(btf, i);
+			if (kind != -1 && btf_kind(t) != kind)
+				continue;
+			tname = btf__str_by_offset(btf, t->name_off);
+			if (tname && strcmp(tname, type_name) == 0)
+				return i;
+		}
 	}
 
 	return libbpf_err(-ENOENT);
 }
 
+/* the kind value of -1 indicates that kind matching should be skipped */
+__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
+{
+	return btf_find_by_name_kind(btf, btf->start_id, type_name, -1);
+}
+
 __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
 				 __u32 kind)
 {
@@ -1006,6 +1060,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 	btf->fd = -1;
 	btf->ptr_sz = sizeof(void *);
 	btf->swapped_endian = false;
+	btf->sorted_start_id = 0;
 
 	if (base_btf) {
 		btf->base_btf = base_btf;
@@ -1057,6 +1112,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	btf->start_id = 1;
 	btf->start_str_off = 0;
 	btf->fd = -1;
+	btf->sorted_start_id = 0;
 
 	if (base_btf) {
 		btf->base_btf = base_btf;
@@ -1715,6 +1771,7 @@ static void btf_invalidate_raw_data(struct btf *btf)
 		free(btf->raw_data_swapped);
 		btf->raw_data_swapped = NULL;
 	}
+	btf->sorted_start_id = 0;
 }
 
 /* Ensure BTF is ready to be modified (by splitting into a three memory
-- 
2.34.1


