Return-Path: <bpf+bounces-58520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB791ABCEF4
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 08:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEAA1B66001
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 06:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A365E25B1D2;
	Tue, 20 May 2025 06:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMiyu2Kx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9119259F
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 06:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747721165; cv=none; b=T2syHZvj7R6B5gaHxxLYzV5PGEFigTGjylfaLHzI1vmhBWXCb3u60gpVFzKTVEnyNlo4emfAdWiIMSV1B9FEpD3/hZdX02jR4/hlZs5MSjTnow3FN5TUFPXpVgBdyyiwigV/K/xGyKzthObPOjBfBlQviCJX9x9HVh2JIEddp0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747721165; c=relaxed/simple;
	bh=Ri+Djq1hO/7LpLz3lYMuCDlzEQ1yvapfiLwpnKa/Ia0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5TLPDspN5MZ8RX4+6TKu/O2PNsX/syFUhDwGKKtfQSD5E4UaXD7i2dkTZBslYIYku7AzP77VQWm6VBI3b80YVOKytVurhh2c2k6XfV9RhBX6ebSQNf5vbdhHsWGpcEyCZSmDFJCv7I2iWPzgvwriXnwCcnqympxVgo/eGPlaj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMiyu2Kx; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-306bf444ba2so5123560a91.1
        for <bpf@vger.kernel.org>; Mon, 19 May 2025 23:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747721163; x=1748325963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exjs9qv769uSOVDe/SfT4xTE+P3QbGIK6VCcQPIsDkU=;
        b=KMiyu2Kx71j4JoHkLz9VfSXy5w7ny/AqfVcnHmcCM6ZtJe/LGDTptUtEpF8U3Ug8lD
         pNFw/+k+md6hG0b3AkRPuLDrtuJTu1fNsRF6qdSYQ8PXYzkXAMBjeBtI5m7lNgMe1BLR
         gMQfRaAc5kC8QcMoT9VsTZ08I4tpWrbLuqGGMfPTcjOn+JMgMWBGpSFOYtR1NUod5lrA
         FIJMsB10sj3eF+jGYlOqBRH8Nn8ronJzO4XhB/YnrE5PK79eXCNzaF7U6WYjkmv8Rd4G
         vSwO09hM9tdkJuQ3KI08UUPRtteixJv2PT8iEe5M/vI3xUP8KPIrVoMxwlqMuS4yLNbN
         ivAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747721163; x=1748325963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exjs9qv769uSOVDe/SfT4xTE+P3QbGIK6VCcQPIsDkU=;
        b=B6q7XBU9JvDLCXljpLA1qAYn83aKTyaUlM2kS3kk0bQGW4n357hrJoKDg0nL5ajev2
         wcVktWyy6FGCnvfzWW1PgP00YQdaUzBRXwQo1H+OTwLiL/HztR3d/rR6hWVpMPF738yJ
         MesR467+udPnYL1PeJFPNljSfINDzGCb3ohcSPgSgoZ8/FsN/GvfrSWBeCsrDOzyKVfj
         NFnjMVNN+0cuULJAIC0Chi4r5cBEN/0lTtxlVwQlUJWmgNw+3Gx2Rw9El/lzJj/Bm3X3
         lNDw44rROMYcyvriYLJYqyRYBcZ3pN3hfhPOzi8kTS6dvnORLyh3LuzMim3LYgKOzvYD
         33vw==
X-Gm-Message-State: AOJu0Yx7dbxMOp3DZdaYsPkHnhLloLDNmhIL0uxCpZqh9IbcZ8UbNqe4
	XljQsPROEPEVhKCSEd64cuZZxJN96J2s/4rB5Bv8qA+uvOnEjOIY3s3E
X-Gm-Gg: ASbGnctHkvnY+PSQIEJ1Z/8uya9tv9Ngl1koephqCGhw4Bx23t289UN3KRohJDXI0bi
	TbWBPo9gb0d0u36+ZQWluVw1vJsDc4U4WbZLy9X05YcNLjjSQxbcRAo/vnDS2DKMeYBj7wSPWOo
	uMSM0Jp+n6ItM9tslag1kOktqmvrGGhIozPrlKosMV33lNQyrtWrUrXnrZke19/rjSSmbiotb8t
	L4xnpWwm4PlmH0Mh07gv5GhRDrijz+z1os+PC/Fo+aVS0v98wjhr09SWVyln3tgNAKlNn3B2JgM
	m1A+Q6WbVr0P/UGM4jyUNcQgkwv/QjOhib5rp4sTCtCrpCUd0wpENwLww1/XPQVax5/7gq9lhOH
	AMMi3AKpWqA==
X-Google-Smtp-Source: AGHT+IHIoNbQcghkG/2Yz2wEhJFRGdpNDkEnmYh23lOeG8yiA4c65L5qk+Gp1vIDPBA6sGNxxCYglA==
X-Received: by 2002:a17:90b:4c8d:b0:30e:9349:2d96 with SMTP id 98e67ed59e1d1-30e93493228mr20420682a91.28.1747721162532;
        Mon, 19 May 2025 23:06:02 -0700 (PDT)
