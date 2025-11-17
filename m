Return-Path: <bpf+bounces-74738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DECC645AF
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 14:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9121F4E3B6D
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF28334C02;
	Mon, 17 Nov 2025 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0wBnSbY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C32332EDD
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386006; cv=none; b=rZ7a3TGMyL6p2zWkdW/2sTraja3kz8ap/ZI09x78zhnXpcxB0fjV8l4+NZLmNcW7bVfr89Z1ATsD9yv5O+62oACQsfck/7A8AFaTxRuLjIKTU2EQOSBVpz1y2XfEKNAOVsU86p4obp+NyA/stxoESTNBIvHP6yS5vN7+4rxXMjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386006; c=relaxed/simple;
	bh=JLTGVx4UZtjRB1mVuoBOiHsEz9/Yagm9RBlqqg5WwaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fq6BqH5SsUnDEPq80qiR8kDdSoxhrkU9XJGsMDvL9SVrBoe7Y2gppjZ+ITRv7qPEPcb+Iuq720ZmkGl4PM1l9h7O5Nt59t8T1kV9gnQFlHYdSA6zuFjmj1cEzONM5wuOdUHZR90MgmK/+ZawCqV7edq3c00H/obbLbztvNLz8Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0wBnSbY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so2722571b3a.0
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 05:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763386004; x=1763990804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDnX3/9BOxi6Gb6RG2mMeJXGvVBir6Y+siDzZkdeaTk=;
        b=X0wBnSbYgbm5aXREpeVRWkwSdB4qG5nl5ftbSg4CslIdKmSJa6jKgQGZevn8tounjT
         bo6acLsLtuaaJ3Ymyqrc3hux2zPEWsffGyff13iXCbYylf9EDFhbBWxOBgR5JDRH2Hfj
         6NmzM2BQVryHgV82sdzl4n7tftAuZB93HOu9UlooQQcvcikXhrTmOqzu1m0UldpcfR/U
         9hPLCbP1W++GZfjfOEO2WJO85v/dHKT/ACsMCe9m7rrxjSmWmdNvrRG9lemOUIbA1gki
         H9h/aKTw087MuFKcf97YlDk1Cbk9lRNKvMTVNc/RjwhzElI4NZOXztYi86O+1oyxHKsk
         VRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763386004; x=1763990804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kDnX3/9BOxi6Gb6RG2mMeJXGvVBir6Y+siDzZkdeaTk=;
        b=e8E1XbxwHAn9l9OkKtgMRUTK/EYRYrlrs82Zw5GSWYykjOBY2laJqv0I8Yn7KwvKSm
         j81+vkPTQs+QmYX9GmoBuxDDrX46c2E8R9AeEkW+fKymj1x11GcODf1M7aAsg+geb0Uc
         Q7onqAC9r5QpIhZxtwSZPrSPbZuwjX7/aqdYPAoWWvVWO+99aBHpX00Y32Bn7bGZjD4O
         n5pjf95IZ1YaGoZvcnbKa/CXX3jCoeZ5P6zxuHVvKwKGvBwnoLzjcpiRsjBpEJzsB3BA
         JESsK1nnhb2HKXW0Qi0mxws291XB+o3fw7hjYnI6U4BIlLZb5ZVA/OB04BDg6n0Yy/PV
         a4PQ==
X-Forwarded-Encrypted: i=1; AJvYcCViGJCXFahh7MowBp1TEWKpUsKine32TMC5l2DTksSdzH0tOyC9ezLA8LSDqMpiMILogcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMM78sh6v0EJNK/bn/t8ujKyvsIqVER0xrIdPCs/4dRGXfyUHU
	EtwziPPtxHV5O2t4xCsyeiGCd8gwkEXDCuq4PQ0rwQKvKNzYIADMmCFz
X-Gm-Gg: ASbGncvhOTaKeM9F4IBTHU0REXT4ZDBxEggRih2xb/QcmmTOHLG2Rxx07MKu+GUrDxX
	pGzfyDoQzhbTr9EI3guP7AKzw7aM6W0u0Wn76dCqDD4A7BHcxwmvUYx3iyYQNJorQBBRA5yxgYG
	giCPNnCcKOBrhPstmLqho3H0Xsm6E4y2WwlKRZU4E+XEswAcl/LWXt2FGihr7TOouj5B7uf38a+
	8eF/krJkKS3+GQ0e4aSM1HV4mlanuBvgKSN5xUcmhsk3nIkkO88ZLsmwcBmUeYn1SGDxI+RP7sI
	JtKA/pMEJK6zIvSwsYeV6S/FXtj6m+q03C/rkCO9E0wsEeqIiYkqJTook0Ao1eMA5p+bO4L+TQV
	6yQvTCnQCNYmmvcHT4Ujepus+tQi5nRH+Wx7NsNUwI3VHmTIt7MSX9KYJBPzXwcBYeLc2RodYrz
	/3mxRJaRvijSm5C+Kl
X-Google-Smtp-Source: AGHT+IGZzgzGPA7A8TF1YDSWzknuJkYXs5j8CBMMrMfBosuB5NpJMGFxMPwzRtMqYCAJYGp+hc7eOg==
X-Received: by 2002:a05:6a00:270a:b0:7bf:1a4b:1675 with SMTP id d2e1a72fcca58-7bf1a4b18e8mr4299493b3a.28.1763386003583;
        Mon, 17 Nov 2025 05:26:43 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924cd89bcsm13220953b3a.15.2025.11.17.05.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 05:26:42 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>
Subject: [RFC PATCH v6 4/7] libbpf: Optimize type lookup with binary search for sorted BTF
Date: Mon, 17 Nov 2025 21:26:20 +0800
Message-Id: <20251117132623.3807094-5-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117132623.3807094-1-dolinux.peng@gmail.com>
References: <20251117132623.3807094-1-dolinux.peng@gmail.com>
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
index e3aa31c735c8..bb77e6c762cc 100644
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


