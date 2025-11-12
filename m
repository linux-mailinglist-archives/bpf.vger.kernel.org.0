Return-Path: <bpf+bounces-74316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1851FC53D9F
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 19:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0C7C4F597B
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 17:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE25C34A3B0;
	Wed, 12 Nov 2025 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbjj3aRm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D164C27FB35
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970384; cv=none; b=jnoPLH4E0on8vU1Eskv3ZVRP4TjG3RVO0rIj1gRRNoPHM9/0JPLPBlZGjM3MRLXxH6wF/6CLKamYOirZz0/zNm/Zs34XuBGqe9G4dm2OLSFCXw1C4FYeF941tNWUTzsO47QvdiWcbko9Ds5j8i1UlZg7ZswerWb6GH7MjV5UvjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970384; c=relaxed/simple;
	bh=CEquJeA0B7qwqGPeAqfkq2sfpRrrFE8MiRneGr6NkN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bx/VGCAc1anY9vAFT9/fMyIGcvGQfhQnKeHzuiYCtgtsMXJ9K0vJQFqCH1hwR79DvN+m8exC3OnJbZ/Q2+oh9PkTeqAKLOAgJv8j6T7DQa8u+KU5a5yh5VC+sP2mTpuhcHLvZNbEbs273x4jtKpjiqpZmB1Vye9+S7M+PKOs1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbjj3aRm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so363594b3a.2
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762970382; x=1763575182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acHq2BOUlgDzCbZtEmgoDWL45nmh/pJ1AbrqttUOy5o=;
        b=kbjj3aRm/dhTy9iRHF1zO7u0wjiQbEI1yAle6PBSNBi4a3R6sdUJHctV0Hs2dEo3zu
         ss/hDe4McgMpHliONUFfmWB5cBbBV2yo/koMzXiOAfXU+Q6sLUBuMMCf7tCSf4qWfvkN
         y51ZSyQ7aJHVyrZQj4/3ecNRBnyNCvNFnPC9a+L8633HNLBvu9agcYps3N7BPVgfYGlT
         RTBV9dAZZe124oku7Ho3OPPnvzNrJnMLx+/Vk81iQA8Jp+4oJ5c7UxzPtuNU66rUmFgy
         s2QsNEvUqxaeyJgIPImPOACZSL7YT0j8tbmhdgGbwMxqzaNP9VrpRNZOY1BZw3zfR09D
         cqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970382; x=1763575182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=acHq2BOUlgDzCbZtEmgoDWL45nmh/pJ1AbrqttUOy5o=;
        b=r4UtafBZwQkBIax+crHnk6i1/1eRx0Kk/xHDbJEGBzTT9goovXDX/2fKJoZjnkwgRP
         KyrB5NU1akG1h6fNAMqoETDuBFI4FKe8da1evjFMfCUuPV8HyzEJEMq0c1TAaEC79c5k
         ehff0LFQs9GqxpRzmQX/1Y7MfSbd7RoVEe5sNkD9+fB+9pxwNRntHBEUox015IcSupbs
         VRD2tIG1eGsmqJ5t+D1C/y2zou1p0WEc7PbLZVi7MZ/aPSCs6T33V0/MCc+Oqp8Mj2ZJ
         Od52Po8t1bpbarwMTC+PExe8TKQAZ7htOlQAO+bAZuZB8cEJUSSCQyto8Uq8UH6DKNjA
         bepA==
X-Gm-Message-State: AOJu0Yy3F0A2DoQCU5+GM4unEaNUIQFDM7jY6Bx/zdh6IaPJufxbLkvl
	tX3uj2Bdd45Q6+xoNIW8IYVzU6IXLqSVa4mDYtY1HtxzP3J+3toHyVpPJzr3aQ==
X-Gm-Gg: ASbGncs2PUjI+UkNHdhAe9/sY1RYVYfVLJmaCXPGKvXpL+zxchzsw8A0B9Qpjuml/Kp
	uuvju6POdPuwvH3baicYV5jGyh9McISHln8XjzrNrK5TGkOkFfmizbPFoETPloq9ddRXqrQU/ru
	Z6/f15wsMR9zM1+Jm7wOMCcn6drueeG7TCCu8WPRMqzQ0bFRys0tFbIzWCvyp+IkulWQ/6ezj/H
	ntr9HmkXvxxsk7qVWOVsmqWvrQpykdeUfrfhOWA/64zvtHZJCcUACZsSRjY7GdxORGfyVs2hF+n
	D6EOJoXL30d7PTOlhGo2w+1sZLOWT+pSgLVTQPhCdxJTU8bVHXoU1MiEX/1+b0dIq9K5LcZ4r/r
	hR2G7vrlEANuqUCRWQjGapXRJeq/of8nQfKwXcIjE46OMQtzHYnTl2vNncewsnfqNSZE8zIf6jf
	f0
