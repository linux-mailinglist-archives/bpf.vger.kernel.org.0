Return-Path: <bpf+bounces-64661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A875FB152C2
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE753AE6C4
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0788724EAB1;
	Tue, 29 Jul 2025 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf0HnVZm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC01244675;
	Tue, 29 Jul 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813558; cv=none; b=rltY01ErlYaki2OSstEYds/CDQvY2xSuEjOqIaTQdaVhugPw1kXr31iwAq60g1fQhaaKEI1JMT6x8EBAa7slcKS6I8iJXyCahGMgaZgjDJO9R81H9lIGxx+wmAmPo3vbz6dVEg1g2fFdVF5UKVmDspbExbb3auAsDcgG0LDAVXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813558; c=relaxed/simple;
	bh=gMG9bzFlN3D3L0eUEXiiKcADhszly8/6rQ7m7BKl5iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJE+vx9yZHuZ0XPfROTlIxcDpPKG8TDlC1wIpaIVVKsT8l38O+NXy+rw+WAUrjLffCf2A1F1fwfHvth6yQczKBs9CuT+Nt8/BbgLWsfI/fnuLtQ79WXHHlfTV3WQsHHvry1gr7mlIFX43nvCIUjA74f0eMS4wqLByZWT4KNUwFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jf0HnVZm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23ffdea3575so21254125ad.2;
        Tue, 29 Jul 2025 11:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753813556; x=1754418356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eF2VfFVYk4NZFJtn4tt3ThE/i0TxJ+W9kmk26hfW9gI=;
        b=jf0HnVZm0JG8kCswjOkiP9cf+BcGelaYRYcAlN9d2eET8hr5EAFY3opfUs0/0baWMw
         mEXt+GlehO4fjBx5Oci2ec9P2r9/e0fG0f/91a8nWCy6Kn6p6wB5u6vqFyBZmOarGjVV
         Q2s6h937oF7NaPFWJpfWNOOULZSD3QaPQTuiVRUKPUPydeI4klGGumfoVCN+tKYw1K+2
         9xpGw0bKtu/v8acVZ7/qFgncm1+ohrXdvHiRC6ZpyKOgFhXBmPt9XgEUnhbDsJEKR50h
         e3QZbnjcRa+IZf3dpYnk0GBh6/PwPS7X8MJ1E67eUZHOXD67ivDZR5b/K1siqPzTYvlO
         ebvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753813556; x=1754418356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eF2VfFVYk4NZFJtn4tt3ThE/i0TxJ+W9kmk26hfW9gI=;
        b=TvIfyRgt9PTl/HPJmvU6Dt+nrMVph7RT2yjvgJAJIu9Kzl4+S+ZUoKRnw8UWtl8ah7
         jQ5fwFknZVrh+cPmRYYlpreRjHDu+hInp33vf1kOTZFZJ8SEOO+5Ivz8NwBjnKAk+109
         amb7GLHmWFhqotCpyd/qEd77O5x/5FF50jHgPcDAyfDJMUyzTDgWVMatnQoyoyoUoK04
         mjgt/a0OccgMED1AtG6EtFaFP1EXoLGSKifZikFBuKu4HvGB/U1Yvno5XULkPUmI+m8F
         QDV/C9xAbVKGkXpBs6o8NcPLPKNUY2BC9GupgtH09tsOQm8EYiwwkqmT2XTU4eHgb2wX
         VOtQ==
X-Gm-Message-State: AOJu0YwBFZdjdMyra+F17gxatLuICHGgCzb0IS26D2sfKtuaGIluTo/F
	XqUlJF0KFbHYYvoUHJog4nzlW12QoAu9a3fQ700TTSyxY+jbElxf7T5YTNECwQ==
X-Gm-Gg: ASbGncsw6kekFfSmuHdenDl8bc8Lxe8ahLBoerTk22T9qMaIs+Lr5QkSxGTQm/Bs+DY
	0Lb84L9RFs6vzkRyllxcLdMExqcsFsCmoPRdm4i7ZbYjEG0MO2r4GPOXFdu177CHR/7AA/nTDy9
	cnw7CFMtzFrs/qUEwCLy9NLTi2kKdDzJMGXWgCYI4IFItHQOxJDZHIRFZsRIGGtEyzpYUTyxoEA
	PxHCfVipkXl+XKPQbt5dNeaE8QcocBjax+SF6QC21CCZypa2Fhc2AEupVPGUBVefdRBj4EkVfFy
	nzEicZ3hSHZJG4UEJp0vJJKB9HDwKfFLqFrMOUTfqtaB6ft3zZk/yB8iFDMsLFN790nKF4SQQvb
	B0xFx2YiiqP/JpA==
X-Google-Smtp-Source: AGHT+IGevc4ixl6Eml7kNP4jaUUWJXAMWo06Xe92reUEVJ20lnTFrcwvSSEM/4C26hFFNNqPOLeaAA==
X-Received: by 2002:a17:903:32cd:b0:240:7753:3c07 with SMTP id d9443c01a7336-24096b0548fmr4291385ad.33.1753813556104;
        Tue, 29 Jul 2025 11:25:56 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b421635cb85sm568422a12.38.2025.07.29.11.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:25:55 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v1 04/11] bpf: Convert bpf_selem_unlink to failable
Date: Tue, 29 Jul 2025 11:25:42 -0700
Message-ID: <20250729182550.185356-5-ameryhung@gmail.com>
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

To prepare changing both bpf_local_storage_map_bucket::lock and
bpf_local_storage::lock to rqspinlock, convert bpf_selem_unlink() to
failable. It still always succeeds and returns 0 until the change
happen. No functional change.

For bpf_local_storage_map_free(), since it cannot run recursively,
and the local_storage->lock is always acquired before b->lock,
assert that the lock acquisition always succeeds.

__must_check is added to the function declaration locally to make sure
all the callers are accounted for during the conversion.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h | 2 +-
 kernel/bpf/bpf_cgrp_storage.c     | 3 +--
 kernel/bpf/bpf_inode_storage.c    | 4 +---
 kernel/bpf/bpf_local_storage.c    | 6 ++++--
 kernel/bpf/bpf_task_storage.c     | 4 +---
 net/core/bpf_sk_storage.c         | 4 +---
 6 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index dc56fa459ac9..26b7f53dad33 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -180,7 +180,7 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem);
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
 int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 		       struct bpf_local_storage_elem *selem);
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 148da8f7ff36..68a2ad1fc3d4 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -120,8 +120,7 @@ static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 15a3eb9b02d9..e55c3e0f5bb9 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -112,9 +112,7 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 7501227c8974..dda106f76491 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -426,7 +426,7 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map *smap,
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 }
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 {
 	struct bpf_local_storage_map *storage_smap;
 	struct bpf_local_storage *local_storage = NULL;
@@ -473,6 +473,8 @@ void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 
 	if (free_local_storage)
 		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, reuse_now);
+
+	return 0;
 }
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
@@ -937,7 +939,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 				struct bpf_local_storage_elem, map_node))) {
 			if (busy_counter)
 				this_cpu_inc(*busy_counter);
-			bpf_selem_unlink(selem, true);
+			WARN_ON(bpf_selem_unlink(selem, true));
 			if (busy_counter)
 				this_cpu_dec(*busy_counter);
 			cond_resched_rcu();
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 1109475953c0..c0199baba9a7 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -169,9 +169,7 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map,
 	if (!nobusy)
 		return -EBUSY;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index fac5cf385785..7b3d44667cee 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -40,9 +40,7 @@ static int bpf_sk_storage_del(struct sock *sk, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
-- 
2.47.3


