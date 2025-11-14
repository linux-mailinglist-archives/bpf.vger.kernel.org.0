Return-Path: <bpf+bounces-74557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 07405C5F33A
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA3F935EF62
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 20:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB3D34C989;
	Fri, 14 Nov 2025 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2JBsrvs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED934A766
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151216; cv=none; b=pbyrAnieO36Y3oSFIVPfsBRpfpHhS1lHUbIGF3EfVdLrWwvx/PchAOX2HO76K/qulDQXCh23JTplyMPrTc5LTeWyMsP0eWYeujxv4o9Jsgft7+I+ItstD0p1ZRoGQJA/w61z5d4vE67SqCh7cU2vu7a/BGJ1yxcDSrATuv+aego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151216; c=relaxed/simple;
	bh=qxaqs/iHMtjSFLXzbvynbiO4p10lyVNAQ3dq508g82c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTg6u1+6rU+MCvA4POD6PvOsWQ40qmqEzCP//2urKq+OYFVfAAIiucp8FLn6b+v3cxk93jJ21hd2+YPMl3NIYGMB2ArMrIdclmgOF2mDlC/Ugu8lPHxiZtNdTJMDGFlGi8zqkAb4hHSje2hr1KEpcA7c8BlpHikfxOVE4Q2+Le0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2JBsrvs; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso2137043b3a.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 12:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763151213; x=1763756013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/srIL6wsUiH+p+LHKTc3uVln8o0XANiw4LU9A0/vSg=;
        b=M2JBsrvsYLIIK8pblD7FbvSBR2BD9w9iJBDqwYU+clfa0eO7FAujXK4AmAR91boaSb
         qj9TZA+TtJQLc9MlefrPW1gOuNDLtyi1CWaD7fspE7nHroUQa/TDPX4s5y6CR/GBauYA
         Kybeamvt2fF6ybBiXpfFntde+JfpSM7zBS7m5jFHImTJUcYCgYbFud4MytjxNzeBfsz+
         rnOtHOJ5myHC2FVv008Ne6kEdtin6cMJJM4WbtE0wOz3YSegmDLW50FU8Rm4UDUJlyym
         eooL4PWjvps3sU3iHoD04gq13LRYQK7IoSn9O6Ue0Qawv4gO9BalRwpZ7v5iLi1NF8un
         YNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763151213; x=1763756013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G/srIL6wsUiH+p+LHKTc3uVln8o0XANiw4LU9A0/vSg=;
        b=vNI1zkWaucM1G+JDapKNHZjNVv/4c7YsXwc0qUlDcdzAHpuXJYL1kMJY7yKbqye4UC
         uGufYORIbY6gBTGxOLzzpgqFDXZbbavBoNyba5oTa5WMzYrub1qpOGt7xj/zUEhMKkt1
         MWiG/LIRu2G2aMzF9K+wPuM3wHX8edkpBGUhS8XEb8GhABDcqQhiTp5uGcXsofyy+b2u
         2QnOyfLQXvS2MJ4WGRbCczRc+O01FCft7XIes958NHN/eLjEV2OLQBkFh7/nR5qlJ6PB
         3rlMlSBj7DEeE6oeymfsio05m/6/3Nikbc/LmcIVynCIY9TtrHjdb6NR2HgjiINRAWwp
         JDuQ==
X-Gm-Message-State: AOJu0Yz31ptezUPPN7RJMs7kP9HeL/vy22fazHi/O7G5tze9ZnU0yVFD
	FU98h5WVhUQgMQ4vSIQwxZsyrYXQu97xy0r0Ffzifz5lZ40Uem/7M9KkpKcGjw==
X-Gm-Gg: ASbGncssIJzQ3NryoazrNkLJ4kkTT+x1xKl3O/vmUT2A/tXj+ftv8yOohRDNgvBXLOs
	4nZOwFGmZYl5Oe5McVjN4x5VehLS0IfFW5AKw/Cbb7gVjJCPvVMX6uQpvmKatLRu5oH04fnhtWx
	7Cnf/4wVseY77RuVHjAZjZRRhk1q7nqHkYz7ruyKN7T5Blaef4HHYf+MbXhdL0Few4WhZKDE1zh
	OJPaqhsJV6aEZPONO3PZ3EzivaQEFni9Oz9pCMFwfNtDZOc+WdTXs+wpoUkzJO5M8aFczUwtF4M
	vaX4LfIwCo4Ze9Cx4/HYgg45D9FrIJ+I0V2nUOVz0AtkN0PViI1BDbQApYu+YwFFodXsR/UICNn
	ICmqM3uGKiISOqihn9DAKwbp1E5veVzkc7NjESAJN1LtgI2gKhrGFBOGJQyv9kw77LzJwN7eiQT
	R100fsTIGhL0bZ0g==
X-Google-Smtp-Source: AGHT+IGQmLvOtfJEAr5l97yVW0sUzsdZCxlMChhKZEw1KStpBXYw72cOPGvaz4DNSvo0/JXFn/4G/A==
X-Received: by 2002:a05:6a20:4315:b0:34e:a1b2:a33d with SMTP id adf61e73a8af0-35ba2985051mr5708667637.55.1763151213291;
        Fri, 14 Nov 2025 12:13:33 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc375fe47a0sm5474140a12.29.2025.11.14.12.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 12:13:32 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	memxor@gmail.com,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 3/4] bpf: Save memory alloction info in bpf_local_storage
