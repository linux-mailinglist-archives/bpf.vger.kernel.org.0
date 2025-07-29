Return-Path: <bpf+bounces-64668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6DBB152D3
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1C718A6032
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F8D29A31D;
	Tue, 29 Jul 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNoW/1iN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A10299AAC;
	Tue, 29 Jul 2025 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813567; cv=none; b=LyeApQ1Eus1+ofPXG0X84aW3FOliGSFGxCNEe2yHUhBHaVmr/onG0/0IMJlKLMq3VSz3IocmAgltXRJzJtZZIkPAxxlBSjmCFGt6UwKNgK/CziHTBLXGO4N8pfsVZkhNN6hdBSYtvPfQeq9hwvgkM0DxPK+Ea2+rBAjub1SmYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813567; c=relaxed/simple;
	bh=oJFTBRwuhuZau7h5VFI8lJaPArX0/LL3CqCrMX1M78k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txLrbsUmmCE6U8TdEJlOjcPvVGwqRDaakoBgUkVLODDMJmnUYgCLqpJ2wjkyHWFlo9FvgkNcvpf2A2jQbFuKm8x5O6ITSMY5Ze9YAm7I7AmeVw0p0EudqDixmTmWJkbqk2IFNK1oX1lK7niofs6swUNBO8cpZE3eWuWse5JOyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNoW/1iN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2401248e4aaso32069235ad.0;
        Tue, 29 Jul 2025 11:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753813565; x=1754418365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivj1zd8e6yzH07xgwifWR5NFJhgZ5Ed8O1gRGDMacA0=;
        b=iNoW/1iNG8P3WSkFW4WQu1v7JK/LgBl1Sef4Je7aAlZK3Aiik8F+gQG45GL4KLlk8I
         +xkrzRX06rgu8laUdA1ZndjXROBsspl8bPBM/Afq8+GSZ1hDkH3B4NIVH8KSKkpDV6GB
         /QlOac3SUBwp1L1/1HkUGlGElzi5IgoO5JmNDtBME/qL8R2VwZywpegX1gNLPEkwsMu9
         wu3ooHsXKLMSrfmgoVF9kVmD4yxcsEWggyJqgZwVPPYWVR1n9HGx5xrhl/FoQIwPwog+
         YOciARS/yTOpDgwRyqJxnBgwyhBjsnMwk/w9nkp/JfnEOMp7/HgfJca5UOdtSXE6kHOR
         EGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753813565; x=1754418365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivj1zd8e6yzH07xgwifWR5NFJhgZ5Ed8O1gRGDMacA0=;
        b=F8zrWT1VgPPLcly6eOkFu479stneaMy5ZAR23qTbYHeJGQruID/sGxUIraIM9GpTTT
         cYdhATK7P9JR+B4B1/btYTeULOI940zOklDdAWUOM2HZyacDo/iTUzJzb/DwBUNJPp1Q
         eJhEuNMb1DW6+otyMQD1N2/jwNLnf7OWz7KeXV6R2aTo8ndo5FROn3f4gTTXvIvy9M4+
         oMYLZmAgbzeOPV0u/D64ZYXQM7a3gHwWfZdA0ePsFDruNCofQCh/s/5CxQ6hvjYbdA+N
         Gr6BOC1oaA7azfSN28IgjU0AWUx2JaKFJUjgvOjwWn+CswoncHTXMV4xFq1q7Nf4Nd6A
         GB+Q==
X-Gm-Message-State: AOJu0Yx1r4uafx2njWyqX/XAhYoWRgb1yOmgJ7zN939Lwe06NlpkVerp
	6jyr37VGbRXUkFVDKvkIszBDIuz6Mfgw5TeRyOjuOCWYR4rtKLYTmOBQ05I6mQ==
X-Gm-Gg: ASbGnctcDII0dh21iVof5eCbqHN+yIrHLAdLdXuNsoVO8wpjzp6fLYoFgeNRev25n7f
	WY/ZSrSLpYgEdotGFV0t/sY9b4gn9nYwRAcoh2lYqBIrdFMPF0AZBFGlCemAkaPNIYuPgDfofl1
	3zJYcStLJy8FNMjKjWVoNAZiQ3Lzke3LNORepUyjkFczdhUzUnoYINzpjNjLmAoqPyybvzAAN+v
	QytTkZ0qlsoMXuDvl5PMQt6B3x8YlxTc12exX/Ng4ag2g1o3SxLt9d26hoH3jd/Ov9r2NVtrb98
	WIpMeQeoe5/CU+TiQ3GeFCcgqMSmgasB3vG11jGOONPxXyhljpCpmb+uE3W1rgFqMMVKTLEm+0S
	sBk+xAkx7tLXImg==
X-Google-Smtp-Source: AGHT+IFp4+Jd2Y88x2xmFk3GriZhCRf1tSEI8bwhEIERQAQ0vlIwuFd2MKGSbTv17eONcF4mXlKc+g==
X-Received: by 2002:a17:902:ebd2:b0:210:f706:dc4b with SMTP id d9443c01a7336-24096a68530mr4970915ad.13.1753813560036;
        Tue, 29 Jul 2025 11:26:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2406b081ddesm24510825ad.148.2025.07.29.11.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:25:59 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	kpsingh@kernel.org,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 08/11] bpf: Remove unused percpu counter from bpf_local_storage_map_free
Date: Tue, 29 Jul 2025 11:25:46 -0700
Message-ID: <20250729182550.185356-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250729182550.185356-1-ameryhung@gmail.com>
References: <20250729182550.185356-1-ameryhung@gmail.com>
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
index 2a0aae5168fa..5888e012dfe3 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -170,8 +170,7 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter);
+				struct bpf_local_storage_cache *cache);
 
 int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 				    const struct btf *btf,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 4f9cfa032870..a57abb2956d5 100644
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
index e55c3e0f5bb9..46985acff0dd 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -186,7 +186,7 @@ static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 
 static void inode_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &inode_cache, NULL);
+	bpf_local_storage_map_free(map, &inode_cache);
 }
 
 const struct bpf_map_ops inode_storage_map_ops = {
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 5faa1df4fc50..94d7e7f88572 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -935,8 +935,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 }
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter)
+				struct bpf_local_storage_cache *cache)
 {
 	struct bpf_local_storage_map_bucket *b;
 	struct bpf_local_storage_elem *selem;
@@ -969,11 +968,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
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
index ff1e2e4cc5b5..b9d8c029c0e5 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -218,7 +218,7 @@ static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 
 static void task_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &task_cache, NULL);
+	bpf_local_storage_map_free(map, &task_cache);
 }
 
 BTF_ID_LIST_GLOBAL_SINGLE(bpf_local_storage_map_btf_id, struct, bpf_local_storage_map)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 7b3d44667cee..7037b841cf11 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -62,7 +62,7 @@ void bpf_sk_storage_free(struct sock *sk)
 
 static void bpf_sk_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &sk_cache, NULL);
+	bpf_local_storage_map_free(map, &sk_cache);
 }
 
 static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
-- 
2.47.3


