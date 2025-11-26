Return-Path: <bpf+bounces-75554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33764C88C2E
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12993B19B4
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A663203A9;
	Wed, 26 Nov 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1LRS1SB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C67031ED88
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147048; cv=none; b=Iwr1mpMhnvP2r6cQKRu+IU2bLIcHvcGBCqe6C1Sw+dZ/JcBffos4N9U72Tbt4ij30UCsoxoPGjQBZPg01cV/uyYErKgmE7sovjQWJ3+ALGv/Mp59dXSXpJ8tzl5qDR8JriLgkUcM3MeczokZ/ehQ5145IR238KOIivtx0O+/R0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147048; c=relaxed/simple;
	bh=d3DscDcBlQkBeK2zxMbgxBMfQr0YMduHtPVlM/+IxLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMYXLoqJPpAelgDc4lDM/pI4gpTVEXbdIzOjRjQ7XWb3tgIQ/K/BYlLXkbu52KZGeAo7PXzyfuxvn85pV1IZ3rFyf0u5ji2+htF9glCtXZBXnbWpGz7Mli17bNwIWquVaBzc0rLWqVVDNimtAuatzsCU8tfiuRPfltzUHfpMBnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1LRS1SB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297e982506fso90517255ad.2
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764147045; x=1764751845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay7fnOLJudeGNu6Y3I2222JeR4NzT0GvBbta2hSfvtU=;
        b=d1LRS1SBFqIAw/EWNAYYzaxruahY8jlP5abN/EruKq00prRiIoJBgJfjgteOl9E5nB
         kOsIGAlDrqZSxDaYkrMyb4oyAvt5D0B7yNxqTaH2QHU0E6YjZAtpzLYUTHaKTE1JkRhd
         Ia4MHCjEuRRp+2X6Vmu1/f500aFlW8cEdim8jd6+4ZftZWp2fl6AoWFCKuARuEtihiD4
         tqrrYnI91m+rFXyo6Wp5w/aJlzuvOwsVfDofjmsa9oF2I7lay5fZWkEsGxjrXPmVaCH5
         Xnj+oOtt0yEPu00XlqfxWtOJ/pCnpKtEqcKp4w+VNsNKhWQKjxRCMZ2WQxeOJNOVjdWk
         2xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147045; x=1764751845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ay7fnOLJudeGNu6Y3I2222JeR4NzT0GvBbta2hSfvtU=;
        b=FKOhHToaim1MOU30Xe6/VfQNurFg5aVx4ak8epN1tVntFDoNbd91hj22k/qOWmoU81
         f+RLP4bKkSugo5JUzI6hp3cBH+BNIxAcsyoSv+SWNM22WE4uk++tevDcqZpnOn3I3knu
         y1BuJBqh43oqVx1rL1KwLstLmkdmpvN/DzvbNDYsjvF6aawZLDzKE5npPzD7DpXaRk6y
         YmW6vned3hFMhP3AXnVk8J82f2PaCuRT5KkcDTlKyo7scq40yGS6JCst5fuc+t4vXEGq
         n2L2HcS8KlsXsWAnluzK11toxChx8GL574Px8kUj4VqzqvppE9uHPhRKgls0PZQVAsMi
         ZvBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0EFbsr+Fc3b7jmJsdrWQo9z4lAwDj3/i5NnwKD3rSD538ryLWuxe4zyJY7JP3OdENiwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp6AWi+ab64W1T9L7cF7qhWTmD9Mjw8le+LoHSmSPSDejrKM2N
	kjOjYLppJr2n6w8RFd27CunY6m1WE1H9TpFgA3o32DyxQUl6OEcgbgUE
X-Gm-Gg: ASbGncu4N3if2ENu7JZ6F66ip4gwKj7dJyIifTr3uKsebpryGBAmCQ3Vhut1Xd4VJY+
	o1D85g4FUJhjlL6NrEWKYoCmTsfL/nvkl7KXJFaW7308aoK7pp5JY004nnFnbYXaW6RmE6CS3ch
	R4OxCUmpF1H9lOzcvLn3yeufcj2N0B/fkemNil8LH/bj38XSiieJ4YjsxIfpV8Q3isbNusGh8+p
	v7i6b0uXzXDkCqCw6vAJ0L5vKdUK+WL81A/8cUuzt4fpUsfBrhRyRUzFiI9OQw6lZg9iwNyQdRe
	lVIFJ4QPXiU/3lPRQfrM60bLJ3HjKyXE+LzIbFhXIrVjwngql/tU/kovE3HC+gHEC0uN4FTzUly
	1wKW+o3o68XXLYnNvtCnO4mJwWT0RjCLQh3jnobclbf6h/FJGlH7dYrFOdglTrxctJ8yOcfo+CN
	nGSBg42Gs/sTEP94sbIxjjTg4AwFM=
X-Google-Smtp-Source: AGHT+IExZ5vV40jQbHSa6VDCuGIq7XV7fGyz1t0658/NLZTAynNpqwve20+hXuyWBrgSMrtQ3opEpQ==
X-Received: by 2002:a17:903:38c5:b0:298:1f9c:e0a2 with SMTP id d9443c01a7336-29b6bf804b1mr226373385ad.54.1764147045527;
        Wed, 26 Nov 2025 00:50:45 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023fd82sm20885721b3a.42.2025.11.26.00.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:50:44 -0800 (PST)
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
Subject: [RFC bpf-next v8 4/9] libbpf: Optimize type lookup with binary search for sorted BTF
Date: Wed, 26 Nov 2025 16:50:20 +0800
Message-Id: <20251126085025.784288-5-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126085025.784288-1-dolinux.peng@gmail.com>
References: <20251126085025.784288-1-dolinux.peng@gmail.com>
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