Date: Fri, 14 Nov 2025 12:13:25 -0800
Message-ID: <20251114201329.3275875-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114201329.3275875-1-ameryhung@gmail.com>
References: <20251114201329.3275875-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save the memory allocation method used for bpf_local_storage in the
struct explicitly so that we don't need to go through the hassle to
find out the info. When a later patch replaces BPF memory allocator
with kmalloc_noloc(), bpf_local_storage_free() will no longer need
smap->storage_ma to return the memory and completely remove the
dependency on smap in bpf_local_storage_free().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  1 +
 kernel/bpf/bpf_local_storage.c    | 52 +++++--------------------------
 2 files changed, 9 insertions(+), 44 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 4ab137e75f33..7fef0cec8340 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -97,6 +97,7 @@ struct bpf_local_storage {
 				 */
 	struct rcu_head rcu;
 	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
+	bool bpf_ma;
 };
 
 /* U16_MAX is much more than enough for sk local storage
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 95a5ea618cc5..3c04b9d85860 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -157,12 +157,12 @@ static void __bpf_local_storage_free(struct bpf_local_storage *local_storage,
 
 static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_map *smap,
-				   bool bpf_ma, bool reuse_now)
+				   bool reuse_now)
 {
 	if (!local_storage)
 		return;
 
-	if (!bpf_ma) {
+	if (!local_storage->bpf_ma) {
 		__bpf_local_storage_free(local_storage, reuse_now);
 		return;
 	}
@@ -336,47 +336,12 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	return free_local_storage;
 }
 
-static bool check_storage_bpf_ma(struct bpf_local_storage *local_storage,
-				 struct bpf_local_storage_map *storage_smap,
-				 struct bpf_local_storage_elem *selem)
-{
-
-	struct bpf_local_storage_map *selem_smap;
-
-	/* local_storage->smap may be NULL. If it is, get the bpf_ma
-	 * from any selem in the local_storage->list. The bpf_ma of all
-	 * local_storage and selem should have the same value
-	 * for the same map type.
-	 *
-	 * If the local_storage->list is already empty, the caller will not
-	 * care about the bpf_ma value also because the caller is not
-	 * responsible to free the local_storage.
-	 */
-
-	if (storage_smap)
-		return storage_smap->bpf_ma;
-
-	if (!selem) {
-		struct hlist_node *n;
-
-		n = rcu_dereference_check(hlist_first_rcu(&local_storage->list),
-					  bpf_rcu_lock_held());
-		if (!n)
-			return false;
-
-		selem = hlist_entry(n, struct bpf_local_storage_elem, snode);
-	}
-	selem_smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
-
-	return selem_smap->bpf_ma;
-}
-
 static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 				     bool reuse_now)
 {
 	struct bpf_local_storage_map *storage_smap;
 	struct bpf_local_storage *local_storage;
-	bool bpf_ma, free_local_storage = false;
+	bool free_local_storage = false;
 	HLIST_HEAD(selem_free_list);
 	unsigned long flags;
 
@@ -388,7 +353,6 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 					      bpf_rcu_lock_held());
 	storage_smap = rcu_dereference_check(local_storage->smap,
 					     bpf_rcu_lock_held());
-	bpf_ma = check_storage_bpf_ma(local_storage, storage_smap, selem);
 
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
 	if (likely(selem_linked_to_storage(selem)))
@@ -399,7 +363,7 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 	bpf_selem_free_list(&selem_free_list, reuse_now);
 
 	if (free_local_storage)
-		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, reuse_now);
+		bpf_local_storage_free(local_storage, storage_smap, reuse_now);
 }
 
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
@@ -506,6 +470,7 @@ int bpf_local_storage_alloc(void *owner,
 	INIT_HLIST_HEAD(&storage->list);
 	raw_spin_lock_init(&storage->lock);
 	storage->owner = owner;
+	storage->bpf_ma = smap->bpf_ma;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
 	bpf_selem_link_map(smap, first_selem);
@@ -542,7 +507,7 @@ int bpf_local_storage_alloc(void *owner,
 	return 0;
 
 uncharge:
-	bpf_local_storage_free(storage, smap, smap->bpf_ma, true);
+	bpf_local_storage_free(storage, smap, true);
 	mem_uncharge(smap, owner, sizeof(*storage));
 	return err;
 }
@@ -731,13 +696,12 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 {
 	struct bpf_local_storage_map *storage_smap;
 	struct bpf_local_storage_elem *selem;
-	bool bpf_ma, free_storage = false;
+	bool free_storage = false;
 	HLIST_HEAD(free_selem_list);
 	struct hlist_node *n;
 	unsigned long flags;
 
 	storage_smap = rcu_dereference_check(local_storage->smap, bpf_rcu_lock_held());
-	bpf_ma = check_storage_bpf_ma(local_storage, storage_smap, NULL);
 
 	/* Neither the bpf_prog nor the bpf_map's syscall
 	 * could be modifying the local_storage->list now.
@@ -768,7 +732,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	bpf_selem_free_list(&free_selem_list, true);
 
 	if (free_storage)
-		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, true);
+		bpf_local_storage_free(local_storage, storage_smap, true);
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
-- 
2.47.3


