Return-Path: <bpf+bounces-64660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8052BB152C0
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0179E3A9253
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDD024A067;
	Tue, 29 Jul 2025 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fovYOKwn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203B023D2A9;
	Tue, 29 Jul 2025 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813557; cv=none; b=Pm+FyJ7PEXHUgUO4B6GxZd+5Nr0C8p1L9GaBB9HU0/iGDY4822aY8LwFV1Hlz/SiUxp49sP48sOJyEH8N0O/ZuPD+uR37t8hy1nOYKfqMhkYX11okpJSQXkOdNakqkzkaaUOJClvLOZm55a6X6qEaB35JzoEIUTLTxbovIKV23U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813557; c=relaxed/simple;
	bh=3ZlWEKGL5iipqk2Vt70dN10mo+e6ojWtxC2OzXisx7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0rKrm8V4MQO9qCfW12oSuouqQeiVYRgbL9GT86hrjojjJ+VSih78olr245swUfxJupkOjzr51j6DgfrPLfdUpxohTaR8AO35sAlMtt2gXMLdrWKahCdaN2ncRtozg7J+2mFS1HGy5x7JV9hOM0lc1IBGJw31LB9rPKJMG5pPh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fovYOKwn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24022261323so1876895ad.1;
        Tue, 29 Jul 2025 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753813555; x=1754418355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AViG3C+HLDh8qDpEODYTs1JQRTM0EhfYFQ+5vhEeowg=;
        b=fovYOKwnSZ3WeVaNB7Nz9ApYdqPeKyK3iqkXvbZjI1px0MwiN+JAhHTLO9wEprEURf
         zCGs+9lzwF0fYdxi7JbAux72BaTXToml/0w5U3jkyMWYNlXaeVc8gEH1j29bV341PlrM
         pII5R28d4M2iCSdaMKjx+RuX93WLP0puBQH+t4yPbK6YVGDqm8kCljbqQK1JLeSmJP9y
         VOW0ATUxQWxqK85onSjq6tKGn2XoCQ1879eY+yL3l9eemCZmNakRy/uYkI0HYdriy5fa
         I6qISIBbqbjAWl4k2+ferQp0JcarGVYYS0FQxKHObWHFCXLhSoHKychvN4KyIivtN8Da
         X5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753813555; x=1754418355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AViG3C+HLDh8qDpEODYTs1JQRTM0EhfYFQ+5vhEeowg=;
        b=BW490l9T7XVQDF5dBGZLszaX1EUjj5q8BevtxH/6+iHdndJo4egnt8IfGiRe7EG0gt
         5vajv37ei3328XAyEt3gR3t95KE5u9LzumnhTKtRQ8tEzTzYvZUVtQH2rlCEiogcyFQW
         oKDCYydf9MQdxfYzlrvIXXLFPLcIu3IxjdvtLDT1xgwkl80S/5Wp9WMujU65CIQfIxJ+
         A/p2/zF/4lMwa7fi2dFV0eVqHpzRK0d9VDqWvQE/HxDhCweno9N36JcFsnw0jfexS9Kx
         W6XyK6RI+xoOMyvRbucdQfwy94Cg8qFuSNboyX3JpQJn1FsgNqJu749Fa+KORp0NROww
         H0Qg==
X-Gm-Message-State: AOJu0YxrPuWuGb7NZ7dBVYTXqWLfl0JL8ww1MdnmJ6+XC6XKgR7i9sFC
	J49ydngqqerRvZOgpOQlRkQHlJI1Gq6dcvrdCNuH/U3GGnMl5axTr7ZA0rkaUw==
X-Gm-Gg: ASbGnctbA5v51HBcazxzUNMNi+3bCmhsGJpVDkA8RvR/mS//vxOewt/nrOGVrEjnHLr
	xOxKfwjoeb5pcRgFOQ9wQJNr5bBnckjueURnwaOFvl2W0SdLwA6UW5TY7BO4lesPtEK4v+CV6z5
	ttOyBrMjtP7yQsRIv9wzkjsCelD/94kWgTVQe4HBbZdOuVMhY3eDNsRB8MUtYQe8vyLr1FBxO+N
	lbJqXnmsalRyjEosBZWSYmJikfTDrfHcqFdkDv3CpdRXuGBBZa1UXHffvpgENLHGAcy9lBTXh3W
	lekWQSM+RO/ho0gPBPyhzC4WDSukTDqTJruIPOChlzDoIMS774xhUhKBxXUd5htCfze5Bq7V8Rn
	TCJ7D+bhZDZ+YTg==
