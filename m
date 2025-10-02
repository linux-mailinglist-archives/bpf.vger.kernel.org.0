Return-Path: <bpf+bounces-70247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC31BB58FE
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 00:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9419482C80
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 22:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27698286D4D;
	Thu,  2 Oct 2025 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOAXhUcr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347AC274B3C
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 22:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445640; cv=none; b=tkmi0/MFgo8q3Q6rmZkfCydMy/3gLzT0btoGFpOrqfVEyih+QibcHmbgY296NSFr/by+B0Lvwz9lu2IqakgeYVOFoc4321SWXaMEVNStS//TtPSvWZ4o7Z5B7hZPwI51HeSChK/y/Z2NeNJ+tJklUEKA4mgWCJA1L2PKalg8Yp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445640; c=relaxed/simple;
	bh=464gRjDhWysRp1UFMOn+hjqejnfygGrojzNiCB9m4Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+MOb0GdKEC2nyyjCPy/fioUAuZICpzq0p4BLoPEjZNiP+SgWDyNOdXvN/WtoyKJeG7lILMw43S7E9h+2ktvwKQ7Lg4TC9B6JRf/w39t2XsqWNHGg4KtBWRrugoFxZrCfsZZPqSaNsvV9q2nfSctpe4Jg7Ly0fK5wVtrfHMZUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOAXhUcr; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5d80f5a23eso2159459a12.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 15:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445638; x=1760050438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZA0XDUEcnTqdW6bM7UZOViMWAw8gatLSctO/A3qvR8g=;
        b=lOAXhUcr8mvtRPVk2Eu+1EG1XOfq/QAVSM1Yo5Q8J86Fjd5/YrGR6NP8jLuj2rERxv
         QIr0V7jIOvV2nxit7dKQLoJQfampGVz7daUa63CEn/LJMZJVDn8AVzneMIsV2Ehkfum0
         Rsf6U4Qib0ws39DlafZzVYT6DV73Z/iQGT+Ao90UtbjqAYw9/n8AFlV82nwkxt8iAqUT
         kk8v3V3+jUVUAtopp4Y8UfsJrjewBYTbHfTdp5psOGLJZPi/wP6i+DZD6nl1hFpzjlV0
         FR8AtFUwVKSqPxYTJUlC+2vgMOc2YNTDROkTORF/CZWrsH204qZ9Mj4HQNxDmhd9l6wY
         J1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445638; x=1760050438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZA0XDUEcnTqdW6bM7UZOViMWAw8gatLSctO/A3qvR8g=;
        b=e1n84H/y37SJSTKPQVRl1UOcHHJK/VBYyIJzgs1bk1/lIOEWuHaDp1u7pxLEZ+E3bX
         cXt9IJlbybyJk+6gkro80H4W3/vEzHMFoUM9Z4szseqIwSJX5IQ5pNt1NcpnfI9Q2MHJ
         pTRiyk4uoRfnGKASBOEl5VYzFkyrnNh/U65w/t895KzQeneDfqUdL5YmBIEE3/735aT8
         MomHzU3+7uhwiKjCXKayG7Hc7IPEV5gJ1AKSuZ/MVCOja0cYkuYaCL3uDYaYB5BoOUlu
         96PirW+Z3oB+rsIQ5EnGVEYv3m7txjT6lv2Sts37iad/gC9TLXz09cj7o4QB50lFGX/Z
         PBiw==
X-Gm-Message-State: AOJu0YwUddKSHinZdE7k44bpqKekzhw+bpdu8tCQT9ORS1E9tvK9BqLn
	aa2VvR8C5Noo7egim7a5vHcyHLZJAb5b9+oUitv6MWiKCzPhHTiuuFXS8gamXw==
