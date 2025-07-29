Return-Path: <bpf+bounces-64664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC4B152C8
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5CB25480C4
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665272561D4;
	Tue, 29 Jul 2025 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxSzTCDt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176532528E1;
	Tue, 29 Jul 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813561; cv=none; b=vEoDVy113mwevhfJJ3fHKnKhhB2+ihoaVJj/GrQuFFCkstFVCe+uxsit9+z9hm19pCBttHCM8LtmuRnNlfw8NL97lpg3PxhaFVrlVCanEntNMvOSz4VXY7Hox80dNnDgps2i8M8vnL0O66W4pZa0jCNkFN90GcCaQjFogxbp5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813561; c=relaxed/simple;
	bh=wehLCKWhtQBxDCakvacFqfXiov6xMZNmtYeLzRX9xgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYeyt4+PVT2DTTYsVn2i6RKdXDFSZYnRMgba4dxk21p7LxWU9uw26evAAvqbvDN3MVe96/2KmULsv4r23u/fBPWUxJg0xYVhl+KmKoDZQsb0Xmrf76eZYuIb264vd2GVoLdzAFOfn0C6bpdsPnPHT+EwbJzW22yiH7C7qxJyOyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxSzTCDt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73c17c770a7so6498877b3a.2;
        Tue, 29 Jul 2025 11:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753813559; x=1754418359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVOiiyQikazpN+IzdWHqc9nfN+ZyFQ+AQYylXhFGhe4=;
        b=LxSzTCDtYOi9cTn1fl9i43q/v+9age69uImgVsKjEpSlku8i23n/IiM5hoKM2874Du
         yLgiqmDf+rd4HMly+72PB4Ia258s/+VZV+nqpK6fesm9HRh9aKv8tPCh6HK8zZ11CKG8
         CaSjUvOKFJ3/M6ZRVE7RhqhQGIceMBwOA7lrtI23eex32gP3s+CjtOKnuYqc/HrfgHJl
         umDvaIKR858CITKxL2pcpyIc2ZfH7MtHbPr/cvssq/9R2AlT58sOrZW/vhO0IDjwm8by
         jXh3Ro4Dxu0JIazO1VDRfR9q1LvVfcDyuRrS9VOHyMBOK5yz9eL1hBYwa0nAde5L0ndV
         XVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753813559; x=1754418359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVOiiyQikazpN+IzdWHqc9nfN+ZyFQ+AQYylXhFGhe4=;
        b=i6Nay9LrFZDO96dVnjH1CU2TpLCetgOFhMzRHK+t7Chlox0GbtR9U9EOfELiMoIOBj
         SRrY0UVkwPIcUsyB+JLC137G35MOvW8xceyRS5Qg8EU2IFHRqEqRkTC7JXQ/pyegVaQ/
         Np/HGUsK3AbZP/Ek5jpFQWgcV7L4msCk8Yna//s8934ceQDVzINv7HDVs8aiBmZ3gS9D
         TNGhPhdqUWo+lsB1OfPSQRfTiIVEyx7UnrJWnjawi2Ju53Eu3YppzWOjGyh98dGMB6kz
         si+v132FEV31mqA9QWXt0+VY6JkTn0UrYTVqsZm72fc+K/BjS+uZxR4LfWZC6Dr/a3re
         yEUg==
X-Gm-Message-State: AOJu0Yxf3t60Ca/HpSNvP0VdViCqoT4LvezQnKHBm7Hvpejz2nQmmW7H
	ERU8b8qvSYhE98VArTnd+t0+NeWJvixOpfsF501QTaSK5CpHU4oTOj0hZh6hrQ==
X-Gm-Gg: ASbGncsJBnaZPte9vjF/i5hnuelJgAo22W20naVF9D7nSXVsmt1FYCCrmf94sZUdpAi
	Dsy3uWJpMbaD1xsYzhr504xz+yBXHo+XGH+A+hH+Vs6dlmnN2W2q7jp1mxfAMP0VALCCLYBGith
	mW+yxcw10vYMwZGyYxEc4ceOVokwGGPYgc1Yi9jCluDbAG5vSU2GSmEpqO63aUJwcf8nGaKOFgb
	LFdBgrFnV94k41+GzRN1YNUmzu4oD6MNK4tkUaeEFJDPfOoHstADd5re/7oUYQ9CWQmSeUeWgnR
	1OB17z2Y68d4+L+vWqIm6+CH+IYErXrxn94XEJocS4liMAkdDioNDVFaPMmy7ddvwYyA8X9xch8
	F+0R+zTJ+7q6O5A==
X-Google-Smtp-Source: AGHT+IFL6QlWLlPxyM+VGcZw6qvHiTtBPDmiYXVK2rSJODXOOEFck9lJlAFe45JpSsyi5hDdE8kTrQ==
X-Received: by 2002:a05:6a21:33a2:b0:235:2cd8:6cb6 with SMTP id adf61e73a8af0-23dc0e7c59cmr584487637.34.1753813559118;
        Tue, 29 Jul 2025 11:25:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640872a18bsm8688395b3a.13.2025.07.29.11.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:25:58 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v1 07/11] bpf: Remove cgroup local storage percpu counter
