Return-Path: <bpf+bounces-65849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 190E0B29930
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 07:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0587B18877F8
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 05:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F4C26E711;
	Mon, 18 Aug 2025 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KonUp98p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF31726F471
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 05:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496540; cv=none; b=Lvt82TRqOWL9Xe15iqxgyNt5FOSPywFMBjaVKefAxFDp354lf12bjkXO0pwvKkPn7SWYTF8fq17MBaEI9QMHWxs814egg0FZaRuPLdO6wg9BpfT4RY7qhFAo4k42/DWJuz3oeLapzl5YGeVEoF33PFt8AU2j2kwlNLMxqhCi/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496540; c=relaxed/simple;
	bh=9+1rPdXYutEUKkQvjDO60DLRcfnJ1dyzXXlXsZmSVTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XnSqEATVxhWyLJ5PZXqeS3pz2OKP4mp/4s7GkfOzWV7XWN0t8tjj2hHZcX0udw1ou0bercczx8r5yWXe2NlxyDSsz371WL1bFAzu7oXMHdDenJV98sEkAp8CEs7hFX49NCgUs853BjrH8+vDHCnXMPg78S5Y5VOyClRqczockRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KonUp98p; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-323267bcee7so4505391a91.1
        for <bpf@vger.kernel.org>; Sun, 17 Aug 2025 22:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755496538; x=1756101338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZRfWuGPUUgvuKMVWn0BSSyH7DP7rUdcRjJaD+jFoi0=;
        b=KonUp98pvwoU/dydErjIlYwVO3Ft8lGR8YR74Y60HejOxK1W8xXtPoLAhbUirFpX8F
         /71oPaA5CeQFm46Zl+vf6lIkWD8EjwqTuHG8DV4N7BKRIpRNZbss4XvUsf5K8kVhCeod
         6xMj6aGOpjwIR4WcYGUnFvxBEGWcK5YI4FeAKg4X22Gak4+1Ql1NSNv9/mwRj8QoyPWj
         Zs8fykV9nW0tH1OIk0wEefnZLZswZM8UM8TGrqA27PliT9DfIUvLSz/krf24pHqtyh1W
         dwTv0jaWAAyWdAh6JVJr43cf1AdVhodyx4+FD3tz9Sjn4AbfA38ZOmEPWSKUFsrfSAR2
         eHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755496538; x=1756101338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZRfWuGPUUgvuKMVWn0BSSyH7DP7rUdcRjJaD+jFoi0=;
        b=wLmQYzHhlNdobu3Zag7jvEShBGnUawScvCVfCyDkQ4f3QouwAmm8nollxL/p5M0Aa/
         GZW2YUsZbIjAZWeaitBFxXz6GZPE7mGrvShGuQML0BqgdOgUGxZF56LdIKykVUatm0rA
         Zw+pNsbE9ZoHchQZKlOMDmNExK+OaHncw4//blM7xOO0aDNGLszlHkF1P6jvOpcU4HPl
         No+sflGncGFAh6vCULUa0N1lce8Ma0WjjP2e9MQVmlfFdLSyQOqSkq5Sa/b0A7LdLY3x
         WZbir59CQrn4nAZ374gzWqp7AAX2j0zuw6z4SImxvYDpuLGcabPnLoHn8jcJolRZQAtV
         RTQw==
X-Gm-Message-State: AOJu0YxM8oM7sx/4mhDPEzLg7edqFLaoHZhxoMi0py1MktpFyYgjVDzA
	QvajoCbMp3qRb6tHUWb5lA7WN4n9EElQMn5YVMMP2xJztn5f7z1qqrm5
X-Gm-Gg: ASbGncvZ+pCYKAmIt7+1hflw9Tne1iUBfaaAXwBUqlanxsQp7MCfYiAqJWKgNzxBvwD
	1S5/+T1cv9on2WXDJtiLQYDJK9TaTFey7ddW28RUVS58DTqmK9tWfISMbRaLi5nEJzswr0vKCh7
	c++2CNkLbNe4RjId2RHW5964VViVhqxdUtsynIJywCA2+kOsXHJT2Y2cfz4XhuUwVjHl3fNMoJr
	JEBVI8hCzFRyhuzioesVBkaR4j+flyFs7K39lAVFqDLjYAWDDf/bGS83n0eQ0snSppH2sq9aftG
	yasccsCD4KYUDZS/UGDWccNsRDdWjcUM6qA4NFiR5O0M3bGkUyl6xCuTWLZ8UPdXYQ9kll1lrsz
	CrOUi0m0ibIl0AmEdX8QyEkEyoBwsKDWxNl63tHjz3kf34ZMtFFL5QBtB
X-Google-Smtp-Source: AGHT+IHVWq7D5y1VVOmmSlNtcDgm+Q2Kh/UvXw4Jpd+npQ3H3QnyVEyU34H9tXSxX7a0UEwTtKhL/Q==
X-Received: by 2002:a17:90b:51c6:b0:321:29c4:e7c5 with SMTP id 98e67ed59e1d1-32341e9e9c4mr14037235a91.7.1755496538055;
        Sun, 17 Aug 2025 22:55:38 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323439961c9sm7003413a91.13.2025.08.17.22.55.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 17 Aug 2025 22:55:37 -0700 (PDT)
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
	ameryhung@gmail.com,
	rientjes@google.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v5 mm-new 2/5] mm: thp: add a new kfunc bpf_mm_get_mem_cgroup()
Date: Mon, 18 Aug 2025 13:55:07 +0800
Message-Id: <20250818055510.968-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250818055510.968-1-laoar.shao@gmail.com>
References: <20250818055510.968-1-laoar.shao@gmail.com>
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
index 2b03539452d1..bdcf6f6af99b 100644
--- a/mm/bpf_thp.c
+++ b/mm/bpf_thp.c
@@ -175,10 +175,59 @@ static struct bpf_struct_ops bpf_bpf_thp_ops = {
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
2.47.3


