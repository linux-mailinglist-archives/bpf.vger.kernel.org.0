Return-Path: <bpf+bounces-70250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F4ABB5910
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 00:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C639A48606D
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 22:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BF62BDC03;
	Thu,  2 Oct 2025 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWiYc89n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC49288C9D
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445643; cv=none; b=MEhE3Jo8mCpZSFaywPCdhzRtDBPAH7U/TPSozHBFPpXVc37Lq0pkdyKNjxKhLa2oOjW3blq8yBL/0i3LSOnqqpkVMKexf8m8yMdUz144xStzCSkNrHWYsrp4DK4+CwEV0/xS61F1aH7hgkiIrnMglqPBhyVTZCdhPBEE1crGs38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445643; c=relaxed/simple;
	bh=Rs9pgGg/MaOj4sf2rEKqNeDIwa6UCmWYcj/0CuhdxVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruqwaQu+oIWt71+XsCw6e5DS9FwJIazC5btUQTQ9FCe4MWYmf/GAhL6MXPMk1DeT96h7Zdok7J6s9Z3pBzJhwWMOFYX9/NlyxhU5GD0UBQuaVPa4GD8KheIMRwnmP0JBUjAwBSZI6wpU0R33JdofsYjYbOD2UlRTd1dCdwa1/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWiYc89n; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5f2c1a7e48so1166076a12.0
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 15:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445641; x=1760050441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYm5JWPj4dm6GLlb/3HSk+8LUYIu6E/uVIIRsCYD7NQ=;
        b=FWiYc89nlCPurnSVVg8W3eG+yKXF3bJpbNc1L7xi3bbzdxHzXzw15IXUsZGHz0P9DW
         5iTsClt+4dVD+A4WQB7csRwRMkSe2zLHcyuxYhavY6GOu9ykZcn8TsFBwh/oSZ+TO0m/
         dpATqmaJ5nK7bCsaGrkrD30RBcHwX8RzsrVr78xhYZV6h6RzbNir86auRhLy1ArZG8nr
         RDKydwpwJXhzsQBrF92SKgvSV5hFUuO5F34zn+0HkTTyGuknFb2qAfQZKfiI1DiUj+EB
         mBLq91d6M0XSDr7BZiMO+PLluElcF0mBj8nXp6dhhaaa8vdDqnPuuxLnAhcbDkb6HZ7e
         yxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445641; x=1760050441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYm5JWPj4dm6GLlb/3HSk+8LUYIu6E/uVIIRsCYD7NQ=;
        b=NfB3jjkjOZHmL9/3gF8WjGPA5DGM1L8Cvv0K2YLfshxsmcoTe/Xs2rlbfZf6umxK6k
         k1uFXb6Cl4hEdF05rbFk1W8uFKtEu9ZQhspeEP5scjVUvKQaJU1Xds3mj0wQ1N2Gu7kl
         hyRVwCJUXHsDBnkwGdwy1AnhErgFTJPtyect+fgXyB3/VJYCXcj4aen5yINVg4IoVebT
         f4C4UcSonCcvxAIlgSBaj1OkIPhR+Um8dmegU/1Bybly3bII74ye3+W1PN07+Rjdt6PG
         1sTCREXrgncwQKs2IEAr4tB4EQcY6ZFkmWjzrXu6DSaM0XnnPaEpXM5wE7w2lMiaYQU4
         4gfA==
X-Gm-Message-State: AOJu0YzLCqIY/2FXOX0QkWjaEqysdQy49GQM2vN3smeogNqNaKTc3dQS
	QIifWx9CnC/MGw2dgP+aVsJjo1DLXw07fDDKIBbxkB9JqjBxHHF8tgav7REqHw==
X-Gm-Gg: ASbGncuAEZVtDEBSWpFSTk2nzmiuLB6X0gEs9LHIyDiw6/3pXexRSVjZr2vOZliXK0L
	eTDOaU04Ic/Y/5WaezynWpnwbDAaVUxSyd/JfWl9uJQtqE2p47AQKNyrF3/nGhuyboXpuz4H06S
	NxKgm1daYFU0gK7qUMLTQHJwX91mHzzQXxXSuBmjwaj2ZsNM6tg2GNxD6RmXWqcM+rd2KMjNeKz
	WB2KTgrDBdmowV0onUwskDqF648W/eTZbZ7xYeFKVdhUQLLZCEWHnCwsp5RhBm07uq35ge1DSdJ
	N7Krcb+SIkxBzgmM1JtIf93MlzeB3x2k8c1JQdyHR5AgUf0CPKLI1HXx4O+UldKz5lrDYVh7Bk5
	lLNZ7d/K7HH8nL1rc70M5CU8lZyQf250igwonXnHraZAvnG5P
X-Google-Smtp-Source: AGHT+IElOJDaVI9CSgOz5Xw1RqoJKG1VmL7+FqLJItrI7Kx5/HrYdLTgUuv/9IesdEQJPBr4IZZ4rg==
X-Received: by 2002:a17:903:2411:b0:269:6e73:b90a with SMTP id d9443c01a7336-28e9a5f9e35mr9807015ad.15.1759445640938;
        Thu, 02 Oct 2025 15:54:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b87acsm31229365ad.76.2025.10.02.15.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:54:00 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v2 04/12] bpf: Open code bpf_selem_unlink_storage in bpf_selem_unlink
Date: Thu,  2 Oct 2025 15:53:43 -0700
Message-ID: <20251002225356.1505480-5-ameryhung@gmail.com>
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

To prepare for changing bpf_local_storage::lock to rqspinlock, open code
bpf_selem_unlink_storage() in the only caller, bpf_selem_unlink(), since
unlink_map and unlink_storage must be done together after all the
necessary locks are acquired.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 71 ++++++++++++++++------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 682409fb22a2..9c2b041ae9ca 100644
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
@@ -466,17 +435,43 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map *smap,
 
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 {
+	struct bpf_local_storage_map *storage_smap;
+	struct bpf_local_storage *local_storage;
+	bool bpf_ma, free_local_storage = false;
+	HLIST_HEAD(selem_free_list);
+	unsigned long flags;
 	int err;
 
-	/* Always unlink from map before unlinking from local_storage
-	 * because selem will be freed after successfully unlinked from
-	 * the local_storage.
-	 */
-	err = bpf_selem_unlink_map(selem);
-	if (err)
+	if (unlikely(!selem_linked_to_storage_lockless(selem)))
+		/* selem has already been unlinked from sk */
 		return;
 
-	bpf_selem_unlink_storage(selem, reuse_now);
+	local_storage = rcu_dereference_check(selem->local_storage,
+					      bpf_rcu_lock_held());
+	storage_smap = rcu_dereference_check(local_storage->smap,
+					     bpf_rcu_lock_held());
+	bpf_ma = check_storage_bpf_ma(local_storage, storage_smap, selem);
+
+	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	if (likely(selem_linked_to_storage(selem))) {
+		/* Always unlink from map before unlinking from local_storage
+		 * because selem will be freed after successfully unlinked from
+		 * the local_storage.
+		 */
+		err = bpf_selem_unlink_map(selem);
+		if (err)
+			goto out;
+
+		free_local_storage = bpf_selem_unlink_storage_nolock(
+			local_storage, selem, true, &selem_free_list);
+	}
+out:
+	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+
+	bpf_selem_free_list(&selem_free_list, reuse_now);
+
+	if (free_local_storage)
+		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, reuse_now);
 }
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
-- 
2.47.3