Date: Tue, 29 Jul 2025 11:25:45 -0700
Message-ID: <20250729182550.185356-8-ameryhung@gmail.com>
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

The percpu counter in cgroup local storage is no longer needed as the
underlying bpf_local_storage can now handle deadlock with the help of
rqspinlock. Remove the percpu counter and related migrate_{disable,
enable}.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_cgrp_storage.c | 57 ++++-------------------------------
 1 file changed, 6 insertions(+), 51 deletions(-)

diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 68a2ad1fc3d4..4f9cfa032870 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -11,29 +11,6 @@
 
 DEFINE_BPF_STORAGE_CACHE(cgroup_cache);
 
-static DEFINE_PER_CPU(int, bpf_cgrp_storage_busy);
-
-static void bpf_cgrp_storage_lock(void)
-{
-	cant_migrate();
-	this_cpu_inc(bpf_cgrp_storage_busy);
-}
-
-static void bpf_cgrp_storage_unlock(void)
-{
-	this_cpu_dec(bpf_cgrp_storage_busy);
-}
-
-static bool bpf_cgrp_storage_trylock(void)
-{
-	cant_migrate();
-	if (unlikely(this_cpu_inc_return(bpf_cgrp_storage_busy) != 1)) {
-		this_cpu_dec(bpf_cgrp_storage_busy);
-		return false;
-	}
-	return true;
-}
-
 static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
 {
 	struct cgroup *cg = owner;
@@ -45,18 +22,14 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
 {
 	struct bpf_local_storage *local_storage;
 
-	migrate_disable();
 	rcu_read_lock();
 	local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
 	if (!local_storage)
 		goto out;
 
-	bpf_cgrp_storage_lock();
 	bpf_local_storage_destroy(local_storage);
-	bpf_cgrp_storage_unlock();
 out:
 	rcu_read_unlock();
-	migrate_enable();
 }
 
 static struct bpf_local_storage_data *
@@ -85,9 +58,7 @@ static void *bpf_cgrp_storage_lookup_elem(struct bpf_map *map, void *key)
 	if (IS_ERR(cgroup))
 		return ERR_CAST(cgroup);
 
-	bpf_cgrp_storage_lock();
 	sdata = cgroup_storage_lookup(cgroup, map, true);
-	bpf_cgrp_storage_unlock();
 	cgroup_put(cgroup);
 	return sdata ? sdata->data : NULL;
 }
@@ -104,10 +75,8 @@ static long bpf_cgrp_storage_update_elem(struct bpf_map *map, void *key,
 	if (IS_ERR(cgroup))
 		return PTR_ERR(cgroup);
 
-	bpf_cgrp_storage_lock();
 	sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
 					 value, map_flags, false, GFP_ATOMIC);
-	bpf_cgrp_storage_unlock();
 	cgroup_put(cgroup);
 	return PTR_ERR_OR_ZERO(sdata);
 }
@@ -133,9 +102,7 @@ static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
 	if (IS_ERR(cgroup))
 		return PTR_ERR(cgroup);
 
-	bpf_cgrp_storage_lock();
 	err = cgroup_storage_delete(cgroup, map);
-	bpf_cgrp_storage_unlock();
 	cgroup_put(cgroup);
 	return err;
 }
@@ -152,7 +119,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 
 static void cgroup_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &cgroup_cache, &bpf_cgrp_storage_busy);
+	bpf_local_storage_map_free(map, &cgroup_cache, NULL);
 }
 
 /* *gfp_flags* is a hidden argument provided by the verifier */
@@ -160,7 +127,6 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	   void *, value, u64, flags, gfp_t, gfp_flags)
 {
 	struct bpf_local_storage_data *sdata;
-	bool nobusy;
 
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
@@ -169,38 +135,27 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	if (!cgroup)
 		return (unsigned long)NULL;
 
-	nobusy = bpf_cgrp_storage_trylock();
-
-	sdata = cgroup_storage_lookup(cgroup, map, nobusy);
+	sdata = cgroup_storage_lookup(cgroup, map, NULL);
 	if (sdata)
-		goto unlock;
+		goto out;
 
 	/* only allocate new storage, when the cgroup is refcounted */
 	if (!percpu_ref_is_dying(&cgroup->self.refcnt) &&
-	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) && nobusy)
+	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
 		sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
 						 value, BPF_NOEXIST, false, gfp_flags);
 
-unlock:
-	if (nobusy)
-		bpf_cgrp_storage_unlock();
+out:
 	return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
 }
 
 BPF_CALL_2(bpf_cgrp_storage_delete, struct bpf_map *, map, struct cgroup *, cgroup)
 {
-	int ret;
-
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (!cgroup)
 		return -EINVAL;
 
-	if (!bpf_cgrp_storage_trylock())
-		return -EBUSY;
-
-	ret = cgroup_storage_delete(cgroup, map);
-	bpf_cgrp_storage_unlock();
-	return ret;
+	return cgroup_storage_delete(cgroup, map);
 }
 
 const struct bpf_map_ops cgrp_storage_map_ops = {
-- 
2.47.3


