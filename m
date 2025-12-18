Return-Path: <bpf+bounces-76974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC83CCB9F2
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 285D83026AF3
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 11:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FD8315D35;
	Thu, 18 Dec 2025 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgZQyF3f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921C31AAA9
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057488; cv=none; b=eSkeP35SOsPA1AP1UKyjttmjGfTrs6tW+yGHfN9AqdNl/wzPIs0scolKJcICpjtn2tuaPF926w/pDjaGemA0eOo1q9+uLISTBmUfmAbciwUw7LXxY8Ej3P7ek71LFlgDM4z1tgWDP56Tsm8Uzplw8LXE5L/NIIc2Cn6yz5wwmhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057488; c=relaxed/simple;
	bh=KxIYguLp8SeaWQeT350BLkiIGq16X2SfqmN1sIZpyfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b329IhsWu0T/89y9BOhGxsbKX+DJFGPml+SLAlttALDRmh2JrDPMPFMXk8d6qjZnLzGMe3O3pKhPipsVYtnzK+FfjFUMNbCDWgP6/hWC86gEv0PhQU57oco52abgyNqNRPg0tZ6wHz9WZdycXo//qhUpJG7vCYzVqc90uQWbWUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgZQyF3f; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a2ea96930cso681865ad.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 03:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766057485; x=1766662285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWTU7YkYZsUgcIcDiO47eImJA4XqxyXz+O3bx1BiSAI=;
        b=JgZQyF3fxE4Ww+8kagYtHQzz5EnMPdE0L+pEyP+Ntyy4ahwQXUlOzZlt+m5YoreW2F
         ryLnsq2yOjryOE6+81HRuTwDUVypgcmiwMRhf7/s5hPjbBaAJfG9BbDfrboeO9zblo6T
         0ONpx+Q2zQqzJ+Lq4q10bXa6Bq1Gyzz5SqHWu4HA/NJ/5mrTh7Yjo0XcmPs6VQ1H7L1Y
         MT7Ju1Ib/JWpTmqVo6nkbOOAf8DwSKXzTl//1fcY/GbNntCaITGB4M/6B4eUeqFA4rRd
         EUojXJ8rTQnt10bC4tX+VPk5qmr0rMqsKBfOrWjbPTfQywSW7fabdxpTKABdmR0vGmfQ
         6UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766057485; x=1766662285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HWTU7YkYZsUgcIcDiO47eImJA4XqxyXz+O3bx1BiSAI=;
        b=ZgiPzEaBPu80OX4P5xs5GK9U3B8SWda4GG1lpwrBWQX+PHx4fGqlJ7EClptbrzlV5f
         KpUadRA/lyUc0c05ppylB/+HijtwOYjEVsSOXWkOSXG4z32pJjYFuOQo+6BnFyu2Krkn
         RBJ1Sx4TAsY9sVWFcDqFZAPTN9zrC8RjqBiAhp9rGU2q6SUXktDWYbvMFeYjCWjcAuRr
         UWgWmKoEh2R9OE/kAhjlxmT1FX0v1lCCEvo/AYSwjf6nlDbpJW9qs2qaBiIjRLYbNKit
         MQUkPg9sac5u8c35YQ/lMVKxUE9LUPI16m71fOCH46nwUweQhJxTEyuUuJ1C3lynUBj9
         3JPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWiYWLks91LNoY01YU35gJEMM68aaJl8GVPwtToIJTfJc/9euuaiO0VCfu0xsije8yQmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW5WGc0I6TuXdCfeh/z1Hz3StQJRpf72MQHJEZWcCKdYFG6XcS
	tOVihT72fVvsWGeJ0il16J/wiJYfaYoZSgZ+duAHONn97v4aNJACWxOC
X-Gm-Gg: AY/fxX482KMopu8menOuOAgMLbMKamoSJ57bGD7F2PAsOUAwCp+XHXMTBUzf/lCzjJN
	hugeHCoX1+5t5Xp5ueCuoWl86Z/vqS990Uo7bplAbcou5hIFnCZzpp3VbTR9op5o3Skk4jcRyBU
	tQfNvwvP9QvbL6OvK9hJ6C9hFVIRl9oGbjynAnxjA/a3QU4K9Kd9QbYsoWS1P5U/HoEOp9TVj8c
	j1x66jD/Ekuwdh/9m75XH/bjdMIsL3HCTSzUMg7BWwETFopT/BvOGZXA1RHBThIqKInb08VLmR0
	NOL4FNQ0dnhaMnaG4smGdgMghcsFQRGriao2B1Yd2Iin4VEsnsGwn5+WdS5Kof1etH5ai0Con9C
	gBMp3gIdIIPtMdnF7DiYml7N8/drpvtiKik5WOZiJCDZHGBOQk6tR8k2a9ylQRNkWwgd1JVMchP
	JhfBN35N2z/onXC9zk6rqgi1PXee8=
X-Google-Smtp-Source: AGHT+IG1ZcmxKj9qrvybSbwP+Nq1gJqIR5zkosJ2g86tGdi05X+iVwrfRUtxZQJU9Q4Rbw4XJYSBnA==
X-Received: by 2002:a17:90b:48c4:b0:34c:a35d:de16 with SMTP id 98e67ed59e1d1-34ca35de0bamr11166928a91.11.1766057484998;
        Thu, 18 Dec 2025 03:31:24 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm2328237a91.3.2025.12.18.03.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 03:31:23 -0800 (PST)
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
Subject: [PATCH bpf-next v10 04/13] libbpf: Optimize type lookup with binary search for sorted BTF
Date: Thu, 18 Dec 2025 19:30:42 +0800
Message-Id: <20251218113051.455293-5-dolinux.peng@gmail.com>
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
index ab204ca403dc..2facb57d7e5f 100644
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
+					    type_name, kind);
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
+	if (btf->sorted_start_id > 0 && type_name[0]) {
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
+			if (strcmp(tname, type_name) == 0)
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


