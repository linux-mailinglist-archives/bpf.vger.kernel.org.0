Return-Path: <bpf+bounces-76975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1B6CCB9EF
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91D9C304E612
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78DA31A815;
	Thu, 18 Dec 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjKWi73M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A992F549C
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057492; cv=none; b=Zoc7g41coNznemYpGT++IUL6S75T4T6Dy0TTmpQcw0rq/7rAuR3AAOxVysgRDH7ivf8xcZLrZmmNwAf+YA5/Sh8mTcOpJTyw/G9kmUoMNsD7fBvj7U45PBB5cwpVF2PK2DvGSo2em7tsOO+xtkpialyn9YmIpHDBOnHqtZ64PT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057492; c=relaxed/simple;
	bh=MJCWCSf7+gBpXj5+kFXAWTCAHljmZxeXXmtQQ0SlYV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fZz295Blx1ClvEyvEETtukV1DMpOdHUY70G86624zxEE1MR2FliY54x5zb9qzZDSpJ56UnCC7fqJ7gU34jSCI3kng4IOHX8kcWjdjcBRlFu2LBxXSgX0LRYa14GKb1HV5tHfqsPF6lqVl8Smnbj4aeq/J0vCh6biwM/n+nDT3Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjKWi73M; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso372236a91.3
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 03:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766057489; x=1766662289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ks0ORR4UPC8cdozXOqcEU9Y4B28RYyjPhBeqsdEUJ5I=;
        b=CjKWi73MyCirHZ/TZ35RsBZHeAYeuuJlAYN9ooDeK0Qd0Zsc92agPJpK8fLW0VLPII
         3elBw03wbgyAkLWHaZhLP7jijXuNZce2nHlNx+YngnRRqDtgeJsovdvITJsccYMyxC0P
         zwlCJC8aelUf5+Om8mQGR1sH5PsFVx0a/s7NeyH0U3kpeVJGHXrrhTEMHIXFG/myK9K4
         HrvZ1AHCTHPOe1sCYB9o2RZdafVAd/+mOu1zWGiBFL4aDhweK7NhIPE+Ln74/0DeycTC
         EHUYCBezmhu2Y7g+pMPnqtPtOJiSx+1U5GAUHajG5OVxDPMebMlRc0QC9HcXwBGRtjEM
         nvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766057489; x=1766662289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ks0ORR4UPC8cdozXOqcEU9Y4B28RYyjPhBeqsdEUJ5I=;
        b=hHuoW831bsSiJ8buHgk0P9P1WvlfDrPgwOaW4QmWFFMEaEejE6PXEcFZpM205pOlxY
         D+2jc6p/pzSiXfvmuNSwjlyw5ZDWwpvq8tIE6w7RsD8LwTUWD0ZT6GZB2R43r/Ag/lR+
         Ypdg1n3m/x2vs0y6GIa5UGZ/5BeHdLUvQRmSU7HSLKIsEiYSsUYZeTkLtA/G8HPmD6jH
         7xhPsmIKaS5uxMLZDQdGcYhr5Pmmt6h2CDWa8xKA8DnnpZMTDWXmEH/W+SJuRI18x6YP
         hFN5lXaH+CMA/OxfxedtgDT206cqJK+O6V9mrd9ZOg8zwlTufjFCXA2AIsn8/8kVeVIs
         7BVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJR5+U0AJIzLRnH+CRVtDz0CCqhJCIc7qvXD24jX+jwebTwqijKADWYeJm31CVZoKmFWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsrUj2jZo4FWqLKhCp9g8BTMoWQg9mBOWTRPe+HmXYV+TAnl2K
	3d/iM+C6EH5xkWkKDl6T/nVixUfcGow9BelOh7TfqBXQNXQA7Tm+XUGJ
X-Gm-Gg: AY/fxX6Y59P7LgHA5WeVLaLzhxCJK+L3yvsiFbrI+ApsVMrMff3eTPqGv3sz9MQ1ss+
	zjKXxuRrbiUUm+Xjw4Mh3PIG4XIbxWGl2fvODdKxAE9dnPgISl/VqcmsRSPrL6T0DKP0w5srkw9
	N/IoyD9sSuLQgyjvIxRX/5NJd0kkquqSfXhhVQ17xuG0aMj65JO/c6aKmVHEdusyKkzD72ph1/A
	IY2xRoFeNEyDwGw/RGgstSXgKiDDkU2ea2HxSlYU0CXOapPXH4drv+YoZytuv7FV4Grko6XNywR
	Caw+sX+xaEF/CG67NoxHxNyAwhXwxOseq90uwj82cbzqrAhTvwBZM+tyd/+6jOglUovtbmd+gxs
	oIOFQkxqv+eioCVpCK45Hd0CuoN58tqi3jNDzZgnDu/9W8iQQn9qoCPvO5l/9XJdzeWLwiAug45
	HeSdN/Pm4uHVrGXisVv1llH0cNuz0=
X-Google-Smtp-Source: AGHT+IEySBV+KCTgdrjD3x8MpUwLOxfCP11MntDaFD4SAgq/+i2aamQwMQYKJtgPg09lbDTVxxjigw==
X-Received: by 2002:a17:90b:3912:b0:343:d70e:bef0 with SMTP id 98e67ed59e1d1-34abd8488c6mr18834187a91.21.1766057488610;
        Thu, 18 Dec 2025 03:31:28 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm2328237a91.3.2025.12.18.03.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 03:31:27 -0800 (PST)
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
Subject: [PATCH bpf-next v10 05/13] libbpf: Verify BTF Sorting
Date: Thu, 18 Dec 2025 19:30:43 +0800
Message-Id: <20251218113051.455293-6-dolinux.peng@gmail.com>
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

This patch checks whether the BTF is sorted by name in ascending
order. If sorted, binary search will be used when looking up types.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 tools/lib/bpf/btf.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 2facb57d7e5f..c63d46b7d74b 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -899,6 +899,46 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
+/*
+ * Assuming that types are sorted by name in ascending order.
+ */
+static int btf_compare_type_names(__u32 *a, __u32 *b, const struct btf *btf)
+{
+	struct btf_type *ta = btf_type_by_id(btf, *a);
+	struct btf_type *tb = btf_type_by_id(btf, *b);
+	const char *na, *nb;
+
+	na = btf__str_by_offset(btf, ta->name_off);
+	nb = btf__str_by_offset(btf, tb->name_off);
+	return strcmp(na, nb);
+}
+
+static void btf_check_sorted(struct btf *btf)
+{
+	const struct btf_type *t;
+	__u32 i, k, n;
+	__u32 sorted_start_id;
+
+	if (btf->nr_types < 2)
+		return;
+
+	sorted_start_id = 0;
+	n = btf__type_cnt(btf);
+	for (i = btf->start_id; i < n; i++) {
+		k = i + 1;
+		if (k < n && btf_compare_type_names(&i, &k, btf) > 0)
+			return;
+		if (sorted_start_id == 0) {
+			t = btf_type_by_id(btf, i);
+			if (t->name_off)
+				sorted_start_id = i;
+		}
+	}
+
+	if (sorted_start_id)
+		btf->sorted_start_id = sorted_start_id;
+}
+
 static __s32 btf_find_by_name_bsearch(const struct btf *btf, const char *name,
 						__s32 start_id, __s32 end_id)
 {
@@ -1147,6 +1187,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	err = err ?: btf_sanity_check(btf);
 	if (err)
 		goto done;
+	btf_check_sorted(btf);
 
 done:
 	if (err) {
-- 
2.34.1


