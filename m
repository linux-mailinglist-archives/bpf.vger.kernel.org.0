Return-Path: <bpf+bounces-77015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71187CCD12A
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2610030AEC9D
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D593093C6;
	Thu, 18 Dec 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBlcFbGx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEF83043CF
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080602; cv=none; b=YKUSCwIRK3uh1MEbWKuyu840DwyB+xs704ycJLnETby8mJQf9tErkUEofHAl9wym3W/ImNfctn3sG0QbxqjkS03jquAyq8FEWT8mnbPx15oju1/W8bKogLucOl79ZBcaFsk40FGj60YSfsMBR7CMRk4zNmjvQQN51btt3CojGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080602; c=relaxed/simple;
	bh=+VqL2Tt3DZfEzJCZumYRh3TB8bCtCTtoeuVGc7k8YZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2gU0mWInbg8Pcthpi6E+okcmVdZVyQL0gasjxlNX8FHnWP06xTWY1PAIGeluqgDmh7VFNcvkpQOqwHPOFx5jTCjq5IrkicS30ohC4U4LFsp0ffXfssV1sSuS7D4SppE2nMEBdXNxJJWnKDiS5jpBMU/XxJXgHIOZA6aLCgVIso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBlcFbGx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so1105031b3a.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080599; x=1766685399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBj1V+4xCUwk81a2kOPMU8wayL/IDg35NleXiXlQBlk=;
        b=QBlcFbGx23NFAK6bISQ4jYJg7tlYEc/v1bZnbXxelxFqW63u04MfRQQ3MM+0OJWP9l
         ww/KX4/sYcVtJ4WVkIRjJcQnBK6tCRx2cI5djyXjyQipnhXe3O/gYjraJUmTQcDS89IW
         fYfr13FkmYyS1qiuMgH60UAqZtaXtP4QYNiZF5aND5x55UoYIsLJK6cIGpdV3PJ8eZpZ
         zN2SIm1TGzslw0/EjueiKy/L6t9sQc1pCPLwdc2nZcav9ftRVpTsL2NclAaBGak7SunD
         FDKc48+GnblHt+aSbPoZ2S9eOMmEmzwh6lCl2Iiu6pcxT9PAA2pku6TIamSl/zWKOoxv
         ww+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080599; x=1766685399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vBj1V+4xCUwk81a2kOPMU8wayL/IDg35NleXiXlQBlk=;
        b=sihLBR3EAlr5NCk31mPm79sgWxZo/6SHSL2lIVDnb1YgOSOA+J/RtAmOskQfypcy0S
         bTGfJ13f9BHH0qN+o0RVIlNPKdrPfm6RxEdNTet8lC/LOyf9jraDKbRO1fVQ7K2mob4u
         IZtzbRin7lMr5ZkX3kdgiYjjwa+MD3hx5hTrjtCQND8grr0QYCe6Qf/SELor/cOfJcIJ
         bSQSJekI1hLrHqCGCmFG2W8FdARwmEim+c6Wbrmq08xIQ3JieMx8x3QixW2wkxX+hXV+
         mAMcvFkKjIFNhCQxvRMSCWGfik7bk9hd4dTMpA7nki5jFL9TwDcsjI9IdzMRtlJTOyOD
         OFWA==
X-Gm-Message-State: AOJu0Yy4w5RjqtWx+xTUvfGfjMEauFl6NjdP+eUVIs2P0nB5RKzmrJFW
	e2ok0Y2y0xWjlM7k+rIFgasdZzQlMXVuTYt/2kV5L0TK3VjrdqQazuolzI5glg==
X-Gm-Gg: AY/fxX4o+GXjqrLj+y6ZZrjqtx34qYgGalkpQmeWkUi8Nae5zdR2IMnoOEabcH6cBZO
	gTz2Rv+nOKoS6pOi//x2wSWofnfhz8l9KHKgA2Kv96ddJYDd887jvtFFlvFOkPqBHDZA7Pw4frK
	MjS93BNlllPk7DifxCoj4we50ig8jgRVe7Y26tzq4wQkKDZeDpIFJu4YekIhz1k0IGh/dhIfK+D
	C27MIxmd1pkjW2XDc50R5Tutx4LOHnaOU2EINSOr4X5TEhOlGD3tOGlZNbalvlBAFu5QtCyFaFp
	u3hWzOlUDQAt3mcJG2sIA1+mvM66VZK386PWP3KzdOfz+Cw/wRaRmjUvzyY6s0ec9Snr3j/Jds9
	yCIaS+KDKeKycel8m6Tnf+uFJJRPyYiv6UrobkPWPbKztbP7eFiMQeqs706dbNfAUsCGR9dtCf4
	CFUSopCaPJfEVc5A==