X-Google-Smtp-Source: AGHT+IHF8VfL7OJ7XIlErXV960saoyfcJpBWGwjV3p+N/nGd1f/X2AhUpXMaLfkwu9bFu/kebymwSA==
X-Received: by 2002:a17:903:94f:b0:231:d0da:5e1f with SMTP id d9443c01a7336-240968abb01mr7775685ad.21.1753813555117;
        Tue, 29 Jul 2025 11:25:55 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-240358f4ab6sm47980885ad.49.2025.07.29.11.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:25:54 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v1 03/11] bpf: Open code bpf_selem_unlink_storage in bpf_selem_unlink
Date: Tue, 29 Jul 2025 11:25:41 -0700
Message-ID: <20250729182550.185356-4-ameryhung@gmail.com>
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

To prepare for changing bpf_local_storage::lock to rqspinlock, open code
bpf_selem_unlink_storage() in the only caller, bpf_selem_unlink(), since
unlink_map and unlink_storage must be done together after all the
necessary locks are acquired.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 78 ++++++++++++++++------------------
 1 file changed, 37 insertions(+), 41 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 95e2dcf919ac..7501227c8974 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -371,37 +371,6 @@ static bool check_storage_bpf_ma(struct bpf_local_storage *local_storage,
 	return selem_smap->bpf_ma;
 }
 
-static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
-				     bool reuse_now)
-{
-	struct bpf_local_storage_map *storage_smap;
-	struct bpf_local_storage *local_storage;
-	bool bpf_ma, free_local_storage = false;
-	HLIST_HEAD(selem_free_list);
-	unsigned long flags;
-
-	if (unlikely(!selem_linked_to_storage_lockless(selem)))
-		/* selem has already been unlinked from sk */
-		return;
-
-	local_storage = rcu_dereference_check(selem->local_storage,
-					      bpf_rcu_lock_held());
-	storage_smap = rcu_dereference_check(local_storage->smap,
-					     bpf_rcu_lock_held());
-	bpf_ma = check_storage_bpf_ma(local_storage, storage_smap, selem);
-
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
-	if (likely(selem_linked_to_storage(selem)))
-		free_local_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, true, &selem_free_list);
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
-
-	bpf_selem_free_list(&selem_free_list, reuse_now);
-
-	if (free_local_storage)
-		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, reuse_now);
-}
-
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem)
 {
@@ -459,24 +428,51 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map *smap,
 
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 {
+	struct bpf_local_storage_map *storage_smap;
+	struct bpf_local_storage *local_storage = NULL;
+	bool bpf_ma, free_local_storage = false;
+	HLIST_HEAD(selem_free_list);
 	struct bpf_local_storage_map_bucket *b;
-	struct bpf_local_storage_map *smap;
-	unsigned long flags;
+	struct bpf_local_storage_map *smap = NULL;
+	unsigned long flags, b_flags;
 
 	if (likely(selem_linked_to_map_lockless(selem))) {
 		smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 		b = select_bucket(smap, selem);
-		raw_spin_lock_irqsave(&b->lock, flags);
+	}
 
-		/* Always unlink from map before unlinking from local_storage
-		 * because selem will be freed after successfully unlinked from
-		 * the local_storage.
-		 */
-		bpf_selem_unlink_map_nolock(selem);
-		raw_spin_unlock_irqrestore(&b->lock, flags);
+	if (likely(selem_linked_to_storage_lockless(selem))) {
+		local_storage = rcu_dereference_check(selem->local_storage,
+						      bpf_rcu_lock_held());
+		storage_smap = rcu_dereference_check(local_storage->smap,
+						     bpf_rcu_lock_held());
+		bpf_ma = check_storage_bpf_ma(local_storage, storage_smap, selem);
 	}
 
-	bpf_selem_unlink_storage(selem, reuse_now);
+	if (local_storage)
+		raw_spin_lock_irqsave(&local_storage->lock, flags);
+	if (smap)
+		raw_spin_lock_irqsave(&b->lock, b_flags);
+
+	/* Always unlink from map before unlinking from local_storage
+	 * because selem will be freed after successfully unlinked from
+	 * the local_storage.
+	 */
+	if (smap)
+		bpf_selem_unlink_map_nolock(selem);
+	if (local_storage && likely(selem_linked_to_storage(selem)))
+		free_local_storage = bpf_selem_unlink_storage_nolock(
+			local_storage, selem, true, &selem_free_list);
+
+	if (smap)
+		raw_spin_unlock_irqrestore(&b->lock, b_flags);
+	if (local_storage)
+		raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+
+	bpf_selem_free_list(&selem_free_list, reuse_now);
+
+	if (free_local_storage)
+		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, reuse_now);
 }
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
-- 
2.47.3


