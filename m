Return-Path: <bpf+bounces-73435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25451C31466
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 14:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739D74631C7
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 13:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C281C329364;
	Tue,  4 Nov 2025 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp8EC5DM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1E329397
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263653; cv=none; b=lEqVao4DC6vNqRUlw1/4WWsjajDQwv6dayMkjMCBCKJHz5AjikiPbwFkYkelYofL6IQyoWmPvcGC1W6/7LP1nfgGYbaDNTGRDMWjBVwKHPNX8C5R1RO1yaTmHEMPTm7blHtMrpdFTWW0EaxoXos2M9gF/uhapMYuB6de7qfisvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263653; c=relaxed/simple;
	bh=H8W7FunBp7qoGcxg5bGEeewgRaf3u8ILn6elRUcxoyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y6EyvISrDUqCtYA05RHGp+0e2nSZbViVUZ3L4mj3/iRsW5p93EeB3J4LsSle4KHYG7zhlFewHvEBtLsimTFVDxvkK+Tk+uvwuA7yQKBQvZgXhb0fR4fObafHuRjHJzQI5TpGLcKX9D7X7kwq+XswXX+kpIvtTbx0GG+PM6iCZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fp8EC5DM; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b98a619f020so2635495a12.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 05:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762263651; x=1762868451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NsrgOo4ocG/4BxsQgHROI9+0LDTBXUxvTM9Wy/6b6g=;
        b=fp8EC5DMdVWJEAgeGKsN9e4KRYvc45KgxM/19sd3yhrebHWvucqSHU6M6SK3xd3GKA
         wwWMn0XcSHFAX8BitOoPsoX1zcg+Vp/MuCpuUcXTyHqkXkG3LeGueS3WTmuNlvR8k6Vr
         BKUbFjallSFBgszlDxxddjOLH0OSXF14PQnH6ArcT+W8JTCnTFY6PkNC8jYPMWqOT6CA
         QcmQXDmbT+Lug4sQZVA/b1f+YHWyGyNRLttNVbSNfOHixeUr8phuH4BTD3WIuk+Zblgs
         S83jyniCx40JoIWveT9bXnLZJeHOLhByUwT1l6eQD4cQy1zN9erPk8lJcCHggI46eAHF
         oBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263651; x=1762868451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NsrgOo4ocG/4BxsQgHROI9+0LDTBXUxvTM9Wy/6b6g=;
        b=hbBkz8rvSPBVHnNFktQhfc3GXh+d7O9TCCOvsmzr1LRidjFLTFXn/BBqhWGPJfEH1T
         05VDvhLl8zNysyCrTp0a3EXMDNhP3IIZRIR1FzkZNVZjDrzlZJYx/oV70LFN2qOCc6dP
         lqEAbFCeiXHKOnRIxDQ2hvh6kaqySS9xsDhv8KxKTFu/qQir/5pLXJ5WfuzG4j5BZVE8
         n9sP3C/nKCimcn5S2fShvCKOiJzzX+CIFX3sQIsXATEki9dgr5uIQnBv8jTYOlBhlZCa
         ELlpqrqjf25Uf59D8qaXMHmztHHvRKbc/KBtR/ktR/nC43O29Emtq+bR6IVbcIdwyyLN
         hn4A==
X-Forwarded-Encrypted: i=1; AJvYcCW2f8TUToeKOj3doZ8ljc7wRwqJtkwq6m8yB/Za/DriW96s/EBHY0wZfdHVDk+1Nuc1QJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgd3IFgrBl2FQpwsGi9u6NFQnK0ofRlzzZtsApYZTya7V8oCvg
	2D7zDntG349CjaSzEsoDT6ZAseYb74hwBNcNU3weNuW5lpBvvLEVjICB
X-Gm-Gg: ASbGncsgvO7xCh7hK+AmD3XQDx7W1ciaPEGsIobShykbClx8JKqKhTFpM+AaEtUJoXo
	j8Del5yXIF5NyspZU9NlGnzELH+XO2CkBj4pmuZyhpxpR9tB43AVWs5TGYTzGeu38HLxka8UUXb
	zQYsUhyzjv2DQuMz84yHpLrMhdMjTEbj06tgBpbIO5GAf8Ms03r4MRMpaQyqYSEKtJyU5Ed7AnZ
	plusaqCUaYW/wWHiufHEVdE0jEUnOJUBw4jLR2mxPJbwEoCpG+kSnynTMcsIfwpErPSSVA4wqko
	NyXFr7u8ZinuPA9W8iC1wp+ndQ0ozfQjQxMR4P9rt9QxxxMKb+K6wjuizkzAqhX8egoaaoNyxoP
	GerYqMVxmZnichyDgua2/btSNx+2XpAZPYgN8N9vUtl/Vj3kZB9rt89+qsos/bItQK6tS4+j4l2
	5ma/TemhZ4KGgl+eRe
