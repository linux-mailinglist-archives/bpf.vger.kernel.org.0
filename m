Return-Path: <bpf+bounces-74556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 46829C5F334
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C8C535EBDA
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 20:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C70A34B1AF;
	Fri, 14 Nov 2025 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKhy3BAm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5EB348445
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151214; cv=none; b=SLZdV+9Z+6rRbNJmPgEp8getC91AxgD3hSQnuf7o/ctIJ3iHFTs4pL5aUEd5smGTCaZVf5QqaCacxc6bYcF+pEd99SQK+FwAjmPVri1LYlP6pUGfJCjQqQHFm3iOiX/6MhYBeYL8OfY7zCOP9PSoL3z1bYo0j/tuK2FgI2oQHs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151214; c=relaxed/simple;
	bh=93105ecoRT5r5on2KqS0VsbTh5hx3bo1CP91kuviTXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhCbgklAgiAoY0sXEpZaYeY/9L7iu86XIVwWzkL1zxWJrNp74cpQ+0f4wDjOsq0QEDGgig5USZqhHEccnh8sqLWwB9mHGLXm8jtXt8IfbJY2SsGeCJjapA5rGR2ZZ2E+6wRZ1jm584fwMSSPt/uNuzVHFNQx+xojit3b2tn6SRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKhy3BAm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso2137026b3a.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 12:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763151212; x=1763756012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7Bt9m/p2AJWfBv3iIQBjeNxzWFIsQsFGSYYCtm67mA=;
        b=MKhy3BAmJcrngjE4AyS5bdcBfBoV/ZT4SpF6VUrLDlyXkVLTvPmLXqVEW5Ef0N0810
         D20OxN+aMCgG5yvoGnooG37Cezex1fgKb+t3sUVN79/gsHKy0ZM7wrGSsbc9Lde6SKRG
         ysDR230jBeJk5nhszCNk5oPnCMEhZ/cs26501ZmbKR0CrHNqlh7/Jh/GTcqrg5GF7/Gr
         J/ZQfhwZy5X1bfW1fx9uhpXKdcAzNJ/a/oZ/y105N9LtjNYClZP73RmXhPXIH8Eghhjd
         rn20ZOhCE3Mko16FwTFwAr67NGXHHdecWsJkSAzN+H5egX6MLE0aEhaKoAWuJqENcJ0Y
         h78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763151212; x=1763756012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s7Bt9m/p2AJWfBv3iIQBjeNxzWFIsQsFGSYYCtm67mA=;
        b=LWTspmeDq8ZtyX+rscvxx3tfWzfQHKsYVZ8Qo0T64fincatIRuk1DXW+HqZcy+zh9l
         rPuWFdK4+l8Rgh0Ty0TGAoqWIyQKOLZlxZhUcBGRacnYKFaHrLm8YogpmlipSmW54IiE
         qHyzcZsKHHOMGg3wMqjasaytezfe3Az5F9GAazRArh33Lxx3OPKYD0Si0gbkjBgzokZa
         AZbqG8hL4zCsKDNU6LEI9hdzaEzP/qHjEspFfRpS5nYHo/kgb8UphiQe36XO8jgwaNPK
         7lf2kl6+dM1m8Yt4qzrD/ZWqxppZ8c1pVZ3L6hyhcokvXRjjvQy/451ERQ+tiqjXbfTl
         R7GQ==
X-Gm-Message-State: AOJu0Yyo2Rk7QBmbwgzGjacpW+HVbToofoaRjqwSV7edmphDi8xXcVlN
	8Ben2pZiycV988+nXk3u3o92PCDqbLX8UV4spKUjzbccMOPY+r61Hk824ZVpEA==
X-Gm-Gg: ASbGncu839n+bv49d3grfCWRF/5DvQufhgLfK73Bsc/wVWMUlPz3nvIUzjZ/SzptGQu
	dnQ3k9mZrZTy++nWpHBjuRFHkrKo4OtmiCyir33hVMr9L3LDLEwxvbPuJ9xYDEAaKGp7r0KNCqE
	LuDYSlj2TCYluOkRw6dgX4rVbFUPlKDHJ1qeqFW5U5mKlneRX+8guY+tKa88qq/hUBNpNfOTsuk
	BErO9M++yqyrZJdyT1ryfP8SICUII4sUqzFUeCb0vPX2EKhWAEfb1TfkZDyNTnQDGrXtuEiqxkP
	DTM1e1TgPtCfI35MVNwckVwPi+hI335Gu0470jtokW3hsvY5X7K3J8/O6WB3gM9dTO2sNgf8zkD
	vixBu6JgLOGF60f9FsORe1RnAl5pIqiYN3R0Wm6Qk4SPSchImgyl9tDBc4XQPAv1DbXsMz4jItd
	InWcDUBSlzordt
