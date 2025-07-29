Return-Path: <bpf+bounces-64599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 741B0B14B08
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 11:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942B61AA2B12
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 09:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E58233721;
	Tue, 29 Jul 2025 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrLnc94w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E36230BCE
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780727; cv=none; b=A/7UvHDGMw32fLpTL5mE88fAv3G6fPbwOR7sKrRbA+A7zMdwxaUgndO1AiNc39p+1BgybAx8aY0Rqdtj119NzUyWYwBK9fcCYOCsat7EyM79zuMyAXkmREtPo4wnakRj2kIToHBZCSFWEniKH/3wsDjDXR+b41hXkcquVWx354A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780727; c=relaxed/simple;
	bh=H7ULst5Qlz51PURJjSOSbL3onhC9YReI0X7YJO7knS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P02EO4NCt/ElELsZQNybA35/x8flRrHim5ufdilYr3nbCjgJQ6oVcQArKohF1yOPDsyJPgZ2P6HVIFhBdUWSl1Koj9m+M0BVWLrsYuCU1LcLTC33T2r6nr+6yii1xPcBMXKpA7eZj4J2/jLuWpm8+RD4uFs+dckKkTNorPfPWek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrLnc94w; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23aeac7d77aso49455235ad.3
        for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 02:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780725; x=1754385525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4wuSHp5MgGj5X4uVUc86dlTYO+Bq0AoM4t6bSoJim8=;
        b=lrLnc94w0LZJtC2K7srM7uA7FIKWRmKUWwEtyqSHPTdmrBK+gA619rBcBx9VEo8DgW
         hkc7g+2jaKjVqzyzeCnjKs7C7ta7LWJLi3CZ706oes45pG58MCBXxOAPA/SOyeDddvUe
         A3kbLdh6jlWAIY+hK8n2To3M6FEtmSXYSvJWwHYhaN6sbJcmB6pWbEX1s89VcneU/A9X
         51/AehnEeAGSNfjUxuG8J0iJvIVvU622w2E8jQAm3AkD9nVToB2QsOGYZwDcl5bhGf0k
         FRhRQ+jmFbLPU61Ua4SYfJEC8PCjYJghhUKnH3cSD2mZZjYCKRR5dgd13k48fm4FNBTu
         v1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780725; x=1754385525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4wuSHp5MgGj5X4uVUc86dlTYO+Bq0AoM4t6bSoJim8=;
        b=cbbQ+ihJUxQkbvuMw0AvN+FAoq3mPPCPYmEkRZGN9c40Y1312hEKsixFOLlddvMCtP
         g9vxs7QYl3gvgjwULFHAN9w1jNsOYFkHSTaDScckNaXBWvu8STOigSZRdVUtGp4Hb5Fj
         uzrKHoo+5tKHPmVN+OyT9p8kVmufr0g5w0agqtrZrqyxm2al4678yqWQk34oem6naJwR
         I3QXSxfeNiEs06xX9SEGKHrn07NbsVaw8p/ORgtwFqrA61GT+I+nYgHT+ApWsmPFNife
         n8GpR6vsh89q0ZHea97E6+EurLv0mjed98HevIi1ErcrYAzcB3JPpsUdTpUWYptUxhl+
         kIOQ==
X-Gm-Message-State: AOJu0YyuQ7wihxp563fXkwDGu2N94n3EXegJRmV2QWbS/wW4/ssrvEC9
	qn/UXzHbgIeFzXS01vS5zwmV318cTBTX+WvAXxo3eQiWCS6OkWYligbH
