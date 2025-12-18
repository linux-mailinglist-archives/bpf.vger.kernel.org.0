Return-Path: <bpf+bounces-77016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 901E0CCD0D0
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 18:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57AE3304381E
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F03730C370;
	Thu, 18 Dec 2025 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJH1Oxod"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D450307AD8
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080603; cv=none; b=Vi1IShXBhMZY1V4jivHQ3S5j7ZOhKo/ABi2Bfx8AL0w7oe5v7jbvHzF3fSHMcoIjiNf+/9CB043gvkEEyFWevZ3RgFfi5LZrlyWJtjtmJ0r/iR9JWfRy1v+c8140EOwdzvcgKxM1kleXU5A9oKgAXBbqvzcV2kN5lpmboS7Vo58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080603; c=relaxed/simple;
	bh=IRLkSHPx/ZVLhxPQIXqmSYDZhArMOD7HSo1URz4HlR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5B4ktELmEEWYc4SM30BVfUQzMp1bSJjyL2yHZ9pQx/OLCCvFqb/m7sBb+wzmkPZsUxTPisDsFOYhFZRodcMIUv9FClKOWO+FgzBtGSVflIfpozlA4kRbaX2Wco9icmMNI6UbTQri3H9L8dvnS0krdeX3A/u6NaNmIdV63sgS9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJH1Oxod; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34ca40c1213so796340a91.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080600; x=1766685400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0B43kzJDbhnDgRREv8aqfEZEGbm7QkUNHj2hERWWZhQ=;
        b=SJH1OxodkiQYDRfZF6xikUXC9EMCG8V2eOLBzFmJAuPJUZEdkzxiY7M9wuDOmW4def
         E2BFkyW3EbsLuIoq3Yvug6caUI0vk2Dkuix9LC4igz7AuSVAKKvQuX6zamMf3Fe1zgLD
         DYCdqvlhmoWrjNPTlvsMsCcdqezzlGDVnZ4a/mO1juNMomfs9xEQ8/dqMP810hSceZOT
         nL9uHSagz/B6wtxzvTuYb26YgHezwFHgWsmE8B3s+ft37a25sFlZMIEYszVEhLwkzRlq
         2uFEPbHyPC1uf47g3E/wa5fi7P+xFxvHj4yc+GmNMztRZk1IRSNfbX/Vpiiy4z1NN+3/
         +qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080600; x=1766685400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0B43kzJDbhnDgRREv8aqfEZEGbm7QkUNHj2hERWWZhQ=;
        b=vFaQkp5AkLy/I9y73DPJCXLBDwyoQrLgMeTDgaPYHoJbR6v+mBtCjMw2vwLLIi1TtQ
         yANZ+IUuX1M+hiKLyayLWjEnbkh41uT/M6dRnEB7F4gjOriQiXySpkgclwkrAT6rfU1P
         k6CICV01l6pjShUiwwiRRAGfD6Zqe1S1DK/PYkyUOBpDzuf6ycD/+DpuypwYRV86nPd/
         N97XS9iezY9GyWto4Wx75EvUEVyN9s0nUoYtxNZiWZbpMi8KLtvaFDfSy2hTV2r8W+S3
         9vMqs+h4daPZ6KLeoChEhtSJ37Hlh/RE6/X7i9McswgxFPY6Xn+BVUczehIo+pgCx5y6
         1WmA==
X-Gm-Message-State: AOJu0Yz0UiKBlV0P+rVKDM/WPy4XpSm77IXuZ+gjtiSeDe3HvhrYzLJ0
	MXlmvltt9ZnJeCBmbgigN/KtdSahU7+uzQYKFz1r3Qowk19+TFrRHiLQUeAWxA==