X-Google-Smtp-Source: AGHT+IGfHgXm61hYdHTkloJP9EDQCcxFDGflpotWcq7LwMcu6jjpvDlesAn1RbhH90CuGtl/BpGsCw==
X-Received: by 2002:a05:6a20:2588:b0:34e:cc0a:40b2 with SMTP id adf61e73a8af0-35ba1c8a64dmr6034617637.30.1763151212243;
        Fri, 14 Nov 2025 12:13:32 -0800 (PST)
Received: from localhost ([2a03:2880:ff:f::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37507fc7bsm5560241a12.23.2025.11.14.12.13.31
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
Subject: [PATCH v2 bpf-next 2/4] bpf: Remove smap argument from bpf_selem_free()
Date: Fri, 14 Nov 2025 12:13:24 -0800
Message-ID: <20251114201329.3275875-3-ameryhung@gmail.com>
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

Since selem already saves a pointer to smap, use it instead of an
additional argument in bpf_selem_free(). This requires moving the
SDATA(selem)->smap assignment from bpf_selem_link_map() to
bpf_selem_alloc() since bpf_selem_free() may be called without the
selem being linked to smap in bpf_local_storage_update().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  1 -
 kernel/bpf/bpf_local_storage.c    | 19 ++++++++++---------
 net/core/bpf_sk_storage.c         |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 3663eabcc3ff..4ab137e75f33 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -187,7 +187,6 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
 		bool swap_uptrs, gfp_t gfp_flags);
 
 void bpf_selem_free(struct bpf_local_storage_elem *selem,
-		    struct bpf_local_storage_map *smap,
 		    bool reuse_now);
 
 int
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 400bdf8a3eb2..95a5ea618cc5 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -97,6 +97,8 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	}
 
 	if (selem) {
+		RCU_INIT_POINTER(SDATA(selem)->smap, smap);
+
 		if (value) {
 			/* No need to call check_and_init_map_value as memory is zero init */
 			copy_map_value(&smap->map, SDATA(selem)->data, value);
@@ -227,9 +229,12 @@ static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
 }
 
 void bpf_selem_free(struct bpf_local_storage_elem *selem,
-		    struct bpf_local_storage_map *smap,
 		    bool reuse_now)
 {
+	struct bpf_local_storage_map *smap;
+
+	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
+
 	if (!smap->bpf_ma) {
 		/* Only task storage has uptrs and task storage
 		 * has moved to bpf_mem_alloc. Meaning smap->bpf_ma == true
@@ -263,7 +268,6 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
 {
 	struct bpf_local_storage_elem *selem;
-	struct bpf_local_storage_map *smap;
 	struct hlist_node *n;
 
 	/* The "_safe" iteration is needed.
@@ -271,10 +275,8 @@ static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
 	 * but bpf_selem_free will use the selem->rcu_head
 	 * which is union-ized with the selem->free_node.
 	 */
-	hlist_for_each_entry_safe(selem, n, list, free_node) {
-		smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
-		bpf_selem_free(selem, smap, reuse_now);
-	}
+	hlist_for_each_entry_safe(selem, n, list, free_node)
+		bpf_selem_free(selem, reuse_now);
 }
 
 /* local_storage->lock must be held and selem->local_storage == local_storage.
@@ -432,7 +434,6 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&b->lock, flags);
-	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
 }
@@ -586,7 +587,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 		err = bpf_local_storage_alloc(owner, smap, selem, gfp_flags);
 		if (err) {
-			bpf_selem_free(selem, smap, true);
+			bpf_selem_free(selem, true);
 			mem_uncharge(smap, owner, smap->elem_size);
 			return ERR_PTR(err);
 		}
@@ -662,7 +663,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	bpf_selem_free_list(&old_selem_free_list, false);
 	if (alloc_selem) {
 		mem_uncharge(smap, owner, smap->elem_size);
-		bpf_selem_free(alloc_selem, smap, true);
+		bpf_selem_free(alloc_selem, true);
 	}
 	return err ? ERR_PTR(err) : SDATA(selem);
 }
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index bd3c686edc0b..850dd736ccd1 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -196,7 +196,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		} else {
 			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
 			if (ret) {
-				bpf_selem_free(copy_selem, smap, true);
+				bpf_selem_free(copy_selem, true);
 				atomic_sub(smap->elem_size,
 					   &newsk->sk_omem_alloc);
 				bpf_map_put(map);
-- 
2.47.3