X-Google-Smtp-Source: AGHT+IFQ98bFpUCPF9LTU7l0QR3XqMV2kP4hkjuB9n1LjUHtrI7YnpKZpVVh4ZUD2ENRZb9q+yw6Ww==
X-Received: by 2002:a17:903:191:b0:295:195:23b6 with SMTP id d9443c01a7336-2984edec111mr51058975ad.55.1762970381930;
        Wed, 12 Nov 2025 09:59:41 -0800 (PST)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf64adsm37367335ad.42.2025.11.12.09.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 09:59:41 -0800 (PST)
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
Subject: [PATCH RFC bpf-next 1/2] bpf: Always charge/uncharge memory when allocating/unlinking storage elements
Date: Wed, 12 Nov 2025 09:59:35 -0800
Message-ID: <20251112175939.2365295-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112175939.2365295-1-ameryhung@gmail.com>
References: <20251112175939.2365295-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a96a44aba556 ("bpf: bpf_sk_storage: Fix invalid wait
context lockdep report"), {charge,uncharge}_mem are always true when
allocating a bpf_local_storage_elem or unlinking a bpf_local_storage_elem
from local storage, so drop these arguments. No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  2 +-
 kernel/bpf/bpf_local_storage.c    | 22 ++++++++++------------
 net/core/bpf_sk_storage.c         |  2 +-
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 782f58feea35..3663eabcc3ff 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -184,7 +184,7 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
-		bool charge_mem, bool swap_uptrs, gfp_t gfp_flags);
+		bool swap_uptrs, gfp_t gfp_flags);
 
 void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		    struct bpf_local_storage_map *smap,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b931fbceb54d..400bdf8a3eb2 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -73,11 +73,11 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
-		void *value, bool charge_mem, bool swap_uptrs, gfp_t gfp_flags)
+		void *value, bool swap_uptrs, gfp_t gfp_flags)
 {
 	struct bpf_local_storage_elem *selem;
 
-	if (charge_mem && mem_charge(smap, owner, smap->elem_size))
+	if (mem_charge(smap, owner, smap->elem_size))
 		return NULL;
 
 	if (smap->bpf_ma) {
@@ -106,8 +106,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 		return selem;
 	}
 
-	if (charge_mem)
-		mem_uncharge(smap, owner, smap->elem_size);
+	mem_uncharge(smap, owner, smap->elem_size);
 
 	return NULL;
 }
@@ -284,7 +283,7 @@ static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
  */
 static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
 					    struct bpf_local_storage_elem *selem,
-					    bool uncharge_mem, struct hlist_head *free_selem_list)
+					    struct hlist_head *free_selem_list)
 {
 	struct bpf_local_storage_map *smap;
 	bool free_local_storage;
@@ -297,8 +296,7 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	 * The owner may be freed once the last selem is unlinked
 	 * from local_storage.
 	 */
-	if (uncharge_mem)
-		mem_uncharge(smap, owner, smap->elem_size);
+	mem_uncharge(smap, owner, smap->elem_size);
 
 	free_local_storage = hlist_is_singular_node(&selem->snode,
 						    &local_storage->list);
@@ -393,7 +391,7 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
 	if (likely(selem_linked_to_storage(selem)))
 		free_local_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, true, &selem_free_list);
+			local_storage, selem, &selem_free_list);
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	bpf_selem_free_list(&selem_free_list, reuse_now);
@@ -582,7 +580,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		if (err)
 			return ERR_PTR(err);
 
-		selem = bpf_selem_alloc(smap, owner, value, true, swap_uptrs, gfp_flags);
+		selem = bpf_selem_alloc(smap, owner, value, swap_uptrs, gfp_flags);
 		if (!selem)
 			return ERR_PTR(-ENOMEM);
 
@@ -616,7 +614,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	/* A lookup has just been done before and concluded a new selem is
 	 * needed. The chance of an unnecessary alloc is unlikely.
 	 */
-	alloc_selem = selem = bpf_selem_alloc(smap, owner, value, true, swap_uptrs, gfp_flags);
+	alloc_selem = selem = bpf_selem_alloc(smap, owner, value, swap_uptrs, gfp_flags);
 	if (!alloc_selem)
 		return ERR_PTR(-ENOMEM);
 
@@ -656,7 +654,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (old_sdata) {
 		bpf_selem_unlink_map(SELEM(old_sdata));
 		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
-						true, &old_selem_free_list);
+						&old_selem_free_list);
 	}
 
 unlock:
@@ -762,7 +760,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		 * of the loop will set the free_cgroup_storage to true.
 		 */
 		free_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, true, &free_selem_list);
+			local_storage, selem, &free_selem_list);
 	}
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index d3fbaf89a698..bd3c686edc0b 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -136,7 +136,7 @@ bpf_sk_storage_clone_elem(struct sock *newsk,
 {
 	struct bpf_local_storage_elem *copy_selem;
 
-	copy_selem = bpf_selem_alloc(smap, newsk, NULL, true, false, GFP_ATOMIC);
+	copy_selem = bpf_selem_alloc(smap, newsk, NULL, false, GFP_ATOMIC);
 	if (!copy_selem)
 		return NULL;
 
-- 
2.47.3


