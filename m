Return-Path: <bpf+bounces-78318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC63D0A4D9
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 14:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DB1631734B2
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 13:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B5735BDDD;
	Fri,  9 Jan 2026 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+/zgCh3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B035BDC2
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963623; cv=none; b=cVk1EOrHrZWGG9TMcUa3HQMQwhyT4qdL4KhU07wbW+WZK/nDV0O3SvpXUFGQPOIEp1ESycc3Bo/ugwxkhF4+mhBB/aZpEkCNdrw6+3yarEXaX2vPDdDkR3STuw26pupWs5J4TxOJhXMwCaq4CVyCL5JBiWfJKxAaiE09c/k66HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963623; c=relaxed/simple;
	bh=salwZKOMcBbCVPLM3tI/7wuQ2DcFj21LFNsKb4W+7sA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XcrvEhGmHoaQPoheFfhJMc6te4za3tivIzxsfAKPHZim5sggTSiYeZbnA7rXX5z+lcBBU4vqobLo7bn/I3ShzTtNbxKDd7qYSuBE6QCyW00iHmj+tGrU0I/1lbcixsKBxm6l03qme7hLLM+LZZ0mmPvPmBDE6AW+tkUTr1XqicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+/zgCh3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29f30233d8aso30666455ad.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 05:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963622; x=1768568422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EerJzBZqmLkKlZXphUYi7qXcnVy2FMOdkloJx1qklEI=;
        b=R+/zgCh3qzw93v2PGsDPOwE4NovWoM7ZBNmnYWi74G2BWHRDBOEM2/Xv5xyY+vgyx6
         utMxvs5GZzWY6dILXlcMdFN+CiIFztp7G1fvNcpusAvYmrOeCVMAGH0EkJtuxCOnnv0x
         cNRadA4pbgVZoOXlaaQROf8+6ghWP173yN5rRCaqOIhyJYNhBdhCb0mc/TIWXAeXC/FL
         dcPeX62EwrY7tt6ji3ItwnPkGoSh4t7RHpcTYErzFbjd7NvauXmfKJZLh6jwAJkzDfU6
         +/OD3usd3tYMEL/GgC8PedPxDJqNuPUzte0+rwWlkzlwIDp74soxpLZMWY9/6GMQZPAP
         ivuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963622; x=1768568422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EerJzBZqmLkKlZXphUYi7qXcnVy2FMOdkloJx1qklEI=;
        b=GidR2GFB41fuZXDP/x4E+MDaryW0SQIgiMouoeukmiT//IibbzHn8IcbChMfTzOHGe
         ZHBHHXj1n2xPWhHq3P3u9JxIsYJ09xJHL6pXpNG135g5shkml5DB5/BIn3Ej1T8tUOZx
         yRSzRygEoczA94fQ06XkPPDLHf/4B5ySGXzoCTUUrqXIhKzyib8s6W5zs+NkwDE0lVoc
         tVTEL+OE5FlBlPbg+GdVs49bkYLvCozXHn7tm5tcT9TqWl/POkUVLvONtIC9oBXrwmFH
         kpjESSI0bSXHCTG7NDVVZRzKZ7oc6e+tb4P3+FHbJERJgNEw6Uhx5xbaO8GvFQFOVSmQ
         pr7w==
X-Forwarded-Encrypted: i=1; AJvYcCVcpReVLbhcjuT97wATKc5q23K6VqPzjz9dLMuvg1d67peS5o+rhAsGYDkHRjadv/9iSzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzqrInfDN882b4WwgFGtOFTZgGJLl7uZRfkPESuaALifYDAvu+
	L16Or6nQqe0bAsmEa9CAuFSdVnPrzYMnFQjcU8jMzPoNpFuwRMsQogXo