X-Gm-Gg: ASbGncteNvGg8wW061zQc1W0OUZ/jAChHqcpmdofl3LZyK1bK8mD1+P8m9v5mYPnq/B
	dVNfduU89tQmkm0FQYr2uytlTSG2nkCQIYoAU8wStwM6D3bhQoWCGA1vuR0tHt6P4Nezk87HE51
	nBPlJXvzctojxWIa/Dsu9y1tghNu1hyoparcOf4iYP5bUwYujBWjtaAQaNpI1fXiqKdyQ9ChGux
	KqhE/cGIsZ5ik3Zd41nh2YJLhRtVeNzi7aDwH2W1NkHVHj44KzDQt6SfQG8KFiQ8+toIrahPNDR
	L8j74AR2sBIudpp+hWB7BygsMGDY/7TGml9ep3vyq/UnmktmpNnyqVAfoqqpfthH8Ju2uvPrwQx
	7R0aKWEYhsuma6cSCxUGCA1qWqTpyymvE+dprXRMQShgN5FnF
X-Google-Smtp-Source: AGHT+IHvonwGdb0zL8TGolTrspweB1R7cYKu8fA+DRvk1dbnYVDns4Uo4sPJkOKhkFT+BegO+wVEEw==
X-Received: by 2002:a17:903:1b47:b0:267:8b4f:df36 with SMTP id d9443c01a7336-28e8d0e99bfmr60741565ad.29.1759445638164;
        Thu, 02 Oct 2025 15:53:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110d61sm31345815ad.9.2025.10.02.15.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:53:57 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v2 01/12] bpf: Select bpf_local_storage_map_bucket based on bpf_local_storage
Date: Thu,  2 Oct 2025 15:53:40 -0700
Message-ID: <20251002225356.1505480-2-ameryhung@gmail.com>
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

A later bpf_local_storage refactor will acquire all locks before
performing any update. To simplified the number of locks needed to take
in bpf_local_storage_map_update(), determine the bucket based on the
local_storage an selem belongs to instead of the selem pointer.

Currently, when a new selem needs to be created to replace the old selem
in bpf_local_storage_map_update(), locks of both buckets need to be
acquired to prevent racing. This can be simplified if the two selem
belongs to the same bucket so that only one bucket needs to be locked.
Therefore, instead of hashing selem, hashing the local_storage pointer
the selem belongs.

This is safe since a selem is always linked to local_storage before
linked to map and unlinked from local_storage after unlinked from map.
Performance wise, this is slightly better as update now requires locking
one bucket. It should not change the level of contention on one bucket
as the pointers to local storages of selems in a map are just as unique
as pointers to selems.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b931fbceb54d..e4a7cd33b455 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -19,9 +19,9 @@
 
 static struct bpf_local_storage_map_bucket *
 select_bucket(struct bpf_local_storage_map *smap,
-	      struct bpf_local_storage_elem *selem)
+	      struct bpf_local_storage *local_storage)
 {
-	return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
+	return &smap->buckets[hash_ptr(local_storage, smap->bucket_log)];
 }
 
 static int mem_charge(struct bpf_local_storage_map *smap, void *owner, u32 size)
@@ -411,6 +411,7 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 
 static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
+	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
@@ -419,8 +420,10 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 		/* selem has already be unlinked from smap */
 		return;
 
+	local_storage = rcu_dereference_check(selem->local_storage,
+					      bpf_rcu_lock_held());
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
-	b = select_bucket(smap, selem);
+	b = select_bucket(smap, local_storage);
 	raw_spin_lock_irqsave(&b->lock, flags);
 	if (likely(selem_linked_to_map(selem)))
 		hlist_del_init_rcu(&selem->map_node);
@@ -430,9 +433,13 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 			struct bpf_local_storage_elem *selem)
 {
-	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
+	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
 
+	local_storage = rcu_dereference_check(selem->local_storage,
+					      bpf_rcu_lock_held());
+	b = select_bucket(smap, local_storage);
 	raw_spin_lock_irqsave(&b->lock, flags);
 	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
-- 
2.47.3


