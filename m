Return-Path: <bpf+bounces-67582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC247B45E7E
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 18:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07B81C82CE6
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 16:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00F530B513;
	Fri,  5 Sep 2025 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC0MGxnt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A2B309EFA
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090720; cv=none; b=Aj+RBseQEMuRJFToJ1e2s8EQW7q2L555tGG+q3KlLv1l38S8gcdxoh0d6ITW78/DtBFduPhtnH5HXLZz3167y4XqvjDeXlRI382M/YDza67H8LLLgcV4t5rAEnsoJnEDtyDFHc63NoU6Bbc3tAS5sIq83LCUe8KzNHktIh4amGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090720; c=relaxed/simple;
	bh=tkbki1q5zitUITvhVRXAvCkARxsvSpMJi35tbbPaq1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cztEc+TJG2UODDsLJ4rLHC0Mxyv5JdZlAZpAF3iW8ezUD/A7TeSTFTk8dqg5T4vdPsfDwYhyVRQZNmDOOe1cS4ege3o6T06YT56ggtC29YKhEjgn/dgvC9tALw/LXfsTQz0WST6n9KqC1x+4VFlmuNO6tFI5HeJbXYZX3YrGiZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC0MGxnt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dda7d87faso6310445e9.2
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757090717; x=1757695517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjSJ+33pjco0D6Drl0o+EBST2Xza5L2pSY4bBt9vS+E=;
        b=WC0MGxntb1XkiDNvz0UCNj5DgckLxRypvUqNKjTdY2l1RCwqin4sVh4cQFOyLL++fa
         48Vr7Oxm6nu9wl1RiFJoZ+2q5ZUCs8nylEtZbhvbVsFctI/cBPaA7pU/iTLTLLx1m/pN
         ZIIDitUlR8t3giiDbr8FZj5qB28cfLtpIigYHBUNTZmUgp7rMbdAcccQqyzKvULCe+es
         aBASipKwtUd4GVqhNWY6A9r72+FHMUG9ogyoKf8qdOCmaIQrpwcNBDhLjpUjHyNi/hmI
         F7aIsWxtKXll6A5rxxw4Q1VPGjYpQ1W8+C9LI0a6jFoVsAlOJ+QbQZBRpyxJUGZiynv6
         4fFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090717; x=1757695517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjSJ+33pjco0D6Drl0o+EBST2Xza5L2pSY4bBt9vS+E=;
        b=uBICtmRfXFQ/ac5WOl+1bses1hsCpqKevCOSxxF6X5EAidtcUdmMOH5JP9GZC2xY/a
         8+Uc+ZfJbfQEGGM0ryxdzgrofVTTr9ArfOZeIpNg6+rH7xFYe7stGphrk+C5LYqHJjvC
         7kMZbZHGOqHcFzibXRG0VuYXPpM+LoJFB7iapG6tGQnJ3J72Viyj9pgymoOjnuK1G9C5
         pUkZ3D98YzYtudfq1M2pDsAPl1L1q/6Mh3e5DvdY9M185z6bD3c6S8XepDGrJUfpzSSj
         TaZyR3Vr0HI8eLPEwCk4xUmHISrgGv46JkTWfKceGdiDEzf4zgnenngYceVZwKpzmVdD
         DqTg==
X-Gm-Message-State: AOJu0YzyqOAjUPtEGhvRnIb4t3T526+xXb/D3Mgzqys179louwozKrxp
	84BIkVgL0IbpOKSErUghRE3meoObVg0/nVNhiA8S+PcJiDGJMXJunj+6DTGuaA==
X-Gm-Gg: ASbGncuBE8BIKPKmRsShkmLnB176xeu3JmWx3ulI43fpEqBIy/j6FWw4/yCPtQkTIrt
	Hwly/PFnfpznxzsYBxYafBJEzlzi7i4KsOaKALIGAvNA6ph3cKhKtBNN8Wnu1r8ll1FQJ1ew0Se
	dlgMc4MQOUxPhr3ECMSAXJtwnKEVel71DTWXiVCZKqFzepm/wiuvesB1bFlgE4LryKq44vv/g2r
	d/Wno5TbxJltzuujv0csUEE30yaiGQo2Z+js/DvUEGjHDOm9MJTXdcHzNzHfy7hfvnMKwS59LU8
	BE3TiU8Nc4BFUCnugEThgO5GtM8/nY5uFyBSfwTPXnszwpEMak1YIbzpz81DI8dKAB14uhX/JYf
	b/0YzyM7IAZZspV7a7AAH
X-Google-Smtp-Source: AGHT+IGs43+4cSCtMbQf7u7QKwmAD5gTOEtn5JdpP5YFSi835r7YZ5ynVmDvPpX5WBILAlaYuMfFlw==
X-Received: by 2002:a05:600c:1c0e:b0:459:e466:1bec with SMTP id 5b1f17b1804b1-45cb5871c12mr75689595e9.2.1757090716633;
        Fri, 05 Sep 2025 09:45:16 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d95df59e50sm16990080f8f.23.2025.09.05.09.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:45:16 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 3/7] bpf: htab: extract helper for freeing special structs
Date: Fri,  5 Sep 2025 17:45:01 +0100
Message-ID: <20250905164508.1489482-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Extract the cleanup of known embedded structs into the dedicated helper.
Remove duplication and introduce a single source of truth for freeing
special embedded structs in hashtab.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 71f9931ac64c..2319f8f8fa3e 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -215,6 +215,16 @@ static bool htab_has_extra_elems(struct bpf_htab *htab)
 	return !htab_is_percpu(htab) && !htab_is_lru(htab) && !is_fd_htab(htab);
 }
 
+static void htab_free_internal_structs(struct bpf_htab *htab, struct htab_elem *elem)
+{
+	if (btf_record_has_field(htab->map.record, BPF_TIMER))
+		bpf_obj_free_timer(htab->map.record,
+				   htab_elem_value(elem, htab->map.key_size));
+	if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
+		bpf_obj_free_workqueue(htab->map.record,
+				       htab_elem_value(elem, htab->map.key_size));
+}
+
 static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
 {
 	u32 num_entries = htab->map.max_entries;
@@ -227,12 +237,7 @@ static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
 		struct htab_elem *elem;
 
 		elem = get_htab_elem(htab, i);
-		if (btf_record_has_field(htab->map.record, BPF_TIMER))
-			bpf_obj_free_timer(htab->map.record,
-					   htab_elem_value(elem, htab->map.key_size));
-		if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
-			bpf_obj_free_workqueue(htab->map.record,
-					       htab_elem_value(elem, htab->map.key_size));
+		htab_free_internal_structs(htab, elem);
 		cond_resched();
 	}
 }
@@ -1502,12 +1507,7 @@ static void htab_free_malloced_timers_and_wq(struct bpf_htab *htab)
 
 		hlist_nulls_for_each_entry(l, n, head, hash_node) {
 			/* We only free timer on uref dropping to zero */
-			if (btf_record_has_field(htab->map.record, BPF_TIMER))
-				bpf_obj_free_timer(htab->map.record,
-						   htab_elem_value(l, htab->map.key_size));
-			if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
-				bpf_obj_free_workqueue(htab->map.record,
-						       htab_elem_value(l, htab->map.key_size));
+			htab_free_internal_structs(htab, l);
 		}
 		cond_resched_rcu();
 	}
-- 
2.51.0