X-Gm-Gg: AY/fxX5IxxPzpalm7INUseGUOJo7zKvp7Z8S0gNFTOV83rwDpme2VocAiFKRl9p2ErQ
	ceLl16Ddvu+Fb26kB4LjRkpmercFkzjAwJnjquda2D93/4TmrVBNHUrzg9slTo/BKu1b1SMUDmT
	snN+jGJh5Zpl6B0e8nkPrggBXAxVhBRvo0cWXicoYLgWb0RoVb0fFwei+txcNdHjnSmBwfjV96q
	AgkysLQg5yqf61DOlT3kJY5VImOs4NiowtysJDBcT0C+z/3OsVl3riQgtVXu3h82mQNp8cnDJlS
	hIPyGojm/2eMb7MlstA14sRMPLXJNIExxaf7H/xDRSvFFko91gq7IXS10GxCwlBvjQATlqj6KfG
	5a1xKLBw6BXtwTM18O9v5R+1LoP+nBJtG5toVWg2svkfB91hZM4/QN0QGq1GameKU1v0xyxHXt5
	lF2XktXlfTfTCEUg==
X-Google-Smtp-Source: AGHT+IFRrGJg75XYHlG6wI0zUheMqBbBJbPlwWRy6DGqXEb/3S1wOzkmbL2R3raKDPk0lvRrc1W9OQ==
X-Received: by 2002:a17:90b:5107:b0:34d:1d54:8bcf with SMTP id 98e67ed59e1d1-34e92142ab1mr164616a91.9.1766080600179;
        Thu, 18 Dec 2025 09:56:40 -0800 (PST)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac1acsm965587a91.9.2025.12.18.09.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:39 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 08/16] bpf: Remove unused percpu counter from bpf_local_storage_map_free
Date: Thu, 18 Dec 2025 09:56:18 -0800
Message-ID: <20251218175628.1460321-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218175628.1460321-1-ameryhung@gmail.com>
References: <20251218175628.1460321-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Percpu locks have been removed from cgroup and task local storage. Now
that all local storage no longer use percpu variables as locks preventing
recursion, there is no need to pass them to bpf_local_storage_map_free().
Remove the argument from the function.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h | 3 +--
 kernel/bpf/bpf_cgrp_storage.c     | 2 +-
 kernel/bpf/bpf_inode_storage.c    | 2 +-
 kernel/bpf/bpf_local_storage.c    | 7 +------
 kernel/bpf/bpf_task_storage.c     | 2 +-
 net/core/bpf_sk_storage.c         | 2 +-
 6 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 903559e2ca91..70b35dfc01c9 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -166,8 +166,7 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter);
+				struct bpf_local_storage_cache *cache);
 
 int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 				    const struct btf *btf,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 4d84611d8222..853183eead2c 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -119,7 +119,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 
 static void cgroup_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &cgroup_cache, NULL);
+	bpf_local_storage_map_free(map, &cgroup_cache);
 }
 
 /* *gfp_flags* is a hidden argument provided by the verifier */
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index cedc99184dad..470f4b02c79e 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -184,7 +184,7 @@ static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 
 static void inode_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &inode_cache, NULL);
+	bpf_local_storage_map_free(map, &inode_cache);
 }
 
 const struct bpf_map_ops inode_storage_map_ops = {
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 1d21ec11c80e..667b468652d1 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -827,8 +827,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 }
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter)
+				struct bpf_local_storage_cache *cache)
 {
 	struct bpf_local_storage_map_bucket *b;
 	struct bpf_local_storage_elem *selem;
@@ -861,11 +860,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 		while ((selem = hlist_entry_safe(
 				rcu_dereference_raw(hlist_first_rcu(&b->list)),
 				struct bpf_local_storage_elem, map_node))) {
-			if (busy_counter)
-				this_cpu_inc(*busy_counter);
 			WARN_ON(bpf_selem_unlink(selem, true));
-			if (busy_counter)
-				this_cpu_dec(*busy_counter);
 			cond_resched_rcu();
 		}
 		rcu_read_unlock();
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index dd858226ada2..4d53aebe6784 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -217,7 +217,7 @@ static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 
 static void task_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &task_cache, NULL);
+	bpf_local_storage_map_free(map, &task_cache);
 }
 
 BTF_ID_LIST_GLOBAL_SINGLE(bpf_local_storage_map_btf_id, struct, bpf_local_storage_map)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index fb1f041352a5..38acbecb8ef7 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -60,7 +60,7 @@ void bpf_sk_storage_free(struct sock *sk)
 
 static void bpf_sk_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &sk_cache, NULL);
+	bpf_local_storage_map_free(map, &sk_cache);
 }
 
 static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
-- 
2.47.3