Received: from localhost.localdomain ([39.144.103.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36385e91sm823428a91.12.2025.05.19.23.05.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 May 2025 23:06:02 -0700 (PDT)
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
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 1/5] mm: thp: Add a new mode "bpf"
Date: Tue, 20 May 2025 14:04:59 +0800
Message-Id: <20250520060504.20251-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250520060504.20251-1-laoar.shao@gmail.com>
References: <20250520060504.20251-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Background
----------

Historically, our production environment has always configured THP to never
due to past incidents. This has made system administrators hesitant to
switch to madvise.

New Motivation
--------------

We’ve now identified that AI workloads can achieve significant performance
gains with THP enabled. To balance safety and performance, we aim to allow
THP only for AI services while keeping the global system setting at never.

Proposed Solution
-----------------

Johannes suggested introducing a dedicated mode for this use case [0]. This
approach elegantly solves our problem while avoiding the complexity of
managing BPF alongside other THP modes.

Link: https://lore.kernel.org/linux-mm/20250509164654.GA608090@cmpxchg.org/ [0]

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/huge_mm.h |  2 ++
 mm/huge_memory.c        | 65 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e893d546a49f..3b5429f73e6e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -54,6 +54,7 @@ enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
 	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
+	TRANSPARENT_HUGEPAGE_REQ_BPF_FLAG,	/* "bpf" mode */
 };
 
 struct kobject;
@@ -174,6 +175,7 @@ static inline void count_mthp_stat(int order, enum mthp_stat_item item)
 
 extern unsigned long transparent_hugepage_flags;
 extern unsigned long huge_anon_orders_always;
+extern unsigned long huge_anon_orders_bpf;
 extern unsigned long huge_anon_orders_madvise;
 extern unsigned long huge_anon_orders_inherit;
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 47d76d03ce30..8af56ee8d979 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -79,6 +79,7 @@ static atomic_t huge_zero_refcount;
 struct folio *huge_zero_folio __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
+unsigned long huge_anon_orders_bpf __read_mostly;
 unsigned long huge_anon_orders_madvise __read_mostly;
 unsigned long huge_anon_orders_inherit __read_mostly;
 static bool anon_orders_configured __initdata;
@@ -297,12 +298,15 @@ static ssize_t enabled_show(struct kobject *kobj,
 	const char *output;
 
 	if (test_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags))
-		output = "[always] madvise never";
+		output = "[always] bpf madvise never";
+	else if (test_bit(TRANSPARENT_HUGEPAGE_REQ_BPF_FLAG,
+			  &transparent_hugepage_flags))
+		output = "always [bpf] madvise never";
 	else if (test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
 			  &transparent_hugepage_flags))
-		output = "always [madvise] never";
+		output = "always bpf [madvise] never";
 	else
-		output = "always madvise [never]";
+		output = "always bpf madvise [never]";
 
 	return sysfs_emit(buf, "%s\n", output);
 }
@@ -315,13 +319,20 @@ static ssize_t enabled_store(struct kobject *kobj,
 
 	if (sysfs_streq(buf, "always")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_REQ_BPF_FLAG, &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
+	} else if (sysfs_streq(buf, "bpf")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
+		set_bit(TRANSPARENT_HUGEPAGE_REQ_BPF_FLAG, &transparent_hugepage_flags);
 	} else if (sysfs_streq(buf, "madvise")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_REQ_BPF_FLAG, &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
 	} else if (sysfs_streq(buf, "never")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_REQ_BPF_FLAG, &transparent_hugepage_flags);
 	} else
 		ret = -EINVAL;
 
@@ -495,13 +506,15 @@ static ssize_t anon_enabled_show(struct kobject *kobj,
 	const char *output;
 
 	if (test_bit(order, &huge_anon_orders_always))
-		output = "[always] inherit madvise never";
+		output = "[always] bpf inherit madvise never";
+	else if (test_bit(order, &huge_anon_orders_bpf))
+		output = "always [bpf] inherit madvise never";
 	else if (test_bit(order, &huge_anon_orders_inherit))
-		output = "always [inherit] madvise never";
+		output = "always bpf [inherit] madvise never";
 	else if (test_bit(order, &huge_anon_orders_madvise))
-		output = "always inherit [madvise] never";
+		output = "always bpf inherit [madvise] never";
 	else
-		output = "always inherit madvise [never]";
+		output = "always bpf inherit madvise [never]";
 
 	return sysfs_emit(buf, "%s\n", output);
 }