X-Google-Smtp-Source: AGHT+IGFEmRe2EF9WR29Qg4uBiM17Y9wR9WXxXeS+qHqci58YXZIALWZDgYQrllOordY3WMAx9qbBA==
X-Received: by 2002:a05:6a20:549d:b0:35f:84c7:4012 with SMTP id adf61e73a8af0-3769f92fca1mr424565637.29.1766080598875;
        Thu, 18 Dec 2025 09:56:38 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1d2fff94e5sm2889041a12.25.2025.12.18.09.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:38 -0800 (PST)
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
Subject: [PATCH bpf-next v3 07/16] bpf: Remove cgroup local storage percpu counter
Date: Thu, 18 Dec 2025 09:56:17 -0800
Message-ID: <20251218175628.1460321-8-ameryhung@gmail.com>
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

The percpu counter in cgroup local storage is no longer needed as the
underlying bpf_local_storage can now handle deadlock with the help of
rqspinlock. Remove the percpu counter and related migrate_{disable,
enable}.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_cgrp_storage.c | 59 +++++------------------------------
 1 file changed, 8 insertions(+), 51 deletions(-)

diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 8fef24fcac68..4d84611d8222 100644
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
@@ -45,16 +22,14 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
 {
 	struct bpf_local_storage *local_storage;
 
-	rcu_read_lock_dont_migrate();
+	rcu_read_lock();
 	local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
 	if (!local_storage)
 		goto out;
 
-	bpf_cgrp_storage_lock();
 	bpf_local_storage_destroy(local_storage);
-	bpf_cgrp_storage_unlock();
 out:
-	rcu_read_unlock_migrate();
+	rcu_read_unlock();
 }
 
 static struct bpf_local_storage_data *
@@ -83,9 +58,7 @@ static void *bpf_cgrp_storage_lookup_elem(struct bpf_map *map, void *key)
 	if (IS_ERR(cgroup))
 		return ERR_CAST(cgroup);
 
-	bpf_cgrp_storage_lock();
 	sdata = cgroup_storage_lookup(cgroup, map, true);
-	bpf_cgrp_storage_unlock();
 	cgroup_put(cgroup);
 	return sdata ? sdata->data : NULL;
 }
@@ -102,10 +75,8 @@ static long bpf_cgrp_storage_update_elem(struct bpf_map *map, void *key,
 	if (IS_ERR(cgroup))
 		return PTR_ERR(cgroup);
 
-	bpf_cgrp_storage_lock();
 	sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
 					 value, map_flags, false, GFP_ATOMIC);
-	bpf_cgrp_storage_unlock();
 	cgroup_put(cgroup);
 	return PTR_ERR_OR_ZERO(sdata);
 }
@@ -131,9 +102,7 @@ static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
 	if (IS_ERR(cgroup))
 		return PTR_ERR(cgroup);
 
-	bpf_cgrp_storage_lock();
 	err = cgroup_storage_delete(cgroup, map);
-	bpf_cgrp_storage_unlock();
 	cgroup_put(cgroup);
 	return err;
 }
@@ -150,7 +119,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 
 static void cgroup_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &cgroup_cache, &bpf_cgrp_storage_busy);
+	bpf_local_storage_map_free(map, &cgroup_cache, NULL);
 }
 
 /* *gfp_flags* is a hidden argument provided by the verifier */
@@ -158,7 +127,6 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	   void *, value, u64, flags, gfp_t, gfp_flags)
 {
 	struct bpf_local_storage_data *sdata;
-	bool nobusy;
 
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
@@ -167,38 +135,27 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	if (!cgroup)
 		return (unsigned long)NULL;
 
-	nobusy = bpf_cgrp_storage_trylock();
-
-	sdata = cgroup_storage_lookup(cgroup, map, nobusy);
+	sdata = cgroup_storage_lookup(cgroup, map, true);
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


