Return-Path: <bpf+bounces-70255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8F5BB592B
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 00:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F367219C7E31
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 22:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBE32C11EC;
	Thu,  2 Oct 2025 22:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMSKQ2cd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AE32C027B
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445648; cv=none; b=EplPKdxwfYwpZPOMFS9itqf5sPSkYVKcOmNP24OU3pejrlQtcofVqDYR829nj7mqo9FL3f17OR8pBICPTTY9EOSdADtqyg8OaDi9rujARB6ODFpnqCGwxPXSuK3f0VpAhvYhxM4pwz917jmnOH5gI4Kq6tWSOcT1KfV/iyX2DyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445648; c=relaxed/simple;
	bh=5p6Z7cjjV18vVWnI6II/0QJfVoAKXYNxz9HZpTRNaao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDeRm+lhC0RCdCrBjcx0AwIvAfFQ7ZcpNZtBgW8KUfooMqH4yUPGY1X4TU3B7gaYU2u9cCscbNqIPk4v1g9zq0zUvL0QjqRzwBN/amdXyHMBQXFMTbN68IOS1v7coQ0aQREV+KwLuZ1mflDevLSkn21vj2jvsg3/hdnT4gsCr6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMSKQ2cd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2698d47e776so12031685ad.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 15:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445645; x=1760050445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/gjNuknIK8njy5UF8ewH+Eq1DSFc2xhecDb+OaaefM=;
        b=lMSKQ2cdxlOOxCpNyNf08+iN09en1FXHn5bxjveOHIwu5p0VpJ444HnLXas7obxc3B
         2pUp2Y6N0tEpjb1O2OvHTZXQGh13TDBIBOe7HglbjnAnE+IDsCtiWT5R5yubMyczjzcx
         MPXYfByP4XNC7OJDaIaOXyPQJ411sTG0uW86WuKagBvwgP5uCWIgQ+Fsw+AFXa0yiLGj
         fhgrI59mvBAiGGOhWvWMNRAEjaBqsEpEhZQVMpSqOB2QOC3FuQ76I5eiwKrifIPa1NBz
         tSkjEjzfMLiP8UBlFDRfsXIF2Rcx2BVI4N9SAULD+D6LWAfIPpt+y0RbPeXKNCwo6IRp
         BYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445645; x=1760050445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/gjNuknIK8njy5UF8ewH+Eq1DSFc2xhecDb+OaaefM=;
        b=YHQ0p4N2n3lKliO8pRDDQNv0anikcgun55dhmRuUcGOKKuv3V91zzbTPpLFAixubz4
         Tcol9ukunLtribkoVf/yPaIL+bcQ1psCorhMvxc1EmT8M/n95hZAG0xWy4SYFHVZ/Esv
         S3/lJ7SWvpnk8sYRO3MI/UBuI6hZ89RGE2L84cJM2NFGHLczcT/ucWPVPjinQ+yJQapZ
         2tQjSrrGxQBd95vikZCbObOvkxKjRbQxD9HOExf+ewMhh0lx5PGXx5ug1Oo5STZiGiOC
         LN1EzRpB9cI0rKGRWC39onmUda7CGmhUXmCC9UdkCnS1wLo9LmV1VgXhK6tgPp8XeOLt
         s1aw==
X-Gm-Message-State: AOJu0Yz30xrNWdsWSCwNv4gyIK8t2VCzbUPj8EHVPTnUr547Mf+kXO+u
	KDyQy4G1L0uU53PjN2cllmPwisw/jEe8fOTvnunE0TzKN7s7rTDnkN9GcQeu5A==
X-Gm-Gg: ASbGnctLHqNaC/5hJZTtYsGylRbxNGIQT4LaC1anbKVz83K28FeLMUCMoWZoCXeJ7al
	w40QjatdW6Yx1kficvZTrnxufqm+b2EWzGCyXRU9/+wbJGTqtKyxVJ2iYa7YLNAJ7dIH/+WMlJi
	DGo/04wUIU8TeSvXq6PBlc7VZhz30+8upzCA2ODfwS8S6/jQwXbl7W8PtuVQ+hHQlS6W7vMD6Zk
	fKZsFJUsA9bHtd0xJ1M5rXToaaSJIZk9egemHuqgR0puyADwUPB6brHhHnGBrLUSg/h1JNSxIw1
	hF7mhU2iB7kUFstVOyypiFjWCR1owkcG5T+dNmdR96aNtbrCQNtFIFF/xgdz2IIwxiL/i9UOdij
	DA5FCdcB8tkh162T+IdqC64vhpfZ613oW0WyPx8sEvSJtpcrW
X-Google-Smtp-Source: AGHT+IE49uiyqCW1j3CK+AkbgVqVKlib5DcYPxHW1xayMkN38krzQL3pToh2RW2yf2AFPE8e2f/8zg==
X-Received: by 2002:a17:902:cec6:b0:259:5284:f87b with SMTP id d9443c01a7336-28e9a5fa57cmr11623135ad.16.1759445644723;
        Thu, 02 Oct 2025 15:54:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d126012sm31523965ad.41.2025.10.02.15.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:54:04 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v2 08/12] bpf: Remove cgroup local storage percpu counter
Date: Thu,  2 Oct 2025 15:53:47 -0700
Message-ID: <20251002225356.1505480-9-ameryhung@gmail.com>
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

The percpu counter in cgroup local storage is no longer needed as the
underlying bpf_local_storage can now handle deadlock with the help of
rqspinlock. Remove the percpu counter and related migrate_{disable,
enable}.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_cgrp_storage.c | 59 +++++------------------------------
 1 file changed, 8 insertions(+), 51 deletions(-)

diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 8fef24fcac68..4f9cfa032870 100644
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