X-Google-Smtp-Source: AGHT+IF0jGd0yl4ZUQ5poLvNggv7g7BAW0tkkkPqmp6n4W4vlSXsBr2+elxUCoxY1RlLNu9+9K8/Zw==
X-Received: by 2002:a05:6a20:9151:b0:344:b429:fc64 with SMTP id adf61e73a8af0-348ccbfb900mr22350595637.50.1762263650965;
        Tue, 04 Nov 2025 05:40:50 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a7287sm2499238a12.31.2025.11.04.05.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:40:49 -0800 (PST)
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
Subject: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary search for sorted BTF
Date: Tue,  4 Nov 2025 21:40:29 +0800
Message-Id: <20251104134033.344807-4-dolinux.peng@gmail.com>
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
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 tools/lib/bpf/btf.c | 142 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 119 insertions(+), 23 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 3bc03f7fe31f..5af14304409c 100644
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
@@ -897,44 +903,134 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
-__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
+/*
+ * Find BTF types with matching names within the [left, right] index range.
+ * On success, updates *left and *right to the boundaries of the matching range
+ * and returns the leftmost matching index.
+ */
+static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const char *name,
+						__s32 *left, __s32 *right)
 {
-	__u32 i, nr_types = btf__type_cnt(btf);
+	const struct btf_type *t;
+	const char *tname;
+	__s32 l, r, m, lmost, rmost;
+	int ret;
+
+	/* found the leftmost btf_type that matches */
+	l = *left;
+	r = *right;
+	lmost = -1;
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
+	}
 
-	if (!strcmp(type_name, "void"))
-		return 0;
+	if (lmost == -1)
+		return -ENOENT;
+
+	/* found the rightmost btf_type that matches */
+	l = lmost;
+	r = *right;
+	rmost = -1;
+	while (l <= r) {
+		m = l + (r - l) / 2;
+		t = btf_type_by_id(btf, m);
+		tname = btf__str_by_offset(btf, t->name_off);
+		ret = strcmp(tname, name);
+		if (ret <= 0) {
+			if (ret == 0)
+				rmost = m;
+			l = m + 1;
+		} else {
+			r = m - 1;
+		}
+	}
 
-	for (i = 1; i < nr_types; i++) {
-		const struct btf_type *t = btf__type_by_id(btf, i);
-		const char *name = btf__name_by_offset(btf, t->name_off);
+	*left = lmost;
+	*right = rmost;
+	return lmost;
+}
+
+static __s32 btf_find_type_by_name_kind(const struct btf *btf, int start_id,
+				   const char *type_name, __u32 kind)
+{
+	const struct btf_type *t;
+	const char *tname;
+	int err = -ENOENT;
 
-		if (name && !strcmp(type_name, name))
-			return i;
+	if (!btf)
+		goto out;
+
+	if (start_id < btf->start_id) {
+		err = btf_find_type_by_name_kind(btf->base_btf, start_id,
+						 type_name, kind);
+		if (err == -ENOENT)
+			start_id = btf->start_id;
+	}
+
+	if (err == -ENOENT) {
+		if (btf->nr_sorted_types) {
+			/* binary search */
+			__s32 l, r;
+			int ret;
+
+			l = start_id;
+			r = start_id + btf->nr_sorted_types - 1;
+			ret = btf_find_type_by_name_bsearch(btf, type_name, &l, &r);
+			if (ret < 0)
+				goto out;
+			/* return the leftmost with maching names and skip kind checking */
+			if (kind == -1)
+				return ret;
+			/* found the leftmost btf_type that matches */
+			while (l <= r) {
+				t = btf_type_by_id(btf, l);
+				if (BTF_INFO_KIND(t->info) == kind)
+					return l;
+				l++;
+			}
+		} else {
+			/* linear search */
+			__u32 i, total;
+
+			total = btf__type_cnt(btf);
+			for (i = start_id; i < total; i++) {
+				t = btf_type_by_id(btf, i);
+				if (kind != -1 && btf_kind(t) != kind)
+					continue;
+				tname = btf__str_by_offset(btf, t->name_off);
+				if (tname && !strcmp(tname, type_name))
+					return i;
+			}
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
-- 
2.34.1