X-Gm-Gg: ASbGncs9brKLoSaVpRA8185ZTtYu7odpRj77zUtwiHRc+W/5ftAy0j7Apkb1b/W4ueT
	TTiIeAcm6sLJJbCUHnF0vx79DWE+bjXPSxrWGs3Srv4WQk/MegJ9sgP2+6wBbW7wuffjDERYPvd
	jZydSVZ+0ZhChq/5fajpIq2tZZPvtliu5QYRkQoiCgIVEm5ZY9jE97tCM9nm5v+gJms9I/5ERq9
	MqugsBKJZl/4ibdKgO+Sy0r9YP0uf71URHB9mPFyEdQUxNOTLyqp/9QayOSKqfFdx9Gt01cSPI2
	dMe4JOXE5sMyOGk2plR/mtIIBRMkbItnC/VsxFAU+rj48Op3Q4jt/kOdjJB+dABwNcNVDscQCAF
	mT4z/ITw9Wh/3KeJxf6oFZdb87DKcvTBVtl/qviF6GXNv5pDS
X-Google-Smtp-Source: AGHT+IHImCx59GtUTMVH5evvVf6lAb6VeAEl4nWfKJH/fqFebPmYqu8OpPSeco+MQCs7mhFBgOKpmw==
X-Received: by 2002:a17:903:903:b0:237:e696:3d56 with SMTP id d9443c01a7336-23fb3126909mr242761875ad.32.1753780724700;
        Tue, 29 Jul 2025 02:18:44 -0700 (PDT)
Received: from localhost.localdomain ([101.82.174.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30be01sm74337015ad.39.2025.07.29.02.18.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Jul 2025 02:18:44 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v4 2/4] mm: thp: add a new kfunc bpf_mm_get_mem_cgroup()
Date: Tue, 29 Jul 2025 17:18:05 +0800
Message-Id: <20250729091807.84310-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250729091807.84310-1-laoar.shao@gmail.com>
References: <20250729091807.84310-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will utilize this new kfunc bpf_mm_get_mem_cgroup() to retrieve the
associated mem_cgroup from the given @mm. The obtained mem_cgroup must
be released by calling bpf_put_mem_cgroup() as a paired operation.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/bpf_thp.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
index 10b486dd8bc4..040f988dbdbd 100644
--- a/mm/bpf_thp.c
+++ b/mm/bpf_thp.c
@@ -161,10 +161,59 @@ static struct bpf_struct_ops bpf_bpf_thp_ops = {
 	.name = "bpf_thp_ops",
 };
 
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_mm_get_mem_cgroup - Get the memory cgroup associated with a mm_struct.
+ * @mm: The mm_struct to query
+ *
+ * The obtained mem_cgroup must be released by calling bpf_put_mem_cgroup().
+ *
+ * Return: The associated mem_cgroup on success, or NULL on failure. Note that
+ * this function depends on CONFIG_MEMCG being enabled - it will always return
+ * NULL if CONFIG_MEMCG is not configured.
+ */
+__bpf_kfunc struct mem_cgroup *bpf_mm_get_mem_cgroup(struct mm_struct *mm)
+{
+	return get_mem_cgroup_from_mm(mm);
+}
+
+/**
+ * bpf_put_mem_cgroup - Release a memory cgroup obtained from bpf_mm_get_mem_cgroup()
+ * @memcg: The memory cgroup to release
+ */
+__bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
+{
+#ifdef CONFIG_MEMCG
+	if (!memcg)
+		return;
+	css_put(&memcg->css);
+#endif
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_thp_ids)
+BTF_ID_FLAGS(func, bpf_mm_get_mem_cgroup, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
+BTF_KFUNCS_END(bpf_thp_ids)
+
+static const struct btf_kfunc_id_set bpf_thp_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_thp_ids,
+};
+
 static int __init bpf_thp_ops_init(void)
 {
-	int err = register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
+	int err;
+
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_thp_set);
+	if (err) {
+		pr_err("bpf_thp: Failed to register kfunc sets (%d)\n", err);
+		return err;
+	}
 
+	err = register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
 	if (err)
 		pr_err("bpf_thp: Failed to register struct_ops (%d)\n", err);
 	return err;
-- 
2.43.5