X-Gm-Gg: AY/fxX4YIib87FESD4ia92dZKHwam9w1UvXhMZtm/X7YU+XEm1VyiHwhfmFn42GPhSs
	ve9a+S1mzI9fTgkWr30Z96iO/5bQQNt6A0/fG2jM+yomYrKrXMpxbrpDS7HkkwUGSlPpqE1wGts
	5VXu/s6rpCHUEwJePgSoxjhlK6xKWLLXV0cX/24I1cl7edSLY/tKpJ3qLOVNSSsZ1r87BEJUltI
	x43g5QCfGIBr7owfwWgF8MsEgDbQ0oa+U5rNhd9VYs9tO+9ZZZ/gE99niRiMcHmgIQog5VKq3nG
	5w4FxIpokjtH9KchgnSILupyjix/i4pA4jGt3+rzO6SpMQbCprNNmwBdg8pS97HCAv2A/CfyYM5
	NZt6FocRxH4TsdddV2ewdxA1iN1GBkVU6Tn2aoq9XQW/mw8Qgfenc4BXyw9fIGJzSFqggWk1gvW
	Ggl0TYUdaHTcbZ2ONP3Mmonv+fJ/E=
X-Google-Smtp-Source: AGHT+IHP0XZhJSwwQ1Pk21yDA+jtoIk8CxB90/Dh6t68iDw/EvtSrmz3Jthw2DPZIVW703U7HsaegA==
X-Received: by 2002:a17:902:e743:b0:2a1:e19:ff4 with SMTP id d9443c01a7336-2a3ee4b750amr103993545ad.29.1767963621346;
        Fri, 09 Jan 2026 05:00:21 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a328sm104927325ad.4.2026.01.09.05.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:00:20 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v12 04/11] libbpf: Optimize type lookup with binary search for sorted BTF
Date: Fri,  9 Jan 2026 20:59:56 +0800
Message-Id: <20260109130003.3313716-5-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109130003.3313716-1-dolinux.peng@gmail.com>
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
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
types in large BTF instances with sorted types. For unsorted BTF, the
implementation falls back to the original linear search.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 tools/lib/bpf/btf.c | 90 +++++++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 24 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index bf75f770d29a..02407a022afb 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -92,6 +92,8 @@ struct btf {
 	 *   - for split BTF counts number of types added on top of base BTF.
 	 */
 	__u32 nr_types;
+	/* the start IDs of named types in sorted BTF */
+	int named_start_id;
 	/* if not NULL, points to the base BTF on top of which the current
 	 * split BTF is based
 	 */
@@ -897,46 +899,83 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
-__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
+static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const char *name,
+					   __s32 start_id)
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
+	__s32 l, r, m;
+
+	l = start_id;
+	r = btf__type_cnt(btf) - 1;
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
 	}
 
-	return libbpf_err(-ENOENT);
+	return btf__type_cnt(btf);
 }
 
 static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
-				   const char *type_name, __u32 kind)
+				   const char *type_name, __s32 kind)
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
+	if (btf->named_start_id > 0 && type_name[0]) {
+		start_id = max(start_id, btf->named_start_id);
+		idx = btf_find_type_by_name_bsearch(btf, type_name, start_id);
+		for (; idx < btf__type_cnt(btf); idx++) {
+			t = btf__type_by_id(btf, idx);
+			tname = btf__str_by_offset(btf, t->name_off);
+			if (strcmp(tname, type_name) != 0)
+				return libbpf_err(-ENOENT);
+			if (kind < 0 || btf_kind(t) == kind)
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
+			if (kind > 0 && btf_kind(t) != kind)
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
+	return btf_find_by_name_kind(btf, 1, type_name, -1);
+}
+
 __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
 				 __u32 kind)
 {
@@ -1006,6 +1045,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 	btf->fd = -1;
 	btf->ptr_sz = sizeof(void *);
 	btf->swapped_endian = false;
+	btf->named_start_id = 0;
 
 	if (base_btf) {
 		btf->base_btf = base_btf;
@@ -1057,6 +1097,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	btf->start_id = 1;
 	btf->start_str_off = 0;
 	btf->fd = -1;
+	btf->named_start_id = 0;
 
 	if (base_btf) {
 		btf->base_btf = base_btf;
@@ -1715,6 +1756,7 @@ static void btf_invalidate_raw_data(struct btf *btf)
 		free(btf->raw_data_swapped);
 		btf->raw_data_swapped = NULL;
 	}
+	btf->named_start_id = 0;
 }
 
 /* Ensure BTF is ready to be modified (by splitting into a three memory
-- 
2.34.1