@@ -515,25 +528,36 @@ static ssize_t anon_enabled_store(struct kobject *kobj,
 
 	if (sysfs_streq(buf, "always")) {
 		spin_lock(&huge_anon_orders_lock);
+		clear_bit(order, &huge_anon_orders_bpf);
 		clear_bit(order, &huge_anon_orders_inherit);
 		clear_bit(order, &huge_anon_orders_madvise);
 		set_bit(order, &huge_anon_orders_always);
 		spin_unlock(&huge_anon_orders_lock);
+	} else if (sysfs_streq(buf, "bpf")) {
+		spin_lock(&huge_anon_orders_lock);
+		clear_bit(order, &huge_anon_orders_always);
+		clear_bit(order, &huge_anon_orders_inherit);
+		clear_bit(order, &huge_anon_orders_madvise);
+		set_bit(order, &huge_anon_orders_bpf);
+		spin_unlock(&huge_anon_orders_lock);
 	} else if (sysfs_streq(buf, "inherit")) {
 		spin_lock(&huge_anon_orders_lock);
 		clear_bit(order, &huge_anon_orders_always);
+		clear_bit(order, &huge_anon_orders_bpf);
 		clear_bit(order, &huge_anon_orders_madvise);
 		set_bit(order, &huge_anon_orders_inherit);
 		spin_unlock(&huge_anon_orders_lock);
 	} else if (sysfs_streq(buf, "madvise")) {
 		spin_lock(&huge_anon_orders_lock);
 		clear_bit(order, &huge_anon_orders_always);
+		clear_bit(order, &huge_anon_orders_bpf);
 		clear_bit(order, &huge_anon_orders_inherit);
 		set_bit(order, &huge_anon_orders_madvise);
 		spin_unlock(&huge_anon_orders_lock);
 	} else if (sysfs_streq(buf, "never")) {
 		spin_lock(&huge_anon_orders_lock);
 		clear_bit(order, &huge_anon_orders_always);
+		clear_bit(order, &huge_anon_orders_bpf);
 		clear_bit(order, &huge_anon_orders_inherit);
 		clear_bit(order, &huge_anon_orders_madvise);
 		spin_unlock(&huge_anon_orders_lock);
@@ -943,10 +967,22 @@ static int __init setup_transparent_hugepage(char *str)
 			&transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
 			  &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_REQ_BPF_FLAG,
+			&transparent_hugepage_flags);
+		ret = 1;
+	} else if (!strcmp(str, "bpf")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_FLAG,
+			  &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
+			  &transparent_hugepage_flags);
+		set_bit(TRANSPARENT_HUGEPAGE_REQ_BPF_FLAG,
+			&transparent_hugepage_flags);
 		ret = 1;
 	} else if (!strcmp(str, "madvise")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_FLAG,
 			  &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_REQ_BPF_FLAG,
+			&transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
 			&transparent_hugepage_flags);
 		ret = 1;
@@ -955,6 +991,8 @@ static int __init setup_transparent_hugepage(char *str)
 			  &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
 			  &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_REQ_BPF_FLAG,
+			&transparent_hugepage_flags);
 		ret = 1;
 	}
 out:
@@ -967,8 +1005,8 @@ __setup("transparent_hugepage=", setup_transparent_hugepage);
 static char str_dup[PAGE_SIZE] __initdata;
 static int __init setup_thp_anon(char *str)
 {
+	unsigned long always, bpf, inherit, madvise;
 	char *token, *range, *policy, *subtoken;
-	unsigned long always, inherit, madvise;
 	char *start_size, *end_size;
 	int start, end, nr;
 	char *p;
@@ -978,6 +1016,7 @@ static int __init setup_thp_anon(char *str)
 	strscpy(str_dup, str);
 
 	always = huge_anon_orders_always;
+	bpf = huge_anon_orders_bpf;
 	madvise = huge_anon_orders_madvise;
 	inherit = huge_anon_orders_inherit;
 	p = str_dup;
@@ -1019,18 +1058,27 @@ static int __init setup_thp_anon(char *str)
 				bitmap_set(&always, start, nr);
 				bitmap_clear(&inherit, start, nr);
 				bitmap_clear(&madvise, start, nr);
+				bitmap_clear(&bpf, start, nr);
+			} else if (!strcmp(policy, "bpf")) {
+				bitmap_set(&bpf, start, nr);
+				bitmap_clear(&inherit, start, nr);
+				bitmap_clear(&always, start, nr);
+				bitmap_clear(&madvise, start, nr);
 			} else if (!strcmp(policy, "madvise")) {
 				bitmap_set(&madvise, start, nr);
 				bitmap_clear(&inherit, start, nr);
 				bitmap_clear(&always, start, nr);
+				bitmap_clear(&bpf, start, nr);
 			} else if (!strcmp(policy, "inherit")) {
 				bitmap_set(&inherit, start, nr);
 				bitmap_clear(&madvise, start, nr);
 				bitmap_clear(&always, start, nr);
+				bitmap_clear(&bpf, start, nr);
 			} else if (!strcmp(policy, "never")) {
 				bitmap_clear(&inherit, start, nr);
 				bitmap_clear(&madvise, start, nr);
 				bitmap_clear(&always, start, nr);
+				bitmap_clear(&bpf, start, nr);
 			} else {
 				pr_err("invalid policy %s in thp_anon boot parameter\n", policy);
 				goto err;
@@ -1041,6 +1089,7 @@ static int __init setup_thp_anon(char *str)
 	huge_anon_orders_always = always;
 	huge_anon_orders_madvise = madvise;
 	huge_anon_orders_inherit = inherit;
+	huge_anon_orders_bpf = bpf;
 	anon_orders_configured = true;
 	return 1;
 
-- 
2.43.5


