Return-Path: <bpf+bounces-77012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FD2CCD0C7
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 18:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A4AE30269AB
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12A83009D9;
	Thu, 18 Dec 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwWzw13Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194402EB866
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080598; cv=none; b=t0sKJOICOFsu1yMy4Uz9qZ2R6u+5buDocbjxqGSx7cF9f49hAhfsP54NxvTOTawCwEmIoWUtGAO1FiaFXUcuNSzLQ7ocSX+do2CovOcxDpArMjqgHRhXb+ENsz5iqXLX6dC2bqbz05pkdRcuNNXDrDUIQhYCGp/xnSXO6FHjI0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080598; c=relaxed/simple;
	bh=RH6QJtjpBbRJgr1NyDX6KIkQDP/JzelKkHvxw7UqTlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PF/KU0QSk8+HIdZvnpmlWwcUPss8N4DnPLsXcWfs0F4TcYvmVA1Qx8xlaU6Q5ssv/TMLLtXwXzbGcpYZGoJaGXiWmhYXaq/rJfNMjcCETJ9bK705onC2b6GS1CrUJ7hLE1GDR9VDYMF73c0FJN7J25OSX7exUiAZCCxIwNxVqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwWzw13Z; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso602784b3a.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080595; x=1766685395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRezNWUjQCQRgeNjywR+d0yNBFLc5c1Q2auBSE31jRs=;
        b=LwWzw13ZUySmFqcKGsbxbLPpCN8ZiGoDxRju7QNO9f5KBcNqVTI8EDoHQqayg7kzw4
         StLp6AJCC8mNFZSRhNGFQUwIBNwvl/14uQaXYPr87cRZYhc8sdpIMt0Fe+EBNvwnAmhP
         8C5E9oFIuqxm3CZG2bSVw2xIEgmMaryKRWvQAHjt4i4Z+lUgKs9ZlAXJjHPcFg35Dp5W
         +Vfg1KWY3+5/FWO7wy3gsCjKUN7qTbzCCEcGQ8ODOmXO5o9uGGUx09Rky8bvAhW7j/2q
         ugpCcn+gMZT545di8QsEkrI1h0lXIZlvRBMroJpGx6GqFM1v9Tcejn89UJQCM9P2omCk
         FbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080595; x=1766685395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zRezNWUjQCQRgeNjywR+d0yNBFLc5c1Q2auBSE31jRs=;
        b=oqdpaDuYVRRWoug9TcV8oXqnELLOv7AK2iISxK1U2vgN1aE2lkzwlXRu7K8qVVg/iB
         1I4vRwcmQLib/IIiSC/y9/di8fDdusX02qkuoufkaBBjj6LXwGMeTqDPcsZjgyU6Ch6H
         KWa0gDmFKzeCk6LaLrtUmuLIpm9/Kjszuil5WQCxLOQIZ4OlErXzC+yk0xS+BDR4R3V7
         SIJFUB2Lz3AMTQJ+gsphoiIpLYQEYWo3IOlUutMy+Ti12NUI1SBly37/+WzZcthHkjMX
         GjU19aj0q4XLLNaVmjbU68PXm+BPH6auuk2GxloithhST+htq/GNzmHfLPuruPMEsZLa
         Zxgw==
X-Gm-Message-State: AOJu0YyGJJiMPUbhUwOIJ8lXNDO0Juv6W/q0nbUpkb4Hns0M6gEhcQLf
	s0UBd26QizyYTk6Ee2XgaaL8fXs+EssxC66RqeHpu9+UfBvUKaf3eiQXANKMNw==
X-Gm-Gg: AY/fxX654bZL7SGBmy3cwKblsOGAPC6VyAW/Te37ZHsdBQQ8ZcrbNPPrh96S0RA2x1+
	RUWT/Esa8BxJtFeTe3pYiOxsIQY3nqn0UoHt7CtM8IiQN4dhGD9wpMy6qCRuM+YobSjn0XT3fkV
	GxTMCBTI4oAn9vtevoT65YhZWbBxP/gsF4nucntt3Hsnynhgdb8IW4qM9g4yEpR0QmNPL2UlWu3
	iQZm6Kjz1L6OKi28yap1QHpuYu+Fn4wjLox/4VdUW7yZa1VrD0FokQ/O7TQtQcXdwBLCimdxeEc
	KLwTizS4umurvVWSrj+VjbvojIUaHlmYuZzFJ1INri1DpmkRzb/wkv2RlfVFJlEePTYrQ/zQyE/
	8v1edXh25EdsVI3v/KqVuRIUntceRI7B2OozDWvZY3cwsL0RwXLpXNtps718ng/R3aAFqHuEIHc
	Si1z0PvUcxlBs6Pw==
X-Google-Smtp-Source: AGHT+IEP62anIr8TtiMmm/XhYK6iXaR+61rLrp1ZHQBc/u+GL+SMg3nteTCOZnSs6Lu1CCV9xfpOvQ==
X-Received: by 2002:a05:6a00:451c:b0:7e8:3fcb:bc46 with SMTP id d2e1a72fcca58-7ff54c01878mr463684b3a.27.1766080595221;
        Thu, 18 Dec 2025 09:56:35 -0800 (PST)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe14365443sm3226758b3a.50.2025.12.18.09.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:34 -0800 (PST)
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
Subject: [PATCH bpf-next v3 04/16] bpf: Convert bpf_selem_unlink to failable
Date: Thu, 18 Dec 2025 09:56:14 -0800
Message-ID: <20251218175628.1460321-5-ameryhung@gmail.com>
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

To prepare changing both bpf_local_storage_map_bucket::lock and
bpf_local_storage::lock to rqspinlock, convert bpf_selem_unlink() to
failable. It still always succeeds and returns 0 until the change
happens. No functional change.

For bpf_local_storage_map_free(), WARN_ON() for now as no real error
will happen until we switch to rqspinlock.

__must_check is added to the function declaration locally to make sure
all callers are accounted for during the conversion.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h | 2 +-
 kernel/bpf/bpf_cgrp_storage.c     | 3 +--
 kernel/bpf/bpf_inode_storage.c    | 4 +---
 kernel/bpf/bpf_local_storage.c    | 8 +++++---
 kernel/bpf/bpf_task_storage.c     | 4 +---
 net/core/bpf_sk_storage.c         | 4 +---
 6 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 6cabf5154cf6..a94e12ddd83d 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -176,7 +176,7 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
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
index 0e3fa5fbaaf3..fa629a180e9e 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -367,7 +367,7 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map *smap,
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 }
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 {
 	struct bpf_local_storage *local_storage;
 	bool free_local_storage = false;
@@ -377,7 +377,7 @@ void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 
 	if (unlikely(!selem_linked_to_storage_lockless(selem)))
 		/* selem has already been unlinked from sk */
-		return;
+		return 0;
 
 	local_storage = rcu_dereference_check(selem->local_storage,
 					      bpf_rcu_lock_held());
@@ -402,6 +402,8 @@ void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 
 	if (free_local_storage)
 		bpf_local_storage_free(local_storage, reuse_now);
+
+	return err;
 }
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
@@ -837,7 +839,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 				struct bpf_local_storage_elem, map_node))) {
 			if (busy_counter)
 				this_cpu_inc(*busy_counter);
-			bpf_selem_unlink(selem, true);
+			WARN_ON(bpf_selem_unlink(selem, true));
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
index 4f8e917f49d9..fb1f041352a5 100644
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


