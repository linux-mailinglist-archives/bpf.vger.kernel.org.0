Return-Path: <bpf+bounces-70251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB5DBB5913
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 00:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED99A19C73B3
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 22:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E1D2BEC2A;
	Thu,  2 Oct 2025 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEY+hhPK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991C8298994
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445644; cv=none; b=u+sWVT5pdELtVEKvta4YUttmTuDr9MmcvY/joKsPTSB2kGKbR357BONAtjrQmR68RYVJrWpJtWJyHB9SOHHrWWghIInhXckkIRXUbTDcl678v/rB6mBIwT42XyBDNbcX7zLLbQW19R9gWlbOUmzKj03tyMtCUF67B7Mv5nSHC+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445644; c=relaxed/simple;
	bh=rMGQ++fqJXrN6F6DS1T6vb3M4SFLCrCiAGAbwNGBLKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ho1tKtUiP+GhquGiCcf3u8SIrxW0l5EyOuvt9xojepKTsgLiKKHNJ1O2sZJfXoV4hTx7fMCQqM9a/hbn0S8YU8X03JJFfnhnURXffDkk5El1IAEgXk3hQ1Coe3in+ukZ+A3Gf+0vmZRAnp5+lDNo1Ev9oJ1BCXgNC+WmSeTiUsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEY+hhPK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26e68904f0eso16518335ad.0
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445642; x=1760050442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGP7XQKpjbVBHUUnliMlOJ3FrYuoHPcehkOp1EL/9cI=;
        b=DEY+hhPKxzIYdHzzbNtpwYzhXUFiGf69JU4TJeNTSLldEIwAk32mYg3iBEQCdhi5Tr
         /9Hj8YzrLuaupeWy19UYcAGEG+Vm3Qu/CwUp+OZIqJm4yi7vdzsihEUUNHvxcqlK4emA
         mYdrOa4Dm/BVOnycFG984gKQfENpDf299Z5s4L+aM656YuFoGoRHyIB7NKPtTz3adi0h
         wxnsecHEiO6d4BHqv7/wZ1l/Lpux6lKGw5Df59XZVcZeouFQvQ9+uL2qNiaf3nSE4EDB
         44O6fCDFIyH8rNudQX0wiVX6ihbIKe10jjRQguH6cF/U677+w+BmBwNt48LaT4HWe1a0
         j0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445642; x=1760050442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGP7XQKpjbVBHUUnliMlOJ3FrYuoHPcehkOp1EL/9cI=;
        b=Znp5lNhezL/ivUCwjkUa8H54Kwg42xcJRtN93tbsh9rvM/yvW6u6DEPWn+CdMGkUJf
         GXMVBlJnVWbKVT4vAcvNEaWWd42eCkbS146txYoWqZemUqrnCHJo1ZAub/QywohD0v6G
         IHoLWaTpPCujpjmlupNYDKrHFbxT7vvNenHlHhlZuMnrYmFQPmZ5f50AfIGrXKr0EL9T
         DnXiJbymxB2bOLBl6shxj0iXUsgq+wOxraGyjzXupTQrYPWKZ9q8MIOTDqXBM46QC6QV
         DadBKowDDC95rb1UQOCk3uJkT9ycncYcHbXRiirsbUFSds+lJ2fdkydTCrwQmTb8m+9T
         9XVA==
X-Gm-Message-State: AOJu0Yx4B/Y94hiDsbFYjQDUM70ALN2Nt64DJnRRPLBuCZRxiObIgX5c
	Y2Grr+HgKh1yTVdm0HKg0vCO/9eecAkkXV7jjLsJUfxHCtXH4J5E1yC56Rz11g==
X-Gm-Gg: ASbGnctuI/XNFrmSKInT8vlvwUqgQ8u3RcCAQE8xyGBoLGVoX3v+ELdF2r397VTEhIF
	DWebCNFA8hnkEKD3sf9xYqofOTs11Xo4792QMpZrwwiuKP5BSqFcahj/TTPYnscfJ7+Xk8lit0Z
	EAB7xh5fNSXer8n+ZJ0KAWRZxQ1CGgE/C5SGNR6J0u1/nJJCBcfCGDGU/0z1dEqOhpw5UwW3QJV
	bpfgsQ/0tL+rlJIXpWgaNOcjG506mbg3ircMG2MfkTXaQy7TE/IETUVoKjpAZG5XpA6b+f6NZI5
	h7lyo2nZcOfUai9PAJK473xsmRw2ZJU7f15YXeCBLdqoByiWwilZAGrGmdeBhmcCsPLaKkNO9pX
	u1K1AKjrwHsK6UugbQSYY4GtIao9dcRPDOlUV
X-Google-Smtp-Source: AGHT+IEVV/drYL7Gp88PHqD++18OMU6Z6umBxFyXQa/CQ28s2zofDauhblZTf79D86avnwbPCOcwCg==
X-Received: by 2002:a17:902:ccc8:b0:28e:80bc:46b4 with SMTP id d9443c01a7336-28e9a664f0dmr9480685ad.55.1759445641833;
        Thu, 02 Oct 2025 15:54:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b844fsm30695335ad.69.2025.10.02.15.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:54:01 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v2 05/12] bpf: Convert bpf_selem_unlink to failable
Date: Thu,  2 Oct 2025 15:53:44 -0700
Message-ID: <20251002225356.1505480-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002225356.1505480-1-ameryhung@gmail.com>
References: <20251002225356.1505480-1-ameryhung@gmail.com>
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
happens. No functional change.

For bpf_local_storage_map_free(), since it cannot deadlock with itself
or bpf_local_storage_destroy who the function might be racing with,
retry if bpf_selem_unlink() fails due to rqspinlock returning errors.

__must_check is added to the function declaration locally to make sure
all callers are accounted for during the conversion.

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
index 0687a760974a..8fef24fcac68 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -118,8 +118,7 @@ static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index e54cce2b9175..cedc99184dad 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -110,9 +110,7 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 9c2b041ae9ca..e0e405060e3c 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -433,7 +433,7 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map *smap,
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 }
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 {
 	struct bpf_local_storage_map *storage_smap;
 	struct bpf_local_storage *local_storage;
@@ -472,6 +472,8 @@ void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 
 	if (free_local_storage)
 		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, reuse_now);
+
+	return 0;
 }
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
@@ -930,7 +932,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 				struct bpf_local_storage_elem, map_node))) {
 			if (busy_counter)
 				this_cpu_inc(*busy_counter);
-			bpf_selem_unlink(selem, true);
+			while (bpf_selem_unlink(selem, true));
 			if (busy_counter)
 				this_cpu_dec(*busy_counter);
 			cond_resched_rcu();
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index a1dc1bf0848a..ab902364ac23 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -167,9 +167,7 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map,
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


